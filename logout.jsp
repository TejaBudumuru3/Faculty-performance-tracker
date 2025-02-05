<%@ page import="java.sql.*"%>  
<%@ page language="java" contentType="text/html" %>  
<%@ page errorPage="exception.jsp" %> 


<%

if(session.getAttribute("userID")!=null){
    session.removeAttribute("userID");
    %>
    <html>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>  
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>  
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>  
    <script src="/src/scripts.js">  
        
            // Initialize Toastr options  
            // toastr.options = {  
            //     "closeButton": true,  
            //     "progressBar": true,  
            //     "positionClass": "toast-top-right",  
            //     "timeOut": "5000",  
            //     "extendedTimeOut": "1000"  
            // }; 
        
    </script>
    <script type="text/javascript">
            document.addEventListener("DOMContentLoaded", function() {
                toastr.success("logging out...");});
                setTimeout(() => {
                    window.location.href = "./index.jsp";
                }, 1000);
            </script>
    <%
}
else
response.sendRedirect("./index.jsp");

%>