<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div class="container py-4">

            <div class="d-flex justify-content-between align-items-center mb-3">
                <div>
                    <h3 class="fw-bold">Quản lý ảnh sự kiện</h3>
                    <p class="text-muted mb-0">Upload ảnh và chọn banner cho từng sự kiện</p>
                </div>

                <div>
                    <a href="${ctx}/admin/events" class="btn btn-outline-secondary">Sự kiện</a>
                    <a href="${ctx}/admin/event-images/add" class="btn btn-primary">+ Thêm ảnh</a>
                </div>
            </div>

            <div class="card shadow-sm border-0">
                <div class="card-body p-0">

                    <table class="table table-hover mb-0">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Ảnh</th>
                                <th>Sự kiện</th>
                                <th>Tên file</th>
                                <th>Loại ảnh</th>
                                <th width="230">Thao tác</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:choose>
                                <c:when test="${empty images}">
                                    <tr>
                                        <td colspan="6" class="text-center text-muted py-4">
                                            Chưa có ảnh sự kiện.
                                        </td>
                                    </tr>
                                </c:when>

                                <c:otherwise>
                                    <c:forEach var="img" items="${images}">
                                        <tr>
                                            <td class="align-middle">#${img.id}</td>

                                            <td class="align-middle">
                                                <img src="${ctx}/assets/uploads/events/${img.imageUrl}"
                                                     style="width:120px; height:70px; object-fit:cover;"
                                                     class="rounded">
                                            </td>

                                            <td class="align-middle">
                                                <strong>${img.eventName}</strong>
                                            </td>

                                            <td class="align-middle">
                                                <small>${img.imageUrl}</small>
                                            </td>

                                            <td class="align-middle">
                                                <c:choose>
                                                    <c:when test="${img.banner}">
                                                        <span class="badge bg-success">Banner</span>
                                                    </c:when>

                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">Ảnh phụ</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>

                                            <td class="align-middle">
                                                <a href="${ctx}/admin/event-images/set-banner/${img.id}"
                                                   class="btn btn-warning btn-sm">
                                                    Đặt banner
                                                </a>

                                                <a href="${ctx}/admin/event-images/delete/${img.id}"
                                                   class="btn btn-danger btn-sm"
                                                   onclick="return confirm('Bạn có chắc muốn xóa ảnh này không?')">
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
