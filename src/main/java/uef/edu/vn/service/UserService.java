package uef.edu.vn.service;

import java.util.List;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import uef.edu.vn.model.User;
import uef.edu.vn.repository.UserRepository;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    // ==========================================
    // PHÂN HỆ XÁC THỰC TÀI KHOẢN (AUTH FLOW)
    // ==========================================

    /**
     * Chức năng Đăng ký tài khoản mới (Basic 1)
     * Thao tác băm mật khẩu thô thành chuỗi bảo mật an toàn trước khi lưu xuống DB
     */
    @Transactional
    public boolean register(User user) {
        // 1. Kiểm tra xem tên tài khoản (username) đã bị trùng lặp trong hệ thống chưa
        User existingUser = userRepository.findByUsername(user.getUsername());
        if (existingUser != null) {
            return false; // Đăng ký thất bại do trùng Username
        }

        // 2. Tiến hành mã hóa mật khẩu một chiều bằng thuật toán BCrypt
        String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
        user.setPassword(hashedPassword);

        // 3. Thiết lập các giá trị mặc định nếu hệ thống chưa truyền vào
        if (user.getRole() == null || user.getRole().trim().isEmpty()) {
            user.setRole("USER"); // Khách hàng đăng ký online mặc định có quyền USER
        }
        if (user.getStatus() == null || user.getStatus().trim().isEmpty()) {
            user.setStatus("ACTIVE"); // Tài khoản mặc định ở trạng thái kích hoạt ngay
        }

        // 4. Gọi Repository để lưu xuống database doaneventbookingdb
        userRepository.save(user);
        return true; // Đăng ký thành công
    }

    /**
     * Chức năng Đăng nhập hệ thống (Basic 1)
     * Đối chiếu mật khẩu thô khách hàng gõ với chuỗi mã hóa trong Database
     */
    public User login(String username, String password) {
        // 1. Tìm tài khoản trong database bằng tên đăng nhập
        User user = userRepository.findByUsername(username);
        
        // 2. Nếu không tìm thấy tài khoản, trả về null ngay lập tức
        if (user == null) {
            return null;
        }

        // 3. Kiểm tra xem tài khoản có đang bị khóa (INACTIVE) hay không
        if ("INACTIVE".equalsIgnoreCase(user.getStatus())) {
            return null; 
        }

        // 4. Đối chiếu mật khẩu thô người dùng gõ với chuỗi mã hóa BCrypt lưu trong DB
        // Hàm BCrypt.checkpw() sẽ tự giải mã muối và so sánh an toàn
        if (BCrypt.checkpw(password, user.getPassword())) {
            return user; // Mật khẩu khớp, đăng nhập thành công và trả về thông tin đối tượng
        }

        return null; // Mật khẩu sai, đăng nhập thất bại
    }

    // ==========================================
    // PHÂN HỆ QUẢN LÝ THÀNH VIÊN (ADMIN FLOW)
    // ==========================================

    /**
     * Lấy toàn bộ danh sách khách hàng đăng ký (Basic 3)
     * Phục vụ cho giao diện quản lý bảng User của Admin
     */
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    /**
     * Tra cứu thông tin chi tiết của 1 tài khoản bằng ID
     * Phục vụ trang thông tin cá nhân (Profile) hoặc chỉnh sửa quyền
     */
    public User getUserById(int id) {
        return userRepository.findById(id);
    }

    /**
     * Cập nhật thông tin cá nhân hoặc thay đổi trạng thái tài khoản công khai
     */
    @Transactional
    public void updateUserProfile(User user) {
        userRepository.update(user);
    }
}