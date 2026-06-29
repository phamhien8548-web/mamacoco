package uef.edu.vn.model;

import jakarta.validation.constraints.*;

public class Booking {

    public Booking(int eventId, int id, int ticketTypeId, int eventID, int bookingID, String customerName, String customerEmail, String eventName, int quantity, double totalPrice, String status) {
        this.eventId = eventId;
        this.id = id;
        this.ticketTypeId = ticketTypeId;
        this.eventID = eventID;
        this.bookingID = bookingID;
        this.customerName = customerName;
        this.customerEmail = customerEmail;
        this.eventName = eventName;
        this.quantity = quantity;
        this.totalPrice = totalPrice;
        this.status = status;
    }

    private int eventId;

    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getTicketTypeId() {
        return ticketTypeId;
    }

    public void setTicketTypeId(int ticketTypeId) {
        this.ticketTypeId = ticketTypeId;
    }

    private int id;
    private int ticketTypeId;

    public int getEventID() {
        return eventID;
    }

    public void setEventID(int eventID) {
        this.eventID = eventID;
    }
    private int eventID;
    private int bookingID;

    @NotBlank(message = "Customer name is required")
    private String customerName;

    @NotBlank(message = "Email is required")
    @Email(message = "Invalid email format")
    private String customerEmail;

    @NotBlank(message = "Event name is required")
    private String eventName;

    @Min(value = 1, message = "Quantity must be at least 1")
    private int quantity;

    private double totalPrice;
    private String status; // PENDING, CONFIRMED, ATTENDED

    public Booking() {
    }

    // Getters and Setters
    public int getBookingID() {
        return bookingID;
    }

    public void setBookingID(int bookingID) {
        this.bookingID = bookingID;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerEmail() {
        return customerEmail;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }

    public String getEventName() {
        return eventName;
    }

    public void setEventName(String eventName) {
        this.eventName = eventName;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
