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
<script type="text/javascript" src="<c:url value='/js/Chart.bundle.min.js'/>"></script>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css' />" />

<script type="text/javascript">

function fn_ChangeYear(){
	var optHtml = "";
	var chkMonth = 13;
	if($("#sFromYear").val() == "${nowYear}"){
		chkMonth = parseInt("${nowMonth}");
	}
	for(var i=1;i<chkMonth;i++){
		optHtml += "<option value=\"" + i + "\">" + i + "월</option>";
	}
	$("#sFromMonth").html(optHtml);
	fn_Search();
}

function fn_Search(){
	document.frm.action = "<c:url value='/oss/bisSaleMonth.do'/>";
	document.frm.submit();
}

function fn_CancelDft(ctgr, gubun){
	document.frm.sCtgr.value = ctgr;
	document.frm.sCorpId.value = gubun;
	document.frm.action = "<c:url value='/oss/bisSaleCancelDft.do'/>";
	document.frm.submit();
}

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
                <jsp:include page="/oss/left.do?menu=bis&sub=sale" flush="false"></jsp:include>
            </div>
            <!--//사이드메뉴-->
        </div>
        <div id="contents_area">
            <div id="contents">
            	<!-- change contents -->
                <!-- 3Depth menu -->
                <div id="menu_depth3">
					<ul>
						<li class="on"><a class="menu_depth3" href="/oss/bisSaleYear.do">월간매출통계</a></li>
						<li><a class="menu_depth3" href="/oss/bisSalePdfAll.do">전체 상품</a></li>
						<li><a class="menu_depth3" href="/oss/bisSalePdfAv.do">항공</a></li>
						<li><a class="menu_depth3" href="/oss/bisSalePdfAd.do">숙소</a></li>
						<li><a class="menu_depth3" href="/oss/bisSalePdfRc.do">렌터카</a></li>
						<li><a class="menu_depth3" href="/oss/bisSalePdfSpc.do">관광지/레저</a></li>
						<li><a class="menu_depth3" href="/oss/bisSalePdfSpf.do">맛집</a></li>
						<li><a class="menu_depth3" href="/oss/bisSalePdfSpt.do">여행사 상품</a></li>
						<li><a class="menu_depth3" href="/oss/bisSalePdfSv.do">제주특산/기념품</a></li>
						<li><a class="menu_depth3" href="/oss/bisSalePdfSpb.do">카시트/유모차</a></li>
						<li><a class="menu_depth3" href="/oss/bisSalePdfCp.do">하이제주</a></li>
					</ul>
				</div>
            	<form name="frm" method="post">
					<input type="hidden" id="sCorpId" name="sCorpId" />
					<input type="hidden" id="sCtgr" name="sCtgr" />
                <div class="option-wrap margin">
                    <select id="sFromYear" name="sFromYear" style="width:60px;" onchange="fn_Search();" title="년도 선택">
                    	<c:forEach begin="2016" end="${nowYear}" step="1" var="vYear">
                   			<option value="${vYear}" <c:if test="${vYear eq searchVO.sFromYear}">selected="selected"</c:if>>${vYear}</option>
                    	</c:forEach>
                    </select>
                    <select id="sFromMonth" name="sFromMonth" style="width:60px;" onchange="fn_Search();" title="월 선택">
                    	<c:forEach begin="1" end="12" step="1" var="vMonth">
                    		<c:if test="${vMonth < 10}">
                    			<c:set var="fromMonth_v" value="0${vMonth}" />
                    		</c:if>
                    		<c:if test="${vMonth >= 10}">
                    			<c:set var="fromMonth_v" value="${vMonth}" />
                    		</c:if>
                   			<option value="${fromMonth_v}" <c:if test="${fromMonth_v == searchVO.sFromMonth}">selected="selected"</c:if>>${vMonth}월</option>
                    	</c:forEach>
                    </select>
                </div>
                </form>
            	
            	<div class="list">
			        <table class="table01 center">
			            <colgroup>
			                <col width="9%" />
			                <col width="13%" />
			                <col width="13%" />
			                <col width="10%" />
			                <col width="10%" />
			                <col width="10%" />
							<col width="13%" />
							<col width="11%" />
			                <col width="12%" />
			                <col width="11%" />
			            </colgroup>
			            <thead>
			                <tr>
			                    <th>상품구분</th>
			                    <th>총 매출</th>
			                    <th><p>순 매출</p><p>(총매출-총취소액)</p></th>
			                    <th>판매건수</th>
			                    <th><p>순 판매건수</p><p>(판매건수-취소건수)</p></th>
								<th>사용쿠폰 개수</th>
								<th>사용쿠폰 금액</th>
			                    <th>구매고객수</th>
			                    <th>개인별 평균 매출</th>
			                    <th>개인 별 구매건수</th>
			                </tr>
			            </thead>
			            <tbody>
			                <tr>
			                    <td>전체</td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.totalAmt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.totalAmt - cancelRsvAnls.totalCancelAmt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.totalCnt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.totalCnt - cancelRsvAnls.totalCancelCnt}"/></fmt:formatNumber></td>

								<td><fmt:formatNumber><c:out value="${rsvAnls.disCnt}"/></fmt:formatNumber></td>
								<td><fmt:formatNumber><c:out value="${rsvAnls.disAmt}"/></fmt:formatNumber></td>

			                    <td><fmt:formatNumber><c:out value="${rsvAnls.userCnt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.avgAmt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.avgCnt}"/></fmt:formatNumber></td>
			                </tr>
			                <tr>
			                    <td>항공</td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.avTotalAmt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.avTotalAmt - cancelRsvAnls.avTotalCancelAmt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.avTotalCnt}"/></fmt:formatNumber></td>
								<td><fmt:formatNumber><c:out value="${rsvAnls.avTotalCnt - cancelRsvAnls.avTotalCancelCnt}"/></fmt:formatNumber></td>

								<td><fmt:formatNumber><c:out value="${rsvAnls.avDisCnt}"/></fmt:formatNumber></td>
								<td><fmt:formatNumber><c:out value="${rsvAnls.avDisAmt}"/></fmt:formatNumber></td>

			                    <td><fmt:formatNumber><c:out value="${rsvAnls.avUserCnt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.avAvgAmt}"/></fmt:formatNumber></td>
			                    <td></td>
			                </tr>
			                <tr>
			                    <td>숙박</td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.adTotalAmt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.adTotalAmt - cancelRsvAnls.adTotalCancelAmt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.adTotalCnt}"/></fmt:formatNumber></td>
								<td><fmt:formatNumber><c:out value="${rsvAnls.adTotalCnt - cancelRsvAnls.adTotalCancelCnt}"/></fmt:formatNumber></td>

								<td><fmt:formatNumber><c:out value="${rsvAnls.adDisCnt}"/></fmt:formatNumber></td>
								<td><fmt:formatNumber><c:out value="${rsvAnls.adDisAmt}"/></fmt:formatNumber></td>

			                    <td><fmt:formatNumber><c:out value="${rsvAnls.adUserCnt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.adAvgAmt}"/></fmt:formatNumber></td>
			                    <td></td>
			                </tr>
			                <tr>
			                    <td>렌터카</td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.rcTotalAmt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.rcTotalAmt - cancelRsvAnls.rcTotalCancelAmt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.rcTotalCnt}"/></fmt:formatNumber></td>
								<td><fmt:formatNumber><c:out value="${rsvAnls.rcTotalCnt - cancelRsvAnls.rcTotalCancelCnt}"/></fmt:formatNumber></td>

								<td><fmt:formatNumber><c:out value="${rsvAnls.rcDisCnt}"/></fmt:formatNumber></td>
								<td><fmt:formatNumber><c:out value="${rsvAnls.rcDisAmt}"/></fmt:formatNumber></td>

			                    <td><fmt:formatNumber><c:out value="${rsvAnls.rcUserCnt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.rcAvgAmt}"/></fmt:formatNumber></td>
			                    <td></td>
			                </tr>
			                
			                <tr>
			                    <td>관광지/레저</td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.c200TotalAmt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.c200TotalAmt - cancelRsvAnls.c200TotalCancelAmt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.c200TotalCnt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.c200TotalCnt - cancelRsvAnls.c200TotalCancelCnt}"/></fmt:formatNumber></td>

								<td><fmt:formatNumber><c:out value="${rsvAnls.c200DisCnt}"/></fmt:formatNumber></td>
								<td><fmt:formatNumber><c:out value="${rsvAnls.c200DisAmt}"/></fmt:formatNumber></td>

			                    <td><fmt:formatNumber><c:out value="${rsvAnls.c200UserCnt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.c200AvgAmt}"/></fmt:formatNumber></td>
			                    <td></td>
			                </tr>
			                <tr>
			                    <td>맛집</td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.c300TotalAmt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.c300TotalAmt - cancelRsvAnls.c300TotalCancelAmt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.c300TotalCnt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.c300TotalCnt - cancelRsvAnls.c300TotalCancelCnt}"/></fmt:formatNumber></td>

								<td><fmt:formatNumber><c:out value="${rsvAnls.c300DisCnt}"/></fmt:formatNumber></td>
								<td><fmt:formatNumber><c:out value="${rsvAnls.c300DisAmt}"/></fmt:formatNumber></td>

			                    <td><fmt:formatNumber><c:out value="${rsvAnls.c300UserCnt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.c300AvgAmt}"/></fmt:formatNumber></td>
								<td></td>
							</tr>
							<tr>
								<td>여행사상품</td>
								<td><fmt:formatNumber><c:out value="${rsvAnls.c100TotalAmt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.c100TotalAmt - cancelRsvAnls.c100TotalCancelAmt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.c100TotalCnt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.c100TotalCnt - cancelRsvAnls.c100TotalCancelCnt}"/></fmt:formatNumber></td>

								<td><fmt:formatNumber><c:out value="${rsvAnls.c100DisCnt}"/></fmt:formatNumber></td>
								<td><fmt:formatNumber><c:out value="${rsvAnls.c100DisAmt}"/></fmt:formatNumber></td>

			                    <td><fmt:formatNumber><c:out value="${rsvAnls.c100UserCnt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.c100AvgAmt}"/></fmt:formatNumber></td>
			                    <td></td>
			                </tr>
			                <tr>
			                    <td>제주특산/기념품</td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.svTotalAmt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.svTotalAmt - cancelRsvAnls.svTotalCancelAmt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.svTotalCnt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.svTotalCnt - cancelRsvAnls.svTotalCancelCnt}"/></fmt:formatNumber></td>

								<td><fmt:formatNumber><c:out value="${rsvAnls.svDisCnt}"/></fmt:formatNumber></td>
								<td><fmt:formatNumber><c:out value="${rsvAnls.svDisAmt}"/></fmt:formatNumber></td>

			                    <td><fmt:formatNumber><c:out value="${rsvAnls.svUserCnt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.svAvgAmt}"/></fmt:formatNumber></td>
			                    <td></td>
			                </tr>
			                <tr>
			                    <td>카시트/유모차</td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.c500TotalAmt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.c500TotalAmt - cancelRsvAnls.c500TotalCancelAmt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.c500TotalCnt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.c500TotalCnt - cancelRsvAnls.c500TotalCancelCnt}"/></fmt:formatNumber></td>

								<td><fmt:formatNumber><c:out value="${rsvAnls.c500DisCnt}"/></fmt:formatNumber></td>
								<td><fmt:formatNumber><c:out value="${rsvAnls.c500DisAmt}"/></fmt:formatNumber></td>

			                    <td><fmt:formatNumber><c:out value="${rsvAnls.c500UserCnt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${rsvAnls.c500AvgAmt}"/></fmt:formatNumber></td>
			                    <td></td>
			                </tr>
			            </tbody>
			        </table>	
			    </div>
			    
			    <h4 class="title08">취소 통계</h4>
			    <div class="list">
			        <table class="table01 center">
			            <colgroup>
			                <col width="20%" />
			                <col width="20%" />
			                <col width="20%" />
			                <col width="20%" />
			                <col width="20%" />
			                <col width="20%" />
			            </colgroup>
			            <thead>
			                <tr>
			                    <th>상품구분</th>
			                    <th>총 취소금액</th>
			                    <th>취소건수</th>
			                    <th>당월취소건수</th>
			                    <th>당월이전취소건수</th>
			                </tr>
			            </thead>
			            <tbody>
			                <tr>
			                    <td>전체</td>
			                    <td><fmt:formatNumber><c:out value="${cancelRsvAnls.totalCancelAmt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${cancelRsvAnls.totalCancelCnt}"/></fmt:formatNumber></td>
			                    <td><c:if test="${cancelRsvAnls.nmCancelCnt != 0}"><a href="javascript:fn_CancelDft('ALL', 'CUR')" class="link"></c:if><fmt:formatNumber><c:out value="${cancelRsvAnls.nmCancelCnt}"/></fmt:formatNumber><c:if test="${cancelRsvAnls.nmCancelCnt != 0}"></a></c:if></td>
			                    <td><c:if test="${cancelRsvAnls.omCancelCnt != 0}"><a href="javascript:fn_CancelDft('ALL', 'PREV')" class="link"></c:if><fmt:formatNumber><c:out value="${cancelRsvAnls.omCancelCnt}"/></fmt:formatNumber><c:if test="${cancelRsvAnls.omCancelCnt != 0}"></a></c:if></td>
			                </tr>
			                <tr>
			                    <td>항공</td>
			                    <td><fmt:formatNumber><c:out value="${cancelRsvAnls.avTotalCancelAmt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${cancelRsvAnls.avTotalCancelCnt}"/></fmt:formatNumber></td>
			                    <td><c:if test="${cancelRsvAnls.avNmCancelCnt != 0}"><a href="javascript:fn_CancelDft('AV', 'CUR')" class="link"></c:if><fmt:formatNumber><c:out value="${cancelRsvAnls.avNmCancelCnt}"/></fmt:formatNumber><c:if test="${cancelRsvAnls.avNmCancelCnt != 0}"></a></c:if></td>
			                    <td><c:if test="${cancelRsvAnls.avOmCancelCnt != 0}"><a href="javascript:fn_CancelDft('AV', 'PREV')" class="link"></c:if><fmt:formatNumber><c:out value="${cancelRsvAnls.avOmCancelCnt}"/></fmt:formatNumber><c:if test="${cancelRsvAnls.avOmCancelCnt != 0}"></a></c:if></td>
			                </tr>
			                <tr>
			                    <td>숙박</td>
			                    <td><fmt:formatNumber><c:out value="${cancelRsvAnls.adTotalCancelAmt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${cancelRsvAnls.adTotalCancelCnt}"/></fmt:formatNumber></td>
			                    <td><c:if test="${cancelRsvAnls.adNmCancelCnt != 0}"><a href="javascript:fn_CancelDft('AD', 'CUR')" class="link"></c:if><fmt:formatNumber><c:out value="${cancelRsvAnls.adNmCancelCnt}"/></fmt:formatNumber><c:if test="${cancelRsvAnls.adNmCancelCnt != 0}"></a></c:if></td>
			                    <td><c:if test="${cancelRsvAnls.adOmCancelCnt != 0}"><a href="javascript:fn_CancelDft('AD', 'PREV')" class="link"></c:if><fmt:formatNumber><c:out value="${cancelRsvAnls.adOmCancelCnt}"/></fmt:formatNumber><c:if test="${cancelRsvAnls.adOmCancelCnt != 0}"></a></c:if></td>
			                </tr>
			                <tr>
			                    <td>렌터카</td>
			                    <td><fmt:formatNumber><c:out value="${cancelRsvAnls.rcTotalCancelAmt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${cancelRsvAnls.rcTotalCancelCnt}"/></fmt:formatNumber></td>
			                    <td><c:if test="${cancelRsvAnls.rcNmCancelCnt != 0}"><a href="javascript:fn_CancelDft('RC', 'CUR')" class="link"></c:if><fmt:formatNumber><c:out value="${cancelRsvAnls.rcNmCancelCnt}"/></fmt:formatNumber><c:if test="${cancelRsvAnls.rcNmCancelCnt != 0}"></a></c:if></td>
			                    <td><c:if test="${cancelRsvAnls.rcOmCancelCnt != 0}"><a href="javascript:fn_CancelDft('RC', 'PREV')" class="link"></c:if><fmt:formatNumber><c:out value="${cancelRsvAnls.rcOmCancelCnt}"/></fmt:formatNumber><c:if test="${cancelRsvAnls.rcOmCancelCnt != 0}"></a></c:if></td>
			                </tr>
			                <tr>
			                    <td>관광지/레저</td>
			                    <td><fmt:formatNumber><c:out value="${cancelRsvAnls.c200TotalCancelAmt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${cancelRsvAnls.c200TotalCancelCnt}"/></fmt:formatNumber></td>
			                    <td><c:if test="${cancelRsvAnls.c200NmCancelCnt != 0}"><a href="javascript:fn_CancelDft('C200', 'CUR')" class="link"></c:if><fmt:formatNumber><c:out value="${cancelRsvAnls.c200NmCancelCnt}"/></fmt:formatNumber><c:if test="${cancelRsvAnls.c200NmCancelCnt != 0}"></a></c:if></td>
			                    <td><c:if test="${cancelRsvAnls.c200OmCancelCnt != 0}"><a href="javascript:fn_CancelDft('C200', 'PREV')" class="link"></c:if><fmt:formatNumber><c:out value="${cancelRsvAnls.c200OmCancelCnt}"/></fmt:formatNumber><c:if test="${cancelRsvAnls.c200OmCancelCnt != 0}"></a></c:if></td>
			                </tr>
			                <tr>
			                    <td>맛집</td>
			                    <td><fmt:formatNumber><c:out value="${cancelRsvAnls.c300TotalCancelAmt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${cancelRsvAnls.c300TotalCancelCnt}"/></fmt:formatNumber></td>
			                    <td><c:if test="${cancelRsvAnls.c300NmCancelCnt != 0}"><a href="javascript:fn_CancelDft('C300', 'CUR')" class="link"></c:if><fmt:formatNumber><c:out value="${cancelRsvAnls.c300NmCancelCnt}"/></fmt:formatNumber><c:if test="${cancelRsvAnls.c300NmCancelCnt != 0}"></a></c:if></td>
			                    <td><c:if test="${cancelRsvAnls.c300OmCancelCnt != 0}"><a href="javascript:fn_CancelDft('C300', 'PREV')" class="link"></c:if><fmt:formatNumber><c:out value="${cancelRsvAnls.c300OmCancelCnt}"/></fmt:formatNumber><c:if test="${cancelRsvAnls.c300OmCancelCnt != 0}"></a></c:if>
								</td>
							</tr>
							<tr>
								<td>여행사상품</td>
								<td><fmt:formatNumber><c:out value="${cancelRsvAnls.c100TotalCancelAmt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${cancelRsvAnls.c100TotalCancelCnt}"/></fmt:formatNumber></td>
			                    <td><c:if test="${cancelRsvAnls.c100NmCancelCnt != 0}"><a href="javascript:fn_CancelDft('C100', 'CUR')" class="link"></c:if><fmt:formatNumber><c:out value="${cancelRsvAnls.c100NmCancelCnt}"/></fmt:formatNumber><c:if test="${cancelRsvAnls.c100NmCancelCnt != 0}"></a></c:if></td>
			                    <td><c:if test="${cancelRsvAnls.c100OmCancelCnt != 0}"><a href="javascript:fn_CancelDft('C100', 'PREV')" class="link"></c:if><fmt:formatNumber><c:out value="${cancelRsvAnls.c100OmCancelCnt}"/></fmt:formatNumber><c:if test="${cancelRsvAnls.c100OmCancelCnt != 0}"></a></c:if></td>
			                </tr>
			                <tr>
			                    <td>제주특산/기념품</td>
			                    <td><fmt:formatNumber><c:out value="${cancelRsvAnls.svTotalCancelAmt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${cancelRsvAnls.svTotalCancelCnt}"/></fmt:formatNumber></td>
			                    <td><c:if test="${cancelRsvAnls.svNmCancelCnt != 0}"><a href="javascript:fn_CancelDft('SV', 'CUR')" class="link"></c:if><fmt:formatNumber><c:out value="${cancelRsvAnls.svNmCancelCnt}"/></fmt:formatNumber><c:if test="${cancelRsvAnls.svNmCancelCnt != 0}"></a></c:if></td>
			                    <td><c:if test="${cancelRsvAnls.svOmCancelCnt != 0}"><a href="javascript:fn_CancelDft('SV', 'PREV')" class="link"></c:if><fmt:formatNumber><c:out value="${cancelRsvAnls.svOmCancelCnt}"/></fmt:formatNumber><c:if test="${cancelRsvAnls.svOmCancelCnt != 0}"></a></c:if></td>
			                </tr>
			                <tr>
			                    <td>카시트/유모차</td>
			                    <td><fmt:formatNumber><c:out value="${cancelRsvAnls.c500TotalCancelAmt}"/></fmt:formatNumber></td>
			                    <td><fmt:formatNumber><c:out value="${cancelRsvAnls.c500TotalCancelCnt}"/></fmt:formatNumber></td>
			                    <td><c:if test="${cancelRsvAnls.c500NmCancelCnt != 0}"><a href="javascript:fn_CancelDft('C500', 'CUR')" class="link"></c:if><fmt:formatNumber><c:out value="${cancelRsvAnls.c500NmCancelCnt}"/></fmt:formatNumber><c:if test="${cancelRsvAnls.c500NmCancelCnt != 0}"></a></c:if></td>
			                    <td><c:if test="${cancelRsvAnls.c500OmCancelCnt != 0}"><a href="javascript:fn_CancelDft('C500', 'PREV')" class="link"></c:if><fmt:formatNumber><c:out value="${cancelRsvAnls.c500OmCancelCnt}"/></fmt:formatNumber><c:if test="${cancelRsvAnls.c500OmCancelCnt != 0}"></a></c:if></td>
			                </tr>
			            </tbody>
			        </table>
			    </div>
                <!-- //change contents -->
            </div>
		</div>
    </div>
</div>
</body>
</html>   