# Family_Connect(그룹단위 일정 관리 웹페이지 서비스)
-------------------
[JSP] JSP+HTML+Jquery를 활용한 개인 프로젝트

1. 📺 프로젝트 소개
   ---------------
   가족뿐만 아니라 여러명의 사용자가 각각 자신의 일정을 한눈에 확인하며 관리하고 그룹단위의 일정 관리를 좀 더 쉽게
   할수 있도록 제작한 웹 페이지 서비스
2. 🕰️ 개발 기간
   ----------------
   + 2024.05.02 ~ 2024.05.07 (5일간)

3. 🧑‍🤝‍🧑 맴버구성
   ----------------
  + 이장우 - 개인 프로젝트

4. 🌐 개발 환경
   ----------------
   <img src="https://img.shields.io/badge/JAVA-007396?style=flat-square&logo=Java&logoColor=white"/>  <img src="https://img.shields.io/badge/JS-ffff00?style=flat-square&logo=javascript&logoColor=white"/>  <img src="https://img.shields.io/badge/HTML-E34F26?style=flat-square&logo=html5&logoColor=white"/>  <img src="https://img.shields.io/badge/Jquery-0769AD?style=flat-square&logo=jquery&logoColor=white"/> <img src="https://img.shields.io/badge/MYSQL-4479A1?style=flat-square&logo=mysql&logoColor=white"/> <img src="https://img.shields.io/badge/Google-4285F4?style=flat-square&logo=googlecalendar&logoColor=white"/>

5. 📍 주요 기능
   ----------------
   + Login Page
     + Email, Password 기반으로 로그인 여부 판단
       + 로그인 성공 시 : Jsp의 Session을 활용하여 User의 name, userindex을 적재
       + 로그인 실패 시 : 로그인 실패 알람 후 로그인 페이지로 이동
   
   + Sign in Page
     + 초대코드 필드에만 대해 required를 제거하고 나머지 부분은 다 필수로 입력받음
       + Email 기준으로 아이디의 중복을 탐색하여 로그인 기능 실행
       + 초대코드에 입력이 없을 경우 UUID기반으로 초대코드를 유저에게 발급
         + 추후 다른 유저에게 해당 그룹 초대를 보내고 싶은 경우 해당 코드를 전달하여 가입 시 입력을 요구
   
   + Forget password Page
     + Email을 기반으로 패스워드 찾기를 실행하여 패스워드를 찾음
    
   + Main Page
     + Side bar에 홈, 개인일정, 그룹일정을 만들어 해당 부분을 클릭하면 해당 Page로 변경
     + 현재 로그인된 User의 오늘 할일, 내일 할일, 다음주 할일을 그룹,개인 상관없이 출력
     + Bootstrap의 아코디언을 사용하여 출력

   +개인 Calendar Page
    + Fullcalendar.js를 활용하여 캘린더를 간편하게 랜더링
    + Google API를 활용하여 한국의 공휴일을 가져와서 편하게 랜더링
    + User의 개인 일정만을 가져와서 캘린더에 표현

   +팀원 Calendar Page
    + Fullcalendar.js를 활용하여 캘린더를 간편하게 랜더링
    + Google API를 활용하여 한국의 공휴일을 가져와서 편하게 랜더링
    + User의 초대코드를 기반으로 팀원 일정을 가져와서 캘린더에 표현
    + User가 작성하지 않은 일정은 수정 불가하고 읽기만 가능

   +개인 프로필 수정 Page
    + 모든 값을 수정 가능
    + 초대 코드를 수정하여 그룹 수정 가능
    + 밑에 표현된 회원탈퇴 기능을 사용하여 User 정보 삭제 가능

6. 🛑 Error Report
   ----------------
   + HTML(Datetime-local) <--> JAVA(Timestamp) <--> Mysql(Datetime) 간의 호환성
     + Datetime-local의 포맷 : "yyyy-MM-ddThh:mm"
     + Timestamp의 포맷 : "yyyy-MM-dd hh:mm:ss"
     + Datetime의 포맷 : "yyyy-MM-dd hh:mm:ss"
     + Java와 Mysql 간의 포맷은 일치 하지만 HTML에서 전달되는 값이 달라 따로 파싱을 진행하여 해결하였습니다.
   + fullcalendar.js 사용법 오류
     + 해당 라이브러리의 공식 Docs에는 Google api 활용을 위해 특정 추가 라이브러리가 필요하다는 것에 대한 명세가 빠져있음
     + 구글링을 통해 하단의 라이브러리를 불러와 문제 해결
       ``` html
       <script src="https://cdn.jsdelivr.net/npm/@fullcalendar/google-calendar@6.1.11/index.global.min.js"></script>
       ```

7. 🖨 실제 발표 자료
   ----------------
   [실제 발표 자료 PDF](https://github.com/8282qwe/FamilyConnect/blob/22967ad2cc967f4e3440ab3e431fee9add5f2700/Group-by-group%20Schedule%20Planner_%EB%8D%B0%EB%B8%8C%EC%98%B5%EC%8A%A411%EA%B8%B0%20%EC%9D%B4%EC%9E%A5%EC%9A%B0.pdf)
