<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<div class="container py-4">

    <div class="admin-surface d-flex justify-content-between align-items-start mb-4">
        <div>
            <div class="section-kicker mb-1"><i class="fa-solid fa-clock me-1"></i>Quản lý lịch</div>
            <h2 class="page-title mb-1">Lịch tổ chức sự kiện</h2>
            <p class="page-subtitle mb-0">Quản lý thời gian bắt đầu và kết thúc của từng sự kiện.</p>
        </div>
        <div class="action-buttons">
            <a href="${ctx}/admin/events" class="btn btn-outline-secondary">
                <i class="fa-solid fa-calendar-days me-1"></i>Sự kiện
            </a>
            <a href="${ctx}/admin/schedules/add" class="btn btn-danger">
                <i class="fa-solid fa-plus me-1"></i>Thêm lịch
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
                            <th>Thời gian bắt đầu</th>
                            <th>Thời gian kết thúc</th>
                            <th>Ghi chú</th>
                            <th class="text-center" style="width:160px">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty schedules}">
                                <tr>
                                    <td colspan="6" class="py-5 text-center" style="color:var(--tx3)">
                                        <i class="fa-solid fa-clock fa-2x mb-3 d-block opacity-40"></i>
                                        Chưa có lịch nào. Nhấn "Thêm lịch" để bắt đầu.
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="s" items="${schedules}">
                                    <tr>
                                        <td class="align-middle fw-bold" style="color:var(--tx3)">#${s.id}</td>
                                        <td class="align-middle fw-bold">${s.eventName}</td>
                                        <td class="align-middle">
                                            <span class="badge" style="background:rgba(52,211,153,.15);border:1px solid rgba(52,211,153,.25);color:#34d399;border-radius:999px;padding:5px 10px;font-weight:600;">
                                                <i class="fa-solid fa-play me-1"></i>${s.startTime}
                                            </span>
                                        </td>
                                        <td class="align-middle">
                                            <span class="badge" style="background:rgba(248,113,113,.12);border:1px solid rgba(248,113,113,.22);color:#f87171;border-radius:999px;padding:5px 10px;font-weight:600;">
                                                <i class="fa-solid fa-stop me-1"></i>${s.endTime}
                                            </span>
                                        </td>
                                        <td class="align-middle" style="color:var(--tx2);font-size:.9rem">
                                            <c:choose>
                                                <c:when test="${not empty s.note}">${s.note}</c:when>
                                                <c:otherwise><em style="color:var(--tx3)">—</em></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="align-middle text-center">
                                            <div class="action-buttons justify-content-center">
                                                <a href="${ctx}/admin/schedules/edit/${s.id}"
                                                   class="btn btn-warning btn-sm">
                                                    <i class="fa-solid fa-pen me-1"></i>Sửa
                                                </a>
                                                <a href="${ctx}/admin/schedules/delete/${s.id}"
                                                   class="btn btn-danger btn-sm"
                                                   onclick="return confirm('Xóa lịch này?')">
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
