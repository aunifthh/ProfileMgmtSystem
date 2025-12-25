package Profile.info;

import Profile.bean.ProfileBean;
import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class EditProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        try {
            Connection conn = DriverManager.getConnection(
                "jdbc:derby://localhost:1527/student_profiles","app","app");

            PreparedStatement ps =
                conn.prepareStatement("SELECT * FROM profiles WHERE id=?");
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                ProfileBean profile = new ProfileBean();
                profile.setId(id);
                profile.setName(rs.getString("name"));
                profile.setStudentId(rs.getString("studentId"));
                profile.setProgram(rs.getString("program"));
                profile.setEmail(rs.getString("email"));
                profile.setHobbies(rs.getString("hobbies"));
                profile.setIntro(rs.getString("intro"));

                request.setAttribute("profile", profile);
            }

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("editProfile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        try {
            Connection conn = DriverManager.getConnection(
                "jdbc:derby://localhost:1527/student_profiles","app","app");

            String sql = "UPDATE profiles SET name=?, studentId=?, program=?, "
                       + "email=?, hobbies=?, intro=? WHERE id=?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, request.getParameter("name"));
            ps.setString(2, request.getParameter("studentId"));
            ps.setString(3, request.getParameter("program"));
            ps.setString(4, request.getParameter("email"));
            ps.setString(5, request.getParameter("hobbies"));
            ps.setString(6, request.getParameter("intro"));
            ps.setInt(7, id);

            ps.executeUpdate();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("viewProfiles.jsp?edit=success");
    }
}
