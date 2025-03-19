document.addEventListener("DOMContentLoaded", function () {
    // Initialize toastr options
    toastr.options = {
        "closeButton": true,
        "progressBar": true,
        "positionClass": "toast-top-right",
        "timeOut": "5000",
        "extendedTimeOut": "1000"
    };


// logout

    const logoutButton = document.getElementById("logout");
    if (logoutButton) {
        logoutButton.addEventListener("click", function (event) {
            event.preventDefault(); 
            toastr.success("You have been logged out successfully!"); 

            setTimeout(function () {
                window.location.href = "../logout.jsp";
            }, 1500); // Redirect after 3 seconds
        });
    }
});

//update-password
const updatePasswordButton = document.getElementById("update-password");
if(updatePasswordButton){
    window.href.location="../updatePassword.jsp";
}

// //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

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


function nextTab(current, next,event) {
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

function prevTab(current, previous,event) {
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

// redirecting to workInsert.jsp without table

function submitForm() {
    // Hide all form containers and side menu
    
    document.querySelectorAll('.form-container').forEach(form => form.style.display = 'none');
    document.querySelectorAll('.side-menu').forEach(form => form.style.display = 'none');

    // Define categories and their corresponding IDs
    let categories = {
        "General Work": ["classes", "prep", "reviews", "counsel"],
        "Examination": ["invig", "correction", "viva", "external"],
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

    for (let category in categories) {
        let categoryDisplayed = false;
        categories[category].forEach((id, index) => {
        let inputElement = document.getElementById(id);
            if (!inputElement) return; // Skip if element doesn't exist
            
            let inputValue = inputElement.value;
            let number = parseInt(inputValue, 10); // Convert to integer
            
            if (number<0) {
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
    outputText += `</table>
    <button id="submitButton" style="border: none;padding:1% 2%; margin:1%; background-color: #004080; cursor: pointer; color:white; float:right; border-radius: 5px;">
        Okay
    </button>`;
    // Create a new form element
   
        let form = document.createElement("form");
        form.method = "POST";
        form.action = "workInsert.jsp"; // Forward data to workInsert.jsp
    
        // Collect form data
        for (let category in categories) {
            categories[category].forEach((id) => {
                let inputElement = document.getElementById(id);
                if (!inputElement) return;
                let number = parseInt(inputElement.value, 10) || 0;
    
                // Create hidden fields for each form value
                let hiddenField = document.createElement("input");
                hiddenField.type = "hidden";
                hiddenField.name = id;
                hiddenField.value = number;
                form.appendChild(hiddenField);
            });
        }
    
        // Append form to body and submit
        document.body.appendChild(form);
        form.submit(); // Submit the form ✅ Proper redirection to workInsert.jsp
}


// function submitForm() {
//     // Hide all form containers and side menu
//     document.querySelectorAll('.form-container').forEach(form => form.style.display = 'none');
//     document.querySelectorAll('.side-menu').forEach(form => form.style.display = 'none');

//     let categories = {
//         "General Work": ["classes", "prep", "reviews", "counsel"],
//         "Examination": ["invig", "correction", "viva", "external"],
//         "Membership": ["meeting", "workshop", "visit", "seminar"],
//         "Publications": ["started", "pending", "published", "patent"]
//     };

//     // let formData = {};
//     let outputText = `<h2 style="text-align: center">Your Data Submitted Successfully</h2>
//     <table border="1" style="width: 100%; border-collapse: collapse;">
//         <tr>
//             <th style="text-align: left; padding: 8px;">Category</th>
//             <th style="text-align: left; padding: 8px;">Activity</th>
//             <th style="text-align: left; padding: 8px;">Hours</th>
//         </tr>`;

//     for (let category in categories) {
//         let categoryDisplayed = false;
//         categories[category].forEach((id) => {
//             let inputElement = document.getElementById(id);
//             if (!inputElement) return;
//             let number = parseInt(inputElement.value, 10) || 0;
//             // formData[id] = number;

//             outputText += `<tr>
//                 <td style="padding: 8px;">${categoryDisplayed ? "" : category}</td> 
//                 <td style="padding: 8px;">${id.replace(/-/g, " ")}</td>
//                 <td style="padding: 8px;">${number}</td>
//             </tr>`;

//             categoryDisplayed = true;
//         });
//     }

//     outputText += `</table>
//     <button id="confirmSubmit" style="border: none;padding:1% 2%; margin:1%; background-color: #004080; cursor: pointer; color:white; float:right; border-radius: 5px;">
//         Okay
//     </button>`;

//     // Display the table
//     let outputDiv = document.getElementById("output");
//     outputDiv.innerHTML = outputText;
//     outputDiv.style.display = "block";

//     document.addEventListener("DOMContentLoaded", function() {
//         const button = document.getElementById("confirmSubmit");

//         if (button) {
//             button.addEventListener("click", function() {
//                 if (this.clicked) {
//                     let form = document.createElement("form");
//                     form.method = "POST";
//                     form.action = "workInsert.jsp";
                
//                     for (let category in categories) {
//                         categories[category].forEach((id) => {
//                             let inputElement = document.getElementById(id);
//                             if (!inputElement) return;
//                             let number = parseInt(inputElement.value, 10) || 0;
                
//                             // Create hidden fields for each form value
//                             let hiddenField = document.createElement("input");
//                             hiddenField.type = "hidden";
//                             hiddenField.name = id;
//                             hiddenField.value = number;
//                             form.appendChild(hiddenField);
//                         });
//                     }
                
//                     document.body.appendChild(form);
//                     form.submit();// Forward data to workInsert.jsp
//                 } else {
//                     console.log("Button clicked for the first time.");
//                     this.clicked = true; // Setting a property to track click
//                 }
//             });
//         } else {
//             console.error("Button not found!");
//         }
//     });
// }

// Function to forward data to workInsert.jsp after confirmation
// function forwardData(formData) {
//     let form = document.createElement("form");
//     form.method = "POST";
//     form.action = "workInsert.jsp";

//     for (let key in formData) {
//         let hiddenField = document.createElement("input");
//         hiddenField.type = "hidden";
//         hiddenField.name = key;
//         hiddenField.value = formData[key];
//         form.appendChild(hiddenField);
//     }

//     document.body.appendChild(form);
//     form.submit();
// }

// Function to navigate between tabs
function nextTab(current, next) {
    event.preventDefault();
    document.getElementById(current).style.display = 'none';
    document.getElementById(next).style.display = 'block';
    document.getElementById(next).scrollIntoView({ behavior: 'smooth', block: 'start' });

    // Remove active class from all sidebar items
    const menuItems = document.querySelectorAll('.side-menu ul li');
    menuItems.forEach(item => item.classList.remove('active-category'));

    const activeItem = Array.from(menuItems).find(item => item.getAttribute('onclick').includes(next));
    if (activeItem) {
        activeItem.classList.add('active-category');
    }
}

function prevTab(current, previous) {
    event.preventDefault();
    document.getElementById(current).style.display = 'none';
    document.getElementById(previous).style.display = 'block';
    document.getElementById(previous).scrollIntoView({ behavior: 'smooth', block: 'start' });

    // Remove active class from all sidebar items
    const menuItems = document.querySelectorAll('.side-menu ul li');
    menuItems.forEach(item => item.classList.remove('active-category'));

    const activeItem = Array.from(menuItems).find(item => item.getAttribute('onclick').includes(previous));
    if (activeItem) {
        activeItem.classList.add('active-category');
    }
}
