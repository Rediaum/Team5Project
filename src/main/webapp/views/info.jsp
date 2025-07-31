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

        .profile-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 30px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-control {
            height: 45px;
            border-radius: 5px;
            border: 1px solid #ddd;
            padding: 0 15px;
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
        .btn-check {
            background: #74b9ff;
            color: white;
            border: none;
            height: 45px;
        }
        .btn-check:hover {
            background: #0984e3;
            color: white;
        }
        .check-result {
            font-size: 12px;
            margin-top: 5px;
        }
        .check-success {
            color: #00b894;
        }
        .check-error {
            color: #e17055;
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
    </style>
    
    <!-- jQuery -->
    <script src="${pageContext.request.contextPath}/views/js/jquery-3.4.1.min.js"></script>
    <!-- Bootstrap Popper.js -->
    <script src="${pageContext.request.contextPath}/views/js/popper.min.js"></script>
    <!-- Bootstrap JavaScript -->
    <script src="${pageContext.request.contextPath}/views/js/bootstrap.js"></script>
    
    <script>
        let passwordLengthValid = false;

        document.addEventListener('DOMContentLoaded', function () {
            const custPwdInput = document.getElementById('custPwd');
            const pwdConfirmInput = document.getElementById('pwdConfirm');
            const pwdLengthResultDiv = document.getElementById('pwdLengthResult');
            const pwdCheckResultDiv = document.getElementById('pwdCheckResult');
            const custPhoneInput = document.getElementById('custPhone');

            // 비밀번호 길이 검사 (Real-time)
            custPwdInput.addEventListener('input', function () {
                const pwd = this.value;
                if (pwd.length === 0) {
                    pwdLengthResultDiv.innerHTML = '';
                    passwordLengthValid = true; // 비밀번호를 입력하지 않음 = 비밀번호를 업데이트하지 않음 = 인증이 필요 없음
                } else if (pwd.length < 7) {
                    pwdLengthResultDiv.innerHTML = '<span class="check-error">비밀번호는 7자 이상이어야 합니다.</span>';
                    passwordLengthValid = false;
                } else {
                    pwdLengthResultDiv.innerHTML = '<span class="check-success">비밀번호 길이가 적절합니다.</span>';
                    passwordLengthValid = true;
                }
                checkPasswordConfirmation();
            });

            // 비밀번호 확인 검사 (Real-time)
            pwdConfirmInput.addEventListener('input', checkPasswordConfirmation);

            function checkPasswordConfirmation() {
                const pwd = custPwdInput.value;
                const pwdConfirm = pwdConfirmInput.value;

                if (pwd.length === 0 && pwdConfirm.length === 0) {
                    pwdCheckResultDiv.innerHTML = '';
                } else if (pwd.length < 7) {
                    pwdCheckResultDiv.innerHTML = '<span class="check-error">비밀번호는 7자 이상이어야 합니다.</span>';
                } else if (pwd !== pwdConfirm) {
                    pwdCheckResultDiv.innerHTML = '<span class="check-error">비밀번호가 일치하지 않습니다.</span>';
                } else {
                    pwdCheckResultDiv.innerHTML = '<span class="check-success">비밀번호가 일치합니다.</span>';
                }
            }

            // 폼 제출 시 유효성 검사
            document.getElementById('profileForm').addEventListener('submit', function (e) {
                const pwd = custPwdInput.value;
                const pwdConfirm = pwdConfirmInput.value;
                const phone = custPhoneInput.value.trim();

                // 전화번호는 필수
                if (!phone) {
                    alert('전화번호를 입력하세요.');
                    e.preventDefault();
                    return;
                }

                // 비밀번호 입력된 경우만 검사
                if (pwd || pwdConfirm) {
                    if (pwd.length < 7) {
                        alert('비밀번호는 7자 이상이어야 합니다.');
                        e.preventDefault();
                        return;
                    }

                    if (pwd !== pwdConfirm) {
                        alert('비밀번호가 일치하지 않습니다.');
                        e.preventDefault();
                        return;
                    }
                }
            });
        });
    
    </script>

</head>

<body class="sub_page">
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
                            
                        <!-- Admin한테 메뉴 숨기기-->
                        <c:if test="${sessionScope.role ne 'admin'}">
                            <%-- Products 메뉴 --%>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/product">Products</a>
                            </li>
                            
                            <%-- Contact 메뉴 --%>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/contact">Contact</a>
                            </li>
                        </c:if>
                        
                        <!-- Admin을 위한 메뉴 -->
                        <c:if test="${sessionScope.role eq 'admin'}">
                            <!-- Inventory, 제품 관리 메뉴 -->
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/admin/inventory">Inventory</a>
                            </li>
                            
                            <!-- Customer 관리 메뉴 -->
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/admin/customerList">Customer</a>
                            </li>
                        </c:if>
                        
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
                            
                        <%-- 장바구니 아이콘 메뉴 (Admin 숨기고 Cust 로그인시에만 표시) --%>
                        <c:if test="${sessionScope.logincust != null and sessionScope.role eq 'cust'}">
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
                        <c:if test="${sessionScope.role eq 'cust'}">
                            <li class="nav-item">
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
                            </li>
                        </c:if>
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
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>
            
            <!-- cust 위한 기본 배송지 정보 섹션 (추가된 부분) -->
            <c:if test="${sessionScope.role eq 'cust'}">
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
            </c:if>
            
            <div id="notification"></div>
            <form id="profileForm" action="${pageContext.request.contextPath}/info/update" method="post">
                <input type="hidden" name="custId" value="${cust.custId}" />
                
                <!-- Name (Static Display) -->
                <div class="form-group info-display">
                    <label>이름:</label>
                    <strong>${cust.custName}</strong>
                </div>
                
                <!-- Email (Static Display) -->
                <div class="form-group info-display">
                    <label>이메일:</label>
                    <strong>${cust.custEmail}</strong>
                </div>
                
                <!-- 전화번호 (Editable) -->
                <div class="form-group">
                    <label for="custPhone">전화번호:</label>
                    <input type="tel" class="form-control" id="custPhone" name="custPhone" value="${cust.custPhone}" placeholder="010-1234-5678">
                </div>
                
                <!-- 현비밀번호  -->
                <div class="form-group">
                    <label for="currentPwd">현비밀번호: *</label>
                    <input type="password" class="form-control" id="currentPwd" name="currentPwd"
                           required placeholder="기존 비밀번호를 입력하세요.">
                </div>
                
                <!-- 새비밀번호 -->
                <div class="form-group">
                    <label for="custPwd">새비밀번호:</label>
                    <input type="password" class="form-control" id="custPwd" name="custPwd"
                           placeholder="비밀번호를 변경하지 않을 경우 비워두세요.">
                    <div id="pwdLengthResult" class="check-result"></div>
                </div>
                
                <!-- 새비밀번호 확인 -->
                <div class="form-group">
                    <label for="pwdConfirm">새비밀번호 확인:</label>
                    <input type="password" class="form-control" id="pwdConfirm" name="pwdConfirm"
                           placeholder="비밀번호를 변경하지 않을 경우 비워두세요.">
                    <div id="pwdCheckResult" class="check-result"></div>
                </div>
                
                <!-- Submit Button -->
                <div class="form-group text-center">
                    <button type="submit" class="btn btn-update btn-lg btn-block">프로필 업데이트</button>
                </div>
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