<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>주문 완료 - Team 5 Shop</title>

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

        /* ===== 주문 완료 전용 스타일 ===== */
        .success-header {
            text-align: center;
            padding: 50px 0;
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            border-radius: 15px;
            margin-bottom: 30px;
        }

        .success-icon {
            font-size: 80px;
            margin-bottom: 20px;
            animation: bounce 2s infinite;
        }

        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% {
                transform: translateY(0);
            }
            40% {
                transform: translateY(-10px);
            }
            60% {
                transform: translateY(-5px);
            }
        }

        .order-summary-card {
            background: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
        }

        .info-section {
            background: white;
            border: 1px solid #dee2e6;
            border-radius: 10px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .info-section h4 {
            color: #f7444e;
            border-bottom: 2px solid #f7444e;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }

        .next-steps {
            background: #f8f9fa;
            border-left: 4px solid #28a745;
            padding: 20px;
            margin: 20px 0;
            border-radius: 0 8px 8px 0;
        }

        .action-buttons {
            text-align: center;
            margin: 30px 0;
        }

        .action-buttons .btn {
            margin: 5px 10px;
            padding: 12px 30px;
            font-size: 1rem;
            border-radius: 25px;
        }

        .service-info {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            margin: 20px 0;
        }

        .service-info i {
            color: #f7444e;
        }

        /* 주문 상태 스타일 */
        .order-status {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 20px 0;
            padding: 15px;
            background: white;
            border: 1px solid #ddd;
            border-radius: 8px;
        }

        .status-item {
            text-align: center;
            flex: 1;
            position: relative;
        }

        .status-item:not(:last-child)::after {
            content: '';
            position: absolute;
            right: -50%;
            top: 50%;
            width: 100%;
            height: 2px;
            background: #ddd;
            transform: translateY(-50%);
        }

        .status-item.active::after {
            background: #28a745;
        }

        .status-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #ddd;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 10px;
            font-size: 18px;
        }

        .status-item.active .status-icon {
            background: #28a745;
        }

        .status-item.completed .status-icon {
            background: #28a745;
        }

        /* 주문 상품 스타일 */
        .order-item-card {
            padding: 15px 0;
            margin-bottom: 10px;
        }

        .order-item-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid #ddd;
        }

        .no-image-placeholder {
            width: 80px;
            height: 80px;
            background: #f8f9fa;
            border: 1px solid #ddd;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #6c757d;
            font-size: 24px;
        }

        .quantity-badge {
            background: #e9ecef;
            color: #495057;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.9em;
            font-weight: 500;
        }

        .badge {
            font-size: 0.9em;
            padding: 6px 12px;
        }

        .badge i {
            margin-right: 4px;
        }
    </style>
</head>

<body class="sub_page">

<!-- ===== 헤더 ===== -->
<div class="hero_area">
    <header class="header_section">
        <div class="container">
            <nav class="navbar navbar-expand-lg custom_nav-container">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                    <span>Team 5 Shop</span>
                </a>

                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/">홈</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/product">상품</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/about">소개</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/contact">연락처</a>
                        </li>

                        <!-- 로그인/로그아웃 메뉴 -->
                        <c:choose>
                            <c:when test="${sessionScope.logincust != null}">
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown">
                                        <i class="fa fa-user"></i> ${sessionScope.logincust.custName}님
                                    </a>
                                    <div class="dropdown-menu">
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/mypage">
                                            <i class="fa fa-user-circle"></i> 마이페이지
                                        </a>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/order/history">
                                            <i class="fa fa-list-alt"></i> 주문내역
                                        </a>
                                        <div class="dropdown-divider"></div>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                            <i class="fa fa-sign-out"></i> 로그아웃
                                        </a>
                                    </div>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/login">
                                        <i class="fa fa-sign-in"></i> 로그인
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/register">
                                        <i class="fa fa-user-plus"></i> 회원가입
                                    </a>
                                </li>
                            </c:otherwise>
                        </c:choose>

                        <!-- 장바구니 아이콘 -->
                        <c:if test="${sessionScope.logincust != null}">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                                    <svg version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" width="25" height="25" viewBox="0 0 456.029 456.029" style="enable-background:new 0 0 456.029 456.029;">
                                        <g>
                                            <path d="M345.6,338.862c-29.184,0-53.248,23.552-53.248,53.248c0,29.184,23.552,53.248,53.248,53.248
                                                     c29.184,0,53.248-23.552,53.248-53.248C398.336,362.926,374.784,338.862,345.6,338.862z"/>
                                        </g>
                                        <g>
                                            <path d="M439.296,84.91c-1.024,0-2.56-0.512-4.096-0.512H112.64l-5.12-34.304C104.448,27.566,84.992,10.67,61.952,10.67H20.48
                                                     C9.216,10.67,0,19.886,0,31.15c0,11.264,9.216,20.48,20.48,20.48h41.472c2.56,0,4.608,2.048,5.12,4.608l31.744,216.064
                                                     c4.096,27.136,27.648,47.616,55.296,47.616h212.992c26.624,0,49.664-18.944,55.296-45.056l33.28-166.4
                                                     C457.728,97.71,450.56,86.958,439.296,84.91z"/>
                                        </g>
                                        <g>
                                            <path d="M215.04,389.55c-1.024-28.16-24.576-50.688-52.736-50.688c-29.696,1.536-52.224,26.112-51.2,55.296
                                                     c1.024,28.16,24.064,50.688,52.224,50.688h1.024C193.536,443.31,216.576,418.734,215.04,389.55z"/>
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
<section class="layout_padding">
    <div class="container">
        <!-- 성공 메시지 헤더 -->
        <div class="success-header">
            <div class="success-icon">
                <i class="fa fa-check-circle"></i>
            </div>
            <h2 class="mb-3">주문이 완료되었습니다!</h2>
            <p class="mb-0" style="font-size: 1.1rem;">
                주문번호: <strong>#${order.orderId}</strong><br>
                빠른 시일 내에 배송해드리겠습니다.
            </p>
        </div>

        <div class="row">
            <div class="col-lg-8 mx-auto">
                <!-- 주문 상태 표시 -->
                <div class="order-status">
                    <div class="status-item completed">
                        <div class="status-icon">
                            <i class="fa fa-check"></i>
                        </div>
                        <div class="status-text">
                            <strong>주문완료</strong>
                        </div>
                    </div>
                    <div class="status-item active">
                        <div class="status-icon">
                            <i class="fa fa-credit-card"></i>
                        </div>
                        <div class="status-text">
                            <strong>결제완료</strong>
                        </div>
                    </div>
                    <div class="status-item">
                        <div class="status-icon">
                            <i class="fa fa-truck"></i>
                        </div>
                        <div class="status-text">
                            <strong>배송준비</strong>
                        </div>
                    </div>
                    <div class="status-item">
                        <div class="status-icon">
                            <i class="fa fa-home"></i>
                        </div>
                        <div class="status-text">
                            <strong>배송완료</strong>
                        </div>
                    </div>
                </div>

                <!-- 주문 기본 정보 -->
                <div class="info-section">
                    <h4 class="mb-4">
                        <i class="fa fa-receipt"></i> 주문 정보
                    </h4>

                    <div class="row mb-4">
                        <div class="col-md-6">
                            <p><strong>주문번호:</strong> #${order.orderId}</p>
                            <p><strong>주문일시:</strong>
                                <fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm" />
                            </p>
                            <p><strong>결제금액:</strong>
                                <span class="text-danger font-weight-bold" style="font-size: 1.2rem;">
                                    <fmt:formatNumber value="${order.totalAmount}" pattern="#,###" />원
                                </span>
                            </p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>받는분:</strong> ${order.shippingName}</p>
                            <p><strong>연락처:</strong> ${order.shippingPhone}</p>
                            <p><strong>배송지:</strong><br>
                                <small>${order.shippingAddress}</small>
                            </p>
                        </div>
                    </div>
                </div>

                <!-- 주문 상품 정보 -->
                <div class="info-section">
                    <h4 class="mb-4">
                        <i class="fa fa-shopping-bag"></i> 주문 상품
                    </h4>

                    <c:choose>
                        <c:when test="${not empty orderItems}">
                            <c:forEach var="item" items="${orderItems}" varStatus="status">
                                <div class="order-item-card ${status.last ? '' : 'border-bottom'}">
                                    <div class="row align-items-center">
                                        <div class="col-md-2">
                                            <c:choose>
                                                <c:when test="${not empty item.product.productImg}">
                                                    <img src="${pageContext.request.contextPath}/views/images/${item.product.productImg}"
                                                         alt="${item.product.productName}"
                                                         class="img-fluid order-item-image">
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="no-image-placeholder">
                                                        <i class="fa fa-image"></i>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="col-md-6">
                                            <h6 class="mb-1">${item.product.productName}</h6>
                                            <p class="text-muted mb-1" style="font-size: 0.9em;">
                                                카테고리:
                                                <c:choose>
                                                    <c:when test="${item.product.categoryId == 1}">스마트폰/태블릿</c:when>
                                                    <c:when test="${item.product.categoryId == 2}">게이밍</c:when>
                                                    <c:when test="${item.product.categoryId == 3}">웨어러블/스마트기기</c:when>
                                                    <c:when test="${item.product.categoryId == 4}">노트북/PC</c:when>
                                                    <c:when test="${item.product.categoryId == 5}">모니터</c:when>
                                                    <c:when test="${item.product.categoryId == 6}">TV</c:when>
                                                    <c:when test="${item.product.categoryId == 7}">기타 전자제품</c:when>
                                                    <c:otherwise>기타</c:otherwise>
                                                </c:choose>
                                            </p>
                                            <p class="mb-1"><strong>단가</strong></p>
                                            <p class="text-muted mb-1" style="font-size: 0.9rem;">
                                                <fmt:formatNumber value="${item.orderItem.unitPrice}" pattern="#,###" />원
                                            </p>
                                        </div>
                                        <div class="col-md-2 text-center">
                                            <span class="quantity-badge">${item.orderItem.quantity}개</span>
                                        </div>
                                        <div class="col-md-2 text-right">
                                            <strong class="text-primary">
                                                    <fmt:formatNumber value="${item.totalPrice}" pattern="#,### 원"/>
                                            </strong>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <p class="text-muted">주문 상품 정보를 불러올 수 없습니다.</p>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- 결제 정보 -->
                <div class="info-section">
                    <h4 class="mb-4">
                        <i class="fa fa-credit-card"></i> 결제 정보
                    </h4>

                    <div class="row">
                        <div class="col-md-6">
                            <p><strong>결제 방법:</strong>
                                <c:choose>
                                    <c:when test="${payment.paymentMethod == 'creditCard'}">
                                        <span class="badge badge-primary">
                                            <i class="fa fa-credit-card"></i> 신용카드
                                        </span>
                                    </c:when>
                                    <c:when test="${payment.paymentMethod == 'bankTransfer'}">
                                        <span class="badge badge-info">
                                            <i class="fa fa-university"></i> 무통장입금
                                        </span>
                                    </c:when>
                                    <c:when test="${payment.paymentMethod == 'kakaoPay'}">
                                        <span class="badge badge-warning">
                                            <i class="fa fa-mobile"></i> 카카오페이
                                        </span>
                                    </c:when>
                                    <c:when test="${payment.paymentMethod == 'naverpay'}">
                                        <span class="badge badge-success">
                                            <i class="fa fa-mobile"></i> 네이버페이
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-secondary">기타</span>
                                    </c:otherwise>
                                </c:choose>
                            </p>
                            <p><strong>결제 상태:</strong>
                                <span class="badge badge-success">
                                    <i class="fa fa-check-circle"></i> 결제완료
                                </span>
                            </p>
                            <c:if test="${not empty payment.transactionId}">
                                <p><strong>거래번호:</strong>
                                    <small class="text-muted">${payment.transactionId}</small>
                                </p>
                            </c:if>
                        </div>
                        <div class="col-md-6">
                            <p><strong>결제일시:</strong>
                                <fmt:formatDate value="${payment.paymentDate}" pattern="yyyy-MM-dd HH:mm:ss" />
                            </p>
                            <p><strong>결제금액:</strong>
                                <span class="text-danger font-weight-bold">
                                    <fmt:formatNumber value="${payment.paymentAmount}" pattern="#,###" />원
                                </span>
                            </p>
                        </div>
                    </div>

                    <!-- 배송 정보 -->
                    <div class="order-summary-card">
                        <h5 class="mb-3">
                            <i class="fa fa-truck"></i> 배송 안내
                        </h5>
                        <p class="mb-2">
                            <i class="fa fa-check text-success"></i>
                            <strong>무료배송</strong> - 배송비는 무료입니다.
                        </p>
                        <p class="mb-2">
                            <i class="fa fa-clock-o text-info"></i>
                            <strong>배송예정일:</strong>
                            <script>
                                var today = new Date();
                                var deliveryDate = new Date(today.getTime() + (2 * 24 * 60 * 60 * 1000)); // 2일 후
                                document.write(deliveryDate.getFullYear() + '년 ' +
                                    (deliveryDate.getMonth() + 1) + '월 ' +
                                    deliveryDate.getDate() + '일');
                            </script>
                        </p>
                        <p class="mb-0">
                            <i class="fa fa-info-circle text-warning"></i>
                            상품 준비상황에 따라 배송이 지연될 수 있습니다.
                        </p>
                    </div>
                </div>

                <!-- 다음 단계 안내 -->
                <div class="next-steps">
                    <h5><i class="fa fa-lightbulb-o"></i> 다음 단계</h5>
                    <ul class="mb-0">
                        <li>주문하신 상품을 준비하여 배송해드리겠습니다.</li>
                        <li>배송 시작시 SMS로 배송 정보를 안내해드립니다.</li>
                        <li><strong>마이페이지 > 주문내역</strong>에서 상세한 주문 정보를 확인하실 수 있습니다.</li>
                    </ul>
                </div>

                <!-- 액션 버튼들 -->
                <div class="action-buttons">
                    <a href="${pageContext.request.contextPath}/order/history" class="btn btn-primary">
                        <i class="fa fa-list-alt"></i> 주문내역 확인
                    </a>
                    <a href="${pageContext.request.contextPath}/product" class="btn btn-outline-secondary">
                        <i class="fa fa-shopping-cart"></i> 계속 쇼핑하기
                    </a>
                    <a href="${pageContext.request.contextPath}/" class="btn btn-outline-info">
                        <i class="fa fa-home"></i> 홈으로
                    </a>
                </div>

                <!-- 고객 서비스 정보 -->
                <div class="service-info">
                    <h5 class="mb-3"><i class="fa fa-headphones"></i> 고객 서비스</h5>
                    <div class="row">
                        <div class="col-md-4 text-center">
                            <i class="fa fa-phone" style="font-size: 2rem; color: #28a745; margin-bottom: 10px;"></i>
                            <h6>전화 문의</h6>
                            <p style="font-size: 0.9em; color: #6c757d;">
                                02-1234-5678<br>
                                평일 09:00-18:00
                            </p>
                        </div>
                        <div class="col-md-4 text-center">
                            <i class="fa fa-envelope" style="font-size: 2rem; color: #17a2b8; margin-bottom: 10px;"></i>
                            <h6>이메일 문의</h6>
                            <p style="font-size: 0.9em; color: #6c757d;">
                                team5@shop.com<br>
                                24시간 접수 가능
                            </p>
                        </div>
                        <div class="col-md-4 text-center">
                            <i class="fa fa-headphones" style="font-size: 2rem; color: #ffc107; margin-bottom: 10px;"></i>
                            <h6>고객 지원</h6>
                            <p style="font-size: 0.9em; color: #6c757d;">
                                궁금한 점이 있으시면<br>언제든 연락주세요.
                            </p>
                        </div>
                    </div>
                </div>
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

<!-- JavaScript 라이브러리 -->
<script src="${pageContext.request.contextPath}/views/js/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/views/js/bootstrap.js"></script>

</body>
</html>