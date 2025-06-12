<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="validator" 	uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="un" 			uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />

<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>

<validator:javascript formName="PRMTVO" staticJavascript="false" xhtml="true" cdata="true"/>

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
	document.frm.action = "<c:url value='/oss/eventDtl.do'/>";
	document.frm.submit();
}

function fn_printYnCmtOnchange(obj, cmtSn){
	document.frm.printYn.value = obj.value;
	document.frm.cmtSn.value = cmtSn;
	document.frm.action = "<c:url value='/oss/eventCmtUpdateCPrint.do'/>";
	document.frm.submit();
}

function fn_SaveExcel(){
	frmFileDown.location = "<c:url value='/oss/eventCmtSaveExcel.do'/>" + "?prmtNum=${prmtVO.prmtNum}";
}

function fn_DownloadFile(Id){
	frmFileDown.location = "<c:url value='/oss/eventDtlFileDown.do'/>" + "?prmtFileNum=" + Id;
}

$(document).ready(function(){

});

</script>
</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=site" />
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=site&sub=event" />
		<div id="contents_area">
			<form name="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="pageIndex" name="pageIndex" value="${prmtVO.pageIndex}"/>
				<input type="hidden" id="prmtNum" name="prmtNum" value="${prmtVO.prmtNum}" />
				<input type="hidden" id="printYn" name="printYn" value="0"/>
				<input type="hidden" id="cmtSn" name="cmtSn" value=""/>
				<input type="hidden" name="sPrmtDiv" id="sPrmtDiv" value="${PRMTVO.sPrmtDiv}" />
				<!--본문-->
				<!--상품 등록-->
				<div id="contents">
					<h4 class="title03">프로모션 상세</h4>

					<table border="1" class="table02">
						<colgroup>
							<col width="200" />
							<col width="*" />
							<col width="200" />
							<col width="*" />
						</colgroup>
						<tr>
							<th scope="row">번호</th>
							<td colspan="3">${prmtVO.prmtNum}</td>
						</tr>
						<tr>
							<th>구분</th>
							<td colspan="3">${prmtVO.prmtDivNm}</td>
						</tr>
						<tr>
							<th>프로모션명</th>
							<td colspan="3">${prmtVO.prmtNm}</td>
						</tr>
						<tr>
							<th>시작일</th>
							<td><c:out value="${fn:substring(prmtVO.startDt,0,4)}-${fn:substring(prmtVO.startDt,4,6)}-${fn:substring(prmtVO.startDt,6,8)}" /></td>
							<th>종료일</th>
							<td><c:out value="${fn:substring(prmtVO.endDt,0,4)}-${fn:substring(prmtVO.endDt,4,6)}-${fn:substring(prmtVO.endDt,6,8)}" /></td>
						</tr>
						<tr>
							<th>메인 배너</th>
							<td colspan="3">
								<h4>[PC]</h4>
								<c:out value="${prmtVO.mainImg}" />
								<div class="btn_sty06"><span><a href="${prmtVO.mainImg}" target="_blank">보기</a></span></div>
								<br>
								<h4>[Mobile]</h4>
								<c:out value="${prmtVO.mobileMainImg}" />
								<div class="btn_sty06"><span><a href="${prmtVO.mobileMainImg}" target="_blank">보기</a></span></div>
							</td>
						</tr>
						<tr>
							<th>메인 배경 색상</th>
							<td colspan="3">#${prmtVO.bgColorNum}</td>
						</tr>
						<tr>
							<th>목록 이미지</th>
							<td colspan="3">
								<c:out value="${prmtVO.listImg}" />
								<div class="btn_sty06"><span><a href="${prmtVO.listImg}" target="_blank">보기</a></span></div>
							</td>
						</tr>
						<tr>
							<th>상세 이미지</th>
							<td colspan="3">
								<h4>[PC]</h4>
								<c:out value="${prmtVO.dtlImg}" />
								<div class="btn_sty06"><span><a href="${prmtVO.dtlImg}" target="_blank">보기</a></span></div>

								<c:if test="${not empty prmtVO.mobileDtlImg}">
									<br>
									<h4>[Mobile]</h4>
									<c:out value="${prmtVO.mobileDtlImg}" />
									<div class="btn_sty06"><span><a href="${prmtVO.mobileDtlImg}" target="_blank">보기</a></span></div>
								</c:if>
							</td>
						</tr>
						<tr>
							<th>상세 배경 색상</th>
							<td colspan="3">#${prmtVO.dtlBgColor}</td>
						</tr>
						<tr>
							<th>상세 배경 이미지</th>
							<td colspan="3">
								<h4>[PC]</h4>
								<c:if test="${not empty prmtVO.dtlBgImg }">
									<c:out value="${prmtVO.dtlBgImg}" />
									<div class="btn_sty06"><span><a href="${prmtVO.dtlBgImg}" target="_blank">보기</a></span></div>
								</c:if>

								<c:if test="${not empty prmtVO.mobileDtlBgImg}">
									<br>
									<h4>[Mobile]</h4>
									<c:out value="${prmtVO.mobileDtlBgImg}" />
									<div class="btn_sty06"><span><a href="${prmtVO.mobileDtlBgImg}" target="_blank">보기</a></span></div>
								</c:if>
							</td>
						</tr>
						<tr>
							<th>당첨자 이미지</th>
							<td colspan="3">
								<c:if test="${not empty prmtVO.winsImg}">
									<c:out value="${prmtVO.winsImg}" />
									<div class="btn_sty06"><span><a href="${prmtVO.winsImg}" target="_blank">보기</a></span></div>
								</c:if>
							</td>
						</tr>
						<tr>
							<th>연결 URL<span class="font_red"></span></th>
							<td colspan="3">
								<c:if test="${not empty prmtVO.dtlUrl && not empty prmtVO.dtlUrlMobile}">
									<p>
										<c:if test="${prmtVO.dtlNwdYn == 'Y'}">새창 연결</c:if>
										<c:if test="${prmtVO.dtlNwdYn == 'N'}">같은창 연결</c:if>
									</p>
								</c:if>
								<h4>[PC]</h4>
								<p><c:out value="${prmtVO.dtlUrl}"/></p>
								<br>
								<h4>[Mobile]</h4>
								<p><c:out value="${prmtVO.dtlUrlMobile}"/></p>
							</td>
						</tr>
						<tr>
							<th>관련 상품</th>
							<td colspan="3">
							<div id="selectProduct">
								<ul>
									<c:forEach  items="${prmtPrdtList}" var="product">
										<li>
											<b>[<c:out value="${product.prdtNum}"/>][<c:out value="${product.corpNm}"/>][<c:out value="${product.prdtNm}"/>]</b>
											- ${product.note} | ${plblMap[product.label1]} | ${plblMap[product.label2]} | ${plblMap[product.label3]}
										</li>
									</c:forEach>
								</ul>
							</div>
							</td>
						</tr>
						<tr>
							<th>댓글 사용</th>
							<td colspan="3">
								<c:if test="${prmtVO.cmtYn == 'Y'}">사용</c:if>
								<c:if test="${prmtVO.cmtYn == 'N'}">사용안함</c:if>
							</td>
						</tr>
						<tr>
							<th>Dday 출력</th>
							<td colspan="3">
								<c:if test="${prmtVO.ddayViewYn == 'Y'}">사용</c:if>
								<c:if test="${prmtVO.ddayViewYn == 'N'}">사용안함</c:if>
							</td>
						</tr>
						<tr>
							<th>첨부파일</th>
							<td colspan="3">
								<c:forEach var="data" items="${prmtFileList}" varStatus="status">
									<img class="fileIcon" src="/images/web/board/file.jpg" alt="첨부파일"/>
									<span><a href="javascript:fn_DownloadFile('${data.prmtFileNum}')" title="${data.realFileNm }">(붙임${status.index+1 }) <c:out value="${data.realFileNm }"/> </a></span><br/>
								</c:forEach>
							</td>
						</tr>
					</table>
					<br>
					<h4 class="title03">댓글</h4>
					<table border="1" class="table02">
						<colgroup>
							<col width="200" />
							<col width="*" />
							<col width="200" />
							<col width="*" />
						</colgroup>
						<c:if test="${fn:length(rmtCmtList) == 0}">
							<tr>
								<td colspan="10" class="align_ct">
									댓글이 없습니다.
								</td>
							</tr>
						</c:if>
						<c:forEach var="cmt" items="${rmtCmtList}" varStatus="status">
							<tr>
								<td colspan="4">
									[ID: <c:out value="${cmt.userId}"/> ]
									[E-Mail: <c:out value="${cmt.email}"/> ]
									[시간: <c:out value="${cmt.lastModDttm}"/> ]
									<select onchange="fn_printYnCmtOnchange(this, ${cmt.cmtSn})">
										<option value="Y" <c:if test="${cmt.printYn=='Y'}">selected="selected"</c:if>>표시</option>
										<option value="N" <c:if test="${cmt.printYn=='N'}">selected="selected"</c:if>>차단</option>
									</select>
									<br>
									<c:out value="${cmt.contents}" escapeXml="false"/>
								</td>
							</tr>
						</c:forEach>
					</table>

					<p class="list_pageing">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
					</p>

					<ul class="btn_rt01 align_ct">
						<li class="btn_sty02"><a href="javascript:fn_SaveExcel();">댓글 엑셀저장</a></li>
						<li class="btn_sty01"><a href="javascript:history.back();">목록</a></li>
					</ul>
				</div>
				<!--//상품등록-->
				<!--//본문-->
			</form>
		</div>
	</div>
</div>
<iframe name="frmFileDown" style="display:none"></iframe>
</body>
</html>