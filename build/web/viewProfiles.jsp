<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Profiles</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        body {
            background-color: #e9f7f7;
            font-family: Arial, sans-serif;
            padding-bottom: 50px;
        }

        .main-card {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 5px 18px rgba(0,0,0,0.15);
            margin-top: 50px;
        }

        .page-title {
            color: #009999;
            font-weight: 700;
        }

        .btn-custom {
            background-color: #009999;
            color: white;
            border-radius: 8px;
            transition: 0.3s;
            border: none;
        }

        .btn-custom:hover {
            background-color: #007777;
            color: white;
        }

        .table thead {
            background-color: #009999;
            color: white;
        }

        .table th {
            border: none;
            font-weight: 600;
        }

        .table td {
            vertical-align: middle;
            color: #444;
        }

        .dataTables_wrapper .dataTables_paginate .paginate_button.current {
            background: #009999 !important;
            color: white !important;
            border: 1px solid #009999 !important;
        }
        
        .form-control:focus {
            border-color: #009999;
            box-shadow: 0 0 0 0.2rem rgba(0, 153, 153, 0.25);
        }

        .action-btns .btn {
            border-radius: 6px;
            margin-right: 2px;
        }
    </style>
</head>

<body class="container">

    <div class="main-card">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="page-title mb-0">Student Profiles</h2>
                <p class="text-muted">Manage all registered student records</p>
            </div>
            <a href="ProfileForm.html" class="btn btn-custom px-4 py-2">
                <i class="bi bi-person-plus-fill me-1"></i> Add New Profile
            </a>
        </div>

        <div class="table-responsive">
            <table id="profileTable" class="table table-hover table-striped border">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Student ID</th>
                        <th>Program</th>
                        <th>Email</th>
                        <th class="text-center" style="width: 150px;">Actions</th>
                    </tr>
                </thead>

                <tbody>
                <%
                    Connection conn = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("org.apache.derby.jdbc.ClientDriver");
                        conn = DriverManager.getConnection("jdbc:derby://localhost:1527/student_profiles", "app", "app");

                        ps = conn.prepareStatement("SELECT * FROM profiles");
                        rs = ps.executeQuery();

                        while (rs.next()) {
                            int id = rs.getInt("id"); 
                %>
                    <tr>
                        <td class="fw-bold"><%= rs.getString("name") %></td>
                        <td><%= rs.getString("studentId") %></td>
                        <td><span class="badge bg-light text-dark border"><%= rs.getString("program") %></span></td>
                        <td><%= rs.getString("email") %></td>
                        <td class="action-btns text-center">

                            <a href="viewDetail.jsp?id=<%= id %>"
                               class="btn btn-sm btn-info text-white"
                               title="View Details">
                                <i class="bi bi-eye-fill"></i>
                            </a>

                            <a href="EditProfileServlet?id=<%= id %>"
                               class="btn btn-sm btn-warning text-dark"
                               title="Edit Profile">
                                <i class="bi bi-pencil-square"></i>
                            </a>

                            <button class="btn btn-sm btn-danger"
                                    title="Delete Profile"
                                    onclick="confirmDelete(<%= id %>)">
                                <i class="bi bi-trash-fill"></i>
                            </a>
                        </td>
                    </tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='5' class='text-danger'>Error: " + e.getMessage() + "</td></tr>");
                    } finally {
                        if (rs != null) rs.close();
                        if (ps != null) ps.close();
                        if (conn != null) conn.close();
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>

    <script>
        $(document).ready(function () {
            $('#profileTable').DataTable({
                "pageLength": 10,
                "language": {
                    "searchPlaceholder": "Search by name or ID...",
                    "search": ""
                }
            });
            $('.dataTables_filter input').addClass('form-control d-inline-block w-auto ms-2');
        });

        function confirmDelete(id) {
            Swal.fire({
                title: 'Are you sure?',
                text: "This student profile will be permanently removed.",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#d33',
                cancelButtonColor: '#6c757d',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = 'DeleteProfileServlet?id=' + id;
                }
            });
        }
    </script>

    <%
        if ("success".equals(request.getParameter("edit"))) {
    %>
    <script>
        Swal.fire({ icon: 'success', title: 'Updated!', text: 'Profile has been updated successfully.', timer: 2000, showConfirmButton: false });
    </script>
    <% } %>

    <%
        if ("success".equals(request.getParameter("delete"))) {
    %>
    <script>
        Swal.fire({ icon: 'success', title: 'Deleted!', text: 'Profile has been removed.', timer: 2000, showConfirmButton: false });
    </script>
    <% } %>

</body>
</html>