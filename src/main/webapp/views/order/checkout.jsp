<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>주문서 작성 - Shop Project Team 5</title>

    <!-- bootstrap core css -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/views/css/bootstrap.css" />
    <!-- font awesome style -->
    <link href="${pageContext.request.contextPath}/views/css/font-awesome.min.css" rel="stylesheet" />
    <!-- Custom styles -->
    <link href="${pageContext.request.contextPath}/views/css/style.css" rel="stylesheet" />
    <!-- responsive style -->
    <link href="${pageContext.request.contextPath}/views/css/responsive.css" rel="stylesheet" />

    <!-- Custom styles for order page -->
    <style>
        .address-section {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin: 20px 0;
            border: 1px solid #e9ecef;
            position: relative;
        }

        .address-info {
            line-height: 1.8;
            color: #495057;
        }

        .address-name {
            font-weight: bold;
            color: #343a40;
            font-size: 16px;
            margin-bottom: 8px;
        }

        .address-detail {
            margin-bottom: 5px;
            color: #6c757d;
        }

        .btn-address-edit {
            position: absolute;
            top: 15px;
            right: 15px;
            background: #007bff;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            font-size: 14px;
            text-decoration: none;
            transition: background-color 0.2s;
            cursor: pointer;
        }

        .btn-address-edit:hover {
            background: #0056b3;
            color: white;
            text-decoration: none;
        }

        .no-address {
            text-align: center;
            color: #6c757d;
            font-style: italic;
            padding: 20px;
        }

        /* 배송지 변경 모달 스타일 */
        .address-modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
        }

        .address-modal-content {
            background-color: white;
            margin: 5% auto;
            padding: 0;
            border-radius: 8px;
            width: 90%;
            max-width: 600px;
            max-height: 80vh;
            overflow-y: auto;
        }

        .address-modal-header {
            padding: 20px;
            border-bottom: 1px solid #e9ecef;
            background: #f8f9fa;
            border-radius: 8px 8px 0 0;
        }

        .address-modal-body {
            padding: 20px;
        }

        .address-modal-footer {
            padding: 15px 20px;
            border-top: 1px solid #e9ecef;
            text-align: right;
            background: #f8f9fa;
            border-radius: 0 0 8px 8px;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }

        .close:hover {
            color: black;
        }

        .order-item {
            padding: 15px 0;
            border-bottom: 1px solid #e9ecef;
        }

        .order-item:last-child {
            border-bottom: none;
        }

        .price-original {
            text-decoration: line-through;
            color: #6c757d;
            font-size: 0.9em;
        }

        .price-discounted {
            color: #dc3545;
            font-weight: bold;
        }

        .discount-badge {
            background: #dc3545;
            color: white;
            font-size: 0.8em;
            padding: 2px 6px;
            border-radius: 3px;
            margin-left: 5px;
        }

        .total-section {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-top: 20px;
        }

        .total-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            padding: 8px 0;
        }

        .total-row:last-child {
            border-top: 2px solid #dee2e6;
            margin-top: 10px;
            padding-top: 15px;
            font-weight: bold;
            font-size: 1.2em;
            color: #dc3545;
        }

        .address-option {
            background: white;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
            cursor: pointer;
            transition: all 0.2s;
        }

        .address-option:hover {
            border-color: #007bff;
        }

        .address-option.selected {
            border-color: #007bff;
            background: #e7f3ff;
        }

        .address-option input[type="radio"] {
            margin-right: 10px;
        }

        .payment-methods .form-check {
            border: 1px solid #e9ecef;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 10px;
            transition: all 0.3s;
        }

        .payment-methods .form-check:hover {
            border-color: #007bff;
            box-shadow: 0 2px 4px rgba(0,123,255,0.1);
        }

        .payment-methods .form-check-input:checked + .form-check-label {
            color: #007bff;
            font-weight: 500;
        }

        .payment-methods .form-check-input:checked {
            background-color: #007bff;
            border-color: #007bff;
        }

        .payment-methods .form-check-label {
            cursor: pointer;
            display: block;
            width: 100%;
        }

        .payment-methods .form-check-label i {
            font-size: 1.2em;
            margin-right: 8px;
        }

        #paymentInfo {
            border-left: 4px solid #007bff;
        }
    </style>

    <!-- jQuery -->
    <script src="${pageContext.request.contextPath}/views/js/jquery-3.4.1.min.js"></script>
    <!-- Bootstrap JavaScript -->
    <script src="${pageContext.request.contextPath}/views/js/bootstrap.js"></script>
</head>

<body class="sub_page">

<div class="hero_area">
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
                                    <%-- 사람 아이콘으로 구성된 드롭다운 트리거 --%>
                                <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                                   data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="color: #000;">
                                    <!-- 사람 아이콘 SVG -->
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                         fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                        <circle cx="12" cy="7" r="4"/><!-- 머리 -->
                                        <path d="M6 21v-2a4 4 0 0 1 4-4h4a4 4 0 0 1 4 4v2"/><!-- 몸통 -->
                                    </svg>
                                    <span class="nav-label"><span class="caret"></span></span>
                                </a>

                                    <%-- 드롭다운 메뉴 내용 --%>
                                <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
                                    <c:if test="${sessionScope.logincust != null}">
                                        <%-- 사용자 프로필 메뉴 (사용자 이름 표시) --%>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/info">
                                            <i class="fa fa-user" aria-hidden="true"></i> ${sessionScope.logincust.custName}
                                        </a>

                                        <%-- 주문 내역 메뉴 추가 --%>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/order/history">
                                            <i class="fa fa-list-alt" aria-hidden="true"></i> 주문 내역
                                        </a>

                                        <%-- 배송지 관리 메뉴 --%>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/address">
                                            <i class="fa fa-map-marker" aria-hidden="true"></i> 배송지 관리
                                        </a>

                                        <%-- 구분선 --%>
                                        <div class="dropdown-divider"></div>

                                        <%-- 로그아웃 메뉴 --%>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                            <i class="fa fa-sign-out" aria-hidden="true"></i> 로그아웃
                                        </a>
                                    </c:if>
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
</div>

<!-- 주문서 작성 화면 -->
<section class="product_section layout_padding" style="padding-top: 40px;">
    <div class="container">
        <div class="heading_container heading_center" style="margin-bottom: 30px;">
            <h2>주문서 <span>작성</span></h2>
        </div>

        <!-- 에러 메시지 표시 -->
        <c:if test="${error != null}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fa fa-exclamation-triangle"></i> ${error}
                <button type="button" class="close" data-dismiss="alert">&times;</button>
            </div>
        </c:if>

        <div class="row">
            <div class="col-md-8">
                <!-- 고객 정보 표시 -->
                <div class="card mb-3">
                    <div class="card-header">
                        <h5><i class="fa fa-user"></i> 주문자 정보</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <strong>이름:</strong> ${sessionScope.logincust.custName}
                            </div>
                            <div class="col-md-6">
                                <strong>이메일:</strong> ${sessionScope.logincust.custEmail}
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 배송 정보 입력 폼 -->
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5><i class="fa fa-truck"></i> 배송 정보</h5>
                        <c:choose>
                            <c:when test="${orderType == 'direct'}">
                                <a href="${pageContext.request.contextPath}/address?returnUrl=direct&productId=${product.productId}&quantity=${quantity}" class="btn btn-secondary btn-sm">
                                    <i class="fa fa-cog"></i> 배송지 관리
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/address?returnUrl=order" class="btn btn-secondary btn-sm">
                                    <i class="fa fa-cog"></i> 배송지 관리
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="card-body">
                        <form id="orderForm" action="${pageContext.request.contextPath}/order/submit" method="post">
                            <!-- 주문 타입 히든 필드 -->
                            <c:choose>
                                <c:when test="${cartItems != null && !empty cartItems}">
                                    <input type="hidden" name="orderType" value="cart">
                                </c:when>
                                <c:otherwise>
                                    <input type="hidden" name="orderType" value="direct">
                                    <input type="hidden" name="productId" value="${product.productId}">
                                    <input type="hidden" name="quantity" value="${quantity}">
                                </c:otherwise>
                            </c:choose>

                            <!-- 배송지 정보 섹션 -->
                            <div class="address-section">
                                <h6><i class="fa fa-map-marker"></i> 배송지 정보</h6>
                                <c:choose>
                                    <c:when test="${not empty defaultAddress}">
                                        <div class="address-info" id="selectedAddressInfo">
                                            <div class="address-name">${defaultAddress.addressName}
                                                <c:if test="${defaultAddress.isDefault()}">
                                                    <span class="badge badge-primary">기본</span>
                                                </c:if>
                                            </div>
                                            <div class="address-detail">${defaultAddress.address}</div>
                                            <c:if test="${not empty defaultAddress.detailAddress}">
                                                <div class="address-detail">${defaultAddress.detailAddress}</div>
                                            </c:if>
                                            <div class="address-detail" style="color: #6c757d; font-size: 14px;">
                                                우편번호: ${defaultAddress.postalCode}
                                            </div>
                                        </div>
                                        <button type="button" class="btn-address-edit" onclick="openAddressModal()">
                                            <i class="fa fa-edit"></i> 배송지 변경
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="no-address">
                                            <i class="fa fa-exclamation-circle"></i>
                                            등록된 배송지가 없습니다.
                                            <c:choose>
                                                <c:when test="${orderType == 'direct'}">
                                                    <a href="${pageContext.request.contextPath}/address?returnUrl=direct&productId=${product.productId}&quantity=${quantity}">배송지를 등록해주세요</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="${pageContext.request.contextPath}/address?returnUrl=order">배송지를 등록해주세요</a>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <!-- 히든 필드 -->
                            <input type="hidden" name="selectedAddress" id="selectedAddressId" value="${defaultAddress.addressId}">

                            <div class="form-group">
                                <label for="orderMemo">주문 메모</label>
                                <textarea class="form-control" id="orderMemo" name="orderMemo"
                                          rows="2" placeholder="배송 시 요청사항이 있으시면 입력해주세요 (선택사항)"></textarea>
                            </div>

                            <div class="text-center mt-4">
                                <button type="button" class="btn btn-secondary mr-3" onclick="history.back()">
                                    <i class="fa fa-arrow-left"></i> 이전으로
                                </button>
                                <button type="submit" class="btn btn-success btn-lg" id="orderBtn">
                                    <i class="fa fa-credit-card"></i> 주문 완료
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <!-- 주문 요약 -->
                <div class="card">
                    <div class="card-header">
                        <h5><i class="fa fa-shopping-cart"></i> 주문 요약</h5>
                    </div>
                    <div class="card-body">
                        <!-- 주문 상품 목록 표시 -->
                        <c:choose>
                            <%-- 장바구니에서 주문하는 경우 --%>
                            <c:when test="${cartItems != null && !empty cartItems}">
                                <c:set var="totalOriginalPrice" value="0" />
                                <c:set var="totalDiscountedPrice" value="0" />

                                <c:forEach var="item" items="${cartItems}">
                                    <!-- 할인 가격 계산 -->
                                    <c:set var="actualDiscountRate" value="${item.discountRate > 1 ? item.discountRate / 100 : item.discountRate}" />
                                    <c:set var="discountedPrice" value="${item.productPrice * (1 - actualDiscountRate)}" />
                                    <c:set var="itemOriginalTotal" value="${item.productPrice * item.productQt}" />
                                    <c:set var="itemDiscountedTotal" value="${discountedPrice * item.productQt}" />

                                    <!-- 총합 계산 -->
                                    <c:set var="totalOriginalPrice" value="${totalOriginalPrice + itemOriginalTotal}" />
                                    <c:set var="totalDiscountedPrice" value="${totalDiscountedPrice + itemDiscountedTotal}" />

                                    <div class="order-item">
                                        <div class="d-flex justify-content-between align-items-start">
                                            <div style="flex: 1;">
                                                <h6 class="mb-1">${item.productName}</h6>
                                                <small class="text-muted">수량: ${item.productQt}개</small>

                                                <!-- 가격 표시 -->
                                                <div class="mt-2">
                                                    <c:choose>
                                                        <c:when test="${item.discountRate > 0}">
                                                            <!-- 할인이 있는 경우 -->
                                                            <div class="price-original">
                                                                <fmt:formatNumber value="${itemOriginalTotal}" pattern="#,###" />원
                                                            </div>
                                                            <div class="price-discounted">
                                                                <fmt:formatNumber value="${itemDiscountedTotal}" pattern="#,###" />원
                                                                <span class="discount-badge">
                                                                    <fmt:formatNumber value="${item.discountRate > 1 ? item.discountRate : item.discountRate * 100}" pattern="##" />% 할인
                                                                </span>
                                                            </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <!-- 할인이 없는 경우 -->
                                                            <div class="price-discounted">
                                                                <fmt:formatNumber value="${itemOriginalTotal}" pattern="#,###" />원
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>

                            <%-- 직접 주문하는 경우 --%>
                            <c:when test="${product != null}">
                                <!-- 할인 가격 계산 -->
                                <c:set var="actualDiscountRate" value="${product.discountRate > 1 ? product.discountRate / 100 : product.discountRate}" />
                                <c:set var="discountedPrice" value="${product.productPrice * (1 - actualDiscountRate)}" />
                                <c:set var="totalOriginalPrice" value="${product.productPrice * quantity}" />
                                <c:set var="totalDiscountedPrice" value="${discountedPrice * quantity}" />

                                <div class="order-item">
                                    <div class="d-flex justify-content-between align-items-start">
                                        <div style="flex: 1;">
                                            <h6 class="mb-1">${product.productName}</h6>
                                            <small class="text-muted">수량: ${quantity}개</small>

                                            <!-- 가격 표시 -->
                                            <div class="mt-2">
                                                <c:choose>
                                                    <c:when test="${product.discountRate > 0}">
                                                        <!-- 할인이 있는 경우 -->
                                                        <div class="price-original">
                                                            <fmt:formatNumber value="${totalOriginalPrice}" pattern="#,###" />원
                                                        </div>
                                                        <div class="price-discounted">
                                                            <fmt:formatNumber value="${totalDiscountedPrice}" pattern="#,###" />원
                                                            <span class="discount-badge">
                                                                <fmt:formatNumber value="${product.discountRate > 1 ? product.discountRate : product.discountRate * 100}" pattern="##" />% 할인
                                                            </span>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <!-- 할인이 없는 경우 -->
                                                        <div class="price-discounted">
                                                            <fmt:formatNumber value="${totalOriginalPrice}" pattern="#,###" />원
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:when>
                        </c:choose>

                        <!-- 주문 총합 -->
                        <div class="total-section">
                            <c:set var="totalSavings" value="${totalOriginalPrice - totalDiscountedPrice}" />

                            <div class="total-row">
                                <span>상품 금액:</span>
                                <span><fmt:formatNumber value="${totalOriginalPrice}" pattern="#,###" />원</span>
                            </div>

                            <c:if test="${totalSavings > 0}">
                                <div class="total-row">
                                    <span style="color: #dc3545;">할인:</span>
                                    <span style="color: #dc3545;">-<fmt:formatNumber value="${totalSavings}" pattern="#,###" />원</span>
                                </div>
                            </c:if>

                            <div class="total-row">
                                <span>배송비:</span>
                                <span style="color: #28a745;">무료</span>
                            </div>

                            <div class="total-row">
                                <span>총 결제금액:</span>
                                <span><fmt:formatNumber value="${totalDiscountedPrice}" pattern="###,###" />원</span>
                            </div>
                        </div>

                        <!-- 결제 방법 선택 -->
                        <div class="mt-3">
                            <h6>결제 방법</h6>
                            <div class="payment-methods">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="paymentMethod" id="creditCard" value="creditCard" checked>
                                    <label class="form-check-label" for="creditCard">
                                        <i class="fa fa-credit-card text-primary"></i> 신용카드
                                        <small class="text-muted d-block">간편하고 안전한 카드결제</small>
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="paymentMethod" id="bankTransfer" value="bankTransfer">
                                    <label class="form-check-label" for="bankTransfer">
                                        <i class="fa fa-university text-info"></i> 무통장입금
                                        <small class="text-muted d-block">계좌이체로 결제</small>
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="paymentMethod" id="kakaoPay" value="kakaoPay">
                                    <label class="form-check-label" for="kakaoPay">
                                        <i class="fa fa-mobile text-warning"></i> 카카오페이
                                        <small class="text-muted d-block">카카오톡으로 간편결제</small>
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="paymentMethod" id="naverPay" value="naverPay">
                                    <label class="form-check-label" for="naverPay">
                                        <i class="fa fa-credit-card-alt text-success"></i> 네이버페이
                                        <small class="text-muted d-block">네이버 간편결제</small>
                                    </label>
                                </div>
                            </div>

                            <!-- 결제 정보 표시 영역 -->
                            <div id="paymentInfo" class="mt-3 p-3 bg-light rounded" style="display: none;">
                                <div id="creditCardInfo" class="payment-detail">
                                    <h6>💳 신용카드 결제</h6>
                                    <p class="text-muted">안전한 SSL 암호화로 보호되는 카드결제입니다.</p>
                                </div>
                                <div id="bankTransferInfo" class="payment-detail" style="display: none;">
                                    <h6>🏦 무통장입금 안내</h6>
                                    <div class="bank-info">
                                        <p><strong>입금계좌:</strong> 신한은행 100-123-456789</p>
                                        <p><strong>예금주:</strong> Team5 쇼핑몰</p>
                                        <p class="text-danger"><small>⚠️ 주문 후 24시간 내 입금해주세요.</small></p>
                                    </div>
                                </div>
                                <div id="kakaoPayInfo" class="payment-detail" style="display: none;">
                                    <h6>📱 카카오페이</h6>
                                    <p class="text-muted">카카오톡 앱에서 간편하게 결제하세요.</p>
                                </div>
                                <div id="naverPayInfo" class="payment-detail" style="display: none;">
                                    <h6>🟢 네이버페이</h6>
                                    <p class="text-muted">네이버 ID로 간편하게 결제하세요.</p>
                                </div>
                            </div>
                        </div>

                        <!-- 주문 안내 -->
                        <div class="mt-3">
                            <h6><i class="fa fa-info-circle"></i> 주문 안내</h6>
                            <ul style="font-size: 0.9em; color: #6c757d; padding-left: 20px;">
                                <li>주문 확인 후 변경이 어려우니 신중하게 검토해주세요.</li>
                                <li>배송은 영업일 기준 2-3일 소요됩니다.</li>
                                <li>무료배송 기준: 50,000원 이상 구매시</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- 배송지 변경 모달 -->
<div id="addressModal" class="address-modal">
    <div class="address-modal-content">
        <div class="address-modal-header">
            <h5>배송지 변경</h5>
            <span class="close" onclick="closeAddressModal()">&times;</span>
        </div>
        <div class="address-modal-body">
            <c:if test="${not empty addresses}">
                <c:forEach var="addr" items="${addresses}">
                    <div class="address-option ${addr.isDefault() ? 'selected' : ''}" onclick="selectModalAddress(this, ${addr.addressId})">
                        <input type="radio" name="modalAddress" value="${addr.addressId}" ${addr.isDefault() ? 'checked' : ''}>
                        <div class="address-info">
                            <div class="address-name">${addr.addressName}
                                <c:if test="${addr.isDefault()}">
                                    <span class="badge badge-primary">기본</span>
                                </c:if>
                            </div>
                            <div class="address-detail">${addr.address}</div>
                            <c:if test="${not empty addr.detailAddress}">
                                <div class="address-detail">${addr.detailAddress}</div>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
        </div>
        <div class="address-modal-footer">
            <button type="button" class="btn btn-secondary" onclick="closeAddressModal()">취소</button>
            <button type="button" class="btn btn-primary" onclick="confirmAddressChange()">확인</button>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        // 결제 방법 변경 이벤트
        $('input[name="paymentMethod"]').change(function() {
            var selectedMethod = $(this).val();
            showPaymentInfo(selectedMethod);
        });

        // 초기 선택된 결제 방법 정보 표시
        showPaymentInfo('creditCard');

        // 주문 폼 제출 처리 - 결제 방법 추가 로직
        $('#orderForm').on('submit', function(e) {
            e.preventDefault();

            // 배송지 선택 검증
            const selectedAddressId = $('#selectedAddressId').val();
            if (!selectedAddressId) {
                alert('배송지를 선택해주세요.');
                return false;
            }

            // 결제 방법 가져와서 hidden field로 추가
            const selectedPaymentMethod = $('input[name="paymentMethod"]:checked').val();
            if (!selectedPaymentMethod) {
                alert('결제 방법을 선택해주세요.');
                return false;
            }

            // 기존 paymentMethod hidden field 제거 후 새로 추가
            $('#orderForm input[name="paymentMethod"][type="hidden"]').remove();
            $('#orderForm').append('<input type="hidden" name="paymentMethod" value="' + selectedPaymentMethod + '">');

            // 최종 확인
            if (confirm('주문하시겠습니까?')) {
                $('#orderBtn').prop('disabled', true).html('<i class="fa fa-spinner fa-spin"></i> 처리중...');
                this.submit();
            }
        });
    });

    function showPaymentInfo(method) {
        // 모든 결제 정보 숨기기
        $('.payment-detail').hide();

        // 선택된 결제 방법 정보 표시
        $('#paymentInfo').show();
        $('#' + method + 'Info').show();

        // 결제 버튼 텍스트 변경
        var buttonText = '';
        switch(method) {
            case 'creditCard':
                buttonText = '<i class="fa fa-credit-card"></i> 카드로 결제하기';
                break;
            case 'bankTransfer':
                buttonText = '<i class="fa fa-university"></i> 주문 완료 (입금대기)';
                break;
            case 'kakaoPay':
                buttonText = '<i class="fa fa-mobile"></i> 카카오페이로 결제';
                break;
            case 'naverPay':
                buttonText = '<i class="fa fa-credit-card-alt"></i> 네이버페이로 결제';
                break;
            default:
                buttonText = '<i class="fa fa-credit-card"></i> 주문 완료';
        }
        $('#orderBtn').html(buttonText);
    }

    function openAddressModal() {
        $('#addressModal').show();
    }

    function closeAddressModal() {
        $('#addressModal').hide();
    }

    function selectModalAddress(element, addressId) {
        $('.address-option').removeClass('selected');
        $(element).addClass('selected');
        $(element).find('input[type="radio"]').prop('checked', true);
    }

    function confirmAddressChange() {
        const selectedAddressId = $('input[name="modalAddress"]:checked').val();
        const selectedOption = $('input[name="modalAddress"]:checked').closest('.address-option');

        // 선택된 배송지 정보 가져오기
        const addressName = selectedOption.find('.address-name').text().trim();
        const addressDetail = selectedOption.find('.address-detail').first().text();

        // 주문서의 배송지 정보 업데이트
        $('#selectedAddressInfo .address-name').text(addressName);
        $('#selectedAddressInfo .address-detail').first().text(addressDetail);
        $('#selectedAddressId').val(selectedAddressId);

        closeAddressModal();
    }
</script>

<%-- 푸터 섹션 시작 --%>
<footer>
    <div class="container">
        <div class="row justify-content-center">
            <%-- 회사 로고 --%>
            <div class="col-md-3 pr-md-4">
                <div class="logo_footer">
                    <a href="${pageContext.request.contextPath}/">
                        <img width="210" src="${pageContext.request.contextPath}/views/images/logo.png" alt="로고" />
                    </a>
                </div>
            </div>
            <!-- 정보 (주소 + GitHub) -->
            <div class="col-md-4 pr-md-4">
                <div class="information_f">
                    <p style="margin-bottom: 0.5rem;">
                        <strong>ADDRESS:</strong><br/>
                        충청남도 아산시 탕정면 선문로 221번길 70 선문대학교
                    </p>
                    <p style="margin-bottom: 0;">
                        <strong>GITHUB:</strong>
                        <a href="https://github.com/Rediaum/Team5Project"
                           class="black-link"
                           target="_blank" rel="noopener noreferrer">
                            Team5Project
                        </a>
                    </p>
                </div>
            </div>
            <!-- 네비게이션 메뉴 -->
            <div class="col-md-2">
                <div class="footer-menu">
                    <h5>Menu</h5>
                    <ul class="list-unstyled d-flex flex-column gap-2">
                        <li><a href="${pageContext.request.contextPath}/" class="text-dark">Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/about" class="text-dark">About</a></li>
                        <li><a href="${pageContext.request.contextPath}/testimonial" class="text-dark">Testimonial</a></li>
                        <c:if test="${role ne 'admin'}">
                            <li><a href="${pageContext.request.contextPath}/product" class="text-dark">Products</a></li>
                            <li><a href="${pageContext.request.contextPath}/contact" class="text-dark">Contact</a></li>
                        </c:if>
                        <c:if test="${role eq 'admin'}">
                            <li><a href="${pageContext.request.contextPath}/admin/inventory" class="text-dark">Inventory</a></li>
                            <li><a href="${pageContext.request.contextPath}/admin/customerList" class="text-dark">Customer</a></li>
                        </c:if>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</footer>
<!-- footer end -->

<%-- 저작권 정보 --%>
<div class="cpy_">
    <p class="mx-auto">© 2021 All Rights Reserved By <a href="https://html.design/">Free Html Templates</a><br>
        Distributed By <a href="https://themewagon.com/" target="_blank">ThemeWagon</a>
    </p>
</div>
<!-- footer section -->

<!-- jQery -->
<script src="${pageContext.request.contextPath}/views/js/jquery-3.4.1.min.js"></script>
<!-- popper js -->
<script src="${pageContext.request.contextPath}/views/js/popper.min.js"></script>
<!-- bootstrap js -->
<script src="${pageContext.request.contextPath}/views/js/bootstrap.js"></script>
<!-- custom js -->
<script src="${pageContext.request.contextPath}/views/js/custom.js"></script>

<script>
    $(document).ready(function() {
        // 현재 연도 설정
        $('#displayYear').text(new Date().getFullYear());
    });
</script>

<!-- jQuery 라이브러리 -->
<script src="${pageContext.request.contextPath}/views/js/jquery-3.4.1.min.js"></script>
<!-- Bootstrap Popper.js -->
<script src="${pageContext.request.contextPath}/views/js/popper.min.js"></script>
<!-- Bootstrap JavaScript -->
<script src="${pageContext.request.contextPath}/views/js/bootstrap.js"></script>
<!-- 커스텀 JavaScript -->
<script src="${pageContext.request.contextPath}/views/js/custom.js"></script>

</body>
</html>