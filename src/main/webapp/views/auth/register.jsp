<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/views/images/favicon.png" type="">
    <title>회원 가입 - Shop Project Team 5</title>
    
    <!-- bootstrap core css -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/views/css/bootstrap.css" />
    <!-- font awesome style -->
    <link href="${pageContext.request.contextPath}/views/css/font-awesome.min.css" rel="stylesheet" />
    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/views/css/style.css" rel="stylesheet" />
    <!-- responsive style -->
    <link href="${pageContext.request.contextPath}/views/css/responsive.css" rel="stylesheet" />
    
    <style>
        .register-container {
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
        .btn-register {
            background: #f7444e;
            color: white;
            border: none;
            height: 45px;
            border-radius: 5px;
            font-weight: bold;
        }
        .btn-register:hover {
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
        .input-group-append .btn {
            border-top-left-radius: 0;
            border-bottom-left-radius: 0;
        }
    </style>
    
    <script>
        let emailChecked = false;
        let passwordLengthValid = false;
        // 이메일 중복 검사
        function checkEmailDuplicate() {
            const custEmail = document.getElementById('custEmail').value;
            const resultDiv = document.getElementById('emailCheckResult');

            if (!custEmail.trim()) {
                resultDiv.innerHTML = '<span class="check-error">이메일을 입력하세요.</span>';
                return;
            }

            // 이메일 형식 검사
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(custEmail)) {
                resultDiv.innerHTML = '<span class="check-error">올바른 이메일 형식이 아닙니다.</span>';
                return;
            }

            // AJAX 요청
            fetch('${pageContext.request.contextPath}/register/check-email', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'email=' + encodeURIComponent(custEmail)
            })
                .then(response => response.json())
                .then(available => {
                    if (available) {
                        resultDiv.innerHTML = '<span class="check-success">사용 가능한 이메일입니다.</span>';
                        emailChecked = true;
                    } else {
                        resultDiv.innerHTML = '<span class="check-error">이미 사용중인 이메일입니다.</span>';
                        emailChecked = false;
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    resultDiv.innerHTML = '<span class="check-error">오류가 발생했습니다. 다시 시도해주세요.</span>';
                    emailChecked = false;
                });
        }

        // 페이지 로드 후 이벤트 리스너 등록
        document.addEventListener('DOMContentLoaded', function() {
            const custPwdInput = document.getElementById('custPwd');
            const pwdConfirmInput = document.getElementById('pwdConfirm');
            const pwdLengthResultDiv = document.getElementById('pwdLengthResult');
            const pwdCheckResultDiv = document.getElementById('pwdCheckResult');

            // 비밀번호 길이 검사 (Real-time)
            custPwdInput.addEventListener('input', function() {
                const pwd = this.value;
                if (pwd.length < 7) {
                    pwdLengthResultDiv.innerHTML = '<span class="check-error">비밀번호는 7자 이상이어야 합니다.</span>'; // Password must be at least 7 characters.
                    passwordLengthValid = false;
                } else {
                    pwdLengthResultDiv.innerHTML = '<span class="check-success">비밀번호 길이가 적절합니다.</span>'; // Password length is appropriate.
                    passwordLengthValid = true;
                }
                checkPasswordConfirmation();
            });

            // 비밀번호 확인 검사 (Real-time)
            pwdConfirmInput.addEventListener('input', checkPasswordConfirmation);

            function checkPasswordConfirmation() {
                const pwd = custPwdInput.value;
                const pwdConfirm = pwdConfirmInput.value;

                if (pwdConfirm.length === 0) {
                    pwdCheckResultDiv.innerHTML = '';
                } else if (pwd.length > 0 && pwd.length < 7) {
                    pwdCheckResultDiv.innerHTML = '<span class="check-error">비밀번호는 7자 이상이어야 합니다.</span>';
                } else if (pwdConfirm.length > 0 && pwd !== pwdConfirm) {
                    pwdCheckResultDiv.innerHTML = '<span class="check-error">비밀번호가 일치하지 않습니다.</span>'; // Passwords do not match.
                } else if (pwdConfirm.length > 0 && pwd === pwdConfirm) {
                    pwdCheckResultDiv.innerHTML = '<span class="check-success">비밀번호가 일치합니다.</span>'; // Passwords match.
                }
            }

            // 이메일 입력값이 변경되면 중복 검사 상태 초기화
            document.getElementById('custEmail').addEventListener('input', function() {
                emailChecked = false;
                document.getElementById('emailCheckResult').innerHTML = '';
            });

            // 폼 제출 시 유효성 검사
            document.getElementById('registerForm').addEventListener('submit', function(e) {
                const pwd = document.getElementById('custPwd').value;
                const pwdConfirm = document.getElementById('pwdConfirm').value;
                const custName = document.getElementById('custName').value;
                const custEmail = document.getElementById('custEmail').value;
                const custPhone = document.getElementById('custPhone').value;

                // 필수 필드 검사
                if (!custEmail.trim()) {
                    alert('이메일을 입력하세요.');
                    e.preventDefault();
                    return;
                }

                if (!custName.trim()) {
                    alert('이름을 입력하세요.');
                    e.preventDefault();
                    return;
                }

                if (!pwd.trim()) {
                    alert('비밀번호를 입력하세요.');
                    e.preventDefault();
                    return;
                }

                if (!custPhone.trim()) {
                    alert('전화번호를 입력하세요.');
                    e.preventDefault();
                    return;
                }

                if (!passwordLengthValid) {
                    alert('비밀번호는 7자 이상이어야 합니다.');
                    e.preventDefault();
                    return;
                }

                if (!emailChecked) {
                    alert('이메일 중복 확인을 해주세요.');
                    e.preventDefault();
                    return;
                }

                if (pwd !== pwdConfirm) {
                    alert('비밀번호가 일치하지 않습니다.');
                    e.preventDefault();
                    return;
                }
            });
        });

        // 오료 메시지 받아 alert 표시
        const params = new URLSearchParams(window.location.search);
        const error = params.get("error");
        if (error) {
            alert(error);
        }

    </script>
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
                                    <%-- 로그인한 경우 드롭다운 메뉴 --%>
                                    <c:otherwise>
                                        <%-- 사용자 프로필 메뉴 (사용자 이름 표시) --%>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/info">
                                            <i class="fa fa-user" aria-hidden="true"></i> ${sessionScope.logincust.custName}
                                        </a>

                                        <%-- 주문 내역 메뉴 추가 --%>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/order/history">
                                            <i class="fa fa-list-alt" aria-hidden="true"></i> 주문 내역
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
                            <c:if test="${sessionScope.role ne 'admin'}">
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

<!-- register section -->
<section class="register_section layout_padding">
    <div class="container">
        <div class="register-container">
            <div class="heading_container heading_center">
                <h2>회원가입</h2>
            </div>
            
            <form action="${pageContext.request.contextPath}/register" method="post" id="registerForm">
                <!-- 이메일 -->
                <div class="form-group">
                    <label for="custEmail">이메일 *</label>
                    <div class="input-group">
                        <input type="email" class="form-control" id="custEmail" name="custEmail"
                               value="${cust.custEmail}" required placeholder="example@email.com">
                        <div class="input-group-append">
                            <button type="button" class="btn btn-check" onclick="checkEmailDuplicate()">중복확인</button>
                        </div>
                    </div>
                    <div id="emailCheckResult" class="check-result"></div>
                </div>
                
                <!-- 비밀번호 -->
                <div class="form-group">
                    <label for="custPwd">비밀번호 *</label>
                    <input type="password" class="form-control" id="custPwd" name="custPwd"
                           required placeholder="비밀번호를 입력하세요">
                    <div id="pwdLengthResult" class="check-result"></div>
                </div>
                
                <!-- 비밀번호 확인 -->
                <div class="form-group">
                    <label for="pwdConfirm">비밀번호 확인 *</label>
                    <input type="password" class="form-control" id="pwdConfirm" name="pwdConfirm"
                           required placeholder="비밀번호를 다시 입력하세요">
                    <div id="pwdCheckResult" class="check-result"></div>
                </div>
                
                <!-- 이름 -->
                <div class="form-group">
                    <label for="custName">이름 *</label>
                    <input type="text" class="form-control" id="custName" name="custName"
                           value="${cust.custName}" required placeholder="이름을 입력하세요">
                </div>
                
                <!-- 전화번호 -->
                <div class="form-group">
                    <label for="custPhone">전화번호</label>
                    <input type="tel" class="form-control" id="custPhone" name="custPhone" value="${cust.custPhone}" placeholder="010-1234-5678">
                </div>
                
                <!-- 제출 버튼 -->
                <div class="form-group text-center">
                    <button type="submit" class="btn btn-register btn-lg btn-block">회원가입</button>
                </div>
            </form>
        </div>
    </div>
</section>
<!-- end register section -->

<%-- 푸터 섹션 시작 --%>
<footer>
    <div class="container">
        <div class="row justify-content-center">
            <%-- 회사 로고 --%>
            <div class="col-md-3 pr-md-4">
                <div class="logo_footer">
                    <a href="${pageContext.request.contextPath}/">
                        <img width="210" src="${pageContext.request.contextPath}/views/images/logo.png" alt="로고" />
                    </a>
                </div>
            </div>
            <!-- 정보 (주소 + GitHub) -->
            <div class="col-md-4 pr-md-4">
                <div class="information_f">
                    <p style="margin-bottom: 0.5rem;">
                        <strong>ADDRESS:</strong><br/>
                        충청남도 아산시 탕정면 선문로 221번길 70 선문대학교
                    </p>
                    <p style="margin-bottom: 0;">
                        <strong>GITHUB:</strong>
                        <a href="https://github.com/Rediaum/Team5Project"
                           class="black-link"
                           target="_blank" rel="noopener noreferrer">
                            Team5Project
                        </a>
                    </p>
                </div>
            </div>
            <!-- 네비게이션 메뉴 -->
            <div class="col-md-2">
                <div class="footer-menu">
                    <h5>Menu</h5>
                    <ul class="list-unstyled d-flex flex-column gap-2">
                        <li><a href="${pageContext.request.contextPath}/" class="text-dark">Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/about" class="text-dark">About</a></li>
                        <li><a href="${pageContext.request.contextPath}/testimonial" class="text-dark">Testimonial</a></li>
                        <c:if test="${role ne 'admin'}">
                            <li><a href="${pageContext.request.contextPath}/product" class="text-dark">Products</a></li>
                            <li><a href="${pageContext.request.contextPath}/contact" class="text-dark">Contact</a></li>
                        </c:if>
                        <c:if test="${role eq 'admin'}">
                            <li><a href="${pageContext.request.contextPath}/admin/inventory" class="text-dark">Inventory</a></li>
                            <li><a href="${pageContext.request.contextPath}/admin/customerList" class="text-dark">Customer</a></li>
                        </c:if>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</footer>
<!-- footer end -->

<%-- 저작권 정보 --%>
<div class="cpy_">
    <p class="mx-auto">© 2021 All Rights Reserved By <a href="https://html.design/">Free Html Templates</a><br>
        Distributed By <a href="https://themewagon.com/" target="_blank">ThemeWagon</a>
    </p>
</div>
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