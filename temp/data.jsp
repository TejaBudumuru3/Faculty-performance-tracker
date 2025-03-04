<%@ page import="java.sql.*, org.json.JSONArray, org.json.JSONObject" %>
<%
    // Database connection details
    String url = "jdbc:mysql://localhost:3306/your_database";
    String user = "your_username";
    String password = "your_password";

    // JSON object to store the response
    JSONObject responseData = new JSONObject();
    JSONArray data = new JSONArray();

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish the connection
        Connection con = (Connection) session.getAttribute("dbConnection");

        // SQL query
        
        String query = "SELECT d.DepartmentName, " +
                       "COALESCE(SUM(l.LogCredit), 0) AS total_log_credit, " +
                       "COALESCE(SUM(l.LogCredit), 0) / NULLIF(COUNT(DISTINCT f.FacultyID), 0) AS avg_log_credit " +
                       "FROM Department d " +
                       "LEFT JOIN Faculty f ON d.DepartmentID = f.DepartmentID " +
                       "LEFT JOIN Log l ON f.FacultyID = l.FacultyID " +
                       "GROUP BY d.DepartmentID, d.DepartmentName";

        // Execute the query
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery(query);

        // Process the result set
        while (rs.next()) {
            JSONObject row = new JSONObject();
            row.put("departmentName", rs.getString("DepartmentName"));
            row.put("totalLogCredit", rs.getInt("total_log_credit"));
            row.put("avgLogCredit", rs.getDouble("avg_log_credit"));
            data.put(row);
        }

        // Close the connection
        

        // Add data to the response
        responseData.put("data", data);
    } catch (Exception e) {
        responseData.put("error", e.getMessage());
    }

    // Set the response type to JSON
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");

    // Write the JSON response
    out.print(responseData.toString());
%>
