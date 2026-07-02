<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="vi" id="htmlRoot">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>UEF Tickets - Đặt vé sự kiện</title>

        <link href="${ctx}/assets/nexusai/css/bootstrap.min.css" rel="stylesheet">
        <link href="${ctx}/assets/nexusai/css/aos.css" rel="stylesheet">
        <link href="${ctx}/assets/nexusai/css/swiper-bundle.min.css" rel="stylesheet">
        <link href="${ctx}/assets/nexusai/css/all.min.css" rel="stylesheet">
        <link href="${ctx}/assets/nexusai/css/magnific-popup.css" rel="stylesheet">
        <link href="${ctx}/assets/nexusai/css/style.css" rel="stylesheet">
        <link href="${ctx}/assets/css/custom-style.css" rel="stylesheet" type="text/css">

        <script src="${ctx}/assets/nexusai/js/chart.umd.min.js"></script>
    </head>
    <body class="app-body d-flex flex-column min-vh-100">

        <jsp:include page="header.jsp"/>

        <main class="page-shell flex-grow-1" style="padding-top: 75px;"> 
            <div class="aur aur-a app-aur app-aur-a"></div>
            <div class="aur aur-b app-aur app-aur-b"></div>

            <div class="container py-4 position-relative"> 
                <c:choose>
                    <c:when test="${not empty body}">
                        <jsp:include page="${body}" />
                    </c:when>
                    <c:otherwise>
                        <section class="empty-state rv">
                            <i class="fa-solid fa-ticket-simple"></i>
                            <h3>Chào mừng đến với UEF Tickets</h3>
                            <p>Chọn sự kiện để đặt vé hoặc đăng nhập bằng tài khoản quản trị để quản lý hệ thống.</p>
                            <a class="btn bgrd" href="${ctx}/events">Xem sự kiện</a>
                        </section>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>

        <jsp:include page="footer.jsp"/>

        <script src="${ctx}/assets/nexusai/js/jquery-3.7.1.min.js"></script>
        <script src="${ctx}/assets/nexusai/js/bootstrap.bundle.min.js"></script>
        <script src="${ctx}/assets/nexusai/js/aos.js"></script>
        <script src="${ctx}/assets/nexusai/js/jquery.magnific-popup.min.js"></script>
        <script src="${ctx}/assets/js/eventbooking-ui.js"></script>
    </body>
</html>