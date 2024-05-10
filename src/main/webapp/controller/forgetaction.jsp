<%@ page import="model.dto.userDto" %>
<%@ page import="model.dao.userDao" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.text.ParseException" %><%--
  Created by IntelliJ IDEA.
  User: jangwoo
  Date: 24. 5. 3.
  Time: 오후 6:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setCharacterEncoding("utf-8");%>

<%
    String email = request.getParameter("email");
    userDao dao = new userDao();
    String pw = null;
    try {
        pw = dao.searchForPassword(email);
    } catch (SQLException e) {
        throw new RuntimeException(e);
    } catch (ParseException e) {
        throw new RuntimeException(e);
    }
    if (pw == null) {%>
<script>
    alert("가입이 되어있지 않습니다. 가입화면으로 이동합니다.");
    location.href = "../view/signup.jsp"
</script>
<%
} else {%>
      <script>
          alert("Password : <%=pw%>")
          location.href = "../view/login.jsp";
      </script>
<%
    }
%>
