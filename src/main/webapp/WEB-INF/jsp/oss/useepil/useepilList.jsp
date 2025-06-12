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
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
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
function fn_Search(pageIndex){
	//alert(document.frm.sBbsNm.value);

	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/oss/useepilList.do'/>";
	document.frm.submit();
}

/**
 * 업체 정보 상세보기
 */
function fn_Dtl(useEpilNum){
	document.frm.useEpilNum.value = useEpilNum;
	document.frm.action = "<c:url value='/oss/detailUseepil.do'/>";
	document.frm.submit();
}


function fn_SaveExcel(){
	var parameters = $("#frm").serialize();
	frmFileDown.location = "<c:url value='/oss/useepilSaveExcel.do?"+ parameters +"'/>";

}

$(document).ready(function() {
	$("#sStartFrstRegDttm").datepicker({
		onClose: function (selectedDate) {
			$("#sEndFrstRegDttm").datepicker("option", "minDate", selectedDate);
		}
	});
	$("#sEndFrstRegDttm").datepicker({
		onClose: function (selectedDate) {
			$("#sStartFrstRegDttm").datepicker("option", "maxDate", selectedDate);
		}
	});

	//상품 선택 시 유형 동적 변경
	$('#sCate').change(function() {
		const selectedValue = $(this).val();

		//초기화
		$('#sReviewType').empty();
		$('#sReviewType').append('<option value="">전체</option>');

		if (selectedValue !== "") {

			const hrkCode = selectedValue + "RV";
			console.log(hrkCode);


			$.ajax({
				url     : "<c:url value='/web/cmm/getReviewType.ajax'/>",
				data    : "hrkCode=" + hrkCode,
				dataType: "json",
				success : function (data) {
					$.each(data.reviewTypeList, function(index, item) {
						$('#sReviewType').append('<option value="' + item.cdNum + '">' + item.cdNm + '</option>');
					});
				},
				error: function(xhr, status, error) {
					console.log("AJAX Error: " + error);
				}
			})
		}
	})
})

</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=community" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=community&sub=useepil" flush="false"></jsp:include>
		<div id="contents_area">
			<form name="frm" id="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="useEpilNum" name="useEpilNum" />
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>

				<div id="contents">
					<!--검색-->
					<div class="search_box">
						<div class="search_form">
							<div class="tb_form">
								<table width="850" border="0">
									<colgroup>
										<col width="55" />
										<col width="300" />
										<col width="55" />
										<col width="*" />
									</colgroup>
									<tbody>
									<tr>
										<th scope="row">작성일자</th>
										<td><input type="text" id="sStartFrstRegDttm" class="input_text4 center" name="sStartFrstRegDttm" value="${searchVO.sStartFrstRegDttm}"  title="작성시작일" /> ~ <input type="text" id="sEndFrstRegDttm" class="input_text4 center" name="sEndFrstRegDttm"  title="작성종료일"   value="${searchVO.sEndFrstRegDttm}"/></td>
										<th scope="row">평점</th>
										<td>
											<select id="sReviewFeedback" name="sReviewFeedback">
												<option value="">전체</option>
												<option value="1" <c:if test="${searchVO.sReviewFeedback == '1'}">selected="selected"</c:if>>긍정리뷰(4점이상)</option>
												<option value="0" <c:if test="${searchVO.sReviewFeedback == '0'}">selected="selected"</c:if>>부정리뷰(2점이하)</option>
											</select>
										</td>
									</tr>
									<tr>
										<th scope="row">업체명</th>
										<td><input type="text" id="sCorpNm" name="sCorpNm" class="input_text15" value="${searchVO.sCorpNm}"/></td>
										<th scope="row">상품명</th>
										<td><input type="text" id="sPrdtNm" name="sPrdtNm" class="input_text15" value="${searchVO.sPrdtNm}"/></td>
									</tr>
									<tr>
										<th scope="row">카테고리</th>
										<td>
											<select id="sCate" name="sCate">
												<option value="">전체</option>
												<option value="AD" <c:if test="${searchVO.sCate == 'AD'}">selected="selected"</c:if>>숙박</option>
												<option value="RC" <c:if test="${searchVO.sCate == 'RC'}">selected="selected"</c:if>>렌트카</option>
												<option value="SP" <c:if test="${searchVO.sCate == 'SP'}">selected="selected"</c:if>>소셜</option>
												<option value="SV" <c:if test="${searchVO.sCate == 'SV'}">selected="selected"</c:if>>특산/기념품</option>
											</select>
										</td>
										<th scope="row">유형</th>
										<td>
											<select id="sReviewType" name="sReviewType">
												<option value="">전체</option>
												<c:forEach items="${cdRvtp}" var="rvtp" varStatus="status">
													<option value="${rvtp.cdNum}"  <c:if test="${rvtp.cdNum eq searchVO.sReviewType}">selected="selected"</c:if>>${rvtp.cdNm }</option>
												</c:forEach>
											</select>
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

	              	<p class="search_list_ps">[총 <strong>${totalCnt}</strong>건]</p>
	                <table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
						<thead>
							<tr>
								<th>No.</th>
								<th>카테고리</th>
								<th>업체</th>
								<th>상품</th>
								<th>제목</th>
		                        <th>평점</th>
		                        <th>댓글</th>
		                        <th>이미지</th>
		                        <th>표시</th>
								<th>작성날짜</th>
		                        <th>수정날짜</th>
							</tr>
						</thead>
						<tbody>
							<!-- 데이터 없음 -->
							<c:if test="${fn:length(resultList) == 0}">
								<tr>
									<td colspan="18" align="center">
										<spring:message code="common.nodata.msg" />
									</td>
								</tr>
							</c:if>
							<c:forEach var="data" items="${resultList}" varStatus="status">
								<tr style="cursor:pointer;" onclick="fn_Dtl('${data.useEpilNum}')">
									<td class="align_ct">${data.useEpilNum}</td>
									<td class="align_ct">${data.cate}</td>
									<td class="align_ct"><c:out value='${data.corpNm}'/> (<c:out value='${data.corpId}'/>)</td>
									<td class="align_ct"><c:out value='${data.prdtNm}'/> (<c:out value='${data.prdtnum}'/>)</td>
									<td class="align_ct"><c:out value='${data.subject}'/></td>
									<td class="align_ct"><c:out value='${data.gpa}'/></td>
									<td class="align_ct"><c:out value='${data.cmtCnt}'/></td>
									<td class="align_ct"><c:out value='${data.imgCnt}'/></td>
									<td class="align_ct">
										<c:if test="${data.printYn=='Y'}">표시</c:if>
										<c:if test="${data.printYn=='N'}"><font color="#980000">차단</font></c:if>
									</td>
									<td class="align_ct"><c:out value='${data.frstRegDttm}'/></td>
									<td class="align_ct"><c:out value='${data.lastModDttm}'/></td>
								</tr>
							</c:forEach>

						</tbody>
					</table>

					<p class="list_pageing">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
					</p>

					<ul class="btn_rt01">
						<li class="btn_sty02">
							<a href="javascript:fn_SaveExcel()">엑셀저장</a>
						</li>
					</ul>

				</div>
			</form>

		</div>
	</div>
</div>
<iframe name="frmFileDown" style="display:none"></iframe>
</body>
</html>