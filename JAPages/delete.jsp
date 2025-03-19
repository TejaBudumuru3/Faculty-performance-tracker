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

    String ID=request.getParameter("facultyID");
    String Name="";
    String Contact="";
    String Email="";
    int Experience=0;
    String Designation=""; 
    String Password="";   
    String Searchbutton = request.getParameter("search-button");
    String DeleteButton = request.getParameter("delete");
    String FRoleID="";

    String RoleID = request.getParameter("roleList");
    String RFacultyID = request.getParameter("RolefacultyID");
    String RName = "";
    String RDesignation = "";
    String RPassword="";

    String CFacultyId=request.getParameter("Cfaculty");
    String CName="";
    String Category=request.getParameter("category");
    String CategoryName = "";
    String Committee="";


if(Searchbutton != null ){
    
    if(Searchbutton.equals("faculty-search")){
        out.println("<script>window.onload = function(){document.querySelector('#faculty').style.display='block';"+
        "document.querySelector('#faculty #report-container').style.display='block';document.querySelector('#faculty #faculty').value = '" + ID + "'; };</script>");
        ID=request.getParameter("facultyID");
        out.println("<script>console.log('" + Searchbutton + "');</script>");
        out.println("<script>console.log('" + ID + "');</script>");

        if(ID!=null){
            if(Password!=null){
                try{
                    String FListQuery = "SELECT fr.RoleID, f.* FROM faculty f JOIN faculty_has_roles fr ON f.FacultyID = fr.facultyID JOIN role r ON fr.roleid = r.roleid WHERE f.FacultyID = ?";
                    stmt = con.prepareStatement(FListQuery);
                    stmt.setString(1, ID);
                    ResultSet rs1 = stmt.executeQuery();
                    if(rs1.next()) {
                        Name=rs1.getString("FacultyName");
                        Contact=rs1.getString("FacultyContact");
                        Email=rs1.getString("FacultyEmail");
                        Experience=rs1.getInt("FacultyExperience");
                        Designation=rs1.getString("FacultyDesignation");
                        FRoleID = rs1.getString("RoleID");
                    }
                    else{
                        out.println("<script>window.onload = function(){showToast('NO Faculty details found', 'error');};</script>");
                    }
                }catch(Exception e){
                    out.println(e.getMessage());
                    out.println("<script>console.log('" + e.getMessage() + "');</script>");
                }
            }

        }
    }
    if(Searchbutton.equals("role-search")){
        out.println("<script>window.onload = function(){document.getElementById('role').style.display='block';"+
        "document.querySelector('#role #report-container').style.display='block';document.getElementById('Rfaculty').value = '" + RFacultyID + "';" +
        "document.getElementById('RoleList').value='"+RoleID+"'};</script>");
        try{
            String RListQuery = "SELECT f.facultyID,f.FacultyName,f.FacultyDesignation FROM faculty f JOIN faculty_has_roles fr ON f.FacultyID = fr.facultyID JOIN role r ON fr.roleid = r.roleid WHERE r.roleid = ? AND f.FacultyID = ?";
            stmt = con.prepareStatement(RListQuery);
            stmt.setString(1, RoleID);
            stmt.setString(2, RFacultyID);
            ResultSet rs = stmt.executeQuery();
            if(rs.next()){
                RName = rs.getString("FacultyName");
                RDesignation = rs.getString("FacultyDesignation");
            }
            else{
                out.println("<script>window.onload = function(){showToast('Details not found', 'error');document.getElementById('role').style.display='block';};</script>");

            }
        }catch(Exception e){
            out.println(e.getMessage());
            out.println("<script>console.log('" + e.getMessage() + "');</script>");
        }

    }
    if(Searchbutton.equals("committe-search")){
        out.println("<script>window.onload = function(){document.getElementById('committee').style.display='block';"+
        "document.querySelector('#committee #report-container').style.display='block';document.getElementById('Cfaculty').value = '" + CFacultyId + "';" +
        "document.getElementById('category').value='"+Category+"'};</script>");
        try{
            String RListQuery = "SELECT f.facultyname, f.facultyID, m.categoryid, c.categoryname, m.membershipname FROM membership m JOIN faculty f ON m.facultyid = f.facultyid JOIN category c ON m.categoryid = c.categoryid WHERE m.facultyid = ? and m.categoryid = ?";
            stmt = con.prepareStatement(RListQuery);
            stmt.setString(1, CFacultyId);
            stmt.setString(2, Category);
            ResultSet rs = stmt.executeQuery();
            if(rs.next()){
                CName = rs.getString("facultyname");
                CategoryName = rs.getString("categoryname");
                Category = rs.getString("categoryid");
                Committee = rs.getString("membershipname");
            }
            else{
                out.println("<script>window.onload = function(){showToast('Details not found', 'error');document.getElementById('committee').style.display='block';};</script>");

            }
        }catch(Exception e){
            out.println(e.getMessage());
            out.println("<script>console.log('" + e.getMessage() + "');</script>");
        } 
    }
}
else{
//out.println("<script>console.log('Buttun empty');</script>");
}
boolean delete = false;
out.println("<script>console.log('"+RoleID+"');</script>");
//out.println("<script>console.log('"+DeleteButton+"');</script>");
if(DeleteButton != null){
    //out.println(DeleteButton);
    if(DeleteButton.equals("faculty-delete")){
        ID = request.getParameter("facultyID");
        Password = request.getParameter("facultyPassword");
        FRoleID = request.getParameter("FRoleID");
        //String role= request.getParameter(""); 
        out.println("<script>console.log('"+ID+"');</script>");
        out.println("<script>console.log('"+Password+"');</script>");
        out.println("<script>window.onload = function(){document.getElementById('faculty').style.display='block';"+
        "document.getElementById('report-container').style.display='block';};</script>");
        try{
            String PassQuery = "SELECT * FROM credentials where FacultyID = ? and FacultyPassword = ? and RoleID=? ";
            stmt = con.prepareStatement(PassQuery);
            stmt.setString(1, ID);
            stmt.setString(2, Password);
            stmt.setString(3, FRoleID);
            ResultSet rs  = stmt.executeQuery();
            if(rs.next()){
                out.println("<script>window.onload = function(){document.getElementById('faculty').style.display='block';"+
                "document.getElementById('report-container').style.display='none';};</script>");
                out.println("<script>console.log('Faculty deleted');</script>");
                delete = true;
            }
            else{
                out.println("<script>window.onload = function(){document.getElementById('faculty').style.display='block';"+
                    "document.getElementById('report-container').style.display='none';"+
                    "showToast('Invalid password!', 'error');};</script>");
            }
        }
        catch(Exception e){
            out.println(e.getMessage());
        }
        out.println("<script>console.log('"+delete+"');</script>");
        if(delete){
            try{
                String DeleteQuery = "DELETE FROM faculty WHERE FacultyID = ?";
                stmt = con.prepareStatement(DeleteQuery);
                stmt.setString(1, ID);
                int rowsDeleted = stmt.executeUpdate(); // Execute the query

                if (rowsDeleted > 0) { %>
                    <script>
                        window.onload = function() {
                            showToast("Faculty Deleted", "success");
                        };
                    </script>
                    <%
                    out.println("<script>console.log(' rows were deleted. FacultyID deleted');</script>");
                } else {%>
                    <script>
                        window.onload = function() {
                            showToast("Faculty deletion failed", "error");
                        };
                    </script>
                    <%
                    out.println("<script>console.log('No rows were deleted. FacultyID not found');</script>");
                }
            }
            catch(Exception e){
                %>
                    <script>
                        window.onload = function() {
                            showToast("<%= e.getMessage()%>", "error");
                        };
                    </script>
                    <%
            }
        }
    }

    if(DeleteButton.equals("role-delete")){
        RFacultyID = request.getParameter("RfacultyID");
        RPassword = request.getParameter("RfacultyPassword");
        RoleID = request.getParameter("roleID");
        
        //String role= request.getParameter(""); 
        out.println("<script>console.log('"+RFacultyID+"');</script>");
        out.println("<script>console.log('"+RPassword+"');</script>");
        out.println("<script>console.log('"+RoleID+"');</script>");
        out.println("<script>window.onload = function(){document.getElementById('role').style.display='block';"+
        "document.querySelector('#role #report-container').style.display='block';};</script>");
        try{
            String PassQuery = "SELECT * FROM credentials where FacultyID = ? and FacultyPassword = ? and RoleID=? ";
            stmt = con.prepareStatement(PassQuery);
            out.println("<script>console.log('"+RFacultyID+"');</script>");
            stmt.setString(1, RFacultyID);
            out.println("<script>console.log('"+RPassword+"');</script>");
            stmt.setString(2, RPassword);
            out.println("<script>console.log('"+RoleID+"');</script>");
            stmt.setString(3, RoleID);
            ResultSet rs  = stmt.executeQuery();
            if(rs.next()){
                out.println("<script>window.onload = function(){document.getElementById('role').style.display='block';"+
                "document.getElementById('report-container').style.display='none';};</script>");
                out.println("<script>console.log('Faculty deleted');</script>");
                delete = true;
            }
            else{
                out.println("<script>window.onload = function(){document.getElementById('role').style.display='block';"+
                    "document.getElementById('report-container').style.display='none';"+
                    "showToast('Invalid Password!', 'error');;};</script>");
            }
        }catch(Exception e){
            out.println(e);
        }

        if(delete){
            try{
                String DeleteQuery = "DELETE FROM faculty_has_roles WHERE FacultyID = ? and RoleID=?";
                stmt = con.prepareStatement(DeleteQuery);
                stmt.setString(1, RFacultyID);
                stmt.setString(2, RoleID);
                int rowsDeleted = stmt.executeUpdate(); // Execute the query

                if (rowsDeleted > 0) { %>
                    <script>
                        window.onload = function() {
                            showToast("Faculty Role Deleted", "success");
                        };
                    </script>
                    <%
                    out.println("<script>console.log(' rows were deleted. FacultyID role deleted');</script>");
                } else {%>
                    <script>
                        window.onload = function() {
                            showToast("Faculty Role deletion failed", "error");
                        };
                    </script>
                    <%
                    out.println("<script>console.log('No rows were deleted. FacultyID role not deleted');</script>");
                }
            }
            catch(Exception e){
                %>
                    <script>
                        window.onload = function() {
                            showToast("<%= e.getMessage()%>", "error");
                        };
                    </script>
                    <%
            }
        }
    }

    if(DeleteButton.equals("committe-delete")){
        CFacultyId = request.getParameter("CfacultyID");
        Category = request.getParameter("categoryID");
        CategoryName = request.getParameter("CfacultyCommitte");
        
        //String role= request.getParameter(""); 
        out.println("<script>console.log('"+CFacultyId+"');</script>");
        out.println("<script>console.log('"+Category+"');</script>");
        out.println("<script>console.log('"+CategoryName+"');</script>");
        out.println("<script>window.onload = function(){document.getElementById('committee').style.display='block';"+
        "document.querySelector('#committee #report-container').style.display='block';};</script>");
        try{
                String DeleteQuery = "DELETE FROM membership WHERE FacultyID = ? and CategoryID=? and MembershipName=?";
                stmt = con.prepareStatement(DeleteQuery);
                stmt.setString(1, CFacultyId);
                stmt.setString(2, Category);
                stmt.setString(3, CategoryName);
                int rowsDeleted = stmt.executeUpdate(); // Execute the query

                if (rowsDeleted > 0) { %>
                    <script>
                        window.onload = function() {
                            showToast("Faculty Committee Deleted", "success");
                        };
                    </script>
                    <%
                    out.println("<script>console.log(' rows were deleted. FacultyID Committee deleted');</script>");
                } else {%>
                    <script>
                        window.onload = function() {
                            showToast("Faculty Committee deletion failed", "error");
                        };
                    </script>
                    <%
                    out.println("<script>console.log('No rows were deleted. FacultyID Committee not deleted');</script>");
                }
            }
            catch(Exception e){
                %>
                    <script>
                        window.onload = function() {
                            showToast("<%= e.getMessage()%>", "error");
                        };
                    </script>
                    <%
            }

    }
}    
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <title>Delete Faculty</title>
    <link href="../src/navbar.css" rel="stylesheet">
    <link href="junior-css.css" rel="stylesheet">
    <!-- Toastify CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
    <!-- Toastify JS -->
    <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>

    <!-- jQuery & Select2 Library -->
    
    <link href="https://cdn.jsdelivr.net/npm/select2@4.0.13/dist/css/select2.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.0.13/dist/js/select2.min.js"></script>

    <script src="junior-script.js"></script>
    <script src="../src/js/scripts.js"></script>
    <style>
        .filters {
            display: flex;
            gap: 3%; 
            justify-content: center;
            align-items: center;
            flex-wrap: wrap;
            padding: 10px;
            width:95%;
        }

        .dropdown-container {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        label {
            font-size: 14px;
            font-weight: bold;
            margin-bottom: 5px;
            color: #004080;
        }

        .searchBtn {
            background-color: #004080;
            color: white;
            border: none;
            padding: 12px 20px;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s ease;
            font-size: 16px;
        }
        .searchBtn:hover {
            background-color: #2c7de8;
        }
        .report-container {
            width:99%;
        }
        .form-section {
            background-color: white;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 15px;
            border-radius: 8px;
            margin: 20px;
        }
        .form-section h2 {
            text-align: center;
            color: #004080;
            cursor: pointer;
        }
        .form-content {
            margin-top: 20px;
        }
        .form-content.active {
            display: block;
        }
        .form-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .form-table th, .form-table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }
        .form-table th {
            background-color: #004080;
            color: white;
        }
        .form-table tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .form-table tr:hover {
            background-color: #f1f1f1;
        }

        select {
            padding: 10px;
            width: 180px;
            border: 2px solid #004080;
            border-radius: 5px;
            font-size: 16px;
            background-color: white;
            cursor: pointer;
            outline: none;
            margin-bottom: 10px;
        }

        select:hover {
            border-color: #002b50;
        }

        select:focus {
            border-color: #001f3f;
            box-shadow: 0 0 5px rgba(0, 31, 63, 0.5);
        }

        .submit-div{
            text-align: center;
            margin-top:10px;
        }
        .submit-btn {
            width: 15%;
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
            <li id="facultyAdd" onclick="showForm('faculty')">Delete Faculty</li>
            <li id="roleAdd" onclick="showForm('role')">Delete Role</li>
            <li id="committeeAdd" onclick="showForm('committee')">Delete Committee</li>
          </ul>
    </div>

    <div id="main" class="main-content" >
        <div id="faculty" class="form-container">
            <h2>Delete Faculty</h2>
            <div class="filters">
                <form method="post" >
                    <div class="dropdown-container">
                        <select id="faculty" name="facultyID">
                            <option value="">Select Faculty</option>
                            <%
                                try{
                                    String FListQuery = "SELECT FacultyID, FacultyName FROM faculty where DepartmentID = ?";
                                    stmt = con.prepareStatement(FListQuery);
                                    stmt.setInt(1, departmentId);
                                    ResultSet rs1 = stmt.executeQuery();
                                    while(rs1.next()) {
                                        %>
                                            <option value="<%= rs1.getString("FacultyID") %>" name="FacultyID"><%= rs1.getString("FacultyName") %></option>
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


                    <div class="submit-div">
                        <button class="searchBtn" type="submit"  name="search-button" value="faculty-search">Search</button>
                    </div>
                </form>    
            </div>
            <p id="error"></p>
            <form class="form-section" method="post" action="delete.jsp" id="report-container" style="display:none">
                <h2 id="heading" >Faculty Details</span></h2>
                <div class="form-content">
                    <table class="form-table">
                        <thead>
                            <tr>
                                <th>Details</th>
                                <th>Value</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>ID</td>
                                <td><input type="text" id="facultyID" name="facultyID" value="<%= ID!= null ? ID : ""%>" readonly></td>
                            </tr>
                            <tr>
                                <td>Name</td>
                                <td><input type="text" id="facultyName" name="facultyName" value="<%= Name != null ? Name : ""%> " readonly></td>
                            </tr>
                            <tr>
                                <td>Contact</td>
                                <td><input type="text" id="facultyContact" name="facultyContact" value="<%= Contact != null ? Contact : "" %>" readonly></td>
                            </tr>
                            <tr>
                                <td>Email</td>
                                <td><input type="email" id="facultyEmail" name="facultyEmail" value="<%= Email != null ? Email : "" %>" readonly></td>
                            </tr>
                            <tr>
                                <td>Experience</td>
                                <td><input type="text" id="facultyExperience" name="facultyExperience" value="<%= Experience != 0 ? Experience : "" %>" readonly></td>
                            </tr>
                            <tr>
                                <td>Designation</td>
                                <td><input type="text" id="facultyDesignation" name="facultyDesignation" value="<%= Designation != null ? Designation : "" %>" readonly></td>
                            </tr>
                            <tr>
                                <td>Password</td>
                                <td><input type="password" id="facultyPassword" placeholder="enter password to confirm update" name="facultyPassword" required value=""></td>
                            </tr>
                                <input type="hidden" id="FRoleID" name="FRoleID" value="<%= FRoleID != null ? FRoleID : "" %>">
                        </tbody>
                    </table>
                </div>

                <div class="submit-div">
                <button class="searchBtn" type="submit"  name="delete" value="faculty-delete">Delete</button>
                </div>
            </form>

        </div>


        <div id="role" class="form-container">
            <h2>Delete Role</h2>
            <div class="filters">
                <form method="post" action="">
                    <div class="dropdown-container">

                            <select id="Rfaculty" name="RolefacultyID">
                                <option value="">Select Faculty</option>
                                <%
                                    try{
                                        String FListQuery = "SELECT FacultyID, FacultyName FROM faculty where DepartmentID = ?";
                                        stmt = con.prepareStatement(FListQuery);
                                        stmt.setInt(1, departmentId);
                                        ResultSet rs1 = stmt.executeQuery();
                                        while(rs1.next()) {
                                            %>
                                                <option value="<%= rs1.getString("FacultyID") %>" name="RFacultyID"><%= rs1.getString("FacultyName") %></option>
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

                            <select id="RoleList" name="roleList">
                                <option value="" >Select Role</option>
                                <option value="1">Faculty</option>
                                <option value="2">Jr. Assisstant</option>  
                                <option value="3">HOD</option>
                                <option value='4'>Higher Authority</option>                  
                            </select>
                    </div>
               
                    <div class="submit-div">
                        <button class="searchBtn" type="submit"  name="search-button" value="role-search">Search</button>
                    </div>
                </form>
            </div>

            <p id="error"></p>

            <form class="form-section" method="post" action="delete.jsp" id="report-container" style="display:none">
                <h2 id="heading" >Role Details</h2>
                <div class="form-content">
                    <table class="form-table">
                        <thead>
                            <tr>
                                <th>Details</th>
                                <th>Value</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Faculty Id</td>
                                <td><input type="text" id="RfacultyID" name="RfacultyID" value="<%= RFacultyID != null ? RFacultyID : ""%> " readonly></td>
                            </tr>
                            <tr>
                                <td>Name</td>
                                <td><input type="text" id="RfacultyName" name="RfacultyName" value="<%= RName != null ? RName : ""%> " readonly></td>
                            </tr>
                            <tr>
                                <td>Faculty Designation</td>
                                <td><input type="text" id="RfacultyDesignation" name="RfacultyDesignation" value="<%= RDesignation != null ? RDesignation : "" %>" readonly></td>
                            </tr>
                            <tr>
                                <td>Password</td>
                                <td><input type="password" id="RfacultyPassword" placeholder="enter password to confirm update" name="RfacultyPassword" required value=""></td>
                            </tr>
                            <input type="hidden" name="roleID" value="<%= RoleID != null ? RoleID : ""%> "
                        </tbody>
                    </table>
                </div>

                <div class="submit-div"> 
                    <button class="searchBtn" type="submit"  name="delete" value="role-delete">Delete</button>
                </div>

            </form>
        </div>

        <div id="committee" class="form-container">
            <h2>Delete Committee</h2>
            <div class="filters">
                <form method="post" action="">
                    <div class="dropdown-container">
                        <select id="Cfaculty" name="Cfaculty">
                            <option value="">Select Faculty</option>
                            <%
                                try{
                                    String FListQuery = "SELECT FacultyID, FacultyName FROM faculty where DepartmentID = ?";
                                    stmt = con.prepareStatement(FListQuery);
                                    stmt.setInt(1, departmentId);
                                    ResultSet rs1 = stmt.executeQuery();
                                    while(rs1.next()) {
                                        %>
                                            <option value="<%= rs1.getString("FacultyID") %>" ><%= rs1.getString("FacultyName") %></option>
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

                        <select id="category" name="category">
                            <option value="">Select Category</option>
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
                    <div class="submit-div">
                        <button class="searchBtn" type="submit"  name="search-button" value="committe-search">Search</button>
                    </div>
                </form>
            </div>

            <p id="error"></p>

            <form class="form-section" method="post" action="delete.jsp" id="report-container" style="display:none">
                <div class="form-section">
                    <h2 id="heading" >Committee Details</h2>
                    <div class="form-content">
                        <table class="form-table">
                            <thead>
                                <tr>
                                    <th>Details</th>
                                    <th>Value</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Faculty Id</td>
                                    <td><input type="text" id="CfacultyID" name="CfacultyID" value="<%= CFacultyId != null ? CFacultyId : ""%> " readonly></td>
                                </tr>
                                <tr>
                                    <td>Name</td>
                                    <td><input type="text" id="CfacultyName" name="CfacultyName" value="<%= CName != null ? CName : ""%> " readonly></td>
                                </tr>
                                <tr>
                                    <td>Category</td>
                                    <td><input type="text" id="CfacultyCategory" name="CfacultyCategory" value="<%= CategoryName != null ? CategoryName : "" %>" readonly></td>
                                </tr>
                                <tr>
                                    <td>Committee</td>
                                    <td><input type="text" id="CfacultyCommitte"  name="CfacultyCommitte"  value="<%= Committee != null ? Committee : "" %>" readonly></td>
                                </tr>
                                <input type="hidden" name="categoryID" value="<%= Category != null ? Category : ""%> ">
                            </tbody>
                        </table>
                    </div>
                
                    <div class="submit-div">
                            <button class="searchBtn" type="submit"  name="delete" value="committe-delete">Delete</button>
                    </div>
                </div>
            </form>
        </div>
    </div>




</body>
</html>
