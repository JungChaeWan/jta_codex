<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />

<title></title>
<script type="text/javascript">
/**
 * 조회 & 페이징
 */
function fn_Search(pageIndex){
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/oss/cardivList.do'/>";
	document.frm.submit();
}

function fn_Utd(Id){
	document.frm.rcCardivNum.value = Id;
	document.frm.action = "<c:url value='/oss/cardivUdtView.do'/>";
	document.frm.submit();
}

function fn_Ins(){
	document.frm.action = "<c:url value='/oss/cardivInsView.do' />";
	document.frm.submit();
}

</script>
</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=product" />
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=product&sub=cardiv" />
		<div id="contents_area">
			<form name="frm" id="frm" method="post" onSubmit="return false;">
				<input type="hidden" name="rcCardivNum" id="rcCardivNum" />
				<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}" />

				<div id="contents">
					<!--검색-->
					<div class="search_box">
						<div class="search_form">
							<div class="tb_form">
								<table>
									<colgroup>
										<col class="width10" />
										<col class="width20" />
										<col class="width10" />
										<col class="width20" />
										<col class="width10" />
										<col />
									</colgroup>
									<tr>
										<th>제조사</th>
										<td>
											<select name="sMakerDiv" id=sMakerDiv">
												<option value="">전체</option>
												<c:forEach var="maker" items="${makerDivCd}" varStatus="status">
													<option value="${maker.cdNum}" <c:if test="${maker.cdNum == searchVO.sMakerDiv}">selected="selected"</c:if>>${maker.cdNm}</option>
												</c:forEach>
											</select>
										</td>
										<th>차종</th>
										<td>
											<select name="sCarDiv" id="sCarDiv">
												<option value="">전체</option>
												<c:forEach var="code" items="${carDivCd}" varStatus="status">
													<option value="${code.cdNum}" <c:if test="${code.cdNum == searchVO.sCarDiv}">selected="selected"</c:if>>${code.cdNm}</option>
												</c:forEach>
											</select>
										</td>
										<th>연료</th>
										<td>
											<select name="sUseFuelDiv" id="sUseFuelDiv">
												<option value="">전체</option>
												<c:forEach var="fuel" items="${fuelCd}" varStatus="status">
													<option value="${fuel.cdNum}" <c:if test="${fuel.cdNum == searchVO.sUseFuelDiv}">selected="selected"</c:if>>${fuel.cdNm}</option>
												</c:forEach>
											</select>
										</td>
									</tr>
									<tr>
										<th>차량명</th>
										<td>
											<input type="text" name="sPrdtNm" id="sPrdtNm" class="input_text_full" value="${searchVO.sPrdtNm}" title="차종명 입력" />
										</td>
										<th>차종코드</th>
										<td>
											<input type="text" name="sRcCardivNum" id="sRcCardivNum" class="input_text_full" value="${searchVO.sRcCardivNum}" title="차종코드 입력" />
										</td>
										<th>사용여부</th>
										<td>
											<select name="sUseYn" id=sUseYn">
												<option value="">전체</option>
												<option value="Y" <c:if test="${searchVO.sUseYn=='Y'}">selected="selected"</c:if> >사용</option>
												<option value="N" <c:if test="${searchVO.sUseYn=='N'}">selected="selected"</c:if> >미사용</option>
											</select>
										</td>
									</tr>
								</table>
							</div>
							<span class="btn">
								<input type="image" src="/images/oss/btn/search_btn01.gif" alt="검색" onclick="javascript:fn_Search('1')" />
							</span>
						</div>
					</div>
					<p class="search_list_ps">[총 <strong>${totalCnt}</strong>건]</p>
					<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
						<colgroup>
							<col class="width10" />
							<col class="width10" />
							<col />
							<col class="width10" />
							<col class="width10" />
							<col class="width10" />
							<col class="width10" />
							<col class="width10" />
							<col class="width10" />
						</colgroup>
						<thead>
							<tr>
								<th scope="col">사진</th>
								<th scope="col">코드</th>
								<th scope="col">차량명</th>
								<th scope="col">차량설명</th>
								<th scope="col">제조사</th>
								<th scope="col">정원</th>
								<th scope="col">차종</th>
								<th scope="col">연료</th>
								<th scope="col">사용여부</th>
							</tr>
						</thead>
						<tbody>
							<!-- 데이터 없음 -->
							<c:if test="${fn:length(resultList) == 0}">
								<tr>
									<td colspan="9" class="align_ct"><spring:message code="common.nodata.msg" /></td>
								</tr>
							</c:if>

							<c:forEach var="data" items="${resultList}" varStatus="status">
								<tr style="cursor:pointer;" onclick="fn_Utd('${data.rcCardivNum}')">
									<td class="align_ct">
										<img src="<c:url value='${data.carImg}'/>" style="max-height: 40px;" alt="${data.prdtNm}" />
									</td>
									<td class="align_ct"><c:out value="${data.rcCardivNum}" /></td>
									<td><c:out value="${data.prdtNm}" /></td>
									<td class="align_ct"><c:out value="${data.cardivExp}" /></td>
									<td class="align_ct"><c:out value="${data.makerDivNm}" /></td>
									<td class="align_ct"><c:out value="${data.maxiNum}" /></td>
									<td class="align_ct"><c:out value="${data.carDivNm}" /></td>
									<td class="align_ct"><c:out value="${data.useFuelDivNm}" /></td>
									<td class="align_ct">
										<c:if test="${data.useYn == 'Y'}">O</c:if>
										<c:if test="${data.useYn == 'N'}">X</c:if>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>

					<p class="list_pageing">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
					</p>
					<ul class="btn_rt01">
						<li class="btn_sty01"><a href="javascript:fn_Ins()">등록</a></li>
					</ul>
				</div>
			</form>
		</div>
	</div>
</div>
<iframe name="frmFileDown" style="display:none"></iframe>
</body>
</html>