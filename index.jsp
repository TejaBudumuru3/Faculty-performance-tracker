<%@ page import="java.sql.*"%>  
<%@ page language="java" contentType="text/html" %>  
<%@ page errorPage="exception.jsp" %>  
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
    <!-- Load jQuery and Toastr JS -->  
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>  
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>  
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>  

    <div class="container">  
        <div class="logo">  
            <img src="./src/faculty.png" alt="logo" width="100%"/>  
        </div>  
    
        <div class="login">  
            <!-- Use a standard POST form -->  
            <form id="loginForm" method="post" action="index.jsp">  
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
                    <option value="higher">Higher Authority</option>  
                    <option value="HOD">HOD</option>  
                    <option value="faculty">Faculty</option>  
                    <option value="jr_asst">Jr. Assistant</option>  
                </select>   
                <br>  

                <button type="submit" class="btn btn-outline-primary" id="loginButton">Login</button>  
            </form>  
        </div>  
    </div>  

    <%  
        // Check if there's a login attempt  
        if ("POST".equalsIgnoreCase(request.getMethod())) {  
            String userId = request.getParameter("userid");  
            String password = request.getParameter("pass");  
            String role = request.getParameter("role");  
            boolean loginSuccessful = false;  

            Connection con = null;  
            PreparedStatement stmt = null;  
            ResultSet rs = null;  

            try {  
                Class.forName("com.mysql.cj.jdbc.Driver");  
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/faculty", "root", "");  

                String sql = "SELECT password FROM usercredentials WHERE userId = ?";  
                stmt = con.prepareStatement(sql);  
                stmt.setString(1, userId);  
                rs = stmt.executeQuery();  

                if (rs.next()) {  
                    String storedPassword = rs.getString("password");  

                    // Check if password matches  
                    if (password.equals(storedPassword)) {  
                        loginSuccessful = true;  
                    }  
                }  
            } catch (Exception e) {  
                e.printStackTrace();  
            } finally {  
                try { if (rs != null) rs.close(); } catch (SQLException se) {}  
                try { if (stmt != null) stmt.close(); } catch (SQLException se) {}  
                try { if (con != null) con.close(); } catch (SQLException se) {}  
            }  

            // Store login result in session to be accessed by JavaScript  
            session.setAttribute("loginResult", loginSuccessful ? "success" : "error");  
            if(session.getAttribute("loginResult")!=null){
                session.setAttribute("userId",userId);
            }
        }  
        else{
            session.removeAttribute("loginResult");
        }
    %>  

    <script type="text/javascript">  
        document.addEventListener("DOMContentLoaded", function() {  
            // Initialize Toastr options  
            toastr.options = {  
                "closeButton": true,  
                "progressBar": true,  
                "positionClass": "toast-top-right",  
                "timeOut": "5000",  
                "extendedTimeOut": "1000"  
            };  

            // Check login result from server-side processing  
            var loginResult = "<%= session.getAttribute("loginResult") != null ? session.getAttribute("loginResult") : "" %>";  
            
            if (loginResult == "success") {  
                toastr.success('Login successful');  
                setTimeout(function() {   
                    window.location.href = './faculty.html';   
                }, 1000);  
                <% session.removeAttribute("loginResult"); %>  
            } else if (loginResult == "error") {  
                toastr.error('Invalid UserID or Password');  
                <% session.removeAttribute("loginResult"); %>  
            }  
        });  
    </script>  

    <footer><img src="./src/MVGRLOGO.png" /></footer>  
</body>  
</html>
