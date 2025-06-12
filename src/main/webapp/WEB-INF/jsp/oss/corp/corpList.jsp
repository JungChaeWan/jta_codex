<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 			uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>

<meta http-equiv="Content-Type" content="text/html" charset="utf-8"/>
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

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
	document.frm.action = "<c:url value='/oss/corpList.do'/>";
	document.frm.submit();
}

/**
 * 업체 정보 상세보기
 */
function fn_DtlCorp(corpId){
	document.frm.corpId.value = corpId;
	document.frm.action = "<c:url value='/oss/detailCorp.do'/>";
	document.frm.submit();
}

function fn_tamnacardMng(corpId,tamnacardType){
	var parameters = {
		"corpId"      : corpId,
		"tamnacardType" : tamnacardType
	};

	if(tamnacardType == "P"){
		window.open("/oss/findAllPrdt.do?sCorpId=" + corpId, + "findAllPrdt", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");
	}

	$.ajax({
		type:"post",
		dataType:"json",
		url:"<c:url value='/oss/updateTamnacardMng.ajax'/>",
		data:parameters,
		success:function(data){
			if(tamnacardType != "P"){
				if(data.resultYn){
					alert("정상적으로 적용되었습니다.");
				}else{
					alert("비정상적인 작동");
				}
			}
		},
		error: function(request, status, error) {
			if(request.status == "500") {
				alert("<spring:message code='fail.common.logout'/>");
				location.reload(true);
			} else {
				alert("<spring:message code='fail.common.msg'/>");
				alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
			}
		}
	});
}

function fn_openPopup(sCorpId, sCorpCd) {
	window.open("<c:url value='/oss/findPrdt.do?sCorpId=" + gubun + "'/>","findAllPrdt", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");
}

/**
 * 업체 추가정보 보기
 */
function fn_CorpDtlInfo(corpId){
	var parameters = "corpId=" + corpId;

	$.ajax({
		type:"post",
		dataType:"json",
		url:"<c:url value='/oss/corpDtlInfoChk.do'/>",
		data:parameters,
		success:function(data){
			if(data.resultChk == "N") {
				alert("업체 추가정보가 등록되지 않았습니다.");
			} else {
				document.frm.corpId.value = corpId;
				document.frm.action = "<c:url value='/oss/corpDtlInfo.do'/>";
				document.frm.submit();
			}
		},
		error: function(request, status, error) {
			if(request.status == "500") {
				alert("<spring:message code='fail.common.logout'/>");
				location.reload(true);
			} else {
				alert("<spring:message code='fail.common.msg'/>");
				alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
			}
		}
	});
}

function fn_InsCorp(){
	document.frm.action = "<c:url value='/oss/viewInsertCorp.do' />";
	document.frm.submit();
}

function fn_SaveExcel(){
	var parameters = $("#frm").serialize();

	frmFileDown.location = "<c:url value='/oss/corpSaveExcel.do?' />" + parameters;
}

function fn_VisitJejuList(page) {
	window.open('/oss/getVisitJejuList.do?page=' + page, 'visitJeju', 'width=1000, height=450, scrollbars=yes, status=no, toolbar=no');
}

$(function(){
	$("select[name=sCorpCd]").change(function() {
		if($(this).val() == "${Constant.SOCIAL}") {
			$("select[name=sCorpSubCd]").show();
		} else {
			$("select[name=sCorpSubCd]").val("");
			$("select[name=sCorpSubCd]").hide();
		}
	});

	$("select[name=sCorpCd]").change();

	// 입점서류
	$("#selFileYn").change(function () {
		if($(this).val() == "") {
			$("#divFileNum").hide();
			$("input[name=sFileNum]").prop("checked", false);
		} else {
			$("#divFileNum").show();
		}
	});

	<c:forEach var="fileNum" items="${searchVO.sFileNum}">
		$("#check" + ${fileNum}).prop("checked", true);
	</c:forEach>
});

</script>
</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=corp" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=corp&sub=corp" flush="false"></jsp:include>
		<div id="contents_area">
			<form name="frm" id="frm" method="post" onSubmit="return false;">
				<input type="hidden" name="corpId" id="corpId" />
				<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}"/>

				<div id="contents">
					<!--검색-->
					<div class="search_box">
						<div class="search_form">
							<div class="tb_form">
								<table width="100%" border="0">
									<colgroup>
										<col width="100" />
										<col width="*" />
										<col width="100" />
										<col width="400" />
									</colgroup>
									<tbody>
										<tr>
											<th scope="row">카테고리</th>
											<td>
												<select name="sCorpCd">
													<option value="">전체</option>
													<c:forEach var="corpCd" items="${corpCdList}">
														<option value="${corpCd.cdNum}" <c:if test="${searchVO.sCorpCd eq corpCd.cdNum}">selected="true"</c:if>><c:out value="${corpCd.cdNm}" /></option>
													</c:forEach>
												</select>
												<select name="sCorpSubCd" style="display: none;">
													<option value="">전체</option>
													<option value="${Constant.SOCIAL_TOUR}" <c:if test="${searchVO.sCorpSubCd eq Constant.SOCIAL_TOUR}">selected="true"</c:if>>여행사</option>
													<option value="${Constant.SOCIAL_TICK}" <c:if test="${searchVO.sCorpSubCd eq Constant.SOCIAL_TICK}">selected="true"</c:if>>관광지/레져</option>
													<option value="${Constant.SOCIAL_FOOD}" <c:if test="${searchVO.sCorpSubCd eq Constant.SOCIAL_FOOD}">selected="true"</c:if>>음식/뷰티</option>
												</select>
											</td>
											<th scope="row">거래상태</th>
											<td>
												<select name="sTradeStatusCd">
													<option value="">전체</option>
													<c:forEach var="tsCd" items="${tsCdList}">
														<c:if test="${tsCd.cdNum ne Constant.TRADE_STATUS_REG}">
															<option value="${tsCd.cdNum}" <c:if test="${searchVO.sTradeStatusCd eq tsCd.cdNum}">selected="true"</c:if>><c:out value="${tsCd.cdNm}" /></option>
														</c:if>
													</c:forEach>
												</select>
											</td>
										</tr>
										<tr>
											<th scope="row">업체명</th>
											<td><input type="text" name="sCorpNm" id="sCorpNm" class="input_text_full" value="${searchVO.sCorpNm}" title="검색하실 업체명을 입력하세요." /></td>
											<th scope="row">업체아이디</th>
											<td><input type="text" name="sCorpId" id="sCorpId" class="input_text_full" value="${searchVO.sCorpId}" title="검색하실 업체아이디를 입력하세요." /></td>
										</tr>
										<tr>
											<th scope="row">회원사</th>
											<td>
												<select name="sAsctMemYn">
													<option value="">전체</option>
													<option value="Y" <c:if test="${searchVO.sAsctMemYn eq 'Y'}">selected="true"</c:if> >회원사</option>
													<option value="N" <c:if test="${searchVO.sAsctMemYn eq 'N'}">selected="true"</c:if> >비회원사</option>
												</select>
											</td>
											<th scope="row">우수관광업체</th>
											<td>
												<select name="sSuperbCorpYn">
													<option value="">전체</option>
													<option value="Y" <c:if test="${searchVO.sSuperbCorpYn eq 'Y'}">selected="true"</c:if> >해당</option>
													<option value="N" <c:if test="${searchVO.sSuperbCorpYn eq 'N'}">selected="true"</c:if> >해당없음</option>
												</select>
											</td>
										</tr>
										<tr>
											<th scope="row">실시간업체</th>
											<td>
<%--												<select name="sCorpLinkYn" id="sCorpLinkYn">--%>
<%--													<option value="">전체</option>--%>
<%--													<option value="Y" <c:if test="${searchVO.sCorpLinkYn eq 'Y'}">selected="true"</c:if> >Y</option>--%>
<%--													<option value="N" <c:if test="${searchVO.sCorpLinkYn eq 'N'}">selected="true"</c:if> >N</option>--%>
<%--												</select>--%>
												<select name="sCorpLinkApi" id="sCorpLinkApi">
													<option value="">전체</option>
													<option value="G" <c:if test="${searchVO.sCorpLinkApi eq 'G'}">selected="true"</c:if> >그림</option>
													<option value="R" <c:if test="${searchVO.sCorpLinkApi eq 'R'}">selected="true"</c:if> >리본</option>
													<option value="I" <c:if test="${searchVO.sCorpLinkApi eq 'I'}">selected="true"</c:if> >인스</option>
													<option value="TLL" <c:if test="${searchVO.sCorpLinkApi eq 'TLL'}">selected="true"</c:if> >TL린칸</option>
												</select>
											</td>
											<th scope="row">입점서류</th>
											<td>
												<select name="sFileYn" id="selFileYn">
													<option value="">전체</option>
													<option value="Y" <c:if test="${searchVO.sFileYn eq 'Y'}">selected="true"</c:if> >제출</option>
													<option value="N" <c:if test="${searchVO.sFileYn eq 'N'}">selected="true"</c:if> >미제출</option>
												</select>
												<div id="divFileNum" <c:if test="${empty searchVO.sFileYn}">style="display:none;"</c:if>>
													<label class="lb"><input type="checkbox" name="sFileNum" id="check1" value="1" />사업자등록증</label>
													<label class="lb"><input type="checkbox" name="sFileNum" id="check2" value="2" />통장</label>
													<label class="lb"><input type="checkbox" name="sFileNum" id="check3" value="3" />영업신고증</label>
													<label class="lb"><input type="checkbox" name="sFileNum" id="check4" value="4" />통신판매업신고증</label>
												</div>
											</td>
										</tr>
										<tr>
											<th scope="row">VISIT제주연계</th>
											<td>
												<select name="sVisitMappingYn">
													<option value="">전체</option>
													<option value="Y" <c:if test="${searchVO.sVisitMappingYn eq 'Y'}">selected="true"</c:if> >Y</option>
													<option value="N" <c:if test="${searchVO.sVisitMappingYn eq 'N'}">selected="true"</c:if> >N</option>
												</select>
											</td>
											<th scope="row">탐나는전가맹점</th>
											<td>
												<select name="sTamnacardMngYn">
													<option value="">전체</option>
													<option value="C" <c:if test="${searchVO.sTamnacardMngYn eq 'C'}">selected="true"</c:if> >업체기준</option>
													<option value="P" <c:if test="${searchVO.sTamnacardMngYn eq 'P'}">selected="true"</c:if> >상품기준</option>
													<option value="N" <c:if test="${searchVO.sTamnacardMngYn eq 'N'}">selected="true"</c:if> >N</option>
												</select>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<span class="btn">
								<input type="image" src="/images/oss/btn/search_btn01.gif" alt="검색" onclick="javascript:fn_Search('1')" />
							</span>
						</div>
					</div>
					<p class="search_list_ps title-btn">[총 <strong>${totalCnt}</strong>건]
						<span class="side-wrap">
							<a href="javascript:fn_VisitJejuList(1);" class="btn_sty04">Visit Jeju 컨텐츠 확인</a>
						</span>
						<div id="visitJejuLayer" class="hide"></div>
					</p>
					<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
						<colgroup>
							<col width="20" />
							<col width="90" />
							<col width="*" />
							<col width="110" />
							<col width="60" />
							<col width="100" />
							<col width="100" />
							<col width="70" />
							<col width="70" />
							<col width="60" />
							<col width="60" />
							<col width="130" />
							<col width="80" />
							<col width="150" />
						</colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th>업체아이디</th>
								<th>업체명</th>
								<th>업체분류</th>
								<th>거래상태</th>
								<th>대표자명</th>
								<th>예약전화번호</th>
								<th>VISIT<br>제주연계</th>
								<th>실시간업체</th>
								<th>위도경도</th>
								<th>회원사</th>
								<th>수수료</th>
								<th>등록일시</th>
								<th>탐나는전 관리</th>
							</tr>
						</thead>
						<tbody>
							<!-- 데이터 없음 -->
							<c:if test="${fn:length(resultList) == 0}">
								<tr>
									<td colspan="13" class="align_ct"><spring:message code="common.nodata.msg" /></td>
								</tr>
							</c:if>
							<c:forEach var="corpInfo" items="${resultList}" varStatus="status">
								<tr style="cursor:pointer;">
									<td class="align_ct" onclick="fn_DtlCorp('${corpInfo.corpId}')"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
									<td class="align_ct" onclick="fn_DtlCorp('${corpInfo.corpId}')"><c:out value="${corpInfo.corpId}"/></td>
									<td class="align_lt" onclick="fn_DtlCorp('${corpInfo.corpId}')"><c:out value="${corpInfo.corpNm}"/></td>
									<td class="align_ct" onclick="fn_DtlCorp('${corpInfo.corpId}')"><c:out value="${corpInfo.corpCdNm}"/></td>
									<td class="align_ct" onclick="fn_DtlCorp('${corpInfo.corpId}')">
										<c:forEach items="${tsCdList}" var="tsCd">
											<c:if test="${tsCd.cdNum eq corpInfo.tradeStatusCd}">${tsCd.cdNm}</c:if>
										</c:forEach>
									</td>
									<td class="align_ct" onclick="fn_DtlCorp('${corpInfo.corpId}')"><c:out value="${corpInfo.ceoNm}"/></td>
									<td class="align_ct" onclick="fn_DtlCorp('${corpInfo.corpId}')"><c:out value="${corpInfo.rsvTelNum}"/></td>
									<td class="align_ct" onclick="fn_DtlCorp('${corpInfo.corpId}')">${corpInfo.visitMappingYn}</td>
									<td class="align_ct" onclick="fn_DtlCorp('${corpInfo.corpId}')">${corpInfo.corpLinkYn}</td>
									<td class="align_ct" onclick="fn_DtlCorp('${corpInfo.corpId}')">
										<c:if test="${(not empty corpInfo.lon) and (not empty corpInfo.lat)}">
											<img src="/images/oss/icon/map.jpg" alt="위치" />
										</c:if>
									</td>
									<td class="align_ct" onclick="fn_DtlCorp('${corpInfo.corpId}')">
										<c:if test="${corpInfo.asctMemYn == 'Y'}">회원사</c:if>
										<c:if test="${corpInfo.asctMemYn != 'Y'}">비회원</c:if>
									</td>
									<td class="align_ct" onclick="fn_DtlCorp('${corpInfo.corpId}')">
										<c:forEach items="${cmssList}" var="cmss">
											<c:if test="${cmss.cmssNum eq corpInfo.cmssNum}">${cmss.cmssNm}(${cmss.adjAplPct}%)</c:if>
										</c:forEach>
									</td>
									<td class="align_ct"><c:out value="${corpInfo.frstRegDttm}"/></td>
									<td class="align_ct">
										업체<input type="radio" name="tamnacardMngYn${status.count}" value="C" onclick="fn_tamnacardMng('${corpInfo.corpId}','C')" <c:if test="${corpInfo.tamnacardMngYn=='C'}">checked</c:if>>
										상품<input type="radio" name="tamnacardMngYn${status.count}" value="P" onclick="fn_tamnacardMng('${corpInfo.corpId}','P')" <c:if test="${corpInfo.tamnacardMngYn=='P'}">checked</c:if>>
										N<input type="radio" name="tamnacardMngYn${status.count}" value="N" onclick="fn_tamnacardMng('${corpInfo.corpId}','N')" <c:if test="${corpInfo.tamnacardMngYn=='N'}">checked</c:if>>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>

					<p class="list_pageing">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
					</p>

					<ul class="btn_rt01">
						<li class="btn_sty02"><a href="javascript:fn_SaveExcel()">엑셀저장</a></li>
						<li class="btn_sty01"><a href="javascript:fn_InsCorp()">등록</a></li>
					</ul>
				</div>
			</form>
		</div>
	</div>
</div>

<iframe name="frmFileDown" style="display:none"></iframe>

</body>
</html>