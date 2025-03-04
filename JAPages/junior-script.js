function showForm(formId) {
    const forms = document.querySelectorAll('.form-container');
    forms.forEach(form => form.style.display = 'none');
    document.getElementById(formId).style.display = 'block';

    // Scroll to the top of the previous form
    document.getElementById(formId).scrollIntoView({ behavior: 'smooth', block: 'start' });


    // Remove active class from all sidebar items
    const menuItems = document.querySelectorAll('.side-menu ul li');
    menuItems.forEach(item => item.classList.remove('active-category'));

    // Add active class to the clicked sidebar item
    const activeItem = Array.from(menuItems).find(item => item.getAttribute('onclick').includes(formId));
    if (activeItem) {
        activeItem.classList.add('active-category');
    }
}

function validateAndSubmit(formId) {
    const form = document.getElementById(formId);

    // Check for empty fields
    const inputs = form.querySelectorAll("input[required]");
    let isValid = true;

    inputs.forEach(input => {
        if (!input.value.trim()) {
            isValid = false;
        }
    });

    if (!isValid) {
        showToast("Please fill in all required fields!", "error");
        return;
    }

    // Get the submit button inside the form
    const submitButton = form.querySelector(".submit-btn");

    // Simulate form submission
    setTimeout(() => {
        showToast("Form submitted successfully!", "success");

        // Change button color to indicate success
        submitButton.style.backgroundColor = "green";
        submitButton.textContent = "Added ✔"; // Change text

        // Delay before resetting form and reverting button
        setTimeout(() => {
            inputs.forEach(input => input.value = ""); // Manually clear inputs
            submitButton.style.backgroundColor = "#22438c"; // Revert button color
            submitButton.textContent = "Add"; // Revert button text
        }, 2000); // Reset after 2 seconds

    }, 1000);
}

// Function to show toast messages
function showToast(message, type) {
    Toastify({
        text: message,
        duration: 3000,
        gravity: "top", // top, bottom
        position: "right", // left, center, right
        backgroundColor: type === "success" ? "green" : "red",
        close: true,
    }).showToast();
}
