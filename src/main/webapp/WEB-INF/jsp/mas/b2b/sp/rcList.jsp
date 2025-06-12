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
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
           
 <un:useConstants var="Constant" className="common.Constant" />
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/multiple-select.js'/>"></script>
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/multiple-select.css'/>" />

<title></title>
<script type="text/javascript">

/**
 * 조회 & 페이징
 */
function fn_Search(pageIndex){
	$("#pageIndex").val(pageIndex);
	var parameters = $("#frm").serialize();
	
	$.ajax({
		type:"post", 
		// dataType:"json",
		// async:false,
		url:"<c:url value='/mas/b2b/sp/rcPrdtList.ajax'/>",
		data:parameters ,
		success:function(data){
			$("#searchResult").html("");
			
			if(data.resultList.length > 0){
				fn_ResultInfo("Y", data.difTm);
			}else{
				fn_ResultInfo("N", data.difTm);
			}
			
			$.each(data.resultList, function(index, onerow){
				// alert($("#searchResult").find("tb_" + onerow.carCd).index());
				
				if($("#tb_" + onerow.carCd).length == 0){
					fn_AddTable(onerow.carCd, onerow.carCdNm);
				}
				fn_AddRow(onerow);
			});
			
		},
		error : fn_AjaxError
	});
	
}

function fn_SearchClick(pageIndex){
	$("#sCorpNm").val($("#vCorpNm").val());
	$('#sFromDt').val($('#vFromDt').val().replace(/-/g, ''));
	$('#sToDt').val($('#vToDt').val().replace(/-/g, ''));
	$("#sFromTm").val($("#vFromTm").val());
	$("#sToTm").val($("#vToTm").val());
	fn_Search(pageIndex);
}

function fn_ResultInfo(resultYn, difTm){
	var addHtml = "";
	
	addHtml += "<div class=\"val-title\">";
	addHtml += "<span>" + $("#vFromDt").val() + " " + $("#vFromTm").val() + "</span> ~ <span>" + $("#vToDt").val() + " " + $("#vToTm").val() + "</span>";
	addHtml += "(<strong><span>" + difTm + "</span>시간</strong>)의 검색 결과";
	if(resultYn == "N"){
		addHtml += "<br /><span>예약 가능한 차량이 없습니다.</span>";
	}
	addHtml += "</div>";
	
	$("#searchResult").append(addHtml);
}

function fn_AddTable(carCd, carCdNm){
	var addHtml = "";
	
	addHtml += "<div class=\"margin-top5 margin-btm15\">";
	addHtml += "	<h4 class=\"title08\">" + carCdNm + "</h4>";
	addHtml += "	<table width=\"100%\" border=\"1\" cellspacing=\"0\" cellpadding=\"0\" class=\"table01 list_tb\" id=\"tb_" + carCd + "\">";
	addHtml += "		<colgroup>";
	addHtml += "			<col width=\"10%\" />";
	addHtml += "			<col />";
	addHtml += "			<col width=\"7%\" />";
	addHtml += "			<col width=\"7%\" />";
	addHtml += "			<col width=\"7%\" />";
	addHtml += "			<col width=\"7%\" />";
	addHtml += "			<col width=\"7%\" />";
	addHtml += "			<col width=\"7%\" />";
	addHtml += "			<col width=\"7%\" />";
	addHtml += "			<col width=\"7%\" />";
	addHtml += "			<col width=\"10%\" />";
	addHtml += "		</colgroup>";
	addHtml += "		<thead>";
	addHtml += "			<tr>";
	addHtml += "				<th>업체명</th>";
	addHtml += "				<th>상품명</th>";
	addHtml += "				<th>연료</th>";
	addHtml += "				<th>가격</th>";
	addHtml += "				<th>금연</th>";
	addHtml += "				<th>네비</th>";
	addHtml += "				<th>후방카메라</th>";
	addHtml += "				<th>후방센서</th>";
	addHtml += "				<th>자차필수</th>";
	addHtml += "				<th>블랙박스</th>";
	addHtml += "				<th>예약</th>";
	addHtml += "			</tr>";
	addHtml += "		</thead>";
	addHtml += "		<tbody id=\"tbd_" + carCd + "\">";
	addHtml += "		</tbody>";
	addHtml += "	</table>";
	addHtml += "</div>";
	
	$("#searchResult").append(addHtml);
}

function fn_AddRow(obj){
	var addHtml = "";
	
	addHtml += "<tr>";
	addHtml += "	<td class=\"align_ct\">" + obj.corpNm + "</td>";
	addHtml += "	<td class=\"align_ct\">" + obj.prdtNm + "</td>";
	addHtml += "	<td class=\"align_ct\">" + obj.useFuelDivNm + "</td>";
	addHtml += "	<td class=\"align_ct\">" + commaNum(obj.saleAmt) + "</td>";
	addHtml += "	<td class=\"align_ct\">" + obj.icon01Yn + "</td>";
	addHtml += "	<td class=\"align_ct\">" + obj.icon02Yn + "</td>";
	addHtml += "	<td class=\"align_ct\">" + obj.icon03Yn + "</td>";
	addHtml += "	<td class=\"align_ct\">" + obj.icon04Yn + "</td>";
	addHtml += "	<td class=\"align_ct\">" + obj.icon05Yn + "</td>";
	addHtml += "	<td class=\"align_ct\">" + obj.icon06Yn + "</td>";
	addHtml += "	<td class=\"align_ct\"><a onclick=\"fn_InstantBuy('" + obj.prdtNum + "')\" class=\"btn sm blue\">예약</a></td>";;
	addHtml += "</tr>";
	
	$("#tbd_" + obj.carCd).append(addHtml);
}

function fn_InstantBuy(prdtNum){
	
	var cart = [{
		prdtNum 	: prdtNum,
		prdtDivNm 	: "렌터카",
		fromDt 		: $("#sFromDt").val(),
		toDt 		: $("#sToDt").val(),
		fromTm 		: $("#sFromTm").val(),	// 대여시간
		toTm 		: $("#sToTm").val()	// 반납시간
	}];

	
	$.ajax({
		type:"post", 
		dataType:"json",
		// processData:false,
		// contentType:false,
		// async:false,
		// traditional: true,
		contentType : "application/json;",
		url:"<c:url value='/mas/b2b/instantBuy.ajax'/>",
		data:JSON.stringify({cartList :cart}) ,
		success:function(data){
			if(data.result == "N"){
				alert("예약마감 또는 구매불가 상품입니다.");
				return;
			}else{
				location.href = "<c:url value='/mas/b2b/order01.do'/>";
			}
		},
		error:fn_AjaxError 
	});
}


$(document).ready(function() {
	$("#vFromDt").datepicker({
		dateFormat : "yy-mm-dd"
	});
	$("#vToDt").datepicker({
		dateFormat : "yy-mm-dd"
	});
	
	$("#sCarCd").multipleSelect({
		filter 		: true,
		multiple 	: true,
		multipleWidth : 85,
		maxHeight	: 110,
		selectAllText : "전체차량",
		allSelected : "전체차량",
		minimumCountSelected : 7
	});
});

</script>

</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/mas/head.do?menu=b2b" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area">
			<form name="frm" id="frm" method="post" onSubmit="return false;">
			<input type="hidden" id="corpId" name="corpId" />
			<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
			<input type="hidden" id="sCorpNm" name="sCorpNm" />
			<input type="hidden" id="sFromDt" name="sFromDt" />
			<input type="hidden" id="sToDt" name="sToDt" />
			<input type="hidden" name="sCarDivCd" id="sCarDivCd" value="${searchVO.sCarDivCd}" />
			<div id="contents">
			<!--검색-->
				<div id="menu_depth3">
					<ul>
						<li><a class="menu_depth3"
							href="<c:url value='/mas/b2b/sp/adList.do'/>">숙박</a></li>
						<li class="on"><a class="menu_depth3"
							href="<c:url value='/mas/b2b/sp/rcList.do'/>">렌터카</a></li>
					</ul>
				</div>
	            <div class="search_box">
	            	<div class="search_form">
	                	<div class="tb_form">
							<table width="100%" border="0">
								<colgroup>
									<col width="100" />
	                                <col width="*" />
								</colgroup>
	             				<tbody>
	     							<tr>
	     								<th scope="row">예&nbsp;약&nbsp;일</th>
	        							<td>
	        								<input type="text" id="vFromDt" class="input_text4 center" name="vFromDt" value="${searchVO.sFromDtView}"  title="검색시작일" readonly="readonly" />
	        								<input type="hidden" name="sFromTm" id="sFromTm" value="${searchVO.sFromTm}">
                                            <select name="vFromTm" id="vFromTm">
                                             <c:forEach begin="8" end="20" step="1" var="fromTime">
                                                	<c:if test='${fromTime < 10}'>
                                                		<c:set var="fromTime_v" value="0${fromTime}00" />
                                                		<c:set var="fromTime_t" value="0${fromTime}:00" />
                                                	</c:if>
                                                	<c:if test='${fromTime > 9}'>
                                                		<c:set var="fromTime_v" value="${fromTime}00" />
                                                		<c:set var="fromTime_t" value="${fromTime}:00" />
                                                	</c:if>
                                                 <option value="${fromTime_v}" <c:if test="${searchVO.sFromTm == fromTime_v}">selected="selected"</c:if>>${fromTime_t}</option>
                                             </c:forEach>
                                            </select>
	        								 ~ 
	               							<input type="text" id="vToDt" class="input_text4 center" name="vToDt"  title="검색종료일" value="${searchVO.sToDtView}" readonly="readonly" />
	               							<input type="hidden" name="sToTm" id="sToTm" value="${searchVO.sToTm}">
                                            <select name="vToTm" id="vToTm">
                                                <c:forEach begin="8" end="20" step="1" var="toTime">
                                                	<c:if test='${toTime < 10}'>
                                                		<c:set var="toTime_v" value="0${toTime}00" />
                                                		<c:set var="toTime_t" value="0${toTime}:00" />
                                                	</c:if>
                                                	<c:if test='${toTime > 9}'>
                                                		<c:set var="toTime_v" value="${toTime}00" />
                                                		<c:set var="toTime_t" value="${toTime}:00" />
                                                	</c:if>
                                                 <option value="${toTime_v}" <c:if test="${searchVO.sToTm == toTime_v}">selected="selected"</c:if>>${toTime_t}</option>
                                             </c:forEach>
                                            </select>
	        							</td>
	     							</tr>
	             					<tr>
	             						<th scope="row">업&nbsp;체&nbsp;명</th>
	        							<td><input type="text" id="vCorpNm" class="input_text13" name="vCorpNm" value="${searchVO.sCorpNm}" title="검색하실 업체명을 입력하세요." /></td>
	             					</tr>
	             					<tr>
	             						<th scope="row">차량선택</th>
	        							<td>
	        								<select name="sCarCd" id="sCarCd" multiple="multiple">
												<c:forEach items="${carCdList}" var="carCd" varStatus="status">
													<option value="${carCd.cdNum}" <c:if test="${fn:indexOf(searchVO.sCarCd, carCd.cdNum) != -1}">selected="selected"</c:if>>${carCd.cdNm}</option>
												</c:forEach>
											</select>
	        							</td>
	             					</tr>
	             					<tr>
	             						<th scope="row">차량유형</th>
	             						<td>
	             							<input id="vCarDivCd" type="radio" name="vCarDivCd" value="" <c:if test="${empty searchVO.sCarDivCd}">checked="checked"</c:if>><label for="vCarDivCd">전체</label>
											<c:forEach var="code" items="${carDivCd}" varStatus="status">
												<input id="vCarDivCd${status.index}" type="radio" name="vCarDivCd" value="${code.cdNum}" <c:if test="${searchVO.sCarDivCd==code.cdNum}">checked="checked"</c:if>><label for="vCarDivCd${status.index}">&nbsp;${code.cdNm}</label>
											</c:forEach>
	             						</td>
	             					</tr>
	             					<tr>
	             						<th scope="row">주요정보</th>
	             						<td>
	             							<c:forEach var="icon" items="${iconCd}" varStatus="status">
												<input id="iconCd${status.index}" type="checkbox" name="sIconCd" value="${icon.cdNum}"><label for="iconCd${status.index}">&nbsp;${icon.cdNm}</label>
											</c:forEach>
	             						</td>
	             					</tr>
	     						</tbody>
	               			</table>
	               		</div>
	               		<div class="search-wrap">
				            <span class="btn">
								<input type="image" src="<c:url value='/images/oss/btn/search_btn01.gif'/>" alt="검색" onclick="javascript:fn_SearchClick('1')" />
							</span>
				            
			            </div>
						
	              	</div>
	            </div>
	            <div id="searchResult">
	            </div>
			</div>
			</form>
		</div>
	</div>
</div>

</body>
</html>