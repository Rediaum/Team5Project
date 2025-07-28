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
        let cnt = $('#' + cartId).val();
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
              <a class="nav-link" href="${pageContext.request.contextPath}/about">About</a>
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
        <h2>장바구니</h2>

        <c:choose>
          <%-- 장바구니가 비어있는 경우 --%>
          <c:when test="${empty cartItems}">
            <div class="text-center" style="padding: 50px 0;">
              <i class="fa fa-shopping-cart" style="font-size: 80px; color: #ddd;"></i>
              <h3>장바구니가 비어있습니다</h3>
              <p>원하는 상품을 장바구니에 담아보세요!</p>
              <a href="${pageContext.request.contextPath}/product" class="btn btn-primary">
                <i class="fa fa-arrow-left"></i> 쇼핑 계속하기
              </a>
            </div>
          </c:when>

          <%-- 장바구니에 상품이 있는 경우 --%>
          <c:otherwise>
            <%-- day02 스타일 테이블 --%>
            <table class="table table-striped">
              <thead>
              <tr>
                <th>이미지</th>
                <th>상품명</th>
                <th>가격</th>
                <th>수량</th>
                <th>소계</th>
                <th>등록일</th>
                <th>수정</th>
                <th>삭제</th>
              </tr>
              </thead>
              <tbody>
              <c:forEach var="c" items="${cartItems}">
                <tr>
                  <td>
                    <img src="${pageContext.request.contextPath}/views/images/${c.productImg}"
                         width="50px" alt="${c.productName}">
                  </td>
                  <td>${c.productName}</td>
                  <td><fmt:formatNumber value="${c.productPrice}" pattern="#,###" />원</td>
                  <td>
                    <input type="number" value="${c.productQt}" class="form-control"
                           id="${c.cartId}" min="1" style="width: 80px;">
                  </td>
                  <td>
                    <strong>
                      <fmt:formatNumber value="${c.productPrice * c.productQt}" pattern="#,###" />원
                    </strong>
                  </td>
                  <td><fmt:formatDate value="${c.cartRegdate}" pattern="MM-dd" /></td>
                  <td>
                    <button type="button" class="btn btn-primary btn-sm" onclick="cart.mod(${c.cartId})">
                      <i class="fa fa-edit"></i> 수정
                    </button>
                  </td>
                  <td>
                    <button type="button" class="btn btn-danger btn-sm" onclick="cart.del(${c.cartId})">
                      <i class="fa fa-trash"></i> 삭제
                    </button>
                  </td>
                </tr>
              </c:forEach>
              </tbody>
            </table>

            <%-- 총계 표시 --%>
            <div class="row">
              <div class="col-md-6">
                <form action="${pageContext.request.contextPath}/cart/clear" method="post" style="display: inline;">
                  <button type="submit" class="btn btn-outline-danger"
                          onclick="return confirm('장바구니를 모두 비우시겠습니까?')">
                    <i class="fa fa-trash"></i> 장바구니 비우기
                  </button>
                </form>
              </div>
              <div class="col-md-6 text-right">
                <h4>
                  총 <strong style="color: #f7444e;">${itemCount}개</strong> 상품 -
                  <strong style="color: #f7444e;">
                    <fmt:formatNumber value="${totalPrice}" pattern="#,###" />원
                  </strong>
                </h4>
                <button class="btn btn-success btn-lg" onclick="proceedToCheckout()">
                  <i class="fa fa-credit-card"></i> 주문하기
                </button>
                <a href="${pageContext.request.contextPath}/product" class="btn btn-outline-primary">
                  <i class="fa fa-arrow-left"></i> 쇼핑 계속하기
                </a>
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