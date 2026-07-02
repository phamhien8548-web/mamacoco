<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<%-- FRAGMENT — nhúng vào layout/main.jsp --%>

<div class="container my-5 d-flex justify-content-center">
    <div class="card shadow-lg border-0 rounded-3" style="max-width: 500px; width: 100%;">

        <div class="card-header text-white text-center py-4" style="background-color: #1e293b;">
            <h4 class="mb-1 fw-bold">
                <i class="fa-solid fa-shield-halved text-success"></i> UEF PAYMENT GATEWAY
            </h4>
            <p class="small payment-header-note mb-0">Hệ thống mô phỏng thanh toán an toàn trực tuyến</p>
        </div>

        <div class="card-body p-4">

            <c:if test="${param.error == 'invalid_info'}">
                <div class="alert alert-danger text-center fw-bold py-2 small">
                    <i class="fa-solid fa-triangle-exclamation"></i>
                    Vui lòng nhập đầy đủ thông tin thẻ để thực hiện giao dịch!
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/user/tickets/payment/execute" method="POST">
                <input type="hidden" name="bookingId" value="${bookingId}" />

                <%-- Mã đơn hàng --%>
                <div class="payment-reference mb-3 text-center p-3 rounded">
                    <span class="payment-reference-label d-block small text-uppercase">Mã giao dịch đơn hàng</span>
                    <strong class="text-danger fs-4">#${bookingId}</strong>
                </div>

                <%-- Số thẻ --%>
                <div class="mb-3">
                    <label class="form-label fw-bold">Số Thẻ / Số Tài Khoản Ngân Hàng</label>
                    <div class="input-group">
                        <span class="input-group-text">
                            <i class="fa-solid fa-credit-card text-muted"></i>
                        </span>
                        <input type="text" name="cardNumber" class="form-control"
                               placeholder="9704 1600 xxxx xxxx" required />
                    </div>
                </div>

                <%-- Tên chủ thẻ --%>
                <div class="mb-3">
                    <label class="form-label fw-bold">Tên Chủ Thẻ (Không dấu)</label>
                    <div class="input-group">
                        <span class="input-group-text">
                            <i class="fa-solid fa-user text-muted"></i>
                        </span>
                        <input type="text" name="cardHolder" class="form-control"
                               placeholder="NGUYEN VAN A"
                               style="text-transform: uppercase;" required />
                    </div>
                </div>

                <%-- Hạn thẻ & CVV --%>
                <div class="row">
                    <div class="col-6 mb-3">
                        <label class="form-label fw-bold">Ngày hết hạn</label>
                        <input type="text" class="form-control" placeholder="MM/YY" required />
                    </div>
                    <div class="col-6 mb-3">
                        <label class="form-label fw-bold">
                            Mã CVV <span class="text-muted small">(3 số sau)</span>
                        </label>
                        <input type="password" name="cvv" class="form-control"
                               maxlength="3" placeholder="***" required />
                    </div>
                </div>

                <div class="alert alert-warning small py-2 mt-2">
                    <i class="fa-solid fa-circle-info"></i>
                    Hệ thống đang chạy ở môi trường <strong>Local Test</strong>.
                    Các giao dịch tại đây <strong>không trừ tiền thật</strong>.
                </div>

                <div class="d-grid mt-4 gap-2">
                    <button type="submit" class="btn btn-success btn-lg fw-bold shadow-sm py-2">
                        <i class="fa-solid fa-lock"></i> XÁC NHẬN THANH TOÁN
                    </button>
                    <%--
                        FIX: Bản gốc link về /user/tickets/book (thiếu eventId → lỗi controller).
                        Chuyển về /events để người dùng chọn lại sự kiện.
                        FIX TYPO: "Hủzy" → "Hủy"
                    --%>
                    <a href="${pageContext.request.contextPath}/events"
                       class="btn btn-outline-secondary btn-sm text-center">
                        <i class="fa-solid fa-xmark"></i> Hủy giao dịch &amp; Quay lại
                    </a>
                </div>

            </form>
        </div>
    </div>
</div>
