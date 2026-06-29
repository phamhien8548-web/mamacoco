<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<section class="ticket-hero">
    <div class="section-kicker text-white-50 mb-2">Mua vé sự kiện</div>
    <h1>Khám phá sự kiện nổi bật và đặt vé nhanh chóng</h1>
    <p>
        Theo dõi lịch tổ chức, chọn sự kiện phù hợp và quản lý vé của bạn trong cùng một hệ thống.
    </p>

    <div class="d-flex flex-wrap gap-2 mt-4">
        <a href="#event-list" class="btn btn-warning fw-bold">
            <i class="fa-solid fa-ticket me-1"></i>Chọn sự kiện
        </a>
        <c:choose>
            <c:when test="${not empty sessionScope.currentUser}">
                <a href="${ctx}/user/tickets/my-bookings" class="btn btn-outline-light fw-bold">
                    <i class="fa-solid fa-receipt me-1"></i>Vé của tôi
                </a>
            </c:when>
            <c:otherwise>
                <a href="${ctx}/login" class="btn btn-outline-light fw-bold">
                    <i class="fa-solid fa-right-to-bracket me-1"></i>Đăng nhập để đặt vé
                </a>
            </c:otherwise>
        </c:choose>
        <c:if test="${sessionScope.currentUser.role == 'ADMIN'}">
            <a href="${ctx}/admin/dashboard" class="btn btn-light fw-bold">
                <i class="fa-solid fa-shield-halved me-1"></i>Quản trị hệ thống
            </a>
        </c:if>
    </div>

    <div class="hero-metrics">
        <div class="hero-metric">
            <strong>${fn:length(events)}</strong>
            <span>Sự kiện đang hiển thị</span>
        </div>
        <div class="hero-metric">
            <strong>${fn:length(categories)}</strong>
            <span>Danh mục</span>
        </div>
        <div class="hero-metric">
            <strong>24/7</strong>
            <span>Đặt vé trực tuyến</span>
        </div>
    </div>
</section>

<section class="filter-panel mb-4">
    <form action="${ctx}/events" method="get">
        <div class="row g-3 align-items-end">
            <div class="col-lg-4">
                <label class="form-label fw-bold">Từ khóa</label>
                <div class="input-group">
                    <span class="input-group-text bg-white"><i class="fa-solid fa-magnifying-glass text-danger"></i></span>
                    <input type="text"
                           name="keyword"
                           value="${keyword}"
                           class="form-control"
                           placeholder="Tên hoặc mô tả sự kiện">
                </div>
            </div>

            <div class="col-lg-3">
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

            <div class="col-lg-3">
                <label class="form-label fw-bold">Ngày tổ chức</label>
                <input type="date" name="date" value="${date}" class="form-control">
            </div>

            <div class="col-lg-2 d-grid">
                <button type="submit" class="btn btn-danger">
                    <i class="fa-solid fa-filter me-1"></i>Lọc sự kiện
                </button>
            </div>
        </div>
    </form>
</section>

<section id="event-list">
    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-end gap-2 mb-3">
        <div>
            <div class="section-kicker">Danh sách vé</div>
            <h2 class="page-title mb-0">Sự kiện đang mở bán</h2>
            <p class="page-subtitle">Chọn sự kiện để xem chi tiết và đặt vé.</p>
        </div>
        <a href="${ctx}/events" class="btn btn-outline-secondary btn-sm">
            <i class="fa-solid fa-rotate-right me-1"></i>Làm mới
        </a>
    </div>

    <c:choose>
        <c:when test="${empty events}">
            <div class="empty-state">
                <i class="fa-solid fa-calendar-xmark"></i>
                <h3>Chưa tìm thấy sự kiện phù hợp</h3>
                <p>Thử đổi từ khóa, danh mục hoặc ngày tổ chức để xem thêm kết quả.</p>
                <a href="${ctx}/events" class="btn btn-danger">Xem tất cả sự kiện</a>
            </div>
        </c:when>

        <c:otherwise>
            <div class="row g-4">
                <c:forEach var="e" items="${events}">
                    <div class="col-sm-6 col-xl-4">
                        <article class="card event-card">
                            <c:choose>
                                <c:when test="${not empty e.bannerImage}">
                                    <img src="${ctx}/assets/uploads/events/${e.bannerImage}"
                                         class="card-img-top"
                                         alt="${e.eventName}">
                                </c:when>
                                <c:otherwise>
                                    <div class="event-image-placeholder">
                                        <i class="fa-solid fa-image fa-2x"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>

                            <div class="card-body d-flex flex-column">
                                <div class="d-flex justify-content-between align-items-center gap-2 mb-3">
                                    <span class="badge text-bg-danger">${e.categoryName}</span>
                                    <span class="text-muted small"><i class="fa-solid fa-location-dot me-1"></i>${e.venueName}</span>
                                </div>
                                <h3 class="h5 fw-bold mb-2">${e.eventName}</h3>
                                <p class="text-muted flex-grow-1">${e.shortDescription}</p>
                                <div class="d-grid gap-2">
                                    <a href="${ctx}/events/detail/${e.id}" class="btn btn-danger">
                                        <i class="fa-solid fa-eye me-1"></i>Xem chi tiết
                                    </a>
                                </div>
                            </div>
                        </article>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</section>
