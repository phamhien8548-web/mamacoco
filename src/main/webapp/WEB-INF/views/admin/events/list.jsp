<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div class="container py-4">

            <div class="d-flex justify-content-between align-items-center mb-3">
                <div>
                    <h3 class="fw-bold">Quản lý sự kiện</h3>
                    <p class="text-muted mb-0">Quản lý thông tin sự kiện, danh mục, địa điểm và hình ảnh</p>
                </div>

                <div>
                    <a href="${ctx}/admin/categories" class="btn btn-outline-secondary">Danh mục</a>
                    <a href="${ctx}/admin/venues" class="btn btn-outline-secondary">Địa điểm</a>
                    <a href="${ctx}/admin/schedules" class="btn btn-outline-secondary">Lịch tổ chức</a>
                    <a href="${ctx}/admin/ticket-types" class="btn btn-outline-secondary">Loại vé</a>
                    <a href="${ctx}/admin/event-images" class="btn btn-outline-secondary">Ảnh sự kiện</a>
                    <a href="${ctx}/admin/events/add" class="btn btn-primary">+ Thêm sự kiện</a>
                </div>
            </div>

            <form action="${ctx}/admin/events" method="get" class="card card-body shadow-sm border-0 mb-4">
                <div class="row">
                    <div class="col-md-4 mb-2">
                        <label class="form-label fw-bold">Từ khóa</label>
                        <input type="text"
                               name="keyword"
                               value="${keyword}"
                               class="form-control"
                               placeholder="Nhập tên hoặc mô tả sự kiện">
                    </div>

                    <div class="col-md-3 mb-2">
                        <label class="form-label fw-bold">Danh mục</label>
                        <select name="categoryId" class="form-select">
                            <option value="">Tất cả danh mục</option>
                            <c:forEach var="c" items="${categories}">
                                <option value="${c.id}" ${categoryId == c.id ? 'selected' : ''}>
                                    ${c.categoryName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-md-3 mb-2">
                        <label class="form-label fw-bold">Ngày tổ chức</label>
                        <input type="date"
                               name="date"
                               value="${date}"
                               class="form-control">
                    </div>

                    <div class="col-md-2 mb-2 d-flex align-items-end">
                        <button type="submit" class="btn btn-primary w-100">
                            Tìm kiếm
                        </button>
                    </div>
                </div>

                <div class="mt-2">
                    <a href="${ctx}/admin/events" class="btn btn-outline-secondary btn-sm">
                        Xóa bộ lọc
                    </a>
                </div>
            </form>

            <div class="card shadow-sm border-0">
                <div class="card-body p-0">

                    <table class="table table-hover mb-0">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Ảnh</th>
                                <th>Tên sự kiện</th>
                                <th>Danh mục</th>
                                <th>Địa điểm</th>
                                <th>Trạng thái</th>
                                <th width="220">Thao tác</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:choose>
                                <c:when test="${empty events}">
                                    <tr>
                                        <td colspan="7" class="text-center text-muted py-4">
                                            Không tìm thấy sự kiện phù hợp.
                                        </td>
                                    </tr>
                                </c:when>

                                <c:otherwise>
                                    <c:forEach var="e" items="${events}">
                                        <tr>
                                            <td class="align-middle">#${e.id}</td>

                                            <td class="align-middle">
                                                <c:choose>
                                                    <c:when test="${not empty e.bannerImage}">
                                                        <img src="${ctx}/assets/uploads/events/${e.bannerImage}"
                                                             style="width:90px; height:55px; object-fit:cover;"
                                                             class="rounded">
                                                    </c:when>

                                                    <c:otherwise>
                                                        <div class="bg-secondary text-white d-flex align-items-center justify-content-center rounded"
                                                             style="width:90px; height:55px; font-size:12px;">
                                                            No Image
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>

                                            <td class="align-middle">
                                                <strong>${e.eventName}</strong>
                                                <br>
                                                <small class="text-muted">${e.shortDescription}</small>
                                            </td>

                                            <td class="align-middle">${e.categoryName}</td>
                                            <td class="align-middle">${e.venueName}</td>

                                            <td class="align-middle">
                                                <c:choose>
                                                    <c:when test="${e.status == 'OPEN'}">
                                                        <span class="badge bg-success">OPEN</span>
                                                    </c:when>

                                                    <c:when test="${e.status == 'DRAFT'}">
                                                        <span class="badge bg-secondary">DRAFT</span>
                                                    </c:when>

                                                    <c:otherwise>
                                                        <span class="badge bg-warning text-dark">${e.status}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>

                                            <td class="align-middle">
                                                <a href="${ctx}/admin/events/detail/${e.id}" class="btn btn-info btn-sm text-white">
                                                    Xem
                                                </a>

                                                <a href="${ctx}/admin/events/edit/${e.id}" class="btn btn-warning btn-sm">
                                                    Sửa
                                                </a>

                                                <a href="${ctx}/admin/events/delete/${e.id}"
                                                   class="btn btn-danger btn-sm"
                                                   onclick="return confirm('Bạn có chắc muốn xóa sự kiện này không?')">
                                                    Xóa
                                                </a>
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
