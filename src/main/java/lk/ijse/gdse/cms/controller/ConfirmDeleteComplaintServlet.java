package lk.ijse.gdse.cms.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.gdse.cms.dao.ComplaintDAO;
import lk.ijse.gdse.cms.model.Complaint;

import java.io.IOException;

@WebServlet("/confirm-delete-complaint")
public class ConfirmDeleteComplaintServlet extends HttpServlet {

    private ComplaintDAO complaintDAO;

    @Override
    public void init() {
        complaintDAO = new ComplaintDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Complaint complaint = ComplaintDAO.getComplaintById(id);

        if (complaint != null) {
            request.setAttribute("complaint", complaint);
            request.getRequestDispatcher("jsp/admin/deleteComplaint.jsp").forward(request, response);
        } else {
            response.sendRedirect("jsp/error.jsp"); // Or show "not found"
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            ComplaintDAO dao = new ComplaintDAO();

            // First check if the complaint exists and get its status
            Complaint complaint = ComplaintDAO.getComplaintById(id);
            if (complaint == null) {
                request.setAttribute("errorMessage", "Complaint not found");
                request.getRequestDispatcher("jsp/error.jsp").forward(request, response);
                return;
            }

            boolean success = dao.deleteComplaint(id);
            if (success) {
                response.sendRedirect(request.getContextPath() + "/list-complaints?msg=deleted");
            } else {
                request.setAttribute("errorMessage", "Could not delete complaint. It may be in RESOLVED status.");
                request.getRequestDispatcher("jsp/error.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error: " + e.getMessage());
            request.getRequestDispatcher("jsp/error.jsp").forward(request, response);
        }
    }

}