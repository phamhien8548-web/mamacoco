package uef.edu.vn.model;

public class Invoice {

    private int invoiceID;
    private int bookingID;
    private String invoiceNumber;
    private double amount;
    private String paymentStatus; // UNPAID, PAID

    public Invoice() {
    }

    public Invoice(int invoiceID, int bookingID, String invoiceNumber, double amount, String paymentStatus) {
        this.invoiceID = invoiceID;
        this.bookingID = bookingID;
        this.invoiceNumber = invoiceNumber;
        this.amount = amount;
        this.paymentStatus = paymentStatus;
    }

    // Getters and Setters
    public int getInvoiceID() {
        return invoiceID;
    }

    public void setInvoiceID(int invoiceID) {
        this.invoiceID = invoiceID;
    }

    public int getBookingID() {
        return bookingID;
    }

    public void setBookingID(int bookingID) {
        this.bookingID = bookingID;
    }

    public String getInvoiceNumber() {
        return invoiceNumber;
    }

    public void setInvoiceNumber(String invoiceNumber) {
        this.invoiceNumber = invoiceNumber;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }
}
