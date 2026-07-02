<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<%--
    FRAGMENT — nhúng vào layout/main.jsp qua <jsp:include page="${body}" />
    Controller gửi qua: event, ticketTypes, booking (đã pre-fill customerName/customerEmail từ session)
--%>

<div class="container my-5" style="max-width: 650px;">
    <div class="card booking-card shadow border-0">

        <div class="card-header bg-danger text-white text-center py-3">
            <h4 class="mb-0 fw-bold">
                <i class="fa-solid fa-ticket"></i> CỔNG ĐẶT VÉ TRỰC TUYẾN
            </h4>
        </div>

        <div class="card-body p-4">

            <%-- Thông báo lỗi nếu có (overbooking, vé hết...) --%>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show small fw-bold" role="alert">
                    <i class="fa-solid fa-triangle-exclamation"></i> ${errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <form:form action="${pageContext.request.contextPath}/user/tickets/book"
                       method="POST"
                       modelAttribute="booking">

                <%--
                    FIX BUG NGHIÊM TRỌNG:
                    Hidden field để POST trả về eventId về controller.
                    Controller pre-set booking.eventId trên GET, nhưng nếu không có
                    hidden field thì khi submit POST, eventId = 0 → lỗi DB.
                --%>
                <form:hidden path="eventId" />

                <%-- Thông tin sự kiện đang đặt vé --%>
                <div class="alert theme-alert border-danger border-2 mb-3">
                    <div class="fw-bold text-danger mb-1">
                        <i class="fa-solid fa-calendar-star"></i> Sự kiện:
                    </div>
                    <span class="fs-6">${event.eventName}</span>
                    <c:if test="${not empty event.venueName}">
                        <br><small class="text-muted">
                            <i class="fa-solid fa-location-dot"></i> ${event.venueName}
                        </small>
                    </c:if>
                </div>

                <%-- Chọn loại vé --%>
                <div class="mb-3">
                    <label class="form-label fw-bold">
                        Chọn Loại Vé: <span class="text-danger">*</span>
                    </label>
                    <%--
                        FIX BUG NGHIÊM TRỌNG:
                        Bản gốc dùng cờ ${isDirectBooking} mà controller KHÔNG BAO GIỜ set
                        → luôn rơi vào <c:otherwise> dùng ${allTicketTypes} cũng không được set
                        → dropdown rỗng, không thể chọn được vé nào.

                        Controller showBookForm() luôn truyền ${ticketTypes} cho sự kiện cụ thể,
                        nên dùng trực tiếp ${ticketTypes}.
                    --%>
                    <form:select path="ticketTypeId" class="form-select border-danger fw-bold" required="true">
                        <option value="">-- Chọn hạng vé --</option>
                        <c:forEach items="${ticketTypes}" var="t">
                            <form:option value="${t.id}">
                                ${t.ticketName} —
                                <fmt:formatNumber value="${t.price}" type="number"/> VNĐ
                                (Còn ${t.remainingQuantity} vé)
                            </form:option>
                        </c:forEach>
                    </form:select>
                    <form:errors path="ticketTypeId" class="text-danger small mt-1 d-block" />
                </div>

                <%-- Họ tên khách hàng — auto-fill từ session, readonly nếu đã đăng nhập --%>
                <div class="mb-3">
                    <label class="form-label fw-bold">
                        Họ và Tên Người Mua: <span class="text-danger">*</span>
                    </label>
                    <form:input path="customerName"
                                class="form-control"
                                placeholder="Nhập đầy đủ họ tên..."
                                readonly="${not empty sessionScope.currentUser ? 'true' : 'false'}" />
                    <form:errors path="customerName" class="text-danger small mt-1 d-block" />
                </div>

                <%-- Email — auto-fill từ session --%>
                <div class="mb-3">
                    <label class="form-label fw-bold">
                        Email nhận vé điện tử: <span class="text-danger">*</span>
                    </label>
                    <form:input path="customerEmail"
                                type="email"
                                class="form-control"
                                placeholder="username@gmail.com"
                                readonly="${not empty sessionScope.currentUser ? 'true' : 'false'}" />
                    <form:errors path="customerEmail" class="text-danger small mt-1 d-block" />
                </div>

                <%-- Số lượng vé --%>
                <div class="mb-4">
                    <label class="form-label fw-bold">Số lượng vé:</label>
                    <form:input path="quantity"
                                type="number"
                                class="form-control text-center fw-bold fs-5 border-danger"
                                min="1"
                                value="1" />
                    <form:errors path="quantity" class="text-danger small mt-1 d-block" />
                </div>

                <%--
                    FIX: Cập nhật mô tả luồng thanh toán cho đúng thực tế.
                    Hệ thống có cổng thanh toán giả lập (mock payment gateway),
                    KHÔNG phải "thanh toán tại quầy".
                --%>
                <div class="alert alert-info small mb-4">
                    <i class="fa-solid fa-circle-info"></i>
                    <strong>Lưu ý:</strong> Sau khi xác nhận, bạn sẽ được chuyển đến
                    <strong>cổng thanh toán</strong> để hoàn tất giao dịch. Vé chỉ được kích hoạt
                    sau khi thanh toán thành công.
                </div>

                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-danger btn-lg fw-bold shadow-sm">
                        <i class="fa-solid fa-check-to-slot"></i> XÁC NHẬN ĐẶT VÉ
                    </button>
                    <a href="${pageContext.request.contextPath}/events/detail/${booking.eventId}"
                       class="btn btn-link btn-sm text-muted text-decoration-none text-center">
                        <i class="fa-solid fa-arrow-left"></i> Quay lại chi tiết sự kiện
                    </a>
                </div>

            </form:form>
        </div>
    </div>
</div>
