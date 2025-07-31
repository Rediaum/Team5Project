<%-- 1. JSP 페이지 기본 설정 및 JSTL 태그 라이브러리 선언 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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

        /* Sidebar */
        .sidebar {
            width: 220px;
            background: #222;
            color: white;
            padding-top: 60px;
            box-sizing: border-box;
            flex-shrink: 0;
            display: flex;
            flex-direction: column;
        }

        .sidebar h4 {
            padding: 15px 20px;
            margin-bottom: 0;
            color: #fff;
            font-size: 18px;
            border-bottom: 1px solid #444;
        }

        .sidebar ul {
            list-style: none;
            padding: 0;
            margin: 0;
            flex-grow: 1;
        }

        .sidebar ul li {
            padding: 10px 20px;
            border-bottom: 1px solid #333;
        }

        .sidebar ul li a {
            color: white;
            text-decoration: none;
            display: block;
        }

        .sidebar ul li a:hover {
            background-color: #444;
            color: #fff;
        }

        /* Main content */
        .content {
            flex-grow: 1;
            padding: 30px;
            box-sizing: border-box;
            background-color: #f9f9f9;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .wrapper {
                flex-direction: column;
            }

            .sidebar {
                width: 100%;
                padding-top: 20px;
            }

            .content {
                padding: 15px;
            }
        }
    
    </style>
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
                        
                        <!-- Admin을 위한 메뉴 -->
                        <c:if test="${sessionScope.role eq 'admin'}">
                            <!-- Inventory, 제품 관리 메뉴 -->
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/admin/inventory">Inventory</a>
                            </li>
                            
                            <!-- Customer 관리 메뉴 -->
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/admin/customers">Customer</a>
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
                    <h3>Inventory Management</h3>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- end inner page section -->

<!-- client section -->
<div class="d-flex" style="min-height: 100vh;">
    <%--sidebar--%>
    <div class="sidebar d-flex flex-column p-3 bg-dark text-white" style="width: 220px;">
        <h4>Inventory</h4>
        <ul class="nav nav-pills flex-column mb-auto">
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/inventory"
                   class="nav-link ${activePage == 'inventory' ? 'active' : 'text-white'}">
                    Inventory
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/inventory/add"
                   class="nav-link ${activePage == 'add' ? 'active' : 'text-white'}">
                    Add New Product
                </a>
            </li>
        </ul>
    </div>
        
    <!-- 제품 표 -->
    <div class="content flex-grow-1 p-4" style="background-color: #f8f9fa;">
        <h2>Update Product</h2>
        <form action="${pageContext.request.contextPath}/admin/inventory/update" method="post" enctype="multipart/form-data">
            
            <div class="form-group mb-3">
                <label>ID:</label>
                <p class="form-control-plaintext">${product.productId}</p>
                <input type="hidden" name="productId" value="${product.productId}" />
            </div>
            
            <div class="form-group mb-3">
                <label>Current Image:</label><br/>
                <img src="${pageContext.request.contextPath}/views/images/${product.productImg}" width="400" height="auto" alt="${product.productName}" />
                <input type="hidden" name="productImg" value="${product.productImg}" />
            </div>
            
            
            <div class="form-group">
                <label>Name:</label>
                <input type="text" name="productName" class="form-control" value="${product.productName}" required>
            </div>
            
            <div class="form-group">
                <label>Price:</label>
                <input type="number" name="productPrice" class="form-control" value="${product.productPrice}" required>
            </div>
            
            <div class="form-group">
                <label>Discount Rate (%):</label>
                <input type="number" name="discountRate" class="form-control" value="${product.discountRate}" required>
            </div>
            
            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description" class="form-control" rows="3">${product.description}</textarea>
            </div>
            
            <div class="form-group">
                <label for="productImg">Upload New Image</label>
                <input type="file" name="imgfile" class="form-control-file" />
            </div>
            
            <div class="form-group">
                <label>Category ID:</label>
                <input type="number" name="categoryId" class="form-control" value="${product.categoryId}" required>
            </div>
            
            <br>
            <button type="submit" class="btn btn-primary">Update</button>
            <a href="${pageContext.request.contextPath}/admin/inventory/delete/${product.productId}" class="btn btn-danger" onclick="return confirm('Are you sure?');">Delete</a>
        </form>
    </div>
</div>

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