<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/views/images/favicon.png" type="">
    <title>${product.productName} - Famms</title>

    <!-- bootstrap core css -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/views/css/bootstrap.css" />

    <!-- font awesome style -->
    <link href="${pageContext.request.contextPath}/views/css/font-awesome.min.css" rel="stylesheet" />

    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/views/css/style.css" rel="stylesheet" />
    <!-- responsive style -->
    <link href="${pageContext.request.contextPath}/views/css/responsive.css" rel="stylesheet" />

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script>
        let product_detail = {
            init: function() {
                $('#add_to_cart_btn').click(() => {
                    let quantity = $('#quantity').val();
                    let productId = '${product.productId}';

                    // 장바구니에 추가 로직
                    if(confirm('장바구니에 추가하시겠습니까?')) {
                        location.href = '${pageContext.request.contextPath}/cart/add?productId=' + productId + '&quantity=' + quantity;
                    }
                });

                $('#buy_now_btn').click(() => {
                    let quantity = $('#quantity').val();
                    let productId = '${product.productId}';

                    // 바로 구매 로직
                    if(confirm('바로 구매하시겠습니까?')) {
                        location.href = '${pageContext.request.contextPath}/order/buy?productId=' + productId + '&quantity=' + quantity;
                    }
                });

                $('#back_btn').click(() => {
                    history.back();
                });

                // 페이지 로드 시 초기 가격 계산
                updateTotalPrice();
            }
        }

        function changeQuantity(delta) {
            let quantityInput = document.getElementById('quantity');
            let currentQuantity = parseInt(quantityInput.value);
            let newQuantity = currentQuantity + delta;
            let maxQuantity = parseInt(quantityInput.max); // input의 max 속성값 가져오기

            if (newQuantity >= 1 && newQuantity <= maxQuantity) {
                quantityInput.value = newQuantity;
                updateTotalPrice(); // 수량 변경 시 총 가격 업데이트
            }
        }

        // 총 가격 업데이트 함수
        function updateTotalPrice() {
            let quantity = parseInt(document.getElementById('quantity').value);
            let unitPrice = parseFloat(document.getElementById('final-unit-price').value);

            // 총 가격 계산
            let totalPrice = unitPrice * quantity;

            // 가격을 천 단위 구분자와 함께 표시
            let formattedPrice = Math.floor(totalPrice).toLocaleString('ko-KR') + '원';

            // 총 가격 표시 업데이트
            document.getElementById('total-price').textContent = formattedPrice;
        }

        $(document).ready(() => {
            product_detail.init();
        });
    </script>

    <style>
        .product-detail-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
            overflow: hidden;
            margin: 30px 0;
            border: 1px solid #e5e5e5;
        }

        .product-image {
            width: 100%;
            max-width: 500px;
            height: 400px;
            object-fit: cover;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            border: 1px solid #ddd;
        }

        .product-title {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 20px;
            color: #1a1a1a;
        }

        .price-section {
            margin: 20px 0;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 10px;
            border-left: 4px solid #333;
        }

        .current-price {
            font-size: 2rem;
            font-weight: bold;
            color: #1a1a1a;
            margin-right: 15px;
        }

        .discount-rate {
            background: #e74c3c;
            color: white;
            padding: 4px 12px;
            border-radius: 15px;
            font-size: 14px;
            font-weight: bold;
        }

        .product-info {
            margin: 20px 0;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #eee;
        }

        .info-label {
            font-weight: 600;
            color: #666;
        }

        .info-value {
            color: #333;
        }

        .quantity-section {
            display: flex;
            align-items: center;
            gap: 15px;
            margin: 30px 0;
        }

        .quantity-controls {
            display: flex;
            align-items: center;
            border: 2px solid #ddd;
            border-radius: 8px;
            overflow: hidden;
        }

        .quantity-btn {
            width: 40px;
            height: 40px;
            border: none;
            background: #f8f9fa;
            cursor: pointer;
            font-weight: bold;
            font-size: 18px;
            transition: all 0.3s;
        }

        .quantity-btn:hover {
            background: #333;
            color: white;
        }

        .quantity-input {
            width: 60px;
            height: 40px;
            border: none;
            text-align: center;
            font-weight: bold;
            font-size: 16px;
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            margin: 30px 0;
        }

        .btn-modern {
            padding: 15px 30px;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            flex: 1;
            min-height: 50px;
        }

        .btn-primary-modern {
            background: #1a1a1a;
            color: white;
        }

        .btn-primary-modern:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.3);
            background: #333;
        }

        .btn-secondary-modern {
            background: white;
            color: #1a1a1a;
            border: 2px solid #1a1a1a;
        }

        .btn-secondary-modern:hover {
            background: #1a1a1a;
            color: white;
        }

        .btn-back {
            background: #666;
            color: white;
            margin-bottom: 20px;
        }

        .btn-back:hover {
            background: #333;
        }

        .breadcrumb-section {
            background: #1a1a1a;
            color: white;
            padding: 15px 30px;
            margin-bottom: 0;
        }

        .breadcrumb-section a {
            color: #ccc;
            text-decoration: none;
        }

        .breadcrumb-section a:hover {
            color: white;
        }

        /* 드롭다운 메뉴 스타일 */
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
            color: #1a1a1a;
            text-decoration: none;
        }

        .dropdown-divider {
            margin: 5px 0;
        }

        .dropdown-item i {
            margin-right: 8px;
            width: 16px;
        }

        @media (max-width: 768px) {
            .product-title {
                font-size: 2rem;
            }

            .current-price {
                font-size: 1.8rem;
            }

            .action-buttons {
                flex-direction: column;
            }
        }
    </style>
</head>

<body class="sub_page">
<div class="hero_area">
    <!-- header section strats -->
    <header class="header_section">
        <div class="container">
            <nav class="navbar navbar-expand-lg custom_nav-container ">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                    <img width="250" src="${pageContext.request.contextPath}/views/images/logo.png" alt="#" />
                </a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class=""> </span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/">Home <span class="sr-only">(current)</span></a>
                        </li>
                        <li class="nav-item active">
                            <a class="nav-link" href="${pageContext.request.contextPath}/product">Products</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/about">About</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/testimonial">Testimonial</a>
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
                                    <c:otherwise>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/info">
                                            <i class="fa fa-user" aria-hidden="true"></i> ${sessionScope.logincust.custName}
                                        </a>
                                        <div class="dropdown-divider"></div>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                            <i class="fa fa-sign-out" aria-hidden="true"></i> Log Out
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </li>

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
                    </ul>
                </div>
            </nav>
        </div>
    </header>
    <!-- end header section -->
</div>

<!-- breadcrumb section -->
<div class="breadcrumb-section">
    <a href="${pageContext.request.contextPath}/">홈</a> >
    <a href="${pageContext.request.contextPath}/product">제품</a> >
    ${product.productName}
</div>

<!-- product detail section -->
<section class="product_section layout_padding">
    <div class="container">
        <div class="product-detail-container">
            <div class="row p-4">
                <!-- 뒤로가기 버튼 -->
                <div class="col-12">
                    <button type="button" class="btn btn-modern btn-back" id="back_btn">
                        <i class="fa fa-arrow-left"></i> 뒤로가기
                    </button>
                </div>

                <!-- 제품 이미지 -->
                <div class="col-md-6">
                    <div class="text-center">
                        <img src="${pageContext.request.contextPath}/views/images/${product.productImg}"
                             alt="${product.productName}" class="product-image">
                    </div>
                </div>

                <!-- 제품 정보 -->
                <div class="col-md-6">
                    <h1 class="product-title">${product.productName}</h1>

                    <!-- 가격 정보 -->
                    <div class="price-section">
                        <c:choose>
                            <c:when test="${product.discountRate > 0}">
                                <!-- 할인율이 0.1 형태(10%)인지 70 형태(70%)인지 확인 -->
                                <c:set var="displayDiscountRate" value="${product.discountRate > 1 ? product.discountRate : product.discountRate * 100}" />
                                <c:set var="actualDiscountRate" value="${product.discountRate > 1 ? product.discountRate / 100 : product.discountRate}" />
                                <c:set var="discountedPrice" value="${product.productPrice * (1 - actualDiscountRate)}" />

                                <!-- 단위 가격 표시 -->
                                <div style="margin-bottom: 15px; padding-bottom: 10px; border-bottom: 1px solid #ddd;">
                                    <span style="font-size: 1.2rem; color: #666; margin-right: 10px;">단위 가격:</span>
                                    <span class="current-price" id="unit-price" style="font-size: 1.5rem;">
                                        <fmt:formatNumber type="number" pattern="###,###원" value="${discountedPrice}" />
                                    </span>
                                    <span style="font-size: 1.2rem; color: #999; text-decoration: line-through; margin-left: 10px;">
                                        <fmt:formatNumber type="number" pattern="###,###원" value="${product.productPrice}" />
                                    </span>
                                    <span class="discount-rate" style="margin-left: 10px;">
                                        <fmt:formatNumber type="number" pattern="##" value="${displayDiscountRate}" />% 할인
                                    </span>
                                </div>

                                <!-- 총 가격 표시 -->
                                <div>
                                    <span style="font-size: 1.4rem; color: #666; margin-right: 10px;">총 가격:</span>
                                    <span class="current-price" id="total-price" style="font-size: 2.2rem; color: #e74c3c;">
                                        <fmt:formatNumber type="number" pattern="###,###원" value="${discountedPrice}" />
                                    </span>
                                </div>

                                <!-- 숨겨진 필드 -->
                                <input type="hidden" id="original-price" value="${product.productPrice}" />
                                <input type="hidden" id="discount-rate" value="${actualDiscountRate}" />
                                <input type="hidden" id="final-unit-price" value="${discountedPrice}" />
                            </c:when>
                            <c:otherwise>
                                <!-- 단위 가격 표시 -->
                                <div style="margin-bottom: 15px; padding-bottom: 10px; border-bottom: 1px solid #ddd;">
                                    <span style="font-size: 1.2rem; color: #666; margin-right: 10px;">단위 가격:</span>
                                    <span class="current-price" id="unit-price" style="font-size: 1.5rem;">
                                        <fmt:formatNumber type="number" pattern="###,###원" value="${product.productPrice}" />
                                    </span>
                                </div>

                                <!-- 총 가격 표시 -->
                                <div>
                                    <span style="font-size: 1.4rem; color: #666; margin-right: 10px;">총 가격:</span>
                                    <span class="current-price" id="total-price" style="font-size: 2.2rem; color: #e74c3c;">
                                        <fmt:formatNumber type="number" pattern="###,###원" value="${product.productPrice}" />
                                    </span>
                                </div>

                                <!-- 숨겨진 필드 -->
                                <input type="hidden" id="original-price" value="${product.productPrice}" />
                                <input type="hidden" id="discount-rate" value="0" />
                                <input type="hidden" id="final-unit-price" value="${product.productPrice}" />
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- 제품 상세 정보 -->
                    <div class="product-info">
                        <div class="info-row">
                            <span class="info-label">상품 ID:</span>
                            <span class="info-value">${product.productId}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">카테고리:</span>
                            <span class="info-value">${product.categoryId}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">등록일:</span>
                            <span class="info-value">
                                    <fmt:parseDate value="${product.productRegdate}"
                                                   pattern="yyyy-MM-dd HH:mm:ss" var="parsedDateTime" type="both" />
                                    <fmt:formatDate pattern="yyyy년 MM월 dd일" value="${parsedDateTime}" />
                                </span>
                        </div>
                        <c:if test="${product.productUpdate != null}">
                            <div class="info-row">
                                <span class="info-label">수정일:</span>
                                <span class="info-value">
                                        <fmt:parseDate value="${product.productUpdate}"
                                                       pattern="yyyy-MM-dd HH:mm:ss" var="parsedDateTime" type="both" />
                                        <fmt:formatDate pattern="yyyy년 MM월 dd일" value="${parsedDateTime}" />
                                    </span>
                            </div>
                        </c:if>
                    </div>

                    <!-- 상품 설명 섹션 -->
                    <div class="product-description" style="margin: 20px 0; padding: 20px; background: #f8f9fa; border-radius: 10px; border-left: 4px solid #007bff;">
                        <h5 style="color: #333; margin-bottom: 15px; font-weight: 600;">상품 설명</h5>
                        <div style="color: #666; line-height: 1.6;">
                            <c:choose>
                                <c:when test="${product.description != null && !empty product.description}">
                                    ${product.description}
                                </c:when>
                                <c:otherwise>
                                    이 상품에 대한 자세한 설명이 준비 중입니다.
                                    <br>궁금한 사항이 있으시면 고객센터로 문의해 주세요.
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <!-- 수량 선택 -->
                    <div class="quantity-section">
                        <label for="quantity" class="info-label">수량:</label>
                        <div class="quantity-controls">
                            <button type="button" class="quantity-btn" onclick="changeQuantity(-1)">-</button>
                            <input type="number" id="quantity" class="quantity-input" value="1" min="1" max="99" onchange="updateTotalPrice()">
                            <button type="button" class="quantity-btn" onclick="changeQuantity(1)">+</button>
                        </div>
                    </div>

                    <!-- 액션 버튼 -->
                    <div class="action-buttons">
                        <button type="button" class="btn btn-modern btn-primary-modern" id="add_to_cart_btn">
                            <i class="fa fa-shopping-cart"></i> 장바구니 담기
                        </button>
                        <button type="button" class="btn btn-modern btn-secondary-modern" id="buy_now_btn">
                            <i class="fa fa-credit-card"></i> 바로 구매
                        </button>
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
                    <h4>Contact Us</h4>
                    <div class="contact_link_box">
                        <a href="">
                            <i class="fa fa-map-marker" aria-hidden="true"></i>
                            <span>Location</span>
                        </a>
                        <a href="">
                            <i class="fa fa-phone" aria-hidden="true"></i>
                            <span>Call +01 1234567890</span>
                        </a>
                        <a href="">
                            <i class="fa fa-envelope" aria-hidden="true"></i>
                            <span>demo@gmail.com</span>
                        </a>
                    </div>
                </div>
            </div>
            <div class="col-md-4 footer-col">
                <div class="footer_detail">
                    <a href="" class="footer-logo">Famms</a>
                    <p>Necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with</p>
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
                        <a href="">
                            <i class="fa fa-pinterest" aria-hidden="true"></i>
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
            <p>&copy; <span id="displayYear"></span> All Rights Reserved By <a href="https://html.design/">Free Html Templates</a></p>
        </div>
    </div>
</footer>
<!-- footer section -->

<!-- jQery -->
<script src="${pageContext.request.contextPath}/views/js/jquery-3.4.1.min.js"></script>
<!-- popper js -->
<script src="${pageContext.request.contextPath}/views/js/popper.min.js"></script>
<!-- bootstrap js -->
<script src="${pageContext.request.contextPath}/views/js/bootstrap.js"></script>
<!-- custom js -->
<script src="${pageContext.request.contextPath}/views/js/custom.js"></script>

</body>
</html>