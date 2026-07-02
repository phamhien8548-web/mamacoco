<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<div class="container py-4">

    <%-- Page header --%>
    <div class="admin-surface d-flex justify-content-between align-items-start mb-4">
        <div>
            <div class="section-kicker mb-1"><i class="fa-solid fa-location-dot me-1"></i>Quản lý địa điểm</div>
            <h2 class="page-title mb-1">Địa điểm tổ chức</h2>
            <p class="page-subtitle mb-0">Quản lý nơi diễn ra sự kiện, sức chứa và trạng thái hoạt động.</p>
        </div>
        <div class="action-buttons">
            <a href="${ctx}/admin/categories" class="btn btn-outline-secondary">
                <i class="fa-solid fa-tags me-1"></i>Danh mục
            </a>
            <a href="${ctx}/admin/venues/add" class="btn btn-danger">
                <i class="fa-solid fa-plus me-1"></i>Thêm địa điểm
            </a>
        </div>
    </div>

    <%-- Table --%>
    <div class="card overflow-hidden">
        <div class="card-body p-0">
            <c:choose>
                <c:when test="${empty venues}">
                    <div class="empty-state border-0 shadow-none m-4">
                        <i class="fa-solid fa-location-dot"></i>
                        <h3>Chưa có địa điểm nào</h3>
                        <p>Thêm địa điểm đầu tiên để gán vào sự kiện.</p>
                        <a href="${ctx}/admin/venues/add" class="btn btn-danger">
                            <i class="fa-solid fa-plus me-1"></i>Thêm địa điểm
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th style="width:70px">ID</th>
                                    <th>Tên địa điểm</th>
                                    <th>Địa chỉ</th>
                                    <th class="text-center" style="width:110px">Sức chứa</th>
                                    <th>Mô tả</th>
                                    <th class="text-center" style="width:120px">Trạng thái</th>
                                    <th class="text-center" style="width:160px">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="v" items="${venues}">
                                    <tr>
                                        <td class="align-middle fw-bold" style="color:var(--tx3)">#${v.id}</td>

                                        <td class="align-middle">
                                            <div class="fw-bold">${v.venueName}</div>
                                        </td>

                                        <td class="align-middle" style="color:var(--tx2)">
                                            <i class="fa-solid fa-location-dot me-1" style="color:var(--pur)"></i>${v.address}
                                        </td>

                                        <td class="align-middle text-center fw-bold">
                                            ${v.capacity}
                                            <span style="color:var(--tx3);font-size:.8rem"> người</span>
                                        </td>

                                        <td class="align-middle" style="color:var(--tx2);font-size:.9rem">
                                            <c:choose>
                                                <c:when test="${not empty v.description}">${v.description}</c:when>
                                                <c:otherwise><em style="color:var(--tx3)">—</em></c:otherwise>
                                            </c:choose>
                                        </td>

                                        <td class="align-middle text-center">
                                            <c:choose>
                                                <c:when test="${v.status == 'ACTIVE'}">
                                                    <span class="badge" style="background:rgba(52,211,153,.15);border:1px solid rgba(52,211,153,.3);color:#34d399;border-radius:999px;padding:5px 10px;">
                                                        <i class="fa-solid fa-circle-dot me-1"></i>ACTIVE
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge" style="background:rgba(107,114,128,.12);border:1px solid rgba(107,114,128,.25);color:var(--tx3);border-radius:999px;padding:5px 10px;">
                                                        ${v.status}
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>

                                        <td class="align-middle text-center">
                                            <div class="action-buttons justify-content-center">
                                                <a href="${ctx}/admin/venues/edit/${v.id}"
                                                   class="btn btn-warning btn-sm">
                                                    <i class="fa-solid fa-pen me-1"></i>Sửa
                                                </a>
                                                <a href="${ctx}/admin/venues/delete/${v.id}"
                                                   class="btn btn-danger btn-sm"
                                                   onclick="return confirm('Xóa địa điểm «${v.venueName}»?')">
                                                    <i class="fa-solid fa-trash me-1"></i>Xóa
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

</div>
