<%@ page import="java.sql.*" %>
<%@ page import="java.sql.Date" %>
<%@ page language="java" contentType="text/html" %>
<%@ page errorPage="../exception.jsp" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.util.*" %>
<%@ include file="../cache.jsp" %> 

<%
    Connection con = (Connection) session.getAttribute("dbConnection");
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
    String button = request.getParameter("Button");
    out.println("<script>console.log('"+button+"');</script>");
    if(button != null && button.equals("assign")){

        String facultyID = request.getParameter("FacultyID");
        String taskTitle = request.getParameter("taskTitle");
        LocalDate currentDate = LocalDate.now();
        Date formattedDate = Date.valueOf(currentDate);

        out.println("<script>console.log('"+facultyID+"');</script>");
        out.println("<script>console.log('"+taskTitle+"');</script>");

        try {
            String insertSQL = "INSERT INTO token (FacultyID, Task, Date, Status) VALUES (?, ?, ?, 0)";
            PreparedStatement stmt = con.prepareStatement(insertSQL);
            stmt.setString(1, facultyID);
            stmt.setString(2, taskTitle);
            stmt.setDate(3, formattedDate);

            int rowsInserted = stmt.executeUpdate();
            stmt.close();

            if (rowsInserted > 0) {
                    %>
                    <script type="text/javascript">
                        document.addEventListener("DOMContentLoaded", function() {
                        document.getElementById("assignForm").reset();
                        toastr.success("Token assigned successfully");});
                    </script>
                <% 
            } else {
                %>
                    <script type="text/javascript">
                        document.addEventListener("DOMContentLoaded", function() {
                        document.getElementById("assignForm").reset();
                        toastr.error("Token failed to assign");});
                    </script>
                <%
            }
        }
        catch (Exception e) {
            %>
                <script type="text/javascript">
                    document.addEventListener("DOMContentLoaded", function() {
                    document.getElementById("assignForm").reset();
                    toastr.error("<%= e.getMessage()%>");});
                </script>
            <%           
        }
        
    }else{
        out.println("<script>console.log('"+button+"');</script>");
    }
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Departments</title>
    <link href="../src/navbar.css" rel="stylesheet">
    
    <script src="./HODscript.js"></script> 
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

        label {
            font-size: 16px;
            font-weight: bold;
            margin: 1%;
            color: #004080;
            margin-bottom: 5%;

        }
        /* Change the background and text color */
        .select2-container .select2-selection--single {
            background-color: #f4f4f9;
            color: #004080;
            border: 2px solid #5c6064;
            border-radius: 8px;
            padding: 10px;
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

        .dropdown-container{
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            flex-direction: row;
        }
        /* Adjust width */
        .select2-container {
            width: 50% !important;
            margin:0% 5%;
            font-family:'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
        }
        select{
            flex: 4;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
            border-color: #333;
            margin-bottom: 10px;
        }
        .card { 
            display: flex; 
            justify-content: space-between; 
            align-items: center; width:auto; 
            padding: 10px; margin: 10px; 
            background-color: #f9f9f9; 
            text-align: left; 
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1); 
        }
        .card0 {
            display: flex;
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
        .card2 {
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
        .card textarea, .card0 textarea{
            flex:1;
            width: 97%;
            max-width: 97%;
            padding: 1%;
            margin:1%;
            border: 1px solid #5c6064;
            border-radius: 5px;
            font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
        }
        .assignBtn{
            text-align: center;
        }
        .searchBtn {
            background-color: #004080;
            color: white;
            border: none;
            padding: 12px 20px;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s ease;
            font-size: 14px;
        }
        .searchBtn:hover {
            background-color: #2c7de8;
        }
        .dashboard {
            display: flex;
            justify-content: space-between;
            gap: 20px;
            flex-wrap: nowrap;
        }
        .btns {
            background-color: white;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
            border-radius: 8px;
            text-align: center;
            cursor: pointer;
            transition: transform 0.2s ease-in-out;
            flex: 1;
            max-width: 24%;
        }
        .btns:hover {
            transform: scale(1.05);
            background-color: #e8f0fe;
        }
        .card1.active {
            display: block;
        } 
        .active-category {
            background-color: white !important;
            color: #004080 !important;
            font-weight: bold;
        }     
        .card-container { 
            padding-inline-start:10px; 
            gap: 20px; 
            margin: 10px; 
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
                <a href="HODHome.jsp">Home</a>
                <a href="HODReports.jsp">Faculty</a> 
                <a href="HODToken.jsp">Tasks</a>
            </div>
            <div class="nav-right">
                <a href="HODProfile.jsp">Profile</a>
                <button id="logout" style="background: #004080; border: none; color: inherit; cursor: pointer; font: inherit; padding: 1px 10px;">Logout</button>
            </div>
        </div>
    
        <div class="side-menu">
            <ul>
                <li id="assign" onclick="showForm('Assign')">Assign Task</li>
                <li id="status" onclick="showForm('Status')">Task Status</li>
            </ul>
        </div>

        <div id="main" class="main-content" >
            <div id="Assign" class="form-container">
                <h2>Assign Task to Faculty</h2>
                <form class="card2" method="post" action="" id="assignForm" style="height:40%">
                    <div id="name" class="card">
                        <div class="dropdown-container">
                            <label for="faculty">Faculty Name:</label>
                            <select id="faculty" data-placeholder="Select or Search Faculty" required name="FacultyID">
                                <option value="">Select Faculty</option>
                                    <%
                                    //Connection con = null;
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
                                                    toastr.error("Database session expired!!!");
                                                setTimeout(()=>{window.location.href = "../logout.jsp";}, 3000);
                                            });
                                            </script>
                                    <%
                                        } 
                                        if(roleId!=3){
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
                                        String sql = "SELECT FacultyID, FacultyName FROM faculty where DepartmentID = ?";
                                        reportStmt = con.prepareStatement(sql);
                                        reportStmt.setInt(1, departmentId);
                                        reportRs = reportStmt.executeQuery();
                                        if(reportRs.isBeforeFirst()){
                                            while(reportRs.next()){
                                                out.println("<option value='"+reportRs.getString("FacultyID")+"'>"+reportRs.getString("FacultyName")+"</option>"); 
                                            }   
                                        }
                                        else{
                                            out.println("<option value=''>No Faculty Found</option>");
                                        }
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
                                    %>
                            </select>
                        </div>
                    </div>
                    <div id="title" class="card0">
                        <label for="faculty">Enter Task: </label>
                        <textarea id="taskTitle" rows="2" placeholder="Title" required name="taskTitle"></textarea>
                    </div>
                    <div class="assignBtn">
                        <button class="searchBtn" type="submit"  name="Button" value="assign">Search</button>
                    </div>
                </form>
                <script>
                    function assignTask() {
                        let faculty = document.getElementById('faculty').value;
                        let title = document.getElementById('taskTitle').value.trim();
            
                        if (!faculty || !title) {
                            toastr.warning("Please fill all fields before assigning the task!");
                            return;
                        }
            
                        let confirmation = confirm("Are you sure you want to assign this task?");
                        if (confirmation) {
                            $.ajax({
                                type: "POST",
                                url: "HOD-token.jsp",
                                data: { facultyID: faculty, taskTitle: title },
                                success: function (response) {
                                    if (response.trim() === "success") {
                                        toastr.success("Task assigned successfully!");
                                        document.getElementById('faculty').value = "";
                                        document.getElementById('taskTitle').value = "";
                                    } else {
                                        toastr.error("Failed to assign task. Please try again.");
                                    }
                                },
                                error: function () {
                                    toastr.error("Error occurred while assigning task.");
                                }
                            });
                        }
                    }
                </script>

            </div>

            <div id="Status" class="form-container">
            
                <%
                    String user = (String) session.getAttribute("userID");
                    int role = (int) session.getAttribute("role");
                    if (user == null) {
                        response.sendRedirect("../index.jsp");
                    } 
                    else {
                        if(role != 3){
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
                        else {
                            //Connection con = null;
                            PreparedStatement stmt = null;
                            ResultSet rs1 = null;
                            ResultSet rs = null;

                            try {
                                con = (Connection) session.getAttribute("dbConnection");
                                int departmentId = (int) session.getAttribute("departmentId");
                                if (con != null) {
                    
                                    String TokenQuery1 = "select f.facultyname, t.date, t.task from faculty f join token t on f.facultyid = t.facultyid where f.departmentid = ? and t.status = 0";
                                    stmt = con.prepareStatement(TokenQuery1);
                                    stmt.setInt(1, departmentId);
                                    rs = stmt.executeQuery();
                                    %>
                                    <div class="card-container">
                                        <div class="card1">
                                            <div class="card" style="justify-content: space-around">
                                                <h3>REQUESTED TOKENS</h3>
                                            </div>
                                            <%
                                            if(!rs.isBeforeFirst()){
                                            %> 
                                                <div class="card">
                                                    <p> No Tokens avaliable </p>
                                                </div>
                                       
                                            <%
                                            }

                                            while (rs.next()) {
                                                String taskFaculty = rs.getString("FacultyName");
                                                String taskName = rs.getString("Task");
                                                Date taskDate = rs.getDate("Date");
                                    
                                            %>
                                                <div class="card">
                                                    <p> <%= taskFaculty %> </p>
                                                    <p> <%= taskName %> </p>
                                                    <p> <%= taskDate %> </p>
                                                </div>
                                            <% 
                                            } 
                                                %>
                                        </div>
                                            <%  
                            
                                        String TokenQuery2 = "select f.facultyname, t.date, t.task from faculty f join token t on f.facultyid = t.facultyid where f.departmentid = ? and t.status = 1";
                                        stmt = con.prepareStatement(TokenQuery2);
                                        stmt.setInt(1, departmentId);
                                        rs = stmt.executeQuery();
                                            %>
                                        <div class="card1">
                                            <div class="card" style="justify-content: space-around">
                                                <h3>ACCEPTED TOKENS</h3>
                                            </div>

                                                <%
                                            if(!rs.isBeforeFirst()){
                                            %> 
                                                <div class="card">
                                                    <p> No Tokens avaliable  </p>
                                                </div>
                                            <%
                                            }
                                            else{
                                                while (rs.next()) {
                                                    String taskFaculty = rs.getString("FacultyName");
                                                    String taskName = rs.getString("Task");
                                                    Date taskDate = rs.getDate("Date");
                                            
                                                %>
                                                    <div class="card">
                                                        <p> <%= taskFaculty %> </p>
                                                        <p> <%= taskName %> </p>
                                                        <p> <%= taskDate %> </p>
                                                    </div>
                                                <%      
                                                }
                                            } 
                                            %>
                                        </div>
                                            <%  
                            
                                        String TokenQuery3 = "select f.facultyname, t.date, t.task from faculty f join token t on f.facultyid = t.facultyid where f.departmentid = ? and t.status = 2";
                                        stmt = con.prepareStatement(TokenQuery3);
                                        stmt.setInt(1, departmentId);
                                        rs = stmt.executeQuery();
                                         %>
                                        <div class="card1">
                                            <div class="card" style="justify-content: space-around">
                                                <h3>COMPLETED TOKENS</h3>
                                            </div>
                                                <%
                                            if(!rs.isBeforeFirst()){
                                                 %>  
                                                <div class="card">
                                                    <p> No Tokens avaliable  </p>
                                                </div>
                                            <%
                                            }
                                            else{
                                                while (rs.next()) {
                                                    String taskFaculty = rs.getString("FacultyName");
                                                    String taskName = rs.getString("Task");
                                                    Date taskDate = rs.getDate("Date");
                                            
                                                    %>
                                                    <div class="card">
                                                        <p> <%= taskFaculty %> </p>
                                                        <p> <%= taskName %> </p>
                                                        <p> <%= taskDate %> </p>
                                                    </div>
                                                    <%      
                                                }
                                            } 
                                            %>
                                        </div>
                                    </div>
                                
                                            <%

                                }
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
            </div>
        </div>
       

    </body>
</html>
