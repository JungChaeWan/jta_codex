<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
           
<un:useConstants var="Constant" className="common.Constant" />
<head>
<meta name="robots" content="noindex, nofollow">
<jsp:include page="/mw/includeJs.do"></jsp:include>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common2.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub_member.css'/>">

<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
<script type="text/javascript">
function fn_DropUser(){
	var qutRsn = $("input:radio[name=leaving]:checked").val();

	if(qutRsn == null || qutRsn == ""){
		qutRsn = $("#qutRsn").val();

        if(qutRsn == null || qutRsn == ""){
            alert("<spring:message code='errors.required2' arguments='탈퇴사유'/>");
            $("#qutRsn").focus();
            return;
        }
	}
	if($("#agree1").is(":checked") != true){
        alert("<spring:message code='fail.common.confirm' arguments='탈퇴시 처리사항 안내 확인'/>");
		return;
	}
    if(confirm("<spring:message code='common.confirm.drop'/>")) {
        var parameters = "qutRsn=" + qutRsn;
        parameters += "&snsDiv=${user.snsDiv}";

        $.ajax({
            type:"post",
            url:"<c:url value='/web/mypage/dropUser.ajax'/>",
            data:parameters,
            success:function(data) {
                if(data.result == "success") {
                    alert("<spring:message code='success.user.drop' />");

                    location.href = "<c:url value='/mw/logout.do'/>";
                } else {
                    alert("<spring:message code='fail.user.drop' />");
                }
            },
            error:fn_AjaxError
        });
	}
}
</script>
</head>
<body>
<div id="wrap">
<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do">
		<jsp:param name="headTitle" value="회원탈퇴"/>
	</jsp:include>
</header>
<!-- 헤더 e -->

<!-- 콘텐츠 s -->
<h2 class="sr-only">서브콘텐츠</h2>
<section id="subContent">
	<div class="sub-content">
		<h2>서비스를 이용하시는데 불편함이 있으셨나요?</h2>
		<div class="con-box mb10">
			<ul>
				<li>탐나오에서 발송하는 메일의 수신거부는 '탐나오 > 마이페이지 > 나의 정보'에서 확인하세요.</li>
				<li>이용 불편 및 각종 문의 사항은 고객센터로 문의주시면 성심성의껏 답변 드리겠습니다.</li>
				<%--<li> 전화문의:1234-5678 (365일 오전 9시~오후6시)</li>--%>
			</ul>
		</div>
		<h2>회원탈퇴 전, 유의사항을 확인해 주시기 바랍니다.</h2>
		<div class="con-box mb10">
			<ul>
				<li>회원탈퇴 시 회원전용 웹 서비스 이용이 불가능합니다.</li>
				<li>거래정보가 있는 경우, 전자상거래 등에서의 소비자 보호에 관한 법률에 따라 계약 또는 청약철회에 관한 기록, 대금결제 및 재화 등의 공급에 관한 기록은 5년동안 보존됩니다.</li>
				<li>보유하셨던 탐나오쿠폰은 탈퇴와 함께 삭제됩니다.</li>
				<li>회원탈퇴 후 탐나오 서비스에 입력하신 1:1문의 및 이용후기, 댓글을 삭제되지 않으며, 회원정보 삭제로 인해 작성자 본인을 확인할 수 없어 편집 및 삭제처리가 원천적으로 불가능합니다.</li>
			</ul>
		</div>
		<%--<h2>회원탈퇴 후 재가입 규정</h2>
		<div class="con-box mb10">
			<ul>
				<li>가입시 사용하신 이메일(${user.email})로 재가입은 불가능하며, 다른 이메일 정보로 가입하여야 합니다.</li>
			</ul>
		</div>--%>
		<h2>회원탈퇴 사유</h2>
		<div class="con-box mb10">
			<div class="text-wrap">
				<p class="info"><strong>탐나오를 떠나시는 이유</strong>를 적어주세요. 소중한 의견을 참고하여 더욱 나은 탐나오가 되겠습니다.</p>
                <p class="label"><label><input type="radio" name="leaving" value="개인정보 변경으로 인한 재가입/중복가입"> 개인정보 변경으로 인한 재가입/중복가입</label></p>
                <p class="label"><label><input type="radio" name="leaving" value="타 사이트의 유사서비스 이용"> 타 사이트의 유사서비스 이용</label></p>
                <p class="label"><label><input type="radio" name="leaving" value="찾고자 하는 정보가 없음"> 찾고자 하는 정보가 없음</label></p>
                <p class="label"><label><input type="radio" name="leaving" value="개인정보 및 사생활 침해 사례 경험"> 개인정보 및 사생활 침해 사례 경험</label></p>
                <p class="label"><label><input type="radio" name="leaving" value="사용이 불편함"> 사용이 불편함</label></p>
                <p class="label"><label><input type="radio" name="leaving" value="상품 구성 및 판매 정책에 대한 문제"> 상품 구성 및 판매 정책에 대한 문제</label></p>
                <p class="label"><label><input type="radio" name="leaving" value="업체와의 트러블"> 업체와의 트러블</label></p>
                <p class="label"><label><input type="radio" name="leaving" value="이벤트 참여를 위한 가입 후 탈퇴"> 이벤트 참여를 위한 가입 후 탈퇴</label></p>
                <p class="label"><label><input type="radio" name="leaving" value="" checked> 직접입력</label>
					<input class="reason" type="text" name="qutRsn" id="qutRsn" placeholder="사유 입력" maxlength="30">
				</p>
			</div>
		</div>
		<label for="agree1"><input type="checkbox" id="agree1" name="agree1">탐나오 회원 탈퇴시 처리사항 안내를 확인하였음에 동의합니다.</label>
		<p class="btn-list">
			<a href="javascript:fn_DropUser();" class="btn22">회원탈퇴</a>
		</p>
	</div>
</section>
<!-- 콘텐츠 e -->
<!-- 푸터 s -->
<jsp:include page="/mw/foot.do"></jsp:include>
<!-- 푸터 e -->
</div>
</body>
</html>