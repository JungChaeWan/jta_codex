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

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>

<script type="text/javascript">

function fn_DownloadFile(Id) {
	frmFileDown.location = "<c:url value='/mas/prmt/promotionFileDown.do'/>?prmtFileNum=" + Id;
}

function fn_PromotionList() {
	document.frm.action ="<c:url value='/mas/prmt/promotionList.do'/>";
	document.frm.submit();
}

</script>
</head>
<body>
<div id="wrapper">
	<jsp:include page="/mas/head.do?menu=promotion" />
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area">
			<!--본문-->
			<!--상품 등록-->
			<div id="contents">
				<h4 class="title03">프로모션</h4>

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
						<th>구분<span class="font_red">*</span></th>
						<td colspan="3">${prmtVO.prmtDivNm}</td>
					</tr>
					<tr>
						<th>프로모션명</th>
						<td colspan="3">${prmtVO.prmtNm}</td>
					</tr>
					<tr>
						<th>프로모션 내용</th>
						<td colspan="3" style="white-space:pre-wrap;"><c:out value="${prmtVO.prmtExp}" escapeXml="false" /></td>
					</tr>
					<tr>
						<th>시작일</th>
						<td><c:out value="${fn:substring(prmtVO.startDt,0,4)}-${fn:substring(prmtVO.startDt,4,6)}-${fn:substring(prmtVO.startDt,6,8)}" /></td>
						<th>종료일</th>
						<td><c:out value="${fn:substring(prmtVO.endDt,0,4)}-${fn:substring(prmtVO.endDt,4,6)}-${fn:substring(prmtVO.endDt,6,8)}" /></td>
					</tr>
					<%-- <tr>
						<th>목록이미지</th>
						<td colspan="3">
							<c:out value="${prmtVO.listImg}" />
							<div class="btn_sty06">
								<span><a href="${prmtVO.listImg}" target="_blank">상세보기</a></span>
							</div>
						</td>
					</tr> --%>
					<%-- <tr>
						<th>상세이미지</th>
						<td colspan="3">
							<c:out value="${prmtVO.dtlImg}" />
							<c:if test="${not empty fn:trim(prmtVO.dtlImg) }">
							<div class="btn_sty06">
								<span><a href="${prmtVO.dtlImg}" target="_blank">상세보기</a></span>
							</div>
							</c:if>
						</td>
					</tr> --%>
					<%-- <tr>
						<th>모바일이미지</th>
						<td colspan="3">
							<c:out value="${prmtVO.mobileDtlImg}" />
							<div class="btn_sty06">
								<span><a href="${prmtVO.mobileDtlImg}" target="_blank">상세보기</a></span>
							</div>
						</td>
					</tr> --%>
					<tr>
						<th rowspan="2">적용상품</th>
						<td colspan="3">
						<div id="selectProduct">
							<ul>
								<c:forEach  items="${prmtPrdtList}" var="product">
									<li><c:out value="${product.prdtNm}"/></li>
								</c:forEach>
							</ul>
						</div>
						</td>
					</tr>
				</table>

				<c:if test="${fn:length(prmtFileList)>0}">
					<table style="visibility:hidden" border="1" class="table02">
						<colgroup>
	                        <col width="200" />
	                        <col width="*" />
	                        <col width="200" />
	                        <col width="*" />
	                    </colgroup>
						<tr>
							<th>첨부파일</th>
							<td colspan="3">
								<c:forEach var="data" items="${prmtFileList}" varStatus="status">
									<img class="fileIcon" src="/images/web/board/file.jpg" alt="첨부파일">
									<span>${data.realFileNm }</span>
									<div class="btn_sty06">
										<span><a href="javascript:fn_DownloadFile('${data.prmtFileNum}')">다운로드</a></span>
									</div>
									<br>
								</c:forEach>
							</td>
						</tr>
					</table>
				</c:if>

				<ul class="btn_rt01 align_ct">
					<li class="btn_sty01"><a href="javascript:fn_PromotionList()">목록</a></li>
				</ul>

				<c:if test="${not empty apprMsg}">
					<h4 class="title03">전달 사항</h4>
					<table border="1" class="table01">
						<colgroup>
							<col width="*" />
						</colgroup>
						<tr>
							<td><c:out value="${apprMsg}" escapeXml="false"/></td>
						</tr>
					</table>
				</c:if>
			</div>
			<!--//상품등록-->
			<!--//본문-->
		</div>
	</div>
	<!--//Contents 영역-->
</div>
<form name="frm" method="post" onSubmit="return false;">
</form>
<div class="blackBg"></div>
<div id="div_productList" class="lay_popup lay_ct" style="display:none;">
	<span class="popup_close"><a href="javascript:;" onclick="close_popup($('#div_productList'));" title="창닫기"><img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a></span>
	<div id="div_productList_html"></div>
</div>
<iframe name="frmFileDown" style="display:none"></iframe>
</body>
</html>