package lk.ijse.gdse.cms.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.gdse.cms.dao.ComplaintDAO;
import lk.ijse.gdse.cms.model.Complaint;

import java.io.IOException;

@WebServlet("/editComplaint")
public class EditComplaintServlet extends HttpServlet {

    private ComplaintDAO complaintDAO = new ComplaintDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect(request.getContextPath() + "/employeeDashboard");
            return;
        }

        try {
            int complaintId = Integer.parseInt(idParam);
            int userId = (Integer) session.getAttribute("userId");

            if (!complaintDAO.canUserModifyComplaint(complaintId, userId)) {
                response.sendRedirect(request.getContextPath() + "/employeeDashboard?error=Cannot edit this complaint");
                return;
            }

            Complaint complaint = complaintDAO.getComplaintById(complaintId);
            if (complaint == null) {
                response.sendRedirect(request.getContextPath() + "/employeeDashboard?error=Complaint not found");
                return;
            }

            request.setAttribute("complaint", complaint);
            request.getRequestDispatcher("/jsp/employee/editComplaint.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/employeeDashboard?error=Invalid complaint ID");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/employeeDashboard?error=Error loading complaint");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String idParam = request.getParameter("id");
        String title = request.getParameter("title");
        String description = request.getParameter("description");

        if (idParam == null || title == null || title.trim().isEmpty() ||
                description == null || description.trim().isEmpty()) {
            request.setAttribute("error", "All fields are required");
            request.getRequestDispatcher("/jsp/employee/editComplaint.jsp").forward(request, response);
            return;
        }

        try {
            int complaintId = Integer.parseInt(idParam);
            int userId = (Integer) session.getAttribute("userId");

            if (!complaintDAO.canUserModifyComplaint(complaintId, userId)) {
                response.sendRedirect(request.getContextPath() + "/employeeDashboard?error=Cannot edit this complaint");
                return;
            }

            Complaint complaint = new Complaint();
            complaint.setId(complaintId);
            complaint.setTitle(title.trim());
            complaint.setDescription(description.trim());

            boolean success = complaintDAO.updateComplaint(complaint);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/employeeDashboard?success=Complaint updated successfully");
            } else {
                request.setAttribute("error", "Failed to update complaint or complaint is already resolved");
                Complaint existingComplaint = complaintDAO.getComplaintById(complaintId);
                request.setAttribute("complaint", existingComplaint);
                request.getRequestDispatcher("/jsp/employee/edit_complaint.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/employeeDashboard?error=Invalid complaint ID");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error updating complaint: " + e.getMessage());
            request.getRequestDispatcher("/jsp/employee/edit_complaint.jsp").forward(request, response);
        }
    }

}
