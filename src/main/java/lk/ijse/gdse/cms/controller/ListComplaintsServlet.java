package lk.ijse.gdse.cms.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.gdse.cms.dao.ComplaintDAO;
import lk.ijse.gdse.cms.model.Complaint;

import java.io.IOException;
import java.util.List;

@WebServlet("/list-complaints")
public class ListComplaintsServlet extends HttpServlet {

    private ComplaintDAO complaintDAO = new ComplaintDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<Complaint> allComplaints = complaintDAO.getAllComplaints();
            request.setAttribute("allComplaints", allComplaints);
            request.getRequestDispatcher("/jsp/admin/dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            response.sendRedirect("jsp/error.jsp");
        }
    }

}
