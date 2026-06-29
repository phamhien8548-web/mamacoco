<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div class="container py-4">

            <div class="card shadow-sm border-0">
                <div class="card-header bg-dark text-white">
                    <h4 class="mb-0">
                        <c:choose>
                            <c:when test="${ticketType.id == 0}">
                                Thêm loại vé
                            </c:when>
                            <c:otherwise>
                                Cập nhật loại vé
                            </c:otherwise>
                        </c:choose>
                    </h4>
                </div>

                <div class="card-body">

                    <form action="${ctx}/admin/ticket-types/save" method="post">

                        <input type="hidden" name="id" value="${ticketType.id}">

                        <div class="mb-3">
                            <label class="form-label fw-bold">Sự kiện</label>
                            <select name="eventId" class="form-select" required>
                                <option value="">-- Chọn sự kiện --</option>
                                <c:forEach var="e" items="${events}">
                                    <option value="${e.id}" ${ticketType.eventId == e.id ? 'selected' : ''}>
                                        ${e.eventName}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Tên loại vé</label>
                            <input type="text"
                                   name="ticketName"
                                   value="${ticketType.ticketName}"
                                   class="form-control"
                                   placeholder="Ví dụ: Vé thường, Vé VIP"
                                   required>
                        </div>

                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label fw-bold">Giá vé</label>
                                <input type="number"
                                       name="price"
                                       value="${ticketType.price}"
                                       class="form-control"
                                       min="0"
                                       step="1000"
                                       required>
                            </div>

                            <div class="col-md-4 mb-3">
                                <label class="form-label fw-bold">Tổng số lượng</label>
                                <input type="number"
                                       name="totalQuantity"
                                       value="${ticketType.totalQuantity}"
                                       class="form-control"
                                       min="0"
                                       required>
                            </div>

                            <div class="col-md-4 mb-3">
                                <label class="form-label fw-bold">Đã bán</label>
                                <input type="number"
                                       name="soldQuantity"
                                       value="${ticketType.soldQuantity}"
                                       class="form-control"
                                       min="0"
                                       required>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-bold">Trạng thái</label>
                            <select name="status" class="form-select">
                                <option value="OPEN" ${ticketType.status == 'OPEN' ? 'selected' : ''}>OPEN - Đang bán</option>
                                <option value="SOLD_OUT" ${ticketType.status == 'SOLD_OUT' ? 'selected' : ''}>SOLD_OUT - Hết vé</option>
                                <option value="CLOSED" ${ticketType.status == 'CLOSED' ? 'selected' : ''}>CLOSED - Ngừng bán</option>
                            </select>
                        </div>

                        <div class="d-flex justify-content-between">
                            <a href="${ctx}/admin/ticket-types" class="btn btn-secondary">Quay lại</a>
                            <button type="submit" class="btn btn-primary">Lưu loại vé</button>
                        </div>

                    </form>

                </div>
            </div>

        </div>
