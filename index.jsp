<%@ page import="java.sql.*"%>  
<%@ page language="java" contentType="text/html" %>  
<%@ page errorPage="exception.jsp" %> 
<%@ page import="java.io.InputStream" %>
<%@ page import="java.util.Properties" %> 

<% 
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
                     response.sendRedirect("login.jsp");
                    }
        // You can also print to the browser for debugging
    } catch (Exception e) {
        out.println("Error: " + e.getMessage()); // Print error to the browser
    }
%>
