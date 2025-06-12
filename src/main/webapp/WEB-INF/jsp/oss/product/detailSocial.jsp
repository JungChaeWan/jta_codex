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
<head>

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />

<title></title>

<script type="text/javascript">

function fn_ListSocial(){
	document.social.action = "<c:url value='/oss/socialProductList.do'/>";
	document.social.submit();
}

function fn_UdtSocial(){
	document.social.action = "<c:url value='/oss/updateSocial.do'/>";
	document.social.submit();
}

</script>
</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/oss/head.do?menu=product" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=product&sub=social" flush="false"></jsp:include>
		<div id="contents_area"> 
			<!--본문-->
			<!--상품 등록-->
			<form name="social" method="post">
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
				<input type="hidden" id="prdtNum" name="prdtNum" value="${spPrdtInf.prdtNum}" />
			<div id="contents">
				<h4>상품 기본정보</h4>
				
				<table border="1" class="table02">
					<colgroup>
                        <col width="233" />
                        <col width="385" />
                        <col width="233" />
                        <col width="385" />
                    </colgroup>
					<tr>
						<th scope="row">쇼셜상품번호<span>*</span></th>
						<td>
							<c:out value="${spPrdtInf.prdtNum}" />
						</td>
						<th>카테고리</th>
						<td>
							<c:out value="${spPrdtInf.ctgr }" />
						</td>
					</tr>
					<tr>
						<th>상품명</th>
						<td colspan="3"><c:out value="${spPrdtInf.prdtNm}" /></td>
					</tr>
					<tr>
						<th>상품정보</th>
						<td colspan="3"><c:out value="${spPrdtInf.prdtInf}" /></td>
					</tr>
					<tr>
						<th>서브설명</th>
						<td colspan="3"><c:out value="${spPrdtInf.subExp}" /></td>
					</tr>
					<tr>
						<th>상품구분</th>
						<td>
							<c:if test="${Constant.SP_PRDT_DIV_TOUR == spPrdtInf.prdtDiv}">여행상품</c:if>
							<c:if test="${Constant.SP_PRDT_DIV_COUP == spPrdtInf.prdtDiv}">쿠폰상품</c:if>
							<c:if test="${Constant.SP_PRDT_DIV_SHOP == spPrdtInf.prdtDiv}">쇼핑상품</c:if>
						<th>판매일</th>
						<td><fmt:parseDate value="${spPrdtInf.saleStartDt}" var="saleStartDt" pattern="yyyyMMdd"/><fmt:parseDate value="${spPrdtInf.saleEndDt}" var="saleEndDt" pattern="yyyyMMdd"/>
								<fmt:formatDate value="${saleStartDt}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${saleEndDt}" pattern="yyyy-MM-dd"/>
						 </td>
					</tr>
					<tr>
						<th>유효일</th>
						<td>
							<fmt:parseDate value="${spPrdtInf.exprStartDt}" var="exprStartDt" pattern="yyyyMMdd"/><fmt:parseDate value="${spPrdtInf.exprEndDt}" var="exprEndDt" pattern="yyyyMMdd"/>
								<fmt:formatDate value="${exprStartDt}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${exprEndDt}" pattern="yyyy-MM-dd"/>
						</td>
						<th>거래상태</th>
						<td>
							${spPrdtInf.tradeStatus}
							<select id="tradeStatus" name="tradeStatus">
								<option value="${Constant.TRADE_STATUS_APPR }">승인</option>
								<option value="${Constant.TRADE_STATUS_APPR_REJECT }">승인거절</option>
								<option value="${Constant.TRADE_STATUS_STOP }">판매중지</option>
							</select>
						</td>
					</tr>
				</table>
				<ul class="btn_rt01">
					<li class="btn_sty04">
						<a href="javascript:fn_UdtSocial()">저장</a>
					</li>
					<li class="btn_sty01">
						<a href="javascript:fn_ListSocial()">목록</a>
					</li>
				</ul>
			</div>
			
			</form>
			<!--//상품등록--> 
			<!--//본문--> 
		</div>
	</div>
	<!--//Contents 영역--> 
</div>
</body>
</html>