function submitForm() {
    // Hide all form containers and side menu
    document.querySelectorAll('.form-container').forEach(form => form.style.display = 'none');
    document.querySelectorAll('.side-menu').forEach(form => form.style.display = 'none');

    // Define categories and their corresponding IDs
    let categories = {
        "General Work": ["classes", "prep", "reviews", "counsel"],
        "Examination": ["invig", "correction", "vi-va", "external"],
        "Membership": ["meeting", "workshop", "visit", "seminar"],
        "Publications": ["started", "pending", "published", "patent"]
    };

    let outputText = `<h2 style="text-align: center">Your Data Submitted Successfully</h2>
    <table border="1" style="width: 100%; border-collapse: collapse;">
        <tr>
            <th style="text-align: left; padding: 8px;">Category</th>
            <th style="text-align: left; padding: 8px;">Activity</th>
            <th style="text-align: left; padding: 8px;">Hours</th>
        </tr>`;

    // Iterate through categories
    for (let category in categories) {
        let categoryDisplayed = false; // To avoid repeating category names in multiple rows

        categories[category].forEach((id, index) => {
            let inputElement = document.getElementById(id);
            if (!inputElement) return; // Skip if element doesn't exist
            
            let inputValue = inputElement.value;
            let number = parseInt(inputValue, 10); // Convert to integer
            
            if (isNaN(number)) {
                number = 0; // Default to 0 if invalid
                inputElement.value = "0"; // Reset field to 0
            }

            outputText += `<tr>
                              <td style="padding: 8px;">${categoryDisplayed ? "" : category}</td> 
                              <td style="padding: 8px;">${id.replace(/-/g, " ")}</td>
                              <td style="padding: 8px;">${number}</td>
                           </tr>`;

            categoryDisplayed = true; // Ensure category name is only shown once per group
        });
    }

    outputText += "</table>"+`<button style="border: none;padding:1% 2%; margin:1%; background-color: #004080;  cursor: pointer; color:white; float:right; border-radius: 5px;" onclick=homepage()>Okay</button>`;

    // Display the output
    let outputDiv = document.getElementById("output");
    outputDiv.innerHTML = outputText;
    outputDiv.style.display = "block"; // Ensure it's visible

    

}

function homepage(){
    window.location.href = "workInsert.jsp";
}




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


