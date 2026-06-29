package uef.edu.vn.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import uef.edu.vn.service.TicketService;

@Controller
@RequestMapping("/admin/tickets")
public class TicketAdminController {

    @Autowired
    private TicketService ticketService;
    
    private final String path = "/WEB-INF/views/admin/";

    // 1. Quản lý toàn bộ danh sách đặt vé của hệ thống
    @GetMapping("/bookings")
    public String manageBookings(Model model) {
        model.addAttribute("allBookings", ticketService.getAllBookings());
        model.addAttribute("body", path + "booking-list.jsp"); 
        return "layout/main";
    }

    // 2. Nút bấm admin duyệt tiền (Gọi hàm nghiệp vụ cao cấp của Service)
    @GetMapping("/approve/{id}")
    public String approvePayment(@PathVariable("id") int bookingId) {
        // ĐÃ SỬA: Gọi đúng hàm approvePayment để vừa đổi trạng thái CONFIRMED, vừa tự tạo hóa đơn và gửi Mail
        ticketService.approvePayment(bookingId);
        return "redirect:/admin/tickets/bookings";
    }

    // 3. Nút bấm admin điểm danh tại cửa
    @GetMapping("/checkin/{id}")
    public String checkIn(@PathVariable("id") int bookingId) {
        // ĐÃ SỬA: Gọi đúng hàm checkInAttendance để chuyển trạng thái sang ATTENDED
        ticketService.checkInAttendance(bookingId);
        return "redirect:/admin/tickets/bookings";
    }

    // 4. Xem danh sách hóa đơn tài chính (Ghi nhận từ doanh thu thực tế)
    @GetMapping("/invoices")
    public String manageInvoices(Model model) {
        model.addAttribute("allInvoices", ticketService.getAllInvoices());
        model.addAttribute("body", path + "invoice-list.jsp");
        return "layout/main";
    }
}