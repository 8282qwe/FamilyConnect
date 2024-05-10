<%@ page import="java.util.List" %>
<%@ page import="model.dto.calendarDto" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.dao.calendarDao" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: jangwoo
  Date: 24. 5. 3.
  Time: 오전 11:21
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
    <title>Title</title>
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar-scheduler@6.1.11/index.global.min.js'></script>
    <!--fullcalendar googleapi사용을 위한 라이브러리-->
    <script src="https://cdn.jsdelivr.net/npm/@fullcalendar/google-calendar@6.1.11/index.global.min.js"></script>
    <script src="../js/customapikey.js"></script>
    <%
        List<calendarDto> dtoList;
        calendarDao dao = new calendarDao();
        try {
            dtoList = dao.searchAlluserid(session.getAttribute("userid").toString());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    %>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var calendarEl = document.getElementById('calendar');
            const apikey = config.apikey;
            // new FullCalendar.Calendar(대상 DOM객체, {속성:속성값, 속성2:속성값2..})
            var calendar = new FullCalendar.Calendar(calendarEl, {
                googleCalendarApiKey: apikey,
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: '',
                },
                initialDate: Date.now(), // 초기 로딩 날짜.
                navLinks: false, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
                selectable: true,
                selectMirror: true,
                locale: 'ko',
                editable: true,
                eventSources: [{
                    googleCalendarId: 'ko.south_korea#holiday@group.v.calendar.google.com',
                    color: '#FF0000'
                }],
                eventClick: function (info) {
                    if (info.el.hostname === "www.google.com") {
                        info.jsEvent.stopPropagation();
                        info.jsEvent.preventDefault();
                    } else {
                        $("#form-action").prop("action", "../controller/calendarupdateaction.jsp");
                        $("#calendar_title").prop("value", info.event.title);
                        let data = info.event.startStr.split(":")
                        let data1 = info.event.endStr.split(":")

                        //날자 포맷 다시 보기 트러블 슈팅 리포트 작성
                        $("#calendar_start_date").prop("value", data[0]+":"+data[1]);
                        $("#calendar_end_date").prop("value", data1[0]+":"+data1[1])
                        $("#calendar_description").val(info.event.extendedProps.content);
                        $("#scheduledid").prop("value",info.event.extendedProps.scheduledid);
                        $("#delete").show();
                        $("#calendarModal").modal("show");
                        //info.dateStr = 클릭 당시 날짜

                    }
                },
                dateClick: function (info) {
                    $("#scheduledid").prop("value","");
                    $("#form-action").prop("action", "../controller/insertschedule.jsp");
                    $("#calendar_title").prop("value", "");
                    $("#calendar_start_date").prop("value", info.dateStr+" 00:00");
                    $("#calendar_end_date").prop("value", info.dateStr + " 23:59");
                    $("#calendar_description").val("");
                    $("#delete").hide();
                    $("#calendarModal").modal("show");
                    //info.dateStr = 클릭 당시 날짜
                },
                events: [
                    <% for (calendarDto dto: dtoList){%>
                    {
                        title: "<%=dto.getTitle()%>",
                        start: "<%=dto.getStartdt()%>",
                        end: "<%=dto.getEnddt()%>",
                        content: "<%=dto.getDescription()%>",
                        scheduledid: "<%=dto.getScheduledid()%>"
                    },
                    <% } %>
                ]
            });
            calendar.render();
        })
    </script>
    <style>
        /* 모든 요일 색상 기본 검정*/
        .fc-day a {
            color: black;
            text-decoration: none;
        }

        /* 일요일 날짜 빨간색 */
        .fc-day-sun a {
            color: red;
            text-decoration: none;
        }

        /* 토요일 날짜 파란색 */
        .fc-day-sat a {
            color: blue;
            text-decoration: none;
        }
    </style>
</head>
<body>

<!--modeal-->
<div class="modal fade" id="calendarModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">일정을 입력하세요.</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                </button>
            </div>
            <form action="../controller/insertschedule.jsp" method="post" id="form-action">
                <div class="modal-body">
                    <div class="form-group">
                        <input hidden="hidden" type="text" value="" name="scheduledid" id="scheduledid">
                        <label class="col-form-label">일정 제목</label>
                        <input type="text" class="form-control" id="calendar_title" name="title" value="">
                        <label class="col-form-label">시작 날짜</label>
                        <input type="datetime-local" class="form-control" id="calendar_start_date" name="startdt" value="">
                        <label class="col-form-label">종료 날짜</label>
                        <input type="datetime-local" class="form-control" id="calendar_end_date" name="enddt" value="">
                        <label class="col-form-label">일정 내용</label>
                        <textarea class="form-control" aria-label="일정내용" name="description"
                                  id="calendar_description"></textarea>
                    </div>
                </div>
                <div class="modal-footer" id="button-grouping">
                    <button type="submit" class="btn btn-warning" id="addCalendar">추가</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"
                            id="sprintSettingModalClose">취소
                    </button>
                    <button type="button" class="btn btn-danger" onclick="location.href='../controller/deleteaction.jsp?id='+$('#scheduledid').prop('value')"
                            id="delete">삭제
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

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
                    <button class="dropdown-item" href="../controller/logoutaction.jsp">로그아웃</button>
                    <button class="dropdown-item" href="./mysetting.jsp">내 정보</button>
                </div>
            </div>
        </div>
        <!--내용-->
        <div class="col-lg-8 p-3">
            <h1>캘린더</h1>
            <div id="calendar" style="margin-top: 20px; height: 800px;"></div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>
