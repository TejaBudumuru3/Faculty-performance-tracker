function showForm(formId) {
    const forms = document.querySelectorAll('.form-container');
    forms.forEach(form => form.style.display = 'none');
    document.getElementById("myChart").style.display = 'none';
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

function nextTab(current, next) {
    event.preventDefault(); // Prevent form submission

    // Hide the current tab and show the next one
    document.getElementById(current).style.display = 'none';
    document.getElementById(next).style.display = 'block';

    // Scroll to the top of the new form
    document.getElementById(next).scrollIntoView({ behavior: 'smooth', block: 'start' });

    // Remove active class from all sidebar items
    const menuItems = document.querySelectorAll('.side-menu ul li');
    menuItems.forEach(item => item.classList.remove('active-category'));

    // Add active class to the next category
    const activeItem = Array.from(menuItems).find(item => item.getAttribute('onclick').includes(next));
    if (activeItem) {
        activeItem.classList.add('active-category');
    }
}

function prevTab(current, previous) {
    event.preventDefault(); // Prevent form submission
    document.getElementById(current).style.display = 'none';
    document.getElementById(previous).style.display = 'block';

    // Scroll to the top of the previous form
    document.getElementById(previous).scrollIntoView({ behavior: 'smooth', block: 'start' });

    // Remove active class from all sidebar items
    const menuItems = document.querySelectorAll('.side-menu ul li');
    menuItems.forEach(item => item.classList.remove('active-category'));

    // Add active class to the previous category
    const activeItem = Array.from(menuItems).find(item => item.getAttribute('onclick').includes(previous));
    if (activeItem) {
        activeItem.classList.add('active-category');
    }
}