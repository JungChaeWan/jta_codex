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

<meta charset="utf-8">
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
	document.frm.action = "<c:url value='/oss/corpPartnerList.do'/>";
	document.frm.submit();
}

function fn_limitPointSet(xCorpId){
	const parameters = "corpId="+xCorpId+"&limitPoint="+$("#limitPoint"+xCorpId).val();
	$.ajax({
		type:"post",
		dataType: "json",
		url:"<c:url value='/oss/corpPointLimitSet.ajax'/>",
		data:parameters,
		success:function(data){
			if(data.success == "Y"){
				alert("한도 Point가 설정 완료 되었습니다.");
				return;
			}else{
				alert("오류가 발생 하였습니다." + data.success );
				return;
			}
		}
	});
}

$(document).ready(function(){

	$(".btnReg").click(function (){
		const xCorpId = $(this).data("corpid");
		let xRegYn = $(this).data("regyn");

		//등록 유무 toggle
		if ( xRegYn == "Y" ) {
			xRegYn = "N";
			$(this).data("regyn", "N");
		}else{
			xRegYn = "Y";
			$(this).data("regyn", "Y");
		}
		const parameters = "corpId="+xCorpId+"&regYn="+xRegYn;
		$.ajax({
			type:"post",
			dataType: "json",
			url:"<c:url value='/oss/corpPartnerReg.ajax'/>",
			data:parameters,
			success:function(data){
				if(data.success == "Y"){
					alert("상태 변경 완료 하였습니다.");
					//버튼 변경
					if (data.regYn == "Y") {
						$("#btnReg"+data.corpId).attr("class", "btn_sty04");
					}else{
						$("#btnReg"+data.corpId).attr("class", "btn_sty02");
					}
					return;
				}else{
					alert("오류가 발생 하였습니다." + data.success );
					return;
				}
			}
		});

	});
});

//판매업체 전체 등록/해제 Pop
function fn_CorpPartnerRegAllPop(){
	$.ajax({
		type:"post",
		url:"<c:url value='/oss/corpPartnerRegAllPop.ajax'/>",
		success:function(data){
			$("#corpPartnerRegAllPop").html(data);
			show_popup($("#corpPartnerRegAllPop"));
		}
	});
}
</script>
</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=corp" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area">
			<form name="frm" id="frm" method="post" onSubmit="return false;">
<%--				<input type="hidden" name="corpId" id="corpId" />--%>
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
											<th scope="row">업체아이디</th>
											<td><input type="text" name="sCorpId" id="sCorpId" class="input_text_full" value="${searchVO.sCorpId}" title="검색하실 업체아이디를 입력하세요." /></td>
										</tr>
										<tr>
											<th scope="row">업체명</th>
											<td colspan="3"><input type="text" name="sCorpNm" id="sCorpNm" class="input_text_full" value="${searchVO.sCorpNm}" title="검색하실 업체명을 입력하세요." /></td>
										</tr>
									</tbody>
								</table>
							</div>
							<span class="btn">
								<input type="image" src="/images/oss/btn/search_btn01.gif" alt="검색" onclick="javascript:fn_Search('1')" />
							</span>
						</div>
					</div>
					<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
						<colgroup>
							<col width="20" />
							<col width="90" />
							<col width="*" />
							<col width="110" />
							<col width="60" />
							<col width="100" />
							<col width="100" />
							<c:if test="${pointCpVO.corpFilterYn eq 'Y'}">
							<col width="100" />
							</c:if>
							<c:if test="${pointCpVO.corpPointLimitYn eq 'Y'}">
							<col width="150" />
							<col width="150" />
							<col width="150" />
							</c:if>
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
								<c:if test="${pointCpVO.corpFilterYn eq 'Y'}">
								<th><a href="javascript:fn_CorpPartnerRegAllPop()">판매업체등록</a></th>
								</c:if>
								<c:if test="${pointCpVO.corpPointLimitYn eq 'Y'}">
								<th>한도Point설정</th>
								<th>사용Point</th>
								<th>잔여Point</th>
								</c:if>
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
<%--								onclick="fn_DtlCorp('${corpInfo.corpId}')"--%>
								<tr style="cursor:pointer;" >
									<td class="align_ct" ><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
									<td class="align_ct"><c:out value="${corpInfo.corpId}"/></td>
									<td class="align_lt"><c:out value="${corpInfo.corpNm}"/></td>
									<td class="align_ct"><c:out value="${corpInfo.corpCdNm}"/></td>
									<td class="align_ct">
										<c:forEach items="${tsCdList}" var="tsCd">
											<c:if test="${tsCd.cdNum eq corpInfo.tradeStatusCd}">${tsCd.cdNm}</c:if>
										</c:forEach>
									</td>
									<td class="align_ct"><c:out value="${corpInfo.ceoNm}"/></td>
									<td class="align_ct"><c:out value="${corpInfo.rsvTelNum}"/></td>
									<c:if test="${pointCpVO.corpFilterYn eq 'Y'}">
									<td class="align_ct">
<%--										onclick="fn_PointCorpIns('${corpInfo.corpId}', '${corpInfo.regYn}');"--%>
										<div id="btnReg${corpInfo.corpId}" class='btnReg btn_sty0<c:if test="${corpInfo.regYn eq 'Y'}">4</c:if><c:if test="${corpInfo.regYn eq 'N'}">2</c:if>' data-corpid="${corpInfo.corpId}" data-regyn="${corpInfo.regYn}">
											<a href="javascript:void(0)" >등록</a>
										</div>
									</td>
									</c:if>
									<c:if test="${pointCpVO.corpPointLimitYn eq 'Y'}">
									<td class="align_ct">
										<input type="text" name="limitPoint" id="limitPoint${corpInfo.corpId}" class="input_text_full" value="${corpInfo.limitPoint}" >
										<div class="btn_sty04">
											<a href="javascript:void(0)" onclick="fn_limitPointSet('${corpInfo.corpId}')" >적용</a>
										</div>
									</td>
									<td class="align_ct"></td>
									<td class="align_ct"></td>
									</c:if>
								</tr>
							</c:forEach>
						</tbody>
					</table>

					<p class="list_pageing">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
					</p>

<%--					<ul class="btn_rt01">--%>
<%--						<li class="btn_sty02"><a href="javascript:fn_SaveExcel()">엑셀저장</a></li>--%>
<%--						<li class="btn_sty01"><a href="javascript:fn_InsCorp()">등록</a></li>--%>
<%--					</ul>--%>
				</div>
			</form>
		</div>
	</div>
</div>
<div class="blackBg"></div>
<div id="corpPartnerRegAllPop" class="lay_popup lay_ct"  style="display:none;"></div>
</body>
</html>