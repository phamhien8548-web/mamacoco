<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<style>
            .page-wrapper {
                max-width: 900px;
                margin: 0 auto;
            }

            .form-card {
                border: none;
                border-radius: 8px;
                box-shadow: 0 14px 40px rgba(0,0,0,0.1);
                overflow: hidden;
            }

            .form-header {
                background: #111827;
                color: white;
                padding: 28px 32px;
            }

            .form-header h3 {
                margin: 0;
                font-weight: 800;
            }

            .form-header p {
                margin: 6px 0 0;
                color: #d1d5db;
            }

            .form-body {
                padding: 32px;
                background: white;
            }

            .form-label {
                font-weight: 700;
                color: #374151;
            }

            .form-control,
            .form-select {
                border-radius: 8px;
                padding: 11px 14px;
            }

            .form-control:focus,
            .form-select:focus {
                box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.15);
            }

            .btn-custom {
                border-radius: 8px;
                padding: 10px 18px;
                font-weight: 600;
            }

            .hint {
                font-size: 13px;
                color: #6b7280;
            }
        </style>
<div class="page-wrapper">

            <div class="card form-card">

                <div class="form-header">
                    <h3>
                        <c:choose>
                            <c:when test="${venue.id == 0}">
                                Thêm địa điểm tổ chức
                            </c:when>
                            <c:otherwise>
                                Cập nhật địa điểm tổ chức
                            </c:otherwise>
                        </c:choose>
                    </h3>
                    <p>Nhập thông tin nơi diễn ra sự kiện</p>
                </div>

                <div class="form-body">

                    <form action="${ctx}/admin/venues/save" method="post">

                        <input type="hidden" name="id" value="${venue.id}">

                        <div class="mb-4">
                            <label class="form-label">Tên địa điểm</label>
                            <input type="text"
                                   name="venueName"
                                   value="${venue.venueName}"
                                   class="form-control"
                                   placeholder="Ví dụ: UEF Hall A"
                                   required>
                            <div class="hint mt-1">Tên hội trường, sân khấu, phòng tổ chức hoặc địa điểm sự kiện.</div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">Địa chỉ</label>
                            <input type="text"
                                   name="address"
                                   value="${venue.address}"
                                   class="form-control"
                                   placeholder="Ví dụ: 141 Điện Biên Phủ, TP.HCM"
                                   required>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">Sức chứa</label>
                            <input type="number"
                                   name="capacity"
                                   value="${venue.capacity}"
                                   class="form-control"
                                   min="0"
                                   placeholder="Ví dụ: 500">
                            <div class="hint mt-1">Nhập số lượng người tối đa địa điểm có thể chứa.</div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">Mô tả</label>
                            <textarea name="description"
                                      class="form-control"
                                      rows="4"
                                      placeholder="Mô tả ngắn về địa điểm">${venue.description}</textarea>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">Trạng thái</label>
                            <select name="status" class="form-select">
                                <option value="ACTIVE" ${venue.status == 'ACTIVE' ? 'selected' : ''}>
                                    ACTIVE - Đang hoạt động
                                </option>
                                <option value="INACTIVE" ${venue.status == 'INACTIVE' ? 'selected' : ''}>
                                    INACTIVE - Tạm ngưng
                                </option>
                            </select>
                        </div>

                        <div class="d-flex justify-content-between">
                            <a href="${ctx}/admin/venues" class="btn btn-outline-secondary btn-custom">
                                Quay lại
                            </a>

                            <button type="submit" class="btn btn-primary btn-custom">
                                Lưu địa điểm
                            </button>
                        </div>

                    </form>

                </div>
            </div>

        </div>
