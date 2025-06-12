<%--
  Created by IntelliJ IDEA.
  User: hasid
  Date: 6/12/2025
  Time: 10:08 AM
  To change this template use File | Settings | File Templates.
--%>

<%@page session="false" %>

<html>
<head>
    <title>New Complaint</title>
</head>
<body>
<div class="container">
    <h2>Submit Complaint</h2>
    <form name="complaintForm" action="../../submitComplaint" method="post" onsubmit="return validateComplaintForm();">
        <label>Title:</label>
        <br>
        <input type="text" name="title" id="title" required>
        <br><br>
        <label>Description:</label>
        <br>
        <textarea name="description" rows="4" cols="50" id="description" required></textarea>
        <br><br>
        <button type="submit">Submit</button>
    </form>
</div>
</body>
</html>
