/*
  블랙프라이데이 슬라이더 동적 배경 변경 스크립트
  index.jsp에서 사용
 */

$(document).ready(function() {

    /*
      배경 이미지 변경 함수
      @param {string} bgImageUrl - 변경할 배경 이미지 URL
     */
    function changeSliderBackground(bgImageUrl) {
        if (bgImageUrl && $('#sliderBgImage').length) {
            $('#sliderBgImage').attr('src', bgImageUrl);
        }
    }

    /*
     Bootstrap 캐러셀 슬라이드 전환 이벤트
     슬라이드가 전환되기 시작할 때 배경 이미지도 함께 변경
     */
    $('#customCarousel1').on('slide.bs.carousel', function (event) {
        var nextSlide = $(event.relatedTarget);
        var bgImage = nextSlide.data('bg');

        changeSliderBackground(bgImage);
    });

    /**
     * 캐러셀 인디케이터 클릭 이벤트
     * 점(인디케이터) 클릭 시에도 배경 변경
     */
    $('.carousel-indicators li').click(function() {
        var slideIndex = $(this).data('slide-to');
        var targetSlide = $('.carousel-item').eq(slideIndex);
        var bgImage = targetSlide.data('bg');

        changeSliderBackground(bgImage);
    });

    /*
      초기 로딩 시 첫 번째 슬라이드 배경 설정
      페이지 로드 후 active 슬라이드의 배경으로 초기화
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

    /*
      키보드 네비게이션 지원 (선택사항)
      좌우 화살표 키로 슬라이드 변경
     */
    $(document).keydown(function(e) {
        if (e.which === 37) { // 왼쪽 화살표
            $('#customCarousel1').carousel('prev');
        } else if (e.which === 39) { // 오른쪽 화살표
            $('#customCarousel1').carousel('next');
        }
    });

    /*
     터치 스와이프 지원 개선 (모바일)
     기본 Bootstrap 스와이프에 추가 최적화
     */
    var xDown = null;
    var yDown = null;

    $('.slider_section').on('touchstart', function(e) {
        xDown = e.touches[0].clientX;
        yDown = e.touches[0].clientY;
    });

    $('.slider_section').on('touchmove', function(e) {
        if (!xDown || !yDown) {
            return;
        }

        var xUp = e.touches[0].clientX;
        var yUp = e.touches[0].clientY;

        var xDiff = xDown - xUp;
        var yDiff = yDown - yUp;

        if (Math.abs(xDiff) > Math.abs(yDiff)) {
            if (xDiff > 0) {
                // 왼쪽 스와이프 - 다음 슬라이드
                $('#customCarousel1').carousel('next');
            } else {
                // 오른쪽 스와이프 - 이전 슬라이드
                $('#customCarousel1').carousel('prev');
            }
        }

        xDown = null;
        yDown = null;
    });

    // 디버깅용 콘솔 로그 (배포 시 제거)
    console.log('블랙프라이데이 슬라이더 스크립트 로드 완료');
});