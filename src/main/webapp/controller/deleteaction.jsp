<%@ page import="model.dao.calendarDao" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: jangwoo
  Date: 24. 5. 5.
  Time: 오후 4:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    calendarDao dao = new calendarDao();
    if (request.getParameter("id").isEmpty()) {%>
<script>
    location.href = document.referrer;
</script>
<%
    }

    int id = Integer.parseInt(request.getParameter("id"));
    try {
        if (dao.deleteSchedule(id)) {
%>
<script>
    location.href = document.referrer;
</script>
<%
        }
    } catch (SQLException e) {
        throw new RuntimeException(e);
    }
%>
