document.getElementById("registrationForm").addEventListener("submit", function (e) {
    e.preventDefault(); // Prevent form submission
    let isValid = validateForm();
    if (isValid) {
        alert("Registration Successful!");
    }
});

function validateForm() {
    let isValid = true;

    isValid &= validateField("fullName", /^[a-zA-Z\s]{3,50}$/, "Full Name must be 3-50 alphabetic characters.");
    isValid &= validateField("email", /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/, "Invalid email format.");
    isValid &= validateField("phone", /^[0-9]{10}$/, "Phone number must be 10 digits.");
    isValid &= validatePasswords();
    isValid &= validateField("dob", /.+/, "Please select your Date of Birth.");
    isValid &= validateField("gender", /.+/, "Please select your Gender.");
    isValid &= validateField("address", /^.{5,100}$/, "Address must be between 5 to 100 characters.");
    isValid &= validateCheckbox("terms", "You must agree to the Terms & Conditions.");

    return isValid;
}

function validateField(id, regex, errorMsg) {
    let field = document.getElementById(id);
    let error = field.nextElementSibling;

    if (!regex.test(field.value.trim())) {
        error.textContent = errorMsg;
        field.style.borderColor = "red";
        return false;
    } else {
        error.textContent = "";
        field.style.borderColor = "green";
        return true;
    }
}

function validatePasswords() {
    let password = document.getElementById("password").value.trim();
    let confirmPassword = document.getElementById("confirmPassword").value.trim();
    let error = document.getElementById("confirmPassword").nextElementSibling;

    if (password.length < 6) {
        error.textContent = "Password must be at least 6 characters.";
        return false;
    }

    if (password !== confirmPassword) {
        error.textContent = "Passwords do not match.";
        return false;
    }

    error.textContent = "";
    return true;
}

function validateCheckbox(id, errorMsg) {
    let checkbox = document.getElementById(id);
    let error = checkbox.nextElementSibling;

    if (!checkbox.checked) {
        error.textContent = errorMsg;
        return false;
    } else {
        error.textContent = "";
        return true;
    }
}
