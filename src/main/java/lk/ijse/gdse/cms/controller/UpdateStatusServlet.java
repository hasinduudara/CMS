package lk.ijse.gdse.cms.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.gdse.cms.model.Complaint;
import lk.ijse.gdse.cms.dao.ComplaintDAO;


import java.io.IOException;

@WebServlet("/update-status")
public class UpdateStatusServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");

        if (idStr == null || idStr.trim().isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Complaint ID is missing.");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid complaint ID.");
            return;
        }

        Complaint complaint = ComplaintDAO.getComplaintById(id);

        if (complaint == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Complaint not found.");
            return;
        }

        req.setAttribute("complaint", complaint);
        req.getRequestDispatcher("/jsp/admin/update_status.jsp").forward(req, resp);
    }



    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        String status = req.getParameter("status");
        String remark = req.getParameter("remark");

        // Convert status to the format expected by the database
        if ("Pending".equals(status)) {
            status = "PENDING";
        } else if ("In Progress".equals(status)) {
            status = "IN_PROGRESS";
        } else if ("Resolved".equals(status)) {
            status = "RESOLVED";
        }

        ComplaintDAO.updateStatusAndRemark(id, status, remark);
//        resp.sendRedirect(req.getContextPath() + "/admin-dashboard");
        req.setAttribute("message", "Complaint status updated successfully.");
//        req.getRequestDispatcher("/jsp/admin/dashboard.jsp").forward(req, resp);
        resp.sendRedirect(req.getContextPath() + "/list-complaints?msg=deleted");
    }

}
