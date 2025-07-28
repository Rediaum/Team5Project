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

  <!-- bootstrap core css -->
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/views/css/bootstrap.css" />
  <!-- font awesome style -->
  <link href="${pageContext.request.contextPath}/views/css/font-awesome.min.css" rel="stylesheet" />
  <!-- Custom styles for this template -->
  <link href="${pageContext.request.contextPath}/views/css/style.css" rel="stylesheet" />
  <!-- responsive style -->
  <link href="${pageContext.request.contextPath}/views/css/responsive.css" rel="stylesheet" />

  <!-- jQuery -->
  <script src="${pageContext.request.contextPath}/views/js/jquery-3.4.1.min.js"></script>
  <!-- Bootstrap JavaScript -->
  <script src="${pageContext.request.contextPath}/views/js/bootstrap.js"></script>

  <script>
    let cart = {
      init: function() {},
      del: function(cartId) {
        if (confirm('이 상품을 장바구니에서 삭제하시겠습니까?')) {
          location.href = '${pageContext.request.contextPath}/cart/delete?cartId=' + cartId;
        }
      },
      mod: function(cartId) {
        let cnt = $('#qty_' + cartId).val();
        if (cnt < 1) {
          alert('수량은 1개 이상이어야 합니다.');
          return;
        }
        location.href = '${pageContext.request.contextPath}/cart/update?cartId=' + cartId + '&quantity=' + cnt;
      }
    }
  </script>
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
              <a class="nav-link" href="${pageContext.request.contextPath}/product">Products</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="${pageContext.request.contextPath}/contact">Contact</a>
            </li>
            <li class="nav-item active">
              <a class="nav-link" href="${pageContext.request.contextPath}/cart">Cart</a>
            </li>
          </ul>
        </div>
      </nav>
    </div>
  </header>
  <!-- end header section -->
</div>

<!-- Cart Page Content -->
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

<section class="layout_padding">
  <div class="container">
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
      <div class="col-md-12">
        <div class="d-flex justify-content-between align-items-center mb-4">
          <h2><i class="fa fa-shopping-cart"></i> ${sessionScope.logincust.custName}님의 장바구니</h2>
          <a href="${pageContext.request.contextPath}/product" class="btn btn-outline-primary">
            <i class="fa fa-arrow-left"></i> 쇼핑 계속하기
          </a>
        </div>

        <c:choose>
          <%-- 장바구니가 비어있는 경우 --%>
          <c:when test="${empty cartItems}">
            <div class="text-center" style="padding: 100px 0;">
              <i class="fa fa-shopping-cart" style="font-size: 120px; color: #ddd; margin-bottom: 30px;"></i>
              <h3 style="color: #666; margin-bottom: 20px;">장바구니가 비어있습니다</h3>
              <p style="color: #999; margin-bottom: 30px;">원하는 상품을 장바구니에 담아보세요!</p>
              <a href="${pageContext.request.contextPath}/product" class="btn btn-primary btn-lg">
                <i class="fa fa-shopping-bag"></i> 상품 둘러보기
              </a>
            </div>
          </c:when>

          <%-- 장바구니에 상품이 있는 경우 --%>
          <c:otherwise>
            <!-- 장바구니 상품 목록 -->
            <div class="cart-items">
              <c:forEach var="c" items="${cartItems}">
                <div class="card mb-3">
                  <div class="card-body">
                    <div class="row align-items-center">
                      <!-- 상품 이미지 -->
                      <div class="col-md-2">
                        <img src="${pageContext.request.contextPath}/views/images/${c.productImg}"
                             width="100%" alt="${c.productName}" style="border-radius: 8px;">
                      </div>

                      <!-- 상품 정보 -->
                      <div class="col-md-3">
                        <h5 class="mb-1">${c.productName}</h5>
                        <p class="text-muted mb-0">
                          <fmt:formatNumber value="${c.productPrice}" pattern="#,###" />원
                        </p>
                      </div>

                      <!-- 수량 조절 -->
                      <div class="col-md-2">
                        <div class="input-group">
                          <div class="input-group-prepend">
                            <button class="btn btn-outline-secondary" type="button"
                                    onclick="changeQuantity('qty_${c.cartId}', -1)">-</button>
                          </div>
                          <input type="number" class="form-control text-center"
                                 id="qty_${c.cartId}" value="${c.productQt}" min="1" max="99">
                          <div class="input-group-append">
                            <button class="btn btn-outline-secondary" type="button"
                                    onclick="changeQuantity('qty_${c.cartId}', 1)">+</button>
                          </div>
                        </div>
                      </div>

                      <!-- 소계 -->
                      <div class="col-md-2 text-center">
                        <strong style="font-size: 18px; color: #f7444e;">
                          <fmt:formatNumber value="${c.productPrice * c.productQt}" pattern="#,###" />원
                        </strong>
                      </div>

                      <!-- 버튼들 -->
                      <div class="col-md-3 text-right">
                        <button type="button" class="btn btn-primary btn-sm mr-2"
                                onclick="cart.mod(${c.cartId})" title="수량 변경">
                          <i class="fa fa-refresh"></i> 변경
                        </button>
                        <button type="button" class="btn btn-danger btn-sm"
                                onclick="cart.del(${c.cartId})" title="상품 삭제">
                          <i class="fa fa-trash"></i> 삭제
                        </button>
                      </div>
                    </div>
                  </div>
                </div>
              </c:forEach>
            </div>

            <!-- 장바구니 요약 -->
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
                <div class="card">
                  <div class="card-body">
                    <h5 class="card-title">주문 요약</h5>
                    <div class="d-flex justify-content-between">
                      <span>상품 개수:</span>
                      <span><strong>${itemCount}개</strong></span>
                    </div>
                    <div class="d-flex justify-content-between">
                      <span>배송비:</span>
                      <span>무료</span>
                    </div>
                    <hr>
                    <div class="d-flex justify-content-between" style="font-size: 20px;">
                      <span><strong>총 결제금액:</strong></span>
                      <span style="color: #f7444e;"><strong>
                        <fmt:formatNumber value="${totalPrice}" pattern="#,###" />원
                      </strong></span>
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
  // 수량 변경 함수
  function changeQuantity(inputId, change) {
    let input = document.getElementById(inputId);
    let currentValue = parseInt(input.value);
    let newValue = currentValue + change;

    if (newValue >= 1 && newValue <= 99) {
      input.value = newValue;
    }
  }

  // 주문하기 함수
  function proceedToCheckout() {
    alert('주문 기능은 곧 구현될 예정입니다!');
  }

  // 알림 메시지 자동 숨김
  $(document).ready(function() {
    setTimeout(function() {
      $('.alert').fadeOut();
    }, 5000);
  });
</script>

</body>
</html>