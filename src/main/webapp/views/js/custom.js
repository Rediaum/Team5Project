console.log('Custom.js loaded');

// to get current year
function getYear() {
    var currentDate = new Date();
    var currentYear = currentDate.getFullYear();
    document.querySelector("#displayYear").innerHTML = currentYear;
}

getYear();

// RegisterValidator object to manage all registration validation logic
const RegisterValidator = {
    // Method to check password strength
    passwordStrength: function () {
        const password = $('#custPwd').val(); // Get password input value
        const strengthText = $('#strengthText'); // Get element to display strength message
        let strength = 0; // Password strength score
        let message = 'Type your password';
        let className = 'text-muted'; // Default CSS class
        // Remove all previous strength CSS classes for clean styling
        strengthText.removeClass('text-muted text-danger text-warning text-success');
        // Logic to determine password strength
        if (password.length > 0) {
            // Award points based on criteria:
            if (password.length >= 8) strength += 1; // Minimum 8 characters
            if (/[A-Z]/.test(password)) strength += 1; // Contains uppercase letter
            if (/[a-z]/.test(password)) strength += 1; // Contains lowercase letter
            if (/[0-9]/.test(password)) strength += 1; // Contains number
            if (/[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?~` ]/.test(password)) strength += 1; // Contains special character
            // Determine message and class based on strength score
            if (strength <= 1) {
                message = 'Very Weak Password';
                className = 'text-danger';
            } else if (strength === 2) {
                message = 'Weak Password';
                className = 'text-warning';
            } else if (strength === 3) {
                message = 'Medium Password';
                className = 'text-warning';
            } else if (strength >= 4) {
                message = 'Strong Password!';
                className = 'text-success';
            }
        }
        // Apply message and CSS class to the strengthText element
        strengthText.text(message).addClass(className);
    },
    // Method to check if passwords match
    passwordMatch: function () {
        const password = $('#custPwd').val(); // Get password value
        const confirmPassword = $('#confirmCustPwd').val(); // Get confirm password value
        const matchMessage = $('#matchMessage'); // Get element to display match message
        const registerButton = $('#registerBtn'); // Get register button
        // Remove all previous match CSS classes for clean styling
        matchMessage.removeClass('text-danger text-success');
        // Logic to determine if passwords match
        if (!confirmPassword) {
            matchMessage.text(''); // Clear message
            registerButton.prop('disabled', true); // Disable button
            return false;
        }
        if (password === confirmPassword) {
            matchMessage.text('Passwords Match!').addClass('text-success');
            registerButton.prop('disabled', false); // Enable button
            return true;
        } else {
            matchMessage.text('Passwords Do Not Match').addClass('text-danger');
            registerButton.prop('disabled', true); // Disable button
            return false;
        }
    },
    // Method to bind events to form elements
    eventBind: function () {
        // When user types in password field
        $('#custPwd').on('keyup', () => {
            this.passwordStrength(); // Check password strength
            this.passwordMatch();    // Check password match
        });
        // When user types in confirm password field
        $('#confirmCustPwd').on('keyup', () => {
            this.passwordMatch();    // Only need to check password match
        });
        // Initially disable the register button
        $('#registerBtn').prop('disabled', true);
    },
    // Method to handle form submission
    send: function () {
        // Bind 'click' event to the Register button
        $('#registerBtn').on('click', (e) => {
            e.preventDefault(); // Prevent default button behavior
            // Re-check if passwords match before submitting
            if (!this.passwordMatch()) {
                alert('Passwords do not match.'); // Use alert() as per original request
                return; // Stop submission
            }
            // Get form action and method from HTML attributes
            const formAction = $('#registerForm').attr('action');
            const formMethod = $('#registerForm').attr('method');
            // Set form attributes (redundant if already in HTML, but ensures JS uses them)
            $('#registerForm').attr('method', formMethod);
            $('#registerForm').attr('action', formAction);
            // Programmatically submit the form (will cause page reload)
            $('#registerForm').submit();
        });
    },
    // Initialization method to run all necessary functions when page loads
    init: function () {
        this.eventBind(); // Set up all event listeners
        this.send();      // Set up form submission logic
        this.passwordStrength(); // Call once on init to show initial message
    }
};
$(document).ready(function () {
    RegisterValidator.init();
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

