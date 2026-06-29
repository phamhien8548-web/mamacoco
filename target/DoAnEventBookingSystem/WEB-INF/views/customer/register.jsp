<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<div class="container my-5" style="max-width: 550px;">
    <div class="card shadow border-0">
        <div class="card-header bg-success text-white text-center py-3">
            <h4 class="mb-0 fw-bold"><i class="fa-solid fa-user-plus"></i> ĐĂNG KÝ TÀI KHOẢN</h4>
        </div>
        <div class="card-body p-4">
            
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show small" role="alert">
                    <i class="fa-solid fa-circle-xmark"></i> <strong>Lỗi:</strong> ${errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <form:form action="${pageContext.request.contextPath}/register" method="POST" modelAttribute="user">
                
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold text-secondary">Tên đăng nhập <span class="text-danger">*</span></label>
                        <form:input path="username" class="form-control" placeholder="Viết liền không dấu..." />
                        <form:errors path="username" cssClass="text-danger small mt-1 d-block" />
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold text-secondary">Mật khẩu <span class="text-danger">*</span></label>
                        <form:password path="password" class="form-control" placeholder="Tạo mật khẩu..." />
                        <form:errors path="password" cssClass="text-danger small mt-1 d-block" />
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold text-secondary">Họ và Tên đầy đủ <span class="text-danger">*</span></label>
                    <form:input path="fullname" class="form-control" placeholder="Ví dụ: Nguyễn Văn A..." />
                    <form:errors path="fullname" cssClass="text-danger small mt-1 d-block" />
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold text-secondary">Địa chỉ Email <span class="text-danger">*</span></label>
                        <form:input path="email" type="email" class="form-control" placeholder="abc@gmail.com" />
                        <form:errors path="email" cssClass="text-danger small mt-1 d-block" />
                    </div>

                    <div class="col-md-6 mb-4">
                        <label class="form-label fw-bold text-secondary">Số điện thoại</label>
                        <form:input path="phone" class="form-control" placeholder="Nhập số điện thoại..." />
                        <form:errors path="phone" cssClass="text-danger small mt-1 d-block" />
                    </div>
                </div>

                <div class="d-grid gap-2 mb-3">
                    <button type="submit" class="btn btn-success btn-lg fw-bold shadow-sm">
                        <i class="fa-solid fa-check"></i> HOÀN TẤT ĐĂNG KÝ
                    </button>
                </div>

                <div class="text-center mt-3 border-top pt-3">
                    <span class="text-muted">Bạn đã có tài khoản rồi?</span>
                    <a href="${pageContext.request.contextPath}/login" class="text-decoration-none fw-bold text-success">Đăng nhập ngay</a>
                </div>
                
            </form:form>
            
        </div>
    </div>
</div>