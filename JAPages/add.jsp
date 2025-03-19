<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page errorPage="../exception.jsp" %>
<%@ include file="../cache.jsp" %>

<%  
    Connection con=null;
    PreparedStatement stmt=null;
    con = (Connection) session.getAttribute("dbConnection");
    int departmentId = (int) session.getAttribute("departmentId");
    int role = (int) session.getAttribute("role");
    String user = (String) session.getAttribute("userID");


        if(con == null) {
            %>
            <script>
            window.onload = function() {
                showToast("Database Connection lost", "error");
                setTimeout(() => {
                    window.location.href = "../logout.jsp";
                }, 3000);
            };
            </script>
            <%
        }
        if(role!=2){
            %>
            <script>
            window.onload = function() {
                showToast("You dont have authorized access to this page", "error");
                setTimeout(() => {
                    window.location.href = "../logout.jsp";
                }, 3000);
            };
            </script>
            <%
        }         
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <title>ADD Faculty</title>
    <link href="../src/navbar.css" rel="stylesheet">
    <%-- <link href="./junior-css.css" rel="stylesheet"> --%>
    <!-- Toastify CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
    <!-- Toastify JS -->
    <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
    <script src="./junior-script.js"></script>
    <script src="../src/js/scripts.js"></script>
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
        .active-category {
            background-color: white !important;
            color: #004080 !important;
            font-weight: bold;
        }

        .form-container {
            display: none;
            width: 80%;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            margin: 0 auto;
        }
        select{
            flex: 4;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
            border-color: #333;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }

        .input-group {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }

        label {
            flex: 1;
            font-weight: bold;
            color: #333;
            text-align: left;
            margin-right: 10px;
        }

        input {
            flex: 4;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
            border-color: #333;
        }

        .submit-div{
            text-align: center;
        }
        .submit-btn {
            width: 20%;
            background: #22438c;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s;
        }

        .submit-btn:hover {
            background: #112c66;
        }
    </style>

</head>
<body>
    <!-- Navbar -->
     <div class="navbar">
        <div class="nav-left">
            <a href="JAHome.jsp">Home</a>
            <a href="add.jsp">Add Faculty</a>
            <a href="update.jsp">Update Faculty</a>
            <a href="delete.jsp">Delete Faculty</a>
            <a href="JAToken.jsp">Tasks</a>
        </div>
        <div class="nav-right">
            <a href="JAProfile.jsp">Profile</a>
            <button id="logout" style="background: #004080; border: none; color: inherit; cursor: pointer; font: inherit; padding: 1px 10px;">Logout</button>
        </div>
    </div>

    <div class="side-menu">
        <ul>
            <li id="facultyAdd" onclick="showForm('faculty')">Add Faculty</li>
            <li id="roleAdd" onclick="showForm('role')">Add Role</li>
            <li id="committeeAdd" onclick="showForm('committee')">Add Committee</li>
          </ul>
    </div>

    <div id="main" class="main-content" >
        <div id="faculty" class="form-container" id="FormFaculty" method="post" action="add.jsp">
            <h2>Add New Faculty</h2>
            <form id="formIns">
                <div class="input-group">
                    <label >Faculty ID:</label>
                    <input type="text" id="facultyID" name="facultyID" required>
                </div>
    
                <div class="input-group">
                    <label >Faculty Name:</label>
                    <input type="text" id="facultyName" name="facultyName"  required>
                </div>
    
                <div class="input-group">
                    <label >Faculty Contact:</label>
                    <input type="tel" id="facultyContact" name="facultyContact" required>
                </div>
    
                <div class="input-group">
                    <label >Faculty Email:</label>
                    <input type="email" id="facultyEmail" name="facultyEmail" required>
                </div>
    
                <div class="input-group">
                    <label >Experience (Years):</label>
                    <input type="number" id="facultyExperience" name="facultyExperience" required>
                </div>
    
                <div class="input-group">
                    <label >Designation:</label>
                    <input type="text" id="facultyDesignation" name="facultyDesignation" required>
                </div>

                <div class="input-group">
                    <label >Staff type:</label>
                    <select id="StaffType" name="StaffType" required>
                    <option value="">select Staff Type</option>
                    <option value="1">Teaching Staff</option>
                    <option value="2">Non-Teaching Staff</option>
                    </select>
                </div>
    
                <div class="input-group">
                    <label >Password:</label>
                    <input type="password" id="facultyPassword" name="facultyPassword" required>
                </div>
    
                <div class="submit-div">
                    <button type="submit" id="submit-btn" class="submit-btn" name="submit-btn" value="faculty">Add</button>
                </div>
                
            </form>
        </div>


        <div id="role" class="form-container">
            <h2>Add New Role</h2>
            <form  method="post" id="FormRole" action="add.jsp">    
                <div class="input-group">
                    <label >Faculty Name:</label>
                    <select id="RoleFacultyName" name="RoleFacultyName" required>
                    <option value="">Select Faculty Name</option>
                    <%
                        try{
                            String FListQuery = "SELECT FacultyID, FacultyName FROM faculty where DepartmentID = ?";
                            stmt = con.prepareStatement(FListQuery);
                            stmt.setInt(1, departmentId);
                            ResultSet rs1 = stmt.executeQuery();
                            while(rs1.next()) {
                                %>
                                    <option value="<%= rs1.getString("FacultyID") %>"><%= rs1.getString("FacultyName") %></option>
                                <%
                            }
                        } catch(SQLException e) {
                            %>
                            <script>
                                showToast("<%=e.getMessage()%>", "error");
                            </script>
                            <%
                        }
                    %>
                    </select>

                </div>
    
                <div class="input-group">
                    <label >Faculty Role:</label>
                    <select id="rolename" name="rolename" required>
                        <option value="">select role</option>
                        <option value="1">Faculty</option>
                        <option value="2">Jr. Assistant</option>
                        <option value="3">HOD</option>
                        <option value="4">Higher Authority</option>
                    </select>
                </div>
    
                <div class="input-group">
                    <label >Password:</label>
                    <input type="password" id="rolePassword" name="rolePassword" required>
                </div>
    
                <div class="submit-div">
                    <button type="submit" class="submit-btn" id="submit-btn" name="submit-btn" value="role">Add</button>
                </div>
                
            </form>
        </div>

        <div id="committee" class="form-container">
            <h2>Add New Committee</h2>
            <form method="post" id="FormCommittee" action="add.jsp">    
                <div class="input-group">
                    <label >Faculty Name:</label>
                    <select id="comFacultyName" name="comFacultyName" required>
                    <option value="">select Faculty</option>

                    <%
                    try{
                        String FListQuery = "SELECT FacultyID, FacultyName FROM faculty where DepartmentID = ?";
                        stmt = con.prepareStatement(FListQuery);
                        stmt.setInt(1, departmentId);
                        ResultSet rs1 = stmt.executeQuery();
                        while(rs1.next()) {
                            %>
                                <option value="<%= rs1.getString("FacultyID") %>"><%= rs1.getString("FacultyName") %></option>
                            <%
                        }
                    } catch(SQLException e) {
                        %>
                        <script>
                            showToast("<%=e.getMessage()%>", "error");
                        </script>
                        <%
                    }
                    %>
                </select>
                </div>
                <div class="input-group">
                    <label >Category Name:</label>
                    <select id="categoryName" name="categoryName" required>
                        <option value="">select Category</option>

                    <%  
                    try{
                        String CatQuery = "SELECT * FROM `category`";
                        stmt = con.prepareStatement(CatQuery);
                        ResultSet rs1 = stmt.executeQuery();
                        while(rs1.next()) {
                            %>
                                <option value="<%= rs1.getString("CategoryID") %>"><%= rs1.getString("CategoryName") %></option>
                            <%
                        }
                    } catch(SQLException e) {
                        %>
                        <script>
                            showToast("<%=e.getMessage()%>", "error");
                        </script>
                        <%
                    }

                    %>
                    </select>
                </div>
    
                <div class="input-group">
                    <label >Committee Name:</label>
                    <input type="text" id="memberName" name="memberName" required>
                </div>
    
                <div class="submit-div">
                    <button type="submit" class="submit-btn" id="submit-btn" name="submit-btn" value="committee">Add</button>
                </div>
                
            </form>
        </div>
    </div>
</body>
</html>
<%
String button = request.getParameter("submit-btn");
if(button != null) {
    if(button.equals("faculty")) {
        String facultyID = request.getParameter("facultyID");
        String facultyName = request.getParameter("facultyName");
        String facultyContact = request.getParameter("facultyContact");
        String facultyEmail = request.getParameter("facultyEmail");
        String facultyExperience = request.getParameter("facultyExperience");
        String facultyDesignation = request.getParameter("facultyDesignation");
        String facultyPassword = request.getParameter("facultyPassword");
        String StaffType = request.getParameter("StaffType");

        if(facultyID == null || facultyName == null || facultyContact == null || facultyEmail == null || facultyExperience == null || facultyDesignation == null || facultyPassword == null) {
            %>
            <script>
                console.log("empty faculty fields");
            </script>
            <%
        }else{

        try {
            String query = "INSERT INTO `faculty` (`FacultyID`, `FacultyName`, `FacultyContact`, `FacultyEmail`, `FacultyExperience`, `FacultyDesignation`, `DepartmentID`, `StaffID`) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            stmt = con.prepareStatement(query);
            stmt.setString(1, facultyID);
            stmt.setString(2, facultyName);
            stmt.setString(3, facultyContact);
            stmt.setString(4, facultyEmail);
            stmt.setInt(5, Integer.parseInt(facultyExperience));
            stmt.setString(6, facultyDesignation);
            stmt.setInt(7,departmentId);
            stmt.setInt(8, Integer.parseInt(StaffType));
            int rs = stmt.executeUpdate();

            boolean facultyFlag = false;
            boolean roleFlag = false;
            boolean credentialsFlag = false;
            if(rs>0){
                facultyFlag = true;
            }
            String query2 = "INSERT INTO `faculty_has_roles` (`RoleID`, `FacultyID`) VALUES (1, ?)";
            stmt = con.prepareStatement(query2);
            stmt.setString(1, facultyID);
            int rs2 = stmt.executeUpdate();
            
            if(rs2>0){
                roleFlag = true;
            }

            String query3 = "INSERT INTO `credentials` (`FacultyID`, `RoleID`, `FacultyPassword`) VALUES (?, 1, ?)";
            stmt = con.prepareStatement(query3);
            stmt.setString(1, facultyID);
            stmt.setString(2, facultyPassword);
            int rs3 = stmt.executeUpdate();
            if(rs3>0){
                credentialsFlag = true;
            }
            if(facultyFlag && roleFlag && credentialsFlag){
                %>
                <script>
                    showToast("Faculty added successfully", "success");
                    document.getElementById("formIns").reset();
                </script>
                <%
                facultyFlag = roleFlag = credentialsFlag = false;
            }
            
        } catch(SQLException e) {
            %>
            <script>
                showToast("<%=e.getMessage()%>", "error");
            </script>
            <%
        }
        }
    } else if(button.equals("role")) {

        String facultyName = request.getParameter("RoleFacultyName");
        String roleName = request.getParameter("rolename");
        String rolePassword = request.getParameter("rolePassword");


        if(facultyName == null || roleName == null || rolePassword == null) {
            %>
            <script>
                console.log("empty role fields");
            </script>
            <%
        }

        try {
            String hodID="";
            String hodName="";
            if(roleName.equals("3")){
                stmt = con.prepareStatement("SELECT f.facultyID, f.FacultyName FROM faculty f JOIN faculty_has_roles fhr ON f.facultyID = fhr.facultyID JOIN role r ON fhr.roleID = r.roleID where f.DepartmentID = ? and r.RoleID = 3");
                stmt.setInt(1, departmentId);

                ResultSet hod = stmt.executeQuery();
                if(hod.next()){
                    hodID = hod.getString("facultyID");
                    hodName = hod.getString("FacultyName");
                    out.println("<script>console.log('"+hodID+' '+hodName+"')</script>");

                    out.println("<script>"+
                    "showToast('HOD role is assigned with ID: "+hodID+" and Name: "+hodName+"\\n To assign new HOD, remove previous HOD', 'error');</script>");

                }
                else{
                    String query = "INSERT INTO `faculty_has_roles` (`RoleID`, `FacultyID`) VALUES (?, ?)";
                    stmt = con.prepareStatement(query);
                    stmt.setString(1, roleName);
                    stmt.setString(2, facultyName);
                    int rs = stmt.executeUpdate();

                    boolean roleFlag = false;
                    boolean credentialsFlag = false;

                    if(rs>0){
                        roleFlag = true;
                    }
                    String query2 = "INSERT INTO `credentials` ( `FacultyID`, `FacultyPassword`, `RoleID`) VALUES ( ?, ?, ?)";
                    stmt = con.prepareStatement(query2);
                    stmt.setString(1, facultyName);
                    stmt.setString(2, rolePassword);
                    stmt.setString(3, roleName);
                    int rs2 = stmt.executeUpdate();
                    if(rs2>0){
                    credentialsFlag = true;
                    }
                    if(roleFlag && credentialsFlag){
                        %>
                        <script>
                            showToast("Role added successfully", "success");
                            document.getElementById("FormRole").reset()
                        </script>
                        <%
                        roleFlag = credentialsFlag = false;

                    }
                }
            }

            else{
                String query = "INSERT INTO `faculty_has_roles` (`RoleID`, `FacultyID`) VALUES (?, ?)";
                stmt = con.prepareStatement(query);
                stmt.setString(1, roleName);
                stmt.setString(2, facultyName);
                int rs = stmt.executeUpdate();

                boolean roleFlag = false;
                boolean credentialsFlag = false;

                if(rs>0){
                    roleFlag = true;
                }
                String query2 = "INSERT INTO `credentials` ( `FacultyID`, `FacultyPassword`, `RoleID`) VALUES ( ?, ?, ?)";
                stmt = con.prepareStatement(query2);
                stmt.setString(1, facultyName);
                stmt.setString(2, rolePassword);
                stmt.setString(3, roleName);
                int rs2 = stmt.executeUpdate();
                if(rs2>0){
                credentialsFlag = true;
                }
                if(roleFlag && credentialsFlag){
                    %>
                    <script>
                        showToast("Role added successfully", "success");
                        document.getElementById("FormRole").reset()
                    </script>
                    <%
                    roleFlag = credentialsFlag = false;

                }
            }
        } catch(SQLException e) {
            %>
            <script>
                showToast("<%=e.getMessage()%>", "error");
            </script>
            <%
        }
    }
    else if(button.equals("committee")) {
        String facultyName = request.getParameter("comFacultyName");
        String categoryName = request.getParameter("categoryName");
        String memberName = request.getParameter("memberName");
        out.println(facultyName);
        out.println(categoryName);
        out.println(memberName);
        if(facultyName == null || categoryName == null || memberName == null) {
            %>
            <script>
                console.log("empty committee fields");
            </script>
            <%
        }
        else{
            try {
                String query = "INSERT INTO `membership` (`MembershipID`, `FacultyID`, `CategoryID`, `MembershipName`) VALUES (NULL, ?, ?, ?)";
                stmt = con.prepareStatement(query);
                stmt.setString(1, facultyName);
                stmt.setInt(2, Integer.parseInt(categoryName));
                stmt.setString(3, memberName);
                int rs = stmt.executeUpdate();
                if(rs>0){
                    memberName="";
                    facultyName="";
                    categoryName="";
                    %>
                    <script>
                        
                        document.getElementById("memberName").value="";
                        document.getElementById("comFacultyName").value="";
                        document.getElementById("categoryName").value="";
                        console.log("<%=memberName%>");
                        console.log("<%=facultyName%>");
                        console.log("<%=categoryName%>");
                        showToast("Committee added successfully", "success");
                        document.getElementById("FormCommittee").reset();
                    </script>
                        
                    <%
                }
            } catch(SQLException e) {
                %>
                <script>
                    showToast("<%=e%>", "error");
                </script>
                <%
            }
        }

        

    }
}
%>