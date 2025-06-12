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
<%@ taglib prefix="un" 			uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
           
<un:useConstants var="Constant" className="common.Constant" />
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>

<validator:javascript formName="RC_AMTINFVO" staticJavascript="false" xhtml="true" cdata="true"/>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">
/**
 * 목록
 */
function fn_ListPrdt(){
	document.amtInf.action = "<c:url value='/mas/rc/productList.do'/>";
	document.amtInf.submit();
}

/**
 * 상품 승인 요청
 */
function fn_ApprovalReqPrdt(){
	$.ajax({
		url : "<c:url value='/mas/rc/approvalPrdt.ajax'/>",
		dataType:"json",
		data : "prdtNum=${prdtInf.prdtNum}",
		success: function(data) {
			
			fn_ListPrdt();
		},
		error : function(request, status, error) {
			if(request.status == "500"){
				alert("<spring:message code='fail.common.logout'/>");
				location.reload(true);
			}else{
				alert("<spring:message code='fail.common.msg'/>");
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		}
	});
}

/**
 * 상품 승인 취소 요청
 */
function fn_CancelApproval(){
	$.ajax({
		url : "<c:url value='/mas/rc/cancelApproval.ajax'/>",
		dataType:"json",
		data : "prdtNum=${prdtInf.prdtNum}",
		success: function(data) {
			
			fn_ListPrdt();
		},
		error : function(request, status, error) {
			if(request.status == "500"){
				alert("<spring:message code='fail.common.logout'/>");
				location.reload(true);
			}else{
				alert("<spring:message code='fail.common.msg'/>");
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		}
	});
}

function fn_InsPrdtAmt(){
	// 콤마 제거
	delCommaFormat();
	
	// validation 체크
	if(!validateRC_AMTINFVO(document.amtInf)){
		return;
	}
	
	document.amtInf.action = "<c:url value='/mas/rc/insertPrdtAmt.do'/>";
	document.amtInf.submit();
}

function fn_OpenUdtPrdtAmt(aplDt){
	var parameters = "prdtNum=" + $("#prdtNum").val();
	parameters += "&aplDt=" + aplDt;
	
	$.ajax({
		type:"post", 
		dataType:"json",
		async:false,
		url:"<c:url value='/mas/rc/selectByPrdtAmt.ajax'/>",
		data:parameters ,
		success:function(data){
			$("#viewAplDt").datepicker("destroy");
			// 수정 값 초기화
			$("#viewAplDt").val(fn_addDate(data.amtInf.aplDt));
			$("#aplDt").val(data.amtInf.aplDt);
			$("#tm6Amt").val(data.amtInf.tm6Amt);
			$("#tm12Amt").val(data.amtInf.tm12Amt);
			$("#tm24Amt").val(data.amtInf.tm24Amt);
			$("#tm1AddAmt").val(data.amtInf.tm1AddAmt);
			
			$("#gubun").val("U");
			
			// 에러 문구값 초기화
			$(".error_text").text("");
			
			$("#btnResist").hide();
			$("#btnUpdate").show();
			
			show_popup($("#lay_popup"));
			
			// 금액 소숫점 추가
		    $('.numFormat').each(function() {
		    	$(this).val($(this).val().replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'));
		    });
		},
		error : function(request, status, error) {
			if(request.status == "500"){
				alert("<spring:message code='fail.common.logout'/>");
				location.reload(true);
			}else{
				alert("<spring:message code='fail.common.msg'/>");
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		}
	});
}

function fn_UdtPrdtAmt(){
	// 콤마 제거
	delCommaFormat();
	
	// validation 체크
	if(!validateRC_AMTINFVO(document.amtInf)){
		return;
	}
	
	document.amtInf.action = "<c:url value='/mas/rc/updatePrdtAmt.do'/>";
	document.amtInf.submit();
}

function fn_AddAmt(){
	$("#viewAplDt").datepicker();
	
	// 입력 값 초기화
	$("#amtLay input:text").val("");
	
	$("#gubun").val("I");
	// 에러 문구값 초기화
	$(".error_text").text("");
	
	$("#btnResist").show();
	$("#btnUpdate").hide();
	
	show_popup($("#lay_popup"));
}

function fn_DelPrdtAmt(aplDt){
	if(confirm("<spring:message code='common.delete.msg'/>")){
		$("#aplDt").val(aplDt);
		document.amtInf.action = "<c:url value='/mas/rc/deletePrdtAmt.do'/>";
		document.amtInf.submit();
	}
}

$(document).ready(function(){
	if('${errorCode}' == '1'){
		alert("상품 정보를 확인해 주세요.");
		location.href = "<c:url value='/mas/rc/productList.do' />";
	}
	
	$("#viewAplDt").datepicker();
	
	$('#viewAplDt').change(function() {
		$('#aplDt').val($('#viewAplDt').val().replace(/-/g, ''));
	});
	
	if("${error}" == "Y"){
		if("${amtInfVO.gubun}" == "U"){
			$("#viewAplDt").datepicker("destroy");
			
			$("#btnResist").hide();
			$("#btnUpdate").show();
		}else if("${amtInfVO.gubun}" == "I"){
			$("#viewAplDt").datepicker();
			
			$("#btnResist").show();
			$("#btnUpdate").hide();
		}
		show_popup($("#lay_popup"));
	}
});

</script>

</head>
<body>
<div class="blackBg"></div>
<div id="wrapper">
	<jsp:include page="/mas/head.do?menu=product" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area">
			<form:form commandName="RC_AMTINFVO" name="amtInf" method="post" onSubmit="return false;">
				<input type="hidden" id="prdtNum" name="prdtNum" value="${amtInfVO.prdtNum}" />
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
				<input type="hidden" name="sPrdtNm" value="${searchVO.sPrdtNm}" />
				<input type="hidden" name="sCarDivCd" value="${searchVO.sCarDivCd}" />
				<input type="hidden" name="sTradeStatus" value="${searchVO.sTradeStatus}" />
				<input type="hidden" name="gubun" id="gubun" value="${amtInfVO.gubun}" />
			<div id="contents">
				<h2 class="title08"><c:out value="${prdtInf.prdtNm}"/></h2>
				<div id="menu_depth3">
					<ul>
	                    <li><a class="menu_depth3" href="<c:url value='/mas/rc/detailPrdt.do?prdtNum=${prdtInf.prdtNum}'/>">차량정보</a></li>
	                	<%-- <li><a class="menu_depth3" href="<c:url value='/mas/rc/imgList.do?prdtNum=${prdtInf.prdtNum}'/>">이미지관리</a></li> --%>
	                	<li class="on"><a class="menu_depth3" href="<c:url value='/mas/rc/amtList.do?prdtNum=${prdtInf.prdtNum}'/>">요금관리</a></li>
	                	<li><a class="menu_depth3" href="<c:url value='/mas/rc/disPerList.do?prdtNum=${prdtInf.prdtNum}'/>">할인율관리</a></li>
	                </ul>
	                <div class="btn_rt01">
	                	<c:if test="${(prdtInf.tradeStatus eq Constant.TRADE_STATUS_REG) or (prdtInf.tradeStatus eq Constant.TRADE_STATUS_EDIT)}">
	                	<div class="btn_sty01"><a href="javascript:fn_ApprovalReqPrdt();">승인요청</a></div>
	                	</c:if>
	                	<c:if test="${prdtInf.tradeStatus==Constant.TRADE_STATUS_APPR_REQ}">
	                	<div class="btn_sty01"><a href="javascript:fn_CancelApproval();">승인요청취소</a></div>
	                	</c:if>
	                </div>
	            </div>
                <div class="btn_rt01" style="margin-bottom:5px;">
                	<div>
                		<span class="btn_sty04"><a href="javascript:fn_AddAmt()">요금추가</a></span>
                	</div>
                </div>
                <div class="list">
				<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
					<colgroup>
                        <col width="10%" />
                        <col />
                        <col width="15%" />
                        <col width="15%" />
                        <col width="15%" />
                        <col width="15%" />
                        <col width="15%" />
                    </colgroup>
					<thead>
						<tr>
							<th>번호</th>
							<th>적용일자</th>
							<th>6시간 금액</th>
							<th>12시간 금액</th>
							<th>24시간 금액</th>
							<th>1시간 추가 금액</th>
							<th>기능툴</th>
						</tr>
					</thead>
					<tbody>
						<!-- 데이터 없음 -->
						<c:if test="${fn:length(resultList) == 0}">
							<tr>
								<td colspan="7" class="align_ct">
									<spring:message code="common.noresistdata.mgs" arguments="요금을"/>
								</td>
							</tr>
						</c:if>
						<c:forEach var="amtInfo" items="${resultList}" varStatus="status">
							<tr>
								<td class="align_ct"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
								<td class="align_ct">
									<fmt:parseDate value='${amtInfo.aplDt}' var='aplDt' pattern="yyyyMMdd" scope="page"/>
									<fmt:formatDate value='${aplDt}' pattern='yyyy-MM-dd' />
								</td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${amtInfo.tm6Amt}" /></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${amtInfo.tm12Amt}" /></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${amtInfo.tm24Amt}" /></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${amtInfo.tm1AddAmt}" /></fmt:formatNumber></td>
								<td class="align_ct">
									<div class="btn_sty06"><span><a href="javascript:fn_OpenUdtPrdtAmt('${amtInfo.aplDt}')">수정</a></span></div>
									<div class="btn_sty09"><span><a href="javascript:fn_DelPrdtAmt('${amtInfo.aplDt}')">삭제</a></span></div>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				</div>
				<ul class="btn_rt01">
					<li class="btn_sty01">
						<a href="javascript:fn_ListPrdt()">목록</a>
					</li>
				</ul>
				<div id="lay_popup" class="lay_popup lay_ct" style="display:none;"> <!--왼쪽정렬:lay_lt, 오른쪽정렬:lay_rt, 가운데정렬:lay_ct--> 
		            <span class="popup_close"><a href="javascript:;" onclick="close_popup($('#lay_popup'))" title="창닫기">
		            	<img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a>
		            </span>
		            <ul class="form_area">
		            	<li>
		            		<table border="1" class="table02" id="amtLay">
				            	<caption class="tb01_title">요금관리<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span></caption>
				            	<colgroup>
			                        <col width="200" />
			                        <col width="*" />
			                    </colgroup>
								<tr>
									<th>적용일자<span class="font02">*</span></th>
									<td>
										<form:input path="viewAplDt" id="viewAplDt" class="input_text4 center" readonly="true" value="${amtInfVO.viewAplDt}" />
										<form:hidden path="aplDt" id="aplDt" value="${amtInfVO.aplDt}" />
										<form:errors path="viewAplDt"  cssClass="error_text" />
									</td>
								</tr>
								<tr>
									<th>6시간 금액<span class="font02">*</span></th>
									<td>
										<form:input path="tm6Amt" id="tm6Amt" class="input_text10 numFormat" value="${amtInfVO.tm6Amt}" maxlength="11" onkeydown="javascript:fn_checkNumber();" />
										<form:errors path="tm6Amt"  cssClass="error_text" />
									</td>
								</tr>
								<tr>
									<th>12시간 금액<span class="font02">*</span></th>
									<td>
										<form:input path="tm12Amt" id="tm12Amt" class="input_text10 numFormat" value="${amtInfVO.tm12Amt}" maxlength="11" onkeydown="javascript:fn_checkNumber();" />
										<form:errors path="tm12Amt"  cssClass="error_text" />
									</td>
								</tr>
								<tr>
									<th>24시간 금액<span class="font02">*</span></th>
									<td>
										<form:input path="tm24Amt" id="tm24Amt" class="input_text10 numFormat" value="${amtInfVO.tm24Amt}" maxlength="11" onkeydown="javascript:fn_checkNumber();" />
										<form:errors path="tm24Amt"  cssClass="error_text" />
									</td>
								</tr>
								<tr>
									<th>1시간 추가금액<span class="font02">*</span></th>
									<td>
										<form:input path="tm1AddAmt" id="tm1AddAmt" class="input_text10 numFormat" value="${amtInfVO.tm1AddAmt}" maxlength="11" onkeydown="javascript:fn_checkNumber();" />
										<form:errors path="tm1AddAmt"  cssClass="error_text" />
									</td>
								</tr>
							</table>
		            	</li>
		            </ul>
		            <div class="btn_rt01">
		            	<span class="btn_sty04" id="btnResist"><a href="javascript:fn_InsPrdtAmt()">등록</a></span>
		            	<span class="btn_sty04" id="btnUpdate"><a href="javascript:fn_UdtPrdtAmt()">수정</a></span>
		            </div>
		        </div>
			</div>
			</form:form>
		</div>
	</div>
</div>
</body>
</html>