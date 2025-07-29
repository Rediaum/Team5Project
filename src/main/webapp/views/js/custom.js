console.log('Custom.js loaded');

// to get current year
function getYear() {
    var currentDate = new Date();
    var currentYear = currentDate.getFullYear();
    document.querySelector("#displayYear").innerHTML = currentYear;
}

getYear();

// client section owl carousel
$(".client_owl-carousel").owlCarousel({
    loop: true,
    margin: 0,
    dots: false,
    nav: true,
    navText: [],
    autoplay: true,
    autoplayHoverPause: true,
    navText: [
        '<i class="fa fa-angle-left" aria-hidden="true"></i>',
        '<i class="fa fa-angle-right" aria-hidden="true"></i>'
    ],
    responsive: {
        0: {
            items: 1
        },
        768: {
            items: 2
        },
        1000: {
            items: 2
        }
    }
});



/** google_map js **/
function myMap() {
    var mapProp = {
        center: new google.maps.LatLng(40.712775, -74.005973),
        zoom: 18,
    };
    var map = new google.maps.Map(document.getElementById("googleMap"), mapProp);
}

// ===== 기존 custom.js 파일 맨 아래에 추가할 블랙프라이데이 스크립트 =====

/**
 * 블랙프라이데이 슬라이더 동적 배경 변경 기능
 */
$(document).ready(function() {

    // 블랙프라이데이 슬라이더가 있는 페이지에서만 실행
    if ($('#customCarousel1').length && $('#sliderBgImage').length) {

        /**
         * 배경 이미지 변경 함수
         */
        function changeSliderBackground(bgImageUrl) {
            if (bgImageUrl) {
                $('#sliderBgImage').attr('src', bgImageUrl);
            }
        }

        /**
         * Bootstrap 캐러셀 슬라이드 전환 이벤트
         */
        $('#customCarousel1').on('slide.bs.carousel', function (event) {
            var nextSlide = $(event.relatedTarget);
            var bgImage = nextSlide.data('bg');
            changeSliderBackground(bgImage);
        });

        /**
         * 캐러셀 인디케이터 클릭 이벤트
         */
        $('.carousel-indicators li').click(function() {
            var slideIndex = $(this).data('slide-to');
            var targetSlide = $('.carousel-item').eq(slideIndex);
            var bgImage = targetSlide.data('bg');
            changeSliderBackground(bgImage);
        });

        /**
         * 초기 로딩 시 첫 번째 슬라이드 배경 설정
         */
        function initializeSliderBackground() {
            var activeSlide = $('.carousel-item.active');
            var initialBg = activeSlide.data('bg');
            if (initialBg) {
                changeSliderBackground(initialBg);
            }
        }

        // 초기화 실행
        initializeSliderBackground();

        /**
         * 키보드 네비게이션 지원
         */
        $(document).keydown(function(e) {
            if (e.which === 37) { // 왼쪽 화살표
                $('#customCarousel1').carousel('prev');
            } else if (e.which === 39) { // 오른쪽 화살표
                $('#customCarousel1').carousel('next');
            }
        });

        console.log('블랙프라이데이 슬라이더 기능 활성화');
    }
});

