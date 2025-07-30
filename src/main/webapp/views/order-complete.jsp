<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <title>주문 완료 - Shop Project Team 5</title>

  <!-- Bootstrap CSS -->
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/views/css/bootstrap.css" />
  <!-- Font Awesome -->
  <link href="${pageContext.request.contextPath}/views/css/font-awesome.min.css" rel="stylesheet" />
  <!-- Custom styles -->
  <link href="${pageContext.request.contextPath}/views/css/style.css" rel="stylesheet" />
  <!-- Responsive style -->
  <link href="${pageContext.request.contextPath}/views/css/responsive.css" rel="stylesheet" />
</head>

<body class="sub_page">

<div class="hero_area">
  <!-- header section starts -->
  <header class="header_section">
    <div class="container">
      <nav class="navbar navbar-expand-lg custom_nav-container ">
        <%-- 로고 - 홈페이지로 링크 --%>
        <a class="navbar-brand" href="${pageContext.request.contextPath}/"><img width="250" src="${pageContext.request.contextPath}/views/images/logo.png" alt="#" /></a>

        <%-- 모바일 메뉴 토글 버튼 --%>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class=""> </span>
        </button>

        <%-- 네비게이션 메뉴 --%>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav">
            <%-- 홈 메뉴 --%>
            <li class="nav-item">
              <a class="nav-link" href="${pageContext.request.contextPath}/">Home</a>
            </li>

            <%-- Products 메뉴 --%>
            <li class="nav-item">
              <a class="nav-link" href="${pageContext.request.contextPath}/product">Products</a>
            </li>

            <%-- 사용자 관리 드롭다운 메뉴 --%>
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

            <%-- 장바구니 아이콘 메뉴 --%>
            <c:if test="${sessionScope.logincust != null}">
              <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                  <svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 456.029 456.029" style="enable-background:new 0 0 456.029 456.029;" xml:space="preserve">
                    <g><path d="M345.6,338.862c-29.184,0-53.248,23.552-53.248,53.248c0,29.184,23.552,53.248,53.248,53.248c29.184,0,53.248-23.552,53.248-53.248C398.336,362.926,374.784,338.862,345.6,338.862z" /></g>
                    <g><path d="M439.296,84.91c-1.024,0-2.56-0.512-4.096-0.512H112.64l-5.12-34.304C104.448,27.566,84.992,10.67,61.952,10.67H20.48C9.216,10.67,0,19.886,0,31.15c0,11.264,9.216,20.48,20.48,20.48h41.472c2.56,0,4.608,2.048,5.12,4.608l31.744,216.064c4.096,27.136,27.648,47.616,55.296,47.616h212.992c26.624,0,49.664-18.944,55.296-45.056l33.28-166.4C457.728,97.71,450.56,86.958,439.296,84.91z" /></g>
                    <g><path d="M215.04,389.55c-1.024-28.16-24.576-50.688-52.736-50.688c-29.696,1.536-52.224,26.112-51.2,55.296c1.024,28.16,24.064,50.688,52.224,50.688h1.024C193.536,443.31,216.576,418.734,215.04,389.55z" /></g>
                  </svg>
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
<section class="inner_page_head">
  <div class="container_fuild">
    <div class="row">
      <div class="col-md-12">
        <div class="full">
          <h3>주문 완료</h3>
        </div>
      </div>
    </div>
  </div>
</section>

<section class="layout_padding">
  <div class="container">
    <!-- 성공 메시지 -->
    <div class="row">
      <div class="col-md-12">
        <div class="text-center mb-5">
          <div class="alert alert-success" role="alert" style="border: none; background: linear-gradient(135deg, #28a745, #20c997); color: white; border-radius: 15px; padding: 30px;">
            <i class="fa fa-check-circle" style="font-size: 4rem; margin-bottom: 20px;"></i>
            <h2 class="mb-3">주문이 완료되었습니다!</h2>
            <p class="mb-0" style="font-size: 1.1rem;">
              주문번호: <strong>#${order.orderId}</strong><br>
              빠른 시일 내에 배송해드리겠습니다.
            </p>
          </div>
        </div>
      </div>
    </div>

    <!-- 주문 정보 -->
    <div class="row">
      <div class="col-md-8">
        <div class="card">
          <div class="card-header">
            <h5><i class="fa fa-shopping-bag"></i> 주문 상품 정보</h5>
          </div>
          <div class="card-body">
            <c:forEach var="item" items="${orderItems}">
              <div class="order-item mb-3 pb-3" style="border-bottom: 1px solid #eee;">
                <div class="row align-items-center">
                  <div class="col-md-2">
                    <img src="${pageContext.request.contextPath}/views/images/${item.productImg}"
                         alt="상품 이미지" class="img-fluid rounded" style="max-width: 80px;">
                  </div>
                  <div class="col-md-6">
                    <h6 class="mb-1">${item.productName}</h6>
                    <p class="text-muted mb-0">
                      단가: <fmt:formatNumber value="${item.unitPrice}" pattern="#,###" />원
                    </p>
                  </div>
                  <div class="col-md-2 text-center">
                    <span class="badge badge-secondary">${item.quantity}개</span>
                  </div>
                  <div class="col-md-2 text-right">
                    <strong class="text-danger">
                      <fmt:formatNumber value="${item.unitPrice * item.quantity}" pattern="#,###" />원
                    </strong>
                  </div>
                </div>
              </div>
            </c:forEach>
          </div>
        </div>
      </div>

      <div class="col-md-4">
        <!-- 주문 요약 -->
        <div class="card mb-4">
          <div class="card-header">
            <h5><i class="fa fa-receipt"></i> 주문 요약</h5>
          </div>
          <div class="card-body">
            <div class="d-flex justify-content-between mb-2">
              <span>주문번호:</span>
              <span><strong>#${order.orderId}</strong></span>
            </div>
            <div class="d-flex justify-content-between mb-2">
              <span>주문일시:</span>
              <span><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm" /></span>
            </div>
            <div class="d-flex justify-content-between mb-2">
              <span>배송비:</span>
              <span>무료</span>
            </div>
            <hr>
            <div class="d-flex justify-content-between" style="font-size: 1.2rem;">
              <span><strong>총 결제금액:</strong></span>
              <span class="text-danger"><strong>
                <fmt:formatNumber value="${order.totalAmount}" pattern="#,###" />원
              </strong></span>
            </div>
          </div>
        </div>

        <!-- 배송 정보 -->
        <div class="card">
          <div class="card-header">
            <h5><i class="fa fa-truck"></i> 배송 정보</h5>
          </div>
          <div class="card-body">
            <div class="mb-2">
              <strong>받는 분:</strong><br>
              ${order.shippingName}
            </div>
            <div class="mb-2">
              <strong>연락처:</strong><br>
              ${order.shippingPhone}
            </div>
            <div class="mb-2">
              <strong>배송 주소:</strong><br>
              ${order.shippingAddress}
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 버튼 영역 -->
    <div class="row mt-4">
      <div class="col-md-12 text-center">
        <a href="${pageContext.request.contextPath}/" class="btn btn-outline-primary mr-3">
          <i class="fa fa-home"></i> 홈으로 이동
        </a>
        <a href="${pageContext.request.contextPath}/order/history" class="btn btn-primary mr-3">
          <i class="fa fa-list"></i> 주문 내역 확인
        </a>
        <a href="${pageContext.request.contextPath}/product" class="btn btn-success">
          <i class="fa fa-shopping-bag"></i> 쇼핑 계속하기
        </a>
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

<!-- jQuery -->
<script type="text/javascript" src="${pageContext.request.contextPath}/views/js/jquery-3.4.1.min.js"></script>
<!-- Bootstrap js -->
<script type="text/javascript" src="${pageContext.request.contextPath}/views/js/bootstrap.js"></script>

<script>
  $(document).ready(function() {
    // 5초 후 자동으로 알림 숨김
    setTimeout(function() {
      $('.alert').fadeOut();
    }, 8000);
  });
</script>

</body>
</html>