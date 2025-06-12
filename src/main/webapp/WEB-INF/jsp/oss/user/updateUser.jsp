<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="validator" 	uri="http://www.springmodules.org/tags/commons-validator" %>
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>

<validator:javascript formName="UPDATEUSERVO" staticJavascript="false" xhtml="true" cdata="true"/>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />

<title></title>

<script type="text/javascript">

var emailChk = "N";

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

function fn_ListUser(){
	document.UPDATEUSERVO.action = "<c:url value='/oss/userList.do' />";
	document.UPDATEUSERVO.submit();
}

function fn_UdtUser(){
	// validation 체크
	if(!validateUPDATEUSERVO(document.UPDATEUSERVO)){
		return;
	}
	if(emailChk == "N"){
		alert('<spring:message code="info.email.duplication"/>');
		$("#email").focus();
		return;
	}
	if($("#pwd").val() != $("#pwd_re").val()){
		alert("<spring:message code='fail.user.passwordUpdate2'/>");
		$("#pwd_re").focus();
		return;
	}
	if(!checkIsHP($("#telNum").val())){
		alert("<spring:message code='errors.phone'/>");
		$("#telNum").focus();
		return;
	}

	document.UPDATEUSERVO.action = "<c:url value='/oss/updateUser.do' />";
	document.UPDATEUSERVO.submit();
}

/**
 * EMAIL 중복체크
 */
function fn_EmailDuplicationChk(){
	if(isNull($("#email").val())||isNull($("#email_host").val())){
		alert("<spring:message code='errors.required2' arguments='이메일'/>");
		$("#email").focus();
		return;
	}
	if(!chekIsEmail2($("#email").val() + "@" + $("#email_host").val())){
		alert("이메일 형식이 올바르지 않습니다.");
		$("#email").focus();
		return;
	}

	var parameters = "";
	parameters += "email=" + $("#email").val() + "@" + $("#email_host").val();
	parameters += "&userId=" + $("#userId").val();
	$.ajax({
		type:"post",
		dataType:"json",
		url:"<c:url value='/emailDuplication.ajax'/>",
		data:parameters ,
		success:function(data){
			if(data.chk == "N"){
				alert('<spring:message code="info.email.notExist"/>');
				emailChk = "Y";
			}else{
				alert('<spring:message code="info.email.exist"/>');
				emailChk = "N";
			}
		}
	});
}

/**
 * 이메일 변경시 중복체크 해제
 */
function fn_EmailOnchange(){
	emailChk = "N";
}

$(document).ready(function(){
	// 이메일 주소 변경에 따른 제어
	$("select[name=email_host_s]").change(function(){
		// 직접입력
		if($("select[name=email_host_s]").val()=="etc"){
			$("input[name=email_host]").removeAttr("readonly");
			$("input[name=email_host]").val("");
		}
		// 그외
		else{
			$("input[name=email_host]").val($("select[name=email_host_s]").val());
			$("input[name=email_host]").attr("readonly","readonly");
		}
		emailChk = "N";
	});
});
</script>
</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=user" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=user&sub=user" flush="false"></jsp:include>
		<div id="contents_area">
			<form:form commandName="UPDATEUSERVO" name="UPDATEUSERVO" method="post">
				<input type="hidden" name="sUserNm" value="${searchVO.sUserNm}" />
				<input type="hidden" name="sUserId" value="${searchVO.sUserId}" />
				<input type="hidden" name="sTelNum" value="${searchVO.sTelNum}" />
				<input type="hidden" name="sEmail" value="${searchVO.sEmail}" />
				<input type="hidden" name="sCorpAdminDiv" value="${searchVO.sCorpAdminDiv}" />
				<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}" />
				<input type="hidden" name="userId" value="${user.userId}" />
			<div id="contents">
			<!--본문-->
			<!--상품 등록-->

				<div class="register_area">
					<h4 class="title03">사용자 수정</h4>

					<table border="1" class="table02">
						<colgroup>
	                        <col width="200" />
	                        <col width="*" />
	                        <col width="200" />
	                        <col width="*" />
	                    </colgroup>
	                    <tr>
	                    	<th>사용자 등급</th>
	                    	<td colspan="3">
	                    		<select id="authNm" name="authNm">
	                    			<option value="USER" <c:if test="${user.authNm == 'USER'}">selected="selected"</c:if>>일반사용자</option>
	                    			<option value="ADMIN" <c:if test="${user.authNm == 'ADMIN'}">selected="selected"</c:if>>관리자</option>
	                    		</select>
	                    	</td>
	                    </tr>
						<tr>
							<th scope="row">사용자명<span class="font02">*</span></th>
							<td>
								<form:input path="userNm" id="userNm" class="input_text10" value="${user.userNm}" placeholder="사용자명을 입력하세요." maxlength="20" />
								<form:errors path="userNm"  cssClass="error_text" />
							</td>
							<th>전화번호<span class="font02">*</span></th>
							<td>
								<form:input path="telNum" id="telNum" class="input_text10" value="${user.telNum}" placeholder="전화번호를 입력하세요." maxlength="20" />
								<form:errors path="telNum"  cssClass="error_text" />
							</td>
						</tr>

						<tr>
							<th scope="row">성별<span class="font02"></span></th>
							<td>
								<input type="radio" name="sex" id="sex1" value="M" <c:if test="${user.sex=='M'}">checked="checked"</c:if> /> <label for="sex1">남자</label>
								<input type="radio" name="sex" id="sex2" value="F" <c:if test="${user.sex=='F'}">checked="checked"</c:if> /> <label for="sex2">여자</label>
							</td>
							<th>생년월일<span class="font02"></span></th>
							<td>
								<form:input path="bth" id="bth" class="input_text10" value="${user.bth}" placeholder="생년월일을 입력하세요." maxlength="8" />(형식: 20001010)
							</td>
						</tr>

						<tr>
							<th>이메일<span class="font02">*</span></th>
							<td colspan="3">
								<form:input path="email" id="email" class="input_text10" onchange="fn_EmailOnchange()" maxlength="30" value="${user.email}" /> @
								<input type="text" name="email_host" id="email_host"  value="${user.email_host}" onchange="fn_EmailOnchange()" />
								<select class="width100" name="email_host_s" class="input_text10" id="email_host_s" title="E-mail 호스트 주소를 선택합니다.">
									<option value="etc">직접입력</option>
									<option value="naver.com" <c:if test="${user.email_host=='naver.com'}">selected=selected</c:if>>naver.com</option>
									<option value="daum.net" <c:if test="${user.email_host=='daum.net'}">selected=selected</c:if>>daum.net</option>
									<option value="gmail.com" <c:if test="${user.email_host=='gmail.com'}">selected=selected</c:if>>gmail.com</option>
								</select>
								<div class="btn_sty07"><span><a href="javascript:fn_EmailDuplicationChk()">중복체크</a></span></div>
								<form:errors path="email"  cssClass="error_text" />
							</td>
						</tr>
						<tr>
							<th>주소</th>
							<td colspan="3">
								<div class="btn_sty07"><span><a href="javascript:openDaumPostcode()">주소검색</a></span></div>
								<form:input path="postNum" id="postNum" readonly="readonly" class="input_text5" value="${user.postNum}" />
								<form:input path="roadNmAddr" id="roadNmAddr" class="input_text15" readonly="readonly" value="${user.roadNmAddr}" />
								<form:input path="dtlAddr" id="dtlAddr" class="input_text15" value="${user.dtlAddr}" />
							</td>
						</tr>
						<tr>
							<th>마케팅 수신여부</th>
							<td>
								<input type="radio" name="marketingRcvAgrYn" id="marketingRcvAgrYn1" value="Y" <c:if test="${user.marketingRcvAgrYn=='Y' or empty user.marketingRcvAgrYn}">checked="checked"</c:if> /> <label for="marketingRcvAgrYn1">동의</label>
								<input type="radio" name="marketingRcvAgrYn" id="marketingRcvAgrYn2" value="N" <c:if test="${user.marketingRcvAgrYn=='N'}">checked="checked"</c:if> /> <label for="marketingRcvAgrYn2">미동의</label>
							</td>
						</tr>
						<tr>
							<th>블랙리스트 여부</th>
							<td colspan="3">
								<input type="radio" name="badUserYn" id="badUserYn2" value="N" <c:if test="${user.badUserYn=='N' or empty user.badUserYn}">checked="checked"</c:if> /> <label for="badUserYn2">일반고객</label>
								<input type="radio" name="badUserYn" id="badUserYn1" value="Y" <c:if test="${user.badUserYn=='Y' }">checked="checked"</c:if> /> <label for="badUserYn1">블랙리스트</label>
							</td>
						</tr>
						<tr>
							<th>블랙리스트 사유</th>
							<td colspan="3">
								<textarea name="badUserRsn" id="badUserRsn" rows="5" cols="10">${user.badUserRsn}</textarea>
							</td>
						</tr>
					</table>
				</div>
				<ul class="btn_rt01">
					<li class="btn_sty04">
						<a href="javascript:fn_UdtUser()">수정</a>
					</li>
					<li class="btn_sty01">
						<a href="javascript:fn_ListUser()">목록</a>
					</li>
				</ul>
				<!--//상품등록-->
				<!--//본문-->
			</div>
			</form:form>
		</div>
	</div>
	<!--//Contents 영역-->
</div>
</body>
</html>