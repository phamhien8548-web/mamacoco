<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div class="container py-4">

    <div class="admin-surface d-flex flex-wrap justify-content-between align-items-center gap-3 mb-4">
        <div class="admin-toolbar-title">
            <h3 class="fw-bold mb-1">Quản lý sự kiện</h3>
            <p class="text-muted small mb-0">Quản lý thông tin sự kiện, danh mục, địa điểm và hình ảnh</p>
        </div>

        <div class="admin-action-nav d-flex flex-wrap gap-2">
            <a href="${ctx}/admin/categories" class="btn btn-outline-custom">Danh mục</a>
            <a href="${ctx}/admin/venues" class="btn btn-outline-custom">Địa điểm</a>
            <a href="${ctx}/admin/schedules" class="btn btn-outline-custom">Lịch tổ chức</a>
            <a href="${ctx}/admin/ticket-types" class="btn btn-outline-custom">Loại vé</a>
            <a href="${ctx}/admin/event-images" class="btn btn-outline-custom">Ảnh sự kiện</a>
            <a href="${ctx}/admin/events/add" class="btn btn-primary fw-bold">+ Thêm sự kiện</a>
        </div>
    </div>

    <form action="${ctx}/admin/events" method="get" class="card card-body shadow-sm border-0 mb-4">
        <div class="row g-3">
            <div class="col-md-4">
                <label class="form-label fw-bold small">Từ khóa</label>
                <input type="text"
                       name="keyword"
                       value="${keyword}"
                       class="form-control"
                       placeholder="Nhập tên hoặc mô tả sự kiện">
            </div>

            <div class="col-md-3">
                <label class="form-label fw-bold small">Danh mục</label>
                <select name="categoryId" class="form-select">
                    <option value="">Tất cả danh mục</option>
                    <c:forEach var="c" items="${categories}">
                        <option value="${c.id}" ${categoryId == c.id ? 'selected' : ''}>
                            ${c.categoryName}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="col-md-3">
                <label class="form-label fw-bold small">Ngày tổ chức</label>
                <input type="date"
                       name="date"
                       value="${date}"
                       class="form-control">
            </div>

            <div class="col-md-2 d-flex align-items-end">
                <button type="submit" class="btn btn-primary w-100 fw-bold">
                    Tìm kiếm
                </button>
            </div>
        </div>

        <div class="mt-3">
            <a href="${ctx}/admin/events" class="btn btn-sm btn-link text-decoration-none text-muted p-0">
                <i class="fa-solid fa-rotate-left me-1"></i>Xóa bộ lọc
            </a>
        </div>
    </form>

    <div class="card shadow-sm border-0 overflow-hidden">
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-custom-header">
                    <tr>
                        <th scope="col" style="width: 80px;">ID</th>
                        <th scope="col" style="width: 110px;">Ảnh</th>
                        <th scope="col">Tên sự kiện</th>
                        <th scope="col" style="width: 150px;">Danh mục</th>
                        <th scope="col" style="width: 180px;">Địa điểm</th>
                        <th scope="col" style="width: 110px;">Trạng thái</th>
                        <th scope="col" style="width: 200px; text-align: center;">Thao tác</th>
                    </tr>
                </thead>

                <tbody>
                    <c:choose>
                        <c:when test="${empty events}">
                            <tr>
                                <td colspan="7" class="text-center text-muted py-5">
                                    <i class="fa-solid fa-folder-open d-block fs-3 mb-2 opacity-50"></i>
                                    Không tìm thấy sự kiện phù hợp.
                                </td>
                            </tr>
                        </c:when>

                        <c:otherwise>
                            <c:forEach var="e" items="${events}">
                                <tr>
                                    <td><strong>#${e.id}</strong></td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty e.bannerImage}">
                                                <img src="${ctx}/assets/uploads/events/${e.bannerImage}"
                                                     style="width:90px; height:55px; object-fit:cover;"
                                                     class="rounded border border-secondary border-opacity-10">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="bg-secondary bg-opacity-10 text-muted d-flex align-items-center justify-content-center rounded small"
                                                     style="width:90px; height:55px; font-size:11px;">
                                                    No Image
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td>
                                        <div class="fw-bold text-theme-primary">${e.eventName}</div>
                                        <div class="text-muted small text-truncate" style="max-width: 300px;">
                                            ${e.shortDescription}
                                        </div>
                                    </td>

                                    <td><span class="badge bg-light text-dark border">${e.categoryName}</span></td>
                                    <td><small class="fw-semibold">${e.venueName}</small></td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${e.status == 'OPEN'}">
                                                <span class="badge bg-success-subtle text-success border border-success border-opacity-25 px-2.5 py-1.5">OPEN</span>
                                            </c:when>
                                            <c:when test="${e.status == 'DRAFT'}">
                                                <span class="badge bg-secondary-subtle text-secondary border border-secondary border-opacity-25 px-2.5 py-1.5">DRAFT</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-warning-subtle text-warning border border-warning border-opacity-25 px-2.5 py-1.5">${e.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td>
                                        <div class="d-flex justify-content-center gap-1.5">
                                            <a href="${ctx}/admin/events/detail/${e.id}" class="btn btn-action-view btn-sm" title="Xem chi tiết">
                                                <i class="fa-solid fa-eye"></i> Xem
                                            </a>
                                            <a href="${ctx}/admin/events/edit/${e.id}" class="btn btn-action-edit btn-sm" title="Chỉnh sửa">
                                                <i class="fa-solid fa-pen-to-square"></i> Sửa
                                            </a>
                                            <a href="${ctx}/admin/events/delete/${e.id}"
                                               class="btn btn-action-delete btn-sm"
                                               onclick="return confirm('Bạn có chắc muốn xóa sự kiện này không?')" title="Xóa">
                                                <i class="fa-solid fa-trash-can"></i> Xóa
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>