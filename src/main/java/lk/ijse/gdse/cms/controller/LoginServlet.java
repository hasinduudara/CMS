package lk.ijse.gdse.cms.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.gdse.cms.dao.ComplaintDAO;
import lk.ijse.gdse.cms.dao.UserDAO;
import lk.ijse.gdse.cms.model.Complaint;
import lk.ijse.gdse.cms.model.Role;
import lk.ijse.gdse.cms.model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        User user = new UserDAO().login(username, password);

        if (user.getRole().equals(Role.EMPLOYEE)) {
            List<Complaint> complaints = new ComplaintDAO().getComplaintsByUser(user.getId());
            req.setAttribute("complaints", complaints);
            req.getRequestDispatcher("/jsp/employee/employee_dashboard.jsp").forward(req, resp);
        } else if (user.getRole().equals(Role.ADMIN)) {
            List<Complaint> allComplaints = new ComplaintDAO().getAllComplaints();
            req.setAttribute("allComplaints", allComplaints);
            req.getRequestDispatcher("/jsp/admin/dashboard.jsp").forward(req, resp);
        }

    }
}
