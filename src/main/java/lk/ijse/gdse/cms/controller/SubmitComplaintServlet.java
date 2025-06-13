package lk.ijse.gdse.cms.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.gdse.cms.dao.ComplaintDAO;
import lk.ijse.gdse.cms.model.Complaint;

import java.io.IOException;

@WebServlet("/submitComplaint")
public class SubmitComplaintServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            res.sendRedirect("jsp/employee/complaint_form.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        String title = req.getParameter("title");
        String description = req.getParameter("description");

        Complaint complaint = new Complaint();
        complaint.setUserId(userId);
        complaint.setTitle(title);
        complaint.setDescription(description);

        boolean success = new ComplaintDAO().submitComplaint(complaint);

        if (success) {
            res.sendRedirect(req.getContextPath() + "/jsp/employee/dashboard.jsp");
        } else {
            res.sendRedirect(req.getContextPath() + "/jsp/employee/complaint_form.jsp?error=true");
        }
    }
}