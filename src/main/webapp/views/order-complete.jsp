<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>주문 완료 - Team 5 Electronic Shop</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/views/css/bootstrap.css" />
    <!-- Font Awesome -->
    <link href="${pageContext.request.contextPath}/views/css/font-awesome.min.css" rel="stylesheet" />
    <!-- Custom styles -->
    <link href="${pageContext.request.contextPath}/views/css/style.css" rel="stylesheet" />
    <!-- Responsive style -->
    <link href="${pageContext.request.contextPath}/views/css/responsive.css" rel="stylesheet" />

    <style>
        .success-header {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            border-radius: 15px;
            padding: 40px;
            text-align: center;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(40, 167, 69, 0.3);
        }

        .success-icon {
            font-size: 4rem;
            margin-bottom: 20px;
            animation: checkmark-animation 0.8s ease-in-out;
        }

        @keyframes checkmark-animation {
            0% { transform: scale(0); opacity: 0; }
            50% { transform: scale(1.2); opacity: 0.8; }
            100% { transform: scale(1); opacity: 1; }
        }

        .order-summary-card {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            padding: 25px;
            margin-bottom: 20px;
        }

        .order-info-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 0;
            border-bottom: 1px solid #e9ecef;
        }

        .order-info-row:last-child {
            border-bottom: none;
            font-weight: bold;
            font-size: 1.1em;
            color: #dc3545;
        }

        .order-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid #f8f9fa;
        }

        .order-item:last-child {
            border-bottom: none;
        }

        .item-info {
            flex: 1;
        }

        .item-name {
            font-weight: bold;
            color: #343a40;
            margin-bottom: 5px;
        }

        .item-details {
            color: #6c757d;
            font-size: 0.9em;
        }

        .item-price {
            text-align: right;
            font-weight: bold;
            color: #dc3545;
        }

        .action-buttons {
            text-align: center;
            margin-top: 30px;
        }

        .btn-action {
            margin: 0 10px;
            padding: 12px 30px;
            border-radius: 25px;
            font-weight: bold;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
        }

        .btn-primary-action {
            background: #007bff;
            color: white;
            border: 2px solid #007bff;
        }

        .btn-primary-action:hover {
            background: white;
            color: #007bff;
            text-decoration: none;
        }

        .btn-secondary-action {
            background: #6c757d;
            color: white;
            border: 2px solid #6c757d;
        }

        .btn-secondary-action:hover {
            background: white;
            color: #6c757d;
            text-decoration: none;
        }

        .shipping-info {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-top: 20px;
        }

        .timeline {
            margin-top: 30px;
        }

        .timeline-item {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }

        .timeline-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #28a745;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            font-size: 16px;
        }

        .timeline-content {
            flex: 1;
        }

        .timeline-title {
            font-weight: bold;
            color: #343a40;
        }

        .timeline-desc {
            color: #6c757d;
            font-size: 0.9em;
        }

        .price-breakdown {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-top: 20px;
        }
    </style>
</head>

<body class="sub_page">

<div class="hero_area">
    <!-- header section starts -->
    <header class="header_section">
        <div class="container">
            <nav class="navbar navbar-expand-lg custom_nav-container">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                    <img width="250" src="${pageContext.request.contextPath}/views/images/logo.png" alt="#" />
                </a>

                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent">
                    <span class=""></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/product">Products</a>
                        </li>
                        <c:if test="${sessionScope.logincust != null}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown">
                                    <i class="fa fa-user" aria-hidden="true"></i> ${sessionScope.logincust.custName}
                                </a>
                                <div class="dropdown-menu">
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/info">
                                        <i class="fa fa-user"></i> 프로필
                                    </a>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/address">
                                        <i class="fa fa-map-marker"></i> 배송지 관리
                                    </a>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/order/history">
                                        <i class="fa fa-list-alt"></i> 주문 내역
                                    </a>
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                        <i class="fa fa-sign-out"></i> 로그아웃
                                    </a>
                                </div>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                                    <i class="fa fa-shopping-bag" aria-hidden="true"></i>
                                </a>
                            </li>
                        </c:if>
                    </ul>
                </div>
            </nav>
        </div>
    </header>
    <!-- end header section -->
</div>

<!-- 주문 완료 페이지 -->
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
            <!-- 주문 상세 정보 -->
            <div class="col-lg-8">
                <div class="order-summary-card">
                    <h4 class="mb-4">
                        <i class="fa fa-shopping-cart"></i> 주문 상품 정보
                    </h4>

                    <!-- 주문 상품 목록 -->
                    <c:if test="${not empty orderItems}">
                        <c:forEach var="item" items="${orderItems}">
                            <div class="order-item">
                                <div class="item-info">
                                    <div class="item-name">${item.productId}</div>
                                    <div class="item-details">
                                        수량: ${item.quantity}개 |
                                        단가: <fmt:formatNumber value="${item.unitPrice}" pattern="#,###" />원
                                    </div>
                                </div>
                                <div class="item-price">
                                    <fmt:formatNumber value="${item.unitPrice * item.quantity}" pattern="#,###" />원
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>

                    <!-- 가격 요약 -->
                    <div class="price-breakdown">
                        <div class="order-info-row">
                            <span>상품 금액:</span>
                            <span><fmt:formatNumber value="${order.totalAmount}" pattern="#,###" />원</span>
                        </div>
                        <div class="order-info-row">
                            <span>배송비:</span>
                            <span style="color: #28a745;">무료</span>
                        </div>
                        <div class="order-info-row">
                            <span>총 결제금액:</span>
                            <span><fmt:formatNumber value="${order.totalAmount}" pattern="#,###" />원</span>
                        </div>
                    </div>
                </div>

                <!-- 배송 정보 -->
                <div class="order-summary-card">
                    <h4 class="mb-4">
                        <i class="fa fa-truck"></i> 배송 정보
                    </h4>
                    <div class="shipping-info">
                        <div class="row">
                            <div class="col-md-6">
                                <strong>받는 사람:</strong> ${order.shippingName}<br>
                                <strong>연락처:</strong> ${order.shippingPhone}
                            </div>
                            <div class="col-md-6">
                                <strong>배송 주소:</strong><br>
                                ${order.shippingAddress}
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 사이드바 - 주문 진행 상황 및 안내 -->
            <div class="col-lg-4">
                <div class="order-summary-card">
                    <h4 class="mb-4">
                        <i class="fa fa-clock-o"></i> 주문 진행 상황
                    </h4>
                    <div class="timeline">
                        <div class="timeline-item">
                            <div class="timeline-icon">
                                <i class="fa fa-check"></i>
                            </div>
                            <div class="timeline-content">
                                <div class="timeline-title">주문 완료</div>
                                <div class="timeline-desc">
                                    <fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm" />
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
                </div>

                <!-- 고객센터 안내 -->
                <div class="order-summary-card">
                    <h4 class="mb-3">
                        <i class="fa fa-headphones"></i> 고객센터
                    </h4>
                    <p style="font-size: 0.9em; color: #6c757d; line-height: 1.6;">
                        주문 관련 문의사항이 있으시면<br>
                        언제든지 연락해주세요.
                    </p>
                    <div style="margin-top: 15px;">
                        <i class="fa fa-phone"></i> <strong>1588-1234</strong><br>
                        <i class="fa fa-envelope"></i> <strong>support@team5shop.com</strong><br>
                        <small class="text-muted">평일 09:00 - 18:00 (주말, 공휴일 휴무)</small>
                    </div>
                </div>
            </div>
        </div>

        <!-- 액션 버튼들 -->
        <div class="action-buttons">
            <a href="${pageContext.request.contextPath}/order/history" class="btn-action btn-primary-action">
                <i class="fa fa-list-alt"></i> 주문 내역 보기
            </a>
            <a href="${pageContext.request.contextPath}/product" class="btn-action btn-secondary-action">
                <i class="fa fa-shopping-cart"></i> 쇼핑 계속하기
            </a>
        </div>

        <!-- 추가 안내사항 -->
        <div class="order-summary-card" style="margin-top: 30px;">
            <h5 class="mb-3">
                <i class="fa fa-info-circle"></i> 주문 완료 안내
            </h5>
            <div class="row">
                <div class="col-md-4">
                    <div style="text-align: center; padding: 20px;">
                        <i class="fa fa-truck" style="font-size: 2rem; color: #007bff; margin-bottom: 10px;"></i>
                        <h6>무료 배송</h6>
                        <p style="font-size: 0.9em; color: #6c757d;">
                            전 상품 무료배송으로<br>부담 없이 주문하세요.
                        </p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div style="text-align: center; padding: 20px;">
                        <i class="fa fa-shield" style="font-size: 2rem; color: #28a745; margin-bottom: 10px;"></i>
                        <h6>안전한 포장</h6>
                        <p style="font-size: 0.9em; color: #6c757d;">
                            제품이 안전하게 배송될 수 있도록<br>꼼꼼하게 포장합니다.
                        </p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div style="text-align: center; padding: 20px;">
                        <i class="fa fa-refresh" style="font-size: 2rem; color: #dc3545; margin-bottom: 10px;"></i>
                        <h6>쉬운 교환/반품</h6>
                        <p style="font-size: 0.9em; color: #6c757d;">
                            7일 내 간편하게<br>교환/반품이 가능합니다.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- footer section -->
<footer class="footer_section">
    <div class="container">
        <div class="row">
            <div class="col-md-4 footer-col">
                <div class="footer_contact">
                    <h4>Contact us</h4>
                    <div class="contact_link_box">
                        <a href="">
                            <i class="fa fa-map-marker" aria-hidden="true"></i>
                            <span>서울시 강남구 테헤란로</span>
                        </a>
                        <a href="">
                            <i class="fa fa-phone" aria-hidden="true"></i>
                            <span>Call +82 1588-1234</span>
                        </a>
                        <a href="">
                            <i class="fa fa-envelope" aria-hidden="true"></i>
                            <span>team5@electroshop.com</span>
                        </a>
                    </div>
                </div>
            </div>
            <div class="col-md-4 footer-col">
                <div class="footer_detail">
                    <a href="" class="footer-logo">Team 5 Electronic Shop</a>
                    <p>
                        최고의 전자제품을 합리적인 가격에 만나보세요.
                        고객 만족이 저희의 최우선 목표입니다.
                    </p>
                    <div class="footer_social">
                        <a href="">
                            <i class="fa fa-facebook" aria-hidden="true"></i>
                        </a>
                        <a href="">
                            <i class="fa fa-twitter" aria-hidden="true"></i>
                        </a>
                        <a href="">
                            <i class="fa fa-linkedin" aria-hidden="true"></i>
                        </a>
                        <a href="">
                            <i class="fa fa-instagram" aria-hidden="true"></i>
                        </a>
                    </div>
                </div>
            </div>
            <div class="col-md-4 footer-col">
                <h4>Subscribe</h4>
                <form action="#">
                    <input type="text" placeholder="Enter email" />
                    <button type="submit">Subscribe</button>
                </form>
            </div>
        </div>
        <div class="footer-info">
            <p>
                &copy; <span id="displayYear"></span> All Rights Reserved By
                <a href="#">Team 5 Electronic Shop</a>
            </p>
        </div>
    </div>
</footer>
<!-- footer section -->

<!-- jQuery -->
<script src="${pageContext.request.contextPath}/views/js/jquery-3.4.1.min.js"></script>
<!-- Popper.js -->
<script src="${pageContext.request.contextPath}/views/js/popper.min.js"></script>
<!-- Bootstrap JavaScript -->
<script src="${pageContext.request.contextPath}/views/js/bootstrap.js"></script>
<!-- Custom JavaScript -->
<script src="${pageContext.request.contextPath}/views/js/custom.js"></script>

<script>
    $(document).ready(function() {
        // 현재 연도 설정
        $('#displayYear').text(new Date().getFullYear());

        // 주문완료 페이지 진입시 장바구니 아이콘 업데이트 (비우기)
        // 필요에 따라 AJAX로 장바구니 개수 업데이트 로직 추가 가능
    });
</script>

</body>
</html>