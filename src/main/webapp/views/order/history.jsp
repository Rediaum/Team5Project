<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>주문 내역 - Team 5 Shop</title>

    <!-- CSS 리소스 -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/views/css/bootstrap.css" />
    <link href="${pageContext.request.contextPath}/views/css/font-awesome.min.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/views/css/style.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/views/css/responsive.css" rel="stylesheet" />

    <style>
        /* ===== 드롭다운 메뉴 스타일 ===== */
        .dropdown-menu {
            border: 1px solid #ddd;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            border-radius: 5px;
        }

        .dropdown-item {
            padding: 8px 16px;
            color: #333;
            transition: background-color 0.2s;
        }

        .dropdown-item:hover {
            background-color: #f8f9fa;
            color: #f7444e;
        }

        .dropdown-divider {
            margin: 5px 0;
        }

        .dropdown-item i {
            margin-right: 8px;
            width: 16px;
        }

        /* ===== 주문 내역 전용 스타일 ===== */
        .order-card {
            border: 1px solid #e9ecef;
            border-radius: 10px;
            transition: box-shadow 0.3s ease;
            margin-bottom: 20px;
        }

        .order-card:hover {
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .order-header {
            background: #f8f9fa;
            border-bottom: 1px solid #e9ecef;
            border-radius: 10px 10px 0 0;
            padding: 15px 20px;
        }

        .order-date {
            color: #007bff;
            font-size: 1.2rem;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .order-number {
            color: #6c757d;
            font-size: 0.95rem;
        }

        .product-item {
            background-color: #f8f9fa;
            border: 1px solid #e9ecef;
            border-radius: 8px;
            padding: 12px;
            margin-bottom: 10px;
            transition: all 0.3s ease;
        }

        .product-item:hover {
            background-color: #e9ecef;
            transform: translateY(-1px);
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .order-products {
            border-top: 1px solid #dee2e6;
            padding-top: 15px;
            margin-top: 15px;
        }

        .total-amount {
            font-size: 1.3rem;
            font-weight: bold;
            color: #dc3545;
        }

        .empty-orders {
            text-align: center;
            padding: 80px 0;
        }

        .empty-orders-icon {
            font-size: 100px;
            color: #dee2e6;
            margin-bottom: 20px;
        }

        /* 상세보기 토글 영역 */
        .order-detail-section {
            display: none;
            background: #f8f9fa;
            border-top: 1px solid #e9ecef;
            padding: 20px;
            border-radius: 0 0 10px 10px;
        }

        .timeline {
            position: relative;
            padding-left: 30px;
        }

        .timeline::before {
            content: '';
            position: absolute;
            left: 10px;
            top: 0;
            bottom: 0;
            width: 2px;
            background: #e9ecef;
        }

        .timeline-item {
            position: relative;
            margin-bottom: 20px;
        }

        .timeline-icon {
            position: absolute;
            left: -25px;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            background: #28a745;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 10px;
        }

        .timeline-content {
            padding-left: 10px;
        }

        .timeline-title {
            font-weight: bold;
            color: #333;
        }

        .timeline-desc {
            font-size: 0.9rem;
            color: #6c757d;
        }
    </style>

    <!-- JavaScript 리소스 -->
    <script src="${pageContext.request.contextPath}/views/js/jquery-3.4.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/views/js/bootstrap.js"></script>
</head>

<body class="sub_page">

<!-- ===== 헤더 섹션 ===== -->
<div class="hero_area">
    <header class="header_section">
        <div class="container">
            <nav class="navbar navbar-expand-lg custom_nav-container">
                <%-- 로고 --%>
                <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                    <img width="250" src="${pageContext.request.contextPath}/views/images/logo.png" alt="Team 5 Shop" />
                </a>

                <%-- 모바일 메뉴 토글 버튼 --%>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                        aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class=""></span>
                </button>

                <%-- 네비게이션 메뉴 --%>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/">Home</a>
                        </li>

                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="pagesDropdown" role="button"
                               data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="nav-label">Pages</span>
                            </a>
                            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="pagesDropdown">
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/about">About</a>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/testimonial">Testimonial</a>
                            </div>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/product">Products</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/contact">Contact</a>
                        </li>

                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                               data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                                     stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <circle cx="12" cy="7" r="4"/>
                                    <path d="M6 21v-2a4 4 0 0 1 4-4h4a4 4 0 0 1 4 4v2"/>
                                </svg>
                            </a>

                            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
                                <c:choose>
                                    <c:when test="${sessionScope.logincust == null}">
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/login">
                                            <i class="fa fa-sign-in"></i> Login
                                        </a>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/register">
                                            <i class="fa fa-user-plus"></i> Register
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/info">
                                            <i class="fa fa-user"></i> ${sessionScope.logincust.custName}
                                        </a>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/order/history">
                                            <i class="fa fa-list-alt"></i> 주문 내역
                                        </a>
                                        <div class="dropdown-divider"></div>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                            <i class="fa fa-sign-out"></i> Log Out
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </li>

                        <c:if test="${sessionScope.logincust != null}">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                                    <svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 456.029 456.029"
                                         style="width: 24px; height: 24px;">
                                        <g>
                                            <path d="M345.6,338.862c-29.184,0-53.248,23.552-53.248,53.248c0,29.184,23.552,53.248,53.248,53.248
                                                     c29.184,0,53.248-23.552,53.248-53.248C398.336,362.926,374.784,338.862,345.6,338.862z" />
                                        </g>
                                        <g>
                                            <path d="M439.296,84.91c-1.024,0-2.56-0.512-4.096-0.512H112.64l-5.12-34.304C104.448,27.566,84.992,10.67,61.952,10.67H20.48
                                                     C9.216,10.67,0,19.886,0,31.15c0,11.264,9.216,20.48,20.48,20.48h41.472c2.56,0,4.608,2.048,5.12,4.608l31.744,216.064
                                                     c4.096,27.136,27.648,47.616,55.296,47.616h212.992c26.624,0,49.664-18.944,55.296-45.056l33.28-166.4
                                                     C457.728,97.71,450.56,86.958,439.296,84.91z" />
                                        </g>
                                        <g>
                                            <path d="M215.04,389.55c-1.024-28.16-24.576-50.688-52.736-50.688c-29.696,1.536-52.224,26.112-51.2,55.296
                                                     c1.024,28.16,24.064,50.688,52.224,50.688h1.024C193.536,443.31,216.576,418.734,215.04,389.55z" />
                                        </g>
                                    </svg>
                                </a>
                            </li>
                        </c:if>

                        <form class="form-inline search-form-header" action="${pageContext.request.contextPath}/search" method="GET">
                            <div class="search-input-container">
                                <input type="text" name="keyword" class="form-control search-input-header"
                                       placeholder="상품 검색..." autocomplete="off" id="headerSearchInput">
                                <button class="btn search-btn-header" type="submit">
                                    <i class="fa fa-search"></i>
                                </button>
                                <div id="headerSuggestions" class="header-suggestions-dropdown" style="display: none;"></div>
                            </div>
                        </form>
                    </ul>
                </div>
            </nav>
        </div>
    </header>
</div>

<!-- ===== 메인 컨텐츠 ===== -->
<section class="product_section layout_padding">
    <div class="container">
        <div class="heading_container heading_center">
            <h2>${sessionScope.logincust.custName}님의 주문 <span>내역</span></h2>
        </div>

        <!-- 알림 메시지 -->
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <strong>성공!</strong> ${success}
                <button type="button" class="close" data-dismiss="alert">
                    <span>&times;</span>
                </button>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <strong>오류!</strong> ${error}
                <button type="button" class="close" data-dismiss="alert">
                    <span>&times;</span>
                </button>
            </div>
        </c:if>

        <div class="row">
            <div class="col-12">
                <c:choose>
                    <c:when test="${empty orderHistory}">
                        <%-- 주문 내역이 없는 경우 --%>
                        <div class="empty-orders">
                            <i class="fa fa-shopping-cart empty-orders-icon"></i>
                            <h4 class="mt-3 text-muted">${sessionScope.logincust.custName}님의 주문 내역이 없습니다</h4>
                            <p class="text-muted">첫 번째 주문을 시작해보세요!</p>
                            <a href="${pageContext.request.contextPath}/product" class="btn btn-primary btn-lg mt-3">
                                <i class="fa fa-shopping-bag"></i> 쇼핑하러 가기
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <%-- 주문 내역 목록 --%>
                        <c:forEach var="order" items="${orderHistory}" varStatus="status">
                            <div class="card order-card">
                                    <%-- 주문 헤더 --%>
                                <div class="order-header">
                                    <div class="order-date">
                                        <fmt:formatDate value="${order.orderDate}" pattern="yyyy년 MM월 dd일 HH:mm" />
                                    </div>
                                    <div class="order-number">
                                        <i class="fa fa-receipt"></i> 주문번호: ${order.orderId}
                                    </div>
                                </div>

                                    <%-- 주문 기본 정보 --%>
                                <div class="card-body">
                                    <div class="row mb-3">
                                        <div class="col-md-3">
                                            <strong>받는분:</strong><br>
                                                ${order.shippingName}
                                        </div>
                                        <div class="col-md-4">
                                            <strong>배송지:</strong><br>
                                            <small class="text-muted">${order.shippingAddress}</small>
                                        </div>
                                        <div class="col-md-3">
                                            <strong>연락처:</strong><br>
                                            <small>${order.shippingPhone}</small>
                                        </div>
                                        <div class="col-md-2">
                                                <%-- 빈 공간 --%>
                                        </div>
                                    </div>

                                        <%-- 주문 상품 목록 --%>
                                    <div class="order-products">
                                        <h6 class="mb-3">
                                            <i class="fa fa-shopping-bag"></i> 주문 상품
                                        </h6>
                                        <c:choose>
                                            <c:when test="${not empty orderItemsMap[order.orderId]}">
                                                <div class="row">
                                                    <c:forEach var="itemInfo" items="${orderItemsMap[order.orderId]}" varStatus="itemStatus">
                                                        <div class="col-md-6 mb-2">
                                                            <div class="product-item">
                                                                <div class="d-flex justify-content-between align-items-center">
                                                                    <div>
                                                                        <strong>${itemInfo.product.productName}</strong><br>
                                                                        <small class="text-muted">
                                                                            수량: ${itemInfo.orderItem.quantity}개 ×
                                                                            <fmt:formatNumber value="${itemInfo.orderItem.unitPrice}" pattern="#,###" />원
                                                                        </small>
                                                                    </div>
                                                                    <div class="text-right">
                                                                        <strong class="text-primary">
                                                                            <fmt:formatNumber value="${itemInfo.totalPrice}" pattern="#,###" />원
                                                                        </strong>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <p class="text-muted">주문 상품 정보를 불러올 수 없습니다.</p>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                        <%-- 총액 및 액션 버튼 --%>
                                    <div class="row mt-3">
                                        <div class="col-md-6">
                                            <div class="total-amount">
                                                총액: <fmt:formatNumber value="${order.totalAmount}" pattern="#,###" />원
                                            </div>
                                        </div>
                                        <div class="col-md-6 text-right">
                                            <button class="btn btn-outline-info btn-sm" onclick="toggleOrderDetail(${order.orderId})">
                                                <i class="fa fa-eye"></i> 상세보기
                                            </button>
                                            <a href="${pageContext.request.contextPath}/order/complete/${order.orderId}"
                                               class="btn btn-outline-primary btn-sm ml-2">
                                                <i class="fa fa-file-text"></i> 주문서 보기
                                            </a>
                                            <button class="btn btn-outline-danger btn-sm ml-2"
                                                    onclick="if(confirm('정말 주문을 취소하시겠습니까?')) { location.href='${pageContext.request.contextPath}/order/cancel/${order.orderId}'; }">
                                                <i class="fa fa-times"></i> 주문취소
                                            </button>
                                        </div>
                                    </div>
                                </div>

                                    <%-- 상세 정보 영역 (토글) --%>
                                <div id="orderDetail_${order.orderId}" class="order-detail-section">
                                    <div class="row">
                                            <%-- 배송 정보 --%>
                                        <div class="col-lg-6">
                                            <h5 class="mb-3">
                                                <i class="fa fa-truck"></i> 배송 정보
                                            </h5>
                                            <div class="card">
                                                <div class="card-body">
                                                    <p><strong>받는 사람:</strong> ${order.shippingName}</p>
                                                    <p><strong>연락처:</strong> ${order.shippingPhone}</p>
                                                    <p><strong>배송 주소:</strong><br>${order.shippingAddress}</p>
                                                    <p><strong>주문 일시:</strong><br>
                                                        <fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm:ss" />
                                                    </p>
                                                </div>
                                            </div>
                                        </div>

                                            <%-- 주문 진행 상황 --%>
                                        <div class="col-lg-6">
                                            <h5 class="mb-3">
                                                <i class="fa fa-clock-o"></i> 주문 진행 상황
                                            </h5>
                                            <div class="timeline">
                                                <div class="timeline-item">
                                                    <div class="timeline-icon">
                                                        <i class="fa fa-check"></i>
                                                    </div>
                                                    <div class="timeline-content">
                                                        <div class="timeline-title">주문 완료</div>
                                                        <div class="timeline-desc">
                                                            <fmt:formatDate value="${order.orderDate}" pattern="MM-dd HH:mm" />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="timeline-item">
                                                    <div class="timeline-icon" style="background: #6c757d;">
                                                        <i class="fa fa-cog"></i>
                                                    </div>
                                                    <div class="timeline-content">
                                                        <div class="timeline-title">상품 준비중</div>
                                                        <div class="timeline-desc">곧 준비가 완료됩니다</div>
                                                    </div>
                                                </div>
                                                <div class="timeline-item">
                                                    <div class="timeline-icon" style="background: #6c757d;">
                                                        <i class="fa fa-truck"></i>
                                                    </div>
                                                    <div class="timeline-content">
                                                        <div class="timeline-title">배송 시작</div>
                                                        <div class="timeline-desc">영업일 기준 2-3일 소요</div>
                                                    </div>
                                                </div>
                                                <div class="timeline-item">
                                                    <div class="timeline-icon" style="background: #6c757d;">
                                                        <i class="fa fa-home"></i>
                                                    </div>
                                                    <div class="timeline-content">
                                                        <div class="timeline-title">배송 완료</div>
                                                        <div class="timeline-desc">상품을 확인해주세요</div>
                                                    </div>
                                                </div>
                                            </div>

                                                <%-- 고객센터 안내 --%>
                                            <div class="card mt-4" style="background: #f8f9fa;">
                                                <div class="card-body">
                                                    <h6 class="mb-2">
                                                        <i class="fa fa-headphones"></i> 고객센터
                                                    </h6>
                                                    <small class="text-muted">
                                                        주문 관련 문의사항이 있으시면<br>
                                                        언제든지 연락해주세요.
                                                    </small>
                                                    <div class="mt-2">
                                                        <small>
                                                            <i class="fa fa-phone"></i> 02-1234-5678<br>
                                                            <i class="fa fa-envelope"></i> team5@shop.com
                                                        </small>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>

                        <%-- 하단 액션 버튼 --%>
                        <div class="text-center mt-4">
                            <a href="${pageContext.request.contextPath}/product" class="btn btn-success btn-lg">
                                <i class="fa fa-shopping-bag"></i> 계속 쇼핑하기
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</section>

<!-- ===== 푸터 ===== -->
<footer class="footer_section">
    <div class="container">
        <div class="row">
            <div class="col-md-4 footer-col">
                <div class="footer_contact">
                    <h4>연락처</h4>
                    <div class="contact_link_box">
                        <a href=""><i class="fa fa-map-marker"></i><span>서울시 강남구</span></a>
                        <a href=""><i class="fa fa-phone"></i><span>02-1234-5678</span></a>
                        <a href=""><i class="fa fa-envelope"></i><span>team5@shop.com</span></a>
                    </div>
                </div>
            </div>
            <div class="col-md-4 footer-col">
                <div class="footer_info">
                    <h4>고객센터</h4>
                    <p>평일 09:00 - 18:00<br>주말/공휴일 휴무</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="footer_info">
                    <h5>Team 5 Shop</h5>
                    <p>최고의 상품과 서비스를 제공합니다</p>
                </div>
            </div>
        </div>
    </div>
</footer>

<!-- ===== JavaScript ===== -->
<script>
    /**
     * 주문 내역 관리 객체
     */
    const OrderHistory = {
        contextPath: '<c:out value="${pageContext.request.contextPath}" />',

        /**
         * 주문 상세 정보 토글
         */
        toggleOrderDetail: function(orderId) {
            const detailSection = $('#orderDetail_' + orderId);

            if (detailSection.is(':visible')) {
                detailSection.slideUp(300);
            } else {
                // 다른 열린 상세보기들 닫기
                $('.order-detail-section:visible').slideUp(300);
                // 현재 상세보기 열기
                detailSection.slideDown(300);
            }
        }
    };

    // 전역 함수 (HTML onclick에서 직접 호출용)
    function toggleOrderDetail(orderId) {
        OrderHistory.toggleOrderDetail(orderId);
    }

    // 페이지 로드 시
    $(document).ready(function() {
        console.log('주문 내역 페이지 로드 완료');
    });
</script>

</body>
</html>