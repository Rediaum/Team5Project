/**
 * 검색 페이지 전용 JavaScript
 * 파일 위치: src/main/webapp/views/js/search.js
 */

$(document).ready(function() {
    // 검색 페이지 초기화
    initSearchPage();
});

// 검색 페이지 초기화
function initSearchPage() {
    console.log('검색 페이지 로드됨');

    // 폼 유효성 검사
    $('#searchForm').on('submit', function(e) {
        const keyword = $('input[name="keyword"]').val().trim();
        const category = $('select[name="category"]').val();
        const minPrice = $('input[name="minPrice"]').val();
        const maxPrice = $('input[name="maxPrice"]').val();

        // 최소한 하나의 검색 조건은 있어야 함
        if (!keyword && category == '0' && !minPrice && !maxPrice) {
            alert('검색 조건을 입력해주세요.');
            e.preventDefault();
            return false;
        }

        // 가격 범위 검증
        if (minPrice && maxPrice && parseInt(minPrice) > parseInt(maxPrice)) {
            alert('최소 가격이 최대 가격보다 클 수 없습니다.');
            e.preventDefault();
            return false;
        }
    });
}

// 필터 초기화
function clearFilters() {
    $('input[name="keyword"]').val('');
    $('select[name="category"]').val('0');
    $('input[name="minPrice"]').val('');
    $('input[name="maxPrice"]').val('');
    $('#sort1').prop('checked', true);

    // 검색 페이지로 이동 (모든 필터 제거)
    window.location.href = window.location.pathname;
}

// 장바구니 추가
function addToCart(productId) {
    if (confirm('장바구니에 추가하시겠습니까?')) {
        window.location.href = window.location.origin + '/cart/add?productId=' + productId;
    }
}

// 빠른 검색 함수들
function quickSearch(keyword) {
    $('input[name="keyword"]').val(keyword);
    $('#searchForm').submit();
}

function selectCategory(categoryId) {
    $('select[name="category"]').val(categoryId);
    $('#searchForm').submit();
}

function setPriceRange(minPrice, maxPrice) {
    $('input[name="minPrice"]').val(minPrice);
    $('input[name="maxPrice"]').val(maxPrice);
    $('#searchForm').submit();
}