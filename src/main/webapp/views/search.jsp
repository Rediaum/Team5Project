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
   <%@ include file="header.jsp" %>
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