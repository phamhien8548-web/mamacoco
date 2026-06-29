<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<style>
            .page-wrapper {
                max-width: 1200px;
                margin: 0 auto;
            }

            .page-title {
                font-weight: 800;
                color: #1f2937;
            }

            .sub-title {
                color: #6b7280;
                margin-top: 4px;
            }

            .card-custom {
                border: none;
                border-radius: 8px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.08);
                overflow: hidden;
            }

            .table thead th {
                background: #111827;
                color: white;
                padding: 14px;
                font-size: 15px;
            }

            .table tbody td {
                padding: 14px;
                vertical-align: middle;
            }

            .badge-active {
                background: #16a34a;
                padding: 7px 12px;
                border-radius: 999px;
                font-size: 12px;
            }

            .badge-inactive {
                background: #6b7280;
                padding: 7px 12px;
                border-radius: 999px;
                font-size: 12px;
            }

            .btn-action {
                border-radius: 8px;
                padding: 6px 12px;
                font-size: 13px;
            }

            .top-actions {
                display: flex;
                gap: 10px;
                flex-wrap: wrap;
            }

            .empty-box {
                padding: 40px;
                text-align: center;
                color: #6b7280;
            }
        </style>
<div class="page-wrapper">

            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h2 class="page-title mb-0">Quản lý địa điểm tổ chức</h2>
                    <p class="sub-title">Quản lý nơi diễn ra sự kiện, sức chứa và trạng thái hoạt động</p>
                </div>

                <div class="top-actions">
                    <a href="${ctx}/admin/categories" class="btn btn-outline-secondary">
                        Danh mục
                    </a>

                    <a href="${ctx}/admin/venues/add" class="btn btn-primary">
                        + Thêm địa điểm
                    </a>
                </div>
            </div>

            <div class="card card-custom">
                <div class="card-body p-0">

                    <c:choose>
                        <c:when test="${empty venues}">
                            <div class="empty-box">
                                <h5>Chưa có địa điểm nào</h5>
                                <p>Hãy thêm địa điểm đầu tiên để tạo sự kiện.</p>
                                <a href="${ctx}/admin/venues/add" class="btn btn-primary">Thêm địa điểm</a>
                            </div>
                        </c:when>

                        <c:otherwise>
                            <table class="table table-hover mb-0">
                                <thead>
                                    <tr>
                                        <th width="70">ID</th>
                                        <th>Tên địa điểm</th>
                                        <th>Địa chỉ</th>
                                        <th width="120">Sức chứa</th>
                                        <th>Mô tả</th>
                                        <th width="130">Trạng thái</th>
                                        <th width="180">Thao tác</th>
                                    </tr>
                                </thead>

                                <tbody>
                                <c:forEach var="v" items="${venues}">
                                    <tr>
                                        <td>
                                            <strong>#${v.id}</strong>
                                        </td>

                                        <td>
                                            <div class="fw-bold">${v.venueName}</div>
                                            <small class="text-muted">Venue ID: ${v.id}</small>
                                        </td>

                                        <td>${v.address}</td>

                                        <td>
                                            <span class="fw-bold">${v.capacity}</span> người
                                        </td>

                                        <td>
                                    <c:choose>
                                        <c:when test="${empty v.description}">
                                            <span class="text-muted">Không có mô tả</span>
                                        </c:when>
                                        <c:otherwise>
                                            ${v.description}
                                        </c:otherwise>
                                    </c:choose>
                                    </td>

                                    <td>
                                    <c:choose>
                                        <c:when test="${v.status == 'ACTIVE'}">
                                            <span class="badge badge-active">ACTIVE</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-inactive">${v.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                    </td>

                                    <td>
                                        <a href="${ctx}/admin/venues/edit/${v.id}"
                                           class="btn btn-warning btn-sm btn-action">
                                            Sửa
                                        </a>

                                        <a href="${ctx}/admin/venues/delete/${v.id}"
                                           class="btn btn-danger btn-sm btn-action"
                                           onclick="return confirm('Bạn có chắc muốn xóa địa điểm này không?')">
                                            Xóa
                                        </a>
                                    </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </c:otherwise>
                    </c:choose>

                </div>
            </div>

        </div>
