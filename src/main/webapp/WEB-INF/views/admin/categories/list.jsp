<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<div class="container py-4">

    <%-- Page header --%>
    <div class="admin-surface d-flex justify-content-between align-items-start mb-4">
        <div>
            <div class="section-kicker mb-1"><i class="fa-solid fa-tags me-1"></i>Quản lý danh mục</div>
            <h2 class="page-title mb-1">Danh mục sự kiện</h2>
            <p class="page-subtitle mb-0">Phân loại và quản lý các thể loại sự kiện trên hệ thống.</p>
        </div>
        <a href="${ctx}/admin/categories/add" class="btn btn-danger">
            <i class="fa-solid fa-plus me-1"></i>Thêm danh mục
        </a>
    </div>

    <%-- Flash messages --%>
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show mb-4">
            <i class="fa-solid fa-circle-check me-2"></i>${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <%-- Table --%>
    <div class="card overflow-hidden">
        <div class="card-body p-0">
            <table class="table table-hover mb-0">
                <thead>
                    <tr>
                        <th style="width:70px">ID</th>
                        <th>Tên danh mục</th>
                        <th>Mô tả</th>
                        <th style="width:130px" class="text-center">Trạng thái</th>
                        <th style="width:160px" class="text-center">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty categories}">
                            <tr>
                                <td colspan="5" class="py-5">
                                    <div class="text-center" style="color:var(--tx3)">
                                        <i class="fa-solid fa-tags fa-2x mb-3 d-block opacity-40"></i>
                                        Chưa có danh mục nào. Hãy thêm danh mục đầu tiên.
                                    </div>
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="c" items="${categories}">
                                <tr>
                                    <td class="align-middle fw-bold" style="color:var(--tx3)">#${c.id}</td>
                                    <td class="align-middle fw-bold">${c.categoryName}</td>
                                    <td class="align-middle" style="color:var(--tx2)">
                                        <c:choose>
                                            <c:when test="${not empty c.description}">${c.description}</c:when>
                                            <c:otherwise><em style="color:var(--tx3)">Không có mô tả</em></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="align-middle text-center">
                                        <c:choose>
                                            <c:when test="${c.status == 'ACTIVE'}">
                                                <span class="badge" style="background:rgba(52,211,153,.15);border:1px solid rgba(52,211,153,.3);color:#34d399;border-radius:999px;padding:5px 10px;">
                                                    <i class="fa-solid fa-circle-dot me-1"></i>ACTIVE
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge" style="background:rgba(107,114,128,.15);border:1px solid rgba(107,114,128,.3);color:var(--tx3);border-radius:999px;padding:5px 10px;">
                                                    ${c.status}
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="align-middle text-center">
                                        <div class="action-buttons justify-content-center">
                                            <a href="${ctx}/admin/categories/edit/${c.id}"
                                               class="btn btn-warning btn-sm">
                                                <i class="fa-solid fa-pen me-1"></i>Sửa
                                            </a>
                                            <a href="${ctx}/admin/categories/delete/${c.id}"
                                               class="btn btn-danger btn-sm"
                                               onclick="return confirm('Xóa danh mục «${c.categoryName}»?')">
                                                <i class="fa-solid fa-trash me-1"></i>Xóa
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>

</div>
