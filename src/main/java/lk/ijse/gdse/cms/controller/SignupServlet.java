package lk.ijse.gdse.cms.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.gdse.cms.dao.UserDAO;
import lk.ijse.gdse.cms.model.User;

import java.io.IOException;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String role = req.getParameter("role");

        // Optionally hash the password here
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setRole(role);

        boolean success = new UserDAO().register(user);
        if (success) {
            res.sendRedirect(req.getContextPath() + "/index.jsp?message=Registration successful! Please login.");
        } else {
            res.getWriter().println("Registration failed. Try another username.");
        }
    }
}
