package uef.edu.vn.model;

import jakarta.validation.constraints.*;

public class User {

    private int id;

    @NotBlank(message = "Username is required")
    @Size(max = 50, message = "Username cannot exceed 50 characters")
    private String username;

    @NotBlank(message = "Password is required")
    private String password; // Dùng để lưu chuỗi mật khẩu đã mã hóa BCrypt

    @NotBlank(message = "Full name is required")
    @Size(max = 100, message = "Full name cannot exceed 100 characters")
    private String fullname;

    @NotBlank(message = "Email is required")
    @Email(message = "Invalid email format")
    @Size(max = 100, message = "Email cannot exceed 100 characters")
    private String email;

    @Size(max = 20, message = "Phone number cannot exceed 20 characters")
    private String phone;

    private String role;   // 'USER' hoặc 'ADMIN'
    private String status; // 'ACTIVE' hoặc 'INACTIVE'

    // Hàm khởi tạo không tham số (Mặc định bắt buộc phải có cho các Framework)
    public User() {
    }

    // Hàm khởi tạo đầy đủ tham số phục vụ cho việc map dữ liệu từ Repository lên
    public User(int id, String username, String password, String fullname, String email, String phone, String role, String status) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.fullname = fullname;
        this.email = email;
        this.phone = phone;
        this.role = role;
        this.status = status;
    }

    // --- HỆ THỐNG GETTERS VÀ SETTERS (Viết tay chuẩn hóa theo mẫu Booking/Event) ---

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}