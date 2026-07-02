<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<div class="container py-4">
<div class="row justify-content-center">
<div class="col-lg-7">

    <div class="card">
        <div class="card-header py-4">
            <h4 class="mb-1 fw-bold theme-header-title">
                <i class="fa-solid fa-clock me-2"></i>
                <c:choose>
                    <c:when test="${schedule.id == 0}">Thêm lịch tổ chức</c:when>
                    <c:otherwise>Cập nhật lịch tổ chức</c:otherwise>
                </c:choose>
            </h4>
            <p class="mb-0 small theme-header-subtitle">
                Thiết lập thời gian bắt đầu và kết thúc cho sự kiện.
            </p>
        </div>

        <div class="card-body p-4 p-lg-5">
            <form action="${ctx}/admin/schedules/save" method="post">

                <input type="hidden" name="id" value="${schedule.id}">

                <div class="mb-4">
                    <label class="form-label fw-bold">
                        Sự kiện <span class="text-danger">*</span>
                    </label>
                    <select name="eventId" class="form-select" required>
                        <option value="">— Chọn sự kiện —</option>
                        <c:forEach var="e" items="${events}">
                            <option value="${e.id}" ${schedule.eventId == e.id ? 'selected' : ''}>
                                ${e.eventName}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="row g-3 mb-4">
                    <div class="col-md-6">
                        <label class="form-label fw-bold">
                            Thời gian bắt đầu <span class="text-danger">*</span>
                        </label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-play" style="color:var(--pur)"></i></span>
                            <input type="datetime-local" name="startTime"
                                   value="${schedule.startTime}"
                                   class="form-control" required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-bold">
                            Thời gian kết thúc <span class="text-danger">*</span>
                        </label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-stop" style="color:var(--pur)"></i></span>
                            <input type="datetime-local" name="endTime"
                                   value="${schedule.endTime}"
                                   class="form-control" required>
                        </div>
                    </div>
                </div>

                <div class="mb-5">
                    <label class="form-label fw-bold">Ghi chú</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fa-solid fa-note-sticky" style="color:var(--pur)"></i></span>
                        <input type="text" name="note"
                               value="${schedule.note}"
                               class="form-control"
                               placeholder="Ví dụ: Mở cửa lúc 17:30, Check-in từ 18:00">
                    </div>
                </div>

                <div class="d-flex justify-content-between gap-2">
                    <a href="${ctx}/admin/schedules" class="btn btn-outline-secondary">
                        <i class="fa-solid fa-arrow-left me-1"></i>Quay lại
                    </a>
                    <button type="submit" class="btn btn-danger px-4">
                        <i class="fa-solid fa-floppy-disk me-1"></i>
                        <c:choose>
                            <c:when test="${schedule.id == 0}">Tạo lịch</c:when>
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
