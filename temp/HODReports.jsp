<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html" %>
<%@ page errorPage="../exception.jsp" %>
<%@ include file="../cache.jsp" %> 
<%

String user = (String) session.getAttribute("userID");
int role = (int) session.getAttribute("role");
int departmentId = (int) session.getAttribute("departmentId");
if (user == null) {
    response.sendRedirect("../index.jsp");
}
else{
    if(role!=3){
        %>
            <script type="text/javascript">
            document.addEventListener("DOMContentLoaded", function() {
                toastr.error("YOU DONT HAVE ANY ACCESS TO THIS PAGE");});
                setTimeout(() => {
                    window.location.href = "../logout.jsp";
                }, 2000);
            </script>
            <%   
    }
    else{
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            con = (Connection) session.getAttribute("dbConnection");
            if (con == null) {
                %>
                <script type="text/javascript">
                    document.addEventListener("DOMContentLoaded", function() {
                        toastr.error("Database is not connected!!!");
                    });
                </script>
                <%
            } else {
                //Query for Faculty list
                String sql = "SELECT FacultyID, FacultyName FROM faculty where DepartmentID = ?";
                stmt = con.prepareStatement(sql);
                stmt.setInt(1, departmentId);
                rs = stmt.executeQuery();
                if(rs.next()){
                    %>
                


<!DOCTYPE html>
<html lang="en">
<head>
    <title>Home Page</title>
    <%-- <link href="navbar.css" rel="stylesheet"> --%>
    <link href="../src/navbar.css" rel="stylesheet">
    <!-- jQuery & Select2 Library -->
    <!-- Include toastr CSS -->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">

            <!-- Include jQuery -->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

            <!-- Include toastr JS -->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
            <script src="../src/js/scripts.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            overflow-x: hidden; /* Prevents unwanted scrolling */
        }

        .main {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 80px 20px 20px;
        }

        .filters {
            display: flex;
            gap: 3%; /* Space between dropdowns */
            justify-content: center;
            align-items: center;
            flex-wrap: wrap;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width:95%;
        }

        /* Change the background and text color */
        .select2-container .select2-selection--single {
            background-color: #f4f4f9;
            color: #004080;
            border: 2px solid #004080;
            border-radius: 8px;
            padding: 20px;
            font-size: 16px;

            height: 40px !important;  /* Adjust height */
            display: flex !important;
            align-items: center !important;  /* Center text vertically */
        }

        /* Change the dropdown arrow */
        .select2-container--default .select2-selection--single .select2-selection__arrow b {
            border-color: #004080 transparent transparent transparent !important;
        }

        /* Change the dropdown list style */
        .select2-container--default .select2-results__option {
            color: #004080;
            background: white;
            padding: 10px;
            font-size: 16px;
        }

        /* Highlight hovered option */
        .select2-container--default .select2-results__option--highlighted {
            background-color: #004080 !important;
            color: white !important;
        }

        /* Adjust width */
        .select2-container {
            width: 200px !important;
            font-family:'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
        }



        .dropdown-container {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        label {
            font-size: 14px;
            font-weight: bold;
            margin-bottom: 5px;
            color: #004080;
        }

        .searchBtn {
            background-color: #004080;
            color: white;
            border: none;
            padding: 12px 20px;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s ease;
            font-size: 16px;
            margin-top: 23%;
        }
        .searchBtn:hover {
            background-color: #2c7de8;
        }

        .report-container {
            width:97%;
        }
        .report-section {
            background-color: white;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 15px;
            border-radius: 8px;
            margin: 20px;
        }
        .report-section h2 {
            text-align: center;
            color: #004080;
            cursor: pointer;
        }
        .report-content {
            display: none;
            margin-top: 20px;
        }
        .report-content.active {
            display: block;
        }
        .report-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .report-table th, .report-table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }
        .report-table th {
            background-color: #004080;
            color: white;
        }
        .report-table tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .report-table tr:hover {
            background-color: #f1f1f1;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <div class="navbar">
        <div class="nav-left">
            <a href="HOD-Home.html">Home</a>
            <a href="HOD-reports.html">Faculty</a>
            <a href="HOD-token.html">Tasks</a>
        </div>
        <div class="nav-right">
            <a href="HOD-profile.html">Profile</a>
            <a href="login.html">Logout</a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main">
        <div class="filters">
            <div class="dropdown-container">
                <label for="faculty">Faculty</label>
                <select id="faculty">
                    <option value="">Select Faculty</option>
                    <%while(rs.next()){ %>
                        <option value="<%=rs.getString("FacultyID")%>"><%=rs.getString("FacultyName")%></option>
                    <% } %>
                </select>
            </div>

            <div class="dropdown-container">
                <label for="year">Year</label>
                <select id="year">
                    <option value="">Select Year</option>
                    <option value="2025">2025</option>
                    <option value="2024">2024</option>
                    <option value="2023">2023</option>
                </select>
            </div>

            <div class="dropdown-container">
                <label for="month">Month</label>
                <select id="month">
                    <option value="">Select Month</option>
                    <option value="1">January</option>
                    <option value="2">February</option>
                    <option value="3">March</option>
                    <option value="4">April</option>
                    <option value="5">May</option>
                    <option value="6">June</option>
                    <option value="7">July</option>
                    <option value="8">August</option>
                    <option value="9">September</option>
                    <option value="10">October</option>
                    <option value="11">November</option>
                    <option value="12">December</option>
                </select>
            </div>

            <div class="dropdown-container">
                <label for="week">Week</label>
                <select id="week">
                    <option value="">Select Week</option>
                    <option value="1">Week 1</option>
                    <option value="2">Week 2</option>
                    <option value="3">Week 3</option>
                    <option value="4">Week 4</option>
                </select>
            </div>

             <%
             int from = 0;
            int to = 0;
            int year=0;
            int month=0;
            int week=0;
            if ("POST".equalsIgnoreCase(request.getMethod())) {

            String userStr = request.getParameter("faculty");
            String yearStr = request.getParameter("year");
            String monthStr = request.getParameter("month");
            String weekStr = request.getParameter("week");

            if(!userStr.equals("") && !yearStr.equals("") && !monthStr.equals("") && !weekStr.equals("")){
                 year = Integer.parseInt(yearStr);
                 month = Integer.parseInt(monthStr);
                 week = Integer.parseInt(weekStr);
            

            if(week == 1){
                from = 1;
                to = 7;
            }
            else if(week == 2){
                from = 8;
                to = 14;
            }
            else if(week == 3){
                from = 15;
                to = 21;
            }
            else if(week == 4){
                from = 22;
                to = 31;
            }
            else{
                from = 1;
                to = 31;
            }
            //Query for reports
            String ReportQuery="SELECT COALESCE(SUM(l.ClassHours + l.PreparationTime + l.ProjectReview + l.CounsellingHours), 0) AS GenericWork, COALESCE(SUM(l.InvigilationHours + l.ExamEvaluations + l.Viva + l.Externals), 0) AS Examination, COALESCE(SUM(l.Meetings + l.Seminars + l.Workshops + l.EventHours), 0) AS Membership, COALESCE(SUM(l.PublicationResearchWork + l.PatentResearchWork), 0) AS Publications, COALESCE(SUM(l.PublicationsPublished), 0) AS PublicationsPublished, COALESCE(SUM(l.PatentsGained), 0) AS PatentsGained FROM FACULTY f LEFT JOIN log l ON f.facultyid = l.facultyid WHERE f.facultyid = ? AND YEAR(l.LogDate) = ? AND MONTH(l.LogDate) = ? AND DAY(l.LogDate) BETWEEN ? AND ?";
            stmt = con.prepareStatement(ReportQuery);
            stmt.setString(1, user);
            stmt.setInt(2, year);
            stmt.setInt(3, month);
            stmt.setInt(4, from);
            stmt.setInt(5, to);
            rs = stmt.executeQuery();
            %>
            <script>
            console.log(rs.getInt("GenericWork"));
            </script>
            <%
            if(rs.next()){
                %>
                <script>
                console.log("<%=user%>");
                console.log(<%=year%>);
                console.log(<%=month%>);
                console.log(<%=week%>);
                console.log(<%=from%>);
                console.log(<%=to%>);

                console.log(rs.getInt("GenericWork"));
                console.log(rs.getInt("Examination"));
                console.log(rs.getInt("Membership"));
                console.log(rs.getInt("Publications"));
                console.log(rs.getInt("PublicationsPublished"));
                console.log(rs.getInt("PatentsGained"));

                </script>
                <%
                }
                }
                }
                }
            }
        } catch (Exception e) {
            %>
            <script type="text/javascript">
            
                document.addEventListener("DOMContentLoaded", function() {
                    toastr.error("<%= e %>");
                });
            </script>
            <%
        }
    }
}
%>
            %>
            <div >
                <button class="searchBtn" onclick="searching()">Search</button>
            </div>
        </div>

        <div class="report-container">
            <div class="report-section">
                <h2 id="heading" onclick = toggleReport(this)>Report for week <span id="report-date"></span></h2>
                <div class="report-content">
                    <table class="report-table">
                        <thead>
                            <tr>
                                <th>Category</th>
                                <th>Details</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>General Work</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Examinations</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Meetings</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Publications</td>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>

    <script>
        function toggleReport(element) {
            const content = element.nextElementSibling; // Get the .report-content div
            content.classList.toggle('active'); // Toggle visibility
        }

        function searching() {
            // Get selected values
            

            window.location.href = "./HODReports.jsp";
        }


        // for search bar in dropdown by external library
        <%-- $(document).ready(function() {
            $('#faculty, #year, #month, #week').select2({
                placeholder: "Select an option",
                allowClear: true,
                dropdownParent: $(document.body) // Ensures dropdown isn't clipped
            });
        }); --%>


    </script>
        
    
</body>
</html>



