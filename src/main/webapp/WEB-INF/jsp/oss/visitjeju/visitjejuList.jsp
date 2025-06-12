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
<meta http-equiv="Content-Type" content="text/html" charset="utf-8"/>
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<title>비짓제주 연동</title>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<style>
.ui-autocomplete {
	max-height: 100px;
	overflow-y: auto; /* prevent horizontal scrollbar */
	overflow-x: hidden;
	position: absolute;
	cursor: default;
	z-index: 4000 !important
}
</style>

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" async></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>" async></script>

<script type="text/javascript">
/**
 * 조회 & 페이징
 */
function fn_Search(pageIndex){
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/oss/visitjejuList.do'/>";
	document.frm.submit();
}

function fn_visitjejuMng(corpId, visitjejuType){

	if(visitjejuType == "Y"){
		
	} else if(visitjejuType == "N"){
		window.open("/oss/findVisitjejuPrdt.do?sCorpId=" + corpId, + "findVisitjejuPrdt", "width=1200, height=720, scrollbars=yes, status=no, toolbar=no;");
	} else {
		
	}
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

function fn_visitjejuApiMng(index) {
	var $input = $("#visitNm_" + index);
	var $list = $("<ul>", {
		id: "autocomplete-list-" + index,
		css: {
			position: "absolute",
			border: "1px solid #ccc",
			background: "#fff",
			display: "none",
			maxHeight: "200px",
			overflowY: "auto",
			zIndex: 1000,
			width: 500
		}
	}).insertAfter($input);

	$input.on("input", function() {
		var parameters = "title=" + $input.val();
		var visitJEJU = [];

		$.ajax({
			type: "post",
			dataType: "json",
			async: true,
			url: "<c:url value='/oss/getVisitJeju.ajax'/>",
			data: parameters,
			success: function(data) {
				// 기존 항목 제거
				$list.empty().hide();

				// 데이터 처리
				$.each(data.visitJejuList, function(index, onerow) {
					if (onerow["contentsid"] != null && onerow["contentsid"] != '') {
						var subStr = onerow["title"] + " [" + onerow["address"] + "]";
						visitJEJU.push({ label: subStr, value: onerow["contentsid"] });
					}
				});

				if (visitJEJU.length == 0) {
					visitJEJU.push({ label: '데이터가 없습니다.', value: '0000' });
				}

				// 목록 표시
				$.each(visitJEJU, function(i, item) {
					var $item = $("<li>")
							.text(item.label)
							.css({ cursor: "pointer", padding: "5px" })
							.on("click", function() {
								if (item.value != "0000") {
									$input.val(item.label.substring(0, item.label.indexOf("[", 0)).trim());
									$("#visitMappingId_" + index).val(item.value);
									$("#visitMappingNm_" + index).val($input.val());
								}
								$list.hide(); // 선택 후 목록 숨기기
							});
					$list.append($item);
				});

				// 목록 표시
				if (visitJEJU.length > 0) {
					$list.show();
				}
			}
		});
	});

	// 입력 필드 외부 클릭 시 목록 숨기기
	$(document).on("click", function(event) {
		if (!$(event.target).closest($input).length && !$(event.target).closest($list).length) {
			$list.hide();
		}
	});

	// 블러 이벤트: 콤마 제거
	$input.blur(function() {
		var strVal = this.value;
		if (strVal.substr(strVal.length - 1, strVal.length) == ",") {
			strVal = strVal.substr(0, strVal.length - 1);
			this.value = strVal;
		}
	});
}


function fn_insertVisitjeju(corpId, corpCd, contentsid, contentsnm){
	
	if(contentsid == ""){
		alert("연동상품을 검색해주세요.");
		return;
	}
	
	let parameters = {};
	parameters["corpId"] = corpId;
	parameters["apiCorpYn"] = "Y";
	parameters["corpCd"] = corpCd;
	parameters["contentsid"] = contentsid;
	parameters["contentsnm"] = contentsnm;
	
	$.ajax({
		type:"post",
		dataType:"json",
		url:"<c:url value='/oss/insertVisitjeju.ajax'/>",
		data:parameters,
		success:function(data){
			if(data.resultYn == "Y"){
				alert("정상적으로 적용되었습니다.");
				fn_Search('${searchVO.pageIndex}');
			} else if(data.resultYn == "D"){
				alert("기존에 등록건이 존재 합니다.");
				fn_Search('${searchVO.pageIndex}');
			} else {
				alert("비정상적인 작동");
				fn_Search('${searchVO.pageIndex}');
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

function fn_deleteVisitjeju(corpId, corpCd, contentsid, contentsnm){
	
	if(contentsid == ""){
		alert("연동되어 있지 않습니다.");
		return;
	}
	
	let parameters = {};
	parameters["corpId"] = corpId;
	parameters["apiCorpYn"] = "Y";
	parameters["corpCd"] = corpCd;
	parameters["contentsid"] = contentsid;
	parameters["contentsnm"] = contentsnm;
	
	$.ajax({
		type:"post",
		dataType:"json",
		url:"<c:url value='/oss/deleteVisitjeju.ajax'/>",
		data:parameters,
		success:function(data){
			if(data.resultYn == "Y"){
				alert("정상적으로 적용되었습니다.");
				fn_Search('${searchVO.pageIndex}');
			} else {
				alert("비정상적인 작동");
				fn_Search('${searchVO.pageIndex}');
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

</script>
</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=corp" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=corp&sub=visitjeju" flush="false"></jsp:include>
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
											<th scope="row">업체/상품 확인</th>
											<td>
												<select name="sApiCorpYn" id="sApiCorpYn">
													<option value="">전체</option>
													<option value="Y" <c:if test="${searchVO.sApiCorpYn eq 'Y'}">selected="true"</c:if> >업체</option>
													<option value="N" <c:if test="${searchVO.sApiCorpYn eq 'N'}">selected="true"</c:if> >상품</option>
													<option value="D" <c:if test="${searchVO.sApiCorpYn eq 'D'}">selected="true"</c:if> >중복</option>
												</select>
											</td>
											<th scope="row"></th>
											<td>
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
					<p class="search_list_ps title-btn">[총 <strong>${totalCnt}</strong>건] 숙소 : ${resultTypeCnt.adCnt}, 관광지 : ${resultTypeCnt.spCnt}
						<span class="side-wrap">
							<a href="javascript:fn_VisitJejuList(1);" class="btn_sty04">Visit Jeju 컨텐츠 확인</a>
						</span>
						<div id="visitJejuLayer" class="hide"></div>
					</p>
					<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
						<colgroup>
							<col width="20" />
							<col width="90" />
							<col width="250" />
							<col width="*" />
							<col width="110" />
							<col width="60" />
							<col width="100" />
							<col width="350" />
							<col width="180" />
						</colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th>업체아이디</th>
								<th>업체명</th>
								<th>주소</th>
								<th>업체분류</th>
								<th>거래상태</th>
								<th>등록일시</th>
								<th></th>
								<th>비짓제주연동 </th>
							</tr>
						</thead>
						<tbody>
							<!-- 데이터 없음 -->
							<c:if test="${fn:length(resultList) == 0}">
								<tr>
									<td colspan="8" class="align_ct"><spring:message code="common.nodata.msg" /></td>
								</tr>
							</c:if>
							<c:forEach var="corpInfo" items="${resultList}" varStatus="status">
								<tr style="cursor:pointer;">
									<td class="align_ct"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
									<td class="align_ct"><c:out value="${corpInfo.corpId}"/></td>
									<td class="align_lt"><c:out value="${corpInfo.corpNm}"/></td>
									<td class="align_lt"><c:out value="${corpInfo.roadNmAddr} ${corpInfo.dtlAddr}"/></td>
									<td class="align_ct"><c:out value="${corpInfo.corpCdNm}"/></td>
									<td class="align_ct">
										<c:forEach items="${tsCdList}" var="tsCd">
											<c:if test="${tsCd.cdNum eq corpInfo.tradeStatusCd}">${tsCd.cdNm}</c:if>
										</c:forEach>
									</td>
									<td class="align_ct"><c:out value="${corpInfo.frstRegDttm}"/></td>
									<td>
										<input type="text" name="visitNm_${status.index}" id="visitNm_${status.index}" onkeydown="fn_visitjejuApiMng(${status.index});" value="${corpInfo.contentsnm}" class="ui-autocomplete-input" autocomplete="off"/>
										<input type="hidden" name="visitMappingId_${status.index}" id="visitMappingId_${status.index}" value="${corpInfo.contentsid}" />
										<input type="hidden" name="visitMappingNm_${status.index}" id="visitMappingNm_${status.index}" value="${corpInfo.contentsnm}" />
										<li class="btn_sty01">
											<a onclick="javascript:fn_insertVisitjeju('${corpInfo.corpId}', '${corpInfo.corpCd}', $('#visitMappingId_${status.index}').val(), $('#visitMappingNm_${status.index}').val());">연동</a>
            							</li>
            							<li class="btn_sty01">
											<a onclick="javascript:fn_deleteVisitjeju('${corpInfo.corpId}', '${corpInfo.corpCd}', $('#visitMappingId_${status.index}').val(), $('#visitMappingNm_${status.index}').val());">해제</a>
            							</li>
									</td>
									<td class="align_ct">
										업체<input type="radio" name="visitjejuMngYn${status.count}" value="Y" onclick="fn_visitjejuMng('${corpInfo.corpId}','Y')" <c:if test="${corpInfo.apiCorpYcnt > 0}">checked</c:if>>
										상품<input type="radio" name="visitjejuMngYn${status.count}" value="N" onclick="fn_visitjejuMng('${corpInfo.corpId}','N')" <c:if test="${corpInfo.apiCorpNcnt > 0}">checked</c:if>>
										중복<input type="radio" name="visitjejuMngYn${status.count}" value="D" onclick="fn_visitjejuMng('${corpInfo.corpId}','D')" <c:if test="${(corpInfo.apiCorpYcnt > 0) and (corpInfo.apiCorpNcnt > 0)}">checked</c:if>>
										N<input type="radio" name="visitjejuMngYn${status.count}" value="" onclick="fn_visitjejuMng('${corpInfo.corpId}','')" <c:if test="${(corpInfo.apiCorpYcnt eq null) and (corpInfo.apiCorpNcnt eq null)}">checked</c:if>>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>

					<p class="list_pageing">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
					</p>

					<ul class="btn_rt01">
					</ul>
				</div>
			</form>
		</div>
	</div>
</div>

<iframe name="frmFileDown" style="display:none"></iframe>

</body>
</html>