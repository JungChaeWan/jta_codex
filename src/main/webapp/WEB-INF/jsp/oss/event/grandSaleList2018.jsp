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
	document.frm.action = "<c:url value='/oss/event/grandSaleList2018.do'/>";
	document.frm.submit();
}

function fn_ExcelUpload() {
	if ($('#excelFile').val() != '') {		
		if ($('#excelFile').val().indexOf('.xlsx')) {
			document.frm.action = "<c:url value='/oss/event/excelUpload2018.do'/>";
			document.frm.submit();
			
			$('#rsvAvState').html("처리 중 ...");
		}			
		else
			alert('첨부파일을 "파일 형식 > Excel 통합 문서(.xlsx)" 로 변환 후 진행해 주세요.');
		
	} else {
		alert('excel 파일을 확인 하세요.');
		return false;
	}
}

$(document).ready(function(){

});

</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=maketing" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=maketing&sub=grandSale2018" flush="false"></jsp:include>
		<div id="contents_area">
			<div id="contents_area">
				<div id="contents">
					<div id="menu_depth3">
						<ul>
							<li><a class="menu_depth3" href="<c:url value='/oss/event/voucherMng.do'/>">탐나오상품권</a></li>
							<li><a class="menu_depth3" href="<c:url value='/oss/event/pointJoinList2018.do'/>">상품권대상관리</a></li>
							<li><a class="menu_depth3" href="<c:url value='/oss/event/pointList2018.do'/>">상품권현황</a></li>
							<li><a class="menu_depth3" href="<c:url value='/oss/event/grandSaleJoinList2018.do'/>">참여현황</a></li>
							<li class="on"><a class="menu_depth3" href="<c:url value='/oss/event/grandSaleList2018.do'/>">참여업체관리</a></li>
		                </ul>
		            </div>
					<form name="frm" id="frm" method="post" enctype="multipart/form-data" onSubmit="return false;">
						<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}" />

						<div id="contents">
							<h4 class="title03">그랜드 세일 참여 업체 관리</h4>
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
				               						<th scope="row">업&nbsp;체&nbsp;명</th>
        											<td><input type="text" id="sCorpNm" class="input_text_full" name="sCorpNm" value="${searchVO.sCorpNm}" title="검색하실 업체명을 입력하세요." /></td>
				               					</tr>
				     						</tbody>
				               			</table>
				               		</div>
				               		<span class="btn">
										<input type="image" src="<c:url value='/images/oss/btn/search_btn01.gif'/>" alt="검색" onclick="javascript:fn_Search('1')" />
									</span>
			              	</div>
			            </div>
						<!--검색-->


						<p class="search_list_ps title-btn">[총 <strong>${totalCnt}</strong>건] 
							<span class="side-wrap">참여업체 Excel : <input type="file" name="excelFile"  id="excelFile" />
								<span id="rsvAvState"><input type="button" value="업로드" onclick="fn_ExcelUpload();" /></span>
							</span> 
						</p>
						<div class="list">

						<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
							<thead>
								<tr>
									<th>순번</th>
									<th>유형</th>
									<th>구분</th>
									<th>업체명</th>
									<th>업체코드</th>									
									<th>상품코드</th>
									<th>이벤트코드</th>
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
									<tr>
										<td class="align_ct"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
										<td class="align_ct"><c:out value="${data.typeNm}"/></td>
										<td class="align_ct"><c:out value="${data.divNm}"/></td>
										<td><c:out value="${data.corpNm}"/></td>
										<td class="align_ct"><c:out value="${data.corpId}"/></td>
										<td class="align_ct"><c:out value="${data.prdtId}"/></td>
										<td><c:out value="${data.evntId}"/></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>

						</div>
						<p class="list_pageing">
							<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
						</p>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
