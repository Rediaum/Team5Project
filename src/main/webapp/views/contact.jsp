<%-- 1. JSP 페이지 기본 설정 및 JSTL 태그 라이브러리 선언 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
   <!-- Basic -->
   <meta charset="utf-8" />
   <meta http-equiv="X-UA-Compatible" content="IE=edge" />
   <!-- Mobile Metas -->
   <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
   <!-- Site Metas -->
   <meta name="keywords" content="" />
   <meta name="description" content="" />
   <meta name="author" content="" />

   <%-- 2. 리소스(CSS, JS, 이미지 등) 경로 수정 --%>
   <link rel="shortcut icon" href="${pageContext.request.contextPath}/views/images/favicon.png" type="">
   <title>Famms - Fashion HTML Template</title>
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
</head>
<body class="sub_page">
<div class="hero_area">
   <%-- 4. 헤더 섹션 시작 --%>
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
                     <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true" style="color: #000;">
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
   <!-- end header section -->
</div>
<!-- inner page section -->
<section class="inner_page_head">
   <div class="container_fuild">
      <div class="row">
         <div class="col-md-12">
            <div class="full">
               <h3>Contact us</h3>
            </div>
         </div>
      </div>
   </div>
</section>
<!-- end inner page section -->
<!-- why section -->
<section class="why_section layout_padding">
   <div class="container">

      <div class="row">
         <div class="col-lg-8 offset-lg-2">
            <div class="full">
               <%-- 4. Form action 경로 수정 --%>
               <%-- 폼 제출 시 처리할 컨트롤러의 경로로 수정합니다. --%>
               <form action="${pageContext.request.contextPath}/contact/submit" method="post">
                  <fieldset>
                     <input type="text" placeholder="Enter your full name" name="name" required />
                     <input type="email" placeholder="Enter your email address" name="email" required />
                     <input type="text" placeholder="Enter subject" name="subject" required />
                     <textarea placeholder="Enter your message" name="message" required></textarea>
                     <input type="submit" value="Submit" />
                  </fieldset>
               </form>
            </div>
         </div>
      </div>
   </div>
</section>
<!-- end why section -->
<!-- arrival section -->
<section class="arrival_section">
   <div class="container">
      <div class="box">
         <div class="arrival_bg_box">
            <img src="${pageContext.request.contextPath}/views/images/arrival-bg.png" alt="">
         </div>
         <div class="row">
            <div class="col-md-6 ml-auto">
               <div class="heading_container remove_line_bt">
                  <h2>
                     #NewArrivals
                  </h2>
               </div>
               <p style="margin-top: 20px;margin-bottom: 30px;">
                  Vitae fugiat laboriosam officia perferendis provident aliquid voluptatibus dolorem, fugit ullam sit earum id eaque nisi hic? Tenetur commodi, nisi rem vel, ea eaque ab ipsa, autem similique ex unde!
               </p>
               <a href="${pageContext.request.contextPath}/product">
                  Shop Now
               </a>
            </div>
         </div>
      </div>
   </div>
</section>
<!-- end arrival section -->
<!-- footer section -->
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
<!-- footer section -->
<!-- jQery -->
<script src="${pageContext.request.contextPath}/views/js/jquery-3.4.1.min.js"></script>
<!-- popper js -->
<script src="${pageContext.request.contextPath}/views/js/popper.min.js"></script>
<!-- bootstrap js -->
<script src="${pageContext.request.contextPath}/views/js/bootstrap.js"></script>
<!-- custom js -->
<script src="${pageContext.request.contextPath}/views/js/custom.js"></script>
</body>
</html>
