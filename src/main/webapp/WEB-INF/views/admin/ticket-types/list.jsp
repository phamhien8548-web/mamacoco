<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<div class="container py-4">

    <div class="admin-surface d-flex justify-content-between align-items-start mb-4">
        <div>
            <div class="section-kicker mb-1"><i class="fa-solid fa-ticket-simple me-1"></i>Quản lý loại vé</div>
            <h2 class="page-title mb-1">Loại vé sự kiện</h2>
            <p class="page-subtitle mb-0">Quản lý tên vé, giá bán và số lượng phát hành theo sự kiện.</p>
        </div>
        <div class="action-buttons">
            <a href="${ctx}/admin/events"    class="btn btn-outline-secondary"><i class="fa-solid fa-calendar-days me-1"></i>Sự kiện</a>
            <a href="${ctx}/admin/schedules" class="btn btn-outline-secondary"><i class="fa-solid fa-clock me-1"></i>Lịch</a>
            <a href="${ctx}/admin/ticket-types/add" class="btn btn-danger">
                <i class="fa-solid fa-plus me-1"></i>Thêm loại vé
            </a>
        </div>
    </div>

    <div class="card overflow-hidden">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead>
                        <tr>
                            <th style="width:70px">ID</th>
                            <th>Sự kiện</th>
                            <th>Tên vé</th>
                            <th class="text-end">Giá vé</th>
                            <th class="text-center">Tổng SL</th>
                            <th class="text-center">Đã bán</th>
                            <th class="text-center">Còn lại</th>
                            <th class="text-center">Trạng thái</th>
                            <th class="text-center" style="width:160px">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty ticketTypes}">
                                <tr>
                                    <td colspan="9" class="py-5 text-center" style="color:var(--tx3)">
                                        <i class="fa-solid fa-ticket-simple fa-2x mb-3 d-block opacity-40"></i>
                                        Chưa có loại vé nào.
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="t" items="${ticketTypes}">
                                    <tr>
                                        <td class="align-middle fw-bold" style="color:var(--tx3)">#${t.id}</td>
                                        <td class="align-middle fw-bold">${t.eventName}</td>
                                        <td class="align-middle">${t.ticketName}</td>
                                        <td class="align-middle text-end fw-bold" style="color:#a78bfa;">
                                            <fmt:formatNumber value="${t.price}" type="number"/> đ
                                        </td>
                                        <td class="align-middle text-center">${t.totalQuantity}</td>
                                        <td class="align-middle text-center" style="color:#f87171;">${t.soldQuantity}</td>
                                        <td class="align-middle text-center">
                                            <span class="badge" style="background:rgba(96,165,250,.15);border:1px solid rgba(96,165,250,.25);color:#60a5fa;border-radius:999px;padding:4px 10px;">
                                                ${t.remainingQuantity}
                                            </span>
                                        </td>
                                        <td class="align-middle text-center">
                                            <c:choose>
                                                <c:when test="${t.status == 'OPEN'}">
                                                    <span class="badge" style="background:rgba(52,211,153,.15);border:1px solid rgba(52,211,153,.3);color:#34d399;border-radius:999px;padding:4px 10px;">
                                                        <i class="fa-solid fa-circle-dot me-1"></i>OPEN
                                                    </span>
                                                </c:when>
                                                <c:when test="${t.status == 'SOLD_OUT'}">
                                                    <span class="badge" style="background:rgba(248,113,113,.12);border:1px solid rgba(248,113,113,.22);color:#f87171;border-radius:999px;padding:4px 10px;">
                                                        <i class="fa-solid fa-ban me-1"></i>SOLD OUT
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge" style="background:rgba(107,114,128,.12);border:1px solid rgba(107,114,128,.25);color:var(--tx3);border-radius:999px;padding:4px 10px;">
                                                        ${t.status}
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="align-middle text-center">
                                            <div class="action-buttons justify-content-center">
                                                <a href="${ctx}/admin/ticket-types/edit/${t.id}"
                                                   class="btn btn-warning btn-sm">
                                                    <i class="fa-solid fa-pen me-1"></i>Sửa
                                                </a>
                                                <a href="${ctx}/admin/ticket-types/delete/${t.id}"
                                                   class="btn btn-danger btn-sm"
                                                   onclick="return confirm('Xóa loại vé «${t.ticketName}»?')">
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
