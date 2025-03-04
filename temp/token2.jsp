<%@ page import="java.sql.*"%>  
<%@ page language="java" contentType="text/html" %>  
<%@ page errorPage="exception.jsp" %>  

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Faculty Page</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; }
        .navbar { background-color: #004080; overflow: hidden; color: white; display: flex; justify-content: space-between; padding: 20px 20px; }
        .navbar a { color: white; text-decoration: none; padding: 10px; }
        .navbar a:hover { background-color: #4e2c2c; }
        .main { display: flex; margin: 20px; flex-direction: column; align-items: center; }
        .card-container { padding-inline-start:10px; gap: 20px; margin: 10px; }
        .card { display: flex; justify-content: space-between; align-items: center; width:auto; padding: 10px; margin: 10px; background-color: #f9f9f9; text-align: left; box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1); }
        .buttons { display: flex; align-content: right; flex-direction: row; gap: 5px; margin-right: 10px; }
        .btn { background-color: #007BFF; width: 60px; color: white; border: none; padding: 5px 10px; border-radius: 5px; cursor: pointer; }
        .btn:hover { background-color: #0056b3; }
        h3 { justify-content: start; color: #004080; border-bottom: 2px solid #007BFF; padding-bottom: 5px; }
    </style>
</head>
<body>
    <div class="navbar">
        <div class="nav-left">
            <a href="FacultyPage.jsp">Home</a>
            <a href="workUpdate.html">Work Update</a>
            <a href="reports2.html">Reports</a>
            <a href="token2.jsp">Notifications</a>
        </div>
        <div class="nav-right">
            <a href="profile.html">Profile</a>
            <a href="#">Feedback</a>
            <a href="logout.jsp">Logout</a>
        </div>
    </div>

    <%
        // Handle token update when the button is clicked
        if (request.getParameter("acceptToken") != null) {
            String facultyId = request.getParameter("facultyId");
            String taskDate = request.getParameter("taskDate");
            String taskName = request.getParameter("taskName");

            Connection con = null;
            PreparedStatement stmt = null;

            try {
                con = (Connection) session.getAttribute("dbConnection");
                if (con != null) {
                    String updateQuery = "UPDATE token SET status = 1 WHERE FacultyID = ? AND Date = ? AND Task = ? AND status = 0";
                    stmt = con.prepareStatement(updateQuery);
                    stmt.setString(1, facultyId);
                    stmt.setString(2, taskDate);
                    stmt.setString(3, taskName);

                    int rowsUpdated = stmt.executeUpdate();
                    if (rowsUpdated > 0) {
                        out.print("<script>alert('Token updated successfully!'); window.location.href='token2.jsp';</script>");
                    } else {
                        out.print("<script>alert('No token found or already accepted.');</script>");
                    }
                } else {
                    out.print("<script>alert('Database connection failed.');</script>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.print("<script>alert('Error: " + e.getMessage() + "');</script>");
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
                    String updateQuery = "UPDATE token SET status = 0 WHERE FacultyID = ? AND Date = ? AND Task = ? AND status = 1";
                    stmt = con.prepareStatement(updateQuery);
                    stmt.setString(1, facultyId);
                    stmt.setString(2, taskDate);
                    stmt.setString(3, taskName);

                    int rowsUpdated = stmt.executeUpdate();
                    if (rowsUpdated > 0) {
                        out.print("<script>alert('Token updated successfully!'); window.location.href='token2.jsp';</script>");
                    } else {
                        out.print("<script>alert('No token found or already accepted.');</script>");
                    }
                } else {
                    out.print("<script>alert('Database connection failed.');</script>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.print("<script>alert('Error: " + e.getMessage() + "');</script>");
            } finally {
                if (stmt != null) stmt.close();
            }
        }
    %>

    <%
        String user = (String) session.getAttribute("userID");
        if (user == null) {
            response.sendRedirect("index.jsp");
        } else {
            Connection con = null;
            PreparedStatement stmt = null;
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
                                                    <button type="submit" name="rejectToken" class="btn">Reject</button>
                                                </form>
                                            </div>
                                        </div>
                                <% } %>
                            </div>
                    </div>
    <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    %>
</body>
</html>
