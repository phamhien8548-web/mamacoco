<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<div class="container py-4">
<div class="row justify-content-center">
<div class="col-lg-8">

    <div class="card">
        <div class="card-header py-4">
            <h4 class="mb-1 fw-bold theme-header-title">
                <i class="fa-solid fa-ticket-simple me-2"></i>
                <c:choose>
                    <c:when test="${ticketType.id == 0}">Thêm loại vé</c:when>
                    <c:otherwise>Cập nhật loại vé</c:otherwise>
                </c:choose>
            </h4>
            <p class="mb-0 small theme-header-subtitle">
                Thiết lập tên vé, giá bán và số lượng phát hành.
            </p>
        </div>

        <div class="card-body p-4 p-lg-5">
            <form action="${ctx}/admin/ticket-types/save" method="post">

                <input type="hidden" name="id" value="${ticketType.id}">

                <div class="mb-4">
                    <label class="form-label fw-bold">
                        Sự kiện <span class="text-danger">*</span>
                    </label>
                    <select name="eventId" class="form-select" required>
                        <option value="">— Chọn sự kiện —</option>
                        <c:forEach var="e" items="${events}">
                            <option value="${e.id}" ${ticketType.eventId == e.id ? 'selected' : ''}>
                                ${e.eventName}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-bold">
                        Tên loại vé <span class="text-danger">*</span>
                    </label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fa-solid fa-ticket" style="color:var(--pur)"></i></span>
                        <input type="text" name="ticketName"
                               value="${ticketType.ticketName}"
                               class="form-control"
                               placeholder="Ví dụ: Vé thường, Vé VIP, Early Bird..."
                               required>
                    </div>
                </div>

                <div class="row g-3 mb-4">
                    <div class="col-md-4">
                        <label class="form-label fw-bold">
                            Giá vé (VNĐ) <span class="text-danger">*</span>
                        </label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-dong-sign" style="color:var(--pur)"></i></span>
                            <input type="number" name="price"
                                   value="${ticketType.price}"
                                   class="form-control"
                                   min="0" step="1000"
                                   placeholder="0"
                                   required>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-bold">
                            Tổng số lượng <span class="text-danger">*</span>
                        </label>
                        <input type="number" name="totalQuantity"
                               value="${ticketType.totalQuantity}"
                               class="form-control"
                               min="0" placeholder="0" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-bold">Đã bán</label>
                        <input type="number" name="soldQuantity"
                               value="${ticketType.soldQuantity}"
                               class="form-control"
                               min="0" placeholder="0" required>
                        <div class="form-text">Tự động cập nhật khi có giao dịch.</div>
                    </div>
                </div>

                <div class="mb-5">
                    <label class="form-label fw-bold">Trạng thái</label>
                    <select name="status" class="form-select">
                        <option value="OPEN"     ${ticketType.status == 'OPEN'     ? 'selected' : ''}>OPEN — Đang bán</option>
                        <option value="SOLD_OUT" ${ticketType.status == 'SOLD_OUT' ? 'selected' : ''}>SOLD_OUT — Hết vé</option>
                        <option value="CLOSED"   ${ticketType.status == 'CLOSED'   ? 'selected' : ''}>CLOSED — Ngừng bán</option>
                    </select>
                </div>

                <div class="d-flex justify-content-between gap-2">
                    <a href="${ctx}/admin/ticket-types" class="btn btn-outline-secondary">
                        <i class="fa-solid fa-arrow-left me-1"></i>Quay lại
                    </a>
                    <button type="submit" class="btn btn-danger px-4">
                        <i class="fa-solid fa-floppy-disk me-1"></i>
                        <c:choose>
                            <c:when test="${ticketType.id == 0}">Tạo loại vé</c:when>
                            <c:otherwise>Lưu thay đổi</c:otherwise>
                        </c:choose>
                    </button>
                </div>

            </form>
        </div>
    </div>

</div>
</div>
</div>
