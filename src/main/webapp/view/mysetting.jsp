<%@ page import="model.dao.userDao" %>
<%@ page import="model.dto.userDto" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: jangwoo
  Date: 24. 5. 3.
  Time: 오후 2:14
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
</head>
<body>
<%
    String userid = session.getAttribute("userid").toString();
    userDao dao = new userDao();

    userDto user;
    try {
        user = dao.searchByUserid(Integer.parseInt(userid));
    } catch (SQLException e) {
        throw new RuntimeException(e);
    }
%>
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
        <div class="col-lg-10 p-3">
            <div class="col-xs-12">
                <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
                <link rel="stylesheet" href="https://unpkg.com/bs-brain@2.0.3/components/registrations/registration-7/assets/css/registration-7.css">
                <div class="container bootstrap snippets bootdeys">
                    <div class="row">
                        <section class="bg-light p-3 p-md-4 p-xl-5">
                            <div class="container">
                                <div class="row justify-content-center">
                                    <div class="col-12 col-md-9 col-lg-7 col-xl-6 col-xxl-5">
                                        <div class="card border border-light-subtle rounded-4">
                                            <div class="card-body p-3 p-md-4 p-xl-5">
                                                <div class="row">
                                                    <div class="col-12">
                                                        <div class="mb-5">
                                                            <h2 class="h4 text-center">회원 정보 수정</h2>
                                                            <h3 class="fs-6 fw-normal text-secondary text-center m-0">정보를 입력해 주세요.</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                                <form action="../controller/settingaction.jsp">
                                                    <div class="row gy-3 overflow-hidden">
                                                        <div class="col-12">
                                                            <div class="form-floating mb-3">
                                                                <input type="text" class="form-control" name="firstName" id="name" placeholder="이름" value="<%=user.getName()%>" readonly required>
                                                                <label for="name" class="form-label">이름</label>
                                                            </div>
                                                        </div>
                                                        <div class="col-12">
                                                            <div class="form-floating mb-3">
                                                                <input type="password" class="form-control" name="password" value="<%=user.getPassword()%>" id="password" placeholder="비밀번호" required>
                                                                <label for="password" class="form-label">비밀번호</label>
                                                            </div>
                                                        </div>
                                                        <div class="col-12">
                                                            <div class="form-floating mb-3">
                                                                <input type="email" class="form-control" name="email" id="email" placeholder="name@example.com" value="<%=user.getEmail()%>" readonly required>
                                                                <label for="email" class="form-label">이메일</label>
                                                            </div>
                                                        </div>
                                                        <div class="col-12">
                                                            <div class="form-floating mb-3">
                                                                <input type="text" class="form-control" name="phone" id="phone" placeholder="핸드폰 번호" value="<%=user.getPhone()%>" required>
                                                                <label for="phone" class="form-label">핸드폰 번호</label>
                                                            </div>
                                                        </div>
                                                        <div class="col-12">
                                                            <div class="form-floating mb-3">
                                                                <input class="form-control" type="date" value="<%=user.getBirthday()%>" name="birthday" id="birthday" required>
                                                                <label class="form-label" for="birthday"></label>
                                                            </div>
                                                        </div>
                                                        <div class="col-12">
                                                            <div class="form-floating mb-3">
                                                                <input type="text" class="form-control" name="group" id="group" value="<%=user.getGroupid()%>" placeholder="초대코드">
                                                                <label for="group" class="form-label">초대코드</label>
                                                            </div>
                                                        </div>
                                                        <div class="col-12">
                                                            <div class="d-grid">
                                                                <button class="btn bsb-btn-xl btn-primary" type="submit">수정하기</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                                <div class="row">
                                                    <div class="col-12">
                                                        <hr class="mt-5 mb-4 border-secondary-subtle">
                                                        <p class="m-0 text-secondary text-center">탈퇴하시겠습니까? <a href="../controller/deleteaction.jsp" class="link-primary text-decoration-none">탈퇴하기</a></p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
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
