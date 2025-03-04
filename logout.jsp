<%@ page import="java.sql.*"%>  
<%@ page language="java" contentType="text/html" %>  
<%@ page errorPage="exception.jsp" %> 
<%@ include file="cache.jsp" %> 



<%

if(session.getAttribute("userID")!=null){
    //session.removeAttribute("userID");
    session.invalidate();
}

response.sendRedirect("./index.jsp");

%>