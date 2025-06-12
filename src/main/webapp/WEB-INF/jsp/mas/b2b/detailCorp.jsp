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

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />

<title></title>

<script type="text/javascript">

</script>
</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/mas/head.do?menu=b2b" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area"> 
			<!--본문-->
			
			<!--업체정보상세-->	
			<div id="contents">
			
				<!--업체 기본 정보-->
				<h4 class="title03 margin-top25">업체 기본정보</h4>				
				<table border="1" class="table02">
					<colgroup>
                        <col width="15%" />
                        <col width="35%" />
                        <col width="15%" />
                        <col width="35%" />
                    </colgroup>
					<tr>
						<th>업체명</th>
						<td>
							<c:out value="${corpInfo.corpNm}" />
						</td>
						<th>업체구분</th>
						<td>
							<c:forEach var="code" items="${corpCd}" varStatus="status">
								<c:if test="${corpInfo.corpCd==code.cdNum}">${code.cdNm}</c:if>
							</c:forEach>
							<c:if test="${corpInfo.corpCd eq Constant.SOCIAL}">
								<c:if test="${corpInfo.corpSubCd eq Constant.SOCIAL_TOUR }">
									(여행사)
								</c:if>
								<c:if test="${corpInfo.corpSubCd eq Constant.SOCIAL_TICK }">
									(관광지)
								</c:if>
								<c:if test="${corpInfo.corpSubCd eq Constant.SOCIAL_FOOD }">
									(음식/뷰티)
								</c:if>
							</c:if>
						</td>
					</tr>
					<tr>
						<th>사업자등록번호</th>
						<td>
							<c:out value="${corpInfo.coRegNum}" />
						</td>
						<th>회사유형</th>
						<td>
							<c:if test="${Constant.CORP_TYPE_CORP==corpInfo.corpType}">법인</c:if> 
							<c:if test="${Constant.CORP_TYPE_INDI==corpInfo.corpType}">개인</c:if>
						</td>						
					</tr>
					<tr>						
						<th>예약전화번호</th>
						<td>
							<c:out value="${corpInfo.rsvTelNum}" />
						</td>
						<th>팩스번호</th>
						<td>
							<c:out value="${corpInfo.faxNum}" />
						</td>
					</tr>
					<tr>						
						<th>업체홈페이지</th>
						<td>
							<a href="<c:out value='${corpInfo.hmpgAddr}' />" target="_blank"><c:out value='${corpInfo.hmpgAddr}' /></a>
						</td>
						<th>계약상태</th>
						<td>
							<c:forEach var="code" items="${tradeStateCd}" varStatus="status">
								<c:if test="${corpInfo.tradeStatusCd==code.cdNum}">${code.cdNm}</c:if>
							</c:forEach>
						</td>
					</tr>
					<tr>						
						<th>업태</th>
						<td>
							<c:out value="${corpInfo.bsncon}" />
						</td>
						<th>업종</th>
						<td>
							<c:out value="${corpInfo.bsntyp}" />
						</td>
					</tr>
					<tr>
						<th>업체이메일</th>
						<td colspan="3">
							<c:out value="${corpInfo.corpEmail}" />
						</td>
					</tr>
					<tr>
						<th>계좌정보</th>
						<td colspan="3">
							<c:out value="${corpInfo.bankNm}" /> <c:out value="${corpInfo.accNum}" /> , <c:out value="${corpInfo.depositor}" />
						</td>
					</tr>
					<tr>
						<th>업체주소</th>
						<td colspan="3">
							<c:out value="${corpInfo.roadNmAddr}" /><br />
							<c:out value="${corpInfo.dtlAddr}" />
						</td>
					</tr>
					<tr>
						<th>위도/경도</th>
						<td colspan="3">
							<strong>위도</strong> <c:out value="${corpInfo.lat}" /> / <strong>경도</strong> <c:out value="${corpInfo.lon}" />
						</td>
					</tr>
				</table>
				<!--//업체 기본 정보-->
				
				
				<!--담당자 정보-->
				<h4 class="title03 margin-top25">담당자 정보</h4>				
				<table border="1" class="table02">
					<colgroup>
                        <col width="15%" />
                        <col width="35%" />
                        <col width="15%" />
                        <col width="35%" />
                    </colgroup>
                    <tr>
						<th>대표자 성명</th>
                    	<td>
                    		<c:out value="${corpInfo.ceoNm}" />
                    	</td>
						<th>담당자 성명</th>
						<td><c:out value="${corpInfo.admNm}" /></td>
					</tr>
					<tr>
						<th>이메일</th>
						<td><c:out value="${corpInfo.admEmail}" /></td>
						<th>일반전화</th>
						<td><c:out value="${corpInfo.admTelnum}" /></td>
					</tr>
					<tr>
						<th>부서</th>
						<td><c:out value="${corpInfo.admDep}" /></td>
						<th>직위</th>
						<td><c:out value="${corpInfo.admOfcpos}" /></td>
					</tr>
				</table>
				<!--담당자 정보-->
				
				
				<form name="corp" method="post">
					<input type="hidden" id="corpId" name="corpId" value='<c:out value="${corpInfo.corpId}" />' />
					<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
					<input type="hidden" id="sCorpNm" name="sCorpNm" value="${searchVO.sCorpNm}"/>
				</form>
			
				<ul class="btn_rt01">
					<li class="btn_sty01">
						<a href="javascript:history.back();">뒤로</a>
					</li>
					
				</ul>
			</div>
			<!--//업체정보상세-->
			
			<!--//본문--> 
		</div>
	</div>
	<!--//Contents 영역--> 
</div>
</body>
</html>