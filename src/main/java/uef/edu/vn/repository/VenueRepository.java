/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uef.edu.vn.repository;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import uef.edu.vn.model.Venue;

@Repository
public class VenueRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Venue> findAll() {
        String sql = "SELECT * FROM venues ORDER BY id DESC";

        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            Venue v = new Venue();
            v.setId(rs.getInt("id"));
            v.setVenueName(rs.getString("venue_name"));
            v.setAddress(rs.getString("address"));
            v.setCapacity(rs.getInt("capacity"));
            v.setDescription(rs.getString("description"));
            v.setStatus(rs.getString("status"));
            return v;
        });
    }

    public Venue findById(int id) {
        String sql = "SELECT * FROM venues WHERE id = ?";

        return jdbcTemplate.queryForObject(sql, (rs, rowNum) -> {
            Venue v = new Venue();
            v.setId(rs.getInt("id"));
            v.setVenueName(rs.getString("venue_name"));
            v.setAddress(rs.getString("address"));
            v.setCapacity(rs.getInt("capacity"));
            v.setDescription(rs.getString("description"));
            v.setStatus(rs.getString("status"));
            return v;
        }, id);
    }

    public void save(Venue venue) {
        String sql = "INSERT INTO venues(venue_name, address, capacity, description, status) VALUES (?, ?, ?, ?, ?)";
        jdbcTemplate.update(
                sql,
                venue.getVenueName(),
                venue.getAddress(),
                venue.getCapacity(),
                venue.getDescription(),
                venue.getStatus()
        );
    }

    public void update(Venue venue) {
        String sql = "UPDATE venues SET venue_name = ?, address = ?, capacity = ?, description = ?, status = ? WHERE id = ?";
        jdbcTemplate.update(
                sql,
                venue.getVenueName(),
                venue.getAddress(),
                venue.getCapacity(),
                venue.getDescription(),
                venue.getStatus(),
                venue.getId()
        );
    }

    public void delete(int id) {
        String sql = "DELETE FROM venues WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }
}
