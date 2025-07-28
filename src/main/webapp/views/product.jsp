<%-- 1. JSP 페이지 기본 설정 및 JSTL 태그 라이브러리 선언 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
   <meta charset="utf-8" />
   <meta http-equiv="X-UA-Compatible" content="IE=edge" />
   <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
   <meta name="keywords" content="" />
   <meta name="description" content="" />
   <meta name="author" content="" />

   <%-- 2. 리소스(CSS, JS, 이미지 등) 경로 수정 --%>
   <link rel="shortcut icon" href="${pageContext.request.contextPath}/views/images/favicon.png" type="">
   <title>Famms - Fashion HTML Template</title>
   <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/views/css/bootstrap.css" />
   <link href="${pageContext.request.contextPath}/views/css/font-awesome.min.css" rel="stylesheet" />
   <link href="${pageContext.request.contextPath}/views/css/style.css" rel="stylesheet" />
   <link href="${pageContext.request.contextPath}/views/css/responsive.css" rel="stylesheet" />
</head>
<body class="sub_page">
<div class="hero_area">
   <header class="header_section">
      <div class="container">
         <nav class="navbar navbar-expand-lg custom_nav-container ">
            <%-- 3. 페이지 이동 경로 수정 --%>
            <a class="navbar-brand" href="${pageContext.request.contextPath}/"><img width="250" src="${pageContext.request.contextPath}/views/images/logo.png" alt="#" /></a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
               <span class=""> </span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
               <ul class="navbar-nav">
                  <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/">Home <span class="sr-only">(current)</span></a>
                  </li>
                  <li class="nav-item dropdown">
                     <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true"> <span class="nav-label">Pages <span class="caret"></span></a>
                     <ul class="dropdown-menu">
                        <li><a href="${pageContext.request.contextPath}/about">About</a></li>
                        <li><a href="${pageContext.request.contextPath}/testimonial">Testimonial</a></li>
                     </ul>
                  </li>
                  <li class="nav-item active">
                     <a class="nav-link" href="${pageContext.request.contextPath}/product">Products</a>
                  </li>
                  <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/blog_list">Blog</a>
                  </li>
                  <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/contact">Contact</a>
                  </li>
                  <li class="nav-item dropdown">
                     <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="color: #000;">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                           <circle cx="12" cy="7" r="4"/>
                           <path d="M6 21v-2a4 4 0 0 1 4-4h4a4 4 0 0 1 4 4v2"/>
                        </svg>
                     </a>
                     <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
                        <c:choose>
                           <c:when test="${sessionScope.logincust == null}">
                              <a class="dropdown-item" href="${pageContext.request.contextPath}/login">
                                 <i class="fa fa-sign-in" aria-hidden="true"></i> Login
                              </a>
                              <a class="dropdown-item" href="${pageContext.request.contextPath}/register">
                                 <i class="fa fa-user-plus" aria-hidden="true"></i> Register
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
                  <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                        <svg version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 456.029 456.029" style="enable-background:new 0 0 456.029 456.029;"
                             xml:space="preserve">
                                 <g>
                                    <g>
                                       <path d="M345.6,338.862c-29.184,0-53.248,23.552-53.248,53.248c0,29.184,23.552,53.248,53.248,53.248
                                          c29.184,0,53.248-23.552,53.248-53.248C398.336,362.926,374.784,338.862,345.6,338.862z" />
                                    </g>
                                 </g>
                           <g>
                              <g>
                                 <path d="M439.296,84.91c-1.024,0-2.56-0.512-4.096-0.512H112.64l-5.12-34.304C104.448,27.566,84.992,10.67,61.952,10.67H20.48
                                          C9.216,10.67,0,19.886,0,31.15c0,11.264,9.216,20.48,20.48,20.48h41.472c2.56,0,4.608,2.048,5.12,4.608l31.744,216.064
                                          c4.096,27.136,27.648,47.616,55.296,47.616h212.992c26.624,0,49.664-18.944,55.296-45.056l33.28-166.4
                                          C457.728,97.71,450.56,86.958,439.296,84.91z" />
                              </g>
                           </g>
                           <g>
                              <g>
                                 <path d="M215.04,389.55c-1.024-28.16-24.576-50.688-52.736-50.688c-29.696,1.536-52.224,26.112-51.2,55.296
                                          c1.024,28.16,24.064,50.688,52.224,50.688h1.024C193.536,443.31,216.576,418.734,215.04,389.55z" />
                              </g>
                           </g>
                              </svg>
                     </a>
                  </li>
                  <form class="form-inline" action="${pageContext.request.contextPath}/search">
                     <button class="btn  my-2 my-sm-0 nav_search-btn" type="submit">
                        <i class="fa fa-search" aria-hidden="true"></i>
                     </button>
                  </form>
               </ul>
            </div>
         </nav>
      </div>
   </header>
</div>
<section class="inner_page_head">
   <div class="container_fuild">
      <div class="row">
         <div class="col-md-12">
            <div class="full">
               <h3>Product Grid</h3>
            </div>
         </div>
      </div>
   </div>
</section>
<section class="product_section layout_padding">
   <div class="container">
      <div class="heading_container heading_center">
         <h2>
            Our <span>products</span>
         </h2>
      </div>
      <div class="row">
         <%-- 4. 동적 데이터 처리 예시 --%>
         <%-- 이 부분은 DB에서 상품 목록(productList)을 가져와 JSTL로 반복 처리합니다. --%>
         <c:forEach var="product" items="${productList}">
            <div class="col-sm-6 col-md-4 col-lg-3">
               <div class="box">
                  <div class="option_container">
                     <div class="options">
                           <%-- 상품 상세 페이지 링크 --%>
                        <a href="${pageContext.request.contextPath}/product/detail/${product.productId}" class="option1">
                              ${product.productName}
                        </a>

                           <%-- 장바구니 추가 버튼 (로그인 체크) --%>
                        <c:choose>
                           <c:when test="${sessionScope.logincust != null}">
                              <%-- 로그인시: 장바구니 추가 --%>
                              <a href="${pageContext.request.contextPath}/cart/add?productId=${product.productId}" class="option2">
                                 Add To Cart
                              </a>
                           </c:when>
                           <c:otherwise>
                              <%-- 비로그인시: 로그인 페이지로 --%>
                              <a href="${pageContext.request.contextPath}/login" class="option2"
                                 onclick="alert('장바구니에 상품을 담으려면 로그인이 필요합니다.'); return true;">
                                 Add To Cart
                              </a>
                           </c:otherwise>
                        </c:choose>

                           <%-- 바로 구매 버튼 (로그인 체크) --%>
                        <c:choose>
                           <c:when test="${sessionScope.logincust != null}">
                              <%-- 로그인시: 바로 구매 --%>
                              <a href="${pageContext.request.contextPath}/cart/add?productId=${product.productId}" class="option3">
                                 Buy Now
                              </a>
                           </c:when>
                           <c:otherwise>
                              <%-- 비로그인시: 로그인 페이지로 --%>
                              <a href="${pageContext.request.contextPath}/login" class="option3"
                                 onclick="alert('구매하려면 로그인이 필요합니다.'); return true;">
                                 Buy Now
                              </a>
                           </c:otherwise>
                        </c:choose>
                     </div>
                  </div>
                  <div class="img-box">
                        <%-- 이미지 경로: ${pageContext.request.contextPath}/views/images/상품이미지파일명 --%>
                     <img src="${pageContext.request.contextPath}/views/images/${product.productImg}" alt="${product.productName}">
                  </div>
                  <!-- 상품 정보 (이름, 가격) - 할인 적용 버전 -->
                  <div class="detail-box" style="display: block !important">
                     <h5>${product.productName}</h5>

                     <!-- 할인율에 따른 가격 표시 -->
                     <c:choose>
                        <c:when test="${product.discountRate > 0}">
                           <!-- 할인이 있는 경우 -->
                           <c:set var="discountedPrice" value="${product.productPrice * (100 - (product.discountRate*100)) / 100}" />
                           <div style="display: flex; align-items: center; gap: 8px; flex-wrap: wrap;">
                              <!-- 할인된 가격 (크게) -->
                              <h6 style="color: #1a1a1a; font-weight: bold; margin: 0;">
                                 <fmt:formatNumber type="number" pattern="###,###원" value="${discountedPrice}" />
                              </h6>
                              <!-- 원래 가격 (취소선) -->
                              <span style="color: #999; text-decoration: line-through; font-size: 0.9rem;">
                                       <fmt:formatNumber type="number" pattern="###,###원" value="${product.productPrice}" />
                                    </span>
                              <!-- 할인율 배지 -->
                              <span style="background: #e74c3c; color: white; padding: 2px 6px; border-radius: 8px; font-size: 0.75rem; font-weight: bold;">
                                       ${product.discountRate*100}% 할인
                                    </span>
                           </div>
                        </c:when>
                        <c:otherwise>
                           <!-- 할인이 없는 경우 -->
                           <h6><fmt:formatNumber type="number" pattern="###,###원" value="${product.productPrice}" /></h6>
                        </c:otherwise>
                     </c:choose>
                  </div>
               </div>
            </div>
         </c:forEach>


         <%-- ... 나머지 정적 상품들도 동일하게 경로 수정 ... --%>
      </div>
      <div class="btn-box">
         <a href="">
            View All products
         </a>
      </div>
   </div>
</section>
<footer class="footer_section">
   <div class="container">
      <div class="row">
         <div class="col-md-4 footer-col">
            <div class="footer_contact">
               <h4>
                  Reach at..
               </h4>
               <div class="contact_link_box">
                  <a href="">
                     <i class="fa fa-map-marker" aria-hidden="true"></i>
                     <span>
                        Location
                        </span>
                  </a>
                  <a href="">
                     <i class="fa fa-phone" aria-hidden="true"></i>
                     <span>
                        Call +01 1234567890
                        </span>
                  </a>
                  <a href="">
                     <i class="fa fa-envelope" aria-hidden="true"></i>
                     <span>
                        demo@gmail.com
                        </span>
                  </a>
               </div>
            </div>
         </div>
         <div class="col-md-4 footer-col">
            <div class="footer_detail">
               <a href="${pageContext.request.contextPath}/" class="footer-logo">
                  Famms
               </a>
               <p>
                  Necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with
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
                  <a href="">
                     <i class="fa fa-pinterest" aria-hidden="true"></i>
                  </a>
               </div>
            </div>
         </div>
         <div class="col-md-4 footer-col">
            <div class="map_container">
               <div class="map">
                  <div id="googleMap"></div>
               </div>
            </div>
         </div>
      </div>
      <div class="footer-info">
         <div class="col-lg-7 mx-auto px-0">
            <p>
               &copy; <span id="displayYear"></span> All Rights Reserved By
               <a href="https://html.design/">Free Html Templates</a><br>

               Distributed By <a href="https://themewagon.com/" target="_blank">ThemeWagon</a>
            </p>
         </div>
      </div>
   </div>
</footer>
<script src="${pageContext.request.contextPath}/views/js/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/views/js/popper.min.js"></script>
<script src="${pageContext.request.contextPath}/views/js/bootstrap.js"></script>
<script src="${pageContext.request.contextPath}/views/js/custom.js"></script>
</body>
</html>