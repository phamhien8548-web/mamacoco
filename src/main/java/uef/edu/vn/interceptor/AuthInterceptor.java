package uef.edu.vn.interceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.servlet.HandlerInterceptor;
import uef.edu.vn.model.User;

public class AuthInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        String uri = request.getRequestURI();
        String contextPath = request.getContextPath();
        String path = uri.substring(contextPath.length());

        // Các trang công khai và tài nguyên tĩnh không cần kiểm tra phiên đăng nhập.
        if (path.startsWith("/login")
                || path.startsWith("/register")
                || path.startsWith("/logout")
                || path.startsWith("/auth")
                || path.startsWith("/assets")
                || path.startsWith("/resources")) {
            return true;
        }

        // 1. Lấy phiên làm việc hiện tại từ Request
        HttpSession session = request.getSession();

        // 2. Trích xuất thông tin người dùng đăng nhập (được lưu từ AuthController)
        User currentUser = (User) session.getAttribute("currentUser");

        // 3. THÀNH PHẦN CHẶN 1: Người dùng chưa đăng nhập (Vãng lai)
        if (currentUser == null) {
            // Điều hướng an toàn về trang đăng nhập kèm tham số báo lỗi để giao diện hiển thị thông báo
            response.sendRedirect(request.getContextPath() + "/login?error=unauthenticated");
            return false; // Chặn đứng yêu cầu, không cho vào Controller
        }

        // 4. Chặn người dùng thường truy cập phân hệ quản trị.
        if (path.startsWith("/admin") && !"ADMIN".equalsIgnoreCase(currentUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login?error=unauthorized");
            return false;
        }

        // 5. Hợp lệ: đã đăng nhập, và nếu là route admin thì có đúng quyền ADMIN.
        return true;
    }
}
