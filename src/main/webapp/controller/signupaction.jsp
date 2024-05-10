<%@ page import="model.dao.userDao" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="java.sql.Date" %>
<%--
  Created by IntelliJ IDEA.
  User: jangwoo
  Date: 24. 5. 3.
  Time: 오후 3:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="user" class="model.dto.userDto"/>
<jsp:setProperty name="user" property="*"/>
<%
    userDao dao = new userDao();
    try {
        if (dao.searchByEmail(user.getEmail())) {%>
            <script>
                alert("이미 존재하는 아이디가 있습니다.")
                history.go(-1);
            </script>
<%
        }
        else{
            try {
                dao.insertUser(user);
            } catch (ParseException e) {
                throw new RuntimeException(e);
            }
        }
    } catch (SQLException e) {
        System.out.println(e.getMessage());
    }
    response.sendRedirect("../view/login.jsp");
%>