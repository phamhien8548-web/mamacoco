package uef.edu.vn.controller;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import uef.edu.vn.model.User;
import uef.edu.vn.service.UserService;

@Controller
public class AuthController {

    @Autowired
    private UserService userService;

    // Đường dẫn gốc chứa giao diện phân hệ khách hàng (Đã quy hoạch ở Giai đoạn 3)
    private final String viewPath = "/WEB-INF/views/customer/";

    // ==========================================
    // 1. CHỨC NĂNG ĐĂNG NHẬP (LOGIN FLOW)
    // ==========================================

    /**
     * Hiển thị Form đăng nhập
     */
    @GetMapping("/login")
    public String showLoginForm(@RequestParam(value = "error", required = false) String error, 
                                @RequestParam(value = "success", required = false) String success, 
                                Model model) {
        // Bẫy thông báo từ Interceptor hoặc luồng đăng ký chuyển qua
        if ("unauthenticated".equals(error)) {
            model.addAttribute("errorMessage", "Vui lòng đăng nhập hệ thống để tiếp tục.");
        } else if ("unauthorized".equals(error)) {
            model.addAttribute("errorMessage", "Tài khoản của bạn không có quyền truy cập phân hệ Quản trị.");
        } else if ("failed".equals(error)) {
            model.addAttribute("errorMessage", "Tên đăng nhập hoặc mật khẩu không chính xác.");
        } else if ("registered".equals(success)) {
            model.addAttribute("successMessage", "Đăng ký thành công! Vui lòng đăng nhập.");
        }

        // Đóng gói giao diện form login vào bộ khung layout/main giống TicketUserController
        model.addAttribute("body", viewPath + "login.jsp");
        return "layout/main";
    }

    /**
     * Xử lý gửi dữ liệu Form đăng nhập
     */
    @PostMapping("/login")
    public String processLogin(@RequestParam("username") String username,
                               @RequestParam("password") String password,
                               HttpSession session) {
        
        // Gọi nghiệp vụ kiểm tra tài khoản và đối chiếu mật khẩu băm BCrypt
        User user = userService.login(username, password);

        if (user != null) {
            // Đăng nhập thành công -> Lưu dữ liệu vào Session để Interceptor kiểm duyệt
            session.setAttribute("currentUser", user);
            
            // Phân quyền điều hướng (Role-based Authorization)
            if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                return "redirect:/admin/tickets/bookings"; // Nếu là Admin đưa vào trang quản lý vé
            } else {
                return "redirect:/events"; // Nếu là Khách hàng đưa về trang danh sách sự kiện
            }
        }

        // Đăng nhập thất bại -> Đẩy ngược lại trang login kèm tham số lỗi
        return "redirect:/login?error=failed";
    }

    // ==========================================
    // 2. CHỨC NĂNG ĐĂNG KÝ (REGISTRATION FLOW)
    // ==========================================

    /**
     * Hiển thị Form đăng ký tài khoản khách hàng vãng lai
     */
    @GetMapping("/register")
    public String showRegisterForm(Model model) {
        // Truyền một đối tượng User rỗng ra để Form mapping dữ liệu qua thẻ <form:form>
        model.addAttribute("user", new User());
        model.addAttribute("body", viewPath + "register.jsp");
        return "layout/main";
    }

    /**
     * Xử lý gửi dữ liệu Form đăng ký
     */
    @PostMapping("/register")
    public String processRegister(@Valid @ModelAttribute("user") User user,
                                  BindingResult result,
                                  Model model) {
        
        // 1. Kiểm tra các lỗi vi phạm điều kiện trống (@NotBlank) trong Model User.java
        if (result.hasErrors()) {
            model.addAttribute("body", viewPath + "register.jsp");
            return "layout/main"; // Trả về trang đăng ký để hiện câu thông báo lỗi đỏ
        }

        // 2. Gọi tầng Service để băm mật khẩu và lưu xuống database doaneventbookingdb
        boolean isSuccess = userService.register(user);

        if (!isSuccess) {
            // Nếu hàm trả về false tức là bị trùng tên đăng nhập trong DB
            model.addAttribute("errorMessage", "Tên đăng nhập này đã tồn tại trên hệ thống!");
            model.addAttribute("body", viewPath + "register.jsp");
            return "layout/main";
        }

        // Đăng ký hoàn toàn hợp lệ -> Điều hướng sang trang Login kèm cờ báo thành công
        return "redirect:/login?success=registered";
    }

    // ==========================================
    // 3. CHỨC NĂNG ĐĂNG XUẤT (LOGOUT FLOW)
    // ==========================================

    /**
     * Xử lý Đăng xuất hệ thống
     */
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        // Hủy hoàn toàn phiên làm việc hiện tại, xóa sạch "currentUser" trong bộ nhớ RAM
        session.invalidate();
        return "redirect:/login";
    }
    
    @GetMapping("/profile")
    public String showProfile(HttpSession session, Model model) {
        if (session.getAttribute("currentUser") == null) {
            return "redirect:/login?error=unauthenticated";
        }

        // Nạp giao diện profile vào layout chung
        model.addAttribute("body", viewPath + "profile.jsp");
        return "layout/main";
    }
}
