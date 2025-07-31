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

        .action-buttons {
            text-align: center;
            margin: 40px 0;
        }

        .btn-action {
            display: inline-block;
            padding: 12px 30px;
            margin: 0 10px;
            border-radius: 25px;
            text-decoration: none;
            font-weight: bold;
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
            background: white;
            color: #6c757d;
            border: 2px solid #6c757d;
        }

        .btn-secondary-action:hover {
            background: #6c757d;
            color: white;
            text-decoration: none;
        }

        .info-section {
            background: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
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

                    <!-- 간단한 배송 안내 -->
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
                            <strong>배송기간</strong> - 영업일 기준 2-3일 소요 예정
                        </p>
                        <p class="mb-0">
                            <i class="fa fa-phone text-warning"></i>
                            <strong>문의전화</strong> - 02-1234-5678 (평일 09:00-18:00)
                        </p>
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
                <div class="info-section">
                    <h5 class="mb-3">
                        <i class="fa fa-info-circle"></i> 이용 안내
                    </h5>
                    <div class="row">
                        <div class="col-md-4 text-center">
                            <i class="fa fa-truck" style="font-size: 2rem; color: #007bff; margin-bottom: 10px;"></i>
                            <h6>무료 배송</h6>
                            <p style="font-size: 0.9em; color: #6c757d;">
                                전 상품 무료배송으로<br>부담 없이 주문하세요.
                            </p>
                        </div>
                        <div class="col-md-4 text-center">
                            <i class="fa fa-shield" style="font-size: 2rem; color: #28a745; margin-bottom: 10px;"></i>
                            <h6>안전 결제</h6>
                            <p style="font-size: 0.9em; color: #6c757d;">
                                안전한 결제 시스템으로<br>걱정 없이 구매하세요.
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

</body>
</html>