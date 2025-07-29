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
    <title>배송지 관리 - Shop Project Team 5</title>

    <!-- bootstrap core css -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/views/css/bootstrap.css" />
    <!-- font awesome style -->
    <link href="${pageContext.request.contextPath}/views/css/font-awesome.min.css" rel="stylesheet" />
    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/views/css/style.css" rel="stylesheet" />
    <!-- responsive style -->
    <link href="${pageContext.request.contextPath}/views/css/responsive.css" rel="stylesheet" />

    <style>
        .address-container {
            max-width: 800px;
            margin: 50px auto;
            padding: 30px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .address-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 15px;
            position: relative;
            transition: box-shadow 0.3s ease;
        }
        .address-card:hover {
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .address-card.default {
            border-color: #f7444e;
            background: #fff8f8;
        }
        .default-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            background: #f7444e;
            color: white;
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 12px;
            font-weight: bold;
        }
        .btn-add {
            background: #28a745;
            color: white;
            border: none;
            height: 45px;
            border-radius: 5px;
            font-weight: bold;
            margin-bottom: 20px;
        }
        .btn-add:hover {
            background: #218838;
            color: white;
        }
        .btn-primary {
            background: #007bff;
            border-color: #007bff;
        }
        .btn-danger {
            background: #dc3545;
            border-color: #dc3545;
        }
        .btn-secondary {
            background: #6c757d;
            border-color: #6c757d;
        }
        .address-form {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: none;
        }
        .address-form.show {
            display: block;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            font-weight: bold;
            margin-bottom: 5px;
            display: block;
        }
        .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        .address-actions {
            margin-top: 10px;
        }
        .address-actions button {
            margin-right: 10px;
            margin-bottom: 10px;
        }
        .address-info {
            line-height: 1.6;
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
        $(document).ready(function() {
            // 새 배송지 추가 폼 토글
            $('#addAddressBtn').click(function() {
                $('#addAddressForm').toggleClass('show');
                const btnText = $(this).text().includes('추가') ? '취소' : '새 배송지 추가';
                $(this).text(btnText);
            });

            // 수정 폼 토글
            $('.edit-btn').click(function() {
                const addressId = $(this).data('address-id');
                $('#editForm' + addressId).toggleClass('show');
            });

            // 취소 버튼
            $('.cancel-btn').click(function() {
                $(this).closest('.address-form').removeClass('show');
                $('#addAddressBtn').text('새 배송지 추가');
            });

            // 기본 배송지 설정
            $('.set-default-btn').click(function() {
                const addressId = $(this).data('address-id');
                if (confirm('이 주소를 기본 배송지로 설정하시겠습니까?')) {
                    $.post('${pageContext.request.contextPath}/address/setDefault', {
                        addressId: addressId
                    }, function(result) {
                        if (result.success) {
                            location.reload();
                        } else {
                            alert('기본 배송지 설정에 실패했습니다.');
                        }
                    });
                }
            });

            // 삭제 확인
            $('.delete-btn').click(function() {
                if (confirm('정말로 이 배송지를 삭제하시겠습니까?')) {
                    return true;
                }
                return false;
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

<!-- address section -->
<section class="address_section layout_padding">
    <div class="container">
        <div class="address-container">
            <div class="heading_container heading_center">
                <h2>배송지 관리</h2>
                <p>최대 10개까지 배송지를 등록할 수 있습니다.</p>
            </div>

            <!-- 뒤로 가기 버튼 -->
            <div class="mb-3">
                <a href="${pageContext.request.contextPath}/info" class="btn btn-secondary">
                    <i class="fa fa-arrow-left" aria-hidden="true"></i> 프로필로 돌아가기
                </a>
            </div>

            <!-- 오류/성공 메시지 표시 -->
            <c:if test="${not empty errorMsg}">
                <div class="alert alert-danger">${errorMsg}</div>
            </c:if>
            <c:if test="${not empty successMsg}">
                <div class="alert alert-success">${successMsg}</div>
            </c:if>

            <!-- 새 배송지 추가 버튼 -->
            <c:if test="${addressList.size() < 10}">
                <button id="addAddressBtn" class="btn btn-add btn-lg">
                    <i class="fa fa-plus" aria-hidden="true"></i> 새 배송지 추가
                </button>
            </c:if>
            <c:if test="${addressList.size() >= 10}">
                <div class="alert alert-warning">
                    최대 10개의 배송지까지만 등록할 수 있습니다.
                </div>
            </c:if>

            <!-- 새 배송지 추가 폼 -->
            <div id="addAddressForm" class="address-form">
                <h4>새 배송지 추가</h4>
                <form action="${pageContext.request.contextPath}/address/add" method="post">
                    <div class="form-group">
                        <label for="addressName">배송지 이름*</label>
                        <input type="text" id="addressName" name="addressName" class="form-control"
                               placeholder="예: 집, 회사, 부모님 댁" required maxlength="20">
                    </div>
                    <div class="form-group">
                        <label for="postalCode">우편번호*</label>
                        <input type="text" id="postalCode" name="postalCode" class="form-control"
                               placeholder="우편번호를 입력하세요" required>
                    </div>
                    <div class="form-group">
                        <label for="address">주소*</label>
                        <input type="text" id="address" name="address" class="form-control"
                               placeholder="도로명 주소를 입력하세요" required>
                    </div>
                    <div class="form-group">
                        <label for="detailAddress">상세주소</label>
                        <input type="text" id="detailAddress" name="detailAddress" class="form-control"
                               placeholder="상세주소를 입력하세요">
                    </div>
                    <div class="form-group">
                        기본 배송지로 설정 : <input type="checkbox" name="isDefault" value="true" style="margin-left: 5px;">
                    </div>
                    <div class="address-actions">
                        <button type="submit" class="btn btn-primary">저장</button>
                        <button type="button" class="btn btn-secondary cancel-btn">취소</button>
                    </div>
                </form>
            </div>

            <!-- 등록된 배송지 목록 -->
            <div class="address-list">
                <c:choose>
                    <c:when test="${empty addressList}">
                        <div class="alert alert-info">
                            등록된 배송지가 없습니다. 새 배송지를 추가해주세요.
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="addr" items="${addressList}" varStatus="status">
                            <div class="address-card ${addr.isDefault() ? 'default' : ''}">
                                <c:if test="${addr.isDefault()}">
                                    <div class="default-badge">기본 배송지</div>
                                </c:if>

                                <div class="address-info">
                                    <h5><strong>${addr.addressName}</strong></h5>
                                    <p>
                                            ${addr.address}<br>
                                        <c:if test="${not empty addr.detailAddress}">
                                            ${addr.detailAddress}<br>
                                        </c:if>
                                        (우편번호: ${addr.postalCode})
                                    </p>
                                </div>

                                <div class="address-actions">
                                    <button type="button" class="btn btn-sm btn-primary edit-btn"
                                            data-address-id="${addr.addressId}">
                                        <i class="fa fa-edit" aria-hidden="true"></i> 수정
                                    </button>

                                    <c:if test="${!addr.isDefault()}">
                                        <button type="button" class="btn btn-sm btn-secondary set-default-btn"
                                                data-address-id="${addr.addressId}">
                                            <i class="fa fa-star" aria-hidden="true"></i> 기본으로 설정
                                        </button>
                                    </c:if>

                                    <a href="${pageContext.request.contextPath}/address/delete/${addr.addressId}"
                                       class="btn btn-sm btn-danger delete-btn">
                                        <i class="fa fa-trash" aria-hidden="true"></i> 삭제
                                    </a>
                                </div>

                                <!-- 수정 폼 -->
                                <div id="editForm${addr.addressId}" class="address-form">
                                    <h4>배송지 수정</h4>
                                    <form action="${pageContext.request.contextPath}/address/update" method="post">
                                        <input type="hidden" name="addressId" value="${addr.addressId}">
                                        <div class="form-group">
                                            <label>배송지 이름*</label>
                                            <input type="text" name="addressName" class="form-control"
                                                   value="${addr.addressName}" required maxlength="20">
                                        </div>
                                        <div class="form-group">
                                            <label>우편번호*</label>
                                            <input type="text" name="postalCode" class="form-control"
                                                   value="${addr.postalCode}" required>
                                        </div>
                                        <div class="form-group">
                                            <label>주소*</label>
                                            <input type="text" name="address" class="form-control"
                                                   value="${addr.address}" required>
                                        </div>
                                        <div class="form-group">
                                            <label>상세주소</label>
                                            <input type="text" name="detailAddress" class="form-control"
                                                   value="${addr.detailAddress}">
                                        </div>
                                        <div class="form-group">
                                            기본 배송지로 설정 : <input type="checkbox" name="isDefault" value="true"
                                            ${addr.isDefault() ? 'checked' : ''} style="margin-left: 5px;">
                                        </div>
                                        <div class="address-actions">
                                            <button type="submit" class="btn btn-primary">수정 완료</button>
                                            <button type="button" class="btn btn-secondary cancel-btn">취소</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</section>
<!-- end address section -->

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