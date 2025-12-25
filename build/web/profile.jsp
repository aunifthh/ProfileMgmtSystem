<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Profile.bean.ProfileBean"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Profile</title>

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
    .info-card i {
        font-size: 20px;
    }
</style>

</head>

<body>

<div class="profile-card">
    <div class="text-center mb-4">
        <h2>Profile Details</h2>
    </div>
    
    <%
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DriverManager.getConnection("jdbc:derby://localhost:1527/student_profiles", "app", "app");
            String query = "SELECT * FROM Profiles ORDER BY EMAIL DESC FETCH FIRST ROW ONLY";
            stmt = conn.prepareStatement(query);
            rs = stmt.executeQuery();

            if (rs.next()) {
    %>

    <div class="row g-0">

        <!-- LEFT SIDE -->
        <div class="col-4 left-side">
            <img src="https://cdn-icons-png.flaticon.com/512/1144/1144760.png"
                 alt="profile icon"
                 style="width: 120px; height: 120px; border-radius: 70%; object-fit: cover;">

            <h4 class="mt-3">
                <%= request.getAttribute("name") %>
            </h4>
        </div>

        <!-- RIGHT SIDE -->
        <div class="col-8 right-side">
            <ul class="list-group mb-4">
                <li class="list-group-item">
                    <i class="bi bi-person-fill me-2"></i>
                    <span>Name:</span> <%= request.getAttribute("name") %>
                </li>

                <li class="list-group-item">
                    <i class="bi bi-card-text me-2"></i>
                    <span>Student ID:</span> <%= request.getAttribute("studentId") %>
                </li>

                <li class="list-group-item">
                    <i class="bi bi-mortarboard-fill me-2"></i>
                    <span>Program:</span> <%= request.getAttribute("program") %>
                </li>

                <li class="list-group-item">
                    <i class="bi bi-envelope-fill me-2"></i>
                    <span>Email:</span> <%= request.getAttribute("email") %>
                </li>

                <li class="list-group-item">
                    <i class="bi bi-heart-fill me-2"></i>
                    <span>Hobbies:</span> <%= request.getAttribute("hobbies") %>
                </li>

                <li class="list-group-item">
                    <i class="bi bi-chat-left-text-fill me-2"></i>
                    <span>Self Introduction:</span>
                    <div class="intro-box">
                        <%= request.getAttribute("intro") %>
                    </div>
                </li>
            </ul>
        </div>
    </div>
    
        <%
            } else {
    %>
        <p class="text-center text-muted">No profile found.</p>
    <%
            }
        } catch (SQLException e) {
            out.println("<p class='text-danger'>Error retrieving profile: " + e.getMessage() + "</p>");
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    %>

    <div class="mt-4 text-center">
        <a href="viewProfiles.jsp" class="btn btn-custom px-4">Other Students Info</a>
        <a href="ProfileForm.html" class="btn btn-secondary ms-2">Back to Form</a>
    </div>

</div>

</body>
</html>
