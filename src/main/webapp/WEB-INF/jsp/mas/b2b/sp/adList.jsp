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
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

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
		url:"<c:url value='/mas/b2b/sp/adPrdtList.ajax'/>",
		data:parameters ,
		success:function(data){
			$("#searchResult").html(data);
		},
		error : fn_AjaxError
	});
	
}

function fn_SearchClick(pageIndex){
	if($("#vAdultMem").val() == 0){
		alert("성인 인원을 입력해주세요.");
		return;
	}
	$("#sAdultMem").val($("#vAdultMem").val());
	$("#sJuniorMem").val($("#vJuniorMem").val());
	$("#sChildMem").val($("#vChildMem").val());
	$("#sCorpNm").val($("#vCorpNm").val());
	$("#sStartDt").val($("#vStartDt").val());
	$("#sEndDt").val($("#vEndDt").val());
	$("#sAdDiv").val($("input:radio[name=vAdDiv]:checked").val());
	$("#sAdArea").val($("input:radio[name=vAdArea]:checked").val());
	fn_Search(pageIndex);
}

function fn_InstantBuy(prdtNum){
	
	var cart = [{
		prdtNum 	: prdtNum,
		prdtDivNm 	: "숙박",
		startDt		: $("#sStartDt").val(),
		fromDt 		: $("#sStartDt").val(),
		toDt 		: $("#sEndDt").val(),
		adultCnt	: $("#sAdultMem").val(),
		juniorCnt	: $("#sJuniorMem").val(),
		childCnt	: $("#sChildMem").val()
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
	$("#vStartDt").datepicker({
		dateFormat : "yy-mm-dd"
	});
	$("#vEndDt").datepicker({
		dateFormat : "yy-mm-dd"
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
			<input type="hidden" id="sAdultMem" name="sAdultMem" />
			<input type="hidden" id="sJuniorMem" name="sJuniorMem" />
			<input type="hidden" id="sChildMem" name="sChildMem" />
			<input type="hidden" id="sCorpNm" name="sCorpNm" />
			<input type="hidden" id="sStartDt" name="sStartDt" />
			<input type="hidden" id="sEndDt" name="sEndDt" />
			<input type="hidden" id="sAdDiv" name="sAdDiv" />
			<input type="hidden" id="sAdArea" name="sAdArea" />
			<div id="contents">
			<!--검색-->
				<div id="menu_depth3">
					<ul>
						<li class="on"><a class="menu_depth3"
							href="<c:url value='/mas/b2b/sp/adList.do'/>">숙박</a></li>
						<li><a class="menu_depth3"
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
	        							<th scope="row">인&nbsp;원</th>
	        							<td>
	        								<select name="vAdultMem" id="vAdultMem">
	        									<c:forEach begin="1" end="10" step="1" var="adult">
	        										<option value="${adult}">성인${adult}명</option>
	        									</c:forEach>
	        								</select>
	        								<select name="vJuniorMem" id="vJuniorMem">
	        									<c:forEach begin="0" end="10" step="1" var="adult">
	        										<option value="${adult}">소아${adult}명</option>
	        									</c:forEach>
	        								</select>
	        								<select name="vChildMem" id="vChildMem">
	        									<c:forEach begin="0" end="10" step="1" var="adult">
	        										<option value="${adult}">유아${adult}명</option>
	        									</c:forEach>
	        								</select>
	        							</td>
	     							</tr>
	     							<tr>
	     								<th scope="row">예&nbsp;약&nbsp;일</th>
	        							<td>
	        								<input type="text" id="vStartDt" class="input_text4 center" name="vStartDt" value="${SVR_TODAY}"  title="검색시작일" readonly="readonly" /> ~ 
	               							<input type="text" id="vEndDt" class="input_text4 center" name="vEndDt"  title="검색종료일" value="${SVR_TODAY}" readonly="readonly" />
	        							</td>
	     							</tr>
	             					<tr>
	             						<th scope="row">업&nbsp;체&nbsp;명</th>
	        							<td><input type="text" id="vCorpNm" class="input_text13" name="vCorpNm" value="${searchVO.sCorpNm}" title="검색하실 업체명을 입력하세요." /></td>
	             					</tr>
	             					<tr>
	             						<th scope="row">유&nbsp;형</th>
	             						<td>
	             							<input id="vAdDiv0" type="radio" name="vAdDiv" value="" <c:if test="${empty searchVO.sAdDiv}">checked="checked"</c:if> ><label for="vAdDiv0">&nbsp;전체</label>
	             							<c:forEach var="data" items="${cdAddv}" varStatus="status">
                                               	<input id="vAdDiv${status.index+1}" type="radio" name="vAdDiv" value="${data.cdNum}" <c:if test="${searchVO.sAdDiv==data.cdNum}">checked="checked"</c:if>><label for="vAdDiv${status.index+1}">&nbsp;${data.cdNm }</label>
                                            </c:forEach>
	             						</td>
	             					</tr>
	             					<tr>
	             						<th scope="row">지&nbsp;역</th>
	             						<td>
	             							<input id="vAdAdar0" type="radio" name="vAdArea" value="" <c:if test="${empty searchVO.sAdAdar}">checked="checked"</c:if> ><label for="vAdAdar0">&nbsp;전체</label>
	             							<c:forEach var="data" items="${cdAdar}" varStatus="status">
                                                <input id="vAdAdar${status.index+1}" type="radio" name="vAdAdar" value="${data.cdNum }" <c:if test="${searchVO.sAdAdar==data.cdNum}">checked="checked"</c:if>><label for="vAdAdar${status.index+1}">&nbsp;${data.cdNm }</label>
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