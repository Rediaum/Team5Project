<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
  <!-- Basic -->
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <!-- Mobile Metas -->
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

  <title>장바구니 - Shop Project Team 5</title>

  <!-- bootstrap core css -->
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/views/css/bootstrap.css" />
  <!-- font awesome style -->
  <link href="${pageContext.request.contextPath}/views/css/font-awesome.min.css" rel="stylesheet" />
  <!-- Custom styles for this template -->
  <link href="${pageContext.request.contextPath}/views/css/style.css" rel="stylesheet" />
  <!-- responsive style -->
  <link href="${pageContext.request.contextPath}/views/css/responsive.css" rel="stylesheet" />

  <style>
    .cart-container {
      padding: 40px 0;
    }
    .cart-item {
      border: 1px solid #e0e0e0;
      border-radius: 8px;
      padding: 20px;
      margin-bottom: 15px;
      background: white;
      box-shadow: 0 2px 4px rgba(0,0,0,0.1);
      transition: all 0.3s ease;
    }
    .cart-item:hover {
      box-shadow: 0 4px 8px rgba(0,0,0,0.15);
    }
    .cart-item-img {
      width: 100px;
      height: 100px;
      object-fit: cover;
      border-radius: 8px;
    }
    .cart-item-details {
      display: flex;
      flex-direction: column;
      justify-content: center;
    }
    .cart-item-name {
      font-size: 18px;
      font-weight: bold;
      color: #333;
      margin-bottom: 5px;
    }
    .cart-item-price {
      color: #f7444e;
      font-size: 16px;
      font-weight: bold;
    }
    .quantity-controls {
      display: flex;
      align-items: center;
      gap: 10px;
    }
    .quantity-btn {
      width: 35px;
      height: 35px;
      border: 1px solid #ddd;
      background: white;
      border-radius: 4px;
      cursor: pointer;
      display: flex;
      align-items: center;
      justify-content: center;
      transition: all 0.2s;
    }
    .quantity-btn:hover {
      background: #f7444e;
      color: white;
      border-color: #f7444e;
    }
    .quantity-input {
      width: 60px;
      text-align: center;
      border: 1px solid #ddd;
      border-radius: 4px;
      padding: 8px;
    }
    .cart-summary {
      background: #f8f9fa;
      border-radius: 8px;
      padding: 25px;
      margin-top: 20px;
      border: 1px solid #e9ecef;
    }
    .cart-summary h4 {
      color: #333;
      margin-bottom: 20px;
    }
    .summary-row {
      display: flex;
      justify-content: space-between;
      margin-bottom: 10px;
      padding: 5px 0;
    }
    .summary-total {
      border-top: 2px solid #f7444e;
      padding-top: 15px;
      margin-top: 15px;
      font-size: 18px;
      font-weight: bold;
    }
    .btn-remove {
      background: #dc3545;
      color: white;
      border: none;
      padding: 8px 15px;
      border-radius: 4px;
      cursor: pointer;
      transition: all 0.2s;
    }
    .btn-remove:hover {
      background: #c82333;
    }
    .empty-cart {
      text-align: center;
      padding: 60px 0;
      color: #666;
    }
    .empty-cart i {
      font-size: 80px;
      color: #ddd;
      margin-bottom: 20px;
    }
    .btn-checkout {
      background: #f7444e;
      color: white;
      padding: 15px 30px;
      border: none;
      border-radius: 25px;
      font-size: 16px;
      font-weight: bold;
      width: 100%;
      margin-top: 15px;
      transition: all 0.3s;
    }
    .btn-checkout:hover {
      background: #e73940;
      transform: translateY(-2px);
    }
    .btn-continue {
      background: #28a745;
      color: white;
      padding: 12px 25px;
      border: none;
      border-radius: 25px;
      text-decoration: none;
      display: inline-block;
      transition: all 0.3s;
    }
    .btn-continue:hover {
      background: #218838;
      text-decoration: none;
      color: white;
    }
  </style>

  <!-- jQuery -->
  <script src="${pageContext.request.contextPath}/views/js/jquery-3.4.1.min.js"></script>
  <!-- Bootstrap JavaScript -->
  <script src="${pageContext.request.contextPath}/views/js/bootstrap.js"></script>
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
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class=""> </span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav">
            <li class="nav-item">
              <a class="nav-link" href="${pageContext.request.contextPath}/">Home</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="${pageContext.request.contextPath}/about">About</a>
            </li>
            <li class="nav-item active">
              <a class="nav-link" href="${pageContext.request.contextPath}/product">Products</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="${pageContext.request.contextPath}/contact">Contact</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="${pageContext.request.contextPath}/register">Register</a>
            </li>
          </ul>
        </div>
      </nav>
    </div>
  </header>
  <!-- end header section -->
</div>

<!-- Cart Section -->
<section class="cart-container">
  <div class="container">
    <div class="row">
      <div class="col-12">
        <div class="heading_container">
          <h2>
            <i class="fa fa-shopping-cart"></i> 장바구니
          </h2>
          <p>선택하신 상품들을 확인하세요</p>
        </div>
      </div>
    </div>

    <%-- 성공/오류 메시지 표시 --%>
    <c:if test="${not empty success}">
      <div class="alert alert-success alert-dismissible fade show" role="alert">
        <strong>성공!</strong> ${success}
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
    </c:if>

    <c:if test="${not empty error}">
      <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <strong>오류!</strong> ${error}
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
    </c:if>

    <div class="row">
      <%-- 장바구니 상품 목록 --%>
      <div class="col-lg-8">
        <c:choose>
          <%-- 장바구니가 비어있는 경우 --%>
          <c:when test="${empty cartItems}">
            <div class="empty-cart">
              <i class="fa fa-shopping-cart"></i>
              <h3>장바구니가 비어있습니다</h3>
              <p>원하는 상품을 장바구니에 담아보세요!</p>
              <a href="${pageContext.request.contextPath}/product" class="btn-continue">
                <i class="fa fa-arrow-left"></i> 쇼핑 계속하기
              </a>
            </div>
          </c:when>

          <%-- 장바구니에 상품이 있는 경우 --%>
          <c:otherwise>
            <c:forEach var="item" items="${cartItems}">
              <div class="cart-item" data-cart-id="${item.cartId}">
                <div class="row align-items-center">
                    <%-- 상품 이미지 --%>
                  <div class="col-md-3">
                    <img src="${pageContext.request.contextPath}/views/images/${item.productImg}"
                         alt="${item.productName}" class="cart-item-img" />
                  </div>

                    <%-- 상품 정보 --%>
                  <div class="col-md-4">
                    <div class="cart-item-details">
                      <div class="cart-item-name">${item.productName}</div>
                      <div class="cart-item-price">
                        <fmt:formatNumber value="${item.productPrice}" pattern="#,###" />원
                      </div>
                    </div>
                  </div>

                    <%-- 수량 조절 --%>
                  <div class="col-md-3">
                    <div class="quantity-controls">
                      <button class="quantity-btn" onclick="updateQuantity(${item.cartId}, ${item.productQt - 1})">
                        <i class="fa fa-minus"></i>
                      </button>
                      <input type="number" class="quantity-input" value="${item.productQt}"
                             onchange="updateQuantity(${item.cartId}, this.value)" min="1" />
                      <button class="quantity-btn" onclick="updateQuantity(${item.cartId}, ${item.productQt + 1})">
                        <i class="fa fa-plus"></i>
                      </button>
                    </div>
                  </div>

                    <%-- 삭제 버튼 --%>
                  <div class="col-md-2">
                    <button class="btn-remove" onclick="removeItem(${item.cartId})">
                      <i class="fa fa-trash"></i> 삭제
                    </button>
                  </div>
                </div>
              </div>
            </c:forEach>

            <%-- 장바구니 비우기 버튼 --%>
            <div class="text-right mt-3">
              <form action="${pageContext.request.contextPath}/cart/clear" method="post" style="display: inline;">
                <button type="submit" class="btn btn-outline-danger"
                        onclick="return confirm('장바구니를 모두 비우시겠습니까?')">
                  <i class="fa fa-trash"></i> 장바구니 비우기
                </button>
              </form>
            </div>
          </c:otherwise>
        </c:choose>
      </div>

      <%-- 주문 요약 (장바구니에 상품이 있을 때만 표시) --%>
      <c:if test="${not empty cartItems}">
        <div class="col-lg-4">
          <div class="cart-summary">
            <h4><i class="fa fa-calculator"></i> 주문 요약</h4>

            <div class="summary-row">
              <span>상품 개수:</span>
              <span><strong>${itemCount}개</strong></span>
            </div>

            <div class="summary-row">
              <span>상품 금액:</span>
              <span><fmt:formatNumber value="${totalPrice}" pattern="#,###" />원</span>
            </div>

            <div class="summary-row">
              <span>배송비:</span>
              <span>
                <c:choose>
                  <c:when test="${totalPrice >= 50000}">
                    <span style="color: #28a745;">무료</span>
                  </c:when>
                  <c:otherwise>
                    3,000원
                  </c:otherwise>
                </c:choose>
              </span>
            </div>

            <c:set var="deliveryFee" value="${totalPrice >= 50000 ? 0 : 3000}" />
            <c:set var="finalTotal" value="${totalPrice + deliveryFee}" />

            <div class="summary-row summary-total">
              <span>총 결제 금액:</span>
              <span style="color: #f7444e;">
                <fmt:formatNumber value="${finalTotal}" pattern="#,###" />원
              </span>
            </div>

            <button class="btn-checkout" onclick="proceedToCheckout()">
              <i class="fa fa-credit-card"></i> 주문하기
            </button>

            <a href="${pageContext.request.contextPath}/product" class="btn-continue" style="margin-top: 10px;">
              <i class="fa fa-arrow-left"></i> 쇼핑 계속하기
            </a>
          </div>
        </div>
      </c:if>
    </div>
  </div>
</section>

<!-- footer section -->
<footer class="footer_section">
  <div class="container">
    <div class="row">
      <div class="col-md-4 footer-col">
        <div class="footer_contact">
          <h4>Reach at..</h4>
          <div class="contact_link_box">
            <a href=""><i class="fa fa-map-marker" aria-hidden="true"></i><span>Location</span></a>
            <a href=""><i class="fa fa-phone" aria-hidden="true"></i><span>Call +01 1234567890</span></a>
            <a href=""><i class="fa fa-envelope" aria-hidden="true"></i><span>demo@gmail.com</span></a>
          </div>
        </div>
      </div>
      <div class="col-md-4 footer-col">
        <div class="footer_info">
          <h4>Newsletter</h4>
          <form action="#">
            <input type="text" placeholder="Enter email" />
            <button type="submit">Subscribe</button>
          </form>
        </div>
      </div>
      <div class="col-md-4">
        <div class="footer_info">
          <h5>Products</h5>
          <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt</p>
        </div>
      </div>
    </div>
  </div>
</footer>

<!-- copyright -->
<div class="cpy_">
  <p class="mx-auto">© 2021 All Rights Reserved By <a href="https://html.design/">Free Html Templates</a><br>
    Distributed By <a href="https://themewagon.com/" target="_blank">ThemeWagon</a>
  </p>
</div>

<script>
  // 장바구니 JavaScript 함수들
  function updateQuantity(cartId, newQuantity) {
    if (newQuantity < 1) {
      if (confirm('상품을 장바구니에서 제거하시겠습니까?')) {
        removeItem(cartId);
      }
      return;
    }

    $.ajax({
      url: '${pageContext.request.contextPath}/cart/update',
      type: 'POST',
      data: {
        cartId: cartId,
        quantity: newQuantity
      },
      success: function(response) {
        if (response.success) {
          // 페이지 새로고침으로 업데이트된 정보 표시
          location.reload();
        } else {
          alert(response.message || '수량 변경에 실패했습니다.');
        }
      },
      error: function() {
        alert('오류가 발생했습니다. 다시 시도해주세요.');
      }
    });
  }

  function removeItem(cartId) {
    if (!confirm('이 상품을 장바구니에서 제거하시겠습니까?')) {
      return;
    }

    $.ajax({
      url: '${pageContext.request.contextPath}/cart/remove',
      type: 'POST',
      data: {
        cartId: cartId
      },
      success: function(response) {
        if (response.success) {
          // 해당 상품 항목 제거 애니메이션
          $('[data-cart-id="' + cartId + '"]').fadeOut(300, function() {
            location.reload();
          });
        } else {
          alert(response.message || '상품 제거에 실패했습니다.');
        }
      },
      error: function() {
        alert('오류가 발생했습니다. 다시 시도해주세요.');
      }
    });
  }

  function proceedToCheckout() {
    // 주문 페이지로 이동 (구현 예정)
    alert('주문 기능은 곧 구현될 예정입니다!');
    // window.location.href = '${pageContext.request.contextPath}/order';
  }

  // 페이지 로드 완료 후
  $(document).ready(function() {
    // 수량 입력 필드에서 Enter 키 방지
    $('.quantity-input').on('keypress', function(e) {
      if (e.which == 13) {
        e.preventDefault();
        $(this).blur();
      }
    });

    // 알림 메시지 자동 숨김
    setTimeout(function() {
      $('.alert').fadeOut();
    }, 5000);
  });
</script>

</body>
</html>