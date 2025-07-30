<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
   <!-- Basic -->
   <meta charset="utf-8" />
   <meta http-equiv="X-UA-Compatible" content="IE=edge" />
   <!-- Mobile Metas -->
   <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

   <link rel="shortcut icon" href="${pageContext.request.contextPath}/views/images/favicon.png" type="">
   <title>검색 결과 - Team5 Shop</title>
   <!-- bootstrap core css -->
   <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/views/css/bootstrap.css" />
   <!-- font awesome style -->
   <link href="${pageContext.request.contextPath}/views/css/font-awesome.min.css" rel="stylesheet" />
   <!-- Custom styles for this template -->
   <link href="${pageContext.request.contextPath}/views/css/style.css" rel="stylesheet" />
   <!-- responsive style -->
   <link href="${pageContext.request.contextPath}/views/css/responsive.css" rel="stylesheet" />
</head>

<body class="sub_page">

<div class="hero_area">
   <%-- 기존 프로젝트와 동일한 헤더 --%>
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

                  <%-- Pages 드롭다운 메뉴 --%>
                  <li class="nav-item dropdown">
                     <a class="nav-link dropdown-toggle" href="#" id="pagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="color: #000;">
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

                  <%-- 검색 메뉴 (현재 활성화) --%>
                  <li class="nav-item active">
                     <a class="nav-link" href="${pageContext.request.contextPath}/search">Search <span class="sr-only">(current)</span></a>
                  </li>

                  <%-- Contact 메뉴 --%>
                  <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/contact">Contact</a>
                  </li>

                  <%-- 사용자 관리 드롭다운 메뉴 --%>
                  <li class="nav-item dropdown">
                     <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="color: #000;">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                           <circle cx="12" cy="7" r="4"/>
                           <path d="m5.5 21c0-5 3-8 6.5-8s6.5 3 6.5 8"/>
                        </svg>
                     </a>

                     <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
                        <c:choose>
                           <c:when test="${sessionScope.logincust != null}">
                              <h6 class="dropdown-header">안녕하세요, ${sessionScope.logincust.custName}님!</h6>
                              <div class="dropdown-divider"></div>
                              <a class="dropdown-item" href="${pageContext.request.contextPath}/info">
                                 <i class="fa fa-user"></i> 프로필 수정
                              </a>
                              <a class="dropdown-item" href="${pageContext.request.contextPath}/cart">
                                 <i class="fa fa-shopping-cart"></i> 장바구니
                              </a>
                              <div class="dropdown-divider"></div>
                              <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                 <i class="fa fa-sign-out"></i> 로그아웃
                              </a>
                           </c:when>
                           <c:otherwise>
                              <a class="dropdown-item" href="${pageContext.request.contextPath}/login">
                                 <i class="fa fa-sign-in"></i> 로그인
                              </a>
                              <a class="dropdown-item" href="${pageContext.request.contextPath}/register">
                                 <i class="fa fa-user-plus"></i> 회원가입
                              </a>
                           </c:otherwise>
                        </c:choose>
                     </div>
                  </li>

                  <%-- 검색 폼 --%>
                  <form class="form-inline search-form-header" action="${pageContext.request.contextPath}/search" method="GET">
                     <div class="search-input-container">
                        <input type="text" name="keyword" class="form-control search-input-header"
                               placeholder="상품 검색..." autocomplete="off" id="headerSearchInput" value="${keyword}">
                        <button class="btn search-btn-header" type="submit">
                           <i class="fa fa-search" aria-hidden="true"></i>
                        </button>
                     </div>
                  </form>
               </ul>
            </div>
         </nav>
      </div>
   </header>
</div>

<!-- 검색 섹션 -->
<section class="search_section">
   <div class="container">
      <div class="search_form_container">
         <h2 class="search_title">🔍 상품 검색</h2>

         <form id="searchForm" action="${pageContext.request.contextPath}/search" method="GET">
            <div class="row">
               <div class="col-md-4">
                  <div class="form-group">
                     <label>검색어</label>
                     <input type="text" name="keyword" class="form-control" placeholder="상품명을 입력하세요..." value="${keyword}">
                  </div>
               </div>
               <div class="col-md-3">
                  <div class="form-group">
                     <label>카테고리</label>
                     <select name="category" class="form-control">
                        <option value="0">전체 카테고리</option>
                        <option value="1" ${selectedCategory == 1 ? 'selected' : ''}>🎧 오디오</option>
                        <option value="2" ${selectedCategory == 2 ? 'selected' : ''}>🎮 게이밍</option>
                        <option value="3" ${selectedCategory == 3 ? 'selected' : ''}>⌚ 웨어러블</option>
                        <option value="4" ${selectedCategory == 4 ? 'selected' : ''}>💻 PC/노트북</option>
                        <option value="5" ${selectedCategory == 5 ? 'selected' : ''}>🖥️ 모니터</option>
                        <option value="6" ${selectedCategory == 6 ? 'selected' : ''}>📺 TV</option>
                        <option value="7" ${selectedCategory == 7 ? 'selected' : ''}>📱 스마트폰</option>
                     </select>
                  </div>
               </div>
               <div class="col-md-2">
                  <div class="form-group">
                     <label>최소 가격</label>
                     <input type="number" name="minPrice" class="form-control" placeholder="0" value="${minPrice}">
                  </div>
               </div>
               <div class="col-md-2">
                  <div class="form-group">
                     <label>최대 가격</label>
                     <input type="number" name="maxPrice" class="form-control" placeholder="무제한" value="${maxPrice}">
                  </div>
               </div>
               <div class="col-md-1">
                  <div class="form-group">
                     <label>&nbsp;</label>
                     <button type="submit" class="btn btn-primary btn-block">검색</button>
                  </div>
               </div>
            </div>

            <div class="row mt-3">
               <div class="col-md-8">
                  <div class="form-check form-check-inline">
                     <input class="form-check-input" type="radio" name="sortBy" value="regdate" id="sort1" ${sortBy == 'regdate' || sortBy == null ? 'checked' : ''}>
                     <label class="form-check-label" for="sort1">최신순</label>
                  </div>
                  <div class="form-check form-check-inline">
                     <input class="form-check-input" type="radio" name="sortBy" value="price" id="sort2" ${sortBy == 'price' ? 'checked' : ''}>
                     <label class="form-check-label" for="sort2">가격순</label>
                  </div>
                  <div class="form-check form-check-inline">
                     <input class="form-check-input" type="radio" name="sortBy" value="name" id="sort3" ${sortBy == 'name' ? 'checked' : ''}>
                     <label class="form-check-label" for="sort3">이름순</label>
                  </div>
               </div>
               <div class="col-md-4 text-right">
                  <button type="button" class="btn btn-secondary" onclick="clearFilters()">필터 초기화</button>
               </div>
            </div>
         </form>
      </div>
   </div>
</section>

<!-- 검색 결과 섹션 -->
<section class="layout_padding">
   <div class="container">

      <!-- 검색 통계 (결과가 있을 때만) -->
      <c:if test="${not empty searchResults}">
         <div class="search_stats">
            <div class="row">
               <div class="col-md-3">
                  <div class="stat_item">
                     <div class="stat_number">${fn:length(searchResults)}</div>
                     <div>총 상품수</div>
                  </div>
               </div>
               <div class="col-md-3">
                  <div class="stat_item">
                     <div class="stat_number">
                        <fmt:formatNumber value="${searchStats.avgPrice}" pattern="#,###" />원
                     </div>
                     <div>평균 가격</div>
                  </div>
               </div>
               <div class="col-md-3">
                  <div class="stat_item">
                     <div class="stat_number">
                        <fmt:formatNumber value="${searchStats.minPrice}" pattern="#,###" />원
                     </div>
                     <div>최저 가격</div>
                  </div>
               </div>
               <div class="col-md-3">
                  <div class="stat_item">
                     <div class="stat_number">
                        <fmt:formatNumber value="${searchStats.maxPrice}" pattern="#,###" />원
                     </div>
                     <div>최고 가격</div>
                  </div>
               </div>
            </div>
         </div>
      </c:if>

      <!-- 검색 결과 -->
      <c:choose>
         <c:when test="${not empty searchResults}">
            <div class="row product_grid">
               <c:forEach var="product" items="${searchResults}">
                  <div class="col-sm-6 col-md-4 col-lg-3">
                     <div class="product_box">
                        <div class="product_img_box">
                           <img src="${pageContext.request.contextPath}/views/images/${product.productImg}" alt="${product.productName}">
                        </div>
                        <div class="product_detail">
                           <div class="product_info">
                              <h6>${product.productName}</h6>
                              <div class="product_price">
                                 <fmt:formatNumber value="${product.productPrice}" pattern="#,###" />원
                              </div>
                              <div class="btn_container">
                                 <a href="${pageContext.request.contextPath}/product/detail/${product.productId}" class="btn btn-primary btn-sm">
                                    상세보기
                                 </a>
                                 <c:choose>
                                    <c:when test="${sessionScope.logincust != null}">
                                       <a href="javascript:void(0)" onclick="addToCart(${product.productId})" class="btn btn-success btn-sm ml-2">
                                          장바구니
                                       </a>
                                    </c:when>
                                    <c:otherwise>
                                       <a href="${pageContext.request.contextPath}/login" class="btn btn-success btn-sm ml-2">
                                          장바구니
                                       </a>
                                    </c:otherwise>
                                 </c:choose>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
               </c:forEach>
            </div>
         </c:when>
         <c:otherwise>
            <div class="no_results">
               <i class="fa fa-search fa-5x"></i>
               <h3 style="margin: 30px 0;">검색 결과가 없습니다</h3>
               <p>다른 검색어나 필터 조건을 시도해보세요.</p>
               <a href="${pageContext.request.contextPath}/product" class="btn btn-primary">전체 상품 보기</a>
            </div>
         </c:otherwise>
      </c:choose>
   </div>
</section>

<!-- 기존 프로젝트와 동일한 푸터 -->
<footer class="footer_section">
   <div class="container">
      <div class="row">
         <div class="col-md-4 footer-col">
            <div class="footer_contact">
               <h4>Contact us</h4>
               <div class="contact_link_box">
                  <a href=""><i class="fa fa-map-marker" aria-hidden="true"></i><span>Location</span></a>
                  <a href=""><i class="fa fa-phone" aria-hidden="true"></i><span>Call +01 1234567890</span></a>
                  <a href=""><i class="fa fa-envelope" aria-hidden="true"></i><span>demo@gmail.com</span></a>
               </div>
            </div>
         </div>
         <div class="col-md-4 footer-col">
            <div class="footer_detail">
               <a href="" class="footer-logo">Shop</a>
               <p>Necessary, making this the first true generator on the Internet.</p>
               <div class="footer_social">
                  <a href=""><i class="fa fa-facebook" aria-hidden="true"></i></a>
                  <a href=""><i class="fa fa-twitter" aria-hidden="true"></i></a>
                  <a href=""><i class="fa fa-linkedin" aria-hidden="true"></i></a>
                  <a href=""><i class="fa fa-instagram" aria-hidden="true"></i></a>
               </div>
            </div>
         </div>
         <div class="col-md-4 footer-col">
            <h4>Subscribe</h4>
            <form>
               <input type="text" placeholder="Enter email" />
               <button type="submit">Subscribe</button>
            </form>
         </div>
      </div>
   </div>
</footer>

<div class="cpy_">
   <p class="mx-auto">© 2021 All Rights Reserved By <a href="https://html.design/">Free Html Templates</a><br>
      Distributed By <a href="https://themewagon.com/" target="_blank">ThemeWagon</a>
   </p>
</div>

<!-- JavaScript -->
<script src="${pageContext.request.contextPath}/views/js/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/views/js/popper.min.js"></script>
<script src="${pageContext.request.contextPath}/views/js/bootstrap.js"></script>
<script src="${pageContext.request.contextPath}/views/js/custom.js"></script>
<script src="${pageContext.request.contextPath}/views/js/search.js"></script>

</body>
</html>