<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div class="container py-4">

            <div class="card shadow-sm border-0">
                <div class="card-header bg-dark text-white">
                    <h4 class="mb-0">
                        <c:choose>
                            <c:when test="${schedule.id == 0}">
                                Thêm lịch tổ chức
                            </c:when>
                            <c:otherwise>
                                Cập nhật lịch tổ chức
                            </c:otherwise>
                        </c:choose>
                    </h4>
                </div>

                <div class="card-body">

                    <form action="${ctx}/admin/schedules/save" method="post">

                        <input type="hidden" name="id" value="${schedule.id}">

                        <div class="mb-3">
                            <label class="form-label fw-bold">Sự kiện</label>
                            <select name="eventId" class="form-select" required>
                                <option value="">-- Chọn sự kiện --</option>
                                <c:forEach var="e" items="${events}">
                                    <option value="${e.id}" ${schedule.eventId == e.id ? 'selected' : ''}>
                                        ${e.eventName}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Thời gian bắt đầu</label>
                                <input type="datetime-local"
                                       name="startTime"
                                       value="${schedule.startTime}"
                                       class="form-control"
                                       required>
                            </div>

                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Thời gian kết thúc</label>
                                <input type="datetime-local"
                                       name="endTime"
                                       value="${schedule.endTime}"
                                       class="form-control"
                                       required>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-bold">Ghi chú</label>
                            <input type="text"
                                   name="note"
                                   value="${schedule.note}"
                                   class="form-control"
                                   placeholder="Ví dụ: Mở cửa lúc 17:30">
                        </div>

                        <div class="d-flex justify-content-between">
                            <a href="${ctx}/admin/schedules" class="btn btn-secondary">Quay lại</a>
                            <button type="submit" class="btn btn-primary">Lưu lịch</button>
                        </div>

                    </form>

                </div>
            </div>

        </div>
