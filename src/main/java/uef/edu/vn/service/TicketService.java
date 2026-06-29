package uef.edu.vn.service;

import uef.edu.vn.model.Booking;
import uef.edu.vn.model.Invoice;
import uef.edu.vn.repository.BookingRepository;
import uef.edu.vn.repository.InvoiceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import org.springframework.jdbc.core.JdbcTemplate;
import uef.edu.vn.model.TicketType;
import uef.edu.vn.repository.TicketTypeRepository;

@Service
public class TicketService {

    @Autowired
    private BookingRepository bookingRepository;

    @Autowired
    private InvoiceRepository invoiceRepository;

    @Autowired
    private TicketTypeRepository ticketTypeRepository;

    @Autowired(required = false) // Không gây lỗi biên dịch nếu đồ án chưa cài thư viện/cấu hình Mail
    private JavaMailSender mailSender;

    // 🔥 THÊM DÒNG NÀY VÀO: Để Service có thể dùng chung cấu hình Database của Spring
    @Autowired
    private JdbcTemplate jdbcTemplate;

    // =========================================================================
    // TRUNG TÂM QUẢN LÝ SỰ KIỆN LOCAL (Không cần tạo bảng hay Model Event riêng)
    // =========================================================================
    // Hàm trả về danh sách tên các sự kiện để nạp vào thẻ <select> dropdown ở giao diện đặt vé của User
    public List<String> getAvailableEventNames() {
        try {
            String sql = "SELECT eventName FROM Events";
            return jdbcTemplate.queryForList(sql, String.class);
        } catch (Exception e) {
            // Ghi log lỗi ra console để dev biết đường sửa
            System.err.println("Lỗi truy vấn danh sách sự kiện: " + e.getMessage());

            // Trả về danh sách trống, sạch sẽ và chuyên nghiệp
            return new ArrayList<>();
        }
    }

    /**
     * Lấy danh sách loại vé dựa trên ID sự kiện. Cách này giúp giao diện tự
     * hiển thị (động) các loại vé (VIP, Standard) thay vì chỉ lấy 1 giá cố
     * định.
     *
     * @param eventId
     * @return
     */
    public List<TicketType> getTicketTypesForEvent(int eventId) {
        List<TicketType> types = ticketTypeRepository.findByEventId(eventId);
        if (types == null || types.isEmpty()) {
            throw new IllegalArgumentException("Sự kiện này chưa có loại vé nào được cấu hình!");
        }
        return types;
    }

    public List<TicketType> getTicketTypesByEventId(int eventId) {
        return this.getTicketTypesForEvent(eventId);
    }

    // ==========================================
    // PHÂN HỆ NGƯỜI DÙNG (USER FLOW)
    // ==========================================
    // User thực hiện tạo đơn đặt vé trực tuyến
    @Transactional
    public void saveBooking(Booking booking) {
        // 1. Dùng repository tìm thông tin loại vé bằng ID (An toàn nhất)
        TicketType type = ticketTypeRepository.findById(booking.getTicketTypeId()); // Giả sử bạn có trường ticketTypeId trong model Booking

        if (type == null) {
            throw new IllegalArgumentException("Loại vé không tồn tại!");
        }

        // 2. Tính tổng tiền dựa trên giá của loại vé đó
        booking.setTotalPrice(booking.getQuantity() * type.getPrice().doubleValue());
        booking.setStatus("PENDING");

        bookingRepository.save(booking);
    }

    // User nhập email để tra cứu lại lịch sử các vé mình từng đặt
    public List<Booking> getBookingsByEmail(String email) {
        return bookingRepository.findByCustomerEmail(email);
    }

    // ==========================================
    // PHÂN HỆ QUẢN TRỊ VIÊN (ADMIN FLOW)
    // ==========================================
    // Admin xem toàn bộ danh sách đặt vé để thực hiện kiểm duyệt
    public List<Booking> getAllBookings() {
        return bookingRepository.findAll();
    }

    // Kế toán / Admin xem danh sách tất cả hóa đơn tài chính đã được xuất
    public List<Invoice> getAllInvoices() {
        return invoiceRepository.findAll();
    }

    // THAO TÁC 1: Admin bấm nút "Duyệt Thanh Toán"
    @Transactional
    public void approvePayment(int bookingId) {
        // 1. Cập nhật trạng thái của Booking từ PENDING -> CONFIRMED (Đã xác nhận vé)
        bookingRepository.updateStatus(bookingId, "CONFIRMED");

        // Lấy thông tin chi tiết của vé vừa được duyệt để lấy số tiền xuất hóa đơn
        Booking booking = bookingRepository.findById(bookingId);

        // 2. Tự động sinh mã hóa đơn duy nhất không trùng lặp (Ví dụ: INV-A1B2C3D4)
        String invoiceNum = "INV-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();

        // 3. Khởi tạo một đối tượng Invoice mới khớp chính xác cấu trúc Model của bạn
        Invoice invoice = new Invoice();
        invoice.setBookingID(bookingId);
        invoice.setInvoiceNumber(invoiceNum);
        invoice.setAmount(booking.getTotalPrice());
        invoice.setPaymentStatus("PAID"); // Đã thanh toán thành công

        // Lưu hóa đơn xuống database để ghi nhận doanh thu
        invoiceRepository.save(invoice);

        // 4. [Nâng cao] Gửi email tự động thông báo Vé điện tử kèm Mã hóa đơn cho khách hàng
        sendETicketEmail(booking, invoiceNum);
    }

    // THAO TÁC 2: Nhân viên bấm nút "Điểm danh (Check-in)" tại sảnh sự kiện
    public void checkInAttendance(int bookingId) {
        // Cập nhật trạng thái của Booking từ CONFIRMED -> ATTENDED (Đã đến tham gia)
        bookingRepository.updateStatus(bookingId, "ATTENDED");
    }

    // ==========================================
    // THƯ VIỆN GỬI MAIL THÔNG BÁO TỰ ĐỘNG
    // ==========================================
    private void sendETicketEmail(Booking booking, String invoiceNum) {
        if (mailSender == null) {
            // Nếu đồ án chạy local chưa cài đặt giao thức SMTP Mail, in ra Console để chứng minh luồng logic chạy đúng
            System.out.println(">>> [MOCK EMAIL] Đã kích hoạt luồng gửi E-Ticket thành công!");
            System.out.println(">>> Gửi tới: " + booking.getCustomerEmail());
            System.out.println(">>> Nội dung: Mã hóa đơn " + invoiceNum + " cho sự kiện [" + booking.getEventName() + "] đã hoàn tất duyệt.");
            return;
        }
        try {
            SimpleMailMessage msg = new SimpleMailMessage();
            msg.setFrom("hienpnhm24@uef.edu.vn");
            msg.setTo(booking.getCustomerEmail());
            msg.setSubject("[UEF] Xác nhận thanh toán vé Sự kiện thành công");
            msg.setText("Xin chào " + booking.getCustomerName() + ",\n\n"
                    + "Yêu cầu đặt vé trực tuyến của bạn đã được Admin phê duyệt hệ thống.\n"
                    + "Tên sự kiện: " + booking.getEventName() + "\n"
                    + "Số lượng: " + booking.getQuantity() + " vé\n"
                    + "Tổng tiền: " + booking.getTotalPrice() + " VND\n"
                    + "Mã Vé Điện Tử (Mã Hóa Đơn): " + invoiceNum + "\n\n"
                    + "Vui lòng chụp lại màn hình email này để nhân viên thực hiện quét điểm danh khi vào cửa. Chúc bạn có trải nghiệm tuyệt vời!");
            mailSender.send(msg);
        } catch (Exception e) {
            System.err.println("Lỗi gửi mail: " + e.getMessage());
        }
    }
}
