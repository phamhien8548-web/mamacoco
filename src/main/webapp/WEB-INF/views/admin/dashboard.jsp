<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<div class="container-fluid my-4 px-4">
    <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-2">
        <div>
            <h2 class="text-dark fw-bold mb-0">
                <i class="fa-solid fa-chart-pie text-danger"></i> BẢNG ĐIỀU KHIỂN THỐNG KÊ
            </h2>
            <p class="text-muted small mb-0">Theo dõi doanh thu và lượt tham gia sự kiện theo thời gian thực.</p>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/admin/tickets/bookings" class="btn btn-outline-secondary fw-bold shadow-sm">
                <i class="fa-solid fa-list-check"></i> Chuyển sang Quản lý vé
            </a>
        </div>
    </div>

    <div class="row mb-4">
        <div class="col-md-6 mb-3 mb-md-0">
            <div class="card bg-primary text-white shadow border-0 rounded-3 h-100 overflow-hidden">
                <div class="card-body position-relative p-4">
                    <div class="fw-bold text-uppercase mb-1 opacity-75">Tổng Doanh Thu Hệ Thống</div>
                    <h2 class="fw-bold mb-0 display-6">
                        <fmt:formatNumber value="${totalRevenue}" type="number"/> VNĐ
                    </h2>
                    <i class="fa-solid fa-sack-dollar position-absolute opacity-25" style="font-size: 5rem; top: 10px; right: 20px;"></i>
                </div>
            </div>
        </div>
        
        <div class="col-md-6">
            <div class="card bg-success text-white shadow border-0 rounded-3 h-100 overflow-hidden">
                <div class="card-body position-relative p-4">
                    <div class="fw-bold text-uppercase mb-1 opacity-75">Tổng Số Vé Đã Bán & Phê Duyệt</div>
                    <h2 class="fw-bold mb-0 display-6">
                        ${totalTickets} <span class="fs-4">vé</span>
                    </h2>
                    <i class="fa-solid fa-ticket position-absolute opacity-25" style="font-size: 5rem; top: 10px; right: 20px;"></i>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-8 mb-4">
            <div class="card shadow-sm border-0 rounded-3 h-100">
                <div class="card-header bg-white py-3">
                    <h6 class="mb-0 fw-bold text-secondary text-uppercase"><i class="fa-solid fa-chart-column"></i> BIỂU ĐỒ DOANH THU THEO SỰ KIỆN</h6>
                </div>
                <div class="card-body">
                    <canvas id="revenueChart" style="min-height: 300px;"></canvas>
                </div>
            </div>
        </div>

        <div class="col-lg-4 mb-4">
            <div class="card shadow-sm border-0 rounded-3 h-100">
                <div class="card-header bg-white py-3">
                    <h6 class="mb-0 fw-bold text-secondary text-uppercase"><i class="fa-solid fa-chart-doughnut"></i> TỈ LỆ TRẠNG THÁI VÉ</h6>
                </div>
                <div class="card-body d-flex align-items-center justify-content-center">
                    <canvas id="attendanceChart" style="max-height: 300px;"></canvas>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        
        // --------------------------------------------------------
        // 1. XỬ LÝ BIỂU ĐỒ DOANH THU (BAR CHART)
        // Dùng JSTL bóc tách List<DashboardStats> từ Model ra mảng Javascript
        const eventLabels = [
            <c:forEach items="${revenueStats}" var="stat">
                "${stat.label}",
            </c:forEach>
        ];
        
        const revenueData = [
            <c:forEach items="${revenueStats}" var="stat">
                ${stat.revenue},
            </c:forEach>
        ];

        // Vẽ biểu đồ Cột
        const ctxRevenue = document.getElementById('revenueChart').getContext('2d');
        new Chart(ctxRevenue, {
            type: 'bar',
            data: {
                labels: eventLabels,
                datasets: [{
                    label: 'Doanh Thu (VNĐ)',
                    data: revenueData,
                    backgroundColor: 'rgba(13, 110, 253, 0.7)', // Màu xanh primary của Bootstrap
                    borderColor: 'rgba(13, 110, 253, 1)',
                    borderWidth: 1,
                    borderRadius: 4
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: { beginAtZero: true }
                }
            }
        });

        // --------------------------------------------------------
        // 2. XỬ LÝ BIỂU ĐỒ TỈ LỆ VÉ (DOUGHNUT CHART)
        // Bóc tách dữ liệu từ attendanceStats
        const statusLabels = [
            <c:forEach items="${attendanceStats}" var="stat">
                // Đổi nhãn tiếng Anh sang tiếng Việt cho đẹp biểu đồ
                "${stat.label == 'PENDING' ? 'Chờ thanh toán' : (stat.label == 'CONFIRMED' ? 'Đã thanh toán (Chưa tham gia)' : 'Đã check-in')}",
            </c:forEach>
        ];

        const ticketsSoldData = [
            <c:forEach items="${attendanceStats}" var="stat">
                ${stat.ticketsSold},
            </c:forEach>
        ];

        // Vẽ biểu đồ Tròn khuyết (Doughnut)
        const ctxAttendance = document.getElementById('attendanceChart').getContext('2d');
        new Chart(ctxAttendance, {
            type: 'doughnut',
            data: {
                labels: statusLabels,
                datasets: [{
                    data: ticketsSoldData,
                    // Bảng màu: Vàng (Pending), Xanh lá (Confirmed), Xám đen (Attended)
                    backgroundColor: ['#ffc107', '#198754', '#6c757d'],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { position: 'bottom' }
                }
            }
        });

    });
</script>