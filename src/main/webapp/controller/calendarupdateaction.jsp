<%@ page import="model.dao.calendarDao" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: jangwoo
  Date: 24. 5. 5.
  Time: 오후 3:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setCharacterEncoding("utf-8");%>
<jsp:useBean id="sdto" class="model.dto.calendarDto"/>
<%
    calendarDao dao = new calendarDao();
    sdto.setScheduledid(Integer.parseInt(request.getParameter("scheduledid")));
    sdto.setTitle(request.getParameter("title"));
    sdto.setStartdt(request.getParameter("startdt"));
    sdto.setEnddt(request.getParameter("enddt"));
    sdto.setDescription(request.getParameter("description"));

    try {
        if (dao.updateSchedule(sdto)) {%>
<script>
    location.href = document.referrer;
</script>
<%
} else {
%>
<script>
    alert("수정 실패");
    location.href = document.referrer;
</script>
<%
        }
    } catch (SQLException e) {
        throw new RuntimeException(e);
    }
%>