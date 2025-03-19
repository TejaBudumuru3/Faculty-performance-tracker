<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html" %>
<%@ page errorPage="../exception.jsp" %>
<%@ include file="../cache.jsp" %>  

<%
String user = (String) session.getAttribute("userID");
int role = (int) session.getAttribute("role");
String FacultyName = "";
String FacultyDesignation = "";
String FacultyContact = "";
String FacultyEmail = "";
int FacultyExperience = 0;
String Dept = "";

Connection con = null;
PreparedStatement stmt = null;
ResultSet rs = null;

if (user == null) {
    response.sendRedirect("../index.jsp");
} else {
    if (role != 3) {
%>
        <script type="text/javascript">
            document.addEventListener("DOMContentLoaded", function () {
                toastr.error("YOU DON'T HAVE ACCESS TO THIS PAGE");
                setTimeout(() => {
                    window.location.href = "../logout.jsp";
                }, 2000);
            });
        </script>
<%
    } else {
        try {
            con = (Connection) session.getAttribute("dbConnection");
            if (con == null) {
%>
                <script type="text/javascript">
                    document.addEventListener("DOMContentLoaded", function () {
                        toastr.error("Database is not connected!!!");
                    });
                </script>
<%
            }

            // Fetch Faculty Details
            String facultyProfile = "SELECT f.FacultyID, f.FacultyName, d.DepartmentName, f.FacultyDesignation, f.FacultyExperience, f.FacultyContact, f.FacultyEmail FROM faculty f JOIN department d ON f.DepartmentID = d.DepartmentID WHERE FacultyID=?";
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

        } catch (Exception e) {
%>
            <script type="text/javascript">
                document.addEventListener("DOMContentLoaded", function () {
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
    <title>Profile & Update Password</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
    <script src="../src/js/scripts.js"></script>

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

        .form-container {
            width: 60%;
            display:none;
            background: white;
            padding: 5%;
            border-radius: 8px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            margin-left: auto;
            margin-right: auto;
            margin-top: 5%;
        }
        select{
            flex: 4;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
            border-color: #333;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }

        .input-group {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }

        label {
            flex: 1;
            font-weight: bold;
            color: #333;
            text-align: left;
            margin-right: 10px;
        }

        input {
            flex: 4;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
            border-color: #333;
        }

        .submit-div{
            text-align: center;
        }
        .submit-btn {
            width: 20%;
            background: #22438c;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s;
        }

        .submit-btn:hover {
            background: #112c66;
        }
    </style>


    <script>
        document.addEventListener("DOMContentLoaded", function () {
            document.getElementById("facultyID").innerText = "ID: " + "<%=user%>";
            document.getElementById("name").innerText = " " + "<%=FacultyName%>";
            document.getElementById("change").addEventListener("click", function () {
                document.getElementById("profile").style.display = "none";
                document.getElementById("updatePass").style.display = "block";

            });
        });
    </script>
</head>

<body>
    <div class="navbar">
        <div class="nav-left">
            <a href="HODHome.jsp">Home</a>
            <a href="HODToken.jsp">Tasks</a>
            <a href="HODReports.jsp">Reports</a>
        </div>
        <div class="nav-right">
            <a href="HODProfile.jsp">Profile</a>
            <button id="logout" style="background: #004080; border: none; color: inherit; cursor: pointer; font: inherit; padding: 1px 10px;">Logout</button>
        </div>
    </div>
    <!-- Profile Section -->
    <div class="profile-container" id="profile">
        <div class="profile">
            <img src="https://www.pngmart.com/files/23/Profile-PNG-Photo.png" alt="Faculty Photo">
            <h3 style="border-bottom:none;color: #004080"id="name"></h3>
            <h3 style="color: black;border-bottom:none;font-weight:normal" id="facultyID"></h3> 
        </div>
        <div class="profile-info">
            <h3>Faculty Profile</h3>
            <p><strong>Email:</strong> <%= FacultyEmail %></p>
            <p><strong>Phone:</strong> <%= FacultyContact %></p>
            <p><strong>Department:</strong> <%= Dept %></p>
            <p><strong>Designation:</strong> <%= FacultyDesignation %></p>
            <p><strong>Experience:</strong> <%= FacultyExperience %> years</p>
            <button id="change" class="btn btn-danger">Update Password</button>
        </div>
    </div>

    <!-- Password Update Form -->
    <div class="form-container" id="updatePass">
        <h2>Update Password</h2>
        <form method="post" style="display: flex;flex-direction: column;flex-wrap: wrap;">
            <label>Old Password:</label>
            <input type="password" name="oldPassword" required>
            <label>New Password:</label>
            <input type="password" name="NewPassword" required>
            <label>Re-enter Password:</label>
            <input type="password" name="RenterPassword" required>
            <button type="submit" style="margin: auto;margin-top: 2%;" class="btn btn-primary" name="pass" value="change">Change Password</button>
        </form>
    </div>
</body>
</html>

<%
if ("change".equals(request.getParameter("pass"))) {
    String oldPassword = request.getParameter("oldPassword");
    String newPassword = request.getParameter("NewPassword");
    String retypePassword = request.getParameter("RenterPassword");

    try {
        if (newPassword.equals(retypePassword)) {
            String passQuery = "SELECT * FROM credentials WHERE FacultyID = ? AND FacultyPassword = ? AND RoleID=?";
            stmt = con.prepareStatement(passQuery);
            stmt.setString(1, user);
            stmt.setString(2, oldPassword);
            stmt.setInt(3, role);
            rs = stmt.executeQuery();

            if (rs.next()) {
                String updateQuery = "UPDATE credentials SET FacultyPassword = ? WHERE FacultyID = ? AND RoleID=?";
                stmt = con.prepareStatement(updateQuery);
                stmt.setString(1, newPassword);
                stmt.setString(2, user);
                stmt.setInt(3, role);
                int res = stmt.executeUpdate();

                if (res > 0) {
                    out.println("<script>toastr.success('Password updated successfully!');</script>");
                } else {
                    out.println("<script>toastr.error('Password update failed!');</script>");
                }
            } else {
                out.println("<script>toastr.error('Invalid old password!');</script>");
            }
        } else {
            out.println("<script>toastr.error('Password mismatch!');</script>");
        }
    } catch (Exception e) {
        out.println("<script>toastr.error('Error: " + e.getMessage() + "');</script>");
    }
}
%>
