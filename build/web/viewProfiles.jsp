<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Profiles</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body class="container mt-5">

<h2 class="mb-4">All Student Profiles</h2>

<table class="table table-bordered table-striped">
    <thead class="table-dark">
        <tr>
            <th>No.</th>
            <th>Name</th>
            <th>Student ID</th>
            <th>Program</th>
            <th>Email</th>
            <th>Actions</th>
        </tr>
    </thead>

    <tbody>
    <%
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(
                "jdbc:derby://localhost:1527/student_profiles", "app", "app");

            ps = conn.prepareStatement("SELECT * FROM profiles");
            rs = ps.executeQuery();

            while (rs.next()) {
    %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("studentId") %></td>
            <td><%= rs.getString("program") %></td>
            <td><%= rs.getString("email") %></td>
            <td>
                <a href="EditProfileServlet?id=<%= rs.getInt("id") %>" 
                   class="btn btn-sm btn-warning">Edit</a>

                <button class="btn btn-sm btn-danger"
                        onclick="confirmDelete(<%= rs.getInt("id") %>)">
                    Delete
                </button>
            </td>
        </tr>
    <%
            }
        } catch (Exception e) {
            out.println(e.getMessage());
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
    %>
    </tbody>
</table>

<script>
    function confirmDelete(id) {
        Swal.fire({
            title: 'Are you sure?',
            text: "This profile will be deleted!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            confirmButtonText: 'Yes, delete it!'
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = 'DeleteProfileServlet?id=' + id;
            }
        })
    }
</script>
</body>
</html>
