<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div class="container py-4">

            <a href="${ctx}/admin/events" class="btn btn-secondary mb-3">Quay lại</a>

            <div class="card shadow-sm border-0">
                <div class="card-body">

                    <h2 class="fw-bold">${event.eventName}</h2>
                    <p class="text-muted">${event.shortDescription}</p>

                    <c:if test="${not empty event.bannerImage}">
                        <img src="${ctx}/assets/uploads/events/${event.bannerImage}"
                             class="img-fluid rounded mb-4"
                             style="max-height:350px; object-fit:cover;">
                    </c:if>

                    <div class="row mb-3">
                        <div class="col-md-4">
                            <strong>Danh mục:</strong>
                            <div>${event.categoryName}</div>
                        </div>

                        <div class="col-md-4">
                            <strong>Địa điểm:</strong>
                            <div>${event.venueName}</div>
                        </div>

                        <div class="col-md-4">
                            <strong>Trạng thái:</strong>
                            <div><span class="badge bg-success">${event.status}</span></div>
                        </div>
                    </div>

                    <hr>

                    <h5>Mô tả chi tiết</h5>
                    <p>${event.description}</p>

                    <div class="mt-4">
                        <a href="${ctx}/admin/events/edit/${event.id}" class="btn btn-warning">Sửa sự kiện</a>
                    </div>

                </div>
            </div>

        </div>
