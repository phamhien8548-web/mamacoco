<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<div class="container py-5" style="max-width: 700px;">
    
    <a href="${pageContext.request.contextPath}/events" class="btn btn-secondary mb-4 shadow-sm">
        <i class="fa-solid fa-arrow-left"></i> Quay lại trang chủ
    </a>

    <div class="card shadow border-0 rounded-4 overflow-hidden">
        <div class="card-header bg-primary text-white text-center py-4">
            <div class="mb-2">
                <i class="fa-solid fa-circle-user fa-5x"></i>
            </div>
            <h3 class="mb-0 fw-bold">${sessionScope.currentUser.fullname}</h3>
            <p class="mb-0 mt-1 opacity-75">
                <i class="fa-solid fa-id-badge"></i> @${sessionScope.currentUser.username}
            </p>
        </div>

        <div class="card-body p-5 bg-light">
            <h5 class="text-primary border-bottom pb-2 mb-4">
                <i class="fa-solid fa-address-card"></i> Thông tin liên hệ
            </h5>

            <div class="row mb-4">
                <div class="col-md-6 mb-3 mb-md-0">
                    <span class="text-muted d-block small fw-bold text-uppercase">Địa chỉ Email</span>
                    <span class="fs-5">${sessionScope.currentUser.email}</span>
                </div>
                <div class="col-md-6">
                    <span class="text-muted d-block small fw-bold text-uppercase">Số điện thoại</span>
                    <span class="fs-5">
                        <c:choose>
                            <c:when test="${not empty sessionScope.currentUser.phone}">
                                ${sessionScope.currentUser.phone}
                            </c:when>
                            <c:otherwise>
                                <em class="text-secondary">Chưa cập nhật</em>
                            </c:otherwise>
                        </c:choose>
                    </span>
                </div>
            </div>

            <h5 class="text-primary border-bottom pb-2 mb-4">
                <i class="fa-solid fa-shield-halved"></i> Thông tin hệ thống
            </h5>

            <div class="row">
                <div class="col-md-6 mb-3 mb-md-0">
                    <span class="text-muted d-block small fw-bold text-uppercase">Quyền hạn (Role)</span>
                    <c:choose>
                        <c:when test="${sessionScope.currentUser.role == 'ADMIN'}">
                            <span class="badge bg-danger fs-6 px-3 py-2"><i class="fa-solid fa-user-shield"></i> QUẢN TRỊ VIÊN</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge bg-secondary fs-6 px-3 py-2"><i class="fa-solid fa-user"></i> KHÁCH HÀNG</span>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="col-md-6">
                    <span class="text-muted d-block small fw-bold text-uppercase">Trạng thái tài khoản</span>
                    <c:choose>
                        <c:when test="${sessionScope.currentUser.status == 'ACTIVE'}">
                            <span class="badge bg-success fs-6 px-3 py-2"><i class="fa-solid fa-circle-check"></i> HOẠT ĐỘNG TỐT</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge bg-warning text-dark fs-6 px-3 py-2"><i class="fa-solid fa-lock"></i> ĐANG BỊ KHÓA</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="mt-5 text-center">
                <a href="${pageContext.request.contextPath}/user/tickets/my-bookings" class="btn btn-outline-primary fw-bold shadow-sm px-4">
                    <i class="fa-solid fa-clock-rotate-left"></i> Xem lịch sử đặt vé của tôi
                </a>
            </div>

        </div>
    </div>
</div>
