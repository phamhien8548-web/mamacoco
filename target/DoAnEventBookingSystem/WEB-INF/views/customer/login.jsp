<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<div class="container my-5" style="max-width: 450px;">
    <div class="card shadow border-0">
        <div class="card-header bg-primary text-white text-center py-3">
            <h4 class="mb-0 fw-bold"><i class="fa-solid fa-right-to-bracket"></i> ĐĂNG NHẬP</h4>
        </div>
        <div class="card-body p-4">
            
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success alert-dismissible fade show small" role="alert">
                    <i class="fa-solid fa-circle-check"></i> ${successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show small" role="alert">
                    <i class="fa-solid fa-triangle-exclamation"></i> ${errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="POST">
                
                <div class="mb-3">
                    <label class="form-label fw-bold text-secondary">Tên đăng nhập:</label>
                    <input type="text" name="username" class="form-control" placeholder="Nhập username..." required autofocus />
                </div>

                <div class="mb-4">
                    <label class="form-label fw-bold text-secondary">Mật khẩu:</label>
                    <input type="password" name="password" class="form-control" placeholder="Nhập mật khẩu..." required />
                </div>

                <div class="d-grid gap-2 mb-3">
                    <button type="submit" class="btn btn-primary btn-lg fw-bold shadow-sm">
                        ĐĂNG NHẬP VÀO HỆ THỐNG
                    </button>
                </div>

                <div class="text-center mt-3 border-top pt-3">
                    <span class="text-muted">Bạn chưa có tài khoản?</span>
                    <a href="${pageContext.request.contextPath}/register" class="text-decoration-none fw-bold text-primary">Đăng ký ngay</a>
                </div>
                
            </form>
        </div>
    </div>
</div>