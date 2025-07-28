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

  <script>
    $(document).ready(function() {
      // 로그인 폼 제출 처리
      $('#loginForm').submit(function(e) {
        e.preventDefault();

        let email = $('#email').val().trim();
        let pwd = $('#pwd').val().trim();

        // 클라이언트 유효성 검사
        if (!email) {
          alert('이메일을 입력하세요.');
          $('#email').focus();
          return false;
        }

        if (!pwd) {
          alert('비밀번호를 입력하세요.');
          $('#pwd').focus();
          return false;
        }

        // AJAX 로그인 요청
        $.ajax({
          url: '${pageContext.request.contextPath}/loginimpl',
          type: 'POST',
          data: {
            email: email,
            pwd: pwd
          },
          beforeSend: function() {
            $('#loginBtn').prop('disabled', true).html('<i class="fa fa-spinner fa-spin"></i> 로그인 중...');
          },
          success: function(response) {
            // 성공 시 메인 페이지로 리다이렉트
            alert('로그인 성공!');
            window.location.href = '${pageContext.request.contextPath}/';
          },
          error: function(xhr, status, error) {
            // 실패 시 에러 메시지 표시
            alert('로그인에 실패했습니다. 이메일과 비밀번호를 확인하세요.');
            $('#loginBtn').prop('disabled', false).html('<i class="fa fa-sign-in"></i> 로그인');
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

<!-- login section -->
<section class="login_section layout_padding">
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-md-6 col-lg-5">
        <div class="login-container">
          <div class="heading_container heading_center">
            <h2>
              <span>로그인</span>
            </h2>
          </div>

          <!-- 로그인 폼 -->
          <form id="loginForm">
            <div class="form-group">
              <label for="email">
                <i class="fa fa-envelope"></i> 이메일
              </label>
              <input type="email" class="form-control" id="email" name="email"
                     placeholder="이메일을 입력하세요" required>
            </div>

            <div class="form-group">
              <label for="pwd">
                <i class="fa fa-lock"></i> 비밀번호
              </label>
              <input type="password" class="form-control" id="pwd" name="pwd"
                     placeholder="비밀번호를 입력하세요" required>
            </div>

            <div class="form-check mb-3">
              <input type="checkbox" class="form-check-input" id="rememberMe">
              <label class="form-check-label" for="rememberMe">
                로그인 상태 유지
              </label>
            </div>

            <div class="btn-box">
              <button type="submit" id="loginBtn" class="btn btn-login">
                <i class="fa fa-sign-in"></i> 로그인
              </button>
            </div>
          </form>

          <!-- 추가 링크들 -->
          <div class="login-links">
            <div class="text-center mt-4">
              <p class="mb-2">
                <a href="${pageContext.request.contextPath}/register" class="text-primary">
                  <i class="fa fa-user-plus" aria-hidden="true"></i>
                  아직 계정이 없으신가요? 회원가입
                </a>
              </p>
              <p class="mb-0">
                <a href="#" class="text-muted">
                  <i class="fa fa-question-circle" aria-hidden="true"></i>
                  비밀번호를 잊으셨나요?
                </a>
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
<!-- end login section -->

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

<!-- jQuery -->
<script src="${pageContext.request.contextPath}/views/js/jquery-3.4.1.min.js"></script>
<!-- Bootstrap Popper.js -->
<script src="${pageContext.request.contextPath}/views/js/popper.min.js"></script>
<!-- Bootstrap JavaScript -->
<script src="${pageContext.request.contextPath}/views/js/bootstrap.js"></script>
<!-- Custom JavaScript -->
<script src="${pageContext.request.contextPath}/views/js/custom.js"></script>
</body>
</html>