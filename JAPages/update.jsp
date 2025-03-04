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

    String ID=request.getParameter("facultyID");
   
    String button = request.getParameter("button");
    String Name="";
    String Contact="";
    String Email="";
    int Experience=0;
    String Designation="";
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
    
    if(button!=null && button.equals("search")) {
        out.println("<script>console.log('" + button + "');</script>");
        if(ID!=null){
            ID=request.getParameter("facultyID");
            out.println("<script>window.onload = function() {" +
            "document.getElementById('form-display').style.display = 'block';" +
            "document.getElementById('faculty').value = '" + ID + "';" +
            "};</script>");
            try{
                String FListQuery = "SELECT * FROM faculty where FacultyID = ?";
                stmt = con.prepareStatement(FListQuery);
                stmt.setString(1, ID);
                ResultSet rs1 = stmt.executeQuery();
                if(rs1.next()) {
                    Name=rs1.getString("FacultyName");
                    Contact=rs1.getString("FacultyContact");
                    Email=rs1.getString("FacultyEmail");
                    Experience=rs1.getInt("FacultyExperience");
                    Designation=rs1.getString("FacultyDesignation");
                }
                
            }catch(Exception e){
                out.println(e.getMessage());
                out.println("<script>console.log('" + e.getMessage() + "');</script>");

            }

        }
    }
    

    if(button!=null && button.equals("update")) {
        ID=request.getParameter("facultyID");
        out.println("<script>console.log('" + button + "');</script>");
        //out.println("<script>console.log('"+request.getParameter("facultyID")+"')</script>");
        String FacultyName = request.getParameter("facultyName");
        String FacultyContact = request.getParameter("facultyContact");
        String FacultyEmail = request.getParameter("facultyEmail");
        String FacultyExperience = request.getParameter("facultyExperience");
        String FacultyDesignation = request.getParameter("facultyDesignation");
        String FacultyID = ID;
        out.println("<script>console.log('"+FacultyName+"')</script>");
        out.println("<script>console.log('"+FacultyContact+"')</script>");
        out.println("<script>console.log('"+FacultyEmail+"')</script>");
        out.println("<script>console.log('"+FacultyExperience+"')</script>");
        out.println("<script>console.log('"+FacultyID+"')</script>");
        out.println("<script>console.log('"+FacultyDesignation+"');setTimeout(()=>{console.log('waiting')},5000)</script>");
        try{

            String FListQuery = "UPDATE faculty SET FacultyName=?, FacultyContact=?, FacultyEmail=?, FacultyExperience=?, FacultyDesignation=?  where FacultyID = ?";
            stmt = con.prepareStatement(FListQuery);
            stmt.setString(1, FacultyName);
            stmt.setString(2, FacultyContact);
            stmt.setString(3, FacultyEmail);
            stmt.setInt(4, Integer.parseInt(FacultyExperience));
            stmt.setString(5, (FacultyDesignation));
            stmt.setString(6, ID);
            int rs = stmt.executeUpdate();
            if(rs > 0) {
                %>
                <script>
                window.onload = function() {
                    showToast("Faculty details updated successfully!", "success");
                };
                </script>
                <%
            }
        } catch(SQLException e) {
            %>
            <script>
                showToast("<%=e.getMessage()%>", "error");
                console.log(e.getMessage());
            </script>
            <%
        }

    }
    

    
    

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Home Page</title>
    <link href="../src/navbar.css" rel="stylesheet">
    <link href="./junior-css.css" rel="stylesheet">
    <!-- jQuery & Select2 Library -->
    <link href="https://cdn.jsdelivr.net/npm/select2@4.0.13/dist/css/select2.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.0.13/dist/js/select2.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
    <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
    <script src="./junior-script.js"></script>
    <script src="../src/js/scripts.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            overflow-x: hidden; /* Prevents unwanted scrolling */
        }

        .main {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 80px 20px 20px;
        }

        .filters {
            display: flex;
            gap: 3%; /* Space between dropdowns */
            justify-content: center;
            align-items: center;
            flex-wrap: wrap;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width:95%;
        }

        /* Change the background and text color */
        .select2-container .select2-selection--single {
            background-color: #f4f4f9;
            color: #004080;
            border: 2px solid #004080;
            border-radius: 8px;
            padding: 20px;
            font-size: 16px;

            height: 40px !important;  /* Adjust height */
            display: flex !important;
            align-items: center !important;  /* Center text vertically */
        }

        /* Change the dropdown arrow */
        .select2-container--default .select2-selection--single .select2-selection__arrow b {
            border-color: #004080 transparent transparent transparent !important;
        }

        /* Change the dropdown list style */
        .select2-container--default .select2-results__option {
            color: #004080;
            background: white;
            padding: 10px;
            font-size: 16px;
        }

        /* Highlight hovered option */
        .select2-container--default .select2-results__option--highlighted {
            background-color: #004080 !important;
            color: white !important;
        }

        /* Adjust width */
        .select2-container {
            width: 200px !important;
            font-family:'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
        }

        form{
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
        }

        .dropdown-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-right: 2%;

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
            margin-top: 23%;
        }
        .searchBtn:hover {
            background-color: #2c7de8;
        }

        .form-container {
            width:70%;
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

        .submit-div{
            text-align: center;
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
        input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
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

    <!-- Main Content -->
    <div class="main">
        <h2>Update Existing Faculty Details</h2>
        <div class="filters">
            <form method="post" action="">
        
                <div class="dropdown-container">
                    <label for="faculty">Faculty</label>
                    <select id="faculty" name="facultyID">
                        <option value="">select faculty</option>
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

                

                <div >
                    <button class="searchBtn" type="submit"  name="button" value="search">Search</button>
                </div>
            </form>

            <form class="form-container" id="form-display" style="display:none" method="post" value="update.jsp">
            <div class="form-section">
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
                                    <td><input type="text" id="facultyName" name="facultyName" value="<%= Name != null ? Name : ""%> "></td>
                                </tr>
                                <tr>
                                    <td>Contact</td>
                                    <td><input type="text" id="facultyContact" name="facultyContact" value="<%= Contact != null ? Contact : "" %>"></td>
                                </tr>
                                <tr>
                                    <td>Email</td>
                                    <td><input type="email" id="facultyEmail" name="facultyEmail" value="<%= Email != null ? Email : "" %>"></td>
                                </tr>
                                <tr>
                                    <td>Experience</td>
                                    <td><input type="text" id="facultyExperience" name="facultyExperience" value="<%= Experience != 0 ? Experience : "" %>"></td>
                                </tr>
                                <tr>
                                    <td>Designation</td>
                                    <td><input type="text" id="facultyDesignation" name="facultyDesignation" value="<%= Designation != null ? Designation : "" %>"></td>
                                </tr>
                                <tr>
                                    <td>Password</td>
                                    <td><input type="password" id="facultyPassword" placeholder="enter password to confirm update" required value=""></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
            </div>
            <div class="submit-div"> 
                <button type="submit" class="submit-btn" value="update" name="button" >Update</button>
            </div>
        </form>

    </div>
    <%


%>
    <script>
        // for search bar in dropdown by external library
        $(document).ready(function() {
            $('#faculty').select2({
                placeholder: "Select an option",
                allowClear: true,
                dropdownParent: $(document.body) // Ensures dropdown isn't clipped
            });
        });
    </script>
</body>
</html>
