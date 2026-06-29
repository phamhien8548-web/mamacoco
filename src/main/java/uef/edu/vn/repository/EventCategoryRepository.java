package uef.edu.vn.repository;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import uef.edu.vn.model.EventCategory;

@Repository
public class EventCategoryRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<EventCategory> findAll() {
        String sql = "SELECT * FROM event_categories ORDER BY id DESC";

        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            EventCategory c = new EventCategory();
            c.setId(rs.getInt("id"));
            c.setCategoryName(rs.getString("category_name"));
            c.setDescription(rs.getString("description"));
            c.setStatus(rs.getString("status"));
            return c;
        });
    }

    public EventCategory findById(int id) {
        String sql = "SELECT * FROM event_categories WHERE id = ?";

        return jdbcTemplate.queryForObject(sql, (rs, rowNum) -> {
            EventCategory c = new EventCategory();
            c.setId(rs.getInt("id"));
            c.setCategoryName(rs.getString("category_name"));
            c.setDescription(rs.getString("description"));
            c.setStatus(rs.getString("status"));
            return c;
        }, id);
    }

    public void save(EventCategory category) {
        String sql = "INSERT INTO event_categories(category_name, description, status) VALUES (?, ?, ?)";
        jdbcTemplate.update(
                sql,
                category.getCategoryName(),
                category.getDescription(),
                category.getStatus()
        );
    }

    public void update(EventCategory category) {
        String sql = "UPDATE event_categories SET category_name = ?, description = ?, status = ? WHERE id = ?";
        jdbcTemplate.update(
                sql,
                category.getCategoryName(),
                category.getDescription(),
                category.getStatus(),
                category.getId()
        );
    }

    public void delete(int id) {
        String sql = "DELETE FROM event_categories WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }
}
