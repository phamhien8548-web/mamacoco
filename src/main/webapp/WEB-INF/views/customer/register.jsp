<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<div class="d-flex justify-content-center align-items-center py-4">
<div class="auth-card w-100" style="max-width:560px;">

    <%-- Header --%>
    <div class="card-header text-center py-4">
        <div class="mb-2">
            <span class="logo-i brand-mark fs-2 px-3 py-2 rounded-3">
                <i class="fa-solid fa-user-plus"></i>
            </span>
        </div>
        <h4 class="mb-0 fw-bold theme-header-title">Tạo tài khoản mới</h4>
        <p class="small mb-0 mt-1 theme-header-subtitle">Tham gia UEF Event Booking ngay hôm nay</p>
    </div>

    <%-- Body --%>
    <div class="card-body p-4 p-lg-5">

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert">
                <i class="fa-solid fa-circle-xmark me-2"></i><strong>Lỗi:</strong> ${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <form:form action="${ctx}/register" method="POST" modelAttribute="user">

            <div class="row g-3 mb-1">
                <div class="col-md-6">
                    <label class="form-label fw-bold">Tên đăng nhập <span class="text-danger">*</span></label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fa-solid fa-at" style="color:var(--pur)"></i></span>
                        <form:input path="username" class="form-control" placeholder="Viết liền không dấu..." />
                    </div>
                    <form:errors path="username" cssClass="text-danger small mt-1 d-block" />
                </div>

                <div class="col-md-6">
                    <label class="form-label fw-bold">Mật khẩu <span class="text-danger">*</span></label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fa-solid fa-lock" style="color:var(--pur)"></i></span>
                        <form:password path="password" class="form-control" placeholder="Tạo mật khẩu bảo mật..." />
                    </div>
                    <form:errors path="password" cssClass="text-danger small mt-1 d-block" />
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">Họ và Tên đầy đủ <span class="text-danger">*</span></label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa-solid fa-id-card" style="color:var(--pur)"></i></span>
                    <form:input path="fullname" class="form-control" placeholder="Ví dụ: Nguyễn Văn A" />
                </div>
                <form:errors path="fullname" cssClass="text-danger small mt-1 d-block" />
            </div>

            <div class="row g-3 mb-4">
                <div class="col-md-6">
                    <label class="form-label fw-bold">Email <span class="text-danger">*</span></label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fa-solid fa-envelope" style="color:var(--pur)"></i></span>
                        <form:input path="email" type="email" class="form-control" placeholder="abc@gmail.com" />
                    </div>
                    <form:errors path="email" cssClass="text-danger small mt-1 d-block" />
                </div>

                <div class="col-md-6">
                    <label class="form-label fw-bold">Số điện thoại</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fa-solid fa-phone" style="color:var(--pur)"></i></span>
                        <form:input path="phone" class="form-control" placeholder="09xx xxx xxx" />
                    </div>
                    <form:errors path="phone" cssClass="text-danger small mt-1 d-block" />
                </div>
            </div>

            <div class="d-grid mb-3">
                <button type="submit" class="btn btn-success btn-lg fw-bold">
                    <i class="fa-solid fa-circle-check me-2"></i>Hoàn tất đăng ký
                </button>
            </div>

            <div class="text-center border-top pt-4">
                <span style="color:var(--tx2);">Đã có tài khoản rồi?</span>
                <a href="${ctx}/login" class="fw-bold ms-1" style="color:#a78bfa;">
                    Đăng nhập ngay <i class="fa-solid fa-arrow-right fa-xs"></i>
                </a>
            </div>

        </form:form>
    </div>
</div>
</div>
