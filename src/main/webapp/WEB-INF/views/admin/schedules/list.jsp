<%-- 
    Document   : list
    Created on : Jun 12, 2026, 10:20:41 PM
    Author     : LENOVO
--%>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div class="container py-4">

            <div class="d-flex justify-content-between align-items-center mb-3">
                <div>
                    <h3 class="fw-bold">Quản lý lịch tổ chức</h3>
                    <p class="text-muted mb-0">Quản lý thời gian bắt đầu, kết thúc của từng sự kiện</p>
                </div>

                <div>
                    <a href="${ctx}/admin/events" class="btn btn-outline-secondary">Sự kiện</a>
                    <a href="${ctx}/admin/schedules/add" class="btn btn-primary">+ Thêm lịch</a>
                </div>
            </div>

            <div class="card shadow-sm border-0">
                <div class="card-body p-0">

                    <table class="table table-hover mb-0">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Sự kiện</th>
                                <th>Bắt đầu</th>
                                <th>Kết thúc</th>
                                <th>Ghi chú</th>
                                <th width="180">Thao tác</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:forEach var="s" items="${schedules}">
                                <tr>
                                    <td class="align-middle">#${s.id}</td>
                                    <td class="align-middle">
                                        <strong>${s.eventName}</strong>
                                    </td>
                                    <td class="align-middle">${s.startTime}</td>
                                    <td class="align-middle">${s.endTime}</td>
                                    <td class="align-middle">${s.note}</td>
                                    <td class="align-middle">
                                        <a href="${ctx}/admin/schedules/edit/${s.id}" class="btn btn-warning btn-sm">Sửa</a>
                                        <a href="${ctx}/admin/schedules/delete/${s.id}"
                                           class="btn btn-danger btn-sm"
                                           onclick="return confirm('Bạn có chắc muốn xóa lịch này không?')">
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
