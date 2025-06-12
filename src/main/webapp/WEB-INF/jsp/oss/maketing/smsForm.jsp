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
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>


<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">


function fn_onSendType(){
	if( $('#sendTypeV:checked').val()=='SMS' ){
		$('#subjectInput').hide();
	}else{
		$('#subjectInput').show();
	}
}

function fn_onResSend(){
	//alert( $('#resSendV').is(":checked") );

	if($('#resSendV').is(":checked") == true){
		$('#resSendInput').show();
	}else{
		$('#resSendInput').hide();
	}
}

//문자열 바이트 계산
function fn_getByte(strMsg){

	var stringByteLength = 0;
	var stringLength = strMsg.length;
	for(var i=0; i<stringLength; i++) {
    if(escape(strMsg.charAt(i)).length >= 4)
        stringByteLength += 2;
    else if(escape(strMsg.charAt(i)) == "%A7")
        stringByteLength += 2;
    else
        if(escape(strMsg.charAt(i)) != "%0D")
            stringByteLength++;
	}

	return stringByteLength;
}

//목록 추가
function fn_al_Add(name, tel){
	//같은 번호가 있는지 검사
	var bRtn = true;
	$("#payinfo_plus>p").each(function(index){
		if($('input[name=tl_Tel]').eq(index).val() == tel){
			//alert("이미 추가된 번호/그룹 입니다.");
			bRtn = false;
			return;
		}
	});
	if(bRtn == false){
		alert("이미 추가된 번호/그룹 입니다.");
		return;
	}

	var strHtml = "";
	strHtml += '<p>';
	strHtml += '	'+name;
	strHtml += '	<span class="money">'+tel+'</span>';
	strHtml += '	<a class="del" onclick="fn_delPrdt(this);"><img src="'+'<c:url value='/images/web/icon/close5.gif'/>'+'" alt="삭제"></a>';
	strHtml += '	<input type="hidden" name="tl_Name" value="'+name+'"/>';
	strHtml += '	<input type="hidden" name="tl_Tel" value="'+tel+'"/>';
	strHtml += '</p>';
	$("#payinfo_plus").append(strHtml);

}

function fn_al_AddGroup(name, tel){
	//같은 번호가 있는지 검사
	var bRtn = true;
	$("#payinfo_plus>p").each(function(index){
		if($('input[name=tl_Tel]').eq(index).val() == tel){
			//alert("이미 추가된 번호/그룹 입니다.");
			bRtn = false;
			return;
		}
	});
	if(bRtn == false){
		alert("이미 추가된 번호/그룹 입니다.");
		return;
	}

	var strHtml = "";
	strHtml += '<p>';
	strHtml += '	['+name+']';
	strHtml += '	<span class="money"></span>';
	strHtml += '	<a class="del" onclick="fn_delPrdt(this);"><img src="'+'<c:url value='/images/web/icon/close5.gif'/>'+'" alt="삭제"></a>';
	strHtml += '	<input type="hidden" name="tl_Name" value="'+name+'"/>';
	strHtml += '	<input type="hidden" name="tl_Tel" value="'+tel+'"/>';
	strHtml += '</p>';
	$("#payinfo_plus").append(strHtml);
}

//목록 삭제
function fn_delPrdt(obj){
	$(obj).parent().remove();
}

//직접 번호 추가
function fn_al_Direct(){
	if($('#al_directNm').val().length == 0){
		alert("이름을 입력 하세요.");
		$('#al_directNm').focus();
		return;
	}

	if($('#al_directTel').val().length == 0){
		alert("전화번호를 입력 하세요.");
		$('#al_directTel').focus();
		return;
	}

	fn_al_Add($('#al_directNm').val(), $('#al_directTel').val());

}

//전송
function fn_onSend(){


	//오류 검사
	if($("#payinfo_plus>p").length == 0){
		alert("전송할 전화번호를 추가하세요.");
		return;
	}

	if( $('#sendTypeV:checked').val()=='SMS' ){
		if($('#msg').val().length == 0){
			alert("전송할 내용을 입력 하세요.");
			$('#msg').focus();
			return;
		}

		var strMsg = $('#msg').val();
		nSize = fn_getByte(strMsg);

		//alert(nSize);

		if(nSize>80){
			alert("내용이 80Byte(한글 기준 40글자)가 넘어서 MMS로 전송해야 합니다.");
			return;
		}
	}else{

		if($('#subject').val().length == 0){
			alert("제목을 입력 하세요.");
			$('#subject').focus();
			return;
		}

		if($('#msg').val().length == 0){
			alert("전송할 내용을 입력 하세요.");
			$('#msg').focus();
			return;
		}
	}

	if($('#callback').val().length == 0){
		alert("송신번호를 입력 하세요.");
		$('#callback').focus();
		return;
	}


	//데이터 조합
	$('#sendType').val($('#sendTypeV:checked').val());
	$('#reqdate').val($('#tmDate').val() + " " + $('#tmH').val() +":"+ $('#tmM').val() + ":00");
	if($('#resSendV').is(":checked") == true){
		$('#resSend').val("Y");
	}else{
		$('#resSend').val("N");
	}


	//보낼 번호 목록 조합
	var strSendNames = "";
	var strSendTels = "";

	$("#payinfo_plus>p").each(function(index){
		//alert( $('input[name=tl_Name]').eq(index).val() );
		//alert( $('input[name=tl_Tel]').eq(index).val() );
		strSendNames += $('input[name=tl_Name]').eq(index).val() + ",";
		strSendTels  += $('input[name=tl_Tel]').eq(index).val() + ",";
	});
	$('#sendNames').val(strSendNames);
	$('#sendTels').val(strSendTels);

	//alert($('#sendTels').val());

	document.frm.action = "<c:url value='/oss/smsSend.do'/>";
	document.frm.submit();



}

function fn_FindUser(){
	var retVal = window.open("<c:url value='/oss/findUserSMSMail.do'/>?type=SMS","findUser", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");
}

function fn_FindCorp(){
	var retVal = window.open("<c:url value='/oss/findCorpSMSMail.do'/>?type=SMS","findUser", "width=800, height=650, scrollbars=yes, status=no, toolbar=no;");
}


function fn_SelectUer(userId, userNm, tel, mail){
	//alert(userNm + " : " + tel + " : " + mail);
	fn_al_Add(userNm, tel);
}


$(document).ready(function(){

	$("#tmDate").datepicker({
		dateFormat: "yy-mm-dd",
		minDate: "${today}",
		maxDate: '+1y',
		onClose : function(selectedDate) {
			//$("#endDtView").datepicker("option", "minDate", selectedDate);
		}
	});
	$('#tmDate').change(function() {
		//$('#startDt').val($('#startDtView').val().replace(/-/g, ''));
	});


	fn_onSendType();
	fn_onResSend();

	if("${USERCATEVO.sFindYn}"=="Y"){
		fn_al_AddGroup("사용자조건검색","USERCATE");
	}
});


</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=maketing" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=maketing&sub=sms" flush="false"></jsp:include>
		<div id="contents_area">


			<div id="contents">
			<form:form commandName="frm" id="frm" name="frm" method="post"	enctype="multipart/form-data" onSubmit="return false;">

			<!--검색-->
            <div class="search_box">
            	<div class="search_form">
            		<!--
                	<div class="tb_form">
						<table width="100%" border="0">
							<colgroup>
								<col width="100" />
                                <col width="*" />
							</colgroup>
             				<tbody>
             					<tr>
        							<th scope="row">업&nbsp;체&nbsp;명</th>
        							<td>

        								<input type="text" id="sCorpNm" class="input_text_full" name="sCorpNm" value="" title="검색하실 고객명를 입력하세요." />
        							</td>
     							</tr>
     						</tbody>
               			</table>
               		</div>
               		 -->
               		<!--
					<span class="btn">
						<input type="image" src="<c:url value='/images/oss/btn/search_btn01.gif'/>" alt="검색" onclick="javascript:fn_Search('1')" />
					</span>
					 -->

					 <table class="sms-search" style="width: 100%">
					 	<colgroup>
					 		<col width="5%" />
					 		<col />
					 	</colgroup>

					 	<tr>
					 		<th>그룹 추가</th>
					 		<td>
					 			<li class="btn_sty02">	<a href="javascript:fn_al_AddGroup('전체사용자','ALLUSER')">사용자</a></li>
								<li class="btn_sty02">	<a href="javascript:fn_al_AddGroup('전체업체','ALLCORP')">업체</a></li>
								<li class="btn_sty02">	<a href="javascript:fn_al_AddGroup('업체-숙소','CADOCORP')">업체-숙소</a></li>
								<li class="btn_sty02">	<a href="javascript:fn_al_AddGroup('업체-렌터카','CRCOCORP')">업체-렌터카</a></li>
								
								<li class="btn_sty02">	<a href="javascript:fn_al_AddGroup('업체-카시트','CSPCCORP')">업체-카시트</a></li>
								<li class="btn_sty02">	<a href="javascript:fn_al_AddGroup('업체-여행사','CSPTCORP')">업체-여행사</a></li>
								<li class="btn_sty02">	<a href="javascript:fn_al_AddGroup('업체-관광지','CSPUCORP')">업체-관광지</a></li>
								<li class="btn_sty02">	<a href="javascript:fn_al_AddGroup('업체-레저','CSPLCORP')">업체-레저</a></li>
								<li class="btn_sty02">	<a href="javascript:fn_al_AddGroup('업체-맛집','CSPFCORP')">업체-맛집</a></li>
								<li class="btn_sty02">	<a href="javascript:fn_al_AddGroup('업체-뷰티','CSPBCORP')">업체-뷰티</a></li>
								<li class="btn_sty02">	<a href="javascript:fn_al_AddGroup('업체-체험','CSPECORP')">업체-체험</a></li>
								
								<li class="btn_sty02">	<a href="javascript:fn_al_AddGroup('업체-제주특산품','CSVSCORP')">업체-제주특산품</a></li>
								<li class="btn_sty02">	<a href="javascript:fn_al_AddGroup('업체-제주기념품','CSVMCORP')">업체-제주기념품</a></li>
								
								<li class="btn_sty02">	<a href="javascript:fn_al_AddGroup('업체-항공','CAVOCORP')">업체-항공</a></li>
								<li class="btn_sty02">	<a href="javascript:fn_al_AddGroup('업체-골프','CGLOCORP')">업체-골프</a></li>
					 		</td>
						</tr>

						<tr>
							<th>업체 조건</th>
							<td>거래상태
								<select  name="sTradeStatusCd" id="sTradeStatusCd">
   									<option value="">전 체</option>
   									<c:forEach items="${tsCdList}" var="tsCd">
   										<c:if test="${tsCd.cdNum ne Constant.TRADE_STATUS_REG}">
   											<option value="${tsCd.cdNum}" <c:if test="${tsCd.cdNum eq 'TS03'}">selected="true"</c:if>><c:out value="${tsCd.cdNm}" /></option>
   										</c:if>
   									</c:forEach>
   								</select>
							</td>
						</tr>

						<tr>
							<th>검색 추가</th>
							<td>
								<li class="btn_sty01">	<a href="javascript:fn_FindUser()">사용자 검색</a></li>
								<li class="btn_sty01">	<a href="javascript:fn_FindCorp()">업체 검색</a></li>
							</td>
						</tr>


						<tr>
							<th>직접 추가</th>
							<td>
								이름 : <input type="text" name="al_directNm" id="al_directNm" value=""/>
								&nbsp;전화번호 : <input type="text" name="al_directTel" id="al_directTel" value=""/>
								<li class="btn_sty04"><a href="javascript:fn_al_Direct()">추가</a></li>
							</td>
						</tr>

					</table>
              	</div>
            </div>



	            <table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb smsTB">
	            <colgroup>
	            	<col width="25%" />
	            	<col />
	            </colgroup>
	            <tr>
		            <td>
		            	<b>전송 목록</b>
		            	<br/>
		            	<div class="pay-info">
                            <div id="payinfo_plus">
                            </div>
                        </div>
                        <input type="hidden" name="sendNames" id="sendNames" value=""/>
		            	<input type="hidden" name="sendTels" id="sendTels" value=""/>
		            </td>
		            <td>
		            	<b>내용</b>
		            	<br/>
		            	<label><input type="radio" name="sendTypeV" id="sendTypeV" value="SMS" onclick="fn_onSendType()" checked="checked"/>SMS</label>
		            	<label><input type="radio" name="sendTypeV" id="sendTypeV" value="MMS" onclick="fn_onSendType()"/>MMS</label>
		            	<input type="hidden" name="sendType" id="sendType" value=""/>
		            	<br/>
		            	<span id="subjectInput">
		            		제목 : <input type="text" name="subject" id="subject" value="[탐나오]"/>
		            	</span>
		            	<br/>

		            	내용 : 
		            	<select id="wordsContentsId" onChange="$('#msg').val(this.value);">
 							<option value="">= 선 택 =</option>
							<c:forEach items="${wordsList}" var="words">								
								<option value="${words.wordsContents}"><c:out value="${words.wordsSubject}" /></option>
							</c:forEach>
						</select>
		            	<br/>
		            	<textarea rows="10" cols="30" name="msg" id="msg" ></textarea>

		            	<div class="reservation">
		            		<span>
				            	<label> <input type="checkbox" name="resSendV" id="resSendV" value="Y" onclick="fn_onResSend()"/> 예약전송 </label>
				            	<input type="hidden" name="resSend" id="resSend" value=""/>
			            	</span>
			            	<span id="resSendInput">
								<input type="text" id="tmDate" name="tmDate"
									class="input_text3 center"
									value="${today}"/>
									<%--
									readonly="readonly" /> <input type="hidden" id="startDt"
									name="startDt" class="input_text3 center"
									value="${calendarVO.startDt}" />
									--%>
								<select id="tmH" name="tmH">
									<c:forEach var="cnt" begin="0" end="23">
										<c:if test="${cnt < 10 }">
											<option value="0${cnt}">0${cnt}</option>
										</c:if>
										<c:if test="${!(cnt < 10) }">
											<option value="${cnt}">${cnt}</option>
										</c:if>
									</c:forEach>
								</select>시
								<select id="tmM" name="tmM">
									<c:forEach var="cnt" begin="0" end="59">
										<c:if test="${cnt < 10 }">
											<option value="0${cnt}">0${cnt}</option>
										</c:if>
										<c:if test="${!(cnt < 10) }">
											<option value="${cnt}">${cnt}</option>
										</c:if>
									</c:forEach>
								</select>분
								<input type="hidden" name="reqdate" id="reqdate" value=""/>
							</span>
						</div>

						송신번호 : <input type="text" name="callbak" id="callback" value="${fromTel}"/>
						<li class="btn_sty03">
							<span><a href="javascript:fn_onSend()">보내기</a></span>
						</li>

		            </td>
	            </tr>
	            </table>


				<input type="hidden" id="sFindYn" name="sFindYn" value="${USERCATEVO.sFindYn}"/>
	            <input type="hidden" id="sProcStdS" name="sProcStdS" value='${USERCATEVO.sProcStdS}'/>
	            <input type="hidden" id="sProcStdE" name="sProcStdE" value='${USERCATEVO.sProcStdE}'/>
	            <input type="hidden" id="sSex" name="sSex" value='${USERCATEVO.sSex}'/>
	            <input type="hidden" id="sAge" name="sAge" value='${USERCATEVO.sAge}'/>
	            <input type="hidden" id="sArea" name="sArea" value='${USERCATEVO.sArea}'/>
	            <input type="hidden" id="sLoginCntS" name="sLoginCntS" value='${USERCATEVO.sLoginCntS}'/>
	            <input type="hidden" id="sLoginCntE" name="sLoginCntE" value='${USERCATEVO.sLoginCntE}'/>
	            <input type="hidden" id="sBuyCntS" name="sBuyCntS" value='${USERCATEVO.sBuyCntS}'/>
	            <input type="hidden" id="sBuyCntE" name="sBuyCntE" value='${USERCATEVO.sBuyCntE}'/>
	            <input type="hidden" id="sBuyAmtS" name="sBuyAmtS" value='${USERCATEVO.sBuyAmtS}'/>
	            <input type="hidden" id="sBuyAmtE" name="sBuyAmtE" value='${USERCATEVO.sBuyAmtE}'/>
	            <input type="hidden" id="sReBuy" name="sReBuy" value='${USERCATEVO.sReBuy}'/>
	            <input type="hidden" id="sCate" name="sCate" value='${USERCATEVO.sCate}'/>
	            <input type="hidden" id="sBuyDateS" name="sBuyDateS" value='${USERCATEVO.sBuyDateS}'/>
	            <input type="hidden" id="sBuyDateE" name="sBuyDateE" value='${USERCATEVO.sBuyDateE}'/>
	            <input type="hidden" id="sEvent" name="sEvent" value='${USERCATEVO.sEvent}'/>
	            <input type="hidden" id="sUseepil" name="sUseepil" value='${USERCATEVO.sUseepil}'/>
	            <input type="hidden" id="sPayDiv" name="sPayDiv" value='${USERCATEVO.sPayDiv}'/>
	            <input type="hidden" id="sLPointYn" name="sLPointYn" value='${USERCATEVO.sLPointYn}'/>
	            <input type="hidden" id="sCuponYn" name="sCuponYn" value='${USERCATEVO.sCuponYn}'/>
	            <input type="hidden" id="sBlkList" name="sBlkList" value='${USERCATEVO.sBlkList}'/>

            </form:form>

			<%--
            <p class="search_list_ps">[총 <strong>${totalCnt}</strong>건]</p>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
				<thead>
					<tr>
						<th>번호</th>
						<th>업체아이디</th>
						<th>업체명</th>
						<th>업체분류</th>
						<th>대표자명</th>
						<th>대표자전화번호</th>
						<th>예약전화번호</th>
					</tr>
				</thead>
				<tbody>
					<!-- 데이터 없음 -->
					<c:if test="${fn:length(resultList) == 0}">
						<tr>
							<td colspan="7" class="align_ct">
								<spring:message code="common.nodata.msg" />
							</td>
						</tr>
					</c:if>
					<c:forEach var="corpInfo" items="${resultList}" varStatus="status">
						<tr style="cursor:pointer;" onclick="fn_DtlCorp('${corpInfo.corpId}')">
							<td class="align_ct"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
							<td class="align_ct"><c:out value="${corpInfo.corpId}"/></td>
							<td class="align_ct"><c:out value="${corpInfo.corpNm}"/></td>
							<td class="align_ct">
								<c:if test="${corpInfo.corpCd=='AD'}">숙박</c:if>
								<c:if test="${corpInfo.corpCd=='RC'}">렌트카</c:if>
								<c:if test="${corpInfo.corpCd=='GL'}">골프</c:if>
								<c:if test="${corpInfo.corpCd=='SP'}">소셜상품</c:if>
							</td>
							<td class="align_ct"><c:out value="${corpInfo.ceoNm}"/></td>
							<td class="align_ct"><c:out value="${corpInfo.ceoTelNum}"/></td>
							<td class="align_ct"><c:out value="${corpInfo.rsvTelNum}"/></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<p class="list_pageing">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
			</p>
			<ul class="btn_rt01">
				<li class="btn_sty01">
					<a href="javascript:fn_InsCorp()">등록</a>
				</li>
			</ul>
			</div>
			 --%>
		</div>

	</div>
</div>
</body>
</html>