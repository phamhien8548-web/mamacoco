<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div class="container py-4">

            <div class="d-flex justify-content-between align-items-center mb-3">
                <div>
                    <h3 class="fw-bold">Quản lý loại vé</h3>
                    <p class="text-muted mb-0">Quản lý tên vé, giá vé, số lượng vé theo từng sự kiện</p>
                </div>

                <div>
                    <a href="${ctx}/admin/events" class="btn btn-outline-secondary">Sự kiện</a>
                    <a href="${ctx}/admin/schedules" class="btn btn-outline-secondary">Lịch tổ chức</a>
                    <a href="${ctx}/admin/ticket-types/add" class="btn btn-primary">+ Thêm loại vé</a>
                </div>
            </div>

            <div class="card shadow-sm border-0">
                <div class="card-body p-0">

                    <table class="table table-hover mb-0">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Sự kiện</th>
                                <th>Tên vé</th>
                                <th>Giá vé</th>
                                <th>Tổng SL</th>
                                <th>Đã bán</th>
                                <th>Còn lại</th>
                                <th>Trạng thái</th>
                                <th width="180">Thao tác</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:forEach var="t" items="${ticketTypes}">
                                <tr>
                                    <td class="align-middle">#${t.id}</td>
                                    <td class="align-middle">
                                        <strong>${t.eventName}</strong>
                                    </td>
                                    <td class="align-middle">${t.ticketName}</td>
                                    <td class="align-middle">${t.price} VNĐ</td>
                                    <td class="align-middle">${t.totalQuantity}</td>
                                    <td class="align-middle">${t.soldQuantity}</td>
                                    <td class="align-middle">
                                        <span class="badge bg-info text-dark">${t.remainingQuantity}</span>
                                    </td>
                                    <td class="align-middle">
                                        <span class="badge bg-success">${t.status}</span>
                                    </td>
                                    <td class="align-middle">
                                        <a href="${ctx}/admin/ticket-types/edit/${t.id}" class="btn btn-warning btn-sm">Sửa</a>
                                        <a href="${ctx}/admin/ticket-types/delete/${t.id}"
                                           class="btn btn-danger btn-sm"
                                           onclick="return confirm('Bạn có chắc muốn xóa loại vé này không?')">
                                            Xóa
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>

                    </table>

                </div>
            </div>

        </div>
