<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html" %>
<%@ page errorPage="../exception.jsp" %>
<%@ include file="../cache.jsp" %> 





<!DOCTYPE html>
<html lang="en">
<head>
    <title>Departments</title>
    <link href="navbar.css" rel="stylesheet">
    <style>
        body {
            background-color: #f4f4f9;
        }
        .side-menu {
            width: 15%;
            background-color: #004080;
            color: white;
            position: fixed;
            top: 60px; /* Adjust this to match the navbar height */
            bottom: 0;
            padding: 1% 0;
            overflow-y: auto;
            z-index: 500; /* Lower than navbar */
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
            padding: 0% 1%;
        }

        .card {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: auto;
            padding: 2%;
            margin: 1%;
            background-color: #f9f9f9;
            text-align: left;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
        }
        .card1 {
            height: 30%;
            width: auto;
            overflow: auto;
            padding: 2%;
            margin: 1%;
            border: 1px solid #ddd;
            border-radius: 10px;
            background-color: #f9f9f9;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
        }
        h2{
            text-align: center;
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
        
    </style>
</head>
<body>
    <!-- Navbar -->
    <div class="navbar">
        <div class="nav-left">
            <a href="higher-home.html">Home</a>
            <a href="higher-auth.jsp">Departments</a>
        </div>

        <div class="nav-right">
            <a href="login.html">Logout</a>
        </div>
    </div>

    <div class="side-menu">
        <ul>
            <%
            try{
            
            Connection con = (Connection) session.getAttribute("dbConnection");
                PreparedStatement stmt = null;
                ResultSet rs = null;
                if(con!=null){

                   String TokenQuery1 = "SELECT * FROM department";
                    stmt = con.prepareStatement(TokenQuery1);
                    // stmt.setString(1, user);
                    rs = stmt.executeQuery();
                    while(rs.next()){
                        String department = rs.getString("DepartmentName");
                        // Escape special characters in the department name
                        String escapedDepartment = department.replace("'", "\\'");

                        // Print the HTML list item with proper escaping
                        out.println("<li id='" + escapedDepartment + "' onclick=\"showForm('" + escapedDepartment + "')\">" + department + "</li>");
                    }
                }

            }catch(Exception e){
                out.println(e);
            }
            %>
          </ul>
    </div>

    <div id="main" class="main-content" >
        <%-- <div id="CSE" class="form-container"> --%>
            <%
            try{
                Connection con = (Connection) session.getAttribute("dbConnection");
                PreparedStatement stmt = null;
                ResultSet rs = null;
                if(con!=null){

                   String TokenQuery1 = "SELECT * FROM department";
                    stmt = con.prepareStatement(TokenQuery1);
                    // stmt.setString(1, user);
                    rs = stmt.executeQuery();
                    while(rs.next()){
                        out.println("<div id='"+rs.getString("DepartmentName")+"' class='form-container' >");
                        out.println("<h2>"+rs.getString("DepartmentName")+"</h2>");
                        out.println("<div id='hod'>");
                        out.println("<div class='card1'>");
                        out.println("<form action='hod.jsp' method='post'>");
                        out.println("<h3 id='hodHead' class='head'>HOD</h3>");
                        out.println("<div id='name' class='card'>Name</div>");
                        out.println("<div id='roll' class='card'>Roll number</div>");
                        out.println("<div id='hours' class='card'>working hours</div>");
                        out.println("</form>");
                        out.println("</div>");
                        out.println("</div>");
                        out.println("<div id='faculty'>");
                        out.println("<div id='facultyHead' class='card1'>");
                        out.println("<h3 class='head'>Faculty-1</h3>");
                        out.println("<div id='name' class='card'>Name</div>");
                        out.println("<div id='roll' class='card'>Roll number</div>");
                        out.println("<div id='hours' class='card'>working hours</div>");
                        out.println("</div>");
                        out.println("</div>");
                        out.println("</div>");

                        
                    }
                }
            }
            catch(Exception e){
                e.printStackTrace();
            }
            %>
         

        
    </div>

    <script src="HAscript.js"></script>

   
</body>
</html>
