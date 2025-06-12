<%--
  Created by IntelliJ IDEA.
  User: hasid
  Date: 6/12/2025
  Time: 12:21 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page session="true" import="java.util.*, lk.ijse.gdse.cms.model.Complaint" %>

<%
    List<Complaint> allComplaints = (List<Complaint>) request.getAttribute("allComplaints");
%>

<html>
<head>
    <title>All Complaints</title>
</head>
<body>
<div class="container">
    <h2>All Complaints (Admin)</h2>
    <table>
        <thead>
            <tr>
                <th>Complaint ID</th>
                <th>User Title</th>
                <th>Employee ID</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <% for (Complaint complaint : allComplaints) { %>
                <tr>
                    <td><%= complaint.getId() %></td>
                    <td><%= complaint.getTitle() %></td>
                    <td><%= complaint.getUserId() %></td>
                    <td><%= complaint.getStatus() %></td>
                    <td>
                        <a href="../../adminUpdate?id=<%= complaint.getId() %>">Update</a>
                    </td>
                </tr>
            <% } %>
        </tbody>
        </thead>
    </table>
</div>
</body>
</html>

