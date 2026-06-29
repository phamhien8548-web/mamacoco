package uef.edu.vn.repository;

import uef.edu.vn.model.Invoice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class InvoiceRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private Invoice mapRow(ResultSet rs, int rowNum) throws SQLException {
        Invoice inv = new Invoice();
        inv.setInvoiceID(rs.getInt("InvoiceID"));
        inv.setBookingID(rs.getInt("BookingID"));
        inv.setInvoiceNumber(rs.getString("InvoiceNumber"));
        inv.setAmount(rs.getDouble("Amount"));
        inv.setPaymentStatus(rs.getString("PaymentStatus"));
        return inv;
    }

    public void save(Invoice invoice) {
        String sql = "INSERT INTO Invoices (BookingID, InvoiceNumber, Amount, PaymentStatus) VALUES (?, ?, ?, ?)";
        jdbcTemplate.update(sql, invoice.getBookingID(), invoice.getInvoiceNumber(), invoice.getAmount(), invoice.getPaymentStatus());
    }

    public List<Invoice> findAll() {
        String sql = "SELECT * FROM Invoices";
        return jdbcTemplate.query(sql, this::mapRow);
    }

    public Invoice findByBookingId(int bookingId) {
        String sql = "SELECT * FROM Invoices WHERE BookingID = ?";
        return jdbcTemplate.queryForObject(sql, this::mapRow, bookingId);
    }

    public void updateStatus(int bookingId, String status) {
        String sql = "UPDATE Invoices SET PaymentStatus = ? WHERE BookingID = ?";
        jdbcTemplate.update(sql, status, bookingId);
    }
}
