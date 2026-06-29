package uef.edu.vn.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;
import uef.edu.vn.model.Booking;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.List;

@Repository
public class BookingRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    // SỬA LẠI HÀM SAVE: Để lấy được ID tự động tăng từ MySQL gán ngược lại cho Java
    public void save(Booking booking) {
        String sql = "INSERT INTO Bookings (customerName, customerEmail, eventName, quantity, totalPrice, status) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        KeyHolder keyHolder = new GeneratedKeyHolder();

        jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, booking.getCustomerName());
            ps.setString(2, booking.getCustomerEmail());
            ps.setString(3, booking.getEventName());
            ps.setInt(4, booking.getQuantity());
            ps.setDouble(5, booking.getTotalPrice());
            ps.setString(6, booking.getStatus());
            return ps;
        }, keyHolder);

        // Đọc ID vừa sinh tự động từ DB và đặt ngược lại vào đối tượng Java
        if (keyHolder.getKey() != null) {
            booking.setBookingID(keyHolder.getKey().intValue());
        }
    }

    public List<Booking> findAll() {
        String sql = "SELECT * FROM Bookings";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Booking.class));
    }

    public Booking findById(int id) {
        String sql = "SELECT * FROM Bookings WHERE bookingID = ?";
        return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(Booking.class), id);
    }

    public void updateStatus(int id, String status) {
        String sql = "UPDATE Bookings SET status = ? WHERE bookingID = ?";
        jdbcTemplate.update(sql, status, id);
    }

    public List<Booking> findByCustomerEmail(String email) {
        String sql = "SELECT * FROM Bookings WHERE customerEmail = ?";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Booking.class), email);
    }
}
