<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="un"	uri="http://jakarta.apache.org/taglibs/unstandard-1.0"%>

<un:useConstants var="Constant" className="common.Constant" />

<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>


<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">

/**
 * 조회 & 페이징
 */
function fn_Search(pageIndex) {
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/oss/bestprdtList.do'/>";
	document.frm.submit();
}


function fn_Udt(bestprdtNum) {
	document.frm.bestprdtNum.value = bestprdtNum;
	document.frm.action = "<c:url value='/oss/bestprdtUdtView.do'/>";
	document.frm.submit();
}




function fn_Ins() {
	document.frm.pageIndex.value = 0;
	document.frm.action = "<c:url value='/oss/bestprdtInsView.do'/>";
	document.frm.submit();
}


function fn_Del(bestprdtNum) {
	if(confirm("삭제 하시겠습까?")){
		document.frm.pageIndex.value = 0;
		document.frm.bestprdtNum.value = bestprdtNum;
		document.frm.action = "<c:url value='/oss/bestprdtDel.do'/>";
		document.frm.submit();
	}
}


$(document).ready(function(){

});

</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=site" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=site&sub=bestprdt" flush="false"></jsp:include>
		<div id="contents_area">
			<div id="contents_area">
				<div id="contents">
					<form name="frm" method="get" onSubmit="return false;">
						<input type="hidden" id="bestprdtNum" name="bestprdtNum" />
						<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}" />

						<div id="contents">
							<h4 class="title03">베스트 상품 관리</h4>
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
				               						<th scope="row">상품구분</th>
				               						<td colspan="5">
				               							<select  name="sCorpCd" id="sCorpCd" onchange="fn_Search(1);">
				        									<c:forEach items="${corpCdList}" var="data">
				        										<c:if test="${data.cdNum!='AV'}">
				        											<option value="${data.cdNum}" <c:if test="${data.cdNum eq searchVO.sCorpCd}">selected="true"</c:if>><c:out value="${data.cdNm} (${data.cdNum})" /></option>
				        										</c:if>
				        									</c:forEach>
				        								</select>
				               						</td>
				               						<c:if test="${searchVO.sCorpCd eq 'SP'}">
					               						<th scope="row">상품상세구분</th>
					               						<td colspan="5">
					               							<select  name="sCorpSubCd" id="sCorpSubCd" onchange="fn_Search(1);">
					               								<option value="C200" <c:if test="${'C200' eq searchVO.sCorpSubCd}">selected="true"</c:if>><c:out value="관광지/레저" /></option>
					               								<option value="C300" <c:if test="${'C300' eq searchVO.sCorpSubCd}">selected="true"</c:if>><c:out value="맛집" /></option>
																<option value="C100" <c:if test="${'C100' eq searchVO.sCorpSubCd}">selected="true"</c:if>><c:out value="여행사상품" /></option>
					               								
					        									<%-- <c:forEach items="${cateCdList}" var="data">
					        										<option value="${data.cdNum}" <c:if test="${data.cdNum eq searchVO.sCorpSubCd}">selected="true"</c:if>><c:out value="${data.cdNm} (${data.cdNum})" /></option>
					        									</c:forEach> --%>
					        									
					        								</select>
					               						</td>
				               						</c:if>
				               					</tr>
				     						</tbody>
				               			</table>
				               		</div>
				               		<%--
									<span class="btn">
										<input type="image" src="<c:url value='/images/oss/btn/search_btn01.gif'/>" alt="검색" onclick="javascript:fn_Search('1')" />
									</span>
								 --%>
			              	</div>
			            </div>
						<!--검색-->


						<p class="search_list_ps title03">베스트 상품 관리 [총 <strong>${totalCnt}</strong>건]</p> <!--리스트 검색 건수-->
						<div class="list">

						<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
							<thead>
								<tr>
									<th>순번</th>
									<th>업체명</th>
									<th>상품명</th>									
									<th>상품번호</th>
									<th>프로모션 내용</th>
									<th>등록일시</th>
									<th>표시여부</th>
									<th> </th>
								</tr>
							</thead>
							<tbody>
								<!-- 데이터 없음 -->
								<c:if test="${fn:length(resultList) == 0}">
									<tr>
										<td colspan="7" class="align_ct"><spring:message code="common.nodata.msg" /></td>
									</tr>
								</c:if>
								<c:forEach var="data" items="${resultList}"	varStatus="status">
									<tr >
										<td class="align_ct"><c:out value="${data.printSn}" /></td>
										<td class="align_ct"><c:out value="${data.corpNm}" /></td>
										<td class="align_ct"><c:out value="${data.prdtNm}" /></td>
										<td class="align_ct"><c:out value="${data.prdtNum}" /></td>
										<td class="align_ct"><c:out value="${data.prmtContents}" /></td>
										<td class="align_ct">
											<fmt:parseDate value="${data.regDttm}" var="regDttm" pattern="yyyy-MM-dd" />
											<fmt:formatDate value="${regDttm}" pattern="yyyy-MM-dd" /></td>
										</td>
										<td class="align_ct"><c:out value="${data.printYn}" /></td>
										<td class="align_ct">
											<div class="btn_sty06">
												<span><a href="javascript:fn_Udt('${data.bestprdtNum}')">수정</a></span>
											</div>
											<div class="btn_sty09">
												<span><a href="javascript:fn_Del('${data.bestprdtNum}')">삭제</a></span>
											</div>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>

						</div>
						<p class="list_pageing">
							<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
						</p>
						<ul class="btn_rt01">
							<li class="btn_sty04"><a href="javascript:fn_Ins()">등록</a></li>
						</ul>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
