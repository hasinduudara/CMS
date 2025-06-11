package lk.ijse.gdse.cms.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.gdse.cms.dao.UserDAO;
import lk.ijse.gdse.cms.model.User;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        User user = new UserDAO().login(username, password);

        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("user", user.getUsername());
            session.setAttribute("userId", user.getId());
            session.setAttribute("role", user.getRole());
            resp.sendRedirect("dashboard.jsp");
        } else  {
            resp.getWriter().println("Invalid username or password");
        }
    }
}
