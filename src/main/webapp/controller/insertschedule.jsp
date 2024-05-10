<%@ page import="model.dao.calendarDao" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: jangwoo
  Date: 24. 5. 4.
  Time: 오후 9:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setCharacterEncoding("utf-8");%>

<jsp:useBean id="schedule" class="model.dto.calendarDto"/>
<jsp:setProperty name="schedule" property="*"/>
<%
    calendarDao dao = new calendarDao();
    try {
        if (dao.insertSchedule(schedule, session.getAttribute("userid").toString(), null)) {%>
<script>
    location.href = document.referrer;
</script>
<%
} else {
%>
<script>
    alert("추가 실패");
    location.href = document.referrer;
</script>
<%
        }
    } catch (SQLException e) {
        throw new RuntimeException(e);
    }
%>
