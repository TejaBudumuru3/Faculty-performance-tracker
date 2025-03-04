<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="java.time.LocalDate" %>
<%@ page errorPage="exception.jsp" %>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>

<%
    String user = (String) session.getAttribute("userID");
    if (user == null) {
        response.sendRedirect("index.jsp");
    }

    Connection con = null;
    PreparedStatement stmt = null;
    boolean showTable = false;
    Map<String, String> formData = new HashMap<>();

    try {
        con = (Connection) session.getAttribute("dbConnection");
        if (con == null) {
%>
            <script type="text/javascript">
                alert("Database connection failed!");
            </script>
<%
        } else if (request.getMethod().equalsIgnoreCase("POST") && request.getParameter("confirm_submission") == null) {
            // Step 1: Capture data and display table
            Enumeration<String> parameterNames = request.getParameterNames();
            while (parameterNames.hasMoreElements()) {
                String paramName = parameterNames.nextElement();
                String paramValue = request.getParameter(paramName);
                formData.put(paramName, paramValue);
            }
            showTable = true;
        } else if (request.getMethod().equalsIgnoreCase("POST") && request.getParameter("confirm_submission") != null) {
            // Step 2: Insert data into database after confirmation
            int classes = Integer.parseInt(request.getParameter("classes"));
            int prep = Integer.parseInt(request.getParameter("prep"));
            int reviews = Integer.parseInt(request.getParameter("reviews"));
            int counsel = Integer.parseInt(request.getParameter("counsel"));
            int invig = Integer.parseInt(request.getParameter("invig"));
            int correction = Integer.parseInt(request.getParameter("correction"));
            int viva = Integer.parseInt(request.getParameter("viva"));
            int external = Integer.parseInt(request.getParameter("external"));
            int meeting = Integer.parseInt(request.getParameter("meeting"));
            int workshop = Integer.parseInt(request.getParameter("workshop"));
            int visit = Integer.parseInt(request.getParameter("visit"));
            int seminar = Integer.parseInt(request.getParameter("seminar"));
            int started = Integer.parseInt(request.getParameter("started"));
            int pending = Integer.parseInt(request.getParameter("pending"));
            int published = Integer.parseInt(request.getParameter("published"));
            int patent = Integer.parseInt(request.getParameter("patent"));


                //current date
            LocalDate currentDate = LocalDate.now();
            String formattedDate = currentDate.toString();


            String insertSQL = "INSERT INTO Log values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            stmt = con.prepareStatement(insertSQL);
            stmt.setString(1, user);
            stmt.setString(2, formattedDate);
            stmt.setInt(3, classes);
            stmt.setInt(4, prep);
            stmt.setInt(5, reviews);
            stmt.setInt(6, counsel);
            stmt.setInt(7, invig);
            stmt.setInt(8, correction);
            stmt.setInt(9, viva);
            stmt.setInt(10, external);
            stmt.setInt(11, meeting);
            stmt.setInt(12, workshop);
            stmt.setInt(13, visit);
            stmt.setInt(14, seminar);
            stmt.setInt(15, started);
            stmt.setInt(16, pending);
            stmt.setInt(17, published);
            stmt.setInt(18, patent);
            stmt.setInt(19, (classes + prep + reviews + counsel + invig + correction + viva + external + meeting + workshop + visit + seminar + started + pending + published + patent));
            int rowsAffected = stmt.executeUpdate();

           %>
           <script type="text/javascript">
                    console.log("classes: <%=classes%>");
                    console.log("prep: <%=prep%>");
                    console.log("reviews: <%=reviews%>");
                    console.log("counsel: <%=counsel%>");
                    console.log("invig: <%=invig%>");
                    console.log("correction: <%=correction%>");
                    console.log("viva: <%=viva%>");
                    console.log("external: <%=external%>");
                    console.log("meeting: <%=meeting%>");
                    console.log("workshop: <%=workshop%>");
                    console.log("visit: <%=visit%>");
                    console.log("seminar: <%=seminar%>");
                    console.log("started: <%=started%>");
                    console.log("pending: <%=pending%>");
                    console.log("published: <%=published%>");
                    console.log("patent: <%=patent%>");
                    console.log("time: <%=formattedDate%>");
            </script>

           <%

            if (rowsAffected > 0) {
                %>
                <script type="text/javascript">
                    alert("Data inserted successfully!");
                </script>
                <%
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (stmt != null) stmt.close();
    }
%>
    <!DOCTYPE html>
        <html lang="en">
        <head>
            <title>Work Form</title>
            <link href="./src/navbar.css" rel="stylesheet">
            <style>
                body {
                    background-color: #f4f4f9;
                }
                .side-menu {
                    width: 15%;
                    background-color: #004080;
                    color: white;
                    position: fixed;
                    top: 10%;
                    bottom: 0%;
                    padding: 1% 0%;
                    overflow-y: auto;
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
                    padding: 0% 3%;
                    border-radius: 8px;
                }

                .form-group {
                    margin-bottom: 1%;
                }

                .form-group label {
                    display: block;
                    font-weight: bold;
                    margin-bottom: 1%;
                }

                .form-group input, .form-group textarea {
                    width: 97%;
                    padding: 1%;
                    border: 1px solid #ccc;
                    border-radius: 5px;
                }
                .tabs {
                    margin-top: 20px;
                }
                
                .tab-content {
                    
                    padding: 2%;
                    background-color: white;
                    border-radius: 8px;
                    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                    margin-top: 2%;
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
                .submit-container{
                    padding:0% 10% 5% 10%;   
                }
                
            </style>

            <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>  
            <%-- <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>  
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>  
            
            <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet"/>  
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">  

            <script src="./src/js/scripts.js"></script> --%>
        </head>
        <body>
            <!-- Navbar -->
            <script src="./src/js/scripts.js"></script>
            <div class="navbar">
                <div class="nav-left">
                   <!-- <a href="FacultyPage.html" class="logo"></a> -->
                    <a href="FacultyPage.jsp">Home</a>
                    <a href="workUpdate.jsp">Work Update</a>
                    <a href="reports.html">Reports</a>
                    <a href="notifications.html">Notifications</a>
                </div>
                <div class="nav-right">
                    <a href="profile.jsp">Profile</a>
                    <a href="logout.jsp">Logout</a>
                </div>
            </div>

            <div class="side-menu">
                <ul>
                    <li id="GW" onclick="showForm('generalwork')">General Work</li>
                    <li id="EX" onclick="showForm('examination')">Examination</li>
                    <li id="MM" onclick="showForm('membership')">Membership</li>
                    <li id="PB" onclick="showForm('publications')">Publications</li>
                </ul>
            </div>

            <div id="main" class="main-content" >
                <div id="generalwork" class="form-container">
                    <h2>General Work</h2>
                    <form id="myForm">
                        <div class="tabs">
                            <div id="class-hours" class="tab-content">
                                <h2>class-hours</h2>
                                <div class="form-group">
                                    <label for="class-hours">Class-hours</label>
                                    <input type="number" id="classes" name="class-hours" value="0" >
                                </div>
                                    
                                <div class="form-group">
                                    <label for="description-general">Description </label>
                                    <textarea id="description-general" placeholder="Enter description"></textarea>
                                </div>
                                
                            </div>
                
                            <div id="preparation" class="tab-content">
                                <h2>Preparation hours</h2>
                                <div class="form-group">
                                    <label for="prep-time">Preparation time for teaching</label>
                                    <input type="number" id="prep" value="0">
                                </div>
                                
                                <div class="form-group">
                                    <label for="description-general">Description</label>
                                    <textarea id="description-general" placeholder="Enter description"></textarea>
                                </div>
                            </div>
                
                            <div id="review" class="tab-content">
                                <h2>Project review</h2>
                                <div class="form-group">
                                    <label for="review">Project review hours</label>
                                    <input type="number" id="reviews" value="0">
                                </div>
                                
                                <div class="form-group">
                                    <label for="description-general">Description</label>
                                    <textarea id="description-general" placeholder="Enter description"></textarea>
                                </div>
                            </div>
                
                            <div id="Counselling" class="tab-content">
                                <h2>counselling Hours</h2>
                                <div class="form-group">
                                    <label for="counselling">counselling hours</label>
                                    <input type="number" id="counsel" value="0">
                                </div>
                                
                                <div class="form-group">
                                    <label for="description-general">Description </label>
                                    <textarea id="description-general" placeholder="Enter description"></textarea>
                                </div>
                            </div>
                        </div>
                        
                    </form>
                    <div class="button-container">
                    <button type="button" class="next-btn" onclick="nextTab('generalwork', 'examination')">Next</button>
                    </div>
                </div>

                <!-- ----------------------------------------     Examination work   ------------------------------------------------ -->

                <div id="examination" class="form-container">
                    <h2>Examination Work</h2>
                        <form id="myForm">
                            <div class="tabs">
                                <div id="Invigilation" class="tab-content">
                                    <h2>Invigilation</h2>
                                    <div class="form-group">
                                        <label for="Invigilation">Invigilation hours</label>
                                        <input type="number" id="invig" name="class-hours" value="0">
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="description-exam">Description </label>
                                        <textarea id="description-exam" placeholder="Enter description"></textarea>
                                    </div>
                                </div>

                                <div id="paper-correction" class="tab-content">
                                    <h2>paper correction</h2>
                                    <div class="form-group">
                                        <label for="paper-correction">paper correction hours</label>
                                        <input type="number" id="correction" value="0">
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="description-exam">Description</label>
                                        <textarea id="description-exam" placeholder="Enter description"></textarea>
                                    </div>
                                </div>

                                <div id="viva" class="tab-content">
                                    <h2>viva</h2>
                                        <div class="form-group">
                                        <label for="viva">viva hours</label>
                                        <input type="number" id="viva" value="0">
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="description-exam">Description</label>
                                        <textarea id="description-exam" placeholder="Enter description"></textarea>
                                    </div>
                                </div>

                                <div id="Externals" class="tab-content">
                                    <h2>Externals</h2>
                                    <div class="form-group">
                                        <label for="Externals">Externals hours</label>
                                        <input type="number" id="external" value="0">
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="description-exam">Description </label>
                                        <textarea id="description-exam" placeholder="Enter description"></textarea>
                                    </div>
                                </div>
                            </div>               
                        </form>
                        <div class="button-container">
                            <button type="button" class="prev-btn" onclick="prevTab('examination', 'generalwork')">Previous</button>
                            <button type="button" class="next-btn" onclick="nextTab('examination', 'membership')">Next</button>
                        </div>
                </div>
               <!-- ----------------------------------------     Membership work   ------------------------------------------------ -->
                <div id="membership" class="form-container">
                    <h2>Membership Work</h2>
                    <form id="myForm">
                        <div id="examination" class="tabs">
                            <div id="meetings" class="tab-content">
                                <h2>Meetings</h2>
                                <div class="form-group">
                                    <label for="meetings">Meeting hours</label>
                                    <input type="number" id="meeting" name="Meeting-hours" value="0">
                                </div>
                                
                                <div class="form-group">
                                    <label for="description-membership">Description </label>
                                    <textarea id="description-membership" placeholder="Enter description"></textarea>
                                </div>
                            </div>

                            <div id="workshops" class="tab-content">
                                <h2>Workshops</h2>
                                <div class="form-group">
                                    <label for="workshops">Workshop hours</label>
                                    <input type="number" id="workshop" value="0">
                                </div>
                                
                                <div class="form-group">
                                    <label for="description-membership">Description</label>
                                    <textarea id="description-membership" placeholder="Enter description"></textarea>
                                </div>
                            </div>

                            <div id="indus-visits" class="tab-content">
                                <h2>Industrial visit</h2>
                                    <div class="form-group">
                                    <label for="indus-visits">Industrial visiting hours</label>
                                    <input type="number" id="visit" value="0">
                                </div>
                                
                                <div class="form-group">
                                    <label for="description-membership">Description</label>
                                    <textarea id="description-membership" placeholder="Enter description"></textarea>
                                </div>
                            </div>

                            <div id="seminars" class="tab-content">
                                <h2>Seminars</h2>
                                    <div class="form-group">
                                    <label for="seminars">Seminar hours</label>
                                    <input type="number" id="seminar" value="0">
                                </div>
                                
                                <div class="form-group">
                                    <label for="description-membership">Description </label>
                                    <textarea id="description-membership" placeholder="Enter description"></textarea>
                                </div>
                            </div>
                        </div>               
                    </form>
                    <div class="button-container">
                        <button type="button" class="prev-btn" onclick="prevTab('membership', 'examination')">Previous</button>
                        <button type="button" class="next-btn" onclick="nextTab('membership', 'publications')">Next</button>
                    </div>
                </div>

                <!-- ----------------------------------------     Publications work   ------------------------------------------------ -->

                    
                <div id="publications" class="form-container">
                    <h2>Publications Work</h2>
                    <form id="myForm">
                        <div id="publications" class="tabs"></div>
                            <div id="pub-started" class="tab-content">
                                <div class="form-group">
                                    <label for="pub-started">Started</label>
                                    <input type="number" id="started" name="started" value="0">
                                </div>
                                <div class="form-group">
                                    <label for="description-publications">Description</label>
                                    <textarea id="description-publications" placeholder="Add any relevant details"></textarea>
                                </div>
                            </div>

                            <div id="pub-pending" class="tab-content">
                                <div class="form-group">
                                    <label for="pub-pending">Pending</label>
                                    <input type="number" id="pending" value="0">
                                </div>
                                <div class="form-group">
                                    <label for="description-publications">Description</label>
                                    <textarea id="description-publications" placeholder="Add any relevant details"></textarea>
                                </div>
                            </div>

                            <div id="pub-published" class="tab-content">
                                <div class="form-group">
                                    <label for="pub-published">Published</label>
                                    <input type="number" id="published" value="0">
                                </div>
                                <div class="form-group">
                                    <label for="description-publications">Description (Optional)</label>
                                    <textarea id="description-publications" placeholder="Add any relevant details"></textarea>
                                </div>
                            </div>

                            <div id="patents" class="tab-content">
                                <div class="form-group">
                                    <label for="patents">No. of Patents</label>
                                    <input type="number" id="patent" value="0">
                                </div>
                                <div class="form-group">
                                    <label for="description-publications">Description (Optional)</label>
                                    <textarea id="description-publications" placeholder="Add any relevant details"></textarea>
                                </div>
                            </div>
                            <div class="button-container">
                                <button type="button" class="prev-btn" onclick="prevTab('publications', 'membership')">Previous</button>
                                <button type="button" class="next-btn" onclick="submitForm()">Submit</button>
                            </div>
                        </div>
                    </form>
                </div>
<div id=submitdiv class="submit-container">

        <div id="output">
        <%-- <% if (showTable) { %>
            <h2 style="text-align: center">Your Data Submitted Successfully</h2>
            <table border="1">
                <tr><th>Field</th><th>Value</th></tr>
                <% for (Map.Entry<String, String> entry : formData.entrySet()) { %>
                    <tr><td><%= entry.getKey() %></td><td><%= entry.getValue() %></td></tr>
                <% } %>
            </table>
            <form method="POST">
                <% for (Map.Entry<String, String> entry : formData.entrySet()) { %>
                    <input type="hidden" name="<%= entry.getKey() %>" value="<%= entry.getValue() %>">
                <% } %>
                <input type="hidden" name="confirm_submission" value="yes">
                <button type="submit">Okay</button>
            </form>
        <% } %> --%>
    </div>
    </div>
</body>
</html>

