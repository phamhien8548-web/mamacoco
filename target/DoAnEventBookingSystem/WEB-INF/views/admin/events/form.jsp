<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<div class="container py-4">
<div class="row justify-content-center">
<div class="col-lg-9">

    <div class="card">

        <div class="card-header py-4">
            <h4 class="mb-1 fw-bold theme-header-title">
                <i class="fa-solid fa-calendar-plus me-2"></i>
                <c:choose>
                    <c:when test="${event.id == 0}">Thêm sự kiện mới</c:when>
                    <c:otherwise>Cập nhật sự kiện</c:otherwise>
                </c:choose>
            </h4>
            <p class="mb-0 small theme-header-subtitle">
                Điền đầy đủ thông tin sự kiện để hiển thị trên hệ thống.
            </p>
        </div>

        <div class="card-body p-4 p-lg-5">
            <form action="${ctx}/admin/events/save" method="post" enctype="multipart/form-data">

                <input type="hidden" name="id" value="${event.id}">
                <input type="hidden" name="oldBannerImage" value="${event.bannerImage}">

                <%-- Event name --%>
                <div class="mb-4">
                    <label class="form-label fw-bold">
                        Tên sự kiện <span class="text-danger">*</span>
                    </label>
                    <input type="text" name="eventName"
                           value="${event.eventName}"
                           class="form-control"
                           placeholder="Ví dụ: UEF Music Night 2026"
                           required>
                </div>

                <%-- Category + Venue --%>
                <div class="row g-3 mb-4">
                    <div class="col-md-6">
                        <label class="form-label fw-bold">
                            Danh mục <span class="text-danger">*</span>
                        </label>
                        <select name="categoryId" class="form-select" required>
                            <option value="">— Chọn danh mục —</option>
                            <c:forEach var="c" items="${categories}">
                                <option value="${c.id}" ${event.categoryId == c.id ? 'selected' : ''}>
                                    ${c.categoryName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-bold">
                            Địa điểm <span class="text-danger">*</span>
                        </label>
                        <select name="venueId" class="form-select" required>
                            <option value="">— Chọn địa điểm —</option>
                            <c:forEach var="v" items="${venues}">
                                <option value="${v.id}" ${event.venueId == v.id ? 'selected' : ''}>
                                    ${v.venueName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <%-- Short description --%>
                <div class="mb-4">
                    <label class="form-label fw-bold">Mô tả ngắn</label>
                    <input type="text" name="shortDescription"
                           value="${event.shortDescription}"
                           class="form-control"
                           placeholder="Dòng giới thiệu ngắn hiển thị trên thẻ sự kiện">
                </div>

                <%-- Full description --%>
                <div class="mb-4">
                    <label class="form-label fw-bold">Mô tả chi tiết</label>
                    <textarea name="description" class="form-control" rows="6"
                              placeholder="Nội dung đầy đủ về sự kiện, chương trình, khách mời...">${event.description}</textarea>
                </div>

                <%-- Banner upload --%>
                <div class="mb-4">
                    <label class="form-label fw-bold">
                        <i class="fa-solid fa-image me-1" style="color:var(--pur)"></i>Banner sự kiện
                    </label>
                    <input type="file" name="bannerFile" class="form-control" accept="image/*">
                    <div class="form-text">Chấp nhận JPG, PNG. Tỉ lệ khuyến nghị 16:9.</div>
                    <c:if test="${not empty event.bannerImage}">
                        <div class="mt-3">
                            <p class="form-text mb-2">Ảnh banner hiện tại:</p>
                            <img src="${ctx}/assets/uploads/events/${event.bannerImage}"
                                 style="width:220px;height:124px;object-fit:cover;border-radius:10px;border:1px solid var(--bd);">
                        </div>
                    </c:if>
                </div>

                <%-- Status --%>
                <div class="mb-5">
                    <label class="form-label fw-bold">Trạng thái</label>
                    <select name="status" class="form-select">
                        <option value="DRAFT"     ${event.status == 'DRAFT'     ? 'selected' : ''}>DRAFT — Bản nháp</option>
                        <option value="OPEN"      ${event.status == 'OPEN'      ? 'selected' : ''}>OPEN — Đang mở bán vé</option>
                        <option value="SOLD_OUT"  ${event.status == 'SOLD_OUT'  ? 'selected' : ''}>SOLD_OUT — Hết vé</option>
                        <option value="COMPLETED" ${event.status == 'COMPLETED' ? 'selected' : ''}>COMPLETED — Đã kết thúc</option>
                        <option value="CANCELLED" ${event.status == 'CANCELLED' ? 'selected' : ''}>CANCELLED — Đã hủy</option>
                    </select>
                </div>

                <div class="d-flex justify-content-between gap-2">
                    <a href="${ctx}/admin/events" class="btn btn-outline-secondary">
                        <i class="fa-solid fa-arrow-left me-1"></i>Quay lại
                    </a>
                    <button type="submit" class="btn btn-danger px-4">
                        <i class="fa-solid fa-floppy-disk me-1"></i>
                        <c:choose>
                            <c:when test="${event.id == 0}">Tạo sự kiện</c:when>
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
