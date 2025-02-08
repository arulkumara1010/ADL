<%@ page import="java.sql.*" %>
<%@ include file="dbconfig.jsp" %>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    if (conn != null) {
        String query = "SELECT * FROM users WHERE username = ? AND password = ?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, username);
        stmt.setString(2, password);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            session.setAttribute("username", username);
            response.sendRedirect("welcome.jsp");
        } else {
            response.sendRedirect("index.jsp?error=Invalid Credentials");
        }
        stmt.close();
        conn.close();
    }
%>
