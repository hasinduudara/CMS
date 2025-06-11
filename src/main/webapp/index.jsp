<%@page session="true" %>

<%
    if (session.getAttribute("username") != null) {
        response.sendRedirect("dashboard.jsp");
    } else {
        response.sendRedirect("jsp/login.jsp");
    }
%>