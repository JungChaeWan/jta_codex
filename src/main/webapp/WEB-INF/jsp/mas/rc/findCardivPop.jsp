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
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />

<title></title>
<script type="text/javascript">
/**
 * 조회 & 페이징
 */
function fn_Search(pageIndex){
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/mas/rc/findCardiv.do'/>";
	document.frm.target = "findCardiv";
	window.name = "findCardiv";
	document.frm.submit();
}

function fn_Select(rcCardivNum, prdtNm, cardivExp, maxiNum, makerDiv, carDiv, useFuelDiv){
	window.opener.fn_SelectCardiv(rcCardivNum, prdtNm, cardivExp, maxiNum, makerDiv, carDiv, useFuelDiv);
	// parent.window.fn_SelectUer(userId);
	parent.window.close();
}
</script>

</head>
<body>
<div id="popup_wrapper">
    <div id="popup_contents">
        <!--컨텐츠-->
        <form name="frm" method="post" onSubmit="return false;">
        	<input type="hidden" name="rcCardivNum" id="rcCardivNum" />
			<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}" />
			<!--검색폼-->
			<div class="search_area">
				<div class="search_form" style="padding:0 100px;">
					<table>
						<colgroup>
							<col class="width15" />
							<col class="width30" />
							<col class="width15" />
							<col />
						</colgroup>
						<tr>
							<th>차종</th>
							<td>
								<select name="sCarDiv" id="sCarDiv">
									<option value="">전체</option>
									<c:forEach var="car" items="${carDivCd}" varStatus="status">
										<option value="${car.cdNum}" <c:if test="${car.cdNum == searchVO.sCarDiv}">selected="selected"</c:if>>${car.cdNm}</option>
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
							<th>제조사</th>
							<td>
								<select name="sMakerDiv" id=sMakerDiv">
									<option value="">전체</option>
									<c:forEach var="maker" items="${makerDivCd}" varStatus="status">
										<option value="${maker.cdNum}" <c:if test="${maker.cdNum == searchVO.sMakerDiv}">selected="selected"</c:if>>${maker.cdNm}</option>
									</c:forEach>
								</select>
							</td>
							<th>차량명</th>
							<td>
								<input type="text" name="sPrdtNm" id="sPrdtNm" class="input_text10" value="${searchVO.sPrdtNm}"/>
							</td>
						</tr>
					</table>
					<div class="text-center">
						<input type="image" src="/images/oss/btn/search_btn04.gif" alt="검색" onclick="javascript:fn_Search(1)" />
					</div>
				</div>
			</div>
			<!--//검색폼-->
			<div style="border-bottom:1px solid #d3d2d1; padding-bottom:35px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tbody>
						<tr>
							<td valign="top"><h2 class="title02">검색결과</h2></td>
						</tr>
						<tr>
							<td valign="top" width="43%" style="background-color:#f9f9f9; border:solid 1px #ccc; text-align:center;">
								<div style="height:360px; overflow:auto;">
									<table class="table01 list_tb">
										<colgroup>
											<col class="width15" />
											<col />
											<col class="width15" />
											<col class="width10" />
											<col class="width10" />
											<col class="width10" />
											<col class="width10" />
										</colgroup>
										<tr>
											<!-- <th>사진</th> -->
											<th>코드</th>
											<th>차량명</th>
											<th>차량설명</th>
											<th>제조사</th>
											<th>차종</th>
											<th>연료</th>
											<th>정원</th>
										</tr>
										<!-- 데이터 없음 -->
										<c:if test="${fn:length(resultList) == 0}">
											<tr>
												<td colspan="7"><spring:message code="common.nodata.msg" /></td>
											</tr>
										</c:if>

										<c:forEach var="data" items="${resultList}" varStatus="status">
											<tr style="cursor:pointer;" onclick="fn_Select('${data.rcCardivNum}', '${data.prdtNm}', '${data.cardivExp}', '${data.maxiNum}', '${data.makerDiv}', '${data.carDiv}', '${data.useFuelDiv}')">
												<%-- <td class="align_ct"> <img src="<c:url value='${data.carImg}'/>" style="max-height: 30px;" />  </td> --%>
												<td><c:out value="${data.rcCardivNum}" /></td>
												<td class="align_lt"><c:out value="${data.prdtNm}" /></td>
												<td><c:out value="${data.cardivExp}" /></td>
												<td><c:out value="${data.makerDivNm}" /></td>
												<td><c:out value="${data.carDivNm}" /></td>
												<td><c:out value="${data.useFuelDivNm}" /></td>
												<td><c:out value="${data.maxiNum}" /></td>
											</tr>
										</c:forEach>
									</table>
								</div>
							</td>
						</tr>
					</tbody>
				</table>

				<p class="list_pageing">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
				</p>
			</div>
		</form>
	</div>
</div>
</body>
</html>