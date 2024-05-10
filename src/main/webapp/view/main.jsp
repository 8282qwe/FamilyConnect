<%@ page import="model.dao.userDao" %>
<%@ page import="java.util.List" %>
<%@ page import="model.dto.userDto" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.dao.calendarDao" %>
<%@ page import="model.dto.calendarDto" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: jangwoo
  Date: 24. 5. 2.
  Time: 오후 1:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/mainpage.css"/>
    <title>Title</title>
</head>
<body>
<%
    int userid = Integer.parseInt(session.getAttribute("userid").toString());
    String groupid = session.getAttribute("groupid").toString();

    calendarDao dao = new calendarDao();
    List<calendarDto> list = new ArrayList<>();
    List<calendarDto> listTomorrow = new ArrayList<>();
    List<calendarDto> listNextweek = new ArrayList<>();

    try {
        list = dao.searchAllByUserIdNotGroupidToday(userid, groupid);
        listTomorrow = dao.searchAllByUserIdNotGroupidTomorrow(userid, groupid);
        listNextweek = dao.searchAllByUserIdNotGroupidNextWeek(userid, groupid);
    } catch (SQLException e) {
        throw new RuntimeException(e);
    }
%>
<!--사이드바-->
<div class="container-fluid">
    <div class="row flex-nowrap" style="margin-left: 20px;">
        <div class="bg-dark col-auto col-md-3 col-lg-2 min-vh-100 d-flex flex-column justify-content-between">
            <div class="bg-dark p-2">
                <a class="d-flex align-items-center text-decoration-none mt-1 text-white">
                    <span class="fs-4 d-none d-sm-inline">Family<br>Connect</span>
                </a>
                <ul class="nav nav-pills flex-column mt-4">
                    <li class="nav-item py-2 py-sm-0">
                        <a href="./main.jsp" class="nav-link text-white">
                            <i class="fs-5 fa fa-house"></i><span class="fs-4 d-none d-sm-inline"> 홈</span>
                        </a>
                    </li>
                    <li class="nav-item py-2 py-sm-0">
                        <a href="./calendar.jsp" class="nav-link text-white">
                            <i class="fs-5 fa fa-calendar-check"></i><span class="fs-4 d-none d-sm-inline"> 내 일정</span>
                        </a>
                    </li>
                    <li class="nav-item py-2 py-sm-0">
                        <a href="./calendarfamily.jsp" class="nav-link text-white">
                            <i class="fs-5 fa fa-calendar-days"></i><span class="fs-4 d-none d-sm-inline"> 가족 일정</span>
                        </a>
                    </li>
                </ul>
            </div>
            <div class="dropdown open p-3">
                <button class="btn border-none dropdown-toggle text-white" type="button" id="triggerId"
                        aria-expanded="false" data-bs-toggle="dropdown">
                    <i class="fa fa-user"></i><span class="ms-2"><%=session.getAttribute("username").toString()%></span>
                </button>
                <div class="dropdown-menu" aria-labelledby="triggerId">
                    <button class="dropdown-item" onclick="location.href='../controller/logoutaction.jsp'">로그아웃</button>
                    <button class="dropdown-item" onclick="location.href='./mysetting.jsp'">내 정보</button>
                </div>
            </div>
        </div>

        <!--내용-->
        <div class="p-3">
            <h1>Home</h1>

            <!--Task-->
            <div class="container" style="margin-top: 20px; margin-left: 20px">
                <div class="row col-md-10" style="margin: 10px; height: 50%;">
                    <!--아코디언-->
                    <div class="accordion accordion-flush" id="accordionToday">
                        <h1 class="accordion-header" style="margin-bottom: 10px">오늘의 할 일</h1>
                        <%
                            int i = 0;
                            for (calendarDto day : list) {%>
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                        data-bs-target="#flush-collapse<%=i%>" aria-expanded="false"
                                        aria-controls="flush-collapse<%=i%>">
                                    <%=day.getTitle()%>
                                </button>
                            </h2>
                            <div id="flush-collapse<%=i%>" class="accordion-collapse collapse"
                                 data-bs-parent="#accordionToday">
                                <div class="accordion-body">
                                    <p>내용 : <%=day.getDescription()%>
                                    </p>
                                    <p>시작 시간 : <%=day.getStartdt()%>
                                    </p>
                                    <p>종료 시간 : <%=day.getEnddt()%>
                                    </p>
                                </div>
                            </div>
                        </div>
                        <%
                                i++;
                            }
                        %>
                    </div>
                </div>
                <div class="row" style="margin: 20px; padding: 5px">
                    <div class="col-md-5" style="height: 250px;">
                        <!--아코디언-->
                        <div class="accordion accordion-flush" id="accordionTomorrow">
                            <h3 class="accordion-header" style="margin-bottom: 10px">내일 할 일</h3>
                            <%
                                for (int j = 0; j < listTomorrow.size(); j++) {%>
                            <div class="accordion-item">
                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                            data-bs-target="#tomorrow<%=j%>" aria-expanded="false" aria-controls="tomorrow<%=j%>">
                                        <%=listTomorrow.get(j).getTitle()%>
                                    </button>
                                </h2>
                                <div id="tomorrow<%=j%>" class="accordion-collapse collapse"
                                     data-bs-parent="#accordionTomorrow">
                                    <div class="accordion-body">
                                        <p>내용 : <%=listTomorrow.get(j).getDescription()%>
                                        </p>
                                        <p>시작 시간 : <%=listTomorrow.get(j).getStartdt()%>
                                        </p>
                                        <p>종료 시간 : <%=listTomorrow.get(j).getEnddt()%>
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <%
                                }
                            %>
                        </div>
                    </div>
                    <div class="col-md-5" style="height: 250px;">
                        <div class="accordion accordion-flush" id="accordionWeek">
                            <h3 class="accordion-header" style="margin-bottom: 10px">다음주 할 일</h3>
                            <%
                                for (int j = 0; j < listNextweek.size(); j++) {%>
                            <div class="accordion-item">
                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                            data-bs-target="#week<%=j%>" aria-expanded="false"
                                            aria-controls="week<%=j%>">
                                        <%=listNextweek.get(j).getTitle()%>
                                    </button>
                                </h2>
                                <div id="week<%=j%>" class="accordion-collapse collapse"
                                     data-bs-parent="#accordionWeek">
                                    <div class="accordion-body">
                                        <p>내용 : <%=listNextweek.get(j).getDescription()%>
                                        </p>
                                        <p>시작 시간 : <%=listNextweek.get(j).getStartdt()%>
                                        </p>
                                        <p>종료 시간 : <%=listNextweek.get(j).getEnddt()%>
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <%
                                }
                            %>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>
