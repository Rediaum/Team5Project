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
</head>
<body class="sub_page">
<div class="hero_area">
   <!-- header section strats -->
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
                  <li class="nav-item dropdown active">
                     <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true"> <span class="nav-label">Pages <span class="caret"></span></a>
                     <ul class="dropdown-menu">
                        <li><a href="${pageContext.request.contextPath}/about">About</a></li>
                        <li><a href="${pageContext.request.contextPath}/testimonial">Testimonial</a></li>
                     </ul>
                  </li>
                  <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/product">Products</a>
                  </li>
                  <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/blog_list">Blog</a>
                  </li>
                  <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/contact">Contact</a>
                  </li>
                  <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                        <svg version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 456.029 456.029" style="enable-background:new 0 0 456.029 456.029;" xml:space="preserve">
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
   <!-- end header section -->
</div>
<!-- inner page section -->
<section class="inner_page_head">
   <div class="container_fuild">
      <div class="row">
         <div class="col-md-12">
            <div class="full">
               <h3>Testimonial</h3>
            </div>
         </div>
      </div>
   </div>
</section>
<!-- end inner page section -->
<!-- client section -->
<section class="client_section layout_padding">
   <div class="container">
      <div class="heading_container heading_center">
         <h2>
            Customer's Testimonial
         </h2>
      </div>
      <div id="carouselExample3Controls" class="carousel slide" data-ride="carousel">
         <div class="carousel-inner">
            <%-- 4. 동적 데이터 처리 예시 --%>
            <%-- 이 부분은 나중에 DB에서 고객 후기 목록(testimonialList)을 가져와 JSTL로 반복 처리해야 합니다. --%>
            <c:forEach var="testimonial" items="${testimonialList}" varStatus="status">
               <div class="carousel-item ${status.first ? 'active' : ''}">
                  <div class="box col-lg-10 mx-auto">
                     <div class="img_container">
                        <div class="img-box">
                           <div class="img_box-inner">
                              <img src="${pageContext.request.contextPath}/views/images/${testimonial.clientImage}" alt="">
                           </div>
                        </div>
                     </div>
                     <div class="detail-box">
                        <h5>
                              ${testimonial.clientName}
                        </h5>
                        <h6>
                           Customer
                        </h6>
                        <p>
                              ${testimonial.content}
                        </p>
                     </div>
                  </div>
               </div>
            </c:forEach>

            <%-- 아래는 JSTL을 사용하지 않을 경우를 대비한 정적 HTML 예시입니다. --%>
            <%-- 실제 개발 시에는 위의 <c:forEach> 블록을 사용하고 아래는 삭제합니다. --%>
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
                     <h5>
                        Anna Trevor
                     </h5>
                     <h6>
                        Customer
                     </h6>
                     <p>
                        Dignissimos reprehenderit repellendus nobis error quibusdam? Atque animi sint unde quis reprehenderit, et, perspiciatis, debitis totam est deserunt eius officiis ipsum ducimus ad labore modi voluptatibus accusantium sapiente nam! Quaerat.
                     </p>
                  </div>
               </div>
            </div>
            <%-- ... 나머지 정적 후기 항목 ... --%>
         </div>
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
