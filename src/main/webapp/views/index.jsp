<%-- 1. JSP 페이지 기본 설정 및 JSTL 태그 라이브러리 선언 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
   <!-- Site Metas -->
   <meta name="keywords" content="" />
   <meta name="description" content="" />
   <meta name="author" content="" />

   <%-- 2. 리소스(CSS, JS, 이미지 등) 경로 설정 --%>
   <%-- 사용자 경로인 /src/main/webapp/views/ 에 맞게 경로를 수정합니다. --%>
   <link rel="shortcut icon" href="${pageContext.request.contextPath}/views/images/favicon.png" type="">
   <title>Shop - Project team - 5</title>
   <!-- bootstrap core css -->
   <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/views/css/bootstrap.css" />
   <!-- font awesome style -->
   <link href="${pageContext.request.contextPath}/views/css/font-awesome.min.css" rel="stylesheet" />
   <!-- Custom styles for this template -->
   <link href="${pageContext.request.contextPath}/views/css/style.css" rel="stylesheet" />
   <!-- responsive style -->
   <link href="${pageContext.request.contextPath}/views/css/responsive.css" rel="stylesheet" />

   <%-- 3. 사용자 드롭다운 메뉴 스타일 --%>
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
<body>
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
                     <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true"> <span class="nav-label">Pages <span class="caret"></span></a>
                     <ul class="dropdown-menu">
                        <li><a href="${pageContext.request.contextPath}/about">About</a></li>
                        <li><a href="${pageContext.request.contextPath}/testimonial">Testimonial</a></li>
                     </ul>
                  </li>

                  <%-- Products 메뉴 --%>
                  <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/product">Products</a>
                  </li>

                  <%-- Blog 메뉴 --%>
                  <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/blog_list">Blog</a>
                  </li>

                  <%-- Contact 메뉴 --%>
                  <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/contact">Contact</a>
                  </li>

                  <%-- 5. 사용자 관리 드롭다운 메뉴 (사람 아이콘) --%>
                  <li class="nav-item dropdown">
                     <%-- 사람 아이콘으로 구성된 드롭다운 트리거 --%>
                     <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="color: #000;">
                        <!-- 사람 아이콘 SVG -->
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                           <circle cx="12" cy="7" r="4"/><!-- 머리 -->
                           <path d="M6 21v-2a4 4 0 0 1 4-4h4a4 4 0 0 1 4 4v2"/><!-- 몸통 -->
                        </svg>
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

   <%-- 8. 슬라이더 섹션 시작 --%>
   <section class="slider_section ">
      <%-- 슬라이더 배경 이미지 --%>
      <div class="slider_bg_box">
         <img src="${pageContext.request.contextPath}/views/images/slider-bg.jpg" alt="">
      </div>

      <%-- Bootstrap 캐러셀 --%>
      <div id="customCarousel1" class="carousel slide" data-ride="carousel">
         <div class="carousel-inner">
            <%-- 첫 번째 슬라이드 (활성화 상태) --%>
            <div class="carousel-item active">
               <div class="container ">
                  <div class="row">
                     <div class="col-md-7 col-lg-6 ">
                        <div class="detail-box">
                           <%-- 메인 제목 --%>
                           <h1>
                              <span>Sale 20% Off</span>
                              <br>
                              On Everything
                           </h1>
                           <%-- 설명 텍스트 --%>
                           <p>
                              Explicabo esse amet tempora quibusdam laudantium, laborum eaque magnam fugiat hic? Esse dicta aliquid error repudiandae earum suscipit fugiat molestias, veniam, vel architecto veritatis delectus repellat modi impedit sequi.
                           </p>
                           <%-- 액션 버튼들 --%>
                           <div class="btn-box">
                              <%-- 쇼핑하기 버튼 --%>
                              <a href="${pageContext.request.contextPath}/product" class="btn1">
                                 Shop Now
                              </a>
                              <%-- 회원가입 버튼 (녹색) --%>
                              <a href="${pageContext.request.contextPath}/register" class="btn1" style="margin-left: 15px; background-color: #28a745; border-color: #28a745;">
                                 Join Now
                              </a>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
            </div>

            <%-- 두 번째 슬라이드 --%>
            <div class="carousel-item ">
               <div class="container ">
                  <div class="row">
                     <div class="col-md-7 col-lg-6 ">
                        <div class="detail-box">
                           <h1>
                              <span>Sale 20% Off</span>
                              <br>
                              On Everything
                           </h1>
                           <p>
                              Explicabo esse amet tempora quibusdam laudantium, laborum eaque magnam fugiat hic? Esse dicta aliquid error repudiandae earum suscipit fugiat molestias, veniam, vel architecto veritatis delectus repellat modi impedit sequi.
                           </p>
                           <div class="btn-box">
                              <a href="${pageContext.request.contextPath}/product" class="btn1">
                                 Shop Now
                              </a>
                              <a href="${pageContext.request.contextPath}/register" class="btn1" style="margin-left: 15px; background-color: #28a745; border-color: #28a745;">
                                 Join Now
                              </a>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
            </div>

            <%-- 세 번째 슬라이드 --%>
            <div class="carousel-item">
               <div class="container ">
                  <div class="row">
                     <div class="col-md-7 col-lg-6 ">
                        <div class="detail-box">
                           <h1>
                              <span>Sale 20% Off</span>
                              <br>
                              On Everything
                           </h1>
                           <p>
                              Explicabo esse amet tempora quibusdam laudantium, laborum eaque magnam fugiat hic? Esse dicta aliquid error repudiandae earum suscipit fugiat molestias, veniam, vel architecto veritatis delectus repellat modi impedit sequi.
                           </p>
                           <div class="btn-box">
                              <a href="${pageContext.request.contextPath}/product" class="btn1">
                                 Shop Now
                              </a>
                              <a href="${pageContext.request.contextPath}/register" class="btn1" style="margin-left: 15px; background-color: #28a745; border-color: #28a745;">
                                 Join Now
                              </a>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>

         <%-- 캐러셀 인디케이터 (점 표시) --%>
         <div class="container">
            <ol class="carousel-indicators">
               <li data-target="#customCarousel1" data-slide-to="0" class="active"></li>
               <li data-target="#customCarousel1" data-slide-to="1"></li>
               <li data-target="#customCarousel1" data-slide-to="2"></li>
            </ol>
         </div>
      </div>
   </section>
   <!-- end slider section -->
</div>

<%-- 9. 성공/오류 메시지 표시 영역 --%>
<%-- 성공 메시지 (회원가입 완료 등) --%>
<c:if test="${not empty success}">
   <div class="container">
      <div class="alert alert-success alert-dismissible fade show" role="alert" style="margin: 20px 0;">
         <strong>성공!</strong> ${success}
         <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
         </button>
      </div>
   </div>
</c:if>

<%-- 오류 메시지 (로그인 실패 등) --%>
<c:if test="${not empty error}">
   <div class="container">
      <div class="alert alert-danger alert-dismissible fade show" role="alert" style="margin: 20px 0;">
         <strong>오류!</strong> ${error}
         <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
         </button>
      </div>
   </div>
</c:if>

<%-- 10. "Why Shop With Us" 섹션 --%>
<section class="why_section layout_padding">
   <div class="container">
      <div class="heading_container heading_center">
         <h2>Why Shop With Us</h2>
      </div>
      <div class="row">
         <%-- 빠른 배송 --%>
         <div class="col-md-4">
            <div class="box ">
               <div class="img-box">
                  <%-- 배송 트럭 SVG 아이콘 --%>
                  <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 512 512" style="enable-background:new 0 0 512 512;" xml:space="preserve">
                     <!-- SVG 패스 생략 (배송 관련 아이콘) -->
                     <g><g><path d="M476.158,231.363l-13.259-53.035c3.625-0.77,6.345-3.986,6.345-7.839v-8.551c0-18.566-15.105-33.67-33.67-33.67h-60.392V110.63c0-9.136-7.432-16.568-16.568-16.568H50.772c-9.136,0-16.568,7.432-16.568,16.568V256c0,4.427,3.589,8.017,8.017,8.017c4.427,0,8.017-3.589,8.017-8.017V110.63c0-0.295,0.239-0.534,0.534-0.534h307.841c0.295,0,0.534,0.239,0.534,0.534v145.372c0,4.427,3.589,8.017,8.017,8.017c4.427,0,8.017-3.589,8.017-8.017v-9.088h94.569c0.008,0,0.014,0.002,0.021,0.002c0.008,0,0.015-0.001,0.022-0.001c11.637,0.008,21.518,7.646,24.912,18.171h-24.928c-4.427,0-8.017,3.589-8.017,8.017v17.102c0,13.851,11.268,25.119,25.119,25.119h9.086v35.273h-20.962c-6.886-19.883-25.787-34.205-47.982-34.205s-41.097,14.322-47.982,34.205h-3.86v-60.393c0-4.427-3.589-8.017-8.017-8.017c-4.427,0-8.017,3.589-8.017,8.017v60.391H192.817c-6.886-19.883-25.787-34.205-47.982-34.205s-41.097,14.322-47.982,34.205H50.772c-0.295,0-0.534-0.239-0.534-0.534v-17.637h34.739c4.427,0,8.017-3.589,8.017-8.017s-3.589-8.017-8.017-8.017H8.017c-4.427,0-8.017,3.589-8.017,8.017s3.589,8.017,8.017,8.017h26.188v17.637c0,9.136,7.432,16.568,16.568,16.568h43.304c-0.002,0.178-0.014,0.355-0.014,0.534c0,27.996,22.777,50.772,50.772,50.772s50.772-22.776,50.772-50.772c0-0.18-0.012-0.356-0.014-0.534h180.67c-0.002,0.178-0.014,0.355-0.014,0.534c0,27.996,22.777,50.772,50.772,50.772c27.995,0,50.772-22.776,50.772-50.772c0-0.18-0.012-0.356-0.014-0.534h26.203c4.427,0,8.017-3.589,8.017-8.017v-85.511C512,251.989,496.423,234.448,476.158,231.363z M375.182,144.301h60.392c9.725,0,17.637,7.912,17.637,17.637v0.534h-78.029V144.301z M375.182,230.881v-52.376h71.235l13.094,52.376H375.182z M144.835,401.904c-19.155,0-34.739-15.583-34.739-34.739s15.584-34.739,34.739-34.739c19.155,0,34.739,15.583,34.739,34.739S163.99,401.904,144.835,401.904z M427.023,401.904c-19.155,0-34.739-15.583-34.739-34.739s15.584-34.739,34.739-34.739c19.155,0,34.739,15.583,34.739,34.739S446.178,401.904,427.023,401.904z M495.967,299.29h-9.086c-5.01,0-9.086-4.076-9.086-9.086v-9.086h18.171V299.29z" /></g></g>
                     <g><g><path d="M144.835,350.597c-9.136,0-16.568,7.432-16.568,16.568c0,9.136,7.432,16.568,16.568,16.568c9.136,0,16.568-7.432,16.568-16.568C161.403,358.029,153.971,350.597,144.835,350.597z" /></g></g>
                     <g><g><path d="M427.023,350.597c-9.136,0-16.568,7.432-16.568,16.568c0,9.136,7.432,16.568,16.568,16.568c9.136,0,16.568-7.432,16.568-16.568C443.591,358.029,436.159,350.597,427.023,350.597z" /></g></g>
                     <g><g><path d="M332.96,316.393H213.244c-4.427,0-8.017,3.589-8.017,8.017s3.589,8.017,8.017,8.017H332.96c4.427,0,8.017-3.589,8.017-8.017S337.388,316.393,332.96,316.393z" /></g></g>
                     <g><g><path d="M127.733,282.188H25.119c-4.427,0-8.017,3.589-8.017,8.017s3.589,8.017,8.017,8.017h102.614c4.427,0,8.017-3.589,8.017-8.017S132.16,282.188,127.733,282.188z" /></g></g>
                     <g><g><path d="M278.771,173.37c-3.13-3.13-8.207-3.13-11.337,0.001l-71.292,71.291l-37.087-37.087c-3.131-3.131-8.207-3.131-11.337,0c-3.131,3.131-3.131,8.206,0,11.337l42.756,42.756c1.565,1.566,3.617,2.348,5.668,2.348s4.104-0.782,5.668-2.348l76.96-76.96C281.901,181.576,281.901,176.501,278.771,173.37z" /></g></g>
                  </svg>
               </div>
               <div class="detail-box">
                  <h5>Fast Delivery</h5>
                  <p>variations of passages of Lorem Ipsum available</p>
               </div>
            </div>
         </div>

         <%-- 무료 배송 --%>
         <div class="col-md-4">
            <div class="box ">
               <div class="img-box">
                  <%-- 무료 배송 SVG 아이콘 --%>
                  <svg version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 490.667 490.667" style="enable-background:new 0 0 490.667 490.667;" xml:space="preserve">
                     <!-- SVG 패스 생략 (무료 배송 관련 아이콘) -->
                     <g><g><path d="M138.667,192H96c-5.888,0-10.667,4.779-10.667,10.667V288c0,5.888,4.779,10.667,10.667,10.667s10.667-4.779,10.667-10.667v-74.667h32c5.888,0,10.667-4.779,10.667-10.667S144.555,192,138.667,192z" /></g></g>
                     <g><g><path d="M117.333,234.667H96c-5.888,0-10.667,4.779-10.667,10.667S90.112,256,96,256h21.333c5.888,0,10.667-4.779,10.667-10.667S123.221,234.667,117.333,234.667z" /></g></g>
                     <g><g><path d="M245.333,0C110.059,0,0,110.059,0,245.333s110.059,245.333,245.333,245.333s245.333-110.059,245.333-245.333S380.608,0,245.333,0z M245.333,469.333c-123.52,0-224-100.48-224-224s100.48-224,224-224s224,100.48,224,224S368.853,469.333,245.333,469.333z" /></g></g>
                     <g><g><path d="M386.752,131.989C352.085,88.789,300.544,64,245.333,64s-106.752,24.789-141.419,67.989c-3.691,4.587-2.965,11.307,1.643,14.997c4.587,3.691,11.307,2.965,14.976-1.643c30.613-38.144,76.096-60.011,124.8-60.011s94.187,21.867,124.779,60.011c2.112,2.624,5.205,3.989,8.32,3.989c2.368,0,4.715-0.768,6.677-2.347C389.717,143.296,390.443,136.576,386.752,131.989z" /></g></g>
                     <g><g><path d="M376.405,354.923c-4.224-4.032-11.008-3.861-15.061,0.405c-30.613,32.235-71.808,50.005-116.011,50.005s-85.397-17.771-115.989-50.005c-4.032-4.309-10.816-4.437-15.061-0.405c-4.309,4.053-4.459,10.816-0.405,15.083c34.667,36.544,81.344,56.661,131.456,56.661s96.789-20.117,131.477-56.661C380.864,365.739,380.693,358.976,376.405,354.923z" /></g></g>
                     <g><g><path d="M206.805,255.723c15.701-2.027,27.861-15.488,27.861-31.723c0-17.643-14.357-32-32-32h-21.333c-5.888,0-10.667,4.779-10.667,10.667v42.581c0,0.043,0,0.107,0,0.149V288c0,5.888,4.779,10.667,10.667,10.667S192,293.888,192,288v-16.917l24.448,24.469c2.091,2.069,4.821,3.115,7.552,3.115c2.731,0,5.461-1.045,7.531-3.136c4.16-4.16,4.16-10.923,0-15.083L206.805,255.723z M192,234.667v-21.333h10.667c5.867,0,10.667,4.779,10.667,10.667s-4.8,10.667-10.667,10.667H192z" /></g></g>
                     <g><g><path d="M309.333,277.333h-32v-64h32c5.888,0,10.667-4.779,10.667-10.667S315.221,192,309.333,192h-42.667c-5.888,0-10.667,4.779-10.667,10.667V288c0,5.888,4.779,10.667,10.667,10.667h42.667c5.888,0,10.667-4.779,10.667-10.667S315.221,277.333,309.333,277.333z" /></g></g>
                     <g><g><path d="M288,234.667h-21.333c-5.888,0-10.667,4.779-10.667,10.667S260.779,256,266.667,256H288c5.888,0,10.667-4.779,10.667-10.667S293.888,234.667,288,234.667z" /></g></g>
                     <g><g><path d="M394.667,277.333h-32v-64h32c5.888,0,10.667-4.779,10.667-10.667S400.555,192,394.667,192H352c-5.888,0-10.667,4.779-10.667,10.667V288c0,5.888,4.779,10.667,10.667,10.667h42.667c5.888,0,10.667-4.779,10.667-10.667S400.555,277.333,394.667,277.333z" /></g></g>
                     <g><g><path d="M373.333,234.667H352c-5.888,0-10.667,4.779-10.667,10.667S346.112,256,352,256h21.333c5.888,0,10.667-4.779,10.667-10.667S379.221,234.667,373.333,234.667z" /></g></g>
                  </svg>
               </div>
               <div class="detail-box">
                  <h5>Free Shiping</h5>
                  <p>variations of passages of Lorem Ipsum available</p>
               </div>
            </div>
         </div>

         <%-- 최고 품질 --%>
         <div class="col-md-4">
            <div class="box ">
               <div class="img-box">
                  <%-- 품질 보증 SVG 아이콘 --%>
                  <svg id="_30_Premium" height="512" viewBox="0 0 512 512" width="512" xmlns="http://www.w3.org/2000/svg" data-name="30_Premium">
                     <g id="filled">
                        <!-- 품질 관련 아이콘 경로들 -->
                        <path d="m252.92 300h3.08a124.245 124.245 0 1 0 -4.49-.09c.075.009.15.023.226.03.394.039.789.06 1.184.06zm-96.92-124a100 100 0 1 1 100 100 100.113 100.113 0 0 1 -100-100z" />
                        <path d="m447.445 387.635-80.4-80.4a171.682 171.682 0 0 0 60.955-131.235c0-94.841-77.159-172-172-172s-172 77.159-172 172c0 73.747 46.657 136.794 112 161.2v158.8c-.3 9.289 11.094 15.384 18.656 9.984l41.344-27.562 41.344 27.562c7.574 5.4 18.949-.7 18.656-9.984v-70.109l46.6 46.594c6.395 6.789 18.712 3.025 20.253-6.132l9.74-48.724 48.725-9.742c9.163-1.531 12.904-13.893 6.127-20.252zm-339.445-211.635c0-81.607 66.393-148 148-148s148 66.393 148 148-66.393 148-148 148-148-66.393-148-148zm154.656 278.016a12 12 0 0 0 -13.312 0l-29.344 19.562v-129.378a172.338 172.338 0 0 0 72 0v129.38zm117.381-58.353a12 12 0 0 0 -9.415 9.415l-6.913 34.58-47.709-47.709v-54.749a171.469 171.469 0 0 0 31.467-15.6l67.151 67.152z" />
                        <path d="m287.62 236.985c8.349 4.694 19.251-3.212 17.367-12.618l-5.841-35.145 25.384-25c7.049-6.5 2.89-19.3-6.634-20.415l-35.23-5.306-15.933-31.867c-4.009-8.713-17.457-8.711-21.466 0l-15.933 31.866-35.23 5.306c-9.526 1.119-13.681 13.911-6.634 20.415l25.384 25-5.841 35.145c-1.879 9.406 9 17.31 17.367 12.618l31.62-16.414zm-53-32.359 2.928-17.615a12 12 0 0 0 -3.417-10.516l-12.721-12.531 17.658-2.66a12 12 0 0 0 8.947-6.5l7.985-15.971 7.985 15.972a12 12 0 0 0 8.947 6.5l17.658 2.66-12.723 12.535a12 12 0 0 0 -3.417 10.516l2.928 17.615-15.849-8.231a12 12 0 0 0 -11.058 0z" />
                     </g>
                  </svg>
               </div>
               <div class="detail-box">
                  <h5>Best Quality</h5>
                  <p>variations of passages of Lorem Ipsum available</p>
               </div>
            </div>
         </div>
      </div>
   </div>
</section>
<!-- end why section -->

<%-- 11. 신상품 도착 섹션 --%>
<section class="arrival_section">
   <div class="container">
      <div class="box">
         <%-- 배경 이미지 --%>
         <div class="arrival_bg_box">
            <img src="${pageContext.request.contextPath}/views/images/arrival-bg.png" alt="">
         </div>
         <div class="row">
            <div class="col-md-6 ml-auto">
               <div class="heading_container remove_line_bt">
                  <h2>#NewArrivals</h2>
               </div>
               <p style="margin-top: 20px;margin-bottom: 30px;">
                  Vitae fugiat laboriosam officia perferendis provident aliquid voluptatibus dolorem, fugit ullam sit earum id eaque nisi hic? Tenetur commodi, nisi rem vel, ea eaque ab ipsa, autem similique ex unde!
               </p>
               <%-- 쇼핑하기 버튼 --%>
               <a href="${pageContext.request.contextPath}/product">
                  Shop Now
               </a>
            </div>
         </div>
      </div>
   </div>
</section>
<!-- end arrival section -->

<%-- 12. 상품 섹션 (메인) --%>
<section class="product_section layout_padding">
   <div class="container">
      <div class="heading_container heading_center">
         <h2>Our <span>products</span></h2>
      </div>
      <div class="row">
         <%-- 13. DB에서 가져온 상품 목록을 동적으로 표시 --%>
         <c:forEach var="product" items="${productList}" varStatus="status">
            <%-- 메인 페이지에서는 처음 8개 상품만 표시 --%>
            <c:if test="${status.index < 8}">
               <div class="col-sm-6 col-md-4 col-lg-3">
                  <div class="box">
                        <%-- 상품 옵션 컨테이너 (호버 시 나타나는 버튼들) --%>
                     <div class="option_container">
                        <div class="options">
                              <%-- 상품 상세 페이지 링크 --%>
                           <a href="${pageContext.request.contextPath}/product/detail/${product.productId}" class="option1">
                                 ${product.productName}
                           </a>
                              <%-- 장바구니 추가 버튼 --%>
                                 <c:choose>
                                    <c:when test="${sessionScope.logincust != null}">
                                       <%-- 로그인시: 장바구니 추가 --%>
                                       <a href="${pageContext.request.contextPath}/cart/add?productId=${product.productId}" class="option2">
                                          Add To Cart
                                       </a>
                                    </c:when>
                                    <c:otherwise>
                                       <%-- 비로그인시: 로그인 페이지로 --%>
                                       <a href="${pageContext.request.contextPath}/login" class="option2" onclick="alert('로그인이 필요합니다.');">
                                          Add To Cart
                                       </a>
                                    </c:otherwise>
                                 </c:choose>
                              <%-- 바로 구매 버튼 --%>
                           <a href="${pageContext.request.contextPath}/cart/add?productId=${product.productId}" class="option3">
                              Buy Now
                           </a>
                        </div>
                     </div>
                        <%-- 상품 이미지 --%>
                     <div class="img-box">
                        <img src="${pageContext.request.contextPath}/views/images/${product.productImg}" alt="${product.productName}">
                     </div>
                        <!-- 상품 정보 (이름, 가격) - 할인 적용 버전 -->
                        <div class="detail-box" style="display: block !important">
                           <h5>${product.productName}</h5>

                           <!-- 할인율에 따른 가격 표시 -->
                           <c:choose>
                              <c:when test="${product.discountRate > 0}">
                                 <!-- 할인이 있는 경우 -->
                                 <!-- 할인율이 0.1 형태(10%)인지 70 형태(70%)인지 확인 -->
                                 <c:set var="displayDiscountRate" value="${product.discountRate > 1 ? product.discountRate : product.discountRate * 100}" />
                                 <c:set var="actualDiscountRate" value="${product.discountRate > 1 ? product.discountRate / 100 : product.discountRate}" />
                                 <c:set var="discountedPrice" value="${product.productPrice * (1 - actualDiscountRate)}" />

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
                                       <fmt:formatNumber type="number" pattern="##" value="${displayDiscountRate}" />% 할인
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
            </c:if>
         </c:forEach>

         <%-- 14. 상품이 없을 경우 메시지 표시 --%>
         <c:if test="${empty productList}">
            <div class="col-12">
               <div class="text-center">
                  <h4>상품이 준비 중입니다.</h4>
                  <p>곧 다양한 상품을 만나보실 수 있습니다!</p>
               </div>
            </div>
         </c:if>
      </div>

      <%-- 모든 상품 보기 버튼 --%>
      <div class="btn-box">
         <a href="${pageContext.request.contextPath}/product">
            View All products
         </a>
      </div>
   </div>
</section>
<!-- end product section -->

<%-- 15. 구독 섹션 --%>
<section class="subscribe_section">
   <div class="container-fuild">
      <div class="box">
         <div class="row">
            <div class="col-md-6 offset-md-3">
               <div class="subscribe_form ">
                  <div class="heading_container heading_center">
                     <h3>Subscribe To Get Discount Offers</h3>
                  </div>
                  <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor</p>
                  <%-- 이메일 구독 폼 --%>
                  <form action="">
                     <input type="email" placeholder="Enter your email">
                     <button>subscribe</button>
                  </form>
               </div>
            </div>
         </div>
      </div>
   </div>
</section>
<!-- end subscribe section -->

<%-- 16. 고객 후기 섹션 --%>
<section class="client_section layout_padding">
   <div class="container">
      <div class="heading_container heading_center">
         <h2>Customer's Testimonial</h2>
      </div>
      <%-- Bootstrap 캐러셀로 고객 후기 표시 --%>
      <div id="carouselExample3Controls" class="carousel slide" data-ride="carousel">
         <div class="carousel-inner">
            <%-- 첫 번째 후기 (활성화 상태) --%>
            <div class="carousel-item active">
               <div class="box col-lg-10 mx-auto">
                  <div class="img_container">
                     <div class="img-box">
                        <div class="img_box-inner">
                           <img src="${pageContext.request.contextPath}/views/images/client.jpg" alt="">
                        </div>
                     </div>
                  </div>
                  <div class="detail-box">
                     <h5>Anna Trevor</h5>
                     <h6>Customer</h6>
                     <p>민성이는 매우 개쩌는 사람이었어요 그의 판매력에 저는 티셔트 300만장을 사버렸죠 어머 이제 전 vip?</p>
                  </div>
               </div>
            </div>

            <%-- 두 번째 후기 --%>
            <div class="carousel-item">
               <div class="box col-lg-10 mx-auto">
                  <div class="img_container">
                     <div class="img-box">
                        <div class="img_box-inner">
                           <img src="${pageContext.request.contextPath}/views/images/client.jpg" alt="">
                        </div>
                     </div>
                  </div>
                  <div class="detail-box">
                     <h5>Anna Trevor</h5>
                     <h6>Customer</h6>
                     <p>Dignissimos reprehenderit repellendus nobis error quibusdam? Atque animi sint unde quis reprehenderit, et, perspiciatis, debitis totam est deserunt eius officiis ipsum ducimus ad labore modi voluptatibus accusantium sapiente nam! Quaerat.</p>
                  </div>
               </div>
            </div>

            <%-- 세 번째 후기 --%>
            <div class="carousel-item">
               <div class="box col-lg-10 mx-auto">
                  <div class="img_container">
                     <div class="img-box">
                        <div class="img_box-inner">
                           <img src="${pageContext.request.contextPath}/views/images/client.jpg" alt="">
                        </div>
                     </div>
                  </div>
                  <div class="detail-box">
                     <h5>Anna Trevor</h5>
                     <h6>Customer</h6>
                     <p>Dignissimos reprehenderit repellendus nobis error quibusdam? Atque animi sint unde quis reprehenderit, et, perspiciatis, debitis totam est deserunt eius officiis ipsum ducimus ad labore modi voluptatibus accusantium sapiente nam! Quaerat.</p>
                  </div>
               </div>
            </div>
         </div>

         <%-- 캐러셀 네비게이션 버튼 --%>
         <div class="carousel_btn_box">
            <a class="carousel-control-prev" href="#carouselExample3Controls" role="button" data-slide="prev">
               <i class="fa fa-long-arrow-left" aria-hidden="true"></i>
               <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#carouselExample3Controls" role="button" data-slide="next">
               <i class="fa fa-long-arrow-right" aria-hidden="true"></i>
               <span class="sr-only">Next</span>
            </a>
         </div>
      </div>
   </div>
</section>
<!-- end client section -->

<%-- 17. 푸터 섹션 시작 --%>
<footer>
   <div class="container">
      <div class="row">
         <%-- 회사 정보 --%>
         <div class="col-md-4">
            <div class="full">
               <div class="logo_footer">
                  <a href="${pageContext.request.contextPath}/"><img width="210" src="${pageContext.request.contextPath}/views/images/logo.png" alt="#" /></a>
               </div>
               <div class="information_f">
                  <p><strong>ADDRESS:</strong> 28 White tower, Street Name New York City, USA</p>
                  <p><strong>TELEPHONE:</strong> +91 987 654 3210</p>
                  <p><strong>EMAIL:</strong> yourmain@gmail.com</p>
               </div>
            </div>
         </div>

         <%-- 메뉴 링크들 --%>
         <div class="col-md-8">
            <div class="row">
               <div class="col-md-7">
                  <div class="row">
                     <%-- 메인 메뉴 --%>
                     <div class="col-md-6">
                        <div class="widget_menu">
                           <h3>Menu</h3>
                           <ul>
                              <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                              <li><a href="${pageContext.request.contextPath}/about">About</a></li>
                              <li><a href="#">Services</a></li>
                              <li><a href="${pageContext.request.contextPath}/testimonial">Testimonial</a></li>
                              <li><a href="${pageContext.request.contextPath}/blog_list">Blog</a></li>
                              <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
                           </ul>
                        </div>
                     </div>

                     <%-- 계정 관련 메뉴 --%>
                     <div class="col-md-6">
                        <div class="widget_menu">
                           <h3>Account</h3>
                           <ul>
                              <li><a href="#">Account</a></li>
                              <li><a href="#">Checkout</a></li>
                              <li><a href="#">Login</a></li>
                              <li><a href="${pageContext.request.contextPath}/register">Register</a></li>
                              <li><a href="#">Shopping</a></li>
                              <li><a href="#">Widget</a></li>
                           </ul>
                        </div>
                     </div>
                  </div>
               </div>

               <%-- 뉴스레터 구독 --%>
               <div class="col-md-5">
                  <div class="widget_menu">
                     <h3>Newsletter</h3>
                     <div class="information_f">
                        <p>Subscribe by our newsletter and get update protidin.</p>
                     </div>
                     <div class="form_sub">
                        <form>
                           <fieldset>
                              <div class="field">
                                 <input type="email" placeholder="Enter Your Mail" name="email" />
                                 <input type="submit" value="Subscribe" />
                              </div>
                           </fieldset>
                        </form>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
</footer>
<!-- footer end -->

<%-- 18. 저작권 정보 --%>
<div class="cpy_">
   <p class="mx-auto">© 2021 All Rights Reserved By <a href="https://html.design/">Free Html Templates</a><br>
      Distributed By <a href="https://themewagon.com/" target="_blank">ThemeWagon</a>
   </p>
</div>

<%-- 19. JavaScript 라이브러리 로드 --%>
<!-- jQuery 라이브러리 -->
<script src="${pageContext.request.contextPath}/views/js/jquery-3.4.1.min.js"></script>
<!-- Bootstrap Popper.js -->
<script src="${pageContext.request.contextPath}/views/js/popper.min.js"></script>
<!-- Bootstrap JavaScript -->
<script src="${pageContext.request.contextPath}/views/js/bootstrap.js"></script>
<!-- 커스텀 JavaScript -->
<script src="${pageContext.request.contextPath}/views/js/custom.js"></script>
</body>
</html>