<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile Details</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

    <style>
        body {
            background-color: #e9f7f7;
            font-family: Arial, sans-serif;
        }

        .profile-card {
            max-width: 850px;
            margin: 70px auto;
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 5px 18px rgba(0,0,0,0.15);
            overflow: hidden;
        }

        .left-side {
            background-color: #e9f7f7;
            padding: 50px 20px;
            text-align: center;
            border-right: 1px solid #dfecec;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 20px;
        }

        .left-side img {
            width: 140px;
            height: 140px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #009999;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        .left-side h4 {
            color: #004d4d;
            font-weight: 600;
            margin-top: 10px;
        }

        .right-side {
            padding: 40px;
        }

        h2 {
            color: #009999;
            font-weight: 600;
        }

        .list-group-item span {
            font-weight: bold;
            color: #007777;
        }

        .btn-custom {
            background-color: #009999;
            color: white;
            border-radius: 8px;
        }

        .btn-custom:hover {
            background-color: #007777;
            color: white;
        }

        .intro-box {
            background: #f2fafa;
            border-left: 4px solid #009999;
            padding: 12px 15px;
            border-radius: 6px;
            font-style: italic;
        }
    </style>
</head>

<body>

<div class="profile-card">
    <div class="text-center mb-4">
        <h2>Student Profile Detail</h2>
    </div>
    
    <%
        String studentIdParam = request.getParameter("id"); 
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection("jdbc:derby://localhost:1527/student_profiles", "app", "app");
            
            String query = "SELECT * FROM profiles WHERE id = ?";
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, Integer.parseInt(studentIdParam));
            rs = stmt.executeQuery();

            if (rs.next()) {
    %>

    <div class="row g-0">

        <!-- LEFT SIDE -->
        <div class="col-md-4 left-side">
            <img src="https://cdn-icons-png.flaticon.com/512/1144/1144760.png" alt="profile icon">
            <h4 class="mt-3">
                <%= rs.getString("name") %>
            </h4>
            <span class="badge bg-info text-dark">Student</span>
        </div>

        <!-- RIGHT SIDE -->
        <div class="col-md-8 right-side">
            <ul class="list-group list-group-flush mb-4">
                <li class="list-group-item bg-transparent">
                    <i class="bi bi-person-fill me-2"></i>
                    <span>Full Name:</span> <%= rs.getString("name") %>
                </li>

                <li class="list-group-item bg-transparent">
                    <i class="bi bi-card-text me-2"></i>
                    <span>Student ID:</span> <%= rs.getString("studentId") %>
                </li>

                <li class="list-group-item bg-transparent">
                    <i class="bi bi-mortarboard-fill me-2"></i>
                    <span>Program:</span> <%= rs.getString("program") %>
                </li>

                <li class="list-group-item bg-transparent">
                    <i class="bi bi-envelope-fill me-2"></i>
                    <span>Email:</span> <%= rs.getString("email") %>
                </li>

                <li class="list-group-item bg-transparent">
                    <i class="bi bi-heart-fill me-2"></i>
                    <span>Hobbies:</span> <%= rs.getString("hobbies") %>
                </li>

                <li class="list-group-item bg-transparent">
                    <i class="bi bi-chat-left-text-fill me-2"></i>
                    <span>Self Introduction:</span>
                    <div class="intro-box mt-2">
                        <%= rs.getString("intro") %>
                    </div>
                </li>
            </ul>
        </div>
    </div>
    
    <%
            } else {
    %>
        <div class="alert alert-warning text-center">No profile found for this ID.</div>
    <%
            }
        } catch (Exception e) {
            out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    %>

    <div class="mt-4 text-center">
        <a href="viewProfiles.jsp" class="btn btn-custom px-4">
            <i class="bi bi-arrow-left"></i> Back to List
        </a>
    </div>

</div>

</body>
</html>