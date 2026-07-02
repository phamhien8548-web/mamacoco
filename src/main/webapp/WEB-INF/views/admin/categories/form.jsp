<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<div class="container py-4">
<div class="row justify-content-center">
<div class="col-lg-7">

    <div class="card">
        <div class="card-header py-4">
            <h4 class="mb-1 fw-bold theme-header-title">
                <i class="fa-solid fa-tags me-2"></i>
                <c:choose>
                    <c:when test="${category.id == 0}">Thêm danh mục sự kiện</c:when>
                    <c:otherwise>Cập nhật danh mục sự kiện</c:otherwise>
                </c:choose>
            </h4>
            <p class="mb-0 small theme-header-subtitle">
                Phân loại sự kiện để người dùng dễ tìm kiếm hơn.
            </p>
        </div>

        <div class="card-body p-4 p-lg-5">
            <form action="${ctx}/admin/categories/save" method="post">

                <input type="hidden" name="id" value="${category.id}">

                <div class="mb-4">
                    <label class="form-label fw-bold">
                        Tên danh mục <span class="text-danger">*</span>
                    </label>
                    <input type="text" name="categoryName"
                           value="${category.categoryName}"
                           class="form-control"
                           placeholder="Ví dụ: Âm nhạc, Thể thao, Hội thảo..."
                           required>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-bold">Mô tả</label>
                    <textarea name="description" class="form-control" rows="4"
                              placeholder="Mô tả ngắn về loại sự kiện này...">${category.description}</textarea>
                </div>

                <div class="mb-5">
                    <label class="form-label fw-bold">Trạng thái</label>
                    <select name="status" class="form-select">
                        <option value="ACTIVE"   ${category.status == 'ACTIVE'   ? 'selected' : ''}>ACTIVE — Đang hiển thị</option>
                        <option value="INACTIVE" ${category.status == 'INACTIVE' ? 'selected' : ''}>INACTIVE — Ẩn khỏi hệ thống</option>
                    </select>
                </div>

                <div class="d-flex justify-content-between gap-2">
                    <a href="${ctx}/admin/categories" class="btn btn-outline-secondary">
                        <i class="fa-solid fa-arrow-left me-1"></i>Quay lại
                    </a>
                    <button type="submit" class="btn btn-danger px-4">
                        <i class="fa-solid fa-floppy-disk me-1"></i>
                        <c:choose>
                            <c:when test="${category.id == 0}">Tạo danh mục</c:when>
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
