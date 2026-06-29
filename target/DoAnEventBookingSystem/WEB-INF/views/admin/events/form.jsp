<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div class="container py-4">

            <div class="card shadow-sm border-0">
                <div class="card-header bg-dark text-white">
                    <h4 class="mb-0">
                        <c:choose>
                            <c:when test="${event.id == 0}">
                                Thêm sự kiện
                            </c:when>
                            <c:otherwise>
                                Cập nhật sự kiện
                            </c:otherwise>
                        </c:choose>
                    </h4>
                </div>

                <div class="card-body">

                    <form action="${ctx}/admin/events/save" method="post" enctype="multipart/form-data">

                        <input type="hidden" name="id" value="${event.id}">
                        <input type="hidden" name="oldBannerImage" value="${event.bannerImage}">

                        <div class="mb-3">
                            <label class="form-label fw-bold">Tên sự kiện</label>
                            <input type="text"
                                   name="eventName"
                                   value="${event.eventName}"
                                   class="form-control"
                                   placeholder="Ví dụ: Music Night 2026"
                                   required>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Danh mục</label>
                                <select name="categoryId" class="form-select" required>
                                    <option value="">-- Chọn danh mục --</option>
                                    <c:forEach var="c" items="${categories}">
                                        <option value="${c.id}" ${event.categoryId == c.id ? 'selected' : ''}>
                                            ${c.categoryName}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Địa điểm</label>
                                <select name="venueId" class="form-select" required>
                                    <option value="">-- Chọn địa điểm --</option>
                                    <c:forEach var="v" items="${venues}">
                                        <option value="${v.id}" ${event.venueId == v.id ? 'selected' : ''}>
                                            ${v.venueName}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Mô tả ngắn</label>
                            <input type="text"
                                   name="shortDescription"
                                   value="${event.shortDescription}"
                                   class="form-control"
                                   placeholder="Ví dụ: Đêm nhạc sinh viên">
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Mô tả chi tiết</label>
                            <textarea name="description"
                                      class="form-control"
                                      rows="5"
                                      placeholder="Nhập nội dung chi tiết của sự kiện">${event.description}</textarea>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Banner sự kiện</label>
                            <input type="file" name="bannerFile" class="form-control">

                            <c:if test="${not empty event.bannerImage}">
                                <div class="mt-3">
                                    <p class="mb-1 text-muted">Ảnh hiện tại:</p>
                                    <img src="${ctx}/assets/uploads/events/${event.bannerImage}"
                                         style="width:220px; height:120px; object-fit:cover; border-radius:10px;">
                                </div>
                            </c:if>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-bold">Trạng thái</label>
                            <select name="status" class="form-select">
                                <option value="DRAFT" ${event.status == 'DRAFT' ? 'selected' : ''}>DRAFT - Bản nháp</option>
                                <option value="OPEN" ${event.status == 'OPEN' ? 'selected' : ''}>OPEN - Đang mở</option>
                                <option value="SOLD_OUT" ${event.status == 'SOLD_OUT' ? 'selected' : ''}>SOLD_OUT - Hết vé</option>
                                <option value="COMPLETED" ${event.status == 'COMPLETED' ? 'selected' : ''}>COMPLETED - Đã kết thúc</option>
                                <option value="CANCELLED" ${event.status == 'CANCELLED' ? 'selected' : ''}>CANCELLED - Đã hủy</option>
                            </select>
                        </div>

                        <div class="d-flex justify-content-between">
                            <a href="${ctx}/admin/events" class="btn btn-secondary">Quay lại</a>
                            <button type="submit" class="btn btn-primary">Lưu sự kiện</button>
                        </div>

                    </form>

                </div>
            </div>

        </div>
