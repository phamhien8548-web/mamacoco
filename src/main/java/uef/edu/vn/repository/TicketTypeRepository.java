/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uef.edu.vn.repository;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import uef.edu.vn.model.TicketType;

@Repository
public class TicketTypeRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private TicketType mapRow(java.sql.ResultSet rs) throws java.sql.SQLException {
        TicketType t = new TicketType();

        t.setId(rs.getInt("ticket_type_id"));
        t.setEventId(rs.getInt("event_id"));
        t.setTicketName(rs.getString("ticket_name"));
        t.setPrice(rs.getBigDecimal("price"));
        t.setTotalQuantity(rs.getInt("total_quantity"));
        t.setSoldQuantity(rs.getInt("sold_quantity"));
        t.setStatus(rs.getString("status"));
        t.setEventName(rs.getString("event_name"));

        return t;
    }

    public List<TicketType> findAll() {
        String sql = ""
                + "SELECT "
                + "t.id AS ticket_type_id, "
                + "t.event_id AS event_id, "
                + "t.ticket_name AS ticket_name, "
                + "t.price AS price, "
                + "t.total_quantity AS total_quantity, "
                + "t.sold_quantity AS sold_quantity, "
                + "t.status AS status, "
                + "e.event_name AS event_name "
                + "FROM ticket_types t "
                + "JOIN events e ON t.event_id = e.id "
                + "ORDER BY t.id DESC";

        return jdbcTemplate.query(sql, (rs, rowNum) -> mapRow(rs));
    }

    public TicketType findById(int id) {
        String sql = ""
                + "SELECT "
                + "t.id AS ticket_type_id, "
                + "t.event_id AS event_id, "
                + "t.ticket_name AS ticket_name, "
                + "t.price AS price, "
                + "t.total_quantity AS total_quantity, "
                + "t.sold_quantity AS sold_quantity, "
                + "t.status AS status, "
                + "e.event_name AS event_name "
                + "FROM ticket_types t "
                + "JOIN events e ON t.event_id = e.id "
                + "WHERE t.id = ?";

        return jdbcTemplate.queryForObject(sql, (rs, rowNum) -> mapRow(rs), id);
    }

    // Hàm này rất quan trọng để lấy danh sách loại vé động
    public List<TicketType> findByEventId(int eventId) {
        String sql = "SELECT "
                + "t.id AS ticket_type_id, " // Đặt alias rõ ràng
                + "t.event_id, t.ticket_name, t.price, t.total_quantity, t.status, e.event_name "
                + "FROM ticket_types t "
                + "JOIN events e ON t.event_id = e.id "
                + "WHERE t.event_id = ?";

        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            TicketType t = new TicketType();
            t.setId(rs.getInt("ticket_type_id")); // Gọi đúng alias vừa đặt
            t.setEventId(rs.getInt("event_id"));
            t.setTicketName(rs.getString("ticket_name"));
            t.setPrice(rs.getBigDecimal("price"));
            t.setTotalQuantity(rs.getInt("total_quantity"));
            t.setStatus(rs.getString("status"));
            // Bạn có thể set thêm eventName nếu Model của bạn có hỗ trợ:
            t.setEventName(rs.getString("event_name"));
            return t;
        }, eventId);
    }

    public void save(TicketType ticketType) {
        String sql = ""
                + "INSERT INTO ticket_types "
                + "(event_id, ticket_name, price, total_quantity, sold_quantity, status) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        jdbcTemplate.update(
                sql,
                ticketType.getEventId(),
                ticketType.getTicketName(),
                ticketType.getPrice(),
                ticketType.getTotalQuantity(),
                ticketType.getSoldQuantity(),
                ticketType.getStatus()
        );
    }

    public void update(TicketType ticketType) {
        String sql = ""
                + "UPDATE ticket_types SET "
                + "event_id = ?, "
                + "ticket_name = ?, "
                + "price = ?, "
                + "total_quantity = ?, "
                + "sold_quantity = ?, "
                + "status = ? "
                + "WHERE id = ?";

        jdbcTemplate.update(
                sql,
                ticketType.getEventId(),
                ticketType.getTicketName(),
                ticketType.getPrice(),
                ticketType.getTotalQuantity(),
                ticketType.getSoldQuantity(),
                ticketType.getStatus(),
                ticketType.getId()
        );
    }

    public void delete(int id) {
        String sql = "DELETE FROM ticket_types WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }

    // Thêm vào TicketTypeRepository.java
    public Double getPriceByEventName(String eventName) {
        String sql = "SELECT t.price FROM ticket_types t "
                + "JOIN events e ON t.event_id = e.id "
                + "WHERE e.event_name = ? LIMIT 1";
        try {
            return jdbcTemplate.queryForObject(sql, Double.class, eventName);
        } catch (Exception e) {
            // Trả về null nếu không tìm thấy giá hoặc sự kiện không tồn tại
            return null;
        }
    }
}
