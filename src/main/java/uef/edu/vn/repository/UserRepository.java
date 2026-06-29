package uef.edu.vn.repository;

import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;
import uef.edu.vn.model.User;

@Repository
public class UserRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    // 1. Hàm ánh xạ dữ liệu từ Database thành Object Java (Học tập từ EventRepository)
    private User mapRow(java.sql.ResultSet rs) throws java.sql.SQLException {
        User u = new User();
        u.setId(rs.getInt("id"));
        u.setUsername(rs.getString("username"));
        u.setPassword(rs.getString("password"));
        u.setFullname(rs.getString("fullname"));
        u.setEmail(rs.getString("email"));
        u.setPhone(rs.getString("phone"));
        u.setRole(rs.getString("role"));
        u.setStatus(rs.getString("status"));
        return u;
    }

    // 2. Chức năng Đăng ký tài khoản (Học tập dùng KeyHolder từ BookingRepository)
    public void save(User user) {
        String sql = "INSERT INTO users (username, password, fullname, email, phone, role, status) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        KeyHolder keyHolder = new GeneratedKeyHolder();

        jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword()); // Lưu chuỗi mật khẩu đã mã hóa mã hóa BCrypt
            ps.setString(3, user.getFullname());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getPhone());
            ps.setString(6, user.getRole() != null ? user.getRole() : "USER");
            ps.setString(7, user.getStatus() != null ? user.getStatus() : "ACTIVE");
            return ps;
        }, keyHolder);

        // Đọc ID vừa sinh tự động từ DB gán ngược lại cho đối tượng Java
        if (keyHolder.getKey() != null) {
            user.setId(keyHolder.getKey().intValue());
        }
    }

    // 3. Tìm kiếm người dùng bằng Username (Phục vụ cốt lõi cho phân hệ Đăng nhập)
    public User findByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";
        try {
            return jdbcTemplate.queryForObject(sql, (rs, rowNum) -> mapRow(rs), username);
        } catch (EmptyResultDataAccessException e) {
            // Trả về null nếu không tìm thấy tài khoản, giúp Service xử lý báo lỗi thay vì sập app
            return null; 
        }
    }

    // 4. Tìm kiếm người dùng bằng ID (Phục vụ phân quyền hoặc xem trang cá nhân Profile)
    public User findById(int id) {
        String sql = "SELECT * FROM users WHERE id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, (rs, rowNum) -> mapRow(rs), id);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    // 5. Lấy danh sách toàn bộ tài khoản (Phục vụ tính năng Quản lý thông tin khách hàng - Basic 3)
    public List<User> findAll() {
        String sql = "SELECT * FROM users ORDER BY id DESC";
        return jdbcTemplate.query(sql, (rs, rowNum) -> mapRow(rs));
    }

    // 6. Cập nhật thông tin người dùng / Thay đổi trạng thái khóa tài khoản
    public void update(User user) {
        String sql = "UPDATE users SET fullname = ?, email = ?, phone = ?, role = ?, status = ? WHERE id = ?";
        jdbcTemplate.update(
            sql, 
            user.getFullname(), 
            user.getEmail(), 
            user.getPhone(), 
            user.getRole(), 
            user.getStatus(), 
            user.getId()
        );
    }
}