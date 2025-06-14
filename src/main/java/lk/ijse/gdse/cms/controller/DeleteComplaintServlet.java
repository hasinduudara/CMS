package lk.ijse.gdse.cms.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.gdse.cms.dao.ComplaintDAO;

import java.io.IOException;

@WebServlet("/deleteComplaint")
public class DeleteComplaintServlet extends HttpServlet {

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
            response.sendRedirect(request.getContextPath() + "/employeeDashboard?error=Invalid request");
            return;
        }

        try {
            int complaintId = Integer.parseInt(idParam);
            int userId = (Integer) session.getAttribute("userId");

            // Check if user can modify this complaint
            if (!complaintDAO.canUserModifyComplaint(complaintId, userId)) {
                response.sendRedirect(request.getContextPath() + "/employeeDashboard?error=Cannot delete this complaint");
                return;
            }

            boolean success = complaintDAO.deleteComplaint(complaintId);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/employeeDashboard?success=Complaint deleted successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/employeeDashboard?error=Failed to delete complaint or complaint is already resolved");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/employeeDashboard?error=Invalid complaint ID");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/employeeDashboard?error=Error deleting complaint");
        }
    }

}
