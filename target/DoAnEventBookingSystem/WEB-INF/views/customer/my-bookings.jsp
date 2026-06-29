<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<%-- FRAGMENT — nhúng vào layout/main.jsp --%>

<div class="container my-5" style="max-width: 900px;">

    <c:if test="${param.success == 'true'}">
        <div class="alert alert-success alert-dismissible fade show fw-bold" role="alert">
            <i class="fa-solid fa-circle-check"></i>
            Thanh toán thành công! Vé của bạn đã được xác nhận. Kiểm tra email để nhận vé điện tử.
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="card shadow border-0 rounded-3 overflow-hidden">
        <div class="card-header bg-dark text-white py-3 d-flex justify-content-between align-items-center">
            <h5 class="mb-0 fw-bold">
                <i class="fa-solid fa-clock-rotate-left"></i> LỊCH SỬ ĐẶT VÉ CỦA BẠN
            </h5>
            <%--
                FIX: Bản gốc link về /user/tickets/book (thiếu ?eventId=... → controller lỗi ngay).
                TicketUserController.showBookForm() yêu cầu @RequestParam("eventId") int eventId bắt buộc.
                Đổi thành /events để người dùng chọn sự kiện trước rồi mới đặt vé.
            --%>
            <a href="${pageContext.request.contextPath}/events"
               class="btn btn-outline-light btn-sm fw-bold">
                <i class="fa-solid fa-plus"></i> Đặt Vé Mới
            </a>
        </div>

        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-secondary small text-uppercase">
                        <tr>
                            <th class="py-3 text-center">Mã Đơn</th>
                            <th class="py-3">Sự Kiện</th>
                            <th class="py-3 text-center">Số Lượng</th>
                            <th class="py-3 text-end">Tổng Tiền</th>
                            <th class="py-3 text-center">Trạng Thái</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty myBookings}">
                                <tr>
                                    <td colspan="5" class="text-center text-muted py-5">
                                        <i class="fa-solid fa-ticket-simple d-block mb-3 fa-3x text-secondary opacity-50"></i>
                                        <span class="fs-5">Bạn chưa có đơn đặt vé nào trên hệ thống.</span><br>
                                        <small>Hãy chọn cho mình một sự kiện để tham gia nhé!</small>
                                        <br><br>
                                        <a href="${pageContext.request.contextPath}/events"
                                           class="btn btn-primary btn-sm">
                                            <i class="fa-solid fa-calendar-days"></i> Xem danh sách sự kiện
                                        </a>
                                    </td>
                                </tr>
                            </c:when>

                            <c:otherwise>
                                <c:forEach items="${myBookings}" var="b">
                                    <tr>
                                        <td class="text-center fw-bold text-danger">#${b.bookingID}</td>
                                        <td class="fw-bold">${b.eventName}</td>
                                        <td class="text-center fw-bold">${b.quantity}</td>
                                        <td class="text-end fw-bold">
                                            <fmt:formatNumber value="${b.totalPrice}" type="number"/> đ
                                        </td>
                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${b.status == 'PENDING'}">
                                                    <span class="badge bg-warning text-dark px-2 py-2">
                                                        <i class="fa-solid fa-hourglass-half"></i> CHỜ THANH TOÁN
                                                    </span>
                                                </c:when>
                                                <c:when test="${b.status == 'CONFIRMED'}">
                                                    <span class="badge bg-success px-2 py-2">
                                                        <i class="fa-solid fa-circle-check"></i> ĐÃ THANH TOÁN
                                                    </span>
                                                </c:when>
                                                <c:when test="${b.status == 'ATTENDED'}">
                                                    <span class="badge bg-secondary px-2 py-2">
                                                        <i class="fa-solid fa-user-check"></i> ĐÃ THAM GIA
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-light text-dark px-2 py-2">
                                                        ${b.status}
                                                    </span>
                                                </c:otherwise>
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
