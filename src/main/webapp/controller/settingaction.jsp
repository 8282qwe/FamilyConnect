<%@ page import="model.dao.userDao" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.text.ParseException" %><%--
  Created by IntelliJ IDEA.
  User: jangwoo
  Date: 24. 5. 3.
  Time: 오후 6:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setCharacterEncoding("utf-8");%>
<jsp:useBean id="user" class="model.dto.userDto"/>
<jsp:setProperty name="user" property="*"/>
<%
    userDao dao = new userDao();
    int userid = Integer.parseInt(session.getAttribute("userid").toString());
    try {
        if (dao.updateByuserid(userid, user)) {%>
          <script>
              alert("수정 완료!")
              location.href="../view/mysetting.jsp"
          </script>
<%
        }
        else {
            response.sendRedirect("../view/mysetting.jsp");
        }
    } catch (SQLException e) {
        throw new RuntimeException(e);
    } catch (ParseException e) {
        throw new RuntimeException(e);
    }
%>