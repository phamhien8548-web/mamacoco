<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<div class="d-flex justify-content-center align-items-center" style="min-height:70vh;">
<div class="auth-card w-100" style="max-width:440px;">

    <%-- Header --%>
    <div class="card-header text-center py-4">
        <div class="mb-2">
            <span class="logo-i brand-mark fs-2 px-3 py-2 rounded-3">
                <i class="fa-solid fa-ticket"></i>
            </span>
        </div>
        <h4 class="mb-0 fw-bold theme-header-title">Đăng nhập hệ thống</h4>
        <p class="small mb-0 mt-1 theme-header-subtitle">UEF Event Booking Platform</p>
    </div>

    <%-- Body --%>
    <div class="card-body p-4 p-lg-5">

        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-dismissible fade show mb-4" role="alert">
                <i class="fa-solid fa-circle-check me-2"></i>${successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert">
                <i class="fa-solid fa-triangle-exclamation me-2"></i>${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <form action="${ctx}/login" method="POST">

            <div class="mb-3">
                <label class="form-label fw-bold">
                    <i class="fa-solid fa-user me-1 text-purple-400"></i>Tên đăng nhập
                </label>
                <div class="input-group">
                    <span class="input-group-text">
                        <i class="fa-solid fa-at" style="color:var(--pur)"></i>
                    </span>
                    <input type="text" name="username" class="form-control"
                           placeholder="Nhập tên đăng nhập..." required autofocus />
                </div>
            </div>

            <div class="mb-4">
                <label class="form-label fw-bold">
                    <i class="fa-solid fa-lock me-1"></i>Mật khẩu
                </label>
                <div class="input-group">
                    <span class="input-group-text">
                        <i class="fa-solid fa-lock" style="color:var(--pur)"></i>
                    </span>
                    <input type="password" name="password" class="form-control"
                           placeholder="Nhập mật khẩu..." required />
                </div>
            </div>

            <div class="d-grid mb-3">
                <button type="submit" class="btn btn-danger btn-lg fw-bold">
                    <i class="fa-solid fa-arrow-right-to-bracket me-2"></i>Đăng nhập
                </button>
            </div>

            <div class="text-center border-top pt-4 mt-2">
                <span style="color:var(--tx2);">Chưa có tài khoản?</span>
                <a href="${ctx}/register" class="fw-bold ms-1" style="color:#a78bfa;">
                    Đăng ký ngay <i class="fa-solid fa-arrow-right fa-xs"></i>
                </a>
            </div>

        </form>
    </div>
</div>
</div>
