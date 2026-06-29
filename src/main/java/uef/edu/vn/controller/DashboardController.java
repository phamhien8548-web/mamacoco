package uef.edu.vn.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import uef.edu.vn.repository.DashboardRepository;

@Controller
@RequestMapping("/admin")
public class DashboardController {

    @Autowired
    private DashboardRepository dashboardRepository;

    // Đường dẫn phân hệ Admin đã quy hoạch ở Giai đoạn 3
    private final String viewPath = "/WEB-INF/views/admin/";

    /**
     * Hiển thị trang trung tâm điều khiển (Admin Dashboard)
     * Kích hoạt tính năng tính toán doanh thu và lượt tham gia (Advanced 5)
     */
    @GetMapping("/dashboard")
    public String showDashboard(Model model) {
        
        // 1. Thu thập các con số tổng hợp nhanh để hiển thị lên các thẻ Card (Tổng doanh thu, tổng số vé)
        int totalTickets = dashboardRepository.getTotalTicketsSold();
        double totalRevenue = dashboardRepository.getTotalRevenue();
        
        model.addAttribute("totalTickets", totalTickets);
        model.addAttribute("totalRevenue", totalRevenue);

        // 2. Thu thập danh sách dữ liệu phân cấp phục vụ vẽ đồ thị Chart.js ở Frontend
        // Dữ liệu bao gồm: nhãn sự kiện (label), số vé (ticketsSold), doanh thu (revenue)
        model.addAttribute("revenueStats", dashboardRepository.getRevenueStatsByEvent());
        model.addAttribute("attendanceStats", dashboardRepository.getAttendanceStats());

        // 3. Thiết lập đường dẫn trang con và lồng vào bộ khung layout/main đồng bộ của đồ án
        model.addAttribute("body", viewPath + "dashboard.jsp");
        return "layout/main";
    }
}