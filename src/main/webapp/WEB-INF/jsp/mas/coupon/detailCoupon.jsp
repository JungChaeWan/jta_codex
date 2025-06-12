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
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
           
 <un:useConstants var="Constant" className="common.Constant" />
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>" ></script>

<validator:javascript formName="CPVO" staticJavascript="false" xhtml="true" cdata="true"/>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">

function fn_couponList() {
	document.CPVO.action = "<c:url value='/mas/couponList.do' />";
	document.CPVO.submit();
}

$(function() {
	
});
</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/mas/head.do?menu=product" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area">
			<form:form commandName="CPVO"  name="CPVO" method="post"  enctype="multipart/form-data">
			<input type="hidden" name="cpId" id="cpId" value="${cpVO.cpId}"/>
			<div id="contents">
				<h4 class="title03">쿠폰 상세</h4>
				<table border="1" class="table02">
					<colgroup>
                        <col width="200" />
                        <col width="*" />
                        <col width="200" />
                        <col width="*" />
                    </colgroup>
                    <tr>
		         	<th>쿠폰ID</th>
		         	<td><c:out value="${cpVO.cpId}"/></td>
		         	<th>발행상태</th>
		         	<td>
		         		<c:if test='${Constant.STATUS_CD_READY eq cpVO.statusCd}'>발행대기</c:if>
		         		<c:if test='${Constant.STATUS_CD_COMPLETE eq cpVO.statusCd}'>발행완료</c:if>
		         		<c:if test='${Constant.STATUS_CD_CANCEL eq cpVO.statusCd}'>발행취소</c:if>
		       	  	</td>
		         </tr>
		         <tr>
		         	<th>쿠폰명<span class="font02">*</span></th>
		         	<td colspan="3">
		         		<c:out value="${cpVO.cpNm}"/>
		         	</td>
		         </tr>
		         <tr>
		         	<th>적용기간<span class="font02">*</span></th>
		         	<td colspan="3">
		         		<c:out value="${fn:substring(cpVO.aplStartDt,0,4)}-${fn:substring(cpVO.aplStartDt,4,6)}-${fn:substring(cpVO.aplStartDt,6,8)}" />
		         		 ~ <c:out value="${fn:substring(cpVO.aplEndDt,0,4)}-${fn:substring(cpVO.aplEndDt,4,6)}-${fn:substring(cpVO.aplEndDt,6,8)}"  />
		         	</td>
		         </tr>
		         <tr>
		         	<th>할인방식</th>
		         	<td colspan="3">
		         		<c:if test="${cpVO.disDiv eq Constant.CP_DIS_DIV_PRICE}">
		         		금액 : <fmt:formatNumber>${cpVO.disAmt}</fmt:formatNumber> 원 
		         		</c:if>
		         		<c:if test="${cpVO.disDiv eq Constant.CP_DIS_DIV_RATE}">
		         		할인율 : <fmt:formatNumber>${cpVO.disPct}</fmt:formatNumber> % 
		         		</c:if>
		         	</td>
		         </tr>
		         <tr>
		         	<th>구매 최소 금액</th>
		         	<td colspan="3">
		         		<fmt:formatNumber>${cpVO.buyMiniAmt}</fmt:formatNumber> 원
		         	</td>
		         </tr>
		         <tr>
		         	<th>이미지</th>
		         	<td colspan="3">
		         		<c:if test="${not empty cpVO.imgPath }">
							<div id="d_imgPath">
							<c:out value="${cpVO.imgPath}" />
							<div class="btn_sty06">
								<span><a href="${cpVO.imgPath}" target="_blank">상세보기</a></span>
							</div>
							</div>
						</c:if>
		         	</td>
		         </tr>
		         <tr>
		         	<th>간략설명</th>
		         	<td colspan="3">
		         		<c:out value="${cpVO.simpleExp}"  escapeXml="false"/>
		         	</td>
		         </tr>
		         <tr>
		         	<th>적용상품<span class="font02">*</span></th>
		         	<td colspan="3">            	
                    	<c:forEach var="prdt" items="${cpPrdtList }" varStatus="status">
                    		[<c:out value="${prdt.prdtNum }" />][<c:out value="${prdt.corpNm }" />][<c:out value="${prdt.prdtNm }" />]                    		
                    		<br>
                    	</c:forEach>
		         	</td>
		         </tr>		         
		         <tr>
		         	<th>등록시각</th>
		         	<td><c:out value="${cpVO.regDttm}"/> (<c:out value="${cpVO.regId}"/>)</td>
		         	<th>수정시각</th>
		         	<td><c:out value="${cpVO.modDttm}"/> (<c:out value="${cpVO.modId}"/>)</td>
		         </tr>
			</table>
			<ul class="btn_rt01 align_ct">
				<li class="btn_sty01"><a href="javascript:fn_couponList()">목록</a></li>
			</ul>
		</div>
		</form:form>
	</div>
	<!--//Contents 영역--> 
</div>
</div>
</body>
</html>
		