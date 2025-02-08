<%@ page import="java.sql.*" %>
<%!
    public Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/user_auth", "root", "");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
%>
