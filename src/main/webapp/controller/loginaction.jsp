<%@ page import="model.dao.userDao" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="model.dto.userDto" %><%--
  Created by IntelliJ IDEA.
  User: jangwoo
  Date: 24. 5. 3.
  Time: 오후 5:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%request.setCharacterEncoding("utf-8");%>

<jsp:useBean id="user" class="model.dto.userDto"/>
<jsp:setProperty name="user" property="*"/>

<%
    userDao dao = new userDao();
    userDto login;
    try {
        login = dao.searchByEmailAndPassword(user.getEmail(), user.getPassword());
        if (login != null) {
            session.setAttribute("userid", login.getUserid());
            session.setAttribute("username", login.getName());
            session.setAttribute("groupid", login.getGroupid());
            response.sendRedirect("../view/main.jsp");
        } else { %>
<script>
    alert("잘못된 계정입니다.");
    window.history.go(-1);
</script>
<% }
} catch (SQLException e) {
    throw new RuntimeException(e);
}
%>
