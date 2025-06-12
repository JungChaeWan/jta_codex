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

<validator:javascript formName="RC_DISPERINFVO" staticJavascript="false" xhtml="true" cdata="true"/>

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
	document.defDisPer.action = "<c:url value='/mas/rc/productList.do'/>";
	document.defDisPer.submit();
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

function fn_OpenAddDefDisPer(){
	$("#gubun").val("I");
	show_popup($("#lay_popup"));
}

function fn_InsDisPer(){
	if(isNull($("#wdayDisPer").val())){
		alert("평일할인율을 입력하세요.");
		$("#wdayDisPer").focus();
		return;
	}
	if(isNull($("#wkdDisPer").val())){
		alert("주말할인율을 입력하세요.");
		$("#wkdDisPer").focus();
		return;
	}
	/* if(!checkPercentNum90($("#wdayDisPer").val())){
		alert("할인율은 최대 90% 까지 입력 가능합니다.");
		$("#wdayDisPer").focus();
		return;
	}
	if(!checkPercentNum90($("#wkdDisPer").val())){
		alert("할인율은 최대 90% 까지 입력 가능합니다.");
		$("#wkdDisPer").focus();
		return;
	} */
	if($("#gubun").val() == "U"){
		document.defDisPer.action = "<c:url value='/mas/rc/updateDefDisPer.do'/>";
		document.defDisPer.submit();
	}else if($("#gubun").val() == "I"){
		document.defDisPer.action = "<c:url value='/mas/rc/insertDefDisPer.do'/>";
		document.defDisPer.submit();
	}
}


function fn_OpenUdtDefDisPer(){
	$("#gubun").val("U");
	show_popup($("#lay_popup"));
}

/**
 * 기간할인율 등록 layer 창 열기
 */
function fn_InsRangeDisPerLay(){
	// 에러 문구값 초기화
	$(".error_text").text("");
	
	// init
	$("#RC_DISPERINFVO input:text:not([id=rangePrdtNum])").val("");
	$("#gubun2").val("I");
	show_popup($("#lay_popup2"));
}

/**
 * 기간할인율 수정 layer 창 열기
 */
function fn_UdtRangeDisPerLay(disPerNum){
	var parameters = "prdtNum=" + $("#prdtNum").val();
	parameters += "&disPerNum=" + disPerNum;
	
	$.ajax({
		type:"post", 
		dataType:"json",
		async:false,
		url:"<c:url value='/mas/rc/selectByDisPerInf.ajax'/>",
		data:parameters ,
		success:function(data){
			// 수정 값 초기화
			$("#viewAplStartDt").val(fn_addDate(data.disPerInfVO.aplStartDt));
			$("#aplStartDt").val(data.disPerInfVO.aplStartDt);
			$("#viewAplEndDt").val(fn_addDate(data.disPerInfVO.aplEndDt));
			$("#aplEndDt").val(data.disPerInfVO.aplEndDt);
			$("#rangeWdayDisPer").val(data.disPerInfVO.wdayDisPer);
			$("#rangeWkdDisPer").val(data.disPerInfVO.wkdDisPer);
			$("#rangeDisPerNum").val(data.disPerInfVO.disPerNum);
			
			$("#gubun2").val("U");
			
			// 에러 문구값 초기화
			$(".error_text").text("");
			
			show_popup($("#lay_popup2"));
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

function fn_InsRangeDisPer(){
	// validation 체크
	if(!validateRC_DISPERINFVO(document.rangeDisPer)){
		return;
	}
	
	/* if(!checkPercentNum90($("#rangeWdayDisPer").val())){
		alert("할인율은 최대 90% 까지 입력 가능합니다.");
		$("#rangeWdayDisPer").focus();
		return;
	}
	if(!checkPercentNum90($("#rangeWkdDisPer").val())){
		alert("할인율은 최대 90% 까지 입력 가능합니다.");
		$("#rangeWkdDisPer").focus();
		return;
	} */
	if($("#gubun2").val() == "U"){
		document.rangeDisPer.action = "<c:url value='/mas/rc/updateRangeDisPer.do'/>";
		document.rangeDisPer.submit();
	}else if($("#gubun2").val() == "I"){
		document.rangeDisPer.action = "<c:url value='/mas/rc/insertRangeDisPer.do'/>";
		document.rangeDisPer.submit();
	}
}

function fn_DelRangeDisPer(disPerNum){
	if(confirm("<spring:message code='common.delete.msg'/>")){
		$("#rangeDisPerNum").val(disPerNum);
		document.rangeDisPer.action = "<c:url value='/mas/rc/deleteRangeDisPer.do'/>";
		document.rangeDisPer.submit();
	}
}

$(document).ready(function(){
	if('${errorCode}' == '1'){
		alert("상품 정보를 확인해 주세요.");
		location.href = "<c:url value='/mas/rc/productList.do' />";
	}
	
	$("#viewAplStartDt").datepicker({
		dateFormat: "yy-mm-dd",
		onClose : function(selectedDate) {
			$("#viewAplEndDt").datepicker("option", "minDate", selectedDate);
		}
	});
	
	$("#viewAplEndDt").datepicker({
		dateFormat: "yy-mm-dd",
		onClose : function(selectedDate) {
			$("#viewAplStartDt").datepicker("option", "maxDate", selectedDate);
		}
	});
	
	$('#viewAplStartDt').change(function() {
		$('#aplStartDt').val($('#viewAplStartDt').val().replace(/-/g, ''));
	});
	$('#viewAplEndDt').change(function() {
		$('#aplEndDt').val($('#viewAplEndDt').val().replace(/-/g, ''));
	});
	
	if("${error}" == "Y"){
		show_popup($("#lay_popup2"));
	}
	
	$("#viewAplStartDt").attr("readonly","readonly");
	$("#viewAplEndDt").attr("readonly","readonly");
	
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
			<div id="contents">
				<h2 class="title08"><c:out value="${prdtInf.prdtNm}"/></h2>
				<form name="disPerInf" method="post" onSubmit="return false;">
				<input type="hidden" id="prdtNum" name="prdtNum" value="${disPerInfVO.prdtNum}" />
				<input type="hidden" name="sPrdtNm" value="${searchVO.sPrdtNm}" />
				<input type="hidden" name="sCarDivCd" value="${searchVO.sCarDivCd}" />
				<input type="hidden" name="sTradeStatus" value="${searchVO.sTradeStatus}" />
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
				<%-- <input type="hidden" name="gubun" id="gubun" value="${amtInfVO.gubun}" /> --%>
				<div id="menu_depth3">
					<ul>
	                    <li><a class="menu_depth3" href="<c:url value='/mas/rc/detailPrdt.do?prdtNum=${prdtInf.prdtNum}'/>">차량정보</a></li>
	                	<%-- <li><a class="menu_depth3" href="<c:url value='/mas/rc/imgList.do?prdtNum=${prdtInf.prdtNum}'/>">이미지관리</a></li> --%>
	                	<li><a class="menu_depth3" href="<c:url value='/mas/rc/amtList.do?prdtNum=${prdtInf.prdtNum}'/>">요금관리</a></li>
	                	<li class="on"><a class="menu_depth3" href="<c:url value='/mas/rc/disPerList.do?prdtNum=${prdtInf.prdtNum}'/>">할인율관리</a></li>
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
                
               	<h4 class="title02">기본할인율</h4>
               	<table style="width:500px;" border="1" cellspacing="0" cellpadding="0" class="table01 margin-btm25">
               		<colgroup>
               			<col width="200" />
               			<col width="200" />
               			<col width="100" />
               		</colgroup>
               		<thead>
               			<tr>
               				<th>평일할인율</th>
               				<th>주말할인율</th>
               				<th>기능툴</th>
               			</tr>
               		</thead>
               		<tbody>
               			<tr>
               				<c:if test="${empty defDisPerVO}">
               					<td colspan="2" class="align_ct">
               						<spring:message code="common.upperNotExist" arguments="기본할인율" />
               					</td>
               					<td class="align_ct"><div class="btn_sty06"><span><a href="javascript:fn_OpenAddDefDisPer()">등록</a></span></div></td>
               				</c:if>
               				<c:if test="${not empty defDisPerVO}">
               					<td class="align_ct">
               						<fmt:formatNumber><c:out value="${defDisPerVO.wdayDisPer}" /></fmt:formatNumber>%
               					</td>
               					<td class="align_ct">
               						<fmt:formatNumber><c:out value="${defDisPerVO.wkdDisPer}" /></fmt:formatNumber>%
               					</td>
               					<td class="align_ct">
               						<div class="btn_sty06"><span><a href="javascript:fn_OpenUdtDefDisPer()">수정</a></span></div>
               					</td>
               				</c:if>
               			</tr>
               		</tbody>
               	</table>
                <h4 class="title02">기간할인율</h4>
                <h7> ※할인율 적용우선순위 <br>
					1. 대여기간에 기간할인율이 100% 설정되어 있는 상품은 노출되지 않음. <br>
					2. 대여기간에 기간할인율이 두가지 이상일 경우 낮은 할인율로 적용. <br>
					3. 대여기간에 기간할인율과 기본할인율이 겹칠경우 기간할인율로 적용.<br>
					4. 대여기간이 기간할인율 외 기간일 경우 기본할인율로 적용. <br>
				</h7>
                <div class="list">	
                	<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01">
                		<colgroup>
                			<col width="20%" />
                			<col width="20%" />
                			<col width="20%" />
                			<col width="20%" />
                			<col width="20%" />
                		</colgroup>
                		<thead>
                			<tr>
                				<th>적용시작일</th>
                				<th>적용종료일</th>
                				<th>평일할인율</th>
                				<th>주말할인율</th>
                				<th>기능툴</th>
                			</tr>
                		</thead>
                		<tbody>
                			<c:if test="${empty defDisPerVO}">
                				<tr>
                					<td colspan="5" class="align_ct">
	               						<spring:message code="common.upperNotExist" arguments="기본할인율" />
	               					</td>
	                			</tr>
                			</c:if>
                			<c:if test="${not empty defDisPerVO and fn:length(disPerInfList)==0}">
                				<tr>
                					<td colspan="5" class="align_ct">
	               						<spring:message code="common.nodata.msg3" arguments="기간할인율" />
	               					</td>
	                			</tr>
                			</c:if>
                			<c:forEach items="${disPerInfList}" var="rangeDisPerInf" varStatus="status">
                				<tr>
                					<td class="align_ct">
                						<fmt:parseDate value='${rangeDisPerInf.aplStartDt}' var='aplStartDt' pattern="yyyyMMdd" scope="page"/>
										<fmt:formatDate value='${aplStartDt}' pattern='yyyy-MM-dd' />
                					</td>
                					<td class="align_ct">
                						<fmt:parseDate value='${rangeDisPerInf.aplEndDt}' var='aplEndDt' pattern="yyyyMMdd" scope="page"/>
										<fmt:formatDate value='${aplEndDt}' pattern='yyyy-MM-dd' />
                					</td>
                					<td class="align_ct"><c:out value="${rangeDisPerInf.wdayDisPer}" />%</td>
                					<td class="align_ct"><c:out value="${rangeDisPerInf.wkdDisPer}" />%</td>
                					<td class="align_ct">
                						<div class="btn_sty06"><span><a href="javascript:fn_UdtRangeDisPerLay('${rangeDisPerInf.disPerNum}')">수정</a></span></div>
										<div class="btn_sty09"><span><a href="javascript:fn_DelRangeDisPer('${rangeDisPerInf.disPerNum}')">삭제</a></span></div>
                					</td>
                				</tr>
                			</c:forEach>
                		</tbody>
                	</table>
                	</div>
                	</form>
                	<div id="lay_popup" class="lay_popup lay_ct" style="display:none;"> <!--왼쪽정렬:lay_lt, 오른쪽정렬:lay_rt, 가운데정렬:lay_ct--> 
			            <span class="popup_close"><a href="javascript:;" onclick="close_popup($('#lay_popup'))" title="창닫기">
			            	<img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a>
			            </span>
			            <form name="defDisPer">
			            	<input type="hidden" id="prdtNum" name="prdtNum" value="${disPerInfVO.prdtNum}" />
			            	<input type="hidden" id="gubun" name="gubun" />
			            <ul class="form_area">
			            	<li>
			            		<table border="1" class="table02" >
					            	<caption class="tb01_title">기본할인율관리<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span></caption>
					            	<colgroup>
				                        <col width="170" />
				                        <col width="*" />
				                    </colgroup>
									<tr>
										<th>평일할인율<span class="font02">*</span></th>
										<td>
											<input type="text" name="wdayDisPer" id="wdayDisPer" class="input_text2 center" maxlength="3" value="${defDisPerVO.wdayDisPer}" onkeydown="javascript:fn_checkNumber();" /> %
										</td>
									</tr>
									<tr>
										<th>주말할인율<span class="font02">*</span></th>
										<td>
											<input type="text" name="wkdDisPer" id="wkdDisPer" class="input_text2 center" maxlength="3" value="${defDisPerVO.wkdDisPer}" onkeydown="javascript:fn_checkNumber();" /> %
										</td>
									</tr>
								</table>
			            	</li>
			            </ul>
			            </form>
			            <div class="btn_rt01">
			            	<span class="btn_sty04"><a href="javascript:fn_InsDisPer()">저장</a></span>
			            </div>
			        </div>
                	<div id="lay_popup2" class="lay_popup lay_ct" style="display:none;"> <!--왼쪽정렬:lay_lt, 오른쪽정렬:lay_rt, 가운데정렬:lay_ct--> 
			            <span class="popup_close"><a href="javascript:;" onclick="close_popup($('#lay_popup2'))" title="창닫기">
			            	<img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a>
			            </span>
			            <form:form commandName="RC_DISPERINFVO" name="rangeDisPer">
			            	<input type="hidden" id="rangePrdtNum" name="prdtNum" value="${disPerInfVO.prdtNum}" />
			            	<input type="hidden" id="rangeDisPerNum" name="disPerNum" />
			            	<input type="hidden" id="gubun2" name="gubun2" value="${disPerInfVO.gubun2}" />
			            <ul class="form_area">
			            	<li>
			            		<table border="1" class="table02" >
					            	<caption class="tb01_title">기간할인율관리<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span></caption>
					            	<colgroup>
				                        <col width="170" />
				                        <col width="*" />
				                    </colgroup>
					            	<tr>
										<th>적용시작일<span class="font02">*</span></th>
										<td>
											<form:input path="viewAplStartDt" id="viewAplStartDt" class="input_text4 center" readonly="readonly" value="${disPerInfVO.viewAplStartDt}" />
											<input type="hidden" name="aplStartDt" id="aplStartDt" value="${disPerInfVO.aplStartDt}" />
											<form:errors path="viewAplStartDt"  cssClass="error_text" />
										</td>
									</tr>
					            	<tr>
										<th>적용종료일<span class="font02">*</span></th>
										<td>
											<form:input path="viewAplEndDt" id="viewAplEndDt" class="input_text4 center" readonly="readonly" value="${disPerInfVO.viewAplEndDt}" />
											<input type="hidden" name="aplEndDt" id="aplEndDt" value="${disPerInfVO.aplEndDt}" />
											<form:errors path="viewAplEndDt"  cssClass="error_text" />
										</td>
									</tr>
									<tr>
										<th>평일할인율<span class="font02">*</span></th>
										<td>
											<form:input path="wdayDisPer" id="rangeWdayDisPer" class="input_text2 center" maxlength="3" value="${disPerInfVO.wdayDisPer}" onkeydown="javascript:fn_checkNumber();" /> %
											<form:errors path="wdayDisPer"  cssClass="error_text" />
										</td>
									</tr>
									<tr>
										<th>주말할인율<span class="font02">*</span></th>
										<td>
											<form:input path="wkdDisPer" id="rangeWkdDisPer" class="input_text2 center" maxlength="3" value="${disPerInfVO.wkdDisPer}" onkeydown="javascript:fn_checkNumber();" /> %
											<form:errors path="wkdDisPer"  cssClass="error_text" />
										</td>
									</tr>
								</table>
			            	</li>
			            </ul>
			            </form:form>
			            <div class="btn_rt01">
			            	<span class="btn_sty04"><a href="javascript:fn_InsRangeDisPer()">저장</a></span>
			            </div>
			        </div>
			        <ul class="btn_rt01">
			        	<c:if test="${not empty defDisPerVO}">
						<li class="btn_sty04">
							<a href="javascript:fn_InsRangeDisPerLay()">기간할인율등록</a>
						</li>
						</c:if>
						<li class="btn_sty01">
							<a href="javascript:fn_ListPrdt()">목록</a>
						</li>
					</ul>
			</div>
		</div>
	</div>
</div>
</body>
</html>