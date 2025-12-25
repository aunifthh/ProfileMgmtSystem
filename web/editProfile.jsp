<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Profile.bean.ProfileBean"%>

<%
    ProfileBean profile = (ProfileBean) request.getAttribute("profile");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow p-4">
        <h3 class="mb-4">Edit Profile</h3>

        <form action="EditProfileServlet" method="post">
            <input type="hidden" name="id" value="<%= profile.getId() %>">

            <div class="mb-3">
                <label>Name</label>
                <input type="text" name="name" class="form-control" value="<%= profile.getName() %>" required>
            </div>

            <div class="mb-3">
                <label>Student ID</label>
                <input type="text" name="studentId" class="form-control" value="<%= profile.getStudentId() %>" required>
            </div>

            <div class="mb-3">
                <label>Program</label>
                <input type="text" name="program" class="form-control" value="<%= profile.getProgram() %>">
            </div>

            <div class="mb-3">
                <label>Email</label>
                <input type="email" name="email" class="form-control" value="<%= profile.getEmail() %>">
            </div>

            <div class="mb-3">
                <label>Hobbies</label>
                <input type="text" name="hobbies" class="form-control" value="<%= profile.getHobbies() %>">
            </div>

            <div class="mb-3">
                <label>Self Introduction</label>
                <textarea name="intro" class="form-control"><%= profile.getIntro() %></textarea>
            </div>

            <button class="btn btn-primary">Update</button>
            <a href="viewProfiles.jsp" class="btn btn-secondary">Cancel</a>
        </form>
    </div>
</div>

</body>
</html>
