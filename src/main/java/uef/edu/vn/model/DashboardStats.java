package uef.edu.vn.model;

public class DashboardStats {

    private String label;        // Nhãn biểu đồ: Tên sự kiện, tên loại vé, hoặc tháng/năm thống kê
    private int ticketsSold;     // Tổng số lượng vé đã bán được (để vẽ biểu đồ cột/tròn số lượng)
    private double revenue;      // Tổng doanh thu tương ứng (để vẽ biểu đồ doanh thu tài chính)

    // Hàm khởi tạo không tham số bắt buộc cho Spring Framework
    public DashboardStats() {
    }

    // Hàm khởi tạo có tham số giúp ép dữ liệu cực nhanh từ RowMapper của Repository
    public DashboardStats(String label, int ticketsSold, double revenue) {
        this.label = label;
        this.ticketsSold = ticketsSold;
        this.revenue = revenue;
    }

    // --- HỆ THỐNG GETTERS VÀ SETTERS ĐỒNG BỘ THEO PHONG CÁCH CỦA DỰ ÁN ---

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public int getTicketsSold() {
        return ticketsSold;
    }

    public void setTicketsSold(int ticketsSold) {
        this.ticketsSold = ticketsSold;
    }

    public double getRevenue() {
        return revenue;
    }

    public void setRevenue(double revenue) {
        this.revenue = revenue;
    }
}