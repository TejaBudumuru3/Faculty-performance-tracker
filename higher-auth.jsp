<%
String jsonData = (String) session.getAttribute("json");
session.removeAttribute("jsonData");%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Work Form</title>
    <link href="./src/navbar.css" rel="stylesheet">
    <style>
        body {
            background-color: #f4f4f9;
        }
        .side-menu {
            width: 15%;
            background-color: #004080;
            color: white;
            position: fixed;
            top: 10%;
            bottom: 0%;
            padding: 1% 0%;
            overflow-y: auto;
        }

        .side-menu ul {
            list-style: none;
            padding: 0;
        }
        .side-menu ul li {
            padding: 8% 15%;
            cursor: pointer;
            border-bottom: 1px solid #1a73e8;
        }
        .side-menu ul li:hover {
            background-color: #1a73e8;
        }

        .main-content {
            margin-left: 15%;
            padding: 80px 20px 20px;
            width: 80%;
        }

        .form-container {
            display: none;
            padding: 0% 3%;
            border-radius: 8px;
        }

        .form-group {
            margin-bottom: 1%;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 1%;
        }

        .form-group input, .form-group textarea {
            width: 97%;
            padding: 1%;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .tabs {
            margin-top: 20px;
        }
        
        .tab-content {
            
            padding: 2%;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-top: 2%;
        }
        .button-container button {
            padding: 1.5% 7%;
            border: none;
            cursor: pointer;
            color: white;
            border-radius: 5px;
            background-color: #4CAF50;
            margin: 2% 0%;
        }
        .next-btn {
            float:right;
        }
        .prev-btn:hover {
            background-color: #1a73e8;
        }
        .next-btn:hover {
            background-color: #1a73e8;
        }
        .active-category {
            background-color: white !important;
            color: #004080 !important;
            font-weight: bold;
        }
        .submit-container{
            padding:0% 10% 5% 10%;   
        }
        
    </style>
    <!-- Include toastr CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">

    <!-- Include jQuery -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

    <!-- Include toastr JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

     <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
     <script src="./src/js/scripts.js"></script>
</head>
<body>
    <!-- Navbar -->
    <div class="navbar">
        <div class="nav-left">
            <a href="higher-home.html">Home</a>
            <a href="higher-auth.html">Departments</a>
        </div>

        <div class="nav-right">
            <a href="login.html">Logout</a>
        </div>
    </div>

    <div class="side-menu">
        <ul>
            <li id="GW" onclick="showForm('generalwork')">CSE</li>
            <li id="EX" onclick="showForm('examination')">ECE</li>
            <li id="MM" onclick="showForm('membership')">EEE</li>
            <li id="PB" onclick="showForm('publications')">Mech</li>
            <!-- <li id="PB" onclick="showForm('publications')">Civil</li>
            <li id="PB" onclick="showForm('publications')">MBA</li>
            <li id="GW" onclick="showForm('generalwork')">CSD</li> -->
          </ul>
    </div>

    <div id="main" class="main-content" >
        <canvas id="myChart"></canvas>
        <div id="generalwork" class="form-container">
            <h2>Computer Science and Engineering</h2>
            <form id="myForm">
                <div class="tabs">
                    <div id="class-hours" class="tab-content">
                        <h2>Department HOD</h2>
                        <div class="form-group">
                            <label for="class-hours">Name</label>
                            <label for="class-hours">ID</label>
                        </div>    
                        <div class="form-group">
                            <label for="description-general">performance</label>
                        </div>    
                    </div>
                    
                    <div id="class-hours" class="tab-content">
                        <h2>Faculty-1</h2>
                        <div class="form-group">
                            <label for="class-hours">Name</label>
                            <label for="class-hours">Roll number</label>
                        </div>    
                        <div class="form-group">
                            <label for="description-general">performance</label>
                        </div>    
                    </div>
        
                    <div id="preparation" class="tab-content">
                        <h2>Faculty-2</h2>
                        <div class="form-group">
                            <label for="prep-time">Name</label>
                            <label for="class-hours">Roll number</label>
                        </div>
                        
                        <div class="form-group">
                            <label for="description-general">performance</label>
                        </div> 
                    </div>
        
                    <div id="review" class="tab-content">
                        <h2>Faculty-3</h2>
                        <div class="form-group">
                            <label for="review">Name</label>
                            <label for="class-hours">Roll number</label>

                        </div>
                        
                        <div class="form-group">
                            <label for="description-general">performance</label>
                        </div> 
                    </div>
        
                    <div id="Counselling" class="tab-content">
                        <h2>Faculty-4</h2>
                        <div class="form-group">
                            <label for="counselling">Name</label>
                            <label for="class-hours">Roll number</label>
                        </div>
                        
                        <div class="form-group">
                            <label for="description-general">performance</label>
                        </div> 
                    </div>
                </div>
                
            </form>
            <div class="button-container">
              <button type="button" class="next-btn" onclick="nextTab('generalwork', 'examination')">Next</button>
            </div>
        </div>

        <!-- ----------------------------------------     Examination work   ------------------------------------------------ -->

        <div id="examination" class="form-container">
            <h2>Electronics and communication Engineering</h2>
            <form id="myForm">
                <div class="tabs">
                    <div id="class-hours" class="tab-content">
                        <h2>Department HOD</h2>
                        <div class="form-group">
                            <label for="class-hours">Name</label>
                            <label for="class-hours">ID</label>
                        </div>    
                        <div class="form-group">
                            <label for="description-general">performance</label>
                        </div>    
                    </div>
                    
                    <div id="class-hours" class="tab-content">
                        <h2>Faculty-1</h2>
                        <div class="form-group">
                            <label for="class-hours">Name</label>
                            <label for="class-hours">Roll number</label>
                        </div>    
                        <div class="form-group">
                            <label for="description-general">performance</label>
                        </div>    
                    </div>
        
                    <div id="preparation" class="tab-content">
                        <h2>Faculty-2</h2>
                        <div class="form-group">
                            <label for="prep-time">Name</label>
                            <label for="class-hours">Roll number</label>
                        </div>
                        
                        <div class="form-group">
                            <label for="description-general">performance</label>
                        </div> 
                    </div>
        
                    <div id="review" class="tab-content">
                        <h2>Faculty-3</h2>
                        <div class="form-group">
                            <label for="review">Name</label>
                            <label for="class-hours">Roll number</label>

                        </div>
                        
                        <div class="form-group">
                            <label for="description-general">performance</label>
                        </div> 
                    </div>
        
                    <div id="Counselling" class="tab-content">
                        <h2>Faculty-4</h2>
                        <div class="form-group">
                            <label for="counselling">Name</label>
                            <label for="class-hours">Roll number</label>
                        </div>
                        
                        <div class="form-group">
                            <label for="description-general">performance</label>
                        </div> 
                    </div>
                </div>              
                </form>
                <div class="button-container">
                    <button type="button" class="prev-btn" onclick="prevTab('examination', 'generalwork')">Previous</button>
                    <button type="button" class="next-btn" onclick="nextTab('examination', 'membership')">Next</button>
                </div>
        </div>
        <!-- ----------------------------------------     Membership work   ------------------------------------------------ -->
        <div id="membership" class="form-container">
            <h2>Electrical and Electronics Engineering</h2>
            <form id="myForm">
                <div class="tabs">
                    <div id="class-hours" class="tab-content">
                        <h2>Department HOD</h2>
                        <div class="form-group">
                            <label for="class-hours">Name</label>
                            <label for="class-hours">ID</label>
                        </div>    
                        <div class="form-group">
                            <label for="description-general">performance</label>
                        </div>    
                    </div>
                    
                    <div id="class-hours" class="tab-content">
                        <h2>Faculty-1</h2>
                        <div class="form-group">
                            <label for="class-hours">Name</label>
                            <label for="class-hours">Roll number</label>
                        </div>    
                        <div class="form-group">
                            <label for="description-general">performance</label>
                        </div>    
                    </div>
        
                    <div id="preparation" class="tab-content">
                        <h2>Faculty-2</h2>
                        <div class="form-group">
                            <label for="prep-time">Name</label>
                            <label for="class-hours">Roll number</label>
                        </div>
                        
                        <div class="form-group">
                            <label for="description-general">performance</label>
                        </div> 
                    </div>
        
                    <div id="review" class="tab-content">
                        <h2>Faculty-3</h2>
                        <div class="form-group">
                            <label for="review">Name</label>
                            <label for="class-hours">Roll number</label>

                        </div>
                        
                        <div class="form-group">
                            <label for="description-general">performance</label>
                        </div> 
                    </div>
        
                    <div id="Counselling" class="tab-content">
                        <h2>Faculty-4</h2>
                        <div class="form-group">
                            <label for="counselling">Name</label>
                            <label for="class-hours">Roll number</label>
                        </div>
                        
                        <div class="form-group">
                            <label for="description-general">performance</label>
                        </div> 
                    </div>
                </div>              
            </form>
            <div class="button-container">
                <button type="button" class="prev-btn" onclick="prevTab('membership', 'examination')">Previous</button>
                <button type="button" class="next-btn" onclick="nextTab('membership', 'publications')">Next</button>
            </div>
        </div>

        <!-- ----------------------------------------     Publications work   ------------------------------------------------ -->

            
        <div id="publications" class="form-container">
            <h2>Mechanical Engineering</h2>
            <form id="myForm">
                <div class="tabs">
                    <div id="class-hours" class="tab-content">
                        <h2>Department HOD</h2>
                        <div class="form-group">
                            <label for="class-hours">Name</label>
                            <label for="class-hours">ID</label>
                        </div>    
                        <div class="form-group">
                            <label for="description-general">performance</label>
                        </div>    
                    </div>
                    
                    <div id="class-hours" class="tab-content">
                        <h2>Faculty-1</h2>
                        <div class="form-group">
                            <label for="class-hours">Name</label>
                            <label for="class-hours">Roll number</label>
                        </div>    
                        <div class="form-group">
                            <label for="description-general">performance</label>
                        </div>    
                    </div>
        
                    <div id="preparation" class="tab-content">
                        <h2>Faculty-2</h2>
                        <div class="form-group">
                            <label for="prep-time">Name</label>
                            <label for="class-hours">Roll number</label>
                        </div>
                        
                        <div class="form-group">
                            <label for="description-general">performance</label>
                        </div> 
                    </div>
        
                    <div id="review" class="tab-content">
                        <h2>Faculty-3</h2>
                        <div class="form-group">
                            <label for="review">Name</label>
                            <label for="class-hours">Roll number</label>

                        </div>
                        
                        <div class="form-group">
                            <label for="description-general">performance</label>
                        </div> 
                    </div>
        
                    <div id="Counselling" class="tab-content">
                        <h2>Faculty-4</h2>
                        <div class="form-group">
                            <label for="counselling">Name</label>
                            <label for="class-hours">Roll number</label>
                        </div>
                        
                        <div class="form-group">
                            <label for="description-general">performance</label>
                        </div> 
                    </div>
                </div>
            </form>
        </div>

        <div id=submitdiv class="submit-container">
            <form >
                <div id="output"></div>
            </form>
        </div>
    </div>

    

    <script src="./src/js/scripts.js"></script>
    <script>
        // Fetch the data 
            var JsonData = '<%= jsonData %>';
            var data = JSON.parse(JsonData);
                if (!data) {
                    console.error("Error: Data not found in the response");
                }
    
                // Log the fetched data for debugging
                console.log("Fetched data:", data);
    
                // Extract data for the chart
                const departmentNames = data.map(item => item.departmentNames);
                const totalLogCredits = data.map(item => item.totalLogCredits);
                const avgLogCredits = data.map(item => item.avgLogCredits);
    
                // Log the extracted data for debugging
                console.log("Department Names:", departmentNames);
                console.log("Total Log Credits:", totalLogCredits);
                console.log("Average Log Credits:", avgLogCredits);
    
                // Render the chart
                new Chart(document.getElementById("myChart"), {
                    type: "bar",   // Change to 'line', 'pie', etc., as needed
                    data: {
                        labels: departmentNames,
                        datasets: [
                            {
                                label: "Total Credits",
                                data: totalLogCredits,
                                backgroundColor: "rgba(75, 192, 192, 1)",
                                borderColor: "rgba(28, 87, 87, 0.2)",
                                borderWidth: 1
                            },
                            {
                                label: "Average Credits",
                                data: avgLogCredits,
                                backgroundColor: "rgba(192, 75, 192, 0.2)",
                                borderColor: "rgba(192, 75, 192, 1)",
                                borderWidth: 1
                            }
                        ]
                    },
                    options: {
                        responsive: true,
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });
           
    </script>
    

   
</body>
</html>
