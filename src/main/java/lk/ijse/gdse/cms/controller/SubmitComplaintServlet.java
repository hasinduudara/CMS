package lk.ijse.gdse.cms.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.gdse.cms.dao.ComplaintDAO;
import lk.ijse.gdse.cms.model.Complaint;
import lk.ijse.gdse.cms.model.ComplaintStatus;

import java.io.IOException;

@WebServlet("/submitComplaint")
public class SubmitComplaintServlet extends HttpServlet {

    private ComplaintDAO complaintDAO = new ComplaintDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        request.getRequestDispatcher("/jsp/employee/submitComplaint.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        String title = request.getParameter("title");
        String description = request.getParameter("description");

        // Validate input
        if (title == null || title.trim().isEmpty() ||
                description == null || description.trim().isEmpty()) {
            request.setAttribute("error", "Title and description are required");
            request.getRequestDispatcher("/jsp/employee/submitComplaint.jsp").forward(request, response);
            return;
        }

        try {
            Complaint complaint = new Complaint();
            complaint.setUserId(userId);
            complaint.setTitle(title.trim());
            complaint.setDescription(description.trim());
            complaint.setStatus(ComplaintStatus.PENDING);

            boolean success = complaintDAO.insertComplaint(complaint);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/employeeDashboard?success=Complaint submitted successfully");
            } else {
                request.setAttribute("error", "Failed to submit complaint. Please try again.");
                request.getRequestDispatcher("/jsp/employee/submitComplaint.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error submitting complaint: " + e.getMessage());
            request.getRequestDispatcher("/jsp/employee/submitComplaint.jsp").forward(request, response);
        }
    }
}