<%@ page import="java.sql.*"%>  
<%@ page language="java" contentType="text/html" %>  
<%@ page errorPage="../exception.jsp" %>  
<%@ include file="../cache.jsp" %> 
<%
String user = (String) session.getAttribute("userID");
int role = (int) session.getAttribute("role");

String Dept="";
    if (user == null) {
        response.sendRedirect("../index.jsp");
    } else {
        if(role != 2){
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
    }
 %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Junior Assistant's Tasks</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; }
        .navbar { background-color: #004080; overflow: hidden; color: white; display: flex; justify-content: space-between; padding: 20px 20px; }
        .navbar a { color: white; text-decoration: none; padding: 10px; }
        .navbar a:hover { background-color: #4e2c2c; }
        .main { display: flex; margin: 20px; flex-direction: column; align-items: center; }
        .card-container { padding-inline-start:10px; gap: 20px; margin: 10px; }
        .card { display: flex; justify-content: space-between; align-items: center; width:auto; padding: 10px; margin: 10px; background-color: #f9f9f9; text-align: left; box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1); }
        .buttons { display: flex; align-content: right; flex-direction: row; gap: 5px; margin-right: 10px; }
        .btn { background-color: #007BFF; display:inline-block; color: white; border: none; padding: 10px 10px; border-radius: 5px; cursor: pointer; }
        .btn:hover { background-color: #0056b3; }
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
            <a href="JAHome.jsp">Home</a>
            <a href="add.jsp">Add Faculty</a>
            <a href="update.jsp">Update Faculty</a>
            <a href="delete.jsp">Delete Faculty</a>
            <a href="JAToken.jsp">Tasks</a>
        </div>
        <div class="nav-right">
            <a href="JAProfile.jsp">Profile</a>
            <button id="logout" style="background: #004080; border: none; color: inherit; cursor: pointer; font: inherit; padding: 1px 10px;">Logout</button>
        </div>
    </div>

    <%
        // Handle token update when the button is clicked ()
        if (request.getParameter("acceptToken") != null) {
            String facultyId = request.getParameter("facultyId");
            String taskDate = request.getParameter("taskDate");
            String taskName = request.getParameter("taskName");

            Connection con = null;
            PreparedStatement stmt = null;

            try {
                con = (Connection) session.getAttribute("dbConnection");
                if (con != null) {
                    String updateQuery = "UPDATE token SET status = status + 1 WHERE FacultyID = ? AND Date = ? AND Task = ?";
                    stmt = con.prepareStatement(updateQuery);
                    stmt.setString(1, facultyId);
                    stmt.setString(2, taskDate);
                    stmt.setString(3, taskName);

                    int rowsUpdated = stmt.executeUpdate();
                    if (rowsUpdated > 0) {
                        %>

                        <script type="text/javascript">
                        document.addEventListener("DOMContentLoaded", function() {
                            toastr.success("Token Forwarded Successfully");});
                            setTimeout(() => {
                                window.location.href = "./JAToken.jsp";
                            }, 5000);
                        </script>

                        <%
                        } 
                } else { 
                    %> <script type="text/javascript">
                        document.addEventListener("DOMContentLoaded", function() {
                            toastr.error("Database connection failed");
                            });
                            setTimeout(() => {
                                window.location.href = "../index.jsp";
                            }, 2000);
                        </script>

                        <%}
            } catch (Exception e) {
                e.printStackTrace();
                %>

                        <script type="text/javascript">
                        document.addEventListener("DOMContentLoaded", function() {
                            toastr.success("<% e.getMessage(); %>");
                            });
                        </script>

                        <%
                        } finally {
                if (stmt != null) stmt.close();
            }
        }

        // Handle token update when the button is clicked
        if (request.getParameter("rejectToken") != null) {
            String facultyId = request.getParameter("facultyId");
            String taskDate = request.getParameter("taskDate");
            String taskName = request.getParameter("taskName");

            Connection con = null;
            PreparedStatement stmt = null;

            try {
                con = (Connection) session.getAttribute("dbConnection");
                if (con != null) {
                    String updateQuery = "UPDATE token SET status = status - 1 WHERE FacultyID = ? AND Date = ? AND Task = ?";
                    stmt = con.prepareStatement(updateQuery);
                    stmt.setString(1, facultyId);
                    stmt.setString(2, taskDate);
                    stmt.setString(3, taskName);

                    int rowsUpdated = stmt.executeUpdate();
                    if (rowsUpdated > 0) {
                        %>

                        <script type="text/javascript">
                        document.addEventListener("DOMContentLoaded", function() {
                            toastr.success("Token Backwarded Successfully");});
                        </script>

                        <%
                    } 
                } else { 
                    %>

                        <script type="text/javascript">
                        document.addEventListener("DOMContentLoaded", function() {
                            toastr.error("Database connection failed");
                            });
                            setTimeout(() => {
                            window.location.href = "../index.jsp";
                            }, 2000);
                        </script>

                        <%
                    }
            } catch (Exception e) {
                e.printStackTrace();
                 %>

                        <script type="text/javascript">
                        document.addEventListener("DOMContentLoaded", function() {
                            toastr.success("<% e.getMessage(); 
                            %>");
                            });
                        </script>

                        <%
            } finally {
                if (stmt != null) stmt.close();
            }
        }
    %>

    <%

        if (user == null) {
            response.sendRedirect("../index.jsp");
        } else {
            if(role != 2){
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
                    
                    String TokenQuery1 = "SELECT Task, Date FROM token WHERE FacultyID=? AND status = 0";
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
                                    String taskName = rs.getString("Task");
                                    Date taskDate = rs.getDate("Date");
                                    
                            %>
                                    <div class="card">
                                        <p> <%= taskName %> </p>
                                        <div class="buttons">
                                            <form method="POST">
                                                <input type="hidden" name="facultyId" value="<%= user %>">
                                                <input type="hidden" name="taskDate" value="<%= taskDate %>">
                                                <input type="hidden" name="taskName" value="<%= taskName %>">
                                                <button type="submit" name="acceptToken" class="btn">Accept</button>
                                            </form>
                                        </div>
                                    </div>
                                <% } %>
                        </div>
                        <%  
                            
                            String TokenQuery2 = "SELECT Task, Date FROM token WHERE FacultyID=? AND status = 1";
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
                                        String taskName = rs.getString("Task");
                                        Date taskDate = rs.getDate("Date");
                                    %>
                                        <script>console.log("<%= taskName%>");</script>
                                        <div class="card">
                                            <p> <%= taskName %> </p>
                                            <div class="buttons">
                                                <form method="POST">
                                                    <input type="hidden" name="facultyId" value="<%= user %>">
                                                    <input type="hidden" name="taskDate" value="<%= taskDate %>">
                                                    <input type="hidden" name="taskName" value="<%= taskName %>">
                                                    <button type="submit" name="acceptToken" class="btn">Complete</button>
                                                    <button type="submit" name="rejectToken" class="btn">Shift to Previous</button>
                                                </form>
                                            </div>
                                        </div>
                                <%      }
                                    } 
                                    %>
                            </div>
                        <%  
                            
                            String TokenQuery3 = "SELECT Task, Date FROM token WHERE FacultyID=? AND status = 2";
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
                                        String taskName = rs.getString("Task");
                                        Date taskDate = rs.getDate("Date");
                                    %>
                                        <script>console.log("<%= taskName%>");</script>
                                        <div class="card">
                                            <p> <%= taskName %> </p>
                                            <div class="buttons">
                                                <form method="POST">
                                                    <input type="hidden" name="facultyId" value="<%= user %>">
                                                    <input type="hidden" name="taskDate" value="<%= taskDate %>">
                                                    <input type="hidden" name="taskName" value="<%= taskName %>">
                                                    <button type="submit" name="rejectToken" class="btn">Shift to Previous</button>
                                                </form>
                                            </div>
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
