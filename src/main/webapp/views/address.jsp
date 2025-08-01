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
            height: 30px; /* 원하는 높이로 조절 */
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 0 12px;
        }
        .address-actions button i {
            margin-right: 5px; /* 아이콘과 텍스트 사이 간격 */
        }

        /* Bootstrap .btn-sm의 기본 height 값을 오버라이드할 수 있도록 추가 */
        .btn-sm {
            height: auto; /* Bootstrap의 기본 btn-sm 높이 설정을 무효화 */
            padding: .25rem .5rem; /* Bootstrap 기본 패딩 유지 또는 조절 */
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
                <c:choose>
                    <c:when test="${returnUrl == 'order'}">
                        <a href="${pageContext.request.contextPath}/order/from-cart" class="btn btn-secondary">
                            <i class="fa fa-arrow-left" aria-hidden="true"></i> 주문 페이지로 돌아가기
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/info" class="btn btn-secondary">
                            <i class="fa fa-arrow-left" aria-hidden="true"></i> 프로필로 돌아가기
                        </a>
                    </c:otherwise>
                </c:choose>
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
                    <!-- returnUrl 히든 필드 추가 -->
                    <c:if test="${not empty returnUrl}">
                        <input type="hidden" name="returnUrl" value="${returnUrl}">
                    </c:if>

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
                        <label>
                            <input type="checkbox" name="isDefault" value="true" style="margin-right: 5px;">
                            기본 배송지로 설정
                        </label>
                        <!-- 체크되지 않았을 때도 false 값을 전달하기 위한 히든 필드 -->
                        <input type="hidden" name="_isDefault" value="on">
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

                                    <form action="${pageContext.request.contextPath}/address/delete" method="post"
                                          style="display: inline;" onsubmit="return confirm('정말 삭제하시겠습니까?')">
                                        <c:if test="${not empty returnUrl}">
                                            <input type="hidden" name="returnUrl" value="${returnUrl}">
                                        </c:if>
                                        <input type="hidden" name="addressId" value="${addr.addressId}">
                                        <button type="submit" class="btn btn-sm btn-danger">
                                            <i class="fa fa-trash" aria-hidden="true"></i> 삭제
                                        </button>
                                    </form>
                                </div>

                                <!-- 수정 폼 -->
                                <div id="editForm${addr.addressId}" class="address-form">
                                    <h4>배송지 수정</h4>
                                    <form action="${pageContext.request.contextPath}/address/update" method="post">
                                        <!-- returnUrl 히든 필드 추가 -->
                                        <c:if test="${not empty returnUrl}">
                                            <input type="hidden" name="returnUrl" value="${returnUrl}">
                                        </c:if>

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

<!-- Custom JavaScript -->
<script src="${pageContext.request.contextPath}/views/js/custom.js"></script>
</body>
</html>