
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page errorPage="../exception.jsp" %>
<%@ include file="../cache.jsp" %>
<%
    // Add headers to prevent caching
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setHeader("Expires", "0"); // Proxies
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Department Reports</title>
    <link href="../src/navbar.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            overflow-x: hidden;
        }

        /* Ensure the form layout works correctly */
        /* Ensure the form layout works correctly */
form {
    display: flex;
    flex-direction: column; /* Stack items vertically */
    align-items: center; /* Center items horizontally */
    gap: 10px; /* Add spacing between items */
    width: 100%; /* Ensure the form spans the full width */
}

/* Dropdown container styling */
.dropdown-container {
    display: flex;
    flex-direction: column;
    align-items: flex-start; /* Align dropdowns to the left */
    margin: 1%;
}

/* Button container styling */
.btnContainer {
    display: flex;
    justify-content: center; /* Center the button horizontally */
    width: 100%; /* Ensure it spans the full width of its parent */
}

/* Search button styling */
.searchBtn {
    background-color: #004080;
    color: white;
    border: none;
    padding: 12px 20px;
    cursor: pointer;
    border-radius: 5px;
    transition: background-color 0.3s ease;
    font-size: 16px;
}

        /* form{
            display: flex;
            flex-direction: row;
            justify-content: space-between;
            gap: inherit;
            align-items: center
        }
        .dropdown-container {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            margin: 1%;
        } */
        .main {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 80px 20px 20px;
        }
        .filters {
            display: flex;
            gap: 3%;
            justify-content: center;
            align-items: center;
            flex-wrap: wrap;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 95%;
        }
        select {
            background-color: #f4f4f9;
            color: #004080;
            border: 2px solid #004080;
            border-radius: 8px;
            padding-left: 10px;
            font-size: 16px;
            height: 40px;
            display: flex;
            align-items: center;
            box-sizing: border-box;
            width: 200px;
            font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
        }
        label {
            font-size: 14px;
            font-weight: bold;
            margin-bottom: 5px;
            color: #004080;
        }
        /* .btnContainer{
            display: flex;
            justify-content: center; /* Center the button horizontally 
            width: 100%;
        } */
        .searchBtn {
            background-color: #004080;
            color: white;
            border: none;
            padding: 12px 20px;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s ease;
            font-size: 16px;
            /* margin-left: auto;
            margin-right: auto; */
        } 
        .searchBtn:hover {
            background-color: #2c7de8;
        }
        .report-container {
            width: 97%;
        }
        .report-section {
            display: block;
            background-color: white;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 15px;
            border-radius: 8px;
            margin: 20px;
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
    <!-- Include toastr CSS -->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">

            <!-- Include jQuery -->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

            <!-- Include toastr JS -->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
            <script src="../src/js/scripts.js"></script>
</head>
<body>
    <!-- Navbar -->
    <div class="navbar">
        <div class="nav-left">
            <a href="HAHome.jsp">Home</a>
            <a href="HADetails.jsp">Details</a>
            <a href="HAReports.jsp">Reports</a>
        </div>
        <div class="nav-right">
            <a href="HAProfile.jsp">Profile</a>
            <button id="logout" style="background: #004080; border: none; color: inherit; cursor: pointer; font: inherit; padding: 1px 10px;">Logout</button>
        </div>
    </div>
    
    <!-- Main Content -->
    <div class="main">
        <h1>Generate Department Reports</h1>
        <form method="POST" action="" class="form">
            <div class="filters">
                <div class="dropdown-container">
                    <label for="faculty">Select Department:</label>
                    <select id="faculty" name="faculty" required>
                        <option value="">Select Department</option>
                        <%
                            Connection con = null;
                            PreparedStatement reportStmt = null;
                            ResultSet reportRs = null;
                            try {
                                con = (Connection) session.getAttribute("dbConnection");
                                int departmentId = (int) session.getAttribute("departmentId");
                                int roleId = (int) session.getAttribute("role");
                               
                                if (con == null) {
                                    %>
                                    <script type="text/javascript">
                                        document.addEventListener("DOMContentLoaded", function() {
                                            toastr.error("Database is not connected!!!");
                                            setTimeout(()=>{window.location.href = "../logout.jsp";}, 3000);
                                        });
                                    </script>
                                    <%
                                } 
                                    if(roleId!=4){
                                        %>
                                        <script>
                                        document.addEventListener("DOMContentLoaded", function() {
                                            toastr.error("You are not authorized to view this page!!!");
                                            setTimeout(()=>{window.location.href = "../logout.jsp";}, 3000);
                                        });
                                        </script>
                                        <%
                                    }
                                    
                                        //Query for Faculty list
                                            String sql = "SELECT DepartmentName FROM Department;";
                                            reportStmt = con.prepareStatement(sql);
                                            reportRs = reportStmt.executeQuery();
                                            if(reportRs.isBeforeFirst()){
                                                while(reportRs.next()){
                                                    out.println("<option value='"+reportRs.getString("DepartmentName")+"'>"+reportRs.getString("DepartmentName")+"</option>"); 
                                                }   
                                            }
                                            else{
                                                out.println("<option value=''>No Department Found</option>");
                                            }
                                            %>
                                        </select>
                                    </div>
                                    <div class="dropdown-container">
                                        <label for="year">Year</label>
                                        <select id="year" name="year" required>
                                            <option value="">Select Year</option>
                                            <%
                                            //Query for year list
                                            String sql2 = "SELECT max(YEAR(Date)) as maxy, min(YEAR(Date)) as miny FROM log";
                                            reportStmt = con.prepareStatement(sql2);
                                            reportRs = reportStmt.executeQuery();

                                            if (reportRs.next()) {
                                                String maxYearStr = reportRs.getString("maxy"); // Get as String
                                                String minYearStr = reportRs.getString("miny");
                                            
                                                if (maxYearStr != null && minYearStr != null) { // Ensure they're not NULL
                                                    int maxYear = Integer.parseInt(maxYearStr); // Convert to int
                                                    int minYear = Integer.parseInt(minYearStr);
                                            
                                                    for (int i = minYear; i <= maxYear; i++) {
                                                        out.println("<option value='" + i + "'>" + i + "</option>"); 
                                                    }
                                                } else {
                                                    out.println("<option value=''>No Valid Years Found in Database</option>");
                                                }
                                            } else {
                                                out.println("<option value=''>No Valid Years Found in Database</option>");
                                            }
                                
                            } catch (Exception e) {
                                out.println("<p>An error occurred: " + e + "</p>");
                            }
                        %>

                    </select>
                </div>
                <div class="dropdown-container">
                    <label for="month">Month</label>
                    <select id="month" name="month" required>
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
                    <select id="week" name="week" required>
                        <option value="">Select Week</option>
                        <option value="1">Week 1 (01 - 07)</option>
                        <option value="2">Week 2 (08 - 14)</option>
                        <option value="3">Week 3 (15 - 21)</option>
                        <option value="4">Week 4 (22 - 28)</option>
                        <option value="5">Week 5 (29 - 31)</option>
                        <option value="6">Total Month</option>
                    </select>
                </div>
                <div class="btnContainer">
                <button type="submit" class="searchBtn" id="searchBtn" name="action" value="clicked"> Search</button>
                </div>
            </div>
        </form>

        <!-- Report Container -->
        <div class="report-container">
            <%
                
                String button = request.getParameter("action");
                if ("clicked".equals(button)){
                    %>
                    <script>
                    console.log("clicked");
                    </script>
                    <%
                    try {
                        // Database connection
                    
                        con = (Connection) session.getAttribute("dbConnection");
                        // Get form parameters
                        String faculty = request.getParameter("faculty");
                        String year = request.getParameter("year");
                        String month = request.getParameter("month");
                        String week = request.getParameter("week");
                        int from=0;
                        int to=0;
                        

                        if (faculty != null && year != null && month != null && week != null) {
                            if(Integer.parseInt(week) == 1){
                                from = 1;
                                to = 7;
                            }
                            else if(Integer.parseInt(week) == 2){
                                from = 8;
                                to = 14;
                            }
                            else if(Integer.parseInt(week) == 3){
                                from = 15;
                                to = 21;
                            }
                            else if(Integer.parseInt(week) == 4){
                                from = 22;
                                to = 28;
                            }
                            else if(Integer.parseInt(week) == 5) {
                                from = 29;
                                to = 31;
                            }
                            else{
                                from = 1;
                                to = 31;
                            }
                            

                                // SQL query
                                String ReportQuery = "SELECT SUM(l.ClassHours + l.PreparationTime + l.ProjectReview + l.CounsellingHours) AS GenericWork, SUM(l.InvigilationHours + l.ExamEvaluations + l.Viva + l.Externals) AS Examination, SUM(l.Meetings + l.Seminars + l.Workshops + l.EventHours) AS Membership, SUM(l.PublicationResearchWork + l.PatentResearchWork) AS Publications, SUM(l.PublicationsPublished) AS PublicationsPublished, SUM(l.PatentsGained) AS PatentsGained FROM faculty f JOIN log l ON f.facultyid = l.facultyid WHERE f.departmentid = (select DepartmentID from department where departmentname = ?) AND YEAR(l.Date) = ? AND MONTH(l.Date) = ? AND Day(l.Date) between ? and ?";

                                reportStmt = con.prepareStatement(ReportQuery);
                                reportStmt.setString(1, faculty);
                                reportStmt.setInt(2, Integer.parseInt(year));
                                reportStmt.setInt(3, Integer.parseInt(month));
                                reportStmt.setInt(4, from);
                                reportStmt.setInt(5, to);

                                reportRs = reportStmt.executeQuery();
                                String date = from + "/" + month + "/" + year + " - " + to + "/" + month + "/" + year;

                                if (!reportRs.isBeforeFirst()) {
                                    out.println("<p>No reports available for the selected criteria.</p>");
                                } else {
                                
                                while (reportRs.next()) {
                                    int genericWork = reportRs.getInt("GenericWork");
                                    boolean isgenericWorkNull = reportRs.wasNull();
                                    int examination = reportRs.getInt("Examination");
                                    boolean isexaminationNull = reportRs.wasNull();
                                    int membership = reportRs.getInt("Membership");
                                    boolean ismembershipNull = reportRs.wasNull();
                                    int publications = reportRs.getInt("Publications");
                                    boolean ispublicationsNull = reportRs.wasNull();
                                    int publicationsPublished = reportRs.getInt("PublicationsPublished");
                                    boolean ispublicationsPublishedNull = reportRs.wasNull();
                                    int patentsGained = reportRs.getInt("PatentsGained");
                                    boolean ispatentsGainedNull = reportRs.wasNull();
                                        
                                    if (!isgenericWorkNull && !isexaminationNull && !ismembershipNull && !ispublicationsNull && !ispublicationsPublishedNull && !ispatentsGainedNull) {
                                        
                                        out.println("<div class='report-section' style='display: block;'>");
                                        out.println("<p style='font-size:20px'>Report for Department: " + faculty + " between <strong>"+date+"</strong></p>");
                                        out.println("<table class='report-table'>");
                                        out.println("<tr><th>Category</th><th>Hours</th></tr>");
                                        out.println("<tr><td>General Work</td><td>" + genericWork + "</td></tr>");
                                        out.println("<tr><td>Examinations</td><td>" + examination + "</td></tr>");
                                        out.println("<tr><td>Meetings</td><td>" + membership + "</td></tr>");
                                        out.println("<tr><td>Publications</td><td>" + publications + "</td></tr>");
                                        out.println("<tr><td>Publications Published</td><td>" + publicationsPublished + "</td></tr>");
                                        out.println("<tr><td>Patents Gained</td><td>" + patentsGained + "</td></tr>");
                                        out.println("</table>");
                                        out.println("</div>");
                                    }
                                    else {
                                        out.println("<p>No reports available for the selected criteria.</p>");
                                    }
                                }
                            }
                        } 
                    } 
                    catch (Exception e) {
                        out.println("<p>An error occurred: " + e.getMessage() + "</p>");
                        } 
                }else{
                    out.println("<div class='report-section' style='display: none;'>");
                    }
            %>
        </div>
        </div>
    </div>
</body>
</html>