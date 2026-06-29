<%-- 
    Document   : booking-líst
    Created on : Jun 12, 2026, 11:25:45 PM
    Author     : phamh
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<div class="container-fluid my-4 px-4">
    <div class="d-flex justify-content-between align-items-center mb-3 border-bottom pb-2">
        <div>
            <h2 class="text-dark fw-bold mb-0">
                <i class="fa-solid fa-user-gear text-danger"></i> ĐIỀU HÀNH VÉ & ĐIỂM DANH (ADMIN)
            </h2>
            <p class="text-muted small mb-0">Hệ thống cục bộ kiểm soát dòng tiền và trạng thái tham gia sự kiện.</p>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/admin/tickets/invoices" class="btn btn-primary fw-bold shadow-sm">
                <i class="fa-solid fa-file-invoice-dollar"></i> Quản Lý Nhật Ký Hóa Đơn
            </a>
        </div>
    </div>

    <div class="card shadow-sm border-0 rounded-3 overflow-hidden">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover table-striped align-middle mb-0">
                    <thead class="table-dark text-uppercase small">
                        <tr>
                            <th class="py-3 text-center" style="width: 8%;">ID</th>
                            <th class="py-3">Khách Hàng</th>
                            <th class="py-3">Tên Sự Kiện</th>
                            <th class="py-3 text-center">Số Lượng</th>
                            <th class="py-3 text-end">Tổng Tiền</th>
                            <th class="py-3 text-center" style="width: 15%;">Trạng Thái</th>
                            <th class="py-3 text-center" style="width: 20%;">Hành Động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty allBookings}">
                                <tr>
                                    <td colspan="7" class="text-center text-muted py-5">
                                        <i class="fa-solid fa-inbox d-block mb-2 fs-3"></i> Danh sách trống! Chưa có đơn đặt vé nào.
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${allBookings}" var="b">
                                    <tr>
                                        <td class="text-center fw-bold text-secondary">#${b.bookingID}</td>
                                        <td>
                                            <div class="fw-bold text-dark">${b.customerName}</div>
                                            <small class="text-muted"><i class="fa-solid fa-envelope"></i> ${b.customerEmail}</small>
                                        </td>
                                        <td class="fw-bold text-primary">${b.eventName}</td>
                                        <td class="text-center fw-bold">${b.quantity}</td>
                                        <td class="text-end fw-bold text-danger">
                                            <fmt:formatNumber value="${b.totalPrice}" type="number"/> đ
                                        </td>
                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${b.status == 'PENDING'}">
                                                    <span class="badge bg-warning text-dark px-2 py-2"><i class="fa-solid fa-spinner"></i> CHỜ THU TIỀN</span>
                                                </c:when>
                                                <c:when test="${b.status == 'CONFIRMED'}">
                                                    <span class="badge bg-success px-2 py-2"><i class="fa-solid fa-circle-check"></i> ĐÃ THANH TOÁN</span>
                                                </c:when>
                                                <c:when test="${b.status == 'ATTENDED'}">
                                                    <span class="badge bg-secondary px-2 py-2"><i class="fa-solid fa-user-check"></i> ĐÃ CHECK-IN</span>
                                                </c:when>
                                            </c:choose>
                                        </td>
                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${b.status == 'PENDING'}">
                                                    <a href="${pageContext.request.contextPath}/admin/tickets/approve/${b.bookingID}" 
                                                       class="btn btn-success btn-sm fw-bold px-3 shadow-sm"
                                                       onclick="return confirm('Xác nhận thu tiền local cho đơn hàng #${b.bookingID}?')">
                                                        <i class="fa-solid fa-cash-register"></i> Duyệt Thu Tiền
                                                    </a>
                                                </c:when>
                                                <c:when test="${b.status == 'CONFIRMED'}">
                                                    <a href="${pageContext.request.contextPath}/admin/tickets/checkin/${b.bookingID}" 
                                                       class="btn btn-danger btn-sm fw-bold px-3 shadow-sm">
                                                        <i class="fa-solid fa-qrcode"></i> Bấm Điểm Danh
                                                    </a>
                                                </c:when>
                                                <c:when test="${b.status == 'ATTENDED'}">
                                                    <button class="btn btn-light btn-sm disabled text-muted border">
                                                        <i class="fa-solid fa-check"></i> Hoàn Thành
                                                    </button>
                                                </c:when>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>