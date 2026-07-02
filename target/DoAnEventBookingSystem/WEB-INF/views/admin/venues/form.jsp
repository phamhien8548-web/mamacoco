<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<div class="container py-4">
<div class="row justify-content-center">
<div class="col-lg-8">

    <div class="card">

        <div class="card-header py-4">
            <h4 class="mb-1 fw-bold theme-header-title">
                <i class="fa-solid fa-location-dot me-2"></i>
                <c:choose>
                    <c:when test="${venue.id == 0}">Thêm địa điểm tổ chức</c:when>
                    <c:otherwise>Cập nhật địa điểm tổ chức</c:otherwise>
                </c:choose>
            </h4>
            <p class="mb-0 small theme-header-subtitle">
                Nhập thông tin nơi diễn ra sự kiện.
            </p>
        </div>

        <div class="card-body p-4 p-lg-5">
            <form action="${ctx}/admin/venues/save" method="post">

                <input type="hidden" name="id" value="${venue.id}">

                <div class="mb-4">
                    <label class="form-label fw-bold">
                        Tên địa điểm <span class="text-danger">*</span>
                    </label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fa-solid fa-building" style="color:var(--pur)"></i></span>
                        <input type="text" name="venueName"
                               value="${venue.venueName}"
                               class="form-control"
                               placeholder="Ví dụ: UEF Hall A"
                               required>
                    </div>
                    <div class="form-text mt-1">
                        Tên hội trường, sân khấu hoặc phòng tổ chức.
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-bold">
                        Địa chỉ <span class="text-danger">*</span>
                    </label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fa-solid fa-map-location-dot" style="color:var(--pur)"></i></span>
                        <input type="text" name="address"
                               value="${venue.address}"
                               class="form-control"
                               placeholder="Ví dụ: 141 Điện Biên Phủ, Quận 3, TP.HCM"
                               required>
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-bold">Sức chứa (người)</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fa-solid fa-users" style="color:var(--pur)"></i></span>
                        <input type="number" name="capacity"
                               value="${venue.capacity}"
                               class="form-control"
                               min="0"
                               placeholder="Ví dụ: 500">
                    </div>
                    <div class="form-text mt-1">Số lượng người tối đa địa điểm có thể chứa.</div>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-bold">Mô tả</label>
                    <textarea name="description" class="form-control" rows="4"
                              placeholder="Mô tả ngắn về địa điểm, tiện ích, đặc điểm...">${venue.description}</textarea>
                </div>

                <div class="mb-5">
                    <label class="form-label fw-bold">Trạng thái</label>
                    <select name="status" class="form-select">
                        <option value="ACTIVE"   ${venue.status == 'ACTIVE'   ? 'selected' : ''}>ACTIVE — Đang hoạt động</option>
                        <option value="INACTIVE" ${venue.status == 'INACTIVE' ? 'selected' : ''}>INACTIVE — Tạm ngưng</option>
                    </select>
                </div>

                <div class="d-flex justify-content-between gap-2">
                    <a href="${ctx}/admin/venues" class="btn btn-outline-secondary">
                        <i class="fa-solid fa-arrow-left me-1"></i>Quay lại
                    </a>
                    <button type="submit" class="btn btn-danger px-4">
                        <i class="fa-solid fa-floppy-disk me-1"></i>
                        <c:choose>
                            <c:when test="${venue.id == 0}">Tạo địa điểm</c:when>
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
