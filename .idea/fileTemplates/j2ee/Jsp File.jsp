<%--
  Created by IntelliJ IDEA.
  User: ${USER}
  Date: ${DATE}
  Time: ${TIME}
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
      <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
    <title>#[[$Title$]]#</title>
  </head>
  <body>
  #[[$END$]]#
   <div class="container-fluid">
        <div class="row flex-nowrap" style="margin-left: 20px;">
            <div class="bg-dark col-auto col-md-3 col-lg-2 min-vh-100 d-flex flex-column justify-content-between">
                <div class="bg-dark p-2">
                    <a class="d-flex align-items-center text-decoration-none mt-1 text-white">
                        <span class="fs-4 d-none d-sm-inline">Family<br>Connect</span>
                    </a>
                    <ul class="nav nav-pills flex-column mt-4">
                        <li class="nav-item py-2 py-sm-0">
                            <a href="#" class="nav-link text-white">
                                <i class="fs-5 fa fa-house"></i><span class="fs-4 d-none d-sm-inline"> 홈</span>
                            </a>
                        </li>
                        <li class="nav-item py-2 py-sm-0">
                            <a href="#" class="nav-link text-white">
                                <i class="fs-5 fa fa-calendar-check"></i><span class="fs-4 d-none d-sm-inline"> 내 일정</span>
                            </a>
                        </li>
                        <li class="nav-item py-2 py-sm-0">
                            <a href="#" class="nav-link text-white">
                                <i class="fs-5 fa fa-calendar-days"></i><span class="fs-4 d-none d-sm-inline"> 가족 일정</span>
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="dropdown open p-3">
                    <button class="btn border-none dropdown-toggle text-white" type="button" id="triggerId" aria-expanded="false" data-bs-toggle="dropdown">
                        <i class="fa fa-user"></i><span class="ms-2">Username</span>
                    </button>
                    <div class="dropdown-menu" aria-labelledby="triggerId">
                        <button class="dropdown-item" href="#">로그아웃</button>
                        <button class="dropdown-item" href="#">내 정보</button>
                    </div>
                </div>
            </div>
            <!--내용-->
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
  </body>
</html>
