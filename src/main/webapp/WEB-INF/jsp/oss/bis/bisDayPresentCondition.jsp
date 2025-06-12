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
	document.frm.action = "<c:url value='/oss/bisDayPresentCondition.do'/>";
	document.frm.submit();
}


$(document).ready(function() {
	$("#sStartDt").datepicker({
		dateFormat : "yy-mm-dd"
	});
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
                <jsp:include page="/oss/left.do?menu=bis&sub=day" flush="false"></jsp:include>
            </div>
            <!--//사이드메뉴-->
        </div>
        <div id="contents_area">
            <div id="contents">
            
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
			            <col width="8%" />
			            <col width="8%" />
			            <col width="8%" />
						<col width="12%" />
						<col width="12%" />
			            <col width="12%" />
			            <col width="12%" />
			            <col width="12%" />
						<col />
			        </colgroup>
			        <thead>
			            <tr>
			                <th>구분</th>
			                <th>예약건수</th>
			                <th>결제건수</th>
							<th>쿠폰결제건수</th>
							<th>판매금액</th>
			                <th>결제금액</th>
			                <th>할인쿠폰 사용</th>
			                <th>포인트금액</th>
			                <th>취소요청</th>
			                <th>환불요청</th>
			            </tr>
			        </thead>
			        <tbody>
			        	<c:set var="totalRsvCnt" value="0" />
			        	<c:set var="totalAccountCnt" value="0" />
						<c:set var="totalDisAccountCnt" value="0" />
			        	<c:set var="totalSaleAmt" value="0" />
			        	<c:set var="totalDisAmt" value="0" />
			        	<c:set var="totalPointAmt" value="0" />
			        	<c:set var="totalCancelReqAmt" value="0" />
			        	<c:set var="totalRefundReqAmt" value="0" />
			        	<c:forEach var="info" items="${dayConditionList }">
			            <tr>
			                <th>${info.prdtGubun }</th>			                
			                <td><fmt:formatNumber value="${info.rsvCnt }" /></td>
			                <td><fmt:formatNumber value="${info.accountCnt }" /></td>
							<td><fmt:formatNumber value="${info.disAccountCnt }" /></td>
							<td><fmt:formatNumber value="${info.saleAmt + info.disAmt}" /></td>
			                <td><fmt:formatNumber value="${info.saleAmt }" /></td>
			                <td><fmt:formatNumber value="${info.disAmt }" /></td>
			                <td><fmt:formatNumber value="${info.pointAmt }" /></td>
			                <td><fmt:formatNumber value="${info.cancelReqAmt }" /></td>
			                <td><fmt:formatNumber value="${info.refundReqAmt }" /></td>
			            </tr>
			            	<c:set var="totalRsvCnt" value="${totalRsvCnt + info.rsvCnt }" />
				        	<c:set var="totalAccountCnt" value="${totalAccountCnt + info.accountCnt }" />
							<c:set var="totalDisAccountCnt" value="${totalDisAccountCnt + info.disAccountCnt }" />
				        	<c:set var="totalSaleAmt" value="${totalSaleAmt + info.saleAmt }" />
				        	<c:set var="totalDisAmt" value="${totalDisAmt + info.disAmt }" />
				        	<c:set var="totalPointAmt" value="${totalPointAmt + info.pointAmt }" />
				        	<c:set var="totalCancelReqAmt" value="${totalCancelReqAmt + info.cancelReqAmt }" />
			        		<c:set var="totalRefundReqAmt" value="${totalRefundReqAmt + info.refundReqAmt }" />			        	  
			            </c:forEach>
			            <tr>
			                <th>합  계</th>
			                <td><b><fmt:formatNumber value="${totalRsvCnt }" /></b></td>
			                <td><b><fmt:formatNumber value="${totalAccountCnt }" /></b></td>
							<td><b><fmt:formatNumber value="${totalDisAccountCnt }" /></b></td>
							<td><b><fmt:formatNumber value="${totalSaleAmt + totalDisAmt}" /></b></td>
			                <td><b><fmt:formatNumber value="${totalSaleAmt }" /></b></td>
			                <td><b><fmt:formatNumber value="${totalDisAmt }" /></b></td>
			                <td><b><fmt:formatNumber value="${totalPointAmt }" /></b></td>
			                <td><b><fmt:formatNumber value="${totalCancelReqAmt }" /></b></td>
			                <td><b><fmt:formatNumber value="${totalRefundReqAmt }" /></b></td>
			            </tr>
			        </tbody>
			        <tfoot>			        	
			        	<tr>
			                <th>회원 가입수 </th>
			                <td colspan='9'>일 회원가입 <fmt:formatNumber value="${dayMember.nowJoinCnt }" />명 / 일 회원탈퇴 <fmt:formatNumber value="${dayMember.nowQutCnt }" />명 / 총 회원수 <fmt:formatNumber value="${dayMember.userJoinCnt}" />명 (총 탈퇴수<fmt:formatNumber value="${dayMember.allQutCnt}" />명)</td>
			            </tr>
			        </tfoot>
			    </table>
                <!-- //change contents -->
                
               <%-- <h4 class="title08">하이제주 관광지입장권</h4>
                <table class="table01 center" style="width: 400px;">
			        <colgroup>
			            <col />
			            <col width="33%" />
			            <col width="40%" />
			        </colgroup>
			        <thead>
			            <tr>
			                <th>구분</th>
			                <th>예약건수</th>
			                <th>판매금액</th>
			            </tr>
			        </thead>
			        <tbody>
			            <tr>
			                <th>하이제주</th>			                
			                <td><fmt:formatNumber value="${hijejuBis.rsvCnt }" /></td>
			                <td><fmt:formatNumber value="${hijejuBis.saleAmt }" /></td>
			            </tr>
			        </tbody>
			    </table>--%>
            </div>
        </div>
    </div>
</div>
</body>
</html>        