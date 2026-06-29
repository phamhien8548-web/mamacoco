<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>UEF Tickets - Đặt vé sự kiện</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
        <link href="${ctx}/assets/css/custom-style.css" rel="stylesheet" type="text/css" />

        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    </head>
    <body class="app-body d-flex flex-column min-vh-100">

        <nav class="navbar navbar-expand-lg site-navbar sticky-top">
            <div class="container-fluid px-3 px-lg-4">
                <a class="navbar-brand brand-lockup" href="${ctx}/events">
                    <span class="brand-mark"><i class="fa-solid fa-ticket"></i></span>
                    <span>
                        <span class="brand-title">UEF Tickets</span>
                        <span class="brand-subtitle">Event Booking</span>
                    </span>
                </a>

                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNavigation" aria-controls="mainNavigation" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
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
                        <c:choose>
                            <c:when test="${not empty sessionScope.currentUser}">
                                <span class="role-pill ${sessionScope.currentUser.role == 'ADMIN' ? 'role-admin' : 'role-user'}">
                                    ${sessionScope.currentUser.role}
                                </span>
                                <span class="user-greeting">
                                    <i class="fa-solid fa-circle-user"></i>
                                    ${sessionScope.currentUser.fullname}
                                </span>
                                <a class="btn btn-outline-light btn-sm" href="${ctx}/logout">
                                    <i class="fa-solid fa-right-from-bracket me-1"></i>Đăng xuất
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a class="btn btn-light btn-sm fw-semibold" href="${ctx}/login">
                                    <i class="fa-solid fa-right-to-bracket me-1"></i>Đăng nhập
                                </a>
                                <a class="btn btn-warning btn-sm fw-semibold" href="${ctx}/register">
                                    Đăng ký
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </nav>

        <main class="page-shell flex-grow-1">
            <div class="container-fluid px-3 px-lg-4 py-4">
                <c:choose>
                    <c:when test="${not empty body}">
                        <jsp:include page="${body}" />
                    </c:when>
                    <c:otherwise>
                        <section class="empty-state">
                            <i class="fa-solid fa-ticket-simple"></i>
                            <h3>Chào mừng đến với UEF Tickets</h3>
                            <p>Chọn sự kiện để đặt vé hoặc đăng nhập bằng tài khoản quản trị để quản lý hệ thống.</p>
                            <a class="btn btn-danger" href="${ctx}/events">Xem sự kiện</a>
                        </section>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>

        <footer class="site-footer">
            <div class="container-fluid px-3 px-lg-4 d-flex flex-column flex-md-row justify-content-between gap-2">
                <span>© 2026 UEF Tickets</span>
                <span>Đồ án Java Spring MVC - Event Booking System</span>
            </div>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
