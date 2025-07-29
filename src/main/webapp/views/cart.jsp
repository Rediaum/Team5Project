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
  
  <style>
    /* 드롭다운 메뉴 기본 스타일 */
    .dropdown-menu {
      border: 1px solid #ddd;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
      border-radius: 5px;
    }
    
    /* 드롭다운 아이템 스타일 */
    .dropdown-item {
      padding: 8px 16px;
      color: #333;
      transition: background-color 0.2s;
    }
    
    /* 드롭다운 아이템 호버 효과 */
    .dropdown-item:hover {
      background-color: #f8f9fa;
      color: #f7444e;
    }
    
    /* 드롭다운 구분선 스타일 */
    .dropdown-divider {
      margin: 5px 0;
    }
    
    /* 드롭다운 아이템 내 아이콘 스타일 */
    .dropdown-item i {
      margin-right: 8px;
      width: 16px;
    }
  </style>

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
  <%-- 헤더 섹션 시작 --%>
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
            <%-- 홈 메뉴 (현재 활성화 상태) --%>
            <li class="nav-item active">
              <a class="nav-link" href="${pageContext.request.contextPath}/">Home <span class="sr-only">(current)</span></a>
            </li>
            
            <%-- Pages 드롭다운 메뉴 --%>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" id="pagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true" style="color: #000;">
                <span class="nav-label">Pages <span class="caret"></span></span>
              </a>
              <div class="dropdown-menu dropdown-menu-right" aria-labelledby="pagesDropdown">
                <a class="dropdown-item" href="${pageContext.request.contextPath}/about">About</a>
                <a class="dropdown-item" href="${pageContext.request.contextPath}/testimonial">Testimonial</a>
              </div>
            </li>
            
            <%-- Products 메뉴 --%>
            <li class="nav-item">
              <a class="nav-link" href="${pageContext.request.contextPath}/product">Products</a>
            </li>
            
            <%-- Contact 메뉴 --%>
            <li class="nav-item">
              <a class="nav-link" href="${pageContext.request.contextPath}/contact">Contact</a>
            </li>
            
            <%-- 사용자 관리 드롭다운 메뉴 (사람 아이콘) --%>
            <li class="nav-item dropdown">
              <%-- 사람 아이콘으로 구성된 드롭다운 트리거 --%>
              <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="color: #000;">
                <!-- 사람 아이콘 SVG -->
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                  <circle cx="12" cy="7" r="4"/><!-- 머리 -->
                  <path d="M6 21v-2a4 4 0 0 1 4-4h4a4 4 0 0 1 4 4v2"/><!-- 몸통 -->
                </svg>
                <span class="nav-label"><span class="caret"></span></span>
              </a>
              
              <%-- 드롭다운 메뉴 내용 --%>
              <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
                <%-- 로그인 상태에 따른 메뉴 분기 --%>
                <c:choose>
                  <%-- 로그인하지 않은 경우 --%>
                  <c:when test="${sessionScope.logincust == null}">
                    <%-- 로그인 메뉴 --%>
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/login">
                      <i class="fa fa-sign-in" aria-hidden="true"></i> Login
                    </a>
                    <%-- 회원가입 메뉴 --%>
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/register">
                      <i class="fa fa-user-plus" aria-hidden="true"></i> Register
                    </a>
                  </c:when>
                  <%-- 로그인한 경우 --%>
                  <c:otherwise>
                    <%-- 사용자 프로필 메뉴 (사용자 이름 표시) --%>
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/info">
                      <i class="fa fa-user" aria-hidden="true"></i> ${sessionScope.logincust.custName}
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
            
            <%-- 장바구니 아이콘 메뉴 (로그인시에만 표시) --%>
            <c:if test="${sessionScope.logincust != null}">
              <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                    <%-- 장바구니 SVG 아이콘 --%>
                  <svg version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 456.029 456.029" style="enable-background:new 0 0 456.029 456.029;" xml:space="preserve">
                               <!-- 장바구니 바퀴 -->
                    <g>
                      <g>
                        <path d="M345.6,338.862c-29.184,0-53.248,23.552-53.248,53.248c0,29.184,23.552,53.248,53.248,53.248
                                       c29.184,0,53.248-23.552,53.248-53.248C398.336,362.926,374.784,338.862,345.6,338.862z" />
                      </g>
                    </g>
                    <!-- 장바구니 몸체 -->
                    <g>
                      <g>
                        <path d="M439.296,84.91c-1.024,0-2.56-0.512-4.096-0.512H112.64l-5.12-34.304C104.448,27.566,84.992,10.67,61.952,10.67H20.48
                                       C9.216,10.67,0,19.886,0,31.15c0,11.264,9.216,20.48,20.48,20.48h41.472c2.56,0,4.608,2.048,5.12,4.608l31.744,216.064
                                       c4.096,27.136,27.648,47.616,55.296,47.616h212.992c26.624,0,49.664-18.944,55.296-45.056l33.28-166.4
                                       C457.728,97.71,450.56,86.958,439.296,84.91z" />
                      </g>
                    </g>
                    <!-- 장바구니 바퀴 -->
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
            
            <%-- 7. 검색 폼 --%>
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