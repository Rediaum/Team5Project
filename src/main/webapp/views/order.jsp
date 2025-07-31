<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>주문서 작성 - Team 5 Shop</title>

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
                        <a href="${pageContext.request.contextPath}/address?returnUrl=order" class="btn btn-secondary btn-sm">
                            <i class="fa fa-cog"></i> 배송지 관리
                        </a>
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
                                            <a href="${pageContext.request.contextPath}/address?returnUrl=order">배송지를 등록해주세요</a>
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
                                                <h6 class="mb-1">${item.productId}</h6>
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
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="paymentMethod" id="creditCard" value="creditCard" checked>
                                <label class="form-check-label" for="creditCard">
                                    <i class="fa fa-credit-card"></i> 신용카드
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="paymentMethod" id="bankTransfer" value="bankTransfer">
                                <label class="form-check-label" for="bankTransfer">
                                    <i class="fa fa-university"></i> 무통장입금
                                </label>
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
        // 주문 폼 제출 처리
        $('#orderForm').on('submit', function(e) {
            e.preventDefault();

            // 배송지 선택 검증
            const selectedAddressId = $('#selectedAddressId').val();
            if (!selectedAddressId) {
                alert('배송지를 선택해주세요.');
                return false;
            }

            // 최종 확인
            if (confirm('주문하시겠습니까?')) {
                $('#orderBtn').prop('disabled', true).html('<i class="fa fa-spinner fa-spin"></i> 처리중...');
                this.submit();
            }
        });
    });

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
                    <a href="" class="footer-logo">Electro</a>
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