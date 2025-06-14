<%@ page import="lk.ijse.gdse.cms.model.Complaint" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  Complaint complaint = (Complaint) request.getAttribute("complaint");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Edit Complaint</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f2f2f2;
      padding: 20px;
    }
    .form-container {
      background-color: #ffffff;
      padding: 20px;
      border: 1px solid #ccc;
      max-width: 500px;
      margin: 0 auto;
    }
    h2 {
      text-align: center;
    }
    label {
      display: block;
      margin-top: 10px;
    }
    input[type="text"], textarea {
      width: 100%;
      padding: 8px;
      margin-top: 5px;
      box-sizing: border-box;
    }
    button {
      margin-top: 15px;
      padding: 10px 20px;
      background-color: #007bff;
      color: #fff;
      border: none;
      cursor: pointer;
    }
    button:hover {
      background-color: #0056b3;
    }
  </style>
</head>
<body>
<div class="form-container">
  <h2>Edit Complaint</h2>
  <form action="complaint" method="post">
    <input type="hidden" name="action" value="edit">
    <input type="hidden" name="id" value="<%= complaint.getId() %>">

    <label for="title">Title:</label>
    <input type="text" id="title" name="title" value="<%= complaint.getTitle() %>" required>

    <label for="description">Description:</label>
    <textarea id="description" name="description" rows="4" required><%= complaint.getDescription() %></textarea>

    <button type="submit">Update</button>
  </form>
</div>
</body>
</html>
