<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
   <meta charset="utf-8" />
   <meta http-equiv="X-UA-Compatible" content="IE=edge" />
   <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
   <title>검색 결과 - Team5 Shop</title>

   <!-- 기존 CSS 파일들 (수정된 style.css 포함) -->
   <link rel="shortcut icon" href="${pageContext.request.contextPath}/views/images/favicon.png" type="">
   <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/views/css/bootstrap.css" />
   <link href="${pageContext.request.contextPath}/views/css/font-awesome.min.css" rel="stylesheet" />
   <link href="${pageContext.request.contextPath}/views/css/style.css" rel="stylesheet" />
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
</head>

<body class="sub_page">

<!-- 페이지 상단 스크립트 (설정 및 초기화) -->
<script src="${pageContext.request.contextPath}/views/js/jquery-3.4.1.min.js"></script>
<script>
// 전역 설정
$(document).ready(function() {
    window.contextPath = '${pageContext.request.contextPath}';
    window.isLoggedIn = ${sessionScope.logincust != null};

    // AJAX 기본 설정
    $.ajaxSetup({
        beforeSend: function(xhr, settings) {
            if (settings.url.indexOf('/') === 0) {
                settings.url = window.contextPath + settings.url;
            }
        }
    });

    // 검색 기능 초기화
    initSearch();
});

// 검색 관련 함수들
let searchTimeout;

function initSearch() {
    // 검색 결과가 없을 때 인기 상품 로드
    if ($('#popular-products').length > 0) {
        loadPopularProducts();
    }

    // 자동완성 이벤트
    $('#searchInput').on('input', function() {
        const keyword = $(this).val().trim();
        clearTimeout(searchTimeout);

        if (keyword.length >= 2) {
            searchTimeout = setTimeout(() => loadSuggestions(keyword), 300);
        } else {
            $('#suggestions').hide();
        }
    });

    // 외부 클릭 시 자동완성 숨기기
    $(document).on('click', function(e) {
        if (!$(e.target).closest('.search-input-group').length) {
            $('#suggestions').hide();
        }
    });
}

function loadSuggestions(keyword) {
    $.ajax({
        url: '/search/suggestions',
        data: { keyword: keyword },
        success: function(suggestions) {
            displaySuggestions(suggestions);
        },
        error: function() {
            $('#suggestions').hide();
        }
    });
}

function displaySuggestions(suggestions) {
    if (!suggestions || suggestions.length === 0) {
        $('#suggestions').hide();
        return;
    }

    const html = suggestions.map(s =>
        `<div class="suggestion-item" onclick="selectSuggestion('${s}')">${s}</div>`
    ).join('');

    $('#suggestions').html(html).show();
}

function selectSuggestion(suggestion) {
    $('#searchInput').val(suggestion);
    $('#suggestions').hide();
    $('form').first().submit();
}

function loadPopularProducts() {
    $.ajax({
        url: '/search/popular',
        success: function(response) {
            if (response.success && response.products?.length > 0) {
                displayProducts(response.products);
            }
        }
    });
}

function displayProducts(products) {
    const html = products.map(p => `
        <div class="product-card">
            <img src="${window.contextPath}/views/images/${p.productImg}"
                 alt="${p.productName}" class="product-image"
                 onerror="this.src='${window.contextPath}/views/images/default-product.jpg'">
            <div class="product-info">
                <h5 class="product-name">${p.productName}</h5>
                <div class="product-price">${new Intl.NumberFormat('ko-KR').format(p.productPrice)}원</div>
                <div class="product-actions">
                    <button class="btn-detail" onclick="goToDetail(${p.productId})">상세보기</button>
                    <button class="btn-cart" onclick="addToCart(${p.productId})">장바구니</button>
                </div>
            </div>
        </div>
    `).join('');

    $('#popular-products-grid').html(html);
}

function goToDetail(productId) {
    location.href = window.contextPath + '/product/detail/' + productId;
}

function addToCart(productId) {
    if (!window.isLoggedIn) {
        alert('로그인이 필요합니다.');
        location.href = window.contextPath + '/login';
        return;
    }

    $.ajax({
        url: '/cart/add',
        method: 'POST',
        data: { productId: productId, quantity: 1 },
        success: function() {
            alert('장바구니에 추가되었습니다!');
        },
        error: function() {
            alert('장바구니 추가 중 오류가 발생했습니다.');
        }
    });
}
</script>

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

<!-- 검색 컨테이너 -->
<section class="search-container">
   <div class="container">
      <div class="search-form">
         <h3 class="text-center mb-4">🔍 상품 검색</h3>

         <form action="${pageContext.request.contextPath}/search" method="GET">
            <!-- 메인 검색창 -->
            <div class="search-input-group">
               <input type="text" name="keyword" class="search-input"
                      placeholder="찾고 싶은 상품을 입력하세요..."
                      value="${keyword}" autocomplete="off" id="searchInput">
               <button type="submit" class="search-btn">
                  <i class="fa fa-search"></i>
               </button>
               <div id="suggestions" class="suggestions-dropdown" style="display: none;"></div>
            </div>

            <!-- 고급 필터 -->
            <div class="filter-section">
               <div class="filter-group">
                  <label class="filter-label">카테고리</label>
                  <select name="category" class="filter-select">
                     <option value="0">전체</option>
                     <option value="1" ${selectedCategory == 1 ? 'selected' : ''}>오디오</option>
                     <option value="2" ${selectedCategory == 2 ? 'selected' : ''}>게이밍</option>
                     <option value="3" ${selectedCategory == 3 ? 'selected' : ''}>웨어러블</option>
                     <option value="4" ${selectedCategory == 4 ? 'selected' : ''}>PC/노트북</option>
                     <option value="5" ${selectedCategory == 5 ? 'selected' : ''}>모니터</option>
                     <option value="6" ${selectedCategory == 6 ? 'selected' : ''}>TV</option>
                     <option value="7" ${selectedCategory == 7 ? 'selected' : ''}>스마트폰</option>
                  </select>
               </div>

               <div class="filter-group">
                  <label class="filter-label">최소 가격</label>
                  <input type="number" name="minPrice" class="filter-input"
                         placeholder="0" value="${minPrice}" min="0">
               </div>

               <div class="filter-group">
                  <label class="filter-label">최대 가격</label>
                  <input type="number" name="maxPrice" class="filter-input"
                         placeholder="1000000" value="${maxPrice}" min="0">
               </div>

               <div class="filter-group">
                  <label class="filter-label">정렬</label>
                  <select name="sortBy" class="filter-select">
                     <option value="regdate" ${sortBy == 'regdate' ? 'selected' : ''}>최신순</option>
                     <option value="price" ${sortBy == 'price' ? 'selected' : ''}>가격순</option>
                     <option value="name" ${sortBy == 'name' ? 'selected' : ''}>이름순</option>
                  </select>
               </div>

               <div class="filter-group">
                  <label class="filter-label">순서</label>
                  <select name="sortOrder" class="filter-select">
                     <option value="DESC" ${sortOrder == 'DESC' ? 'selected' : ''}>내림차순</option>
                     <option value="ASC" ${sortOrder == 'ASC' ? 'selected' : ''}>올림차순</option>
                  </select>
               </div>

               <button type="submit" class="btn btn-primary" style="align-self: end;">
                  <i class="fa fa-filter"></i> 검색
               </button>
            </div>
         </form>
      </div>
   </div>
</section>

<!-- 검색 결과 -->
<section class="container" style="padding-bottom: 50px;">
   <!-- 검색 통계 -->
   <c:if test="${not empty searchResults}">
      <div class="search-stats">
         <h4>📊 검색 결과 통계</h4>
         <div class="stats-grid">
            <div class="stat-item">
               <span class="stat-number">${searchStats.totalCount}</span>
               <span class="stat-label">총 상품수</span>
            </div>
            <div class="stat-item">
               <span class="stat-number">
                  <fmt:formatNumber value="${searchStats.avgPrice}" pattern="#,###" />원
               </span>
               <span class="stat-label">평균 가격</span>
            </div>
            <div class="stat-item">
               <span class="stat-number">
                  <fmt:formatNumber value="${searchStats.minPrice}" pattern="#,###" />원
               </span>
               <span class="stat-label">최저 가격</span>
            </div>
            <div class="stat-item">
               <span class="stat-number">
                  <fmt:formatNumber value="${searchStats.maxPrice}" pattern="#,###" />원
               </span>
               <span class="stat-label">최고 가격</span>
            </div>
         </div>
      </div>
   </c:if>

   <!-- 상품 목록 -->
   <c:choose>
      <c:when test="${not empty searchResults}">
         <div class="product-grid">
            <c:forEach var="product" items="${searchResults}">
               <div class="product-card">
                  <img src="${pageContext.request.contextPath}/views/images/${product.productImg}"
                       alt="${product.productName}" class="product-image"
                       onerror="this.src='${pageContext.request.contextPath}/views/images/default-product.jpg'">

                  <div class="product-info">
                     <h5 class="product-name">${product.productName}</h5>
                     <div class="product-price">
                        <c:choose>
                           <c:when test="${product.discountRate > 0}">
                              <span style="text-decoration: line-through; color: #999; font-size: 16px;">
                                 <fmt:formatNumber value="${product.productPrice}" pattern="#,###" />원
                              </span>
                              <br>
                              <fmt:formatNumber value="${product.productPrice * (1 - product.discountRate)}" pattern="#,###" />원
                              <span class="badge badge-danger ml-2">${product.discountRate * 100}% 할인</span>
                           </c:when>
                           <c:otherwise>
                              <fmt:formatNumber value="${product.productPrice}" pattern="#,###" />원
                           </c:otherwise>
                        </c:choose>
                     </div>

                     <div class="product-actions">
                        <button class="btn-detail" onclick="goToDetail(${product.productId})">
                           상세보기
                        </button>
                        <button class="btn-cart" onclick="addToCart(${product.productId})">
                           장바구니
                        </button>
                     </div>
                  </div>
               </div>
            </c:forEach>
         </div>
      </c:when>
      <c:otherwise>
         <div class="no-results">
            <div class="no-results-icon">🔍</div>
            <h4>검색 결과가 없습니다</h4>
            <p>다른 키워드로 검색해보시거나 필터 조건을 변경해보세요.</p>

            <!-- 추천 검색어 -->
            <div style="margin-top: 30px;">
               <h5>💡 추천 검색어</h5>
               <div style="margin-top: 15px;">
                  <a href="${pageContext.request.contextPath}/search?keyword=노트북" class="btn btn-outline-primary btn-sm mr-2">노트북</a>
                  <a href="${pageContext.request.contextPath}/search?keyword=스마트폰" class="btn btn-outline-primary btn-sm mr-2">스마트폰</a>
                  <a href="${pageContext.request.contextPath}/search?keyword=이어폰" class="btn btn-outline-primary btn-sm mr-2">이어폰</a>
                  <a href="${pageContext.request.contextPath}/search?keyword=모니터" class="btn btn-outline-primary btn-sm mr-2">모니터</a>
               </div>
            </div>

            <!-- 인기 상품 표시 -->
            <div id="popular-products" style="margin-top: 40px;">
               <h5>🔥 인기 상품</h5>
               <div id="popular-products-grid" class="product-grid" style="margin-top: 20px;">
                  <!-- AJAX로 로드될 인기 상품들 -->
               </div>
            </div>
         </div>
      </c:otherwise>
   </c:choose>
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
<!-- footer section -->

<!-- copyright -->
<div class="cpy_">
  <p class="mx-auto">© 2021 All Rights Reserved By <a href="https://html.design/">Free Html Templates</a><br>
    Distributed By <a href="https://themewagon.com/" target="_blank">ThemeWagon</a>
  </p>
</div>
<!-- footer section -->

<!-- JavaScript -->
<script src="${pageContext.request.contextPath}/views/js/bootstrap.js"></script>

</body>
</html>