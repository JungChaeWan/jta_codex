<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container d-flex align-items-center justify-content-center" style="min-height: 100vh;">
    <div class="card shadow-lg p-4" style="width: 100%; max-width: 400px;">
        <h4 class="text-center mb-4">공고 신청 관리</h4>

        <c:if test="${not empty errorMsg}">
            <div class="alert alert-danger">${errorMsg}</div>
        </c:if>

        <form id="loginForm">
            <div class="mb-3">
                <label for="userId" class="form-label">아이디</label>
                <input type="text" class="form-control" id="userId" name="email" required>
            </div>

            <div class="mb-3">
                <label for="password" class="form-label">비밀번호</label>
                <input type="password" class="form-control" id="password" name="pwd" required>
            </div>

            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-primary">로그인</button>
            </div>
        </form>
        <div id="loginError" class="alert alert-danger mt-3 d-none"></div>
    </div>
</div>

<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
    $(function () {
        $("#loginForm").on("submit", function (e) {
            e.preventDefault();

            const email = $("#userId").val().trim();
            const pwd = $("#password").val().trim();

            $.ajax({
                url: "/wmn/actionWmnLogin.ajax",
                method: "POST",
                data: { email: email, pwd: pwd },
                success: function (res) {
                    if (res.status === "success") {
                        window.location.href = "/wmn/govAnnouncementList.do";
                    } else {
                        let msg = "로그인에 실패했습니다.";
                        if (res.reason === "email") msg = "이메일을 입력해 주세요.";
                        if (res.reason === "pwd") msg = "비밀번호를 입력해 주세요.";
                        if (res.reason === "invalid") msg = "아이디 또는 비밀번호가 올바르지 않습니다.";

                        $("#loginError").text(msg).removeClass("d-none");
                    }
                },
                error: function () {
                    $("#loginError").text("서버 오류가 발생했습니다.").removeClass("d-none");
                }
            });
        });
    });
</script>

</body>
</html>