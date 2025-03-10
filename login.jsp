<%@ page import="java.sql.*"%>  
<%@ page language="java" contentType="text/html" %>  
<%@ page errorPage="exception.jsp" %> 
<%@ include file="cache.jsp" %> 

<!DOCTYPE html>  
<html lang="en">  
<head>  
    <meta charset="utf-8">  
    <meta name="viewport" content="width=device-width, initial-scale=1">  
    <title>Home Page - Faculty Performance Tracker</title>  
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">  
    <link rel="stylesheet" type="text/css" href="./src/styles.css">  
    <link rel="icon" href="./src/faculty.png">  
    <!-- Add Toastr CSS -->  
    <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet"/>  
</head>  
<body>  
    <!-- Include toastr CSS -->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">

            <!-- Include jQuery -->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

            <!-- Include toastr JS -->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
            <script src="./src/js/scripts.js"></script><script src="./src/js/scripts.js"></script>
    <div class="container">  
        <div class="logo">  
            <img src="./src/faculty.png" alt="logo" width="100%"/>  
        </div>  
    
        <div class="login">  
            <!-- Use a standard POST form -->  
            <form id="loginForm" method="post" action="login.jsp">  
                <label><strong>Login</strong></label><hr>  
                
                <div class="form-group">  
                    <label for="userid">UserID</label>  
                    <input type="text" class="form-control" id="userid" name="userid" placeholder="userID" required>  
                </div>  
                
                <div class="form-group">  
                    <label for="password">Password</label>  
                    <input type="password" class="form-control" id="password" name="pass" placeholder="Password" maxlength="12" required>  
                </div>  
                <br>  
                
                <select class="custom-select custom-select-lg mb-3" id="role" name="role" required>  
                    <option selected value="">Select Role</option> 
                    <option value="1">Faculty</option>  
                    <option value="2">Jr. Assistant</option> 
                    <option value="3">HOD</option>  
                    <option value="4">Higher Authority</option> 
                </select>   
                <br>  

                <button type="submit" class="btn btn-outline-primary" id="loginButton">Login</button>  
            </form>  
        </div>  
    </div>  

    <script src="./src/js/scripts.js"></script>

<%


boolean valid = false;
if ("POST".equalsIgnoreCase(request.getMethod())){

String userId = request.getParameter("userid");  
String password = request.getParameter("pass");  
Connection con = null;
int role = Integer.parseInt(request.getParameter("role"));  
if (userId != null && password != null && role != 0) {
        
        PreparedStatement stmt = null;
        ResultSet rs = null;
        PreparedStatement stmt1 = null;
        ResultSet rs1 = null;
       
    try{
        con = (Connection)session.getAttribute("dbConnection");
        if(con!=null){
            String sql = "SELECT * from credentials WHERE RoleID=? and FacultyID=? and FacultyPassword=?";
 
            stmt = con.prepareStatement(sql);  
            stmt.setString(2, userId);  
            stmt.setInt(1,role);
            stmt.setString(3,password);

            rs = stmt.executeQuery();
            if(rs.next()){
                valid=true;
                session.setAttribute("userID",userId);
                session.setAttribute("role", role);
                String dp = "SELECT DepartmentID from faculty where facultyid = ?";
                stmt1 = con.prepareStatement(dp);
                stmt1.setString(1, userId);

                rs1 = stmt1.executeQuery();
                if(rs1.next()) {
                    int val = rs1.getInt("DepartmentID");
                    session.setAttribute("departmentId", val);
                }

            }
            else{
            valid=false;
            }
        } 
       
            
    }catch(Exception e)
    {
        %>
        <script type="text/javascript">
            document.addEventListener("DOMContentLoaded", function() {
                toastr.error(<%= e.getMessage() %>);});
            </script>
        <%}
}


%>
<script type="text/javascript">  
        document.addEventListener("DOMContentLoaded", function() {  
            // Check login result from server-side processing  
            var loginResult = <%= valid %>; 
            var role = <%= role %> 
            var connection = "<%= con %>";

            if(connection ==="null"){
                toastr.error('Database is connection failed.\n\n Please try again');
                setTimeout(function() {   
                    window.location.href = './index.jsp';   
                }, 3000);
            }
            else{
            console.log(loginResult);
            console.log(connection);
            if (loginResult) {  
                toastr.success('Login successfull'); 
                setTimeout(function() {   

                    if(role===1)
                    window.location.href = './FacultyPages/FacultyPage.jsp';
                    else if(role===2)
                    window.location.href = './JAPages/JAHome.jsp';
                    else if(role===3)
                    window.location.href = "./HODPages/HODHome.jsp";
                    else if(role===4)
                    window.location.href = "./HAPages/HAHome.jsp";   
                }, 1000);
            } else {  
                  toastr.error('Invalid UserID or Password');  
            } 
            } 
        });  
 </script>
<%
}
%>
    <footer><img src="./src/MVGRLOGO.png" /></footer>  
</body>  
</html>

