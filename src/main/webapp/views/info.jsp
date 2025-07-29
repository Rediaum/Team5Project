<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
  
  <link rel="shortcut icon" href="${pageContext.request.contextPath}/views/images/favicon.png" type="">
  <title>로그인 - Shop Project Team 5</title>
  
  <!-- bootstrap core css -->
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/views/css/bootstrap.css" />
  <!-- font awesome style -->
  <link href="${pageContext.request.contextPath}/views/css/font-awesome.min.css" rel="stylesheet" />
  <!-- Custom styles for this template -->
  <link href="${pageContext.request.contextPath}/views/css/style.css" rel="stylesheet" />
  <!-- responsive style -->
  <link href="${pageContext.request.contextPath}/views/css/responsive.css" rel="stylesheet" />
  <!-- login 전용 CSS -->
  <link href="${pageContext.request.contextPath}/views/css/login.css" rel="stylesheet" />
  
  <style>
    .profile-container {
      max-width: 600px;
      margin: 50px auto;
      padding: 30px;
      background: #fff;
      border-radius: 10px;
      box-shadow: 0 0 20px rgba(0,0,0,0.1);
    }
    .btn-update {
      background: #f7444e;
      color: white;
      border: none;
      height: 45px;
      border-radius: 5px;
      font-weight: bold;
    }
    .btn-update:hover {
      background: #d63031;
      color: white;
    }
    .alert {
      border-radius: 5px;
      margin-bottom: 20px;
    }
  </style>
  
  <!-- jQuery -->
  <script src="${pageContext.request.contextPath}/views/js/jquery-3.4.1.min.js"></script>
  <!-- Bootstrap Popper.js -->
  <script src="${pageContext.request.contextPath}/views/js/popper.min.js"></script>
  <!-- Bootstrap JavaScript -->
  <script src="${pageContext.request.contextPath}/views/js/bootstrap.js"></script>
  
  <script>
    $(document).ready(function () {
      $('#profileForm').on('submit', function (e) {
        e.preventDefault();
        
        $.ajax({
          url: $(this).attr('action'),
          type: 'POST',
          data: $(this).serialize(),
          success: function (data, textStatus, xhr) {
            window.location.href = '/info';
          },
          error: function (xhr, status, error) {
            $('#notification').html(
                    '<div class="alert alert-danger">프로필을 업데이트하는 과정에서 오류가 발생했습니다.</div>'
            );
          }
        });
      });
    });
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
            <li class="nav-item">
              <a class="nav-link" href="${pageContext.request.contextPath}/register">Register</a>
            </li>
          </ul>
        </div>
      </nav>
    </div>
  </header>
  <!-- end header section -->
</div>

<!-- profile section -->
<section class="profile_section layout_padding">
  <div class="container">
    <div class="profile-container">
      <div class="heading_container heading_center">
        <h2>프로필 수정</h2>
      </div>
      
      <!-- 오류 메시지 표시 -->
      <c:if test="${not empty errorMsg}">
        <div class="alert alert-danger">${errorMsg}</div>
      </c:if>
      <c:if test="${not empty successMsg}">
        <div class="alert alert-success">${successMsg}</div>
      </c:if>
      
      <div id="notification"></div>
      <form id="profileform" action="${pageContext.request.contextPath}/info/update" method="post">
        <input type="hidden" name="custId" value="${cust.custId}" />
        
        <p>이름: <strong>${cust.custName}</strong></p>
        <p>이메일: <strong>${cust.custEmail}</strong></p>
        
        <p>전화번호:
          <input type="text" name="custPhone" value="${cust.custPhone}" required />
        </p>
        
        <p>새비밀번호:
          <input type="password" name="custPwd" placeholder="비밀번호를 변경하지 않을 경우 비워두세요." />
        </p>
        
        <p>현비밀번호:*
          <input type="password" name="currentPwd" required placeholder="기존 비밀번호를 입력하세요." />
        </p>
        
        <button type="submit" class="btn btn-update btn-lg btn-block">Update Profile</button>
      </form>
    
    
    </div>
  </div>
</section>
<!-- end profile section -->

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

<!-- Custom JavaScript -->
<script src="${pageContext.request.contextPath}/views/js/custom.js"></script>
</body>
</html>