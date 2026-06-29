<%-- 
    Document   : form
    Created on : Jun 12, 2026, 11:21:09 PM
    Author     : LENOVO
--%>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div class="container py-4">

            <div class="card shadow-sm border-0">
                <div class="card-header bg-dark text-white">
                    <h4 class="mb-0">Thêm ảnh sự kiện</h4>
                </div>

                <div class="card-body">

                    <form action="${ctx}/admin/event-images/save"
                          method="post"
                          enctype="multipart/form-data">

                        <div class="mb-3">
                            <label class="form-label fw-bold">Sự kiện</label>
                            <select name="eventId" class="form-select" required>
                                <option value="">-- Chọn sự kiện --</option>

                                <c:forEach var="e" items="${events}">
                                    <option value="${e.id}">
                                        ${e.eventName}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Chọn ảnh</label>
                            <input type="file"
                                   name="imageFile"
                                   class="form-control"
                                   accept="image/*"
                                   required>
                        </div>

                        <div class="form-check mb-4">
                            <input class="form-check-input"
                                   type="checkbox"
                                   name="banner"
                                   value="true"
                                   id="banner">
                            <label class="form-check-label" for="banner">
                                Đặt ảnh này làm banner sự kiện
                            </label>
                        </div>

                        <div class="d-flex justify-content-between">
                            <a href="${ctx}/admin/event-images" class="btn btn-secondary">
                                Quay lại
                            </a>

                            <button type="submit" class="btn btn-primary">
                                Lưu ảnh
                            </button>
                        </div>

                    </form>

                </div>
            </div>

        </div>
