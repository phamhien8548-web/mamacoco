<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<nav id="nbar" class="navbar navbar-expand-lg site-navbar sticky-top">
    <div class="container-fluid px-3 px-lg-4">
        <a class="navbar-brand brand-lockup" href="${ctx}/events">
            <span class="logo-i brand-mark"><i class="fa-solid fa-ticket"></i></span>
            <span>
                <span class="brand-title">UEF Tickets</span>
                <span class="brand-subtitle">Event Booking</span>
            </span>
        </a>

        <button class="navbar-toggler boc" type="button" data-bs-toggle="collapse" data-bs-target="#mainNavigation" aria-controls="mainNavigation" aria-expanded="false" aria-label="Toggle navigation">
            <i class="fa-solid fa-bars"></i>
        </button>

        <div class="collapse navbar-collapse" id="mainNavigation">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 align-items-lg-center">
                <li class="nav-item">
                    <a class="nav-link" href="${ctx}/events">
                        <i class="fa-solid fa-calendar-days me-1"></i>Sự kiện
                    </a>
                </li>

                <c:if test="${not empty sessionScope.currentUser}">
                    <li class="nav-item">
                        <a class="nav-link" href="${ctx}/user/tickets/my-bookings">
                            <i class="fa-solid fa-receipt me-1"></i>Vé của tôi
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${ctx}/profile">
                            <i class="fa-solid fa-user me-1"></i>Hồ sơ
                        </a>
                    </li>
                </c:if>

                <c:if test="${sessionScope.currentUser.role == 'ADMIN'}">
                    <li class="nav-item dropdown admin-nav">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fa-solid fa-shield-halved me-1"></i>Quản trị
                        </a>
                        <ul class="dropdown-menu admin-menu">
                            <li><a class="dropdown-item" href="${ctx}/admin/dashboard"><i class="fa-solid fa-chart-pie"></i>Tổng quan</a></li>
                            <li><a class="dropdown-item" href="${ctx}/admin/tickets/bookings"><i class="fa-solid fa-list-check"></i>Duyệt vé</a></li>
                            <li><a class="dropdown-item" href="${ctx}/admin/tickets/invoices"><i class="fa-solid fa-file-invoice-dollar"></i>Hóa đơn</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="${ctx}/admin/events"><i class="fa-solid fa-calendar-plus"></i>Sự kiện</a></li>
                            <li><a class="dropdown-item" href="${ctx}/admin/categories"><i class="fa-solid fa-tags"></i>Danh mục</a></li>
                            <li><a class="dropdown-item" href="${ctx}/admin/venues"><i class="fa-solid fa-location-dot"></i>Địa điểm</a></li>
                            <li><a class="dropdown-item" href="${ctx}/admin/schedules"><i class="fa-solid fa-clock"></i>Lịch tổ chức</a></li>
                            <li><a class="dropdown-item" href="${ctx}/admin/ticket-types"><i class="fa-solid fa-ticket-simple"></i>Loại vé</a></li>
                            <li><a class="dropdown-item" href="${ctx}/admin/event-images"><i class="fa-solid fa-images"></i>Ảnh sự kiện</a></li>
                        </ul>
                    </li>
                </c:if>
            </ul>

            <div class="nav-actions">
                <%-- Nút chuyển chế độ Tối / Sáng --%>
                <button id="thbtn" aria-label="Chuyển chế độ sáng/tối" title="Chuyển chế độ sáng/tối">
                    <i id="suni"  class="fa-solid fa-sun"  style="display:none;"></i>
                    <i id="mooni" class="fa-solid fa-moon"></i>
                </button>

                <c:choose>
                    <c:when test="${not empty sessionScope.currentUser}">
                        <span class="role-pill ${sessionScope.currentUser.role == 'ADMIN' ? 'role-admin' : 'role-user'}">
                            ${sessionScope.currentUser.role}
                        </span>
                        <span class="user-greeting">
                            <i class="fa-solid fa-circle-user"></i>
                            ${sessionScope.currentUser.fullname}
                        </span>
                        <a class="btn boc btn-sm" href="${ctx}/logout">
                            <i class="fa-solid fa-right-from-bracket me-1"></i>Đăng xuất
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a class="btn boc btn-sm" href="${ctx}/login">
                            <i class="fa-solid fa-right-to-bracket me-1"></i>Đăng nhập
                        </a>
                        <a class="btn bgrd btn-sm" href="${ctx}/register">
                            Đăng ký
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</nav>
