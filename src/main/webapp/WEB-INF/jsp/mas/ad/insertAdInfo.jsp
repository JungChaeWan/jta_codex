<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="validator" 	uri="http://www.springmodules.org/tags/commons-validator" %>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
<script type="text/javascript" src="<c:url value='/dext5editor/js/dext5editor.js'/>"></script>

<validator:javascript formName="AD_DFTINFVO" staticJavascript="false" xhtml="true" cdata="true"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<style>
.ui-autocomplete {
	max-height: 100px;
	overflow-y: auto; /* prevent horizontal scrollbar */
	overflow-x: hidden;
	position: absolute;
	cursor: default;
	z-index: 4000 !important
}
</style>

<script type="text/javascript">
var hrkCodeItem = [];

function fn_Ins(){
	// validation 체크
	<c:if test="${corpInfo.adApiLinkNm eq 'TLL'}">
	if ($("#juniorAgeStdApicode option:selected").val() == ""){
		alert("TL린칸 소아 연령 기준을 선택 해 주세요.");
		return;
	}

	if ($("#childAgeStdApicode option:selected").val() == ""){
		alert("TL린칸 유아 연령 기준을 선택 해 주세요.");
		return;
	}

	</c:if>
	if(!validateAD_DFTINFVO(document.AD_DFTINFVO)){
		return;
	}
	//.validation 체크

	$("#cancelGuide").val(DEXT5.getBodyValueExLikeDiv('editor1'));

	document.AD_DFTINFVO.action = "<c:url value='/mas/ad/insertAdInfo.do' />";
	document.AD_DFTINFVO.submit();
}

function fn_Cancel(){
	document.AD_DFTINFVO.action = "<c:url value='/mas/ad/adInfo.do' />";
	document.AD_DFTINFVO.submit();
}


function fn_onLoadComplete(){

	if("<c:out value='${adDftInf.adArea}'/>" != ""){
		document.AD_DFTINFVO.adArea.value = "<c:out value='${adDftInf.adArea}'/>";
	}

	if("<c:out value='${adDftInf.adDiv}'/>" != ""){
		document.AD_DFTINFVO.adDiv.value = "<c:out value='${adDftInf.adDiv}'/>";
	}

}

function dayRsvUnableYnFunc(){
	if($("input[name=dayRsvUnableYn]:checked").val() == "N"){
		$("select[name=dayRsvUnableTm]").removeAttr('disabled');
	}else{
		$("select[name=dayRsvUnableTm]").val("");	
		$("select[name=dayRsvUnableTm]").attr("disabled", "disabled");
	}
	
}

$(document).ready(function(){
	fn_onLoadComplete();
	dayRsvUnableYnFunc();
});



</script>
</head>
<body>
<div id="wrapper">
	<jsp:include page="/mas/head.do?menu=corp"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">

		<div id="contents_area">
			<!--본문-->
			<form:form commandName="AD_DFTINFVO" name="AD_DFTINFVO" method="post">
				<div id="contents">
					<div class="register_area">
						<h4 class="title03">숙소 정보 추가<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span></h4>
		
						<table border="1" class="table02">
							<colgroup>
								<col width="200" />
								<col width="*" />
								<col width="200" />
								<col width="*" />
							</colgroup>
							<tr>
								<th>업체아이디<span></span></th>
								<td colspan="3">
									<input type="hidden" id="corpId" name="corpId" value='<c:out value="${adDftInf.corpId}" />' />
									<c:out value="${adDftInf.corpId}" />
								</td>
							</tr>
							<tr>
								<th>숙소명<span class="font02">*</span></th>
								<td colspan="3">
									<form:input path="adNm" id="adNm" class="input_text30" placeholder="숙소명을 입력하세요." maxlength="30"  />
									<form:errors path="adNm"  cssClass="error_text" />
								</td>
							</tr>
							<tr>
								<th>지역<span class="font02">*</span></th>
								<td>
									<select name="adArea" >
										<option value="JE">제주시내권</option>
										<option value="EA">제주동부</option>
										<option value="WE">제주서부</option>
										<option value="ES">서귀동부</option>
										<option value="WS">서귀서부</option>
										<option value="SE">중문/서귀포권</option>
									</select>
								</td>
								<th>구분<span class="font02">*</span></th>
								<td>
									<select name="adDiv" >
										<c:forEach var="data" items="${cdAddv}" varStatus="status">
											<option value="${data.cdNum}">${data.cdNm}</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<th>숙소 분류<span class="font02">*</span></th>
								<td colspan="3">
									<label><input type="checkbox" name="adGrd" <c:if test="${(fn:indexOf(adDftInf.adGrd, '호텔') >= 0) }">checked="checked"</c:if> value="호텔"/>호텔</label>
									<label><input type="checkbox" name="adGrd" <c:if test="${(fn:indexOf(adDftInf.adGrd, '리조트') >= 0) }">checked="checked"</c:if> value="리조트"/>리조트</label>
									<label><input type="checkbox" name="adGrd" <c:if test="${(fn:indexOf(adDftInf.adGrd, '펜션') >= 0) }">checked="checked"</c:if> value="펜션"/>펜션</label>
									<label><input type="checkbox" name="adGrd" <c:if test="${(fn:indexOf(adDftInf.adGrd, '풀빌라') >= 0) }">checked="checked"</c:if> value="풀빌라"/>풀빌라</label>
									<label><input type="checkbox" name="adGrd" <c:if test="${(fn:indexOf(adDftInf.adGrd, '게스트하우스') >= 0) }">checked="checked"</c:if> value="게스트하우스"/>게스트하우스</label>
									<label><input type="checkbox" name="adGrd" <c:if test="${(fn:indexOf(adDftInf.adGrd, '콘도') >= 0) }">checked="checked"</c:if> value="콘도"/>콘도</label>
									<label><input type="checkbox" name="adGrd" <c:if test="${(fn:indexOf(adDftInf.adGrd, '유스호스텔') >= 0) }">checked="checked"</c:if> value="유스호스텔"/>유스호스텔</label>
									<label><input type="checkbox" name="adGrd" <c:if test="${(fn:indexOf(adDftInf.adGrd, '카라반') >= 0) }">checked="checked"</c:if> value="카라반"/>카라반</label>
									<label><input type="checkbox" name="adGrd" <c:if test="${(fn:indexOf(adDftInf.adGrd, '글램핑') >= 0) }">checked="checked"</c:if> value="글램핑"/>글램핑</label>
									<label><input type="checkbox" name="adGrd" <c:if test="${(fn:indexOf(adDftInf.adGrd, '독채하우스') >= 0) }">checked="checked"</c:if> value="독채하우스"/>독채하우스</label>
									<label><input type="checkbox" name="adGrd" <c:if test="${(fn:indexOf(adDftInf.adGrd, '민박') >= 0) }">checked="checked"</c:if> value="민박"/>민박</label>
								</td>
							</tr>
							 <tr>
								<th>주요정보</th>
								<td colspan="3">
									<c:forEach var="icon" items="${iconCd}">
										<input type="checkbox" name="iconCd" value="${icon.cdNum}" />${icon.cdNm}
									</c:forEach>
								</td>
							</tr>
							<tr>
								<th>한줄소개</th>
								<td colspan="3">
									<form:input path="adSimpleExp" id="adSimpleExp" class="input_text30" placeholder="한줄소개를 입력하세요.(20자이내)" maxlength="20"  />
									<span class="font02">※ 20자 이내로 입력하세요.</span>
									<form:errors path="adSimpleExp"  cssClass="error_text" />
								</td>
							</tr>
							<tr>
								<th>소아 접수 가능 여부<span class="font02">*</span></th>
								<td>
									<label><input type="radio" name="juniorAbleYn" <c:if test="${adDftInf.juniorAbleYn == 'Y'|| adDftInf.juniorAbleYn == null}">checked="checked"</c:if> value="Y" />가능</label>
									<label><input type="radio" name="juniorAbleYn" <c:if test="${adDftInf.juniorAbleYn == 'N'}">checked="checked"</c:if> value="N" />불가</label>
								</td>
								<th>유아 접수 가능 여부<span class="font02">*</span></th>
								<td>
									<label><input type="radio" name="childAbleYn" <c:if test="${adDftInf.childAbleYn == 'Y'|| adDftInf.childAbleYn == null}">checked="checked"</c:if> value="Y" />가능</label>
									<label><input type="radio" name="childAbleYn" <c:if test="${adDftInf.childAbleYn == 'N'}">checked="checked"</c:if> value="N" />불가</label>
								</td>
							</tr>
							<c:choose>
								<c:when test="${corpInfo.adApiLinkNm eq 'TLL'}">
<%--									<tr>--%>
<%--										<th>금액연동기준<span class="font02">*</span></th>--%>
<%--										<td colspan="3">--%>
<%--											<label><input type="radio" name="tllPriceLink" value="SELL" checked="checked" />판매가</label>--%>
<%--											<label><input type="radio" name="tllPriceLink" value="NET"  />입금가</label>--%>
<%--										</td>--%>
<%--									</tr>--%>
									<tr>
										<th>성인 연령 기준<span class="font02">*</span></th>
										<td colspan="3">
											<form:input path="adultAgeStd" id="adultAgeStd" value="${adDftInf.adultAgeStd}" class="input_text20" placeholder="성인 연령 기준을 입력하세요." maxlength="15" />
											<form:errors path="adultAgeStd"  cssClass="error_text" />
											<span class="font01">예) 만 13세 이상</span>
										</td>
									</tr>
									<tr>
										<th>소아 연령 기준<span class="font02">*</span></th>
										<td colspan="3">
											<form:input path="juniorAgeStd" id="juniorAgeStd" value="${adDftInf.juniorAgeStd}" class="input_text20" placeholder="소인 연령 기준을 기준을 입력하세요." maxlength="15" />
											<form:errors path="juniorAgeStd"  cssClass="error_text" />
											<span class="font01">예) 만 2 ~ 13세 미만</span> &nbsp;&nbsp;
											<select name="juniorAgeStdApicode" id="juniorAgeStdApicode">
												<option value="">--TL린칸기준--</option>
												<option value="CHILDA" >성인과 동일한 식사 및 침구 (CHILDA)</option>
												<option value="CHILDB" >어린이 전용 식사 및 침구 또는 어린이 전용 식사 (CHILDB)</option>
												<option value="CHILDC" >침구 만 (CHILDC)</option>
												<option value="CHILDD" > 식사와 침구는 필요하지 않음 (CHILDD)</option>
											</select>
										</td>
									</tr>
									<tr>
										<th>유아 연령 기준<span class="font02">*</span></th>
										<td colspan="3">
											<form:input path="childAgeStd" id="childAgeStd" value="${adDftInf.childAgeStd}" class="input_text20" placeholder="유아 연령 기준을 입력하세요." maxlength="15" />
											<form:errors path="childAgeStd"  cssClass="error_text" />
											<span class="font01">예) 만 2세(24개월) 미만</span>
											<select name="childAgeStdApicode" id="childAgeStdApicode">
												<option value="">--TL린칸기준--</option>
												<option value="CHILDA" >성인과 동일한 식사 및 침구 (CHILDA)</option>
												<option value="CHILDB" >어린이 전용 식사 및 침구 또는 어린이 전용 식사 (CHILDB)</option>
												<option value="CHILDC" >침구 만 (CHILDC)</option>
												<option value="CHILDD" > 식사와 침구는 필요하지 않음 (CHILDD)</option>
											</select>
										</td>
									</tr>
								</c:when>
								<c:otherwise>
									<tr>
										<th>성인 연령 기준<span class="font02">*</span></th>
										<td colspan="3">
											<form:input path="adultAgeStd" id="adultAgeStd" class="input_text20" placeholder="성인 연령 기준을 입력하세요." maxlength="15"  />
											<form:errors path="adultAgeStd"  cssClass="error_text" />
											<span class="font02">예) 만 13세 이상</span>
										</td>
									</tr>
									<tr>
										<th>소아 연령 기준<span class="font02">*</span></th>
										<td colspan="3">
											<form:input path="juniorAgeStd" id="juniorAgeStd" class="input_text20" placeholder="소아 연령 기준을 기준을 입력하세요." maxlength="15"  />
											<form:errors path="juniorAgeStd"  cssClass="error_text" />
											<span class="font02">예) 만 2 ~ 13세 미만</span>
										</td>
									</tr>
									<tr>
										<th>유아 연령 기준<span class="font02">*</span></th>
										<td colspan="3">
											<form:input path="childAgeStd" id="childAgeStd" class="input_text20" placeholder="유아 연령 기준을 입력하세요." maxlength="15"  />
											<form:errors path="childAgeStd"  cssClass="error_text" />
											<span class="font02">예) 만 2세(24개월) 미만</span>
										</td>
									</tr>
								</c:otherwise>
							</c:choose>

							<tr>
								<th>당일예약</th>
								<td>
									<label><input type="radio" onclick = "dayRsvUnableYnFunc(this)" name="dayRsvUnableYn" <c:if test="${adDftInf.dayRsvUnableYn == 'N' || adDftInf.dayRsvUnableYn == null}">checked="checked"</c:if> value="N" />가능</label>
									<label><input type="radio" onclick = "dayRsvUnableYnFunc(this)" name="dayRsvUnableYn" <c:if test="${adDftInf.dayRsvUnableYn == 'Y'}">checked="checked"</c:if> value="Y" />불가</label>
								</td>
								<th>당일예약불가시간</th>
								<td>
									<select name="dayRsvUnableTm">
										<c:forEach begin="1" end="23" step="1" var="tm">
											<c:if test='${tm < 10}'>
												<c:set var="tm_v" value="0${tm}" />
												<c:set var="tm_t" value="0${tm}" />
											</c:if>
											<c:if test='${tm > 9}'>
												<c:set var="tm_v" value="${tm}" />
												<c:set var="tm_t" value="${tm}" />
											</c:if>
											<option value="${tm_v}" <c:if test="${adDftInf.dayRsvUnableTm == tm_v}">selected="selected"</c:if>>${tm_t}</option>
										</c:forEach>
									</select>시 이후 예약불가
								</td>
							</tr>
							<tr>
								<th>체크인 시간<span class="font02">*</span></th>
								<td>
									<form:input path="chkinTm" id="chkinTm" class="input_text20" placeholder="체크인 시간을 입력하세요." maxlength="20"  />
									<form:errors path="chkinTm" cssClass="error_text" />
								</td>
								<th>체크아웃 시간<span class="font02">*</span></th>
								<td>
									<form:input path="chkoutTm" id="chkoutTm" class="input_text20" placeholder="체크아웃 시간을 입력하세요." maxlength="20"  />
									<form:errors path="chkoutTm" cssClass="error_text" />
								</td>
							</tr>
							<tr>
								<th>검색어</th>
								<td colspan="3">
									<p>
										<input type="text" name="srchWord1" id="srchWord1" maxlength="30" value="${adDftInf.srchWord1}" />
										<input type="text" name="srchWord2" id="srchWord2" maxlength="30" value="${adDftInf.srchWord2}" />
										<input type="text" name="srchWord3" id="srchWord3" maxlength="30" value="${adDftInf.srchWord3}" />
										<input type="text" name="srchWord4" id="srchWord4" maxlength="30" value="${adDftInf.srchWord4}" />
										<input type="text" name="srchWord5" id="srchWord5" maxlength="30" value="${adDftInf.srchWord5}" />
									</p>
									<p>
										<input type="text" name="srchWord6" id="srchWord6" maxlength="30" value="${adDftInf.srchWord6}" />
										<input type="text" name="srchWord7" id="srchWord7" maxlength="30" value="${adDftInf.srchWord7}" />
										<input type="text" name="srchWord8" id="srchWord8" maxlength="30" value="${adDftInf.srchWord8}" />
										<input type="text" name="srchWord9" id="srchWord9" maxlength="30" value="${adDftInf.srchWord9}" />
										<input type="text" name="srchWord10" id="srchWord10" maxlength="30" value="${adDftInf.srchWord10}" />
									</p>
									<br>
									<span class="font02">※ 상품의 주요 특징을 적어주세요 (사용자의 통합 검색 시 검색되는 검색어 입니다)</span>
								</td>
							</tr>
							<%-- <tr>
								<th>설명<span></span></th>
								<td colspan="3">
									<textarea name="adInf" id="adInf" class="" cols="70" rows="5" ><c:out value="${adDftInf.adInf}" escapeXml="false" /></textarea>
		
								</td>
							</tr> --%>
							<tr>
								<th>TIP<span></span></th>
								<td colspan="3">
									<textarea name="tip" id="tip" cols="70" rows="3" ></textarea>
									<br>
									<span class="font02">※ 2줄 권고 / 1줄에 30자 이내 권고</span>
								</td>
							</tr>
							<tr>
								<th>홍보영상</th>
								<td colspan="3">
									<input name="sccUrl" id="sccUrl" class="input_text_full" maxlength="200" />
									<br>
									<p class="font02">※ YouTube 동영상의 경로를 넣으시면 됩니다. ( https://www.youtube.com/embed/유튜브영상고유번호 )</p>
								</td>
							</tr>
							<tr>
								<th>숙소소개<span></span></th>
								<td colspan="3">
									<textarea name="infIntrolod" id="infIntrolod" cols="70" rows="7" ></textarea>
								</td>
							</tr>
							<tr>
								<th>객실 비품안내<span></span></th>
								<td colspan="3">
									<textarea name="infEquif" id="infEquif" cols="70" rows="7" ></textarea>
								</td>
							</tr>
							<tr>
								<th>이용안내<span></span></th>
								<td colspan="3">
									<textarea name="infOpergud" id="infOpergud" cols="70" rows="7" ></textarea>
								</td>
							</tr>
							<tr>
								<th>참고사항(특전사항)<span></span></th>
								<td colspan="3">
									<textarea name="infNti" id="infNti" cols="70" rows="7" ></textarea>
								</td>
							</tr>
							<tr>
								<th>취소/환불 규정<span></span></th>
								<td colspan="3">
									<script type="text/javascript">
										var editor1 = new Dext5editor('editor1');
									</script>
									<input type="hidden" name="cancelGuide" id="cancelGuide" />
								</td>
							</tr>
						</table>
					</div>
					<ul class="btn_rt01">
						<li class="btn_sty04"><a href="javascript:fn_Ins()">추가</a></li>
						<li class="btn_sty01"><a href="javascript:fn_Cancel()">취소</a></li>
					</ul>
					<br>
				</div>
			</form:form>
			<!--//본문-->
		</div>
	</div>
	<!--//Contents 영역-->
</div>
</body>
</html>