<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<div class="container py-4">

    <div class="admin-surface d-flex justify-content-between align-items-start mb-4">
        <div>
            <div class="section-kicker mb-1"><i class="fa-solid fa-images me-1"></i>Quản lý ảnh</div>
            <h2 class="page-title mb-1">Ảnh sự kiện</h2>
            <p class="page-subtitle mb-0">Upload ảnh và thiết lập banner đại diện cho từng sự kiện.</p>
        </div>
        <div class="action-buttons">
            <a href="${ctx}/admin/events" class="btn btn-outline-secondary">
                <i class="fa-solid fa-calendar-days me-1"></i>Sự kiện
            </a>
            <a href="${ctx}/admin/event-images/add" class="btn btn-danger">
                <i class="fa-solid fa-plus me-1"></i>Thêm ảnh
            </a>
        </div>
    </div>

    <div class="card overflow-hidden">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead>
                        <tr>
                            <th style="width:60px">ID</th>
                            <th style="width:140px">Ảnh</th>
                            <th>Sự kiện</th>
                            <th>Tên file</th>
                            <th class="text-center" style="width:130px">Loại</th>
                            <th class="text-center" style="width:210px">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty images}">
                                <tr>
                                    <td colspan="6" class="py-5 text-center" style="color:var(--tx3)">
                                        <i class="fa-solid fa-image fa-2x mb-3 d-block opacity-40"></i>
                                        Chưa có ảnh sự kiện nào.
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="img" items="${images}">
                                    <tr>
                                        <td class="align-middle fw-bold" style="color:var(--tx3)">#${img.id}</td>
                                        <td class="align-middle">
                                            <img src="${ctx}/assets/uploads/events/${img.imageUrl}"
                                                 style="width:120px;height:70px;object-fit:cover;border-radius:8px;border:1px solid var(--bd);"
                                                 alt="${img.eventName}">
                                        </td>
                                        <td class="align-middle fw-bold">${img.eventName}</td>
                                        <td class="align-middle">
                                            <code>${img.imageUrl}</code>
                                        </td>
                                        <td class="align-middle text-center">
                                            <c:choose>
                                                <c:when test="${img.banner}">
                                                    <span class="badge" style="background:rgba(251,191,36,.15);border:1px solid rgba(251,191,36,.3);color:#fbbf24;border-radius:999px;padding:5px 12px;">
                                                        <i class="fa-solid fa-star me-1"></i>Banner
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge" style="background:rgba(107,114,128,.12);border:1px solid rgba(107,114,128,.25);color:var(--tx3);border-radius:999px;padding:5px 12px;">
                                                        Ảnh phụ
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="align-middle text-center">
                                            <div class="action-buttons justify-content-center">
                                                <a href="${ctx}/admin/event-images/set-banner/${img.id}"
                                                   class="btn btn-outline-secondary btn-sm"
                                                   title="Đặt làm banner">
                                                    <i class="fa-solid fa-star"></i>
                                                </a>
                                                <a href="${ctx}/admin/event-images/edit/${img.id}"
                                                   class="btn btn-warning btn-sm">
                                                    <i class="fa-solid fa-pen me-1"></i>Sửa
                                                </a>
                                                <a href="${ctx}/admin/event-images/delete/${img.id}"
                                                   class="btn btn-danger btn-sm"
                                                   onclick="return confirm('Xóa ảnh này?')">
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

</div>
