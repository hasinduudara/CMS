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
            res.sendRedirect("jsp/employee/complaint_form.jsp?error=session");
            return;
        }

        // Get and validate parameters
        String title = req.getParameter("title");
        String description = req.getParameter("description");

        if (title == null || title.trim().isEmpty() || description == null || description.trim().isEmpty()) {
            res.sendRedirect(req.getContextPath() + "/jsp/employee/complaint_form.jsp?error=empty");
            return;
        }

        try {
            int userId = (int) session.getAttribute("userId");
            
            Complaint complaint = new Complaint();
            complaint.setUserId(userId);
            complaint.setTitle(title.trim());
            complaint.setDescription(description.trim());

            boolean success = new ComplaintDAO().submitComplaint(complaint);

            if (success) {
                res.sendRedirect(req.getContextPath() + "/jsp/employee/dashboard.jsp?success=true");
            } else {
                res.sendRedirect(req.getContextPath() + "/jsp/employee/complaint_form.jsp?error=db");
            }
        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect(req.getContextPath() + "/jsp/employee/complaint_form.jsp?error=system");
        }
    }
}