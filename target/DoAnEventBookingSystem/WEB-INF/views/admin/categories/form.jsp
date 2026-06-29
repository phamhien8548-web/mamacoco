<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div class="container py-4">

            <h3 class="mb-3">Thông tin danh mục sự kiện</h3>

            <form action="${ctx}/admin/categories/save" method="post" class="card p-4">

                <input type="hidden" name="id" value="${category.id}">

                <div class="mb-3">
                    <label class="form-label">Tên danh mục</label>
                    <input type="text" name="categoryName" value="${category.categoryName}" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Mô tả</label>
                    <textarea name="description" class="form-control" rows="4">${category.description}</textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label">Trạng thái</label>
                    <select name="status" class="form-select">
                        <option value="ACTIVE" ${category.status == 'ACTIVE' ? 'selected' : ''}>ACTIVE</option>
                        <option value="INACTIVE" ${category.status == 'INACTIVE' ? 'selected' : ''}>INACTIVE</option>
                    </select>
                </div>

                <div>
                    <button type="submit" class="btn btn-primary">Lưu</button>
                    <a href="${ctx}/admin/categories" class="btn btn-secondary">Quay lại</a>
                </div>

            </form>

        </div>
