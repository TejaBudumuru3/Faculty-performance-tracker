<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html" %>
<%@ page errorPage="exception.jsp" %>
<%@ include file="../cache.jsp" %> 
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Home Page</title>
    <link href="../src/navbar.css" rel="stylesheet">
    <style>
        body {
            background-color: #eeeef4;
        }
        .main {
            padding: 80px 20px 20px;
        }

        .report-container {
            display: flex;
            flex-direction: column; /* Stack items vertically */
            align-items: center; /* Center items horizontally */
        }
        .report-section {
            background-color: white;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 1%;
            border-radius: 8px;
            margin: 0.5%;
            width:90%;
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
            <a href="FacultyPage.jsp">Home</a>
            <a href="workInsert.jsp">Work Update</a>
            <a href="reports.jsp">Reports</a>
            <a href="token.jsp">Notifications</a>
        </div>
        <div class="nav-right">
            <a href="profile.jsp">Profile</a>
            <button id="logout" style="background: #004080; border: none; color: inherit; cursor: pointer; font: inherit; padding: 1px 10px;">Logout</button>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main">
        
                
<%
String user = (String) session.getAttribute("userID");
String date = "";
int genericWork = 0;
int examination = 0;
int membership = 0;
int publications = 0;
 if (user == null) {
        response.sendRedirect("../index.jsp");
    } else {
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            con = (Connection) session.getAttribute("dbConnection");
            if (con == null) {
                %>
                <script type="text/javascript">
                document.addEventListener("DOMContentLoaded", function() {
                    toastr.error("Database is not connected!!!");});
                </script>
                <%
            }
            String Query = "SELECT Date, (SUM(ClassHours) + SUM(PreparationTime) + SUM(ProjectReview) + SUM(CounsellingHours)) AS GenericWork, (SUM(InvigilationHours) + SUM(ExamEvaluations) + SUM(Viva) + SUM(Externals)) AS Examination, (SUM(Meetings) + SUM(Seminars) + SUM(Workshops) + SUM(EventHours)) AS Membership, (SUM(PublicationResearchWork) + SUM(PatentResearchWork)) AS Publications FROM log WHERE facultyid = ? GROUP BY Date ORDER BY Date DESC LIMIT 0, 25;";
            stmt = con.prepareStatement(Query);
            stmt.setString(1, user);
            rs = stmt.executeQuery();

            while (rs.next()) {
                date = rs.getString("Date");
                genericWork = rs.getInt("GenericWork");
                examination = rs.getInt("Examination");
                 membership = rs.getInt("Membership");
                 publications = rs.getInt("Publications");
            
%>
<script type="text/javascript">
    console.log("<%= rs %>");
    console.log("<%= user %>");
    console.log("<%= date %>");
     console.log(<%= genericWork %>);
        console.log(<%= examination %>);
        console.log(<%= membership %>);
        console.log(<%= publications %>);
    </script>

        <div class="report-container">
            <div class="report-section">
            <h2 id="heading" onclick = toggleReport(this)>Report for <%= date%><span id="report-date"></span></h2>
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
                                <td><%= genericWork %></td>
                            </tr>
                            <tr>
                                <td>Examinations</td>
                                <td><%= examination %></td>
                            </tr>
                            <tr>
                                <td>Meetings</td>
                                <td><%= membership %></td>
                            </tr>
                            <tr>
                                <td>Publications</td>
                                <td><%= publications %></td>
                            </tr>
                        </tbody>
                    </table>
                    <%
                    }
                    %>
                </div>
            </div>
        </div>
    </div>

    <script>
        function toggleReport(element) {
            const content = element.nextElementSibling; // Get the .report-content div
            content.classList.toggle('active'); // Toggle visibility
        }

    </script>

</body>
</html>
<%
       
        }
        catch (Exception e) {
%>
            <script type="text/javascript">
                
                document.addEventListener("DOMContentLoaded", function() {
                    toastr.error("<%= e.getMessage() %>");
                });
            </script>
<%
        }
        }
%>