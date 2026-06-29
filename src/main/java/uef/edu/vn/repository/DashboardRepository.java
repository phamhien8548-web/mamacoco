package uef.edu.vn.repository;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import uef.edu.vn.model.DashboardStats;

@Repository
public class DashboardRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    // 1. Thống kê doanh thu và số lượng vé bán ra theo từng Sự kiện
    public List<DashboardStats> getRevenueStatsByEvent() {
        // Gom nhóm theo tên sự kiện, tính tổng số vé và tổng tiền thu được
        String sql = "SELECT eventName AS label, "
                   + "SUM(quantity) AS tickets_sold, "
                   + "SUM(totalPrice) AS revenue "
                   + "FROM Bookings "
                   + "WHERE status = 'CONFIRMED' OR status = 'ATTENDED' "
                   + "GROUP BY eventName "
                   + "ORDER BY revenue DESC";

        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            DashboardStats stats = new DashboardStats();
            stats.setLabel(rs.getString("label"));
            stats.setTicketsSold(rs.getInt("tickets_sold"));
            stats.setRevenue(rs.getDouble("revenue"));
            return stats;
        });
    }

    // 2. Thống kê trạng thái đặt vé và lượt tham dự (Attendance Statistics)
    public List<DashboardStats> getAttendanceStats() {
        // Gom nhóm theo trạng thái (PENDING, CONFIRMED, ATTENDED) để biết tỉ lệ đi tham gia sự kiện
        String sql = "SELECT status AS label, "
                   + "SUM(quantity) AS tickets_sold, "
                   + "0.0 AS revenue " // Biểu đồ này chỉ cần số lượng, gán tạm doanh thu bằng 0
                   + "FROM Bookings "
                   + "GROUP BY status";

        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            DashboardStats stats = new DashboardStats();
            stats.setLabel(rs.getString("label"));
            stats.setTicketsSold(rs.getInt("tickets_sold"));
            stats.setRevenue(rs.getDouble("revenue"));
            return stats;
        });
    }

    // 3. Lấy tổng quan các con số tổng hợp nhanh (Dùng cho các thẻ hiển thị nhanh trên Dashboard)
    public int getTotalTicketsSold() {
        String sql = "SELECT IFNULL(SUM(quantity), 0) FROM Bookings WHERE status != 'PENDING'";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }

    public double getTotalRevenue() {
        String sql = "SELECT IFNULL(SUM(totalPrice), 0) FROM Bookings WHERE status != 'PENDING'";
        return jdbcTemplate.queryForObject(sql, Double.class);
    }
}