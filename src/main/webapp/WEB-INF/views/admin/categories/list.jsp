<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div class="container py-4">

            <div class="d-flex justify-content-between align-items-center mb-3">
                <h3>Quản lý danh mục sự kiện</h3>
                <a href="${ctx}/admin/categories/add" class="btn btn-primary">Thêm danh mục</a>
            </div>

            <table class="table table-bordered table-hover bg-white">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Tên danh mục</th>
                        <th>Mô tả</th>
                        <th>Trạng thái</th>
                        <th width="180">Thao tác</th>
                    </tr>
                </thead>

                <tbody>
                <c:forEach var="c" items="${categories}">
                    <tr>
                        <td>${c.id}</td>
                        <td>${c.categoryName}</td>
                        <td>${c.description}</td>
                        <td>
                            <span class="badge bg-success">${c.status}</span>
                        </td>
                        <td>
                            <a href="${ctx}/admin/categories/edit/${c.id}" class="btn btn-sm btn-warning">Sửa</a>
                            <a href="${ctx}/admin/categories/delete/${c.id}"
                               class="btn btn-sm btn-danger"
                               onclick="return confirm('Xóa danh mục này?')">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

        </div>
