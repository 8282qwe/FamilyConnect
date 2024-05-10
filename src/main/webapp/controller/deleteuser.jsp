<%@ page import="model.dao.userDao" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: jangwoo
  Date: 24. 5. 5.
  Time: 오후 4:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    userDao dao = new userDao();
    int id = Integer.parseInt(request.getParameter("id"));

    try {
        if (dao.deleteByuserid(id)) {
            response.sendRedirect("./logoutaction.jsp");
        }
    } catch (SQLException e) {
        throw new RuntimeException(e);
    }
%>
