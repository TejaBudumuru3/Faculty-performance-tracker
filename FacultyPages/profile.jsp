<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html" %>
<%@ page errorPage="../exception.jsp" %>
<%@ include file="../cache.jsp" %> 


<%
String user = (String) session.getAttribute("userID");
int role = (int) session.getAttribute("role");
String FacultyName="";
String FacultyDesignation="";
String FacultyContact="";
String FacultyEmail="";
int FacultyExperience=0;
String Dept="";
    if (user == null) {
        response.sendRedirect("../index.jsp");
    } else {
        if(role != 1){
        %>
                <script type="text/javascript">
                document.addEventListener("DOMContentLoaded", function() {
                    toastr.error("YOU DONT HAVE ANY ACCESS TO THIS PAGE");});
                    setTimeout(() => {
                        window.location.href = "../logout.jsp";
                    }, 2000);
                </script>
                <%
            
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
            

            // Query 1: Fetch faculty details
            String facultyProfile = "SELECT f.FacultyID, f.FacultyName, d.DepartmentName, f.FacultyDesignation, f.FacultyExperience, f.FacultyContact, f.FacultyEmail From faculty f JOIN department d ON f.DepartmentID = d.DepartmentID where FacultyID=?";
            stmt = con.prepareStatement(facultyProfile);
            stmt.setString(1, user);
            rs = stmt.executeQuery();

            if (rs.next()) {
                FacultyName = rs.getString("FacultyName");
                FacultyDesignation = rs.getString("FacultyDesignation");
                FacultyContact = rs.getString("FacultyContact");
                FacultyEmail = rs.getString("FacultyEmail");
                FacultyExperience = rs.getInt("FacultyExperience");
                Dept = rs.getString("DepartmentName");
            }

            rs.close();
            stmt.close();
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
    }
%>




<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Faculty Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        .navbar {
            background-color: #004080;
            overflow: hidden;
            color: white;
            display: flex;
            justify-content: space-between;
            padding: 20px 20px;
        }
        .navbar a {
            color: white;
            text-decoration: none;
            padding: 10px;
        }
        .navbar a:hover {
            background-color: #4e2c2c;
        }
        .main {
            display: flex;
            margin: 20px;
            flex-direction: column;
            align-items: center;
        }
        .card-container {
            display: flex;
            padding-inline-start:20px;
            gap: 20px;
            margin-top: 20px;
        }
        .profile-container { 
            max-width: 800px; 
            margin: 20px auto; 
            border: 1px solid #ddd; 
            padding: 30px; 
            border-radius: 8px; 
        }
        .profile {
            text-align: center;
        }
        .profile img{
            width: 120px; 
            height: 120px; 
            border-radius: 50%;
        }
        h3 {
            justify-content: start;
            color:  #004080;
            border-bottom: 2px solid #007BFF;
            padding-bottom: 5px;
        }
        .card {
            width: 500px;
            align-content: center;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 10px;
            background-color: #f9f9f9;
            text-align: center;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
        }
        .greeting {
            padding: 20px;
            text-align: center;
            margin: 20px;
            font-size: 30px;
            font-weight: bold;
        }
        .footer {
            text-align: center;
            padding: 10px;
            background-color: #333;
            color: white;
            position: fixed;
            bottom: 0;
            width: 100%;
        }
        .scrollable-table {
            max-height: 200px;
            overflow-y: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #004080;
            color: white;
        }
    </style>

    <!-- Include toastr CSS -->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">

            <!-- Include jQuery -->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

            <!-- Include toastr JS -->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
            <script src="../src/js/scripts.js"></script>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            var FacultyName = "<%= FacultyName %>";
            var FacultyDesignation = "<%= FacultyDesignation %>";
            var FacultyContact = "<%= FacultyContact %>";
            var FacultyExperience = <%= FacultyExperience %>;
            var FacultyEmail = "<%= FacultyEmail %>";
            var Department = "<%= Dept %>";
            var FacultyID = "<%= user %>";

            document.getElementById("facultyID").innerText = "ID: " + FacultyID;
            document.getElementById("name").innerText = " " + FacultyName;
            document.getElementById("email").innerText = " " + FacultyEmail;
            document.getElementById("phone").innerText = " "+FacultyContact;
            document.getElementById("dept").innerText = " " + Department;
            document.getElementById("des").innerText = " " + FacultyDesignation;
            document.getElementById("exp").innerText = " " + FacultyExperience + " years";
        });
    </script>
</head>
<body>
    <div class="navbar">
        <div class="nav-left">
            <a href="FacultyPage.jsp">Home</a>
            <a href="workInsert.jsp">Work Update</a>
            <a href="log.jsp">Logs</a>
            <a href="token.jsp">Tasks</a>
            <a href="report.jsp"> Reports </a>
        </div>
        <div class="nav-right">
            <a href="profile.jsp">Profile</a>
            <button id="logout" style="background: #004080; border: none; color: inherit; cursor: pointer; font: inherit; padding: 1px 10px;">Logout</button>
        </div>
    </div>
    <div class="profile-container">
        <div class="profile">
            <img src="https://www.pngmart.com/files/23/Profile-PNG-Photo.png" alt="Faculty Photo">
            <h3 style="border-bottom:none;color: #004080"id="name"></h3>
            <h3 style="color: black;border-bottom:none;font-weight:normal" id="facultyID"></h3> 
        </div>
        <div class="profile-info">
            <h3>Basic Information</h3>
            <p><strong>Email:</strong> <var id="email"></var></p>
            <p><strong>Phone:</strong><var id="phone"></var></p>
            <p><strong>Department:</strong><var id="dept"></var></p>
            <p><strong>Experience:</strong><var id="exp"></var></p>
            <p><strong>Designation:</strong><var id="des"></var></p>

        </div>
        
    </div>
</body>
</html>
