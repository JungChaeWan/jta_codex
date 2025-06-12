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
<head>
<title></title>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css' />" />

<script type="text/javascript">

function fn_Search(){
	document.frm.action = "<c:url value='/oss/bisDayCorpAnls.do'/>";
	document.frm.submit();
}

function fn_Prdt(prdtDiv, obj){
	$("#menu_depth3>ul>li").removeClass("on");
	$(obj).parent().addClass("on");
	
	var parameters = "sGubun=" + prdtDiv;
	parameters += "&sStartDt=" + $("#sStartDt").val();
	
	$.ajax({
		type:"post", 
		url:"<c:url value='/oss/bisDayPrdtAnls.ajax'/>",
		data:parameters ,
		beforeSend:function(){
			$("#prdtDiv").html("");
		},
		success:function(data){
			$("#prdtDiv").html(data);
		},
		error:fn_AjaxError
	});
}


$(document).ready(function() {
	$("#sStartDt").datepicker({
		dateFormat : "yy-mm-dd",
		maxDate : '-1d'
	});
	
	<c:if test="${fn:length(dayCorpList) > 1}">
	$(".menu_depth3").eq(0).trigger("click");
	</c:if>
});

</script>
</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/oss/head.do?menu=bis" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
        <div id="side_area"> 
            <!--사이드메뉴-->
            <div class="side_menu">
                <jsp:include page="/oss/left.do?menu=bis&sub=dayCorp" flush="false"></jsp:include>
            </div>
            <!--//사이드메뉴-->
        </div>
        <div id="contents_area">
            <div id="contents">
            	<h4 class="title08">입점업체현황</h4>
            <!-- change contents -->				
				<form name="frm" method="post" onSubmit="return false;">
	            <div class="tb_form">
	                <table width="100%" border="0">
	                    <colgroup>
	                        <col style="widht: 100px" />
	                        <col />
	                    </colgroup>
	                    <tbody>
	                        <tr>
	                            <td class="date-wrap">
	                                <input type="text" id="sStartDt" class="input_text4 center" name="sStartDt" value="${searchVO.sStartDt }" title="검색일" onchange="fn_Search();" />
	                            </td>
	                        </tr>
	                    </tbody>
	                </table>
	            </div>
			    </form>
			    <table class="table01 center">
			        <colgroup>
			            <col />
			            <col width="11%" />
			            <col width="11%" />
			            <col width="11%" />
			            <col width="11%" />
			            <col width="11%" />
			            <col width="11%" />
			            <col width="11%" />
			            <col width="11%" />
			        </colgroup>
			        <thead>
			            <tr>
			                <th>구분</th>
			                <th>업체수</th>
			                <th>승인업체수</th>
			                <th>회원사/비회원사 수</th>
			                <th>회원사 비율</th>
			                <th>상품 수</th>
			                <th>승인</th>
			                <th>판매중지</th>
			                <th>수정요청</th>
			            </tr>
			        </thead>
			        <tbody>
			        	<c:forEach items="${dayCorpList}" var="dayCorp" varStatus="status">
			        		<tr>
			        			<td><c:out value="${dayCorp.corpDivNm}"/></td>
			        			<td><fmt:formatNumber><c:out value="${dayCorp.totalCorpCnt}"/></fmt:formatNumber></td>
			        			<td><fmt:formatNumber><c:out value="${dayCorp.confCorpCnt}"/></fmt:formatNumber></td>
			        			<td>
			        				<fmt:formatNumber><c:out value="${dayCorp.memCorpCnt}"/></fmt:formatNumber> / <fmt:formatNumber><c:out value="${dayCorp.totalCorpCnt - dayCorp.memCorpCnt}"/></fmt:formatNumber> 
			        			</td>
			        			<td>
			        				<c:if test="${dayCorp.totalCorpCnt != 0}">
			        					<fmt:formatNumber value="${dayCorp.memCorpCnt / dayCorp.totalCorpCnt}" type="percent" />
			        				</c:if>
			        			</td>
			        			<td>
			        				<fmt:formatNumber><c:out value="${dayCorp.totalPrdtCnt}"/></fmt:formatNumber>
			        			</td>
			        			<td>
			        				<fmt:formatNumber><c:out value="${dayCorp.prdtCnt03}"/></fmt:formatNumber>
			        			</td>
			        			<td>
			        				<fmt:formatNumber><c:out value="${dayCorp.prdtCnt05}"/></fmt:formatNumber>
			        			</td>
			        			<td>
			        				<fmt:formatNumber><c:out value="${dayCorp.prdtCnt06}"/></fmt:formatNumber>
			        			</td>
			        		</tr>
			        	</c:forEach>
			        </tbody>
			    </table>
                <!-- //change contents -->
                
                <c:if test="${fn:length(dayCorpList) > 1}">
	                <div id="menu_depth3" style="margin-top: 30px; margin-bottom: 0">
						<ul>
							<c:forEach items="${dayCorpList}" var="dayCorp" varStatus="status">
								<c:if test="${status.index > 0}">
									<li <c:if test="${status.index == 1}">class="on"</c:if>><a class="menu_depth3" href="javascript:void(0);" onclick="javascript:fn_Prdt('${dayCorp.corpDiv}', this);">${dayCorp.corpDivNm}</a></li>
								</c:if>
							</c:forEach>
						</ul>
					</div>
					<div id="prdtDiv"></div>
				</c:if>
				
            </div>
        </div>
    </div>
</div>
</body>
</html>        