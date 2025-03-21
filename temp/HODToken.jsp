<%@ page import="java.sql.*"%>  
<%@ page language="java" contentType="text/html" %>  
<%@ page errorPage="../exception.jsp" %>  
<%@ include file="../cache.jsp" %> 


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Tasks </title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; }
        .navbar { background-color: #004080; overflow: hidden; color: white; display: flex; justify-content: space-between; padding: 20px 20px; }
        .navbar a { color: white; text-decoration: none; padding: 10px; }
        .navbar a:hover { background-color: #4e2c2c; }
        .main { display: flex; margin: 20px; flex-direction: column; align-items: center; }
        .card-container { padding-inline-start:10px; gap: 20px; margin: 10px; }
        .card { display: flex; justify-content: space-between; align-items: center; width:auto; padding: 10px; margin: 10px; background-color: #f9f9f9; text-align: left; box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1); }
        h3 { justify-content: start; color: #004080; border-bottom: 2px solid #007BFF; padding-bottom: 5px; }
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

    

    <%
        String user = (String) session.getAttribute("userID");
        int role = (int) session.getAttribute("role");
        if (user == null) {
            response.sendRedirect("../index.jsp");
        } else {
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
            
            } else {
            Connection con = null;
            PreparedStatement stmt = null;
            ResultSet rs1 = null;
            ResultSet rs = null;

            try {
                con = (Connection) session.getAttribute("dbConnection");
                if (con != null) {
                    
                    String TokenQuery1 = "select t.FacultyID, t.Date, t.Task from faculty f join token t on f.facultyid = t.facultyid where status = 0 and f.departmentid = (select departmentid from faculty where facultyid = ?)";
                    stmt = con.prepareStatement(TokenQuery1);
                    stmt.setString(1, user);
                    rs = stmt.executeQuery();
    %>
                    <div class="card-container">
                        <div class="card1">
                            <h3>REQUESTED TOKENS</h3>
                            <%
                                if(!rs.isBeforeFirst()){
                                    %> <div class="card">
                                        <p> No Tokens avaliable </p>
                                        </div>
                                       
                                    <%
                                }

                                 while (rs.next()) {
                                    String FID = rs.getString("FacultyID");
                                    String taskName = rs.getString("Task");
                                    Date taskDate = rs.getDate("Date");
                                    
                            %>
                                    <div class="card">
                                        <p> <%= FID %> </p>
                                        <p> <%= taskName %> </p>
                                        <p> <%= taskDate %> </p>
                                        
                                    </div>
                                <% } %>
                        </div>
                        <%  
                            
                            String TokenQuery2 = "select t.FacultyID, t.Date, t.Task from faculty f join token t on f.facultyid = t.facultyid where status = 1 and f.departmentid = (select departmentid from faculty where facultyid = ?)";
                            stmt = con.prepareStatement(TokenQuery2);
                            stmt.setString(1, user);
                            rs = stmt.executeQuery();
                        %>
                            <div class="card1">
                                <h3>ACCEPTED TOKENS</h3>
                                <%
                                    if(!rs.isBeforeFirst()){
                                        %> <div class="card">
                                        <p> No Tokens avaliable  </p>
                                        </div>
                                        <%
                                    }
                                    else{
                                        while (rs.next()) {
                                        String FID = rs.getString("FacultyID");
                                        String taskName = rs.getString("Task");
                                        Date taskDate = rs.getDate("Date");
                                    %>
                                        <script>console.log("<%= taskName%>");</script>
                                        <div class="card">
                                            <p> <%= FID %> </p>
                                            <p> <%= taskName %> </p>
                                            <p> <%= taskDate %> </p>
                                            
                                        </div>
                                <%      }
                                    } 
                                    %>
                            </div>
                        <%  
                            
                            String TokenQuery3 = "select t.FacultyID, t.Date, t.Task from faculty f join token t on f.facultyid = t.facultyid where status = 2 and f.departmentid = (select departmentid from faculty where facultyid = ?)";
                            stmt = con.prepareStatement(TokenQuery3);
                            stmt.setString(1, user);
                            rs = stmt.executeQuery();
                        %>
                            <div class="card1">
                                <h3>COMPLETED TOKENS</h3>
                                <%
                                    if(!rs.isBeforeFirst()){
                                        %> <div class="card">
                                        <p> No Tokens avaliable  </p>
                                        </div>
                                        <%
                                    }
                                    else{
                                        while (rs.next()) {
                                        String FID = rs.getString("FacultyID");
                                        String taskName = rs.getString("Task");
                                        Date taskDate = rs.getDate("Date");
                                    %>
                                        <script>console.log("<%= taskName%>");</script>
                                        <div class="card">
                                            <p> <%= FID %> </p>
                                            <p> <%= taskName %> </p>
                                            <p> <%= taskDate %> </p>
                                            
                                        </div>
                                <%      }
                                    } 
                                    %>
                            </div>
                    </div>
    <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        }
    %>
</body>
</html>
