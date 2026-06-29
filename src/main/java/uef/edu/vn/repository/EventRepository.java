package uef.edu.vn.repository;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import uef.edu.vn.model.Event;

@Repository
public class EventRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private Event mapRow(java.sql.ResultSet rs) throws java.sql.SQLException {
        Event e = new Event();
        e.setId(rs.getInt("event_id"));
        e.setCategoryId(rs.getInt("category_id"));
        e.setVenueId(rs.getInt("venue_id"));
        e.setEventName(rs.getString("event_name"));
        e.setShortDescription(rs.getString("short_description"));
        e.setDescription(rs.getString("description"));
        e.setBannerImage(rs.getString("banner_image"));
        e.setStatus(rs.getString("status"));
        e.setCreatedBy(rs.getInt("created_by"));
        e.setCategoryName(rs.getString("category_name"));
        e.setVenueName(rs.getString("venue_name"));
        return e;
    }

    public List<Event> findAll() {
        String sql = "SELECT e.*, c.category_name, v.venue_name "
                + "FROM events e "
                + "JOIN event_categories c ON e.category_id = c.id "
                + "JOIN venues v ON e.venue_id = v.id "
                + "ORDER BY e.id DESC";
        return jdbcTemplate.query(sql, (rs, rowNum) -> mapRow(rs));
    }

    public Event findById(int id) {
        String sql = ""
                + "SELECT "
                + "e.id AS event_id, "
                + "e.category_id AS category_id, "
                + "e.venue_id AS venue_id, "
                + "e.event_name AS event_name, "
                + "e.short_description AS short_description, "
                + "e.description AS description, "
                + "e.banner_image AS banner_image, "
                + "e.status AS status, "
                + "e.created_by AS created_by, "
                + "c.category_name AS category_name, "
                + "v.venue_name AS venue_name "
                + "FROM events e "
                + "JOIN event_categories c ON e.category_id = c.id "
                + "JOIN venues v ON e.venue_id = v.id "
                + "WHERE e.id = ?";

        return jdbcTemplate.queryForObject(sql, (rs, rowNum) -> mapRow(rs), id);
    }

    public List<Event> searchEvents(String keyword, Integer categoryId, String date) {
        String sql = ""
                + "SELECT "
                + "e.id AS event_id, "
                + "e.category_id AS category_id, "
                + "e.venue_id AS venue_id, "
                + "e.event_name AS event_name, "
                + "e.short_description AS short_description, "
                + "e.description AS description, "
                + "e.banner_image AS banner_image, "
                + "e.status AS status, "
                + "e.created_by AS created_by, "
                + "c.category_name AS category_name, "
                + "v.venue_name AS venue_name "
                + "FROM events e "
                + "JOIN event_categories c ON e.category_id = c.id "
                + "JOIN venues v ON e.venue_id = v.id "
                + "WHERE 1 = 1 ";

        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += "AND (e.event_name LIKE ? OR e.short_description LIKE ? OR e.description LIKE ?) ";
            String kw = "%" + keyword.trim() + "%";
            params.add(kw);
            params.add(kw);
            params.add(kw);
        }

        if (categoryId != null && categoryId > 0) {
            sql += "AND e.category_id = ? ";
            params.add(categoryId);
        }

        if (date != null && !date.trim().isEmpty()) {
            sql += "AND EXISTS ( "
                    + "SELECT 1 FROM event_schedules s "
                    + "WHERE s.event_id = e.id "
                    + "AND DATE(s.start_time) = ? "
                    + ") ";
            params.add(date);
        }

        sql += "ORDER BY e.id DESC";

        return jdbcTemplate.query(sql, (rs, rowNum) -> mapRow(rs), params.toArray());
    }

    // Nằm trong EventRepository.java
    public void save(Event event) {
        String sql = "INSERT INTO events (category_id, venue_id, event_name, short_description, description, banner_image, status, created_by) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        jdbcTemplate.update(sql,
                event.getCategoryId(),
                event.getVenueId(),
                event.getEventName(),
                event.getShortDescription(),
                event.getDescription(),
                event.getBannerImage(),
                event.getStatus(),
                event.getCreatedBy() // ĐÃ SỬA: Thay số 1 bằng dữ liệu động từ Model truyền xuống
        );
    }

    public void update(Event event) {
        String sql = ""
                + "UPDATE events SET "
                + "category_id = ?, "
                + "venue_id = ?, "
                + "event_name = ?, "
                + "short_description = ?, "
                + "description = ?, "
                + "banner_image = ?, "
                + "status = ? "
                + "WHERE id = ?";

        jdbcTemplate.update(
                sql,
                event.getCategoryId(),
                event.getVenueId(),
                event.getEventName(),
                event.getShortDescription(),
                event.getDescription(),
                event.getBannerImage(),
                event.getStatus(),
                event.getId()
        );
    }

    public void delete(int id) {
        jdbcTemplate.update("DELETE FROM event_images WHERE event_id = ?", id);
        jdbcTemplate.update("DELETE FROM ticket_types WHERE event_id = ?", id);
        jdbcTemplate.update("DELETE FROM event_schedules WHERE event_id = ?", id);
        jdbcTemplate.update("DELETE FROM events WHERE id = ?", id);
    }
}
