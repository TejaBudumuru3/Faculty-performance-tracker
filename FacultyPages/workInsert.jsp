<%@ page import="java.sql.*" %>
<%@ page import="java.sql.Date" %>
<%@ page language="java" contentType="text/html" %>
<%@ page errorPage="../exception.jsp" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.util.*" %>
<%@ include file="../cache.jsp" %> 

<%
    String user = (String) session.getAttribute("userID");
    int role = (int) session.getAttribute("role");

    
    Map<String, String> formData = new HashMap<>();
    Enumeration<String> parameterNames = request.getParameterNames();
    
    while (parameterNames.hasMoreElements()) {
        String paramName = parameterNames.nextElement();
        String paramValue = request.getParameter(paramName);
        formData.put(paramName, paramValue);
    }

    // Print the received data
    int classes = 0;
    int prep = 0;
    int reviews = 0;
    int counsel = 0;
    int invig = 0;
    int correction = 0;
    int viva = 0;
    int external = 0;
    int meeting = 0;
    int workshop = 0;
    int visit = 0;
    int seminar = 0;
    int started = 0;
    int pending = 0;
    int published = 0;
    int patent = 0;
    if (user == null) {
        response.sendRedirect("../index.jsp");
    }
    else{
        if(role != 1){
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
        else {
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            con = (Connection) session.getAttribute("dbConnection");
            if (con == null) {
                session.setAttribute("database error", "Database connection failed");
            }
            else{
                classes = Integer.parseInt(formData.get("classes"));
                prep = Integer.parseInt(formData.get("prep"));
                reviews = Integer.parseInt(formData.get("reviews"));
                counsel = Integer.parseInt(formData.get("counsel"));
                invig = Integer.parseInt(formData.get("invig"));
                correction = Integer.parseInt(formData.get("correction"));
                viva = Integer.parseInt(formData.get("viva"));
                external = Integer.parseInt(formData.get("external"));
                meeting = Integer.parseInt(formData.get("meeting"));
                workshop = Integer.parseInt(formData.get("workshop"));
                visit = Integer.parseInt(formData.get("visit"));
                seminar = Integer.parseInt(formData.get("seminar"));
                started = Integer.parseInt(formData.get("started"));
                pending = Integer.parseInt(formData.get("pending"));
                published = Integer.parseInt(formData.get("published"));
                patent = Integer.parseInt(formData.get("patent"));
                
                //current date
                LocalDate currentDate = LocalDate.now();
                Date formattedDate = Date.valueOf(currentDate);
                //String formattedDate = currentDate.toString();

                
                String InsertQ = "insert into Log (FacultyID, Date, ClassHours, PreparationTime, ProjectReview, CounsellingHours, InvigilationHours, ExamEvaluations, Viva, Externals, Meetings, Seminars, Workshops, EventHours, PublicationResearchWork, PublicationsPublished, PatentResearchWork, PatentsGained, LogCredit) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

                stmt = con.prepareStatement(InsertQ);
                stmt.setString(1, user);
                stmt.setDate(2, formattedDate);
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
                stmt.setInt(19, (classes + prep + reviews + counsel + invig + correction + viva + external + meeting + workshop + visit + seminar + started + published));
                int rowsAffected = stmt.executeUpdate();

                if (rowsAffected > 0) {
                    session.setAttribute("success", "Data inserted successfully");  
                } else {
                    session.setAttribute("failed", "Data insertion failed");
                }
            }
        }
        catch (Exception e) {
             session.setAttribute("catch", e);
        }
        String success = (String) session.getAttribute("success");
        String failed = (String) session.getAttribute("failed");
        if(success != null){
            session.removeAttribute("success");
             %>
        <script type="text/javascript">
            document.addEventListener("DOMContentLoaded", function() {
                toastr.success("<%= success%>");});
            </script>

        <%
        }
        
        else if(failed != null){
            session.removeAttribute("failed");
            %>
        <script type="text/javascript">
            document.addEventListener("DOMContentLoaded", function() {
                toastr.error("<%= failed%>");});
            </script>
        <%
        }
    }
    }


    
%>
<!DOCTYPE html>
        <html lang="en">
        <head>
            <title>Faculty Work Insert Form</title>
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

            
            <!-- Include toastr CSS -->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">

            <!-- Include jQuery -->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

            <!-- Include toastr JS -->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

            <script src="../src/js/scripts.js"></script>
        </head>
        <body>
            <!-- Navbar -->
            <div class="navbar">
                <div class="nav-left">
                    <a href="FacultyPage.jsp">Home</a>
                    <a href="workInsert.jsp">Work Update</a>
                    <a href="log.jsp">Logs</a>
                    <a href="token.jsp">Tasks</a>
                    <a href="report.jsp"> Reports </a>
                </div>
                <div class="nav-right">
                    <a href="profile.jsp">Profile</a>
                    <button id="logout" style="background: #004080; border: none; color: inherit; cursor: pointer; font: inherit; padding: 1px 10px;">Logout</button>
                </div>
            </div>

            <div class="side-menu">
                <ul>
                    <li id="GW" onclick="showForm('generalwork')">General Work</li>
                    <li id="EX" onclick="showForm('examination')">Examination</li>
                    <li id="MM" onclick="showForm('membership')">Club Activities</li>
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
                    <h2>Club Activities</h2>
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
                                <h2>Event hours</h2>
                                    <div class="form-group">
                                    <label for="indus-visits"> Event hours</label>
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
                                    <label for="pub-started">Publication Research Work</label>
                                    <input type="number" id="started" name="started" value="0">
                                </div>
                                <div class="form-group">
                                    <label for="description-publications">Description</label>
                                    <textarea id="description-publications" placeholder="Add any relevant details"></textarea>
                                </div>
                            </div>

                            <div id="pub-pending" class="tab-content">
                                <div class="form-group">
                                    <label for="pub-pending">Publications Published</label>
                                    <input type="number" id="pending" value="0">
                                </div>
                                <div class="form-group">
                                    <label for="description-publications">Description</label>
                                    <textarea id="description-publications" placeholder="Add any relevant details"></textarea>
                                </div>
                            </div>

                            <div id="pub-published" class="tab-content">
                                <div class="form-group">
                                    <label for="pub-published">Patent Research Work</label>
                                    <input type="number" id="published" value="0">
                                </div>
                                <div class="form-group">
                                    <label for="description-publications">Description (Optional)</label>
                                    <textarea id="description-publications" placeholder="Add any relevant details"></textarea>
                                </div>
                            </div>

                            <div id="patents" class="tab-content">
                                <div class="form-group">
                                    <label for="patents">Patents Published</label>
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
                    <form >
                        <div id="output"></div>
                    </form>
                </div>
            </div>

    </body>
</html>

