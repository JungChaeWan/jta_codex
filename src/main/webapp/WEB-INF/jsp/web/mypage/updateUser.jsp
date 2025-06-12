<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="validator" 	uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="un" 		    uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />
<head>
<meta name="robots" content="noindex, nofollow">
<jsp:include page="/web/includeJs.do" flush="false"></jsp:include>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>

<validator:javascript formName="UPDATEUSERVO" staticJavascript="false" xhtml="true" cdata="true"/>
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

<script type="text/javascript">
/**
 * DAUM 연동 주소찾기
 */
function openDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            // 우편번호와 주소 정보를 해당 필드에 넣고, 커서를 상세주소 필드로 이동한다.
            // document.getElementById('post1').value = data.postcode1;
            // document.getElementById('post2').value = data.postcode2;
            // 2015.08.01 부터 우편번호 5자리 실행
            document.getElementById('postNum').value = data.zonecode;
            document.getElementById('roadNmAddr').value = data.address;

            //전체 주소에서 연결 번지 및 ()로 묶여 있는 부가정보를 제거하고자 할 경우,
            //아래와 같은 정규식을 사용해도 된다. 정규식은 개발자의 목적에 맞게 수정해서 사용 가능하다.
            //var addr = data.address.replace(/(\s|^)\(.+\)$|\S+~\S+/g, '');
            //document.getElementById('addr').value = addr;
            document.getElementById('dtlAddr').focus();
        }
    }).open();
}

var phoneNum;

function fn_SendSms() {
    var hp = $("#hp").val();

    if(hp == null || hp == "") {
        alert("<spring:message code='errors.required2' arguments='휴대폰번호' />");
        return;
    }
    if(checkIsHP(hp)) {
        var parameters = "telNum=" + hp;

        $.ajax({
            type:"post",
            dataType:"json",
            url:"<c:url value='/web/getAuthNum.ajax'/>",
            data:parameters,
            success:function(data){
                if(data.success == "Y") {
                    alert("<spring:message code='success.send.certNum'/>");

                    phoneNum = hp;
                    $("#hp").val(hp);
                    $("#info").hide();
                    $("#msg").show();
                } else {
                    alert(data.failMsg);
                }
            }
        });
    } else {
        alert("<spring:message code='errors.phone'/>");
    }
}

//인증번호 체크
function fn_Cert() {
    var certNum = $("#certNumber").val();

    if(certNum == null || certNum == "") {
        alert("<spring:message code='errors.required2' arguments='인증번호' />");
        return;
    }
    var parameters = "telNum=" + phoneNum;
    parameters += "&authNum=" + certNum;

    $.ajax({
        type:"post",
        dataType:"json",
        url:"<c:url value='/web/checkAuthNum.ajax'/>",
        data:parameters,
        success:function(data){
            if(data.success == "Y") {
                alert("<spring:message code='success.phone.cert' />");

                $("#telNum").val(phoneNum);
                $("#telNumView").html(phoneNum);

                close_popup('.member-ctWrap');
            } else {
                alert(data.failMsg);
            }
        }
    });
}

// SNS 연동해제
function fn_SnsUnlink(val) {
    if(confirm("<spring:message code='confirm.sns.unlink'/> ")) {
        $("#snsDiv").val(val);

        if(val == "N") {
            fn_NaverUnlink();
        } else {
            fn_KakaoUnlink();
        }
    }
}

// 네이버 로그인 연동해제
function fn_NaverUnlink() {
    document.UPDATEUSERVO.action = "<c:url value='/web/naverUnlink.do'/>";
    document.UPDATEUSERVO.submit();
}

// 카카오 로그인 연동해제
function fn_KakaoUnlink() {
    document.UPDATEUSERVO.action = "<c:url value='/web/kakaoUnlink.do'/>";
    document.UPDATEUSERVO.submit();
}

function fn_UdtUser() {
    // validation 체크
    if(!validateUPDATEUSERVO(document.UPDATEUSERVO)) {
        return;
    }
    if(confirm("<spring:message code='common.update.msg' />")) {
        if($("#marketingRcvAgrYnChk").is(":checked")) {
            $("#marketingRcvAgrYn").val("Y");
        } else {
            $("#marketingRcvAgrYn").val("N");
        }

        document.UPDATEUSERVO.action = "<c:url value='/web/mypage/updateUser.do'/>";
        document.UPDATEUSERVO.submit();
    }
}

$(document).ready(function(){
    if("${resultCd}" == "Y") {
        alert("<spring:message code='success.common.update' />");
    } else if("${resultCd}" == "N") {
        alert("<spring:message code='fail.common.update' />");
    }

});

</script>
</head>
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
            <span>개인정보수정</span>
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
                            <jsp:include page="/web/mypage/left.do?menu=updateUser" flush="false"></jsp:include>
                            <div class="rContents smON">
                                <h3 class="mainTitle">개인정보수정</h3>
                                <div class="member-myinfo">
                                    <!-- <p class="secession"><a href="">회원탈퇴 바로가기</a></p> -->
                                    <form:form commandName="UPDATEUSERVO" name="UPDATEUSERVO" method="post">
                                        <input type="hidden" name="userId" value="${user.userId}" />
                                        <input type="hidden" name="partnerCode" value="${user.partnerCode}" />
                                        <table class="commRow">
                                            <tr>
                                                <th>아이디 <span>(이메일)</span></th>
                                                <td>
                                                    <form:hidden path="email" value="${user.email}" />
                                                    ${user.email}
                                                </td>
                                            </tr>
                                            <tr>
                                                <th>이름</th>
                                                <td>
                                                    <form:input path="userNm" id="userNm" class="mgR commWidth" value="${user.userNm}" />
                                                    <form:errors path="userNm" cssClass="error_text" />
                                                </td>
                                            </tr>
                                            <%--<tr>
                                                <th>성별</th>
                                                <td>
                                                    <input type="radio" name="sex" id="sex1" value="M" <c:if test="${user.sex=='M'}">checked="checked"</c:if> /> <label for="sex1">남자</label>
                                                    <input type="radio" name="sex" id="sex2" value="F" <c:if test="${user.sex=='F'}">checked="checked"</c:if> /> <label for="sex2">여자</label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th>생년월일</th>
                                                <td>
                                                    <form:input path="bth" id="bth" class="input_text10" value="${user.bth}" placeholder="생년월일을 입력하세요." maxlength="8" />(형식: 20001010)
                                                </td>
                                            </tr>--%>
                                            <tr class="phoneWrap">
                                                <th>휴대폰번호</th>
                                                <td>
                                                    <form:hidden path="telNum" value="${user.telNum}" />
                                                    <span id="telNumView">${user.telNum}</span><a class="mgL commBT" href="javascript:void(0)" onclick="show_popup('#phone-change');">변경하기</a>

                                                    <!-- 휴대폰 인증 -->
                                                    <div id="phone-change" class="member-ctWrap comm-layer-popup_fixed">
                                                        <div class="comm-close"><a onclick="close_popup('.member-ctWrap');"><img src="/images/web/icon/popup_close.png" alt="닫기"></a></div>
                                                        <div class="rArea">
                                                        	<div class="cellphone-Confirm">휴대폰 인증</div>
                                                            <div class="check">
                                                                <p class="phone">
                                                                    <span class="title">휴대폰</span>
                                                                    <input type="text" name="hp" id="hp" onkeyup="addHyphenToPhone(this);"/>
                                                                    <a href="javascript:fn_SendSms();" class="mcBT">인증</a>
                                                                </p>
                                                                <!--인증발송문구-->
                                                                <p class="cite">
                                                                    <span class="title">인증번호</span>
                                                                    <input id="certNumber" type="text">
                                                                    <a href="javascript:fn_Cert();" class="mcBT--red">확인</a>
                                                                </p>
                                                            </div>
                                                            <ul class="popup-info" id="info">
                                                                <li>
                                                                	· 메시지 수신 가능한 휴대폰으로 인증번호를 받으실 수 있습니다.<br>
																	· 인증번호 전송비용은 탐나오에서 부담합니다.
																</li>
                                                            </ul>
                                                            <ul class="popup-info" id="msg" style="display: none">
                                                                <li>· 인증번호가 오지 않으면 입력하신 정보가 정확한지 확인하여 주세요.</li>
                                                            </ul>
                                                        </div>
                                                    </div> <!--//member-ctWrap-->
                                                </td>
                                            </tr>
                                            <c:if test="${!empty user.snsDiv}">
                                                <tr>
                                                    <th>간편로그인</th>
                                                    <td>
                                                        <form:hidden path="snsDiv" id="snsDiv" value="${user.snsDiv}" />
                                                        <c:if test="${fn:contains(user.snsDiv, 'N')}">
                                                            <img src="<c:url value='/images/web/sns/info/naver.png'/>" alt="네이버">
                                                            <c:if test="${!empty user.pwd || fn:contains(user.snsDiv, ',')}">
                                                                <a class="editBT mgL" onclick="fn_SnsUnlink('N');">연동해제</a>
                                                            </c:if>
                                                        </c:if>
                                                        <c:if test="${fn:contains(user.snsDiv, ',')}">
                                                            <br>
                                                        </c:if>
                                                        <c:if test="${fn:contains(user.snsDiv, 'K')}">
                                                            <img src="<c:url value='/images/web/sns/info/kakao.png'/>" alt="카카오">
                                                            <c:if test="${!empty user.pwd || fn:contains(user.snsDiv, ',')}">
                                                                <a class="editBT mgL" onclick="fn_SnsUnlink('K');">연동해제</a>
                                                            </c:if>
                                                        </c:if>
                                                    </td>
                                                </tr>
                                            </c:if>
                                            <tr class="addrWrap">
                                                <th>주소</th>
                                                <td>
                                                    <form:input path="postNum" id="postNum" class="mgR commWidth" readonly="readonly" value="${user.postNum}" /><a class="commBT" href="javascript:openDaumPostcode()">주소검색</a><br>
                                                    <form:input path="roadNmAddr" id="roadNmAddr" class="mgR address" readonly="readonly" value="${user.roadNmAddr}" />
                                                    <form:input path="dtlAddr" id="dtlAddr" class="address sub" value="${user.dtlAddr}" />
                                                </td>
                                            </tr>
                                            <tr class="agWrap">
                                                <th>수신동의</th>
                                                <td class="auto-cancel">
                                                    <p>예약하신 내역과 이벤트, 특가 정보를 이메일 또는 휴대폰 문자메시지로 안내 받으실 수 있습니다.</p>
                                                    <input type="hidden" name="marketingRcvAgrYn" id="marketingRcvAgrYn" value="${user.marketingRcvAgrYn}" >
                                                    <input type="checkbox" id="marketingRcvAgrYnChk" name="marketingRcvAgrYnChk" <c:if test="${user.marketingRcvAgrYn=='Y'}">checked="checked"</c:if>>
                                                    <label class="box-dec" for="marketingRcvAgrYnChk">마케팅활용정보 수신동의</label>
                                                </td>
                                            </tr>
                                        </table>
                                    </form:form>
                                    <p class="button">
                                        <button class="comm-arrowBT comm-arrowBT2" type="submit" onclick="fn_UdtUser();">수정하기</button>
                                        <!-- <button class="comm-arrowBT">취소하기</button>a -->
                                    </p>
                                </div> <!--//member-myinfo-->
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