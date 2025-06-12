<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
<%@ taglib prefix="srping"  uri="http://java.sun.com/jsp/jstl/fmt" %>

<un:useConstants var="Constant" className="common.Constant" />
<head>
<meta name="robots" content="noindex, nofollow">
<jsp:include page="/web/includeJs.do" flush="false"></jsp:include>
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>
<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/sub.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/multiple-select.css?version=${nowDate}'/>" />

</head>
<script type="text/javascript">
function fn_DropUser() {
    var qutRsn = $("input[name=leaving]:checked").val();

    if(qutRsn == null || qutRsn == "") {
        qutRsn = $("#qutRsn").val();

        if(qutRsn == null || qutRsn == "") {
            alert("<spring:message code='errors.required2' arguments='탈퇴사유'/>");

            $("#qutRsn").focus();
            return;
        }
    }
    if($("#agree1").is(":checked") != true) {
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

                    location.href = "<c:url value='/web/logout.do'/>";
                } else {
                    alert("<spring:message code='fail.user.drop' />");
                }
            },
            error:fn_AjaxError
        });
    }
}

$(document).ready(function(){

});

</script>
<body>
<header id="header">
	<jsp:include page="/web/head.do" flush="false"></jsp:include>
</header>
<main id="main">
    <div class="mapLocation"> <!--index page에서는 삭제-->
        <div class="inner">
            <span>홈</span> <span class="gt">&gt;</span>
            <span>마이페이지</span> <span class="gt">&gt;</span>
            <span>나의 정보</span> <span class="gt">&gt;</span>
            <span>회원탈퇴</span>
        </div>
    </div>
    <!-- quick banner -->
    <jsp:include page="/web/left.do" flush="false"></jsp:include>
    <!-- //quick banner -->
    <div class="subContainer">
        <div class="subHead"></div>
        <div class="subContents">
            <!-- new contents -->
            <div class="mypage sideON">
                <div class="bgWrap2">
                    <div class="inner">
                        <div class="tbWrap">
                            <jsp:include page="/web/mypage/left.do?menu=dropUser" flush="false"></jsp:include>
                            <div class="rContents smON">
                                <h3 class="mainTitle">회원탈퇴</h3>
                                <div class="secession">
                                    <div class="text-wrap myBG">
										<div class="iconBG">
											<h4 class="comm-title1">회원님 탐나오 서비스를 이용하시는데 불편함이 있으셨나요?</h4>
											<ul class="commList1">
												<li>탐나오에서 발송하는 메일 수신거부는 "탐나오 → 마이페이지 → 나의 정보"에서 확인하세요.</li>
												<li>이용 불편 및 각종 문의 사항은 고객센터로 문의 주시면 성심 성의껏 답변 드리겠습니다.</li>
											</ul>
										</div>
									</div>
                                    <!-- 유의사항 -->
									<article class="info">
										<h5 class="tit">회원탈퇴 전, 유의사항을 확인해 주시기 바랍니다.</h5>
										<div class="txt">
												<p>ㆍ회원탈퇴 시 회원전용 웹 서비스 이용이 불가합니다.</p>
												<p>ㆍ거래정보가 있는 경우, 전자상거래 등에서의 소비자 보호에 관한 법률에 따라
													계약 또는 청약철회에 관한 기록, 대금결제 및 재화 등의 공급에<br>
													<span> 관한 기록은 5년동안 보존됩니다.</span></p>
												<p>ㆍ보유하셨던 탐나오쿠폰은 탈퇴와 함께 삭제됩니다.</p>
												<p>ㆍ회원탈퇴 후 탐나오 서비스에 입력하신 1:1문의 및 이용후기, 댓글은 삭제되지 않으며, 회원정보 삭제로 인해 작성자 본인을 확인할 수 없어 <br>
													<span>편집 및 삭제처리가 원천적으로 불가능 합니다.</span></p>
										</div>
									</article>
                                    <article class="info">
                                        <h5 class="tit">회원탈퇴 사유</h5>
                                        <div class="txt">
                                            <p class="info2"><strong>탐나오를 떠나시는 이유</strong>를 적어주세요. 소중한 의견을 참고하여 더욱 나은 탐나오가 되겠습니다.</p>
                                            <p class="label"><label><input type="radio" name="leaving" value="개인정보 변경으로 인한 재가입/중복가입"> 개인정보 변경으로 인한 재가입/중복가입</label></p>
                                            <p class="label"><label><input type="radio" name="leaving" value="타 사이트의 유사서비스 이용"> 타 사이트의 유사서비스 이용</label></p>
                                            <p class="label"><label><input type="radio" name="leaving" value="찾고자 하는 정보가 없음"> 찾고자 하는 정보가 없음</label></p>
                                            <p class="label"><label><input type="radio" name="leaving" value="개인정보 및 사생활 침해 사례 경험"> 개인정보 및 사생활 침해 사례 경험</label></p>
                                            <p class="label"><label><input type="radio" name="leaving" value="사용이 불편함"> 사용이 불편함</label></p>
                                            <p class="label"><label><input type="radio" name="leaving" value="상품 구성 및 판매 정책에 대한 문제"> 상품 구성 및 판매 정책에 대한 문제</label></p>
                                            <p class="label"><label><input type="radio" name="leaving" value="업체와의 트러블"> 업체와의 트러블</label></p>
                                            <p class="label"><label><input type="radio" name="leaving" value="이벤트 참여를 위한 가입 후 탈퇴"> 이벤트 참여를 위한 가입 후 탈퇴</label></p>
                                            <p class="label"><label><input type="radio" name="leaving" value="" checked> 직접입력</label>&nbsp;&nbsp;<input type="text" size="70" name="qutRsn" id="qutRsn" placeholder="사유 입력" maxlength="30"></p>
                                        </div>
                                    </article>
                                    <p class="agree auto-cancel">
                                        <input name="agree1" id="agree1" type="checkbox"> <label class="box-dec" for="agree1">탐나오 회원탈퇴시 처리사항 안내 확인에 동의합니다.</label>
                                    </p>
                                    <p class="comm-button2">
                                        <a class="color1" href="javascript:fn_DropUser();">회원 탈퇴</a>
                                    </p>
                                </div> <!-- //secession -->
                            </div> <!--//rContents-->
                        </div> <!--//tbWrap-->
                    </div> <!--//inner-->
                </div> <!--//bgWrap2-->
            </div> <!-- //mypage2 -->
            <!-- //new contents -->
        </div> <!-- //subContents -->
    </div> <!-- //subContainer -->
</main>

<jsp:include page="/web/right.do" flush="false"></jsp:include>
<jsp:include page="/web/foot.do" flush="false"></jsp:include>
</body>
</html>