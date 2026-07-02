<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-lg-7">

            <div class="card">
                <div class="card-header py-4">
                    <%-- Đổi tiêu đề Form động --%>
                    <h4 class="mb-1 fw-bold theme-header-title">
                        <i class="fa-solid fa-images me-2"></i>
                        ${image.id == 0 ? 'Thêm mới ảnh sự kiện' : 'Chỉnh sửa ảnh sự kiện'}
                    </h4>
                    <p class="mb-0 small theme-header-subtitle">
                        ${image.id == 0 ? 'Tải lên ảnh mới cho sự kiện.' : 'Thay ảnh hoặc thay đổi cài đặt banner.'}
                    </p>
                </div>

                <div class="card-body p-4 p-lg-5">
                    <%-- ĐỔI ACTION ĐỘNG: Nếu id == 0 thì chạy /save, ngược lại chạy /update --%>
                    <form action="${ctx}/admin/event-images/${image.id == 0 ? 'save' : 'update'}"
                          method="post"
                          enctype="multipart/form-data">

                        <input type="hidden" name="id" value="${image.id}" />

                        <div class="mb-4">
                            <label class="form-label fw-bold">
                                Sự kiện <span class="text-danger">*</span>
                            </label>
                            <select name="eventId" class="form-select" required>
                                <option value="">— Chọn sự kiện —</option>
                                <c:forEach var="e" items="${events}">
                                    <option value="${e.id}" ${e.id == image.eventId ? 'selected' : ''}>
                                        ${e.eventName}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <%-- Current image preview --%>
                        <div class="mb-4">
                            <label class="form-label fw-bold">Ảnh hiện tại</label>
                            <div class="p-2 rounded" style="background:var(--bg3);border:1px solid var(--bd);display:inline-block;">
                                <img src="${ctx}/assets/uploads/events/${image.imageUrl}"
                                     class="rounded"
                                     style="max-height:160px;max-width:100%;object-fit:cover;display:block;">
                            </div>
                            <div class="form-text mt-1">File: <code>${image.imageUrl}</code></div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-bold">
                                <i class="fa-solid fa-upload me-1" style="color:var(--pur)"></i>Chọn ảnh mới
                            </label>
                            <input type="file" name="imageFile" class="form-control" accept="image/*">
                            <div class="form-text">Để trống nếu muốn giữ nguyên ảnh cũ.</div>
                        </div>

                        <div class="mb-5">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox"
                                       name="banner" value="true"
                                       id="banner" ${image.banner ? 'checked' : ''}>
                                <label class="form-check-label fw-bold" for="banner">
                                    <i class="fa-solid fa-star me-1" style="color:#fbbf24"></i>
                                    Đặt ảnh này làm banner sự kiện (ảnh đại diện)
                                </label>
                            </div>
                        </div>

                        <div class="d-flex justify-content-between gap-2">
                            <a href="${ctx}/admin/event-images" class="btn btn-outline-secondary">
                                <i class="fa-solid fa-arrow-left me-1"></i>Quay lại
                            </a>
                            <button type="submit" class="btn btn-danger px-4">
                                <i class="fa-solid fa-floppy-disk me-1"></i>
                                ${image.id == 0 ? 'Lưu ảnh mới' : 'Cập nhật ảnh'}
                            </button>
                        </div>

                    </form>
                </div>
            </div>

        </div>
    </div>
</div>
