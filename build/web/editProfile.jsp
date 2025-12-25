<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Profile.bean.ProfileBean"%>

<%
    ProfileBean profile = (ProfileBean) request.getAttribute("profile");
    if (profile == null) { profile = new ProfileBean(); }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile</title>

    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

    <style>
        body {
            background-color: #e9f7f7; /* Matching profile.jsp */
            font-family: Arial, sans-serif;
        }

        .profile-card {
            max-width: 850px;
            margin: 70px auto;
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 18px rgba(0,0,0,0.15);
            overflow: hidden; /* This keeps the sidebar corners rounded */
        }

        /* Standardized Sidebar */
        .left-side {
            background-color: #e9f7f7; 
            padding: 60px 20px;
            text-align: center;
            border-right: 1px solid #dfecec;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: flex-start; /* Keeps items at the top like profile.jsp */
            gap: 20px;
            height: 100%; /* Ensures it fills the height of the row */
        }

        .left-side img {
            width: 130px;
            height: 130px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #009999;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        .right-side {
            padding: 40px 50px;
        }

        h2 {
            color: #009999;
            font-weight: 600;
            margin-bottom: 30px;
        }

        label {
            font-weight: bold;
            color: #007777;
            margin-bottom: 5px;
            display: block;
        }

        .form-control {
            border-radius: 8px;
            border: 1px solid #ced4da;
            padding: 10px;
        }

        .form-control:focus {
            border-color: #009999;
            box-shadow: 0 0 0 0.25rem rgba(0, 153, 153, 0.1);
        }

        .btn-custom {
            background-color: #009999;
            color: white;
            border-radius: 8px;
            padding: 10px 25px;
            border: none;
            transition: 0.3s;
        }

        .btn-custom:hover {
            background-color: #007777;
            color: white;
        }
        
        /* Matching the intro box style from profile.jsp */
        .intro-edit-area {
            background: #f2fafa;
            border-left: 4px solid #009999;
            border-radius: 4px;
        }
    </style>
</head>

<body>

<div class="container">
    <div class="profile-card">
        <!-- We use a single Row g-0 so the teal background touches the top/bottom perfectly -->
        <div class="row g-0">
            
            <!-- LEFT SIDE SIDEBAR (Teal) -->
            <div class="col-md-4">
                <div class="left-side">
                    <img src="https://cdn-icons-png.flaticon.com/512/1144/1144760.png" alt="Profile Icon">
                    <h4 style="color: #004d4d;"><%= profile.getName() %></h4>
                    <span class="badge bg-info text-dark px-3">Editing Mode</span>
                </div>
            </div>

            <!-- RIGHT SIDE CONTENT (White) -->
            <div class="col-md-8">
                <div class="right-side">
                    <h2>Edit Student Profile</h2>
                    
                    <form action="EditProfileServlet" method="post">
                        <!-- ID is hidden so user can't change it, but DB knows which row to update -->
                        <input type="hidden" name="id" value="<%= profile.getId() %>">

                        <div class="mb-3">
                            <label><i class="bi bi-person-fill"></i> Full Name</label>
                            <input type="text" name="name" class="form-control" value="<%= profile.getName() %>" required>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label><i class="bi bi-card-text"></i> Student ID</label>
                                <input type="text" name="studentId" class="form-control" value="<%= profile.getStudentId() %>" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label><i class="bi bi-mortarboard-fill"></i> Program</label>
                                <input type="text" name="program" class="form-control" value="<%= profile.getProgram() %>">
                            </div>
                        </div>

                        <div class="mb-3">
                            <label><i class="bi bi-envelope-fill"></i> Email</label>
                            <input type="email" name="email" class="form-control" value="<%= profile.getEmail() %>">
                        </div>

                        <div class="mb-3">
                            <label><i class="bi bi-heart-fill"></i> Hobbies</label>
                            <input type="text" name="hobbies" class="form-control" value="<%= profile.getHobbies() %>">
                        </div>

                        <div class="mb-4">
                            <label><i class="bi bi-chat-left-text-fill"></i> Self Introduction</label>
                            <textarea name="intro" class="form-control intro-edit-area" rows="4"><%= profile.getIntro() %></textarea>
                        </div>

                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-custom flex-grow-1">
                                <i class="bi bi-save"></i> Save Changes
                            </button>
                            <a href="viewProfiles.jsp" class="btn btn-secondary px-4">Cancel</a>
                        </div>
                    </form>
                </div>
            </div>

        </div> <!-- End Row -->
    </div> <!-- End Card -->
</div>

</body>
</html>