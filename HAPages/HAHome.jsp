
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html" %>
<%@ page errorPage="../exception.jsp" %>
<%@ include file="../cache.jsp" %> 


<%
    String userName = "";
    int FCount = 0;
    int AverageCredits = 0;
    int pubLog=0;
    int patentsLog=0;

    String user = (String) session.getAttribute("userID");
    int role = (int) session.getAttribute("role");
    if (user == null) {
        response.sendRedirect("../index.jsp");
    } else {
        if(role != 4){
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
        ResultSet rs = null;

        try {
            con = (Connection) session.getAttribute("dbConnection");
            if (con == null) {
                %>
                <script type="text/javascript">
                document.addEventListener("DOMContentLoaded", function() {
                    toastr.error("Database is not connected!!!");});
                </script>
                <%
            }
            

            // Query 1: Fetch faculty details
            String facultyQuery = "SELECT FacultyName FROM faculty WHERE FacultyID=?";
            stmt = con.prepareStatement(facultyQuery);
            stmt.setString(1, user);
            rs = stmt.executeQuery();

            if (rs.next()) {
                userName = rs.getString("FacultyName");
            }

            rs.close();
            stmt.close();

            // Query 2: Count faculty
            String TaskIncompleteQ = "select count(*) as FacultyCount from faculty where staffid = 1";
            stmt = con.prepareStatement(TaskIncompleteQ);
            // stmt.setString(1, user);
            rs = stmt.executeQuery();

            if (rs.next()) {
                FCount = rs.getInt("FacultyCount");
            }

            rs.close();
            stmt.close();

            // Query 3: Count complete tasks
            String TaskCompleteQ = "select (sum(logcredit) / (select count(*) from faculty where staffid = 1)) as AvgCredits from log;";
            stmt = con.prepareStatement(TaskCompleteQ);
            // stmt.setString(1, user);
            rs = stmt.executeQuery();

            if (rs.next()) {
                AverageCredits = rs.getInt("AvgCredits");
            }

            rs.close();
            stmt.close();

            
            // Query 4 : patents in log
            String patentsLogQ = "SELECT  SUM(PublicationsPublished) AS Publications, SUM(PatentsGained) AS Patents FROM log";
            stmt = con.prepareStatement(patentsLogQ);
            // stmt.setString(1, user);
            rs = stmt.executeQuery();

            if (rs.next()) {
                pubLog = rs.getInt("Publications");
                patentsLog = rs.getInt("Patents");
            }
        }  catch (Exception e) {
%>
            <script type="text/javascript">
                document.addEventListener("DOMContentLoaded", function() {
                    toastr.error("<%= e.getMessage() %>");
                });
            </script>
<%
        } 
    }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Higher Authority Home</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        .navbar {
            background-color: #004080;
            overflow: hidden;
            color: white;
            display: flex;
            justify-content: space-between;
            padding: 20px 20px;
        }
        .navbar a {
            color: white;
            text-decoration: none;
            padding: 10px;
        }
        .navbar a:hover {
            background-color: #4e2c2c;
        }
        .main {
            display: flex;
            margin: 20px;
            flex-direction: column;
            align-items: center;
        }
        .card-container {
            display: flex;
            padding-inline-start:10px;
            gap: 20px;
            margin: 10px;
        }
        .card {

            width: 30%;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 10px;
            background-color: #f9f9f9;
            text-align: center;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
        }
        .card1 {
            width:auto ;
            align-content: center;
            padding-top: 2px;
            padding-bottom: 2px;
            border: 1px solid #ddd;
            border-radius: 10px;
            background-color: #f9f9f9;
            text-align: left;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
        }
        .greeting {
            padding: 20px;
            text-align: center;
            margin: 20px;
            font-size: 30px;
            font-weight: bold;
        }

        .footer {
            text-align: center;
            padding: 10px;
            background-color: #333;
            color: white;
            position: fixed;
            bottom: 0;
            width: 100%;
        }
        .s1{
            display: flex;
        }
        .s2{
            align-content: center;
            padding-inline-start:50px;
            text-align: center;
        }
        #point .highlight {
            font-size: 42px;
            font-weight: bold;
            color: #004080;
            text-align: center;
        }
        #point p {
            text-align: center;
        }
        h3 {
            justify-content: start;
            color:  #004080;
            border-bottom: 2px solid #007BFF;
            padding-bottom: 5px;
        }
        ul {
            list-style-type: none;
            padding:0;
        }

        ul li {
            background: #f8f9fa;
            padding: 10px;
            margin-top: 5px;
            border-radius: 5px;
        }
    </style>
    <!-- Include toastr CSS -->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">

            <!-- Include jQuery -->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

            <!-- Include toastr JS -->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
            <script src="../src/js/scripts.js"></script>
    

            <script>
                document.addEventListener("DOMContentLoaded", function() {
                    var UserName = "<%= userName %>";
                    var pendingTasks = <%= FCount %>;
                    var completedTasks = <%= AverageCredits %>;
                    var Publications = <%= pubLog %>;
                    var Patents = <%= patentsLog %>;
        
                    document.getElementById("greeting").innerText = "Welcome, " + UserName + ", (Higher Authority)!";
                    document.getElementById("pendingTasks").innerText = "Count: " + pendingTasks;
                    document.getElementById("completedTasks").innerText = " " + completedTasks;
                    document.getElementById("publications").innerText = "Publications: " + Publications;
                    document.getElementById("patents").innerText = "Patents: " + Patents;
                });
            </script>
</head>
<body>
    <div class="navbar">
        <div class="nav-left">
            <a href="HAHome.jsp">Home</a>
            <a href="HADetails.jsp">Details</a>
            <a href="HAReports.jsp">Reports</a>
        </div>
        <div class="nav-right">
            <a href="HAProfile.jsp">Profile</a>
            <button id="logout" style="background: #004080; border: none; color: inherit; cursor: pointer; font: inherit; padding: 1px 10px;">Logout</button>
        </div>
    </div>
    <div class="greeting" id="greeting"></div>
    <div class="card1">
        <div class="card-container">
            <div class="card" id="task">
                <h3>Faculty</h3>
                <p id="pendingTasks"></p>
            </div>
            <div class="card" id="point">
                <h3>Average Performance</h3>
                <p class="highlight" id="completedTasks"></p>
            </div>
            <div class="card">
                <h3>Research</h3>
                <p id="publications"></p>
                <p id="patents"></p>
            </div>
        </div>
    </div>
    
    <div class="footer">
        <p>&copy; 2025 Faculty Performance Tracker | Contact Us | Privacy Policy</p>
    </div>
</body>
</html>