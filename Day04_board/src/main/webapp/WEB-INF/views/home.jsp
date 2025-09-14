<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  </head>
<body>
 <style>
        body {
            background-color: #f8f9fa; /* 연한 회색 배경 */
        }
        .login-container {
            width: 100%;
            max-width: 400px; /* 폼의 최대 너비 설정 */
            margin: 80px auto;
            padding: 25px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .form-label {
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="container login-container">
    <h3 class="text-center mb-4">로그인</h3>
    <form action="/members/login" method="post">
        <div class="mb-3">
            <label for="userId" class="form-label">아이디</label>
            <input type="text" class="form-control" id="userId" name="id" placeholder="아이디를 입력하세요" required>
        </div>
        <div class="mb-3">
            <label for="userPassword" class="form-label">비밀번호</label>
            <input type="password" class="form-control" id="userPassword" name="pw" placeholder="비밀번호를 입력하세요" required>
        </div>
        <div class="mb-3 form-check">
            <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberId">
            <label class="form-check-label" for="rememberMe">ID 기억하기</label>
        </div>
        <div class="d-grid gap-2 mb-3">
            <button type="submit" class="btn btn-primary">로그인</button>
        </div>
    </form>
    
    <div class="text-center">
        <a href="/members/regist" class="btn btn-outline-secondary w-100">회원가입</a>
    </div>

    <div class="text-center mt-3">
        <a href="#" class="link-secondary me-3">아이디 찾기</a>
        <a href="#" class="link-secondary">비밀번호 찾기</a>
    </div>
</div>


</body>
</html>