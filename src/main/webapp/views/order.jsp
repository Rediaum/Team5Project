<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>주문서 작성 - Team 5 Shop</title>

    <!-- bootstrap core css -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/views/css/bootstrap.css" />
    <!-- font awesome style -->
    <link href="${pageContext.request.contextPath}/views/css/font-awesome.min.css" rel="stylesheet" />
    <!-- Custom styles -->
    <link href="${pageContext.request.contextPath}/views/css/style.css" rel="stylesheet" />
    <!-- responsive style -->
    <link href="${pageContext.request.contextPath}/views/css/responsive.css" rel="stylesheet" />

    <!-- 드롭다운 메뉴 스타일 -->
    <style>
        .dropdown-menu {
            border: 1px solid #ddd;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            border-radius: 5px;
        }

        .dropdown-item {
            padding: 8px 16px;
            color: #333;
            transition: background-color 0.2s;
        }

        .dropdown-item:hover {
            background-color: #f8f9fa;
            color: #f7444e;
        }

        .dropdown-divider {
            margin: 5px 0;
        }

        .dropdown-item i {
            margin-right: 8px;
            width: 16px;
        }
    </style>

    <!-- jQuery -->
    <script src="${pageContext.request.contextPath}/views/js/jquery-3.4.1.min.js"></script>
    <!-- Bootstrap JavaScript -->
    <script src="${pageContext.request.contextPath}/views/js/bootstrap.js"></script>

    <script>
        $(document).ready(function() {
            // 주문 완료 버튼 클릭 시 확인
            $('#orderBtn').click(function(e) {
                e.preventDefault();
                if (confirm('주문을 완료하시겠습니까?')) {
                    $(this).closest('form').submit();
                }
            });

            // 전화번호 자동 하이픈 추가
            $('#shippingPhone').on('input', function() {
                let value = this.value.replace(/[^0-9]/g, '');
                if (value.length >= 11) {
                    value = value.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
                } else if (value.length >= 7) {
                    value = value.replace(/(\d{3})(\d{4})/, '$1-$2');
                }
                this.value = value;
            });

            // 알림 메시지 자동 숨김
            setTimeout(function() {
                $('.alert').fadeOut();
            }, 5000);
        });
    </script>
</head>

<body class="sub_page">
<!-- header section -->
<div class="hero_area">
    <header class="header_section">
        <div class="container">
            <nav class="navbar navbar-expand-lg custom_nav-container ">
                <%-- 로고 --%>
                <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                    <img width="250" src="${pageContext.request.contextPath}/views/images/logo.png" alt="#" />
                </a>

                <%-- 모바일 메뉴 토글 버튼 --%>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class=""> </span>
                </button>

                <%-- 네비게이션 메뉴 --%>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/">Home</a>
                        </li>

                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="pagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true" style="color: #000;">
                                <span class="nav-label">Pages <span class="caret"></span></span>
                            </a>
                            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="pagesDropdown">
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/about">About</a>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/testimonial">Testimonial</a>
                            </div>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/product">Products</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/contact">Contact</a>
                        </li>

                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="color: #000;">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <circle cx="12" cy="7" r="4"/>
                                    <path d="M6 21v-2a4 4 0 0 1 4-4h4a4 4 0 0 1 4 4v2"/>
                                </svg>
                                <span class="nav-label"><span class="caret"></span></span>
                            </a>

                            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
                                <c:choose>
                                    <c:when test="${sessionScope.logincust == null}">
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/login">
                                            <i class="fa fa-sign-in" aria-hidden="true"></i> Login
                                        </a>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/register">
                                            <i class="fa fa-user-plus" aria-hidden="true"></i> Register
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/info">
                                            <i class="fa fa-user" aria-hidden="true"></i> ${sessionScope.logincust.custName}
                                        </a>
                                        <div class="dropdown-divider"></div>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                            <i class="fa fa-sign-out" aria-hidden="true"></i> Log Out
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </li>

                        <c:if test="${sessionScope.logincust != null}">
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
                        </c:if>

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
</div>

<!-- 주문서 작성 화면 -->
<section class="product_section layout_padding" style="padding-top: 40px;">
    <div class="container">
        <div class="heading_container heading_center" style="margin-bottom: 30px;">
            <h2>주문서 <span>작성</span></h2>
        </div>

        <!-- 에러 메시지 표시 -->
        <c:if test="${error != null}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fa fa-exclamation-triangle"></i> ${error}
                <button type="button" class="close" data-dismiss="alert">&times;</button>
            </div>
        </c:if>

        <div class="row">
            <div class="col-md-8">
                <!-- 고객 정보 표시 -->
                <div class="card mb-3">
                    <div class="card-header">
                        <h5><i class="fa fa-user"></i> 주문자 정보</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <strong>이름:</strong> ${sessionScope.logincust.custName}
                            </div>
                            <div class="col-md-6">
                                <strong>이메일:</strong> ${sessionScope.logincust.custEmail}
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 배송 정보 입력 폼 -->
                <div class="card">
                    <div class="card-header">
                        <h5><i class="fa fa-truck"></i> 배송 정보</h5>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/order/process" method="post" id="orderForm">
                            <div class="form-group">
                                <label for="shippingName">받는 사람 <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="shippingName" name="shippingName"
                                       value="${sessionScope.logincust.custName}" required>
                                <small class="form-text text-muted">주문자와 다른 경우 수정해주세요</small>
                            </div>

                            <div class="form-group">
                                <label for="shippingPhone">연락처 <span class="text-danger">*</span></label>
                                <input type="tel" class="form-control" id="shippingPhone" name="shippingPhone"
                                       placeholder="010-1234-5678" required>
                            </div>

                            <div class="form-group">
                                <label for="shippingAddress">배송 주소 <span class="text-danger">*</span></label>
                                <textarea class="form-control" id="shippingAddress" name="shippingAddress"
                                          rows="3" placeholder="상세 주소를 입력해주세요" required></textarea>
                            </div>

                            <div class="form-group">
                                <label for="orderMemo">주문 메모</label>
                                <textarea class="form-control" id="orderMemo" name="orderMemo"
                                          rows="2" placeholder="배송 시 요청사항이 있으시면 입력해주세요 (선택사항)"></textarea>
                            </div>

                            <div class="text-center mt-4">
                                <button type="button" class="btn btn-secondary mr-3" onclick="history.back()">
                                    <i class="fa fa-arrow-left"></i> 이전으로
                                </button>
                                <button type="submit" class="btn btn-success btn-lg" id="orderBtn">
                                    <i class="fa fa-credit-card"></i> 주문 완료
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <!-- 주문 요약 -->
                <div class="card">
                    <div class="card-header">
                        <h5><i class="fa fa-shopping-cart"></i> 주문 요약</h5>
                    </div>
                    <div class="card-body">
                        <!-- 주문 상품 목록 표시 -->
                        <c:choose>
                            <%-- 장바구니에서 주문하는 경우 --%>
                            <c:when test="${cartItems != null && !empty cartItems}">
                                <c:forEach var="item" items="${cartItems}">
                                    <div class="order-item mb-3">
                                        <div class="d-flex justify-content-between">
                                            <span>${item.productName}</span>
                                            <span>${item.productQt}개</span>
                                        </div>
                                        <div class="text-right">
                                            <small class="text-muted">
                                                <fmt:formatNumber value="${item.productPrice * item.productQt}" pattern="#,###" />원
                                            </small>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <%-- 직접 주문하는 경우 --%>
                            <c:when test="${product != null}">
                                <div class="order-item mb-3">
                                    <div class="d-flex justify-content-between">
                                        <span>${product.productName}</span>
                                        <span>${quantity}개</span>
                                    </div>
                                    <div class="text-right">
                                        <small class="text-muted">
                                            <fmt:formatNumber value="${product.productPrice * quantity}" pattern="#,###" />원
                                        </small>
                                    </div>
                                </div>
                            </c:when>
                            <%-- 기본 표시 --%>
                            <c:otherwise>
                                <div class="order-item mb-3">
                                    <div class="text-center text-muted">
                                        <i class="fa fa-shopping-cart"></i><br>
                                        주문 정보를 불러오는 중...
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>

                        <hr>

                        <!-- 결제 정보 -->
                        <div class="d-flex justify-content-between mb-2">
                            <span>상품 금액:</span>
                            <span>
                                <fmt:formatNumber value="${totalAmount != null ? totalAmount : 0}" pattern="#,###" />원
                            </span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span>배송비:</span>
                            <span>무료</span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span>할인:</span>
                            <span class="text-danger">
                                -<fmt:formatNumber type="number" pattern="###,###원" value="${discountedPrice}" />원
                            </span>
                        </div>

                        <hr>

                        <div class="d-flex justify-content-between" style="font-size: 18px;">
                            <span><strong>총 결제금액:</strong></span>
                            <span class="text-danger">
                                <strong>
                                    <fmt:formatNumber value="${totalAmount != null ? totalAmount : 0}" pattern="#,###" />원
                                </strong>
                            </span>
                        </div>

                        <!-- 결제 방법 -->
                        <div class="mt-4">
                            <h6>결제 방법</h6>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="paymentMethod" id="card" value="card" checked>
                                <label class="form-check-label" for="card">
                                    <i class="fa fa-credit-card"></i> 신용카드
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="paymentMethod" id="bank" value="bank">
                                <label class="form-check-label" for="bank">
                                    <i class="fa fa-university"></i> 무통장입금
                                </label>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 주문 안내 -->
                <div class="card mt-3">
                    <div class="card-body">
                        <h6><i class="fa fa-info-circle"></i> 주문 안내</h6>
                        <small class="text-muted">
                            - 주문 완료 후 변경/취소는 고객센터로 문의해주세요<br>
                            - 배송은 영업일 기준 2-3일 소요됩니다<br>
                            - 무료배송 기준: 50,000원 이상 구매시
                        </small>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- footer section -->
<footer class="footer_section">
    <div class="container">
        <div class="row">
            <div class="col-md-4 footer-col">
                <div class="footer_contact">
                    <h4>연락처</h4>
                    <div class="contact_link_box">
                        <a href=""><i class="fa fa-map-marker" aria-hidden="true"></i><span>서울시 강남구</span></a>
                        <a href=""><i class="fa fa-phone" aria-hidden="true"></i><span>02-1234-5678</span></a>
                        <a href=""><i class="fa fa-envelope" aria-hidden="true"></i><span>team5@shop.com</span></a>
                    </div>
                </div>
            </div>
            <div class="col-md-4 footer-col">
                <div class="footer_info">
                    <h4>고객센터</h4>
                    <p>평일 09:00 - 18:00<br>주말/공휴일 휴무</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="footer_info">
                    <h5>Team 5 Shop</h5>
                    <p>최고의 상품과 서비스를 제공합니다</p>
                </div>
            </div>
        </div>
    </div>
</footer>

</body>
</html>