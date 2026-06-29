/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uef.edu.vn.repository;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import uef.edu.vn.model.EventSchedule;

@Repository
public class EventScheduleRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private EventSchedule mapRow(java.sql.ResultSet rs) throws java.sql.SQLException {
        EventSchedule s = new EventSchedule();

        s.setId(rs.getInt("schedule_id"));
        s.setEventId(rs.getInt("event_id"));
        s.setStartTime(rs.getString("start_time"));
        s.setEndTime(rs.getString("end_time"));
        s.setNote(rs.getString("note"));
        s.setEventName(rs.getString("event_name"));

        return s;
    }

    public List<EventSchedule> findAll() {
        String sql = ""
                + "SELECT "
                + "s.id AS schedule_id, "
                + "s.event_id AS event_id, "
                + "s.start_time AS start_time, "
                + "s.end_time AS end_time, "
                + "s.note AS note, "
                + "e.event_name AS event_name "
                + "FROM event_schedules s "
                + "JOIN events e ON s.event_id = e.id "
                + "ORDER BY s.start_time DESC";

        return jdbcTemplate.query(sql, (rs, rowNum) -> mapRow(rs));
    }

    public EventSchedule findById(int id) {
        String sql = ""
                + "SELECT "
                + "s.id AS schedule_id, "
                + "s.event_id AS event_id, "
                + "s.start_time AS start_time, "
                + "s.end_time AS end_time, "
                + "s.note AS note, "
                + "e.event_name AS event_name "
                + "FROM event_schedules s "
                + "JOIN events e ON s.event_id = e.id "
                + "WHERE s.id = ?";

        return jdbcTemplate.queryForObject(sql, (rs, rowNum) -> mapRow(rs), id);
    }

    public void save(EventSchedule schedule) {
        String sql = "INSERT INTO event_schedules(event_id, start_time, end_time, note) VALUES (?, ?, ?, ?)";

        jdbcTemplate.update(
                sql,
                schedule.getEventId(),
                toMysqlDateTime(schedule.getStartTime()),
                toMysqlDateTime(schedule.getEndTime()),
                schedule.getNote()
        );
    }

    public void update(EventSchedule schedule) {
        String sql = "UPDATE event_schedules SET event_id = ?, start_time = ?, end_time = ?, note = ? WHERE id = ?";

        jdbcTemplate.update(
                sql,
                schedule.getEventId(),
                toMysqlDateTime(schedule.getStartTime()),
                toMysqlDateTime(schedule.getEndTime()),
                schedule.getNote(),
                schedule.getId()
        );
    }

    public void delete(int id) {
        String sql = "DELETE FROM event_schedules WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }

    private String toMysqlDateTime(String value) {
        if (value == null || value.trim().isEmpty()) {
            return null;
        }

        if (value.contains("T")) {
            return value.replace("T", " ") + ":00";
        }

        return value;
    }
}
