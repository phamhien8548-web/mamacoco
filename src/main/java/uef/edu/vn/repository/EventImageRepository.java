/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uef.edu.vn.repository;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import uef.edu.vn.model.EventImage;

@Repository
public class EventImageRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private EventImage mapRow(java.sql.ResultSet rs) throws java.sql.SQLException {
        EventImage img = new EventImage();

        img.setId(rs.getInt("image_id"));
        img.setEventId(rs.getInt("event_id"));
        img.setImageUrl(rs.getString("image_url"));
        img.setBanner(rs.getBoolean("is_banner"));
        img.setEventName(rs.getString("event_name"));

        return img;
    }

    public List<EventImage> findAll() {
        String sql = ""
                + "SELECT "
                + "i.id AS image_id, "
                + "i.event_id AS event_id, "
                + "i.image_url AS image_url, "
                + "i.is_banner AS is_banner, "
                + "e.event_name AS event_name "
                + "FROM event_images i "
                + "JOIN events e ON i.event_id = e.id "
                + "ORDER BY i.id DESC";

        return jdbcTemplate.query(sql, (rs, rowNum) -> mapRow(rs));
    }

    public EventImage findById(int id) {
        String sql = ""
                + "SELECT "
                + "i.id AS image_id, "
                + "i.event_id AS event_id, "
                + "i.image_url AS image_url, "
                + "i.is_banner AS is_banner, "
                + "e.event_name AS event_name "
                + "FROM event_images i "
                + "JOIN events e ON i.event_id = e.id "
                + "WHERE i.id = ?";

        return jdbcTemplate.queryForObject(sql, (rs, rowNum) -> mapRow(rs), id);
    }

    public List<EventImage> findByEventId(int eventId) {
        String sql = ""
                + "SELECT "
                + "i.id AS image_id, "
                + "i.event_id AS event_id, "
                + "i.image_url AS image_url, "
                + "i.is_banner AS is_banner, "
                + "e.event_name AS event_name "
                + "FROM event_images i "
                + "JOIN events e ON i.event_id = e.id "
                + "WHERE i.event_id = ? "
                + "ORDER BY i.id DESC";

        return jdbcTemplate.query(sql, (rs, rowNum) -> mapRow(rs), eventId);
    }

    public void save(EventImage image) {
        if (image.isBanner()) {
            jdbcTemplate.update(
                    "UPDATE event_images SET is_banner = FALSE WHERE event_id = ?",
                    image.getEventId()
            );
        }

        String sql = "INSERT INTO event_images(event_id, image_url, is_banner) VALUES (?, ?, ?)";

        jdbcTemplate.update(
                sql,
                image.getEventId(),
                image.getImageUrl(),
                image.isBanner()
        );

        if (image.isBanner()) {
            jdbcTemplate.update(
                    "UPDATE events SET banner_image = ? WHERE id = ?",
                    image.getImageUrl(),
                    image.getEventId()
            );
        }
    }

    public void setAsBanner(int id) {
        EventImage image = findById(id);

        jdbcTemplate.update(
                "UPDATE event_images SET is_banner = FALSE WHERE event_id = ?",
                image.getEventId()
        );

        jdbcTemplate.update(
                "UPDATE event_images SET is_banner = TRUE WHERE id = ?",
                id
        );

        jdbcTemplate.update(
                "UPDATE events SET banner_image = ? WHERE id = ?",
                image.getImageUrl(),
                image.getEventId()
        );
    }

    public void delete(int id) {
        EventImage image = findById(id);

        jdbcTemplate.update("DELETE FROM event_images WHERE id = ?", id);

        if (image.isBanner()) {
            jdbcTemplate.update(
                    "UPDATE events SET banner_image = NULL WHERE id = ? AND banner_image = ?",
                    image.getEventId(),
                    image.getImageUrl()
            );
        }
    }
    // ==========================================
    // HÀM UPDATE ĐƯỢC THÊM VÀO Ở ĐÂY
    // ==========================================
    public void update(EventImage image) {
        // 1. Nếu ảnh này được sửa thành ảnh Banner, hạ hết các banner khác của sự kiện này xuống
        if (image.isBanner()) {
            jdbcTemplate.update(
                    "UPDATE event_images SET is_banner = FALSE WHERE event_id = ?",
                    image.getEventId()
            );
        }

        // 2. Chạy lệnh UPDATE cập nhật thông tin ảnh trong bảng event_images
        String sql = "UPDATE event_images SET event_id = ?, image_url = ?, is_banner = ? WHERE id = ?";
        jdbcTemplate.update(
                sql,
                image.getEventId(),
                image.getImageUrl(),
                image.isBanner(),
                image.getId()
        );

        // 3. Nếu là banner, đồng bộ cập nhật luôn cột banner_image bên bảng events
        if (image.isBanner()) {
            jdbcTemplate.update(
                    "UPDATE events SET banner_image = ? WHERE id = ?",
                    image.getImageUrl(),
                    image.getEventId()
            );
        }
    }
}
