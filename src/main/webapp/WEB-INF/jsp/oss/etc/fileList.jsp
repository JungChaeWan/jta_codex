<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />

<head>
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>" ></script>

<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">
// 조회 & 페이징
function fn_Search(pageIndex) {
	$("#pageIndex").val(pageIndex);
	var category = $("#category").val();
	var docNm = "";

	if(category == "cm" || category == "cmDtl") {
		docNm = $.trim($("#docNmPrdt").val());
	} else if(category == "cpr") {
		docNm = $.trim($("#docNmCpr").val());
	}
	$("#docNm").val(docNm);

	document.frm.action = "<c:url value='/oss/fileList.do'/>";
	document.frm.submit();
}

function popupUpdate(docId, fileNum, docDiv, fileNm, savePath) {
	$("#docId").val(docId);
	$("#fileNum").val(fileNum);
	$("#docDiv").val(docDiv);
	$("#savePath").val(savePath);
	$("#oldFileNm").html(fileNm);

	$("#fileNm").val($("#fileNm").defaultValue);

	show_popup($("#viewUpdate"));
}

// 파일 수정
function fn_updateFile() {
	if($("#fileNm").val() == "") {
		alert("<spring:message code='info.file.unselect'/>");
		return false;
	}
	if(confirm("<spring:message code='common.update.msg'/>")) {
		var category = $("#category").val();

		if(category == "cpr") {
			var fileNum = $("#fileNum").val();

			if(fileNum == "1") {
				$("#fileNm").attr("name", "businessLicense");
				$("#fileNm").attr("id", "businessLicense");
			} else if(fileNum == "2") {
				$("#fileNm").attr("name", "passbook");
				$("#fileNm").attr("id", "passbook");
			} else if(fileNum == "3") {
				$("#fileNm").attr("name", "businessCard");
				$("#fileNm").attr("id", "businessCard");
			} else if(fileNum == "4") {
				$("#fileNm").attr("name", "salesCard");
				$("#fileNm").attr("id", "salesCard");
			}
		}
		document.frm.action = "<c:url value='/oss/updateFile.do'/>";
		document.frm.submit();
	}
}

// 파일 삭제
function fn_deleteFile(docId, fileNum, docDiv) {
	if(confirm("<spring:message code='common.delete.msg'/>")) {
		$("#docId").val(docId);
		$("#fileNum").val(fileNum);
		$("#docDiv").val(docDiv);

		document.frm.action="<c:url value='/oss/deleteFile.do'/>";
		document.frm.submit();
	}
}

$(function(){
	$("#category").change(function () {
		if($("#category").val() == "cm" || $("#category").val() == "cmDtl") {
			$("#docDiv").val("AD");
			$("#docNm").val("");
		} else {
			$("#docDiv").val("");
		}
		fn_Search(1);
	});

	$("#bbs").change(function () {
		$("#docDiv").val($("#bbs").val());
		fn_Search(1);
	});

	$("#prmt").change(function () {
		$("#docDiv").val($("#prmt").val());
		fn_Search(1);
	});

	$("#cpr").change(function () {
		$("#docDiv").val($("#cpr").val());
		$("#docNmCpr").val("");
		fn_Search(1);
	});

	$("#prdt").change(function () {
		$("#docDiv").val($("#prdt").val());
		$("#docNmPrdt").val("");
		fn_Search(1);
	});

	$("#docNmCpr").keydown(function (key){
		if(key.keyCode == 13) {
			fn_Search(1);
		}
	});

	$("#docNmPrdt").keydown(function (key){
		if(key.keyCode == 13) {
			fn_Search(1);
		}
	});

})

</script>
</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=site" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=site&sub=file" flush="false"></jsp:include>

		<div id="contents_area">
			<form name="frm" method="post" enctype="multipart/form-data" onSubmit="return false;">
				<input type="hidden" name="pageIndex" id="pageIndex" value="1"/>
				<input type="hidden" name="docId" id="docId" value="" />
				<input type="hidden" name="docDiv" id="docDiv" value="${searchVO.docDiv}" />
				<input type="hidden" name="docNm" id="docNm" />
				<input type="hidden" name="fileNum" id="fileNum" value="" />
				<input type="hidden" name="savePath" id="savePath" value="" />

				<div id="contents">
					<h4 class="title03">파일 관리</h4>
					<div class="search_box">
						<div class="search_form" style="text-align:left;">
							<select name="category" id="category">
								<option value="bbs" <c:if test="${searchVO.category == 'bbs'}">selected="selected"</c:if>>게시판</option>
								<option value="prmt" <c:if test="${searchVO.category == 'prmt'}">selected="selected"</c:if>>프로모션</option>
								<option value="uepi" <c:if test="${searchVO.category == 'uepi'}">selected="selected"</c:if>>이용후기</option>
								<option value="cpr" <c:if test="${searchVO.category == 'cpr'}">selected="selected"</c:if>>입점신청</option>
								<option value="cm" <c:if test="${searchVO.category == 'cm'}">selected="selected"</c:if>>상품목록</option>
								<option value="cmDtl" <c:if test="${searchVO.category == 'cmDtl'}">selected="selected"</c:if>>상품상세</option>
							</select>
							<c:if test="${(empty searchVO.category) or (searchVO.category == 'bbs')}">
								<select name="bbs" id="bbs">
									<option value="" <c:if test="${searchVO.docDiv == ''}">selected="selected"</c:if>>전체</option>
									<option value="FNREQ" <c:if test="${searchVO.docDiv == 'FNREQ'}">selected="selected"</c:if>>기능개선요청</option>
									<option value="GRACOM" <c:if test="${searchVO.docDiv == 'GRACOM'}">selected="selected"</c:if>>참여업체</option>
									<option value="MASNOTI" <c:if test="${searchVO.docDiv == 'MASNOTI'}">selected="selected"</c:if>>업체 공지사항</option>
									<option value="MASQA" <c:if test="${searchVO.docDiv == 'MASQA'}">selected="selected"</c:if>>업체 Q&A게시판</option>
									<option value="NEWS" <c:if test="${searchVO.docDiv == 'NEWS'}">selected="selected"</c:if>>보도자료</option>
									<option value="NOTICE" <c:if test="${searchVO.docDiv == 'NOTICE'}">selected="selected"</c:if>>공지사항</option>
									<option value="QA" <c:if test="${searchVO.docDiv == 'QA'}">selected="selected"</c:if>>자주묻는질문</option>
								</select>
							</c:if>
							<c:if test="${searchVO.category == 'prmt'}">
								<select name="prmt" id="prmt">
									<option value="" <c:if test="${searchVO.docDiv == ''}">selected="selected"</c:if>>전체</option>
									<option value="EVNT" <c:if test="${searchVO.docDiv == 'EVNT'}">selected="selected"</c:if>>이벤트</option>
									<option value="PLAN" <c:if test="${searchVO.docDiv == 'PLAN'}">selected="selected"</c:if>>기획전</option>
									<option value="FROM" <c:if test="${searchVO.docDiv == 'FROM'}">selected="selected"</c:if>>특산/기념품</option>
								</select>
							</c:if>
							<c:if test="${searchVO.category == 'cpr'}">
								<select name="cpr" id="cpr">
									<option value="" <c:if test="${searchVO.docDiv == ''}">selected="selected"</c:if>>비승인</option>
									<option value="AD" <c:if test="${searchVO.docDiv == 'AD'}">selected="selected"</c:if>>숙소</option>
									<option value="RC" <c:if test="${searchVO.docDiv == 'RC'}">selected="selected"</c:if>>렌터카</option>
									<option value="SP" <c:if test="${searchVO.docDiv == 'SP'}">selected="selected"</c:if>>소셜</option>
									<option value="SV" <c:if test="${searchVO.docDiv == 'SV'}">selected="selected"</c:if>>특산/기념품</option>
									<option value="AV" <c:if test="${searchVO.docDiv == 'AV'}">selected="selected"</c:if>>항공</option>
									<option value="GL" <c:if test="${searchVO.docDiv == 'GL'}">selected="selected"</c:if>>골프</option>
								</select>

								<input type="text" name="docNmCpr" id="docNmCpr" value="${searchVO.docNm}" style="height:22px; margin-bottom:2px;">
								<div class="btn_sty04"><span><a href="javascript:fn_Search(1);">검색</a></span></div>
							</c:if>
							<c:if test="${(searchVO.category == 'cm') or (searchVO.category == 'cmDtl')}">
								<select name="prdt" id="prdt">
									<option value="AD" <c:if test="${searchVO.docDiv == 'AD'}">selected="selected"</c:if>>숙소</option>
									<option value="RC" <c:if test="${searchVO.docDiv == 'RC'}">selected="selected"</c:if>>렌터카</option>
									<option value="SP" <c:if test="${searchVO.docDiv == 'SP'}">selected="selected"</c:if>>소셜</option>
									<option value="SV" <c:if test="${searchVO.docDiv == 'SV'}">selected="selected"</c:if>>특산/기념품</option>
									<option value="" <c:if test="${searchVO.docDiv == ''}">selected="selected"</c:if>>업체</option>
								</select>

								<input type="text" name="docNmPrdt" id="docNmPrdt" value="${searchVO.docNm}" style="height:22px; margin-bottom:2px;">
								<div class="btn_sty04"><span><a href="javascript:fn_Search(1);">검색</a></span></div>
							</c:if>
						</div>
					</div>

					<p class="search_list_ps">[총 <strong>${totalCnt}</strong>건]</p>
					<div class="list">
						<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
							<thead>
								<tr>
									<th width="100">번호</th>
									<th width="80">구분</th>
									<th width="220">이름</th>
									<th width="90">등록일</th>
									<th width="60">파일번호</th>
									<th width="180">저장경로</th>
									<th>파일명</th>
									<th width="160">기능툴</th>
								</tr>
							</thead>
							<tbody>
							<!-- 데이터 없음 -->
							<c:if test="${fn:length(resultList) == 0}">
								<tr>
									<td colspan="8" class="align_ct">
										<spring:message code="common.nodata.msg" />
									</td>
								</tr>
							</c:if>

							<c:forEach var="fileInfo" items="${resultList}" varStatus="status">
								<tr>
									<td class="align_ct"><c:out value="${fileInfo.docId}" /></td>
									<td class="align_ct">
										<c:out value="${fileInfo.docDiv}" />
									</td>
									<td class="align_lt"><c:out value="${fileInfo.docNm}" /></td>
									<td class="align_ct">
										<fmt:parseDate value="${fileInfo.regDttm}" var="regDttm" pattern="yyyy-MM-dd"/>
										<fmt:formatDate value="${regDttm}" pattern="yyyy-MM-dd"/>
									</td>
									<td class="align_ct">
										<c:out value="${fileInfo.fileNum}" />
									</td>
									<td class="align_lt"><c:out value="${fileInfo.savePath}" /></td>
									<td class="align_lt">
										<c:out value="${fileInfo.saveFileNm}" /><br>
										(<c:out value="${fileInfo.realFileNm}" />)
									</td>
									<td class="align_lt">
										<button type="button" class="btn sm" onclick="window.open('${fileInfo.savePath}${fileInfo.saveFileNm}')">보기</button>
										<button type="button" class="btn blue sm" onclick="popupUpdate('${fileInfo.docId}', '${fileInfo.fileNum}', '${fileInfo.docDiv}', '${fileInfo.realFileNm}', '${fileInfo.savePath}')">수정</button>
										<button type="button" class="btn red sm" onclick="fn_deleteFile('${fileInfo.docId}', '${fileInfo.fileNum}', '${fileInfo.docDiv}')">삭제</button>
									</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
					</div>
					<p class="list_pageing"><ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" /></p>
				</div>

				<div id="viewUpdate" class="lay_popup lay_ct" style="display:none;">
					<span class="popup_close"><a href="javascript:void(0)" onclick="close_popup('#viewUpdate')"><img src="/images/oss/btn/close_btn03.gif" alt="닫기"></a></span>
					<ul class="form_area">
						<li>
							<h5 class="title06">파일 수정</h5>
							<table class="table02">
								<colgroup>
									<col width="100">
									<col width="*">
								</colgroup>
								<tr>
									<th>수정전</th>
									<td id="oldFileNm"></td>
								</tr>
								<tr>
									<th>수정후</th>
									<td>
										<input type="file" name="fileNm" id="fileNm">
									</td>
								</tr>
							</table>
						</li>
					</ul>
					<div class="btn_ct01">
						<span class="btn_sty04"><a href="javascript:void(0)" onclick="fn_updateFile()">저장</a></span>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>

<div class="blackBg"></div>

</body>
</html>