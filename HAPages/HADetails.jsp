<%@ page import="java.sql.*" %>
<%@ page import="org.json.*" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html" %>
<%@ page errorPage="../exception.jsp" %>
<%@ include file="../cache.jsp" %> 

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Departments</title>
    <link href="../src/navbar.css" rel="stylesheet">
    <style>
        body {
            background-color: #f4f4f9;
        }
        .side-menu {
            width: 15%;
            background-color: #004080;
            color: white;
            position: fixed;
            top: 60px; /* Adjust this to match the navbar height */
            bottom: 0;
            padding: 1% 0;
            overflow-y: auto;
            z-index: 500; /* Lower than navbar */
            }
        .side-menu ul {
            list-style: none;
            padding: 0;
        }
        .side-menu ul li {
            padding: 8% 15%;
            cursor: pointer;
            border-bottom: 1px solid #1a73e8;
        }
        .side-menu ul li:hover {
            background-color: #1a73e8;
        }

        .main-content {
            margin-left: 15%;
            padding: 80px 20px 20px;
            width: 80%;
        }

        .form-container {
            display: none;
            padding: 0% 1%;
        }

        .card {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: auto;
            padding: 2%;
            margin: 1%;
            background-color: #f9f9f9;
            text-align: left;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
        }
        .card1 {
            height: 30%;
            width: auto;
            overflow: auto;
            padding: 2%;
            margin: 1%;
            border: 1px solid #ddd;
            border-radius: 10px;
            background-color: #f9f9f9;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
        }
        h2{
            text-align: center;
        }
        .button-container button {
            padding: 1.5% 7%;
            border: none;
            cursor: pointer;
            color: white;
            border-radius: 5px;
            background-color: #4CAF50;
            margin: 2% 0%;
        }
        .next-btn {
            float:right;
        }
        .prev-btn:hover {
            background-color: #1a73e8;
        }
        .next-btn:hover {
            background-color: #1a73e8;
        }
        .active-category {
            background-color: white !important;
            color: #004080 !important;
            font-weight: bold;
        }
        
    </style>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="../src/js/HAscript.js"></script>
    <script src="../src/js/scripts.js"></script>
    <!-- Include toastr CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">

    <!-- Include jQuery -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

    <!-- Include toastr JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
</head>
<body>
    <!-- Navbar -->
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

    <div class="side-menu">
        <ul>
            <li id="cse" onclick="showForm('CSE')">CSE</li>
            <li id="ece" onclick="showForm('ECE')">ECE</li>
            <li id="eee" onclick="showForm('EEE')">EEE</li>
            <li id="mech" onclick="showForm('Mech')">Mech</li>
            <li id="civil" onclick="showForm('Civil')">Civil</li>
            <li id="mba" onclick="showForm('MBA')">IT</li>
            <li id="csm" onclick="showForm('CSM')">CHE</li>
            <li id="de" onclick="showForm('DE')">DE</li>
          </ul>
    </div>

    <div id="main" class="main-content" >
    <canvas id="myChart" width="100%" height="40%"></canvas>
        <div id="CSE" class="form-container">
            <h2>Computer Science and Engineering</h2>
            <div id="hod">
                <div class="card1" >
                    <h3 id="hodHead" class="head">Head Of Department</h3>
                    <div id="name" class="card">Name</div>
                    <div id="roll" class="card">Roll number</div>
                    <div id="hours" class="card">working hours</div>
                </div>
            </div>
            <div id="faculty">
                <div id="facultyHead" class="card1">
                    <h3 class="head">Top Performer Of The Month</h3>
                    <div id="name" class="card">Name</div>
                    <div id="roll" class="card">Roll number</div>
                    <div id="hours" class="card">working hours</div>
                </div>
            </div>
            <div class="button-container">
                <button type="button" class="next-btn" onclick="nextTab('CSE', 'ECE')">Next</button>
              </div>
        </div>

        <div id="ECE" class="form-container">
            <h2>Electronics and communication Engineering</h2>
            <div id="hod">
                <div class="card1">
                    <h3 id="hodHead" class="head">Head Of Department</h3>
                    <div id="name" class="card">Name</div>
                    <div id="roll" class="card">Roll number</div>
                    <div id="hours" class="card">working hours</div>
                </div>
            </div>
            <div id="faculty">
                <div id="facultyHead" class="card1">
                    <h3 class="head">Top Performer Of The Month</h3>
                    <div id="name" class="card">Name</div>
                    <div id="roll" class="card">Roll number</div>
                    <div id="hours" class="card">working hours</div>
                </div>
            </div>
            <div class="button-container">
                <button type="button" class="prev-btn" onclick="prevTab('ECE', 'CSE')">Previous</button>
                <button type="button" class="next-btn" onclick="nextTab('ECE', 'EEE')">Next</button>
            </div>
        </div>

        <div id="EEE" class="form-container">
            <h2>Electrical and Electronics Engineering</h2>
            <div id="hod">
                <div class="card1">
                    <h3 id="hodHead" class="head">Head Of Department</h3>
                    <div id="name" class="card">Name</div>
                    <div id="roll" class="card">Roll number</div>
                    <div id="hours" class="card">working hours</div>
                </div>
            </div>
            <div id="faculty">
                <div id="facultyHead" class="card1">
                    <h3 class="head">Top Performer Of The Month</h3>
                    <div id="name" class="card">Name</div>
                    <div id="roll" class="card">Roll number</div>
                    <div id="hours" class="card">working hours</div>
                </div>
            </div>
            <div class="button-container">
                <button type="button" class="prev-btn" onclick="prevTab('EEE', 'ECE')">Previous</button>
                <button type="button" class="next-btn" onclick="nextTab('EEE', 'Mech')">Next</button>
            </div>
        </div>

        <div id="Mech" class="form-container">
            <div id="hod">
                <h2>Mechanical Engineering</h2>
                <div class="card1">
                    <h3 id="hodHead" class="head">Head Of Department</h3>
                    <div id="name" class="card">Name</div>
                    <div id="roll" class="card">Roll number</div>
                    <div id="hours" class="card">working hours</div>
                </div>
            </div>
            <div id="faculty">
                <div id="facultyHead" class="card1">
                    <h3 class="head">Top Performer Of The Month</h3>
                    <div id="name" class="card">Name</div>
                    <div id="roll" class="card">Roll number</div>
                    <div id="hours" class="card">working hours</div>
                </div>
            </div>
            <div class="button-container">
                <button type="button" class="prev-btn" onclick="prevTab('Mech', 'EEE')">Previous</button>
                <button type="button" class="next-btn" onclick="nextTab('Mech', 'Civil')">Next</button>
            </div>
        </div>

        <div id="Civil" class="form-container">
            <h2>Civil Engineering</h2>
            <div id="hod">
                <div class="card1">
                    <h3 id="hodHead" class="head">Head Of Department</h3>
                    <div id="name" class="card">Name</div>
                    <div id="roll" class="card">Roll number</div>
                    <div id="hours" class="card">working hours</div>
                </div>
            </div>
            <div id="faculty">
                <div id="facultyHead" class="card1">
                    <h3 class="head">Top Performer Of The Month</h3>
                    <div id="name" class="card">Name</div>
                    <div id="roll" class="card">Roll number</div>
                    <div id="hours" class="card">working hours</div>
                </div>
            </div>
            <div class="button-container">
                <button type="button" class="prev-btn" onclick="prevTab('Civil', 'Mech')">Previous</button>
                <button type="button" class="next-btn" onclick="nextTab('Civil', 'MBA')">Next</button>
            </div>
        </div>

        <div id="MBA" class="form-container">
            <h2>INFORMATION TECHNOLOGY</h2>
            <div id="hod">
                <div class="card1">
                    <h3 id="hodHead" class="head">Head Of Department</h3>
                    <div id="name" class="card">Name</div>
                    <div id="roll" class="card">Roll number</div>
                    <div id="hours" class="card">working hours</div>
                </div>
            </div>
            <div id="faculty">
                <div id="facultyHead" class="card1">
                    <h3 class="head">Top Performer Of The Month</h3>
                    <div id="name" class="card">Name</div>
                    <div id="roll" class="card">Roll number</div>
                    <div id="hours" class="card">working hours</div>
                </div>
            </div>
            <div class="button-container">
                <button type="button" class="prev-btn" onclick="prevTab('MBA', 'Civil')">Previous</button>
                <button type="button" class="next-btn" onclick="nextTab('MBA', 'CSM')">Next</button>
            </div>
        </div>


        <div id="CSM" class="form-container">
            <h2>CHEMICAL ENGINEERING</h2>
            <div id="hod">
                <div class="card1">
                    <h3 id="hodHead" class="head">Head Of Department</h3>
                    <div id="name" class="card">Name</div>
                    <div id="roll" class="card">Roll number</div>
                    <div id="hours" class="card">working hours</div>
                </div>
            </div>
            <div id="faculty">
                <div id="facultyHead" class="card1">
                    <h3 class="head">Top Performer Of The Month</h3>
                    <div id="name" class="card">Name</div>
                    <div id="roll" class="card">Roll number</div>
                    <div id="hours" class="card">working hours</div>
                </div>
            </div>
            <div class="button-container">
                <button type="button" class="prev-btn" onclick="prevTab('CSM', 'MBA')">Previous</button>
                <button type="button" class="next-btn" onclick="nextTab('CSM', 'DE')">Next</button>
            </div>
        </div>

        <div id="DE" class="form-container">
            <h2>DATA ENGINEERING</h2>
            <div id="hod">
                <div class="card1">
                    <h3 id="hodHead" class="head">Head Of Department</h3>
                    <div id="name" class="card">Name</div>
                    <div id="roll" class="card">Roll number</div>
                    <div id="hours" class="card">working hours</div>
                </div>
            </div>
            <div id="faculty">
                <div id="facultyHead" class="card1">
                    <h3 class="head">Top Performer Of The Month</h3>
                    <div id="name" class="card">Name</div>
                    <div id="roll" class="card">Roll number</div>
                    <div id="hours" class="card">working hours</div>
                </div>
            </div>
            <div class="button-container">
                <button type="button" class="prev-btn" onclick="prevTab('DE', 'CSM')">Previous</button>
        </div>

        
    </div>

    <%-- <script src=".../src/js/HAscript.js"></script> --%>


   
</body>
</html>
<%
    String CSEHOD = null;
    String CSEID = null;
    String CSEHRS = null;
    String CSETOPNAME = null;
    String CSETOPID = null;
    String CSETOPHRS = null;

    String ECEHOD = null;
    String ECEID = null;
    String ECEHRS = null;
    String ECETOPNAME = null;
    String ECETOPID = null;
    String ECETOPHRS = null;

    String EEEHOD = null;
    String EEEID = null;
    String EEEHRS = null;
    String EEETOPNAME = null;
    String EEETOPID = null;
    String EEETOPHRS = null;

    String MECHOD = null;
    String MECID = null;
    String MECHRS = null;
    String MECTOPNAME = null;
    String MECTOPID = null;
    String MECTOPHRS = null;

    String ITHOD = null;
    String ITID = null;
    String ITHRS = null;
    String ITTOPNAME = null;
    String ITTOPID = null;
    String ITTOPHRS = null;

    String CHEHOD = null;
    String CHEID = null;
    String CHEHRS = null;
    String CHETOPNAME = null;
    String CHETOPID = null;
    String CHETOPHRS = null;

    String CIVHOD = null;
    String CIVID = null;
    String CIVHRS = null;
    String CIVTOPNAME = null;
    String CIVTOPID = null;
    String CIVTOPHRS = null;

    String DEHOD = null;
    String DEHRS = null;
    String DEID = null;
    String DETOPNAME = null;
    String DETOPID = null;
    String DETOPHRS = null;
String jsonData = (String) session.getAttribute("json");
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
                
                }
    else{

session.removeAttribute("jsonData");

JSONArray hodArray = new JSONArray();
JSONArray DeptArray = new JSONArray();
JSONArray TopperArray = new JSONArray();

try{
    Connection con = (Connection) session.getAttribute("dbConnection");
    //int department = (int) session.getAttribute("departmentID");
    //int HODrole = 3;
    PreparedStatement stmt = null;
    ResultSet rs = null;


    String HodQuery = "SELECT f.facultyID, f.FacultyName AS facultyName, d.DepartmentID FROM faculty f JOIN faculty_has_roles fhr ON f.facultyID = fhr.facultyID JOIN role r ON fhr.roleID = r.roleID JOIN department d ON f.DepartmentID = d.DepartmentID WHERE r.RoleID = 3";
    stmt = con.prepareStatement(HodQuery);
    rs = stmt.executeQuery();
    while(rs.next()){
        JSONObject hod = new JSONObject();
                hod.put("facultyID", rs.getString("facultyID"));
                hod.put("facultyName", rs.getString("facultyName"));
                hod.put("deptID", rs.getString("DepartmentID"));
                hodArray.put(hod);
    }
    CSEHOD = hodArray.getJSONObject(0).getString("facultyName");
    CSEID = hodArray.getJSONObject(0).getString("facultyID");
    

    ECEHOD = hodArray.getJSONObject(1).getString("facultyName");
    ECEID = hodArray.getJSONObject(1).getString("facultyID");

    EEEHOD = hodArray.getJSONObject(2).getString("facultyName");
    EEEID = hodArray.getJSONObject(2).getString("facultyID");

    MECHOD = hodArray.getJSONObject(3).getString("facultyName");
    MECID = hodArray.getJSONObject(3).getString("facultyID");

    ITHOD = hodArray.getJSONObject(4).getString("facultyName");
    ITID = hodArray.getJSONObject(4).getString("facultyID");

    CHEHOD = hodArray.getJSONObject(5).getString("facultyName");
    CHEID = hodArray.getJSONObject(5).getString("facultyID");

    CIVHOD = hodArray.getJSONObject(6).getString("facultyName");
    CIVID = hodArray.getJSONObject(6).getString("facultyID");

    DEHOD = hodArray.getJSONObject(7).getString("facultyName");
    DEID = hodArray.getJSONObject(7).getString("facultyID");


    String TotalQuery="select f.departmentid, sum(l.logcredit) AS Total from faculty f join log l on f.facultyid = l.facultyid group by f.departmentid";
    stmt = con.prepareStatement(TotalQuery);
    rs = stmt.executeQuery();
    while(rs.next()){
        JSONObject dept = new JSONObject();
                dept.put("deptID", rs.getString("departmentID"));
                dept.put("total", rs.getString("Total"));
                DeptArray.put(dept);
    }
    CSEHRS = DeptArray.getJSONObject(0).getString("total");
    ECEHRS = DeptArray.getJSONObject(1).getString("total");
    EEEHRS = DeptArray.getJSONObject(2).getString("total");
    MECHRS = DeptArray.getJSONObject(3).getString("total");
    ITHRS = DeptArray.getJSONObject(4).getString("total");
    CHEHRS = DeptArray.getJSONObject(5).getString("total");
    CIVHRS = DeptArray.getJSONObject(6).getString("total");
    DEHRS = DeptArray.getJSONObject(7).getString("total");

    String TopperQuery = "WITH LogSummary AS ( SELECT f.departmentid, f.facultyname, l.facultyid, SUM(l.logcredit) AS total_logcredit FROM log l JOIN faculty f ON l.facultyid = f.facultyid GROUP BY f.departmentid, l.facultyid ), RankedLogSummary AS ( SELECT departmentid, facultyname, facultyid, total_logcredit, ROW_NUMBER() OVER (PARTITION BY departmentid ORDER BY total_logcredit DESC) AS rnk FROM LogSummary ) SELECT departmentid, facultyname, facultyid, total_logcredit AS total FROM RankedLogSummary WHERE rnk = 1;";
    stmt = con.prepareStatement(TopperQuery);
    rs = stmt.executeQuery();
    while(rs.next()){
        JSONObject topper = new JSONObject();
                topper.put("deptID", rs.getString("departmentid"));
                topper.put("facultyName", rs.getString("facultyname"));
                topper.put("facultyID", rs.getString("facultyid"));
                topper.put("totalLogCredits", rs.getString("total"));
                TopperArray.put(topper);
    }

    CSETOPNAME = TopperArray.getJSONObject(0).getString("facultyName");
    CSETOPID = TopperArray.getJSONObject(0).getString("facultyID");
    CSETOPHRS = TopperArray.getJSONObject(0).getString("totalLogCredits");

    ECETOPNAME = TopperArray.getJSONObject(1).getString("facultyName");
    ECETOPID = TopperArray.getJSONObject(1).getString("facultyID");
    ECETOPHRS = TopperArray.getJSONObject(1).getString("totalLogCredits");

    EEETOPNAME = TopperArray.getJSONObject(2).getString("facultyName");
    EEETOPID = TopperArray.getJSONObject(2).getString("facultyID");
    EEETOPHRS = TopperArray.getJSONObject(2).getString("totalLogCredits");

    MECTOPNAME = TopperArray.getJSONObject(3).getString("facultyName");
    MECTOPID = TopperArray.getJSONObject(3).getString("facultyID");
    MECTOPHRS = TopperArray.getJSONObject(3).getString("totalLogCredits");

    ITTOPNAME = TopperArray.getJSONObject(4).getString("facultyName");
    ITTOPID = TopperArray.getJSONObject(4).getString("facultyID");
    ITTOPHRS = TopperArray.getJSONObject(4).getString("totalLogCredits");

    CHETOPNAME = TopperArray.getJSONObject(5).getString("facultyName");
    CHETOPID = TopperArray.getJSONObject(5).getString("facultyID");
    CHETOPHRS = TopperArray.getJSONObject(5).getString("totalLogCredits");

    CIVTOPNAME = TopperArray.getJSONObject(6).getString("facultyName");
    CIVTOPID = TopperArray.getJSONObject(6).getString("facultyID");
    CIVTOPHRS = TopperArray.getJSONObject(6).getString("totalLogCredits");

    DETOPNAME = TopperArray.getJSONObject(7).getString("facultyName");
    DETOPID = TopperArray.getJSONObject(7).getString("facultyID");
    DETOPHRS = TopperArray.getJSONObject(7).getString("totalLogCredits");


}
catch(Exception e){
    out.println(e);
}
}
}
%>

    <script>
            document.querySelector("#CSE #hod .card1 #name").innerHTML = "<strong>Name:   </strong> "+"<%= CSEHOD %>";
            document.querySelector("#CSE #hod .card1 #roll").innerHTML = "<strong>Faculty ID:   </strong> "+"<%= CSEID %>";
            document.querySelector("#CSE #hod .card1 #hours").innerHTML = "<strong>Total Dept working hours:   </strong> "+"<%= CSEHRS %>";

            document.querySelector("#ECE #hod .card1 #name").innerHTML = "<strong>Name:   </strong> "+"<%= ECEHOD %>";
            document.querySelector("#ECE #hod .card1 #roll").innerHTML = "<strong>Faculty ID:   </strong> "+"<%= ECEID %>";
            document.querySelector("#ECE #hod .card1 #hours").innerHTML = "<strong>Total Dept working hours:   </strong> "+"<%= ECEHRS %>";

            document.querySelector("#EEE #hod .card1 #name").innerHTML = "<strong>Name:   </strong> "+"<%= EEEHOD %>";
            document.querySelector("#EEE #hod .card1 #roll").innerHTML = "<strong>Faculty ID:   </strong> "+"<%= EEEID %>";
            document.querySelector("#EEE #hod .card1 #hours").innerHTML = "<strong>Total Dept working hours:   </strong> "+"<%= EEEHRS %>";

            document.querySelector("#Mech #hod .card1 #name").innerHTML = "<strong>Name:   </strong> "+"<%= MECHOD %>";
            document.querySelector("#Mech #hod .card1 #roll").innerHTML = "<strong>Faculty ID:   </strong> "+"<%= MECID %>";
            document.querySelector("#Mech #hod .card1 #hours").innerHTML = "<strong>Total Dept working hours:   </strong> "+"<%= MECHRS %>";

            document.querySelector("#Civil #hod .card1 #name").innerHTML = "<strong>Name:   </strong> "+"<%= CIVHOD %>";
            document.querySelector("#Civil #hod .card1 #roll").innerHTML = "<strong>Faculty ID:   </strong> "+"<%= CIVID %>";
            document.querySelector("#Civil #hod .card1 #hours").innerHTML = "<strong>Total Dept working hours:   </strong> "+"<%= CIVHRS %>";

            document.querySelector("#MBA #hod .card1 #name").innerHTML = "<strong>Name:   </strong> "+"<%= ITHOD %>";
            document.querySelector("#MBA #hod .card1 #roll").innerHTML = "<strong>Faculty ID:   </strong> "+"<%= ITID %>";
            document.querySelector("#MBA #hod .card1 #hours").innerHTML = "<strong>Total Dept working hours:   </strong> "+"<%= ITHRS %>";

            document.querySelector("#CSM #hod .card1 #name").innerHTML = "<strong>Name:   </strong> "+"<%= CHEHOD %>";
            document.querySelector("#CSM #hod .card1 #roll").innerHTML = "<strong>Faculty ID:   </strong> "+"<%= CHEID %>";
            document.querySelector("#CSM #hod .card1 #hours").innerHTML = "<strong>Total Dept working hours:   </strong> "+"<%= CHEHRS %>";

            document.querySelector("#DE #hod .card1 #name").innerHTML = "<strong>Name:   </strong> "+"<%= DEHOD %>";
            document.querySelector("#DE #hod .card1 #roll").innerHTML = "<strong>Faculty ID:   </strong> "+"<%= DEID %>";
            document.querySelector("#DE #hod .card1 #hours").innerHTML = "<strong>Total Dept working hours:   </strong> "+"<%= DEHRS %>";

            document.querySelector("#CSE #faculty .card1 #name").innerHTML = "<strong>Name:   </strong> "+"<%= CSETOPNAME %>";
            document.querySelector("#CSE #faculty .card1 #roll").innerHTML = "<strong>Faculty ID:   </strong> "+"<%= CSETOPID %>";
            document.querySelector("#CSE #faculty .card1 #hours").innerHTML = "<strong>Total working hours:   </strong> "+"<%= CSETOPHRS %>";

            document.querySelector("#ECE #faculty .card1 #name").innerHTML = "<strong>Name:   </strong> "+"<%= ECETOPNAME %>";
            document.querySelector("#ECE #faculty .card1 #roll").innerHTML = "<strong>Faculty ID:   </strong> "+"<%= ECETOPID %>";
            document.querySelector("#ECE #faculty .card1 #hours").innerHTML = "<strong>Total working hours:   </strong> "+"<%= ECETOPHRS %>";

            document.querySelector("#EEE #faculty .card1 #name").innerHTML = "<strong>Name:   </strong> "+"<%= EEETOPNAME %>";
            document.querySelector("#EEE #faculty .card1 #roll").innerHTML = "<strong>Faculty ID:   </strong> "+"<%= EEETOPID %>";
            document.querySelector("#EEE #faculty .card1 #hours").innerHTML = "<strong>Total working hours:   </strong> "+"<%= EEETOPHRS %>";

            document.querySelector("#Mech #faculty .card1 #name").innerHTML = "<strong>Name:   </strong> "+"<%= MECTOPNAME %>";
            document.querySelector("#Mech #faculty .card1 #roll").innerHTML = "<strong>Faculty ID:   </strong> "+"<%= MECTOPID %>";
            document.querySelector("#Mech #faculty .card1 #hours").innerHTML = "<strong>Total working hours:   </strong> "+"<%= MECTOPHRS %>";

            document.querySelector("#Civil #faculty .card1 #name").innerHTML = "<strong>Name:   </strong> "+"<%= CIVTOPNAME %>";
            document.querySelector("#Civil #faculty .card1 #roll").innerHTML = "<strong>Faculty ID:   </strong> "+"<%= CIVTOPID %>";
            document.querySelector("#Civil #faculty .card1 #hours").innerHTML = "<strong>Total working hours:   </strong> "+"<%= CIVTOPHRS %>";

            document.querySelector("#MBA #faculty .card1 #name").innerHTML = "<strong>Name:   </strong> "+"<%= ITTOPNAME %>";
            document.querySelector("#MBA #faculty .card1 #roll").innerHTML = "<strong>Faculty ID:   </strong> "+"<%= ITTOPID %>";
            document.querySelector("#MBA #faculty .card1 #hours").innerHTML = "<strong>Total working hours:   </strong> "+"<%= ITTOPHRS %>";

            document.querySelector("#CSM #faculty .card1 #name").innerHTML = "<strong>Name:   </strong> "+"<%= CHETOPNAME %>";
            document.querySelector("#CSM #faculty .card1 #roll").innerHTML = "<strong>Faculty ID:   </strong> "+"<%= CHETOPID %>";
            document.querySelector("#CSM #faculty .card1 #hours").innerHTML = "<strong>Total working hours:   </strong> "+"<%= CHETOPHRS %>";

            document.querySelector("#DE #faculty .card1 #name").innerHTML = "<strong>Name:   </strong> "+"<%= DETOPNAME %>";
            document.querySelector("#DE #faculty .card1 #roll").innerHTML = "<strong>Faculty ID:   </strong> "+"<%= DETOPID %>";
            document.querySelector("#DE #faculty .card1 #hours").innerHTML = "<strong>Total working hours:   </strong> "+"<%= DETOPHRS %>";

    
        // Fetch the data 
            var JsonData = '<%= jsonData %>';
            var data = JSON.parse(JsonData);
                if (!data) {
                    console.error("Error: Data not found in the response");
                }
    
                // Log the fetched data for debugging
                console.log("Fetched data:", data);
    
                // Extract data for the chart
                const departmentNames = data.map(item => item.departmentNames);
                const totalLogCredits = data.map(item => item.totalLogCredits);
                const avgLogCredits = data.map(item => item.avgLogCredits);
    
                // Log the extracted data for debugging
                console.log("Department Names:", departmentNames);
                console.log("Total Log Credits:", totalLogCredits);
                console.log("Average Log Credits:", avgLogCredits);
    
                // Render the chart
                new Chart(document.getElementById("myChart"), {
                    type: "bar",   // Change to 'line', 'pie', etc., as needed
                    data: {
                        labels: departmentNames,
                        datasets: [
                            {
                                label: "Total Credits",
                                data: totalLogCredits,
                                backgroundColor: "rgba(75, 192, 192, 1)",
                                borderColor: "rgba(28, 87, 87, 0.2)",
                                borderWidth: 1
                            },
                            {
                                label: "Average Credits",
                                data: avgLogCredits,
                                backgroundColor: "rgba(192, 75, 192, 0.2)",
                                borderColor: "rgba(192, 75, 192, 1)",
                                borderWidth: 1
                            }
                        ]
                    },
                    options: {
                        responsive: true,
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });

    </script>