<%@ page import="java.sql.*"%>  
<%@ page language="java" contentType="text/html" %>  
<%@ page errorPage="exception.jsp" %> 
<%@ page import="java.io.InputStream" %>
<%@ page import="java.util.Properties" %> 
<%@ page import="org.json.JSONArray, org.json.JSONObject" %>
<%@ include file="cache.jsp" %> 


<% 
    // JSON object to store the response
    JSONObject responseData = new JSONObject();
    JSONArray data = new JSONArray();

    try {
        // Load the properties file
        session.removeAttribute("dbConnection");
        Connection con = null;  
        InputStream input = application.getResourceAsStream("/WEB-INF/config.properties");
        Properties properties = new Properties();
        properties.load(input);

        // Fetch and print the URL property

        Class.forName(properties.getProperty("driverClass"));  
                con = DriverManager.getConnection(properties.getProperty("url")+properties.getProperty("db"), properties.getProperty("username"), "");  
                if(con!=null){
                    session.setAttribute("dbConnection", con);
                    
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
                        row.put("departmentNames", rs.getString("DepartmentName"));
                        row.put("totalLogCredits", rs.getInt("total_log_credit"));
                        row.put("avgLogCredits", rs.getDouble("avg_log_credit"));
                        data.put(row);
                    }

                    String JsonData = data.toString();
                    

                    // Add data to the response
                    
                    session.setAttribute("json",JsonData);


                    response.sendRedirect("login.jsp");
                    }
        // You can also print to the browser for debugging
    } catch (Exception e) {
        out.println("Error: " + e.getMessage()); // Print error to the browser
    }

    
    // Write the JSON response
%>
