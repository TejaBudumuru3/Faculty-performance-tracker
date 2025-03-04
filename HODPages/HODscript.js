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

function showTab(tabId) {
    // Hide all tab contents
    const tabs = document.querySelectorAll('.card1');
    tabs.forEach(tab => tab.classList.remove('active'));

    // Show the selected tab content
    document.getElementById(tabId).classList.add('active');
}

function assignTask() {
    // Get input values
    let faculty = document.getElementById('faculty').value;
    let title = document.getElementById('taskTitle').value.trim();

    // Check if all required fields are filled
    if (!faculty || !title) {
        Toastify({
            text: "Please fill all fields before assigning the task!",
            duration: 3000,
            gravity: "top",
            position: "right",
            backgroundColor: "#a3ac22;", // Yellow for warning
            stopOnFocus: true
        }).showToast();
        return; // Stop execution if any field is empty
    }

    // Show confirmation dialog
    let confirmation = confirm("Are you sure you want to assign this task?");
    if (confirmation) {
        Toastify({
            text: "Task assigned successfully!",
            duration: 3000,
            gravity: "top",
            position: "right",
            backgroundColor: "#39864b", // Green for success
            stopOnFocus: true
        }).showToast();

        // (Optional) Clear fields after successful assignment
        document.getElementById('faculty').value = "";
        document.getElementById('taskTitle').value = "";
    } else {
        Toastify({
            text: "Task assignment canceled.",
            duration: 3000,
            gravity: "top",
            position: "right",
            backgroundColor: "#ad2c39", // Red for cancel
            stopOnFocus: true
        }).showToast();
    }
}


