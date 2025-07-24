console.log('Custom.js loaded');

// to get current year
function getYear() {
    var currentDate = new Date();
    var currentYear = currentDate.getFullYear();
    document.querySelector("#displayYear").innerHTML = currentYear;
}

getYear();

// register section Password Strength JS
$(document).ready(function () {
    // Password Strength
    $('#custPwd').on('keyup', function () {
        const password = $(this).val();
        const strengthText = $('#strengthText');

        if (!password) {
            strengthText.text('Password 없음').removeClass().addClass('text-muted');
        } else if (password.length < 6) {
            strengthText.text('Weak').removeClass().addClass('text-danger');
        } else if (/[A-Z]/.test(password) && /[0-9]/.test(password)) {
            strengthText.text('Strong').removeClass().addClass('text-success');
        } else {
            strengthText.text('Medium').removeClass().addClass('text-warning');
        }
    });

    // Password Match Validation
    $('#confirmCustPwd, #custPwd').on('keyup', function () {
        const password = $('#custPwd').val();
        const confirm = $('#confirmCustPwd').val();
        const message = $('#matchMessage');
        const btn = $('#registerBtn');

        if (!confirm) {
            message.text('').removeClass();
            btn.prop('disabled', true);
            return;
        }

        if (password === confirm) {
            message.text('Password matched').removeClass().addClass('text-success');
            btn.prop('disabled', false);
        } else {
            message.text('Password does not match').removeClass().addClass('text-danger');
            btn.prop('disabled', true);
        }
    });
});

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

