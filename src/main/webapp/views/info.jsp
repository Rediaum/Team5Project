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
  <title>프로필 관리 - Shop Project Team 5</title>

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
    .check-result {
      margin-top: 5px;
      font-size: 14px;
    }

    /* 기본 배송지 섹션 스타일 */
    .address-section {
      background: #f8f9fa;
      padding: 20px;
      border-radius: 8px;
      margin: 20px 0;
      border: 1px solid #e9ecef;
      position: relative;
    }
    .address-section h4 {
      color: #495057;
      margin-bottom: 15px;
      font-size: 18px;
      font-weight: bold;
    }
    .address-info {
      line-height: 1.6;
      color: #6c757d;
    }
    .address-name {
      font-weight: bold;
      color: #343a40;
      font-size: 16px;
      margin-bottom: 8px;
    }
    .address-detail {
      margin-bottom: 5px;
    }
    .no-address {
      color: #6c757d;
      font-style: italic;
      text-align: center;
      padding: 20px;
    }
    .btn-address-manage {
      position: absolute;
      bottom: 15px;
      right: 15px;
      background: #007bff;
      color: white;
      border: none;
      padding: 8px 15px;
      border-radius: 5px;
      font-size: 14px;
      font-weight: bold;
      text-decoration: none;
      transition: all 0.3s ease;
    }
    .btn-address-manage:hover {
      background: #0056b3;
      color: white;
      text-decoration: none;
      transform: translateY(-1px);
    }
    .btn-address-manage i {
      margin-right: 5px;
    }

    /* 폼 입력 필드 스타일 개선 */
    .form-field {
      margin-bottom: 20px;
    }
    .form-field label {
      font-weight: bold;
      display: block;
      margin-bottom: 5px;
      color: #495057;
    }
    .form-field input[type="text"],
    .form-field input[type="password"] {
      width: 100%;
      padding: 10px;
      border: 1px solid #ced4da;
      border-radius: 5px;
      font-size: 14px;
      transition: border-color 0.3s ease;
    }
    .form-field input[type="text"]:focus,
    .form-field input[type="password"]:focus {
      outline: none;
      border-color: #007bff;
      box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
    }
    .readonly-field {
      background: #f8f9fa;
      color: #6c757d;
      font-weight: bold;
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
      // 비밀번호 확인 검증
      $('#pwdconfirm').on('input', function() {
        const pwd = $('input[name="custPwd"]').val();
        const pwdConfirm = $(this).val();
        const resultDiv = $('#pwdCheckResult');

        if (!pwd && !pwdConfirm) {
          resultDiv.text("");
          return;
        }

        if (pwd !== pwdConfirm) {
          resultDiv.html('<span style="color: red;">비밀번호가 일치하지 않습니다.</span>');
          return;
        }

        resultDiv.html('<span style="color: green;">비밀번호가 일치합니다.</span>');
      });

      // AJAX 폼 제출 (기존 코드 유지)
      $('#profileform').on('submit', function (e) {
        e.preventDefault();

        // 비밀번호 확인 검증
        const newPwd = $('input[name="custPwd"]').val();
        const confirmPwd = $('#pwdconfirm').val();

        if (newPwd && newPwd !== confirmPwd) {
          $('#pwdCheckResult').html('<span style="color: red;">비밀번호가 일치하지 않습니다.</span>');
          return;
        }

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

      <!-- 기본 배송지 정보 섹션 (추가된 부분) -->
      <div class="address-section">
        <h4><i class="fa fa-map-marker" aria-hidden="true"></i> 기본 배송지</h4>
        <c:choose>
          <c:when test="${not empty defaultAddress}">
            <div class="address-info">
              <div class="address-name">${defaultAddress.addressName}</div>
              <div class="address-detail">${defaultAddress.address}</div>
              <c:if test="${not empty defaultAddress.detailAddress}">
                <div class="address-detail">${defaultAddress.detailAddress}</div>
              </c:if>
              <div class="address-detail" style="color: #6c757d; font-size: 14px;">
                우편번호: ${defaultAddress.postalCode}
              </div>
            </div>
          </c:when>
          <c:otherwise>
            <div class="no-address">
              <i class="fa fa-exclamation-circle" aria-hidden="true"></i>
              등록된 기본 배송지가 없습니다.
            </div>
          </c:otherwise>
        </c:choose>

        <!-- 배송지 관리 버튼 -->
        <a href="${pageContext.request.contextPath}/address" class="btn-address-manage">
          <i class="fa fa-edit" aria-hidden="true"></i> 수정
        </a>
      </div>

      <div id="notification"></div>
      <form id="profileform" action="${pageContext.request.contextPath}/info/update" method="post">
        <input type="hidden" name="custId" value="${cust.custId}" />

        <p>이름: <strong>${cust.custName}</strong></p>
        <p>이메일: <strong>${cust.custEmail}</strong></p>

        <p>전화번호:
          <input type="text" name="custPhone" value="${cust.custPhone}" required placeholder="010-1234-5678" />
        </p>

        <p>현비밀번호:*
          <input type="password" name="currentPwd" required placeholder="기존 비밀번호를 입력하세요." />
        </p>

        <p>새비밀번호:
          <input type="password" name="custPwd" placeholder="비밀번호를 변경하지 않을 경우 비워두세요." />
        </p>

        <p>새비밀번호 확인:
          <input type="password" id="pwdconfirm" name="pwdConfirm" placeholder="비밀번호를 변경하지 않을 경우 비워두세요." />
        </p>
        <div id="pwdCheckResult" class="check-result"></div>

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