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

function fn_Search(){
	document.frm.action = "<c:url value='/oss/bisSaleYear.do'/>";
	document.frm.submit();
}

function fn_DtlAnls(dt){
	$("#sFromMonth").val(dt);
	document.frm.action = "<c:url value='/oss/bisSaleMonth.do'/>";
	document.frm.submit();
}

function fn_SaveExcel(){
	var parameters = $("#frm").serialize();
	
	frmFileDown.location = "<c:url value='/oss/bisSaleCancelDftExcel.do?"+ parameters +"'/>";
}

$(document).ready(function() {

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
						<li><a class="menu_depth3" href="/oss/bisSalePdfSpt.do">여행사상품</a></li>
						<li><a class="menu_depth3" href="/oss/bisSalePdfSv.do">제주특산/기념품</a></li>
						<li><a class="menu_depth3" href="/oss/bisSalePdfSpb.do">카시트/유모차</a></li>
						<li><a class="menu_depth3" href="/oss/bisSalePdfCp.do">하이제주</a></li>
					</ul>
				</div>				
					
				<ul class="btn_lt01">
					<li>
						<h4 class="title08">취소 통계 상세 </h4>
					</li>
					<li class="btn_sty01">
						<a href="javascript:fn_SaveExcel();">Excel</a>
					</li>
				</ul>
				<form id="frm" name="frm" method="post" onSubmit="return false;">
					<input type="hidden" id="sCorpId" name="sCorpId" value="${searchVO.sCorpId }" />
					<input type="hidden" id="sCtgr" name="sCtgr" value="${searchVO.sCtgr }" />
					<input type="hidden" id="sFromYear" name="sFromYear" value="${searchVO.sFromYear }" />
					<input type="hidden" id="sFromMonth" name="sFromMonth" value="${searchVO.sFromMonth }" />
				</form>
								    			    	    
			    <div class="list">
			        <table class="table01 center">
			            <colgroup>
			                <col width="9%" />
			                <col width="7%" />
			                <col width="7%" />
			                <col />			                
			                <col width="8%" />
			                <col width="8%" />
			                <col width="20%" />
			            </colgroup>
			            <thead>
			                <tr>
			                    <th>예약번호</th>
			                    <th>예약일자</th>
			                    <th>취소일자</th>
			                    <th>예약정보</th>
			                    <th>취소금액</th>
			                    <th>취소수수료</th>
			                    <th>취소사유</th>
			                </tr>
			            </thead>
			            <tbody>
			            	<c:forEach items="${cancelDftList }" var="cancel">
			                <tr>
			                    <td>${cancel.rsvNum }</td>
			                    <td>${cancel.rsvDt }</td>
			                    <td>${cancel.cancelRequestDttm }</td>
			                    <td class="left">
			                        <h5 class="product">[${cancel.prdtCateNm }] <span class="cProduct">${cancel.corpNm } ${cancel.prdtNm }</span></h5>
			                        <p class="infoText">${cancel.prdtInf }</p>
			                    </td>
			                    <td><fmt:formatNumber value="${cancel.cancelAmt }" /></td>
			                    <td><fmt:formatNumber value="${cancel.cmssAmt }" /></td>
			                    <td>${cancel.cancelRsn }</td>
			                </tr>
			                </c:forEach>
			            </tbody>
			        </table>
			    </div>
                <!-- //change contents -->			
            </div>
        </div>
    </div>
</div>
<iframe name="frmFileDown" style="display:none"></iframe>
</body>
</html>        
        