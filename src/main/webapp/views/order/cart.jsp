<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

  <title>장바구니 - Shop Project Team 5</title>

  <!-- CSS 리소스 -->
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/views/css/bootstrap.css" />
  <link href="${pageContext.request.contextPath}/views/css/font-awesome.min.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/views/css/style.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/views/css/responsive.css" rel="stylesheet" />

  <style>
    /* ===== 장바구니 전용 스타일 ===== */
    .product-name-link {
      color: #333;
      text-decoration: none;
      font-weight: bold;
      transition: color 0.3s ease;
    }

    .product-name-link:hover {
      color: #f7444e;
      text-decoration: none;
    }

    .cart-item-card {
      border: 1px solid #e9ecef;
      border-radius: 10px;
      transition: box-shadow 0.3s ease;
    }

    .cart-item-card:hover {
      box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    }

    .quantity-control {
      max-width: 140px;
    }

    .quantity-control input {
      text-align: center;
      border-left: none;
      border-right: none;
    }

    .quantity-control .btn {
      border: 1px solid #ced4da;
      background: #fff;
      color: #495057;
    }

    .quantity-control .btn:hover {
      background: #f8f9fa;
      color: #f7444e;
    }

    .price-display {
      font-size: 1.1rem;
      font-weight: bold;
      color: #f7444e;
    }

    .discount-badge {
      font-size: 0.8rem;
      padding: 2px 8px;
    }

    .empty-cart-section {
      padding: 80px 0;
      text-align: center;
    }

    .empty-cart-icon {
      font-size: 100px;
      color: #dee2e6;
      margin-bottom: 20px;
    }

    .order-summary-card {
      background: #f8f9fa;
      border: 1px solid #dee2e6;
      border-radius: 10px;
    }
  </style>

  <!-- JavaScript 리소스 -->
  <script src="${pageContext.request.contextPath}/views/js/jquery-3.4.1.min.js"></script>
  <script src="${pageContext.request.contextPath}/views/js/bootstrap.js"></script>
</head>

<body class="sub_page">

<div class="hero_area">
  <!-- ===== 헤더 섹션 ===== -->
  <header class="header_section">
    <div class="container">
      <nav class="navbar navbar-expand-lg custom_nav-container">
        <!-- 로고 -->
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">
          <img width="250" src="${pageContext.request.contextPath}/views/images/logo.png" alt="Team 5 Shop" />
        </a>

        <!-- 모바일 메뉴 토글 -->
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class=""></span>
        </button>

        <!-- 네비게이션 메뉴 -->
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav">
            <!-- Home 메뉴 -->
            <li class="nav-item">
              <a class="nav-link" href="${pageContext.request.contextPath}/">Home</a>
            </li>

            <!-- Pages 드롭다운 -->
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

            <!-- Products 메뉴 -->
            <li class="nav-item">
              <a class="nav-link" href="${pageContext.request.contextPath}/product">Products</a>
            </li>

            <!-- Contact 메뉴 -->
            <li class="nav-item">
              <a class="nav-link" href="${pageContext.request.contextPath}/contact">Contact</a>
            </li>

            <!-- 사용자 관리 드롭다운 -->
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

            <!-- 장바구니 아이콘 (로그인시에만) -->
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

            <!-- 검색 폼 -->
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

<!-- ===== 페이지 헤더 ===== -->
<section class="inner_page_head">
  <div class="container_fuild">
    <div class="row">
      <div class="col-md-12">
        <div class="full">
          <h3>장바구니</h3>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- ===== 메인 컨텐츠 ===== -->
<section class="layout_padding">
  <div class="container">
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
      <div class="col-md-12">
        <!-- 페이지 상단 -->
        <div class="d-flex justify-content-between align-items-center mb-4">
          <h2>
            <i class="fa fa-shopping-cart"></i>
            ${sessionScope.logincust.custName}님의 장바구니
          </h2>
          <a href="${pageContext.request.contextPath}/product" class="btn btn-outline-primary">
            <i class="fa fa-arrow-left"></i> 쇼핑 계속하기
          </a>
        </div>

        <c:choose>
          <%-- 장바구니 비어있음 --%>
          <c:when test="${empty cartItems}">
            <div class="empty-cart-section">
              <i class="fa fa-shopping-cart empty-cart-icon"></i>
              <h3 style="color: #666; margin-bottom: 20px;">장바구니가 비어있습니다</h3>
              <p style="color: #999; margin-bottom: 30px;">원하는 상품을 장바구니에 담아보세요!</p>
              <a href="${pageContext.request.contextPath}/product" class="btn btn-primary btn-lg">
                <i class="fa fa-shopping-bag"></i> 상품 둘러보기
              </a>
            </div>
          </c:when>

          <%-- 장바구니에 상품 있음 --%>
          <c:otherwise>
            <%-- 장바구니 상품 목록 --%>
            <div class="cart-items">
              <c:forEach var="item" items="${cartItems}">
                <%-- 할인율 및 가격 계산 --%>
                <c:set var="actualDiscountRate" value="${item.discountRate > 1 ? item.discountRate / 100 : item.discountRate}" />
                <c:set var="discountedPrice" value="${item.productPrice * (1 - actualDiscountRate)}" />
                <c:set var="itemTotalPrice" value="${discountedPrice * item.productQt}" />

                <div class="card cart-item-card mb-3">
                  <div class="card-body">
                    <div class="row align-items-center">
                        <%-- 상품 이미지 --%>
                      <div class="col-md-2">
                        <a href="${pageContext.request.contextPath}/product/detail/${item.productId}">
                          <img src="${pageContext.request.contextPath}/views/images/${item.productImg}"
                               class="img-fluid rounded" alt="${item.productName}">
                        </a>
                      </div>

                        <%-- 상품 정보 --%>
                      <div class="col-md-3">
                        <h5 class="mb-1">
                          <a href="${pageContext.request.contextPath}/product/detail/${item.productId}"
                             class="product-name-link">
                              ${item.productName}
                          </a>
                        </h5>

                          <%-- 가격 정보 --%>
                        <div class="price-info">
                          <c:choose>
                            <c:when test="${item.discountRate > 0}">
                              <div class="d-flex align-items-center flex-wrap">
                                <span class="price-display mr-2">
                                  <fmt:formatNumber value="${discountedPrice}" pattern="#,###" />원
                                </span>
                                <span class="text-muted text-decoration-line-through small mr-2">
                                  <fmt:formatNumber value="${item.productPrice}" pattern="#,###" />원
                                </span>
                                <span class="badge badge-danger discount-badge">
                                  <fmt:formatNumber value="${item.discountRate > 1 ? item.discountRate : item.discountRate * 100}" pattern="##" />% 할인
                                </span>
                              </div>
                            </c:when>
                            <c:otherwise>
                              <span class="price-display">
                                <fmt:formatNumber value="${item.productPrice}" pattern="#,###" />원
                              </span>
                            </c:otherwise>
                          </c:choose>
                        </div>
                      </div>

                        <%-- 수량 조절 --%>
                      <div class="col-md-2">
                        <div class="input-group quantity-control">
                          <div class="input-group-prepend">
                            <button class="btn btn-outline-secondary" type="button"
                                    onclick="changeQuantity('qty_${item.cartId}', -1)">-</button>
                          </div>
                          <input type="number" class="form-control" id="qty_${item.cartId}"
                                 value="${item.productQt}" min="1" max="99"
                                 data-cart-id="${item.cartId}" data-unit-price="${discountedPrice}"
                                 data-original-quantity="${item.productQt}">
                          <div class="input-group-append">
                            <button class="btn btn-outline-secondary" type="button"
                                    onclick="changeQuantity('qty_${item.cartId}', 1)">+</button>
                          </div>
                        </div>
                      </div>

                        <%-- 소계 --%>
                      <div class="col-md-2 text-center">
                        <strong class="price-display" id="item_total_${item.cartId}">
                          <fmt:formatNumber value="${itemTotalPrice}" pattern="#,###" />원
                        </strong>
                      </div>

                        <%-- 액션 버튼 --%>
                      <div class="col-md-3 text-right">
                        <button type="button" class="btn btn-primary btn-sm mr-2"
                                onclick="updateItem(${item.cartId})" title="수량 변경">
                          <i class="fa fa-check"></i> 변경
                        </button>
                        <button type="button" class="btn btn-danger btn-sm"
                                onclick="deleteItem(${item.cartId})" title="상품 삭제">
                          <i class="fa fa-trash"></i> 삭제
                        </button>
                      </div>
                    </div>
                  </div>
                </div>
              </c:forEach>
            </div>

            <%-- 하단 요약 및 액션 --%>
            <div class="row mt-4">
              <div class="col-md-6">
                <form action="${pageContext.request.contextPath}/cart/clear" method="post" style="display: inline;">
                  <button type="submit" class="btn btn-outline-danger"
                          onclick="return confirm('장바구니를 모두 비우시겠습니까?')">
                    <i class="fa fa-trash"></i> 장바구니 비우기
                  </button>
                </form>
              </div>

              <div class="col-md-6">
                <div class="card order-summary-card">
                  <div class="card-body">
                    <h5 class="card-title">주문 요약</h5>
                    <div class="d-flex justify-content-between mb-2">
                      <span>상품 개수:</span>
                      <span><strong id="total-item-count">${itemCount}개</strong></span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                      <span>배송비:</span>
                      <span>무료</span>
                    </div>
                    <hr>
                    <div class="d-flex justify-content-between" style="font-size: 1.2rem;">
                      <span><strong>총 결제금액:</strong></span>
                      <span class="price-display" id="total-price">
                        <fmt:formatNumber value="${totalPrice}" pattern="#,###" />원
                      </span>
                    </div>
                    <button class="btn btn-success btn-lg btn-block mt-3" onclick="proceedToCheckout()">
                      <i class="fa fa-credit-card"></i> 주문하기
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </div>
</section>

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

<!-- ===== JavaScript ===== -->
<script>
  /**
   * 장바구니 관리 객체
   */
  const CartManager = {
    // 컨텍스트 경로
    contextPath: '<c:out value="${pageContext.request.contextPath}" />',

    /**
     * 초기화
     */
    init: function() {
      console.log('장바구니 관리자 초기화');
      this.bindEvents();
      this.updateTotalPrice();
    },

    /**
     * 이벤트 바인딩
     */
    bindEvents: function() {
      const self = this;

      // 수량 입력 필드 변경 시 실시간 가격 업데이트
      $(document).on('input change', '[id^="qty_"]', function() {
        self.updateTotalPrice();
      });

      // Enter 키 입력 시 바로 서버에 반영
      $(document).on('keypress', '[id^="qty_"]', function(e) {
        if (e.which === 13) { // Enter key
          const cartId = $(this).data('cart-id');
          const quantity = $(this).val();

          if (quantity >= 1 && quantity <= 99) {
            location.href = self.contextPath + '/cart/update?cartId=' + cartId + '&quantity=' + quantity;
          } else {
            alert('수량은 1~99개까지 선택 가능합니다.');
          }
        }
      });

      // 포커스를 잃을 때 (blur) 변경된 수량을 서버에 반영
      $(document).on('blur', '[id^="qty_"]', function() {
        const $input = $(this);
        const cartId = $input.data('cart-id');
        const newQuantity = parseInt($input.val());
        const originalQuantity = parseInt($input.data('original-quantity'));

        // 수량이 실제로 변경되었고 유효 범위 내에 있으면 서버에 반영
        if (newQuantity !== originalQuantity && newQuantity >= 1 && newQuantity <= 99) {
          location.href = self.contextPath + '/cart/update?cartId=' + cartId + '&quantity=' + newQuantity;
        } else if (newQuantity < 1 || newQuantity > 99) {
          alert('수량은 1~99개까지 선택 가능합니다.');
          $input.val(originalQuantity);
        }
      });
    },

    /**
     * 수량 변경 (+ / - 버튼) - 즉시 서버 반영
     */
    changeQuantity: function(inputId, change) {
      const input = document.getElementById(inputId);
      if (!input) return;

      const currentValue = parseInt(input.value) || 1;
      const newValue = currentValue + change;
      const cartId = input.getAttribute('data-cart-id');

      if (newValue >= 1 && newValue <= 99) {
        // 즉시 서버에 반영
        location.href = this.contextPath + '/cart/update?cartId=' + cartId + '&quantity=' + newValue;
      } else {
        alert('수량은 1~99개까지 선택 가능합니다.');
      }
    },

    /**
     * 상품 수량 변경 (서버 반영) - 확인 없이 바로 반영
     */
    updateItem: function(cartId) {
      const quantity = document.getElementById('qty_' + cartId).value;

      if (quantity < 1 || quantity > 99) {
        alert('수량은 1~99개까지 선택 가능합니다.');
        return;
      }

      // 확인 없이 바로 서버에 반영
      location.href = this.contextPath + '/cart/update?cartId=' + cartId + '&quantity=' + quantity;
    },

    /**
     * 상품 삭제
     */
    deleteItem: function(cartId) {
      if (confirm('이 상품을 장바구니에서 삭제하시겠습니까?')) {
        location.href = this.contextPath + '/cart/delete?cartId=' + cartId;
      }
    },

    /**
     * 실시간 총 가격 업데이트
     */
    updateTotalPrice: function() {
      let totalPrice = 0;
      let totalCount = 0;

      // 모든 장바구니 아이템 순회
      $('[id^="qty_"]').each(function() {
        const $input = $(this);
        const quantity = parseInt($input.val()) || 0;
        const unitPrice = parseFloat($input.data('unit-price')) || 0;
        const cartId = $input.data('cart-id');

        // 개별 상품 총액 계산
        const itemTotal = unitPrice * quantity;
        totalPrice += itemTotal;
        totalCount += quantity;

        // 개별 상품 가격 표시 업데이트
        const $priceElement = $('#item_total_' + cartId);
        if ($priceElement.length) {
          $priceElement.text(Math.floor(itemTotal).toLocaleString('ko-KR') + '원');
        }
      });

      // 전체 총액 및 개수 업데이트
      $('#total-price').text(Math.floor(totalPrice).toLocaleString('ko-KR') + '원');
      $('#total-item-count').text(totalCount + '개');
    },

    /**
     * 주문하기
     */
    proceedToCheckout: function() {
      <c:if test="${empty cartItems}">
      alert('장바구니가 비어있습니다.');
      return;
      </c:if>

      if (confirm('주문하시겠습니까?')) {
        location.href = this.contextPath + '/order/from-cart';
      }
    }
  };

  // ===== 전역 함수들 (HTML onclick에서 직접 호출용) =====
  function changeQuantity(inputId, change) {
    CartManager.changeQuantity(inputId, change);
  }

  function updateItem(cartId) {
    CartManager.updateItem(cartId);
  }

  function deleteItem(cartId) {
    CartManager.deleteItem(cartId);
  }

  function proceedToCheckout() {
    CartManager.proceedToCheckout();
  }

  // 페이지 로드 시 초기화
  $(document).ready(function() {
    CartManager.init();
  });
</script>

</body>
</html>