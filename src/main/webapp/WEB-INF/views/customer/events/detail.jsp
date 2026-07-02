<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<section class="content-panel overflow-hidden">
    <div class="row g-0">
        <div class="col-lg-5">
            <c:choose>
                <c:when test="${not empty event.bannerImage}">
                    <img src="${ctx}/assets/uploads/events/${event.bannerImage}"
                         class="img-fluid h-100 w-100 event-detail-image"
                         alt="${event.eventName}">
                </c:when>
                <c:otherwise>
                    <div class="event-image-placeholder h-100 event-detail-image">
                        <i class="fa-solid fa-image fa-3x"></i>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="col-lg-7">
            <div class="p-4 p-lg-5 d-flex flex-column h-100">
                <div class="d-flex flex-wrap gap-2 mb-3">
                    <span class="badge text-bg-danger">${event.categoryName}</span>
                    <span class="badge text-bg-warning">Đang mở bán</span>
                </div>

                <h1 class="page-title">${event.eventName}</h1>
                <p class="page-subtitle fs-5">${event.shortDescription}</p>

                <div class="row g-3 my-4">
                    <div class="col-md-6">
                        <div class="info-tile">
                            <div class="fw-bold text-danger mb-1">
                                <i class="fa-solid fa-location-dot me-1"></i>Địa điểm
                            </div>
                            <div>${event.venueName}</div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="info-tile">
                            <div class="fw-bold text-danger mb-1">
                                <i class="fa-solid fa-ticket me-1"></i>Loại sự kiện
                            </div>
                            <div>${event.categoryName}</div>
                        </div>
                    </div>
                </div>

                <div class="border-start border-danger border-4 ps-3 mb-4">
                    <h2 class="h5 fw-bold">Thông tin sự kiện</h2>
                    <p class="text-muted mb-0" style="white-space: pre-line;">${event.description}</p>
                </div>

                <div class="mt-auto d-grid gap-2 d-md-flex">
                    <a href="${ctx}/user/tickets/book?eventId=${event.id}" class="btn btn-danger btn-lg px-4">
                        <i class="fa-solid fa-ticket me-1"></i>
                        <c:choose>
                            <c:when test="${not empty sessionScope.currentUser}">Đặt vé ngay</c:when>
                            <c:otherwise>Đăng nhập để đặt vé</c:otherwise>
                        </c:choose>
                    </a>
                    <a href="${ctx}/events" class="btn btn-outline-secondary btn-lg px-4">
                        <i class="fa-solid fa-arrow-left me-1"></i>Quay lại
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>
