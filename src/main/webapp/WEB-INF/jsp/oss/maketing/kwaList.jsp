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
	document.frm.action = "<c:url value='/oss/kwaList.do'/>";
	document.frm.submit();
}


function fn_Udt(kwaNum) {
	document.frm.kwaNum.value = kwaNum;
	document.frm.action = "<c:url value='/oss/kwaUdtView.do'/>";
	document.frm.submit();
}




function fn_Ins() {
	document.frm.pageIndex.value = 0;
	document.frm.action = "<c:url value='/oss/kwaInsView.do'/>";
	document.frm.submit();
}


function fn_Del(kwaNum) {
	if(confirm("삭제 하시겠습까?")){
		document.frm.pageIndex.value = 0;
		document.frm.kwaNum.value = kwaNum;
		document.frm.action = "<c:url value='/oss/kwaDel.do'/>";
		document.frm.submit();
	}
}

function fn_SaveExcel(){
	var parameters = $("#frm").serialize();
	frmFileDown.location = "<c:url value='/oss/kwaListExcel.do?"+ parameters +"'/>";

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
		<jsp:include page="/oss/left.do?menu=site&sub=kwa" flush="false"></jsp:include>
		<div id="contents_area">
			<div id="contents_area">
				<div id="contents">
					<form name="frm" method="get" onSubmit="return false;">
						<input type="hidden" id="kwaNum" name="kwaNum" />
						<input type="hidden" id="location" name="location" value="${searchVO.slocation}"/>
						<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}" />

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
			               						<th scope="row">배너 섹션</th>
			               						<td colspan="2">
			               							<select  name="slocation" onchange="fn_Search(1);">
			        									<c:forEach items="${bnCdList}" var="bnCd">
			        										<option value="${bnCd.cdNum}" <c:if test="${bnCd.cdNum eq searchVO.slocation}">selected="true"</c:if>><c:out value="${bnCd.cdNm} (${bnCd.cdNum})" /></option>
			        									</c:forEach>
			        								</select>
			               						</td>
			               						<th scope="row">해시태그 명</th>
			               						<td colspan="2">
			               							<input type="text" id="skwaNm" class="input_text_full" name="skwaNm" value="${searchVO.skwaNm}" title="해시태그명을 입력하세요." />
			               						</td>
			               					</tr>
			     						</tbody>
			               			</table>
			               		</div>
								<span class="btn">
									<input type="image" src="<c:url value='/images/oss/btn/search_btn01.gif'/>" alt="검색" onclick="javascript:fn_Search('1')" />
								</span>
			              	</div>
			            </div>



						<p class="search_list_ps title03">해시태그 광고 관리 [총 <strong>${totalCnt}</strong>건]</p> <!--리스트 검색 건수-->
						<div class="list">

						<table width="100%" border="1" cellspacing="0" cellpadding="0"
							class="table01 list_tb">
							<thead>
								<tr>
									<th>해시태그 명</th>
									<th>적용기간</th>
									<th>등록일</th>
									<th>링크</th>
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
										<td class="align_ct"><c:out value="${data.kwaNm}" /></td>
										<td class="align_ct">
											<fmt:parseDate value="${data.startDttm}" var="startDttm"	pattern="yyyyMMdd" />
											<fmt:parseDate value="${data.endDttm}" var="endDttm" pattern="yyyyMMdd" />
											<fmt:formatDate value="${startDttm}" pattern="yyyy-MM-dd" />
											~
											<fmt:formatDate value="${endDttm}" pattern="yyyy-MM-dd" />

											<c:if test="${nowDate <= data.endDttm }">
												<span class="font03">[진행중]</span>
											</c:if>
											<c:if test="${nowDate > data.endDttm }">
												<span class="font02">[마감]</span>
											</c:if>

										</td>
										<td class="align_ct">
											<fmt:parseDate value="${data.regDttm}" var="regDttm" pattern="yyyy-MM-dd" />
											<fmt:formatDate value="${regDttm}" pattern="yyyy-MM-dd" /></td>
										</td>
										<td class="align_ct">

											<div class="btn_sty06">
												<span>
													<c:if test="${empty data.pcUrl && data.prdtCnt == 0}"><a href="/mw/cerca.do?trova=<c:out value="${data.kwaNm}"/>" target="_blank"></c:if>
													<c:if test="${!empty data.pcUrl }"><a href="${data.pcUrl}" target="_blank"></c:if>
													<c:if test="${empty data.pcUrl && data.prdtCnt != 0}"><a href="/web/kwaSearch.do?kwaNum=<c:out value="${data.kwaNum}"/>" target="_blank"></c:if>
													 PC 화면 </a>
												</span>
											</div>

											<div class="btn_sty06">
												<span>
													<c:if test="${empty data.mobileUrl && data.prdtCnt == 0}"><a href="/mw/cerca.do?trova=<c:out value="${data.kwaNm}"/>" target="_blank"></c:if>
													<c:if test="${!empty data.mobileUrl }"><a href="${data.mobileUrl}" target="_blank"></c:if>
													<c:if test="${empty data.mobileUrl && data.prdtCnt != 0}"><a href="/mw/kwaSearch.do?kwaNum=<c:out value="${data.kwaNum}"/>" target="_blank"></c:if>
													 Mobile 화면 </a>
												</span>
											</div>

										</td>
										<td class="align_ct">
											<div class="btn_sty06">
												<span><a href="javascript:fn_Udt('${data.kwaNum}')">수정</a></span>
											</div>
											<div class="btn_sty09">
												<span><a href="javascript:fn_Del('${data.kwaNum}')">삭제</a></span>
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
							<li class="btn_sty02">
								<a href="javascript:fn_SaveExcel()">엑셀저장</a>
							</li>
						</ul>
						<ul class="btn_rt01">
							<li class="btn_sty04"><a href="javascript:fn_Ins()">등록</a></li>
						</ul>
						
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<iframe name="frmFileDown" style="display:none"></iframe>
</body>
</html>