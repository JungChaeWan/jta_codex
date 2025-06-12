<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="validator"	uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="un" 			uri="http://jakarta.apache.org/taglibs/unstandard-1.0"%>

<un:useConstants var="Constant" className="common.Constant" />
<head>
<meta name="robots" content="noindex, nofollow">
<jsp:include page="/web/includeJs.do" />

<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>

<validator:javascript formName="CORP_PNSREQVO" staticJavascript="false" xhtml="true" cdata="true"/>

<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/sub.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<script type="text/javascript">
/**
 * DAUM 연동 주소찾기
 */
function openDaumPostcode() {
	new daum.Postcode({
		oncomplete: function(data) {
			$("#addr").val(data.address);
			$("#dtlAddr").focus();
		}
	}).open();
}

function duplicationCoRegNum() {
	var coRegNum = $("#coRegNum").val().trim();

	if(coRegNum == "") {
		alert("<spring:message code='errors.required2' arguments='사업자등록번호' />");
		return false;
	}
	if(!checkBizID(coRegNum)) {
		alert("<spring:message code='common.wrong.msg' arguments="사업자등록번호"/>");
		$("#coRegNum").focus();
		return false;
	}
	coRegNum = coRegNum.replace(/-/g,"");

	$.ajax({
		url: "<c:url value='/web/coustmer/duplicationCoRegNum.ajax'/>",
		data: "sCoRegNum=" + coRegNum,
		method:"post",
		success:function(data) {
			if(data.resultCode == "${Constant.JSON_SUCCESS}") {
				alert("<spring:message code='info.notExist' arguments='사업자등록번호'/>");

				$("#duplicationCoRegNum").val("Y");
				coRegNum = coRegNum.substring(0, 3) + "-" + coRegNum.substring(3, 5) + "-" + coRegNum.substring(5);
				$("#coRegNum").val(coRegNum);
				$("#coRegNum").prop("readonly", true);
			} else {
				alert("<spring:message code='errors.exist' arguments='사업자등록번호'/>");

				$("#duplicationCoRegNum").val("N");
				$("#coRegNum").focus();
			}
		},
		error: fn_AjaxError
	});
}


function saveCorpPns() {

	if(!validateCORP_PNSREQVO(document.CORP_PNSREQVO)) {
		return;
	}

	var duplicationCoRegNum = $("#duplicationCoRegNum").val();

	if(duplicationCoRegNum == "") {
		alert("<spring:message code='info.duplication.check' arguments='사업자등록번호' />");
		$("#coRegNum").focus();
		return false;
	} else if(duplicationCoRegNum == "N") {
		alert("<spring:message code='errors.exist' arguments='사업자등록번호' />");
		$("#coRegNum").focus();
		return false;
	}

	if ($('input:radio[name=tamnacardMngYn]').is(':checked') == false){
		alert("탐나는전 가맹 유무를 선택 해 주세요.");
		return;
	}

	if(!checkURL($("#hmpgAddr").val())) {
		alert("<spring:message code='common.wrong.msg' arguments='홈페이지 주소' />");
		$("#hmpgAddr").focus();
		return false;
	}
	if(!fn_is_email($("#admEmail").val())) {
		alert("<spring:message code='errors.email' />");
		$("#admEmail").focus();
		return false;
	}
	if(!checkIsHP($("#admMobile").val())) {
		alert("<spring:message code='errors.phone' />");
		$("#admMobile").focus();
		return false;
	}
	if($("#businessLicense").val().trim() == "") {
		alert("<spring:message code='errors.required' arguments='사업자등록증 파일' />");
		return false;
	}
	if($("#passbook").val().trim() == "") {
		alert("<spring:message code='errors.required' arguments='통장 파일' />");
		return false;
	}
	if($("#allCheck").prop("checked") == false) {
		alert("<spring:message code='fail.common.confirm' arguments='약관' />");
		$("#allCheck").focus();
		return false;
	}
	var parameters = new FormData($("#frm")[0]);

	$.ajax({
		type: "post",
		enctype: "multipart/form-data",
		url: "<c:url value='/web/coustmer/insertCorpPns.ajax'/>",
		data: parameters,
		processData: false,
		contentType: false,
		success:function(data) {
			if(data.result == "${Constant.JSON_SUCCESS}") {
				location.href = "<c:url value='/web/coustmer/completeCorpPns.do' />";
			} else {
				alert("<spring:message code='fail.request.msg' />");
			}
		},
		error: fn_AjaxError
	});

}

$(document).ready(function(){
	// 간편가입자 여부(비밀번호 유무) 체크
	if(${empty userInfo.pwd}) {
		alert("간편 가입자는 비밀번호 등록 후 입점 신청을 할 수 있습니다.");

		location.href = "<c:url value='/web/mypage/viewChangePw.do' />" + "?snsDiv=${userInfo.snsDiv}";
	} else {
		$("input[name='belong']").change(function(){
			if($(this).val() == "member" ) {
				$("#branchNm").css("display", "block");
			} else {
				$("#branchNm").css("display", "none");
			}
		});
	}

});

</script>
</head>
<body>
<header id="header">
	<jsp:include page="/web/head.do" />
</header>
<main id="main">
	<div class="mapLocation">
		<div class="inner">
			<span>홈</span> <span class="gt">&gt;</span>
			<span>고객센터</span><span class="gt">&gt;</span>
			<span>입점/제휴 신청</span>
		</div>
	</div>
	<!-- quick banner -->
	<jsp:include page="/web/left.do" />
	<!-- //quick banner -->
	<div class="subContainer">
		<div class="subHead"></div>
		<div class="subContents">
			<!-- new contents -->
			<div class="service-center sideON">
				<div class="bgWrap2">
					<div class="inner">
						<div class="tbWrap">
							<jsp:include page="/web/coustmer/left.do?menu=corpPns" />

							<div class="rContents smON">
								<h3 class="mainTitle">입점/제휴 신청</h3>
								<div class="affiInfo">
									<img src="/images/web/service/affiliates.jpg" alt="회원가입, 입점/제휴 신청, 심사후 담당자 연결, 프로모션 계약체결, 프로모션 개시">
								</div>

								<h5 class="listTitle1">탐나오 입점 신청서 <span class="sub-info">* 표시 필수 입력사항</span></h5>
								<div class="commBoard-wrap">
									<div class="board-write">
										<table class="commRow application">
											<tbody>
												<tr>
													<th>업체정보</th>
													<td class="ctUS">
														<%--@elvariable id="CORP_PNSREQVO" type="oss.corp.vo.CORP_PNSREQVO"--%>
														<form:form commandName="CORP_PNSREQVO" name="CORP_PNSREQVO" id="frm" method="post" enctype="multipart/form-data">
															<table class="commRow commRow-sub line---truth">
																<tr>
																	<th><span class="necessary">*</span> 업체명</th>
																	<td><form:input path="corpNm" type="text" class="full" maxlength="30" /></td>
																	<th><span class="necessary">*</span> 회사유형</th>
																	<td>
																		<input id="company1" type="radio" name="corpType" value="${Constant.CORP_TYPE_CORP}"><label for="company1">법인</label>
																		<input id="company2" type="radio" name="corpType" value="${Constant.CORP_TYPE_INDI}"><label for="company2">개인</label>
																		<input id="company3" type="radio" name="corpType" value="${Constant.CORP_TYPE_SIMP}"><label for="company3">간이</label>
																	</td>
																</tr>
																<tr>
																	<th><span class="necessary">*</span> 사업자등록번호</th>
																	<td colspan='3'>
																		<input type="hidden" id="duplicationCoRegNum" name="duplicationCoRegNum" value="" />
																		<form:input path="coRegNum" type="text" class="fullBT" maxlength="20"/>
																		<a href="javascript:duplicationCoRegNum();" class="comm-sideBT overlap-check">중복체크</a>
																	</td>
																</tr>
																<tr>
																	<th><span class="necessary">*</span> 전화번호</th>
																	<td>
																		<form:input path="rsvTelNum" type="text" class="full" placeholder="064-123-4567" onkeyup="addHyphenToPhone(this);" maxlength="20"/>
																	</td>
																	<th>팩스번호</th>
																	<td>
																		<form:input path="faxNum" type="text" class="full" placeholder="064-123-4567" onkeyup="addHyphenToPhone(this);" maxlength="20"/>
																	</td>
																</tr>
																<tr>
																	<th><span class="necessary">*</span> 협회소속분과</th>
																	<td>
																		<input id="belong1" type="radio" name="belong" value="member"><label for="belong1">회원</label>
																		<input id="belong2" type="radio" name="belong" value="nonMember" checked="checked"><label for="belong2">비회원</label>
																		<!-- 회원시 노출 -->
																		<select name="branchNm" id="branchNm" class="members" style="display:none">
																			<option value="">회원사 선택</option>
																			<option value="국내여행업분과 ">국내여행업분과</option>
																			<option value="국제여행업제1분과">국제여행업제1분과</option>
																			<option value="국제여행업제2분과">국제여행업제2분과</option>
																			<option value="관광호텔업분과">관광호텔업분과</option>
																			<option value="휴양리조트업분과">휴양리조트업분과</option>
																			<option value="일반숙박업분과">일반숙박업분과</option>
																			<option value="전세버스업분과">전세버스업분과</option>
																			<option value="렌터카업분과">렌터카업분과</option>
																			<option value="관광지업분과">관광지업분과</option>
																			<option value="테마관광지업분과">테마관광지업분과</option>
																			<option value="골프장업분과">골프장업분과</option>
																			<option value="외식업분과">외식업분과</option>
																			<option value="관광해양레져업분과">관광해양레져업분과</option>
																			<option value="힐링체험업분과">힐링체험업분과</option>
																			<option value="승마장업분과">승마장업분과</option>
																			<option value="관광면세업분과">관광면세업분과</option>
																			<option value="관광기념품업분과">관광기념품업분과</option>
																			<option value="사업지원분과">사업지원분과</option>
																			<option value="협력지원분과">협력지원분과</option>
																			<option value="특별회원">특별회원</option>
																		</select>
																	</td>
																	<th><span class="necessary">*</span> 탐나는전</th>
																	<td>
																		<input id="tamnacardC" type="radio" name="tamnacardMngYn" value="C"><label for="tamnacardC">가맹점</label>
																		<input id="tamnacardN" type="radio" name="tamnacardMngYn" value="N" checked="checked"><label for="tamnacardN">비가맹점</label>
																	</td>
																</tr>
																<tr>
																	<th>업체 홈페이지</th>
																	<td colspan="3">
																		<form:input path="hmpgAddr" type="text" class="full" placeholder="http://abc.com" maxlength="100"/>
																	</td>
																</tr>
																<tr>
																	<th><span class="necessary">*</span> 업체 주소</th>
																	<td colspan="3">
																		<a class="comm-sideBT" href="javascript:openDaumPostcode()">주소검색</a>
																		<input type="text" name="addr" id="addr" class="addr1" readonly="true"  value="${CORP_PNSREQVO.addr}" />
																		<input type="text" name="dtlAddr" id="dtlAddr" class="addr2" value="${CORP_PNSREQVO.dtlAddr}" maxlength="50" />
																	</td>
																</tr>

																<tr>
																	<th><span class="necessary">*</span> 대표자 성명</th>
																	<td colspan="3"><form:input path="ceoNm" type="text" class="full" maxlength="20"/></td>
																</tr>
																<tr>
																	<th><span class="necessary">*</span> 업태</th>
																	<td><form:input path="bsncon" type="text" class="full" maxlength="30"/></td>
																	<th><span class="necessary">*</span> 업종</th>
																	<td><form:input path="bsntyp" type="text" class="full" maxlength="30"/></td>
																</tr>
																<tr>
																	<th><span class="necessary">*</span> 판매예정상품</th>
																	<td colspan="3"><form:input path="salePrdtList" type="text" class="full" maxlength="60"/></td>
																</tr>
																<tr>
																	<th><span class="necessary">*</span> 예금주명</th>
																	<td><form:input path="depositor" type="text" class="full" maxlength="20" /></td>
																	<th><span class="necessary">*</span> 계좌은행</th>
																	<td><form:input path="bankNm" type="text" class="full" placeholder="농협" maxlength="20"/></td>
																</tr>
																<tr>
																	<th><span class="necessary">*</span> 계좌번호</th>
																	<td colspan="3"><form:input path="accNum" type="text" class="full" placeholder="123456-78-901234" maxlength="30"/></td>
																</tr>
															</table>
														</td>
													</tr>
													<tr>
														<th>담당자 정보</th>
														<td class="ctUS">
															<table class="commRow commRow-sub">
																<tr>
																	<th><span class="necessary">*</span> 담당자 성명</th>
																	<td colspan="3"><form:input path="admNm" type="text" class="full" value="${userInfo.userNm}" maxlength="20"/></td>
																</tr>
																<tr>
																	<th><span class="necessary">*</span> 담당자 email</th>
																	<td colspan="3">
																		<div class="email-form">
																			<form:input path="admEmail" class="full" type="text" name="admEmail" id="admEmail" value="${userInfo.email}" maxlength="50" />
																		</div>
																	</td>
																</tr>
																<tr>
																	<th><span class="necessary">*</span> 담당자 휴대전화</th>
																	<td><form:input path="admMobile" type="text" class="full" placeholder="010-1234-5678" value="${userInfo.telNum}" onkeyup="addHyphenToPhone(this);" maxlength="20"/></td>
																	<th><span class="necessary">*</span> 담당자 직통전화</th>
																	<td><form:input path="admTelnum" type="text" class="full" placeholder="064-123-4567" onkeyup="addHyphenToPhone(this);" maxlength="20"/></td>
																</tr>
																<tr>
																	<th><span class="necessary">*</span> 소속부서</th>
																	<td><form:input path="admDep" type="text" class="full" maxlength="30"/></td>
																	<th><span class="necessary">*</span> 직위</th>
																	<td><form:input path="admOfcpos" type="text" class="full" maxlength="20"/></td>
																</tr>
															</table>
														</td>
													</tr>
													<tr>
														<th>입점 서류</th>
														<td class="ctUS">
															<table class="commRow commRow-sub">
																<c:set var="acceptExt" value="${Constant.FILE_CHECK_EXT}" />
																<tr>
																	<th><span class="necessary">*</span> 사업자등록증</th>
																	<td colspan="3">
																		<input type="file" name="businessLicense" id="businessLicense" accept="${acceptExt}" class="full" onchange="checkFile(this, '${acceptExt}', 5)" />
																	</td>
																</tr>
																<tr>
																	<th><span class="necessary">*</span> 통장</th>
																	<td colspan="3">
																		<input type="file" name="passbook" id="passbook" accept="${acceptExt}" class="full" onchange="checkFile(this, '${acceptExt}', 5)" />
																	</td>
																</tr>
																<tr>
																	<th>영업신고증 및 <br>각종 허가증(택1)<br><span class="necessary">*숙박필수</span></th>
																	<td colspan="3">
																		<input type="file" name="businessCard" id="businessCard" accept="${acceptExt}" class="full" onchange="checkFile(this, '${acceptExt}', 5)" />
																	</td>
																</tr>
																<tr>
																	<th>통신판매업신고증</th>
																	<td colspan="3">
																		<input type="file" name="salesCard" id="salesCard" accept="${acceptExt}" class="full" onchange="checkFile(this, '${acceptExt}', 5)" />
																	</td>
																</tr>
															</table>
															<p class="text-red text-right"><span class="necessary">*</span> 등록가능 파일: ${Constant.FILE_CHECK_SIZE}MB 이하의 ${fn:toUpperCase(fn:replace(acceptExt, ".", ""))} 파일</p>
														</td>
													</tr>
													<tr>
														<th>탐나오 판매약관</th>
														<td class="memo">
															<div class="scroll-wrap">
																<dl class="comm-rule">
																	<dt>제 1 조 (목적)</dt>
																	<dd>
																		본 약관은 제주특별자치도관광협회(이하 “회사”)와 회사가 운영하는 탐나오 사이트(https://www.tamnao.com, 이하 “탐나오”)에 판매자(본 약관에서 ‘판매자’는 탐나오 구매이용약관에 있는 ‘판매자’와 같음)로 입점하여 사이트에서 판매자에게 제공하는 전자상거래 관련 서비스와 기타 서비스(이하 “서비스”)를 이용하는 자 간의 권리, 의무를 확정하고 이를 이행하여 상호 발전을 도모하는 것을 목적으로 합니다.
																	</dd>
																	<dt>제 2 조 (용어의 정의)</dt>
																	<dd>
																		본 약관에서 사용되는 용어의 정의는 본 약관에서 별도로 규정하는 경우를 제외하고 탐나오 구매 이용약관 제2조를 따릅니다.
																	</dd>
																	<dt>제 3 조 (효력)</dt>
																	<dd>
																		① 회사는 본 약관에서 규정되지 않은 세부적인 내용을 탐나오 마켓 제휴상품 계약서(이하 "제휴상품 계약서")에 규정할 수 있으며, 이를 ‘판매회원 거래관리툴(seller Tool, 이하 “판매회원툴”)’을 통하여 공지합니다.

																		② 회사는 관련 법령의 규정 등에 따라 판매서비스 중 특정 서비스에 관한 약관(이하 "개별약관")을 별도로 제정할 수 있으며, 판매회원이 개별약관에 동의하면 개별약관은 제휴상품 계약의 일부를 구성하고, 개별약관에 이 약관과 상충하는 내용이 있으면 개별약관이 우선하여 적용됩니다.

																		③ 탐나오 구매이용약관의 내용 중 성질상 판매 서비스에 적용될 수 있는 내용은 제2항과 동일하게 적용됩니다. 본 약관에 따라 판매회원으로 가입하고자 하는 자는 구매이용약관의 내용을 숙지하고 본 항의 내용에 동의하는 것임을 확인합니다.

																		④ 이 약관, 개별약관의 변경이 있으면 회사는 변경 내용의 효력발생일 7일 이전(다만, 판매회원에게 불리한 내용으로 변경할 때에는 30일 이전)에 해당 변경 사항을 판매회원툴에 공지하며, 판매회원이 변경된 약관, 이용정책, 개별약관에 동의하지 않으면 판매회원 탈퇴(제휴상품 계약의 해지)를 요청할 수 있으며, 변경 적용일까지 거부 의사를 표시하지 않으면 변경 약관, 이용정책, 개별약관에 동의한 것으로 간주합니다.

																		⑤ 변경된 약관은 그 적용일자 이전으로 소급하여 적용되지 않습니다.
																	</dd>
																	<dt>제 4 조 (판매 수수료)</dt>
																	<dd>
																		① 판매수수료는 탐나오 서비스를 이용하는 데 따른 대가로 판매자가 회사에 지급해야 하는 금액을 의미하며, 회사는 구매자로부터 예치받은 금액에서 판매수수료를 공제하고 판매자에게 정산합니다.

																		② 판매수수료는 결제금액(판매자가 정한 상품을 구매할 때 결제한 금액)에 회사가 정한 비율(이하 “판매수수료율”이라 합니다)을 곱한 금액으로 하며, 고객이 취소 요청시 발생할 수 있는 취소수수료 금액도 판매수수료를 적용한다.

																		③ 판매수수료와 판매수수료율은 회사와 판매자간의 협의 또는 회사의 내부 사정에 따라 변경될 수 있습니다.

																		④ 회사는 제1항의 판매수수료에 대하여 매주 정산후 판매자에게 세금계산서를 발행하며, 판매자는 판매회원툴을 통해 정산과 정산 예정금액을 확인할 수 있습니다.
																	</dd>
																	<dt>제 5 조 (판매자의 관리의무)</dt>
																	<dd>
																		① 사이트에서 상품과 용역의 판매는 회사와 상품 판매에 대한 제휴계약이 완료된 판매자의 상품등록과 등록된 상품에 대하여 회사의 상품 승인이 이루어져야 판매가 가능하며, 이를 위해서 판매자는 상품에 관한 정보를 판매회원툴을 통하여 직접 등록, 관리해야 합니다. 이때 상품의 판매가격은 표준마진율, 부가세, 판매수수료 등을 고려하여 판매자가 스스로 결정합니다.

																		② 회사는 판매자에게 상품의 등록에서 판매, 정산에 이르기까지의 과정 및 환불, 취소 과정을 알기 쉽게 설명한 ‘매뉴얼 다운로드’를 판매회원툴에서 제공합니다.

																		③ 판매자는 재고 수량 등 수시로 바뀌는 사항에 대한 데이터를 철저하게 관리해야 하여야 하며, 판매자은 데이터를 허위로 기재할 수 없습니다. 판매자의 데이터 관리 부주의로 인하여 발생하는 구매자와의 분쟁은 판매자의 책임이며, 분재 해결에 소요되는 경비는 판매자 부담으로 합니다.

																		④ 판매자는 전자상거래 등에서의 소비자보호에 관한 법률(이하 “전상법”), 전자금융거래법, 여신전문금융업법, 전기통신사업법, 부가가치세법, 정보통신망 이용촉진 및 정보보호 등에 관한 법률, 상표법, 저작권법 등 사이트에서 상품과 용역의 판매와 관련하여 법령이 요구하는 사항을 지켜야 합니다.

																		⑤ 판매자는 회사가 서면으로 미리 승인하지 않으면 사이트의 상호나 로고 등을 사용할 수 없습니다.

																		⑥ 판매자는 사이트를 통하지 않고 구매자에게 직접 상품을 판매하거나 이를 유도해서는 안 되며, 이를 위반하면 회사는 해당 판매자의 서비스 이용을 정지하거나 서비스 이용계약을 해지할 수 있습니다.

																		⑦ 판매자는 판매된 상품 및 용역에 대한 보증 서비스를 자신의 책임과 비용으로 시행하여야 합니다.

																		⑧ 판매자는 구매회원의 문의에 성실하고 정확하게 대답해야 합니다. 판매자의 불성실, 부정확한 답변으로 구매회원에게 손해가 발생하면 판매자가 이에 대해 책임을 부담합니다.

																		⑨ 판매자는 상품의 판매와 관련하여 특정한 인허가 자격이 요구되면 이에 대한 요건을 만족한 후 판매상품을 등록해야 합니다. 인허가 자격을 갖추지 않은 상태에서 관련 상품을 판매하여 발생한 모든 민형사상의 책임은 판매자 본인에게 있습니다.

																		⑩ 판매자는 상품 등록 후 장기간 판매가 없는 상품이거나 상품 정보관리가 미흡한 경우 회사는 판매자에게 시정조치 및 경고를 할 수 있으며 2회 경고 조치에도 시정 조치가 이루어지지 않을 경우 별도 통지 없이 상품 검색의 효율성 제고와 탐나오 마켓 신뢰도를 위해서 해당 상품을 삭제하거나 판매 중단 처리할 수 있습니다.

																		⑪ 회사는 판매자의 사유로 고객이 구매한 상품에 대하여 3영업일 이전에 처리되지 않거나 취소율이 회사가 정해놓은 일정 수준을 초과하면 경고 또는 업체평가에 반영하는 등 서비스 품질향상을 위하여 판매자에게 필요한 조치를 할 수 있습니다.
																	</dd>
																	<dt>제 6 조 (지적 재산권)</dt>
																	<dd>
																		① 판매자는 상품, 서비스 등의 등록 및 판매 등과 관련하여 제3자의 상표권, 특허권, 저작권, 성명권, 초상권 등 제반 지적 재산권을 침해하지 않아야 하며, 제3자의 지적 재산권을 사용할 때에는 정당한 권리자로부터 사용 허락을 받은 후에 사용해야 합니다.

																		② 판매자가 등록∙사용한 제반 정보(초상, 성명 포함)에 대하여 제3자가 지적 재산권과 관련한 권리침해를 주장하면 회사는 판매자가 제3자의 권리침해가 아님을 입증(법원의 판결 또는 검찰의 불기소처분 등)할 때까지 해당 상품과 서비스에 관한 정보의 등록 및 해당 상품과 서비스의 판매를 중지할 수 있습니다.

																		③ 판매자가 등록한 상품, 서비스에 관한 정보는 판매 장려를 위하여 회사가 제휴한 제3자(및 사이트)와 다른 회원의 블로그 등에 노출될 수 있습니다. 다만, 다른 회원이 블로그 등에 이를 노출하려면 회사가 정한 방침에 동의하고 회사가 허용한 방식으로만 하여야 합니다.

																		④ 판매자는 사이트에 등록∙사용한 정보와 관련하여 제3자로부터 소송 또는 소송 이외의 방법 등으로 이의제기를 받게 되면 회사(및 사이트)를 면책시켜야 하며, 면책에 실패한 경우 그로 인해 회사(및 사이트)가 입은 모든 손해를 배상하여야 합니다.
																	</dd>
																	<dt>제 7 조 (상품 구매 및 배송)</dt>
																	<dd>
																		① 구매자의 상품 구매에 따른 결제가 완료된 순간 회사는 판매자에게 구매 및 결제 정보를 판매회원툴, 이메일(E-mail), SMS등의 방법으로 전달하고, 판매자는 해당 구매 정보에 따라 구매내역 처리를 해야 합니다.

																		② 판매자는 구매내역을 확인하고 고객이 요청한 정보에 따라서 구매내역 처리를 진행하여야 하며, 구매 요청 내용에 대한 구매내역 처리가 불가한 경우는 즉시 고객에게 통지하고 취소  및 환불 처리를 해야 합니다,

																		③ 전상법 제15조 1항에 따라 판매자는 구매자의 결제일로부터 3영업일 이내에 상품 등의 서비스을 위하여 필요한 조치를 하여야 하고(단, 구매자와 판매자 간에 상품등의 공급시기에 관하여 따로 약정한 경우는 제외), 판매회원툴에 구매번호 등의 발송 관련 데이터를 입력하여 발송이 완료되었음을 증명해야 합니다.

																		④ 판매자가 전항의 기한 내에 구매내역 처리를 하지 않거나, 상품 정보의 오류 등으로 구매자가 상품을 정상적으로 이용하지 못하면 판매자는 그에 관한 모든 책임을 부담해야 합니다.

																		⑤ 판매자가 구매자의 구매대금 결제를 확인한 후 상당 기간 구매확인을 하지 않거나, 구매확인을 한 이후라도 구매내역 처리 및 취소 등 후속 절차를 이행하지 않으면 회사는 별도의 개별 정책으로 구매자에게 자동으로 취소 및 환불 처리하는 등의 조치를 할 수 있습니다. 다만, 구매자가 희망하지 않는 경우는 제외하며 개별 정책은 미리 공지합니다.

																		⑥ 판매회원은 주문내역을 확인하고 배송 중 상품이 파손되지 않도록 적절한 포장을 한 후 배송을 증명하거나 추적할 수 있는 물류대행(택배)업체에 배송을 위탁하여야 합니다.

																		⑦ 판매회원이 전항의 기한 내에 발송하지 않거나, 배송지 오류 등으로 구매자가 상품을 정상적으로 받지 못하면 판매회원은 그에 관한 모든 책임을 부담하여야 합니다.
																	</dd>
																	<dt>제 8 조 (취소, 환불)</dt>
																	<dd>
																		① 판매자는 탐나오 사이트 상품 정보란에 반드시 취소수수료 규정을 명시하여야 하며, 구매자가 구매 취소요청시 명시한 취소수수료 규정을 준수하여야 합니다.

																		② 구매자가 상품 구매 후 상품을 이용하기전에 취소나 환불을 요청하면 판매자는 전상법 등 관련 법률에 따라 취소와 환불을 해주어야 하며, 취소수수료 발생시에는 사전 상품 정보에 고지한 취소수수료 규정에 따라서 취소수수료를 고객에게 부과할 수 있습니다.

																		③ 구매자가 상품 구매 후 상품을 이용한 후에 서비스 불만족 등의 사유로 취소 및 환불을 요청하는 경우에 구매자는 판매자와 직접 취소 사유를 설명하고 취소 및 환불 요청을 할 수 있습니다. 단, 회사는 구매자와 판매자간의 발생되는 분쟁에 대해서 중재를 할 수가 있습니다.

																		④ 판매자는 구매취소 요청 건에 대해 2영업일 이내에 환불처리나 취소확인 처리를 하지 않으면, 3영업일에 주문 건은 회사가 판매자에게 별도의 통보없이 환불 처리를 할 수도 있습니다.
																		단, 상품이 이미 발송된 경우(제주특산/기념품 판매자에 한함) 판매자가 고객으로부터 상품을 다시 회수한 일을 기준으로 2영업일 이내에 환불처리나 취소확인 처리를 하지 않으면, 3영업일에 회사가 판매자에게 별도의 통보없이 환불 처리를 할 수도 있습니다.

																		⑤ 판매자는 상품의 하자 또는 사용상의 안전성에 결함이 있으면 취소 및 환불 처리를 하여야 하며, 그에 따른 비용을 부담하여야 합니다.

																		⑥ 상품에 대한 취소요청을 받은 판매자는 취소수수료 확인 및 천재지변에 따른 취소 확인 등이 필요하면 취소를 보류할 수 있고, 정당한 사유가 있으면 환불을 거부하거나 취소수수료를 부과할 수 있습니다.
																	</dd>
																	<dt>제 9 조 (판매대금의 정산)</dt>
																	<dd>
																		① 판매대금은 총 결제대금(취소수수료 발생금액 포함)에서 제4조의 판매수수료를 상계한 금액으로 7일 단위로 고객이 구매한 상품에 대하여 사용이 완료되거나 구매확정상태의 상품을 기준으로 정산함을 원칙으로 합니다. 단, 해당 상품이 사용 전 고객의 요청에 의해 취소되고 판매자의 규정에 의해 취소수수료가 발생했을 경우 취소수수료에 대해서만 판매수수료를 적용합니다.

																		② 회사는 판매회원툴을 통하여 판매금액, 추가정산금액, 공제금액, 정산금액을 판매자에게 제공합니다.

																		③ 판매회원은 판매자로 등록할 때 통장사본을 제출하여야 하며, 판매자가 지정한 입금계좌의 예금주는 판매자(사업자 등록증상의 대표자)과 동일인임을 원칙으로 합니다.

																		④ 사용 완료일 기준으로 금요일~익주 목요일의 사용완료 상품 건에 대하여 익익주 금요일에 정산함을 원칙으로 합니다.
																	</dd>
																	<dt>제 10 조 (정산의 보류)</dt>
																	<dd>
																		① 회사는 판매자의 귀책사유로 발생한 비용을 판매대금 정산 때 공제할 수 있으며, 판매자와의 제휴계약 종료 후에는 해당 판매자의 판매대금의 일정 비율에 해당하는 금액을 제휴계약 종료일로부터 일정 기간 예치하여 이 기간에 구매자로부터 환불 등 이의제기가 있을 때 관련 비용의 지급에 사용할 수 있습니다.

																		② 판매자의 채권자가 신청한 사항에 대해 법원이 판매대금의 가압류, 압류 및 추심명령 등을 결정하면, 회사는 판매자와 채권자 간의 합의 또는 채무액의 변제 등으로 이 결정이 해제될 때까지 판매대금의 정산을 중지할 수 있습니다.

																		③ 본 조에 정한 것 외에도 법률의 규정이나 합리적인 사유가 있으면 회사는 해당 사항을 판매자에게 통지하고 판매대금의 전부 또는 일부의 정산을 일정 기간 유보하거나 상계할 수 있습니다.
																	</dd>
																	<dt>제 11 조 (개인정보의 보호)</dt>
																	<dd>
																		① 판매자는 판매서비스를 이용하면서 얻은 타인의 개인정보(구매자 정보 등)를 이 약관에서 정한 목적 이외의 용도로 사용할 수 없으며, 이를 위반하면 관련 법령에 따라 모든 민/형사상의 법적 책임을 지고 자신의 노력과 비용으로 회사를 면책시켜야만 하며, 회사는 해당 판매회원 및 판매자를 탈퇴시킬 수 있습니다.

																		② 회사는 개인정보 보호를 위하여 배송 등의 목적으로 판매자에게 공개된 구매자의 개인정보를 상당 기간이 지난 후 비공개 조치할 수 있습니다.

																		③ 회사가 개인정보를 보호하는 데 상당한 주의를 기울였음에도 특정 판매자가 제1항을 위반하여 타인의 개인정보를 유출하거나 유용했을 때 회사는 그에 대하여 아무런 책임을 지지 않습니다.

																		④ 전기통신사업법 등 관련 법령이 규정하는 적법한 절차에 따라 수사관서 등이 판매자에 관한 정보의 제공을 회사에 요청했을 때 회사는 해당 자료를 제출할 수 있습니다.

																		⑤ 판매자가 불법행위를 하였다면 회사는 이에 대한 수사 등을 의뢰하기 위하여 관련 자료를 수사관서 등에 제출할 수 있고, 판매자는 이에 동의합니다.

																		⑥ 판매자는 회사로부터 제공받은 개인정보(구매자 정보 등)를 제공받은 목적(상품의 구매내역 처리)의 용도로 법령 또는 회사가 정한 기간 동안 보유할 수 있으며 그 기간이 종료될 경우 즉시 파기해야 합니다. 또한 제공받은 개인정보(구매자 정보 등)의 주체로부터 직접 파기 요청을 받은 경우 이에 응해야 합니다.

																		⑦ 판매자는 관련 법령 및 방송통신위원회 고시에 따라 회사로부터 제공받은 개인정보(구매자 정보 등)를 보호하기 위하여 기술적∙관리적 보호조치를 취해야 합니다.
																	</dd>
																	<dt>제 12 조 (계약기간 및 해지)</dt>
																	<dd>
																		① 회사는 탐나오 상품 판매에 대하여 판매자와 제휴계약를 별도로 진행하며, 제휴계약의 기간은 판매자와 계약서에 날인한 날로부터 해당 연도 말일까지이며, 판매자가 기간 만료 1개월 전까지 서면으로 반대 의사를 표시하지 않는 한 계약기간은 같은 조건으로 1년간 자동 갱신됩니다.

																		② 당사자 일방에게 다음 각 호의 사유가 발생했을 때 그 상대방은 별도의 최고 없이 해지를 통지함으로써 제휴계약을 즉시 해지할 수 있습니다.

																		1. 상품제휴계약(구매이용약관, 전자금융거래 이용약관, 개인정보처리방침 등을 포함)의 의무를 위반하여 상대방으로부터 그 시정을 요구받은 후 7일 이내에 이를 바로잡지 않은 경우

																		2. 부도 등 금융기관의 거래정지, 회생 및 파산절차의 개시, 영업정지 및 취소 등의 행정처분, 주요 자산에 대한 보전처분, 영업양도 및 합병 등으로 이용계약을 더는 이행할 수 없는 경우

																		3. 관련 법령을 위반하거나 판매자의 책임 있는 사유로 회사가 명예 실추 등 유/무형적 손해를 입은 경우

																		4. 판매자의 책임 있는 사유로 2개월간의 거래 건 중 20% 이상에서 구매자로부터 이의가 제기된 경우

																		5. 판매 상품에 대한 중요한 정보를 잘못 기재하거나 기재하지 않아서 소비자에게 혼란과 불만을 유발하는 경우

																		6. 그 밖에 회사의 안전거래 이용규칙 위반 사항에 해당하는 행위를 한 경우

																		③ 판매자는 언제든지 회사에 해지의사를 통지함으로써 이용계약을 해지할 수 있습니다.

																		④ 제휴계약이 해지될 때까지 판매자는 완결되지 않은 구매건의 구매내역 처리, 취소, 환불에 필요한 조치를 해야 하며, 해지 이전에 이미 판매한 상품에 대한 판매자의 책임과 관련 조항은 그 효력을 유지합니다.
																	</dd>
																	<dt>제 13 조 (손해배상)</dt>
																	<dd>
																		① 당사자 일방 또는 당사자 일방의 피고용인, 대리인, 기타 도급 및 위임 등으로 당사자 일방을 대신하여 이용계약을 이행하는 자의 책임 있는 사유로 말미암아 이 계약의 이행과 관련하여 상대방에게 손해가 발생하면, 그 당사자 일방은 상대방에게 발생한 손해를 배상할 책임이 있습니다.

																		② 판매자가 이용계약을 위반하여 회사 또는 사이트의 대외 이미지 실추 등 회사에 유, 무형적 손해가 발생하면, 판매자는 회사의 손해를 배상해야 합니다.
																	</dd>
																	<dt>제 14 조 (회사의 면책)</dt>
																	<dd>
																		① 회사는 사이트 및 기타 IT장치를 기반으로 한 거래시스템만을 제공할 뿐, 판매자가 등록한 상품과 용역, 그에 관한 정보 등에 대한 책임은 판매자에게 있습니다. 또한 판매자와 구매자와의 거래에서 분쟁이 발생했을 때 회사는 그 분쟁에 개입하지 않으며 분쟁의 결과에 대한 모든 책임은 판매자가 부담합니다. 이와 관련하여 회사가 제3자에게 손해를 배상하거나 기타 비용을 지출하게 된다면 회사는 판매자에게 구상권을 행사할 수 있습니다. 단, 회사는 분쟁의 합리적이고 원활한 조정을 위하여 회사가 해당 분쟁에 개입할 수 있으며, 판매자는 회사의 결정을 신의성실의 원칙에 따라 최대한 존중해야 합니다.

																		② 회사는 권리자의 적법한 요구가 있으면 해당 상품과 용역 등에 관한 정보를 삭제하거나 수정할 수 있으며, 판매자는 이에 따른 손해배상을 회사에 청구할 수 없습니다.

																		③ 회사는 전상법 제20조 제2항에 따라 판매자의 정보를 열람하는 방법을 구매자에게 제공할 수 있으며, 판매자는 해당 정보를 기재하지 않거나 허위로 기재하여 발생하는 모든 책임을 져야 합니다.

																		④ 회사는 컴퓨터 등 정보통신설비의 보수, 점검, 교체 및 고장, 통신 두절 등의 사유가 발생하면 판매서비스의 제공을 일시적으로 중단할 수 있으며, 이와 관련하여 고의 또는 중대한 과실이 없는 한 책임을 지지 않습니다.
																	</dd>
																	<dt>제 15 조 (매매부적합상품)</dt>
																	<dd>
																		① 다음 각 호의 매매부적합상품은 판매를 금지하며, 매매부적합상품을 판매했을 때의 모든 책임은 해당 매매부적합상품을 등록한 판매자가 부담합니다.

																		1. 허위 또는 과장 광고한 상품

																		2. 지적 재산권, 상표권 등 타인의 권리를 침해하는 상품

																		3. 형법, 정보통신망이용촉진 및 정보보호 등에 관한 법률 등 관련 법령에서 유통을 금지하는 음란물

																		4. 특정한 면허 보유 및 허가를 필요한 상품인 경우 해당 조건을 갖추지 않은 경우

																		5. 회사가 정하는 판매회원 업종별 판매가 제한되는 상품을 판매하는 경우

																		6. 기타 관계 법령에 저촉되거나 회사가 합리적인 사유로 판매를 금지하는 상품

																		② 회사는 매매부적합상품이 발견되면 해당 상품을 삭제하거나 그 판매를 중지시킬 수 있으며, 해당 상품이 이미 판매되었다면 그 거래를 취소할 수 있습니다. 이때 판매자가 취소된 거래와 관련하여 지급한 서비스 이용료는 환불되지 않습니다.

																		③ 회사는 매매부적합상품을 등록한 판매자의 회원 자격을 정지시키거나 탈퇴시킬 수 있으며, 매매부적합상품으로 입은 손해를 해당 판매자에게 청구할 수 있습니다.

																		④ 판매자가 제1항의 매매부적합상품을 판매하여 구매자에게 손해가 발생했을 때 회사는 손해에 상당하는 금액(구매대금 및 구매자의 정신적 피해에 대한 보상)을 구매자에게 직접 지급할 수 있습니다. 이때 회사는 구매자에게 지급한 구매대금, 정신적 피해에 대한 보상금(금전적 가치로 환산할 수 있는 수단을 포함함) 및 위 절차와 관련하여 회사가 지출한 제반 경비(상품 운송비 등)를 해당 위조품을 판매한 판매자에게 청구할 수 있습니다.

																		⑤ 제4항은 제16조의 회사의 면책을 부인하는 것으로 해석될 수 없습니다.
																	</dd>
																	<dt>제 16 조 (금지행위)</dt>
																	<dd>
																		① 판매자는 회사 또는 사이트의 경영 또는 영업 활동을 방해하는 불공정행위를 직∙간접적으로 하거나 제3자로 하여금 하게 해서는 안 됩니다. 특히 판매자는 직접 또는 회사(또는 사이트)와 경쟁관계에 있는 제3자의 회사(이하 "경쟁회사") 또는 해당 사이트와 연계∙공조하여 ‘독점규제 및 공정거래에 관한 법률’상 금지되는 불공정행위(예컨대, 사업활동방해 등)등을 하여 회사나 사이트의 영업에 피해를 주는 행위를 해서는 안 됩니다.

																		② 회사는 카테고리 오등록, 판매자 업종별 상품등록의 제한 등 회사와 다른 판매자의 정상적인 영업활동을 방해하는 판매방식 행위를 금지하고 있으며 판매자에게 해당 상품의 수정을 요구할 수 있고, 적발횟수에 따라 해당 상품을 판매금지 또는 해당 판매자에게 사이트 이용을 제한할 수 있습니다.

																		1. 카테고리 오등록이란 판매상품과 관계없는 카테고리에 상품을 등록하는 것을 말합니다.

																		2. 판매자 업종별 상품등록의 제한이란 실시간 상품(실시간 항공, 숙박, 렌터카, 골프) 및 제주특산/기념품을 판매하는 판매자가 패키지상품등을 구성하여 판매하는 것을 말합니다.

																		- 회사는 구체적인 업종별 상품등록 정책 및 판단 기준에 대한 정책을 미리 공지하며, 효율적인 탐나오 운영 및 판매회원들의 공동 이익을 보호하기 위하여 업종별 상품등록의 제한이라고 확인(추정)된 상품의 승인을 제한하거나 해당 상품을 삭제하는 등의 조치를 할 수 있습니다.

																		3. 회사는 기타 비정상적인 방법으로 상품을 노출하는 모든 행위를 금지합니다.

																		③ 판매자가 제1항, 제2항 및 이 약관에서 금지하는 행위를 했을 때 회사는 판매자의 서비스 이용정지, 계약해지 등 회사의 손해를 최소화할 수 있는 조치를 할 수 있고, 판매자는 이에 대하여 이의를 제기하지 않습니다.
																	</dd>
																	<dt>제 17 조 (불공정 행위 금지)</dt>
																	<dd>
																		회사는 다음 각 호의 어느 하나에 해당하는 불공정 거래 행위 또는 부당한 공동행위를 하지 않으며, 독점규제 및 공정거래에 관한 법률 등 관련 법령을 지킵니다.

																		1. 정상적인 거래 관행에 비추어 부당한 조건 등 불이익을 판매자에게 제시하여 거래하도록 강제하는 행위

																		2. 판매수수료 및 기타 수익의 결정과 관련하여 회사와 경쟁관계에 있는 제3의 회사와 담합하는 등의 불공정 행위

																		3. 판매자들을 부당하게 차별적으로 취급하여 서비스이용료와 판매촉진서비스 이용료를 판매회원별로 다르게 정하는 행위. 다만, 합리적인 사유가 있으면 다르게 정할 수 있습니다.

																		4. 회사와 경쟁관계에 있는 제3의 회사와 거래하는 것을 금지하거나 부당하게 강요하는 행위 등 판매자에게 불이익을 주는 행위
																	</dd>
																	<dt>제 18 조 (비밀유지)</dt>
																	<dd>
																		① 각 당사자는 법령상 요구되는 경우를 제외하고는 상대방으로부터 취득한 구매자정보, 기술정보, 생산 및 판매계획, 노하우 등 비밀로 관리되는 정보를 제3자에게 누설해서는 안 되며, 그 정보를 이용계약의 이행 이외의 목적으로 사용해서는 안 됩니다.

																		② 제1항의 의무는 이용계약의 종료 후에도 3년간 존속합니다.
																	</dd>
																	<dt>제 19 조 (관할법원)</dt>
																	<dd>
																		이용계약과 관련하여 회사와 판매회원 간에 분쟁이 발생하여 소송이 제기될 때에는 제주지방법원을 1심 관할 법원으로 합니다.
																	</dd>
																	<dt>제 20 조 (보칙)</dt>
																	<dd>
																		① 판매자는 주소지 또는 대금결제를 위한 통장계좌 등에 변경이 있으면 즉시 회사에 해당 내용을 통지해야 하며, 회사는 통지의 지연으로 발생한 손해에 대해 책임을 지지 않습니다.

																		② 각 당사자는 상대방의 서면 동의 없이 제휴상품 계약상의 권리와 의무를 제3자에게 양도하거나 처분할 수 없습니다.

																		③ 이 약관과 관련하여 당사자가 서로 합의하여 추가로 작성한 계약서, 협정서, 약정서 등과 회사의 정책변경, 법령의 제·개정 또는 공공기관의 고시·지침 등에 따라 회사가 사이트 또는 판매회원툴을 통해 판매회원에게 공지하는 내용도 이용계약의 일부를 구성합니다.

																		④ 이 약관과 개별약관에서 정하지 않은 사항은 구매이용약관 및 제휴상품 계약서를 따르며, 구매이용약관에서 정하지 않은 사항은 관련 법령과 상관례를 따릅니다.
																	</dd>
																	<dt>■ 부칙</dt>
																	<dd>
																		제 1 조 (시행일)
																		이 약관은 2016. 01 .19.부터 시행합니다.
																	</dd>
																</dl>
															</div>
														</td>
													</tr>
												</tbody>
											</table>
										</form:form>
										<p class="commAgree"><input id="allCheck" type="checkbox"> <label for="allCheck">판매이용약관 내용을 확인하고 동의합니다.</label></p>
									</div> <!--//board-write-->

									<div class="boardBT2" id="sendCorpPns">
										<p class="button comm-btWrap"><a href="javascript:void(0)" onclick="saveCorpPns();" class="comm-arrowBT comm-arrowBT2">신청하기</a></p>
									</div>
								</div> <!--//commBoard-wrap-->
							</div> <!--//rContents-->
						</div> <!--//tbWrap-->
					</div> <!--//Fasten-->
				</div> <!--//bgWrap2-->
			</div> <!-- //affiliates -->
			<!-- //new contents -->
		</div> <!-- //subContents -->
	</div> <!-- //subContainer -->
</main>

<jsp:include page="/web/foot.do" />
</body>
</html>