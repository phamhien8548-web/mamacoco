<%-- 
    Document   : invoice-list
    Created on : Jun 12, 2026, 11:26:10 PM
    Author     : phamh
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<div class="container my-4">
    <div class="d-flex justify-content-between align-items-center mb-3 border-bottom pb-2">
        <div>
            <h2 class="fw-bold mb-0" style="color:var(--tx)">
                <i class="fa-solid fa-receipt text-primary"></i> ĐỐI SOÁT HÓA ĐƠN TÀI CHÍNH (ADMIN)
            </h2>
            <p class="text-muted small mb-0">Danh sách hóa đơn được tạo tự động tương ứng với dòng tiền mặt thực tế thu được.</p>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/admin/tickets/bookings" class="btn btn-outline-secondary fw-bold">
                <i class="fa-solid fa-arrow-left"></i> Quay lại Danh Sách Vé
            </a>
        </div>
    </div>

    <div class="card shadow-sm border-0 rounded-3 overflow-hidden">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover table-striped align-middle mb-0">
                    <thead class="table-primary text-uppercase small">
                        <tr>
                            <th class="py-3 text-center" style="width: 12%;">ID Hóa Đơn</th>
                            <th class="py-3 text-center" style="width: 15%;">Mã Đơn Đặt</th>
                            <th class="py-3">Mã Số Hóa Đơn Kiểm Tra (UUID)</th>
                            <th class="py-3 text-end" style="width: 20%;">Doanh Thu Ghi Nhận</th>
                            <th class="py-3 text-center" style="width: 15%;">Trạng Thái</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty allInvoices}">
                                <tr>
                                    <td colspan="5" class="text-center text-muted py-5">
                                        <i class="fa-solid fa-receipt d-block mb-2 fs-3"></i> Chưa có hóa đơn nào được xuất trên hệ thống!
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${allInvoices}" var="inv">
                                    <tr>
                                        <td class="text-center fw-bold text-primary">#${inv.invoiceID}</td>
                                        <td class="text-center fw-bold text-secondary">Đơn #${inv.bookingID}</td>
                                        <td><code class="fs-6 fw-bold" style="color:var(--pur)">${inv.invoiceNumber}</code></td>
                                        <td class="text-end fw-bold text-success">
                                            <fmt:formatNumber value="${inv.amount}" type="number"/> đ
                                        </td>
                                        <td class="text-center">
                                            <span class="badge bg-success px-3 py-1 text-uppercase">
                                                <i class="fa-solid fa-check-double"></i> ${inv.paymentStatus}
                                            </span>
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