package uef.edu.vn.controller;

import jakarta.servlet.http.HttpSession; // MỚI THÊM: Quản lý phiên đăng nhập
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import uef.edu.vn.model.Booking;
import uef.edu.vn.model.Event;
import uef.edu.vn.model.User;
import uef.edu.vn.service.TicketService;
import uef.edu.vn.service.EventService;
import java.util.List;
import uef.edu.vn.model.TicketType;

@Controller
@RequestMapping("/user/tickets")
public class TicketUserController {

    @Autowired
    private TicketService ticketService;

    @Autowired
    private EventService eventService;

    private final String path = "/WEB-INF/views/customer/";

    // 1. Hiển thị Form đặt vé thường (ĐÃ KHẮC PHỤC LỖI 2 - AUTO-FILL)
    // 1. Hiển thị Form đặt vé (ĐÃ CẬP NHẬT: TỰ ĐỘNG KHÓA SỰ KIỆN TỪ TRANG CHI TIẾT)
    // 1. Hiển thị Form đặt vé thường (ĐÃ CẬP NHẬT AUTO-FILL & AUTO-MAP EVENT)
    @GetMapping("/book")
    public String showBookForm(
            @RequestParam(value = "eventId") int eventId, // Thay đổi: Lấy ID sự kiện
            Model model,
            HttpSession session) {

        // 1. Lấy thông tin sự kiện để hiển thị tiêu đề
        Event event = eventService.findById(eventId);

        // 2. Lấy danh sách các loại vé CỦA SỰ KIỆN ĐÓ
        List<TicketType> ticketTypes = ticketService.getTicketTypesByEventId(eventId);

        Booking booking = new Booking();
        // Gán ID sự kiện để lúc lưu vào DB, bạn biết đơn này thuộc sự kiện nào
        booking.setEventId(eventId);

        // Logic cũ: Tự động điền thông tin user
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser != null) {
            booking.setCustomerName(currentUser.getFullname());
            booking.setCustomerEmail(currentUser.getEmail());
        }

        model.addAttribute("event", event);
        model.addAttribute("ticketTypes", ticketTypes); // Truyền list loại vé qua View
        model.addAttribute("booking", booking);
        model.addAttribute("body", path + "booking-form.jsp");

        return "layout/main";
    }

    // 2. Xử lý bấm Đặt vé (ĐÃ BỔ SUNG BẮT LỖI OVERBOOKING TỪ BƯỚC TRƯỚC)
    @PostMapping("/book")
    public String processBooking(@ModelAttribute("booking") Booking booking, Model model) {
        try {
            // === BỔ SUNG: Lấy tên sự kiện dựa vào eventId truyền lên từ form ẩn ===
            Event currentEvent = eventService.findById(booking.getEventId());
            if (currentEvent != null) {
                booking.setEventName(currentEvent.getEventName()); // Điền tên sự kiện vào Java object
            }
            // ======================================================================

            ticketService.saveBooking(booking);
            return "redirect:/user/tickets/payment?bookingId=" + booking.getBookingID();

        } catch (RuntimeException e) {
            model.addAttribute("errorMessage", e.getMessage());

            // FIX: Nạp lại dữ liệu cho ĐÚNG sự kiện đó thay vì nạp toàn bộ danh sách
            Event event = eventService.findById(booking.getEventId());
            model.addAttribute("event", event);
            model.addAttribute("ticketTypes", ticketService.getTicketTypesByEventId(booking.getEventId()));

            model.addAttribute("body", path + "booking-form.jsp");
            return "layout/main";
        }
    }

    // 3. Hiển thị giao diện Cổng thanh toán giả lập (Mock Payment Gateway)
    @GetMapping("/payment")
    public String showMockPaymentGateway(@RequestParam("bookingId") int bookingId, Model model) {
        // Lấy thông tin đơn hàng ra để hiển thị số tiền người dùng cần quét/trả
        model.addAttribute("bookingId", bookingId);
        model.addAttribute("body", path + "payment-gateway.jsp");
        return "layout/main";
    }

    // 4. Xử lý bấm nút "XÁC NHẬN THANH TOÁN" tại cổng giả lập
    @PostMapping("/payment/execute")
    public String executeFakePayment(@RequestParam("bookingId") int bookingId,
            @RequestParam("cardNumber") String cardNumber,
            @RequestParam("cardHolder") String cardHolder,
            @RequestParam("cvv") String cvv,
            Model model) {

        // GIẢ LẬP CHECK VALIDATION: Kiểm tra xem người dùng có nhập đầy đủ thông tin thẻ không
        if (cardNumber.isEmpty() || cardHolder.isEmpty() || cvv.isEmpty()) {
            return "redirect:/user/tickets/payment?bookingId=" + bookingId + "&error=invalid_info";
        }

        // LUỒNG TỰ ĐỘNG CHẠY THẬT:
        // Gọi hàm approvePayment trong TicketService để:
        // - Chuyển trạng thái vé thành CONFIRMED
        // - Tự động sinh mã hóa đơn ngắn UUID và lưu bảng Invoices
        // - Tự động trừ kho vé và kích hoạt luồng bắn Email thật về hòm thư người mua!
        ticketService.approvePayment(bookingId);

        // Lấy email của đơn hàng để truyền qua trang lịch sử xem thành quả
        return "redirect:/user/tickets/my-bookings?success=true";
    }

    // 5. Xem lịch sử vé cá nhân của User (ĐÃ VÁ LỖI BẢO MẬT RÒ RỈ DỮ LIỆU)
    @GetMapping("/my-bookings")
    public String myBookings(HttpSession session, Model model) {

        // 1. Kiểm tra đăng nhập (Bởi vì AuthInterceptor của chúng ta hiện chỉ chặn link /admin)
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            // Khách vãng lai cố tình mò vào link sẽ bị đá văng ra trang Login
            return "redirect:/login?error=unauthenticated";
        }

        // 2. Bảo mật tuyệt đối: Ép buộc hệ thống chỉ lấy email của chính tài khoản đang đăng nhập
        String userEmail = currentUser.getEmail();

        // Truy vấn database và đẩy dữ liệu ra View
        model.addAttribute("myBookings", ticketService.getBookingsByEmail(userEmail));
        model.addAttribute("body", path + "my-bookings.jsp");

        return "layout/main";
    }
}
