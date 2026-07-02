<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<div class="row justify-content-center py-4">
<div class="col-lg-7 col-md-9">

    <%-- Back button --%>
    <a href="${ctx}/events" class="btn btn-outline-secondary mb-4">
        <i class="fa-solid fa-arrow-left me-1"></i>Về trang sự kiện
    </a>

    <div class="card overflow-hidden">

        <%-- Profile header --%>
        <div class="card-header text-center py-5">
            <div class="mb-3">
                <span class="profile-avatar rounded-circle d-inline-flex align-items-center justify-content-center">
                    <i class="fa-solid fa-circle-user fa-3x"></i>
                </span>
            </div>
            <h3 class="mb-1 fw-bold theme-header-title">${sessionScope.currentUser.fullname}</h3>
            <p class="mb-2 theme-header-subtitle">
                <i class="fa-solid fa-id-badge me-1"></i>@${sessionScope.currentUser.username}
            </p>
            <c:choose>
                <c:when test="${sessionScope.currentUser.role == 'ADMIN'}">
                    <span class="role-pill role-admin">
                        <i class="fa-solid fa-shield-halved me-1"></i>Quản trị viên
                    </span>
                </c:when>
                <c:otherwise>
                    <span class="role-pill role-user">
                        <i class="fa-solid fa-user me-1"></i>Khách hàng
                    </span>
                </c:otherwise>
            </c:choose>
        </div>

        <%-- Profile body --%>
        <div class="card-body p-4 p-lg-5">

            <%-- Contact info --%>
            <h6 class="section-kicker mb-3">
                <i class="fa-solid fa-address-card me-1"></i>Thông tin liên hệ
            </h6>
            <div class="row g-3 mb-4">
                <div class="col-md-6">
                    <div class="info-tile">
                        <div class="small fw-bold mb-1" style="color:var(--tx3);text-transform:uppercase;letter-spacing:.04em;">
                            <i class="fa-solid fa-envelope me-1"></i>Email
                        </div>
                        <div class="fw-bold">${sessionScope.currentUser.email}</div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="info-tile">
                        <div class="small fw-bold mb-1" style="color:var(--tx3);text-transform:uppercase;letter-spacing:.04em;">
                            <i class="fa-solid fa-phone me-1"></i>Điện thoại
                        </div>
                        <div class="fw-bold">
                            <c:choose>
                                <c:when test="${not empty sessionScope.currentUser.phone}">
                                    ${sessionScope.currentUser.phone}
                                </c:when>
                                <c:otherwise>
                                    <em style="color:var(--tx3);">Chưa cập nhật</em>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>

            <%-- System info --%>
            <h6 class="section-kicker mb-3">
                <i class="fa-solid fa-shield-halved me-1"></i>Thông tin hệ thống
            </h6>
            <div class="row g-3 mb-5">
                <div class="col-md-6">
                    <div class="info-tile">
                        <div class="small fw-bold mb-2" style="color:var(--tx3);text-transform:uppercase;letter-spacing:.04em;">
                            Quyền hạn
                        </div>
                        <c:choose>
                            <c:when test="${sessionScope.currentUser.role == 'ADMIN'}">
                                <span class="badge" style="background:rgba(251,191,36,.2);border:1px solid rgba(251,191,36,.4);color:#fbbf24;padding:6px 12px;font-size:.85rem;">
                                    <i class="fa-solid fa-user-shield me-1"></i>Quản trị viên
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge" style="background:rgba(52,211,153,.15);border:1px solid rgba(52,211,153,.3);color:#34d399;padding:6px 12px;font-size:.85rem;">
                                    <i class="fa-solid fa-user me-1"></i>Khách hàng
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="info-tile">
                        <div class="small fw-bold mb-2" style="color:var(--tx3);text-transform:uppercase;letter-spacing:.04em;">
                            Trạng thái
                        </div>
                        <c:choose>
                            <c:when test="${sessionScope.currentUser.status == 'ACTIVE'}">
                                <span class="badge" style="background:rgba(52,211,153,.15);border:1px solid rgba(52,211,153,.3);color:#34d399;padding:6px 12px;font-size:.85rem;">
                                    <i class="fa-solid fa-circle-check me-1"></i>Hoạt động
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge" style="background:rgba(248,113,113,.15);border:1px solid rgba(248,113,113,.3);color:#f87171;padding:6px 12px;font-size:.85rem;">
                                    <i class="fa-solid fa-lock me-1"></i>Đang bị khóa
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <%-- CTA --%>
            <div class="d-grid gap-2">
                <a href="${ctx}/user/tickets/my-bookings" class="btn btn-danger btn-lg fw-bold">
                    <i class="fa-solid fa-clock-rotate-left me-2"></i>Xem lịch sử đặt vé
                </a>
                <c:if test="${sessionScope.currentUser.role == 'ADMIN'}">
                    <a href="${ctx}/admin/dashboard" class="btn btn-outline-secondary">
                        <i class="fa-solid fa-shield-halved me-1"></i>Vào trang quản trị
                    </a>
                </c:if>
            </div>

        </div>
    </div>
</div>
</div>
