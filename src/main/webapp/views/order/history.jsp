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

    <!-- bootstrap core css -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/views/css/bootstrap.css" />
    <!-- font awesome style -->
    <link href="${pageContext.request.contextPath}/views/css/font-awesome.min.css" rel="stylesheet" />
    <!-- Custom styles -->
    <link href="${pageContext.request.contextPath}/views/css/style.css" rel="stylesheet" />
    <!-- responsive style -->
    <link href="${pageContext.request.contextPath}/views/css/responsive.css" rel="stylesheet" />

    <!-- 드롭다운 메뉴 스타일 -->
    <style>
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
    </style>

    <!-- jQuery -->
    <script src="${pageContext.request.contextPath}/views/js/jquery-3.4.1.min.js"></script>
    <!-- Bootstrap JavaScript -->
    <script src="${pageContext.request.contextPath}/views/js/bootstrap.js"></script>
</head>

<body class="sub_page">
<!-- header section -->
<div class="hero_area">
    <header class="header_section">
        <div class="container">
            <nav class="navbar navbar-expand-lg custom_nav-container ">
                <%-- 로고 --%>
                <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                    <img width="250" src="${pageContext.request.contextPath}/views/images/logo.png" alt="#" />
                </a>

                <%-- 모바일 메뉴 토글 버튼 --%>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class=""> </span>
                </button>

                <%-- 네비게이션 메뉴 --%>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/">Home</a>
                        </li>

                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="pagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true" style="color: #000;">
                                <span class="nav-label">Pages <span class="caret"></span></span>
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
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="color: #000;">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <circle cx="12" cy="7" r="4"/>
                                    <path d="M6 21v-2a4 4 0 0 1 4-4h4a4 4 0 0 1 4 4v2"/>
                                </svg>
                                <span class="nav-label"><span class="caret"></span></span>
                            </a>

                            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
                                <c:choose>
                                    <c:when test="${sessionScope.logincust == null}">
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/login">
                                            <i class="fa fa-sign-in" aria-hidden="true"></i> Login
                                        </a>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/register">
                                            <i class="fa fa-user-plus" aria-hidden="true"></i> Register
                                        </a>
                                    </c:when>
                                    <%-- 로그인한 경우 드롭다운 메뉴 --%>
                                    <c:otherwise>
                                        <%-- 사용자 프로필 메뉴 (사용자 이름 표시) --%>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/info">
                                            <i class="fa fa-user" aria-hidden="true"></i> ${sessionScope.logincust.custName}
                                        </a>

                                        <%-- 주문 내역 메뉴 추가 --%>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/order/history">
                                            <i class="fa fa-list-alt" aria-hidden="true"></i> 주문 내역
                                        </a>

                                        <%-- 구분선 --%>
                                        <div class="dropdown-divider"></div>

                                        <%-- 로그아웃 메뉴 --%>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                            <i class="fa fa-sign-out" aria-hidden="true"></i> Log Out
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </li>

                        <c:if test="${sessionScope.logincust != null}">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                                    <svg version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 456.029 456.029" style="enable-background:new 0 0 456.029 456.029;" xml:space="preserve">
                                        <g>
                                            <g>
                                                <path d="M345.6,338.862c-29.184,0-53.248,23.552-53.248,53.248c0,29.184,23.552,53.248,53.248,53.248
                                                   c29.184,0,53.248-23.552,53.248-53.248C398.336,362.926,374.784,338.862,345.6,338.862z" />
                                            </g>
                                        </g>
                                        <g>
                                            <g>
                                                <path d="M439.296,84.91c-1.024,0-2.56-0.512-4.096-0.512H112.64l-5.12-34.304C104.448,27.566,84.992,10.67,61.952,10.67H20.48
                                                   C9.216,10.67,0,19.886,0,31.15c0,11.264,9.216,20.48,20.48,20.48h41.472c2.56,0,4.608,2.048,5.12,4.608l31.744,216.064
                                                   c4.096,27.136,27.648,47.616,55.296,47.616h212.992c26.624,0,49.664-18.944,55.296-45.056l33.28-166.4
                                                   C457.728,97.71,450.56,86.958,439.296,84.91z" />
                                            </g>
                                        </g>
                                        <g>
                                            <g>
                                                <path d="M215.04,389.55c-1.024-28.16-24.576-50.688-52.736-50.688c-29.696,1.536-52.224,26.112-51.2,55.296
                                                 c1.024,28.16,24.064,50.688,52.224,50.688h1.024C193.536,443.31,216.576,418.734,215.04,389.55z" />
                                            </g>
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
                                    <i class="fa fa-search" aria-hidden="true"></i>
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

<!-- 주문 내역 화면 -->
<section class="product_section layout_padding">
    <div class="container">
        <div class="heading_container heading_center">
            <h2>${sessionScope.logincust.custName}님의 주문 <span>내역</span></h2>
        </div>

        <div class="row">
            <div class="col-12">
                <c:choose>
                    <c:when test="${empty orderHistory}">
                        <!-- 주문 내역이 없는 경우 -->
                        <div class="text-center py-5">
                            <i class="fa fa-shopping-cart" style="font-size: 60px; color: #ddd;"></i>
                            <h4 class="mt-3 text-muted">${sessionScope.logincust.custName}님의 주문 내역이 없습니다</h4>
                            <p class="text-muted">첫 번째 주문을 시작해보세요!</p>
                            <a href="${pageContext.request.contextPath}/product" class="btn btn-primary mt-3">
                                <i class="fa fa-shopping-bag"></i> 쇼핑하러 가기
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- 주문 내역 목록 -->
                        <c:forEach var="order" items="${orderHistory}" varStatus="status">
                            <div class="card mb-3">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    <h6 class="mb-0">
                                        <i class="fa fa-receipt"></i> 주문번호: ${order.orderId}
                                    </h6>
                                    <small class="text-muted">
                                        <fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm" />
                                    </small>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-3">
                                            <strong>받는분:</strong><br>
                                                ${order.shippingName}
                                        </div>
                                        <div class="col-md-4">
                                            <strong>배송지:</strong><br>
                                            <small class="text-muted">${order.shippingAddress}</small>
                                        </div>
                                        <div class="col-md-2">
                                            <strong>연락처:</strong><br>
                                            <small>${order.shippingPhone}</small>
                                        </div>
                                        <div class="col-md-3 text-right">
                                            <strong class="text-danger" style="font-size: 18px;">
                                                <fmt:formatNumber value="${order.totalAmount}" pattern="#,###" />원
                                            </strong>
                                        </div>
                                    </div>
                                    <div class="text-right mt-3">
                                        <a href="${pageContext.request.contextPath}/order/detail/${order.orderId}" class="btn btn-outline-primary btn-sm">
                                            <i class="fa fa-eye"></i> 상세보기
                                        </a>
                                        <button class="btn btn-outline-secondary btn-sm ml-2" onclick="reorder(${order.orderId})">
                                            <i class="fa fa-refresh"></i> 재주문
                                        </button>
                                        <button class="btn btn-outline-danger btn-sm ml-2" onclick="cancelOrder(${order.orderId})">
                                            <i class="fa fa-times"></i> 주문취소
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>

                        <!-- 페이징이 필요하다면 여기에 추가 -->
                        <div class="text-center mt-4">
                            <a href="${pageContext.request.contextPath}/product" class="btn btn-success">
                                <i class="fa fa-shopping-bag"></i> 계속 쇼핑하기
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
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
                    <h4>연락처</h4>
                    <div class="contact_link_box">
                        <a href=""><i class="fa fa-map-marker" aria-hidden="true"></i><span>서울시 강남구</span></a>
                        <a href=""><i class="fa fa-phone" aria-hidden="true"></i><span>02-1234-5678</span></a>
                        <a href=""><i class="fa fa-envelope" aria-hidden="true"></i><span>team5@shop.com</span></a>
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

<script>
    // 재주문 함수
    function reorder(orderId) {
        if (confirm('이 주문을 다시 주문하시겠습니까?')) {
            alert('재주문 기능은 곧 구현될 예정입니다!');
            // TODO: 재주문 기능 구현
        }
    }

    // 주문 취소 함수
    function cancelOrder(orderId) {
        if (confirm('정말로 이 주문을 취소하시겠습니까?')) {
            location.href = '${pageContext.request.contextPath}/order/cancel/' + orderId;
        }
    }
</script>

</body>
</html>