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
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title>탐나오</title>
<script type="text/javascript">

function fn_ListCorpPnsReq() {
	document.frm.action= "<c:url value='/oss/corpPnsReqList.do'/>";
	document.frm.submit();
}

function fn_updateCorpPnsReq() {
	document.CORP_PNSREQVO.action="<c:url value='/oss/updateCorpPnsRequest.do'/>";
	document.CORP_PNSREQVO.submit();
}

// 파일 삭제
function fn_deleteFile(docId, fileNum) {
	if(confirm("<spring:message code='common.delete.msg'/>")) {
		var parameters = "docId=" + docId + "&fileNum=" + fileNum;

		$.ajax({
			type:"post",
			dataType:"json",
			url:"<c:url value='/oss/deleteCorpPnsRequestFile.ajax'/>",
			data:parameters,
			success:function(data){
				if(data.result == "success") {
					alert("<spring:message code='success.common.delete' />");
					$("#divFile" + fileNum).hide();
					$("#divInputFile" + fileNum).show();
				} else {
					alert("<spring:message code='fail.common.delete' />");
				}
			},
			error:fn_AjaxError
		});
	}
}

$(document).ready(function(){

});

</script>
</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/oss/head.do?menu=corp" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=corp&sub=corpapp" flush="false"></jsp:include>
		<div id="contents_area"> 
			<!--본문-->
			<div id="contents">
				<form name="frm" method="post">
					<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}"/>
					<input type="hidden" name="sCorpCd" id="sCorpCd" value="${searchVO.sCorpCd}"/>
					<input type="hidden" name="sStatusCd" id="sStatusCd" value="${searchVO.sStatusCd}"/>
					<input type="hidden" name="sStartDt" id="sStartDt" value="${searchVO.sStartDt}"/>
					<input type="hidden" name="sEndDt" id="sEndDt" value="${searchVO.sEndDt}"/>
					<input type="hidden" name="sCorpNm" id="sCorpNm" value="${searchVO.sCorpNm}"/>
				</form>
				<form:form commandName="CORP_PNSREQVO" name="CORP_PNSREQVO" method="post" enctype="multipart/form-data">
					<form:hidden path="requestNum" value="${result.requestNum}" />
					<!-- 업체 기본 정보 -->
					<h4 class="title03 margin-top25">업체 기본정보</h4>
					<table border="1" class="table02">
						<colgroup>
							<col width="15%" />
							<col width="35%" />
							<col width="15%" />
							<col width="35%" />
						</colgroup>
						<tr>
							<th scope="row">업체명</th>
							<td colspan="3"><c:out value="${result.corpNm}" /></td>
						</tr>
						<tr>
							<th scope="row">사업자등록번호</th>
							<td><c:out value="${result.coRegNum}" /></td>
							<th scope="row">회사유형</th>
							<td>
								<c:choose>
									<c:when test="${result.corpType eq Constant.CORP_TYPE_CORP}">법인</c:when>
									<c:when test="${result.corpType eq Constant.CORP_TYPE_INDI}">개인</c:when>
									<c:when test="${result.corpType eq Constant.CORP_TYPE_SIMP}">간이</c:when>
								</c:choose>
							</td>
						</tr>
						<tr>
							<th scope="row">전화번호</th>
							<td>
								<form:input path="rsvTelNum" type="text" class="input_text20" onkeyup="addHyphenToPhone(this);" value="${result.rsvTelNum}"/>
							</td>
							<th scope="row">팩스번호</th>
							<td>
								<form:input path="faxNum" type="text" class="input_text20" onkeyup="addHyphenToPhone(this);" value="${result.faxNum}" />
							</td>
						</tr>
						<tr>
							<th scope="row">업체홈페이지</th>
							<td>
								<form:input path="hmpgAddr" type="text" class="input_text20" value="${result.hmpgAddr}" />
							</td>
							<th scope="row">협회소속분과</th>
							<td>
								<form:input path="branchNm" type="text" class="input_text20" value="${result.branchNm}" />
							</td>
						</tr>
						<tr>
							<th scope="row">업체주소</th>
							<td colspan="3">
								<form:input path="addr" type="text" class="width30" value="${result.addr}" />
								<form:input path="dtlAddr" type="text" class="width30" value="${result.dtlAddr}" />
							</td>
						</tr>
						<tr>
							<th scope="row">대표자 성명</th>
							<td>
								<form:input path="ceoNm" type="text" class="input_text20" value="${result.ceoNm}" />
							</td>
							<th scope="row">탐나는전</th>
							<td>
								<input id="tamnacardC" type="radio" name="tamnacardMngYn" value="C" <c:if test="${result.tamnacardMngYn eq 'C'}">checked="checked"</c:if>><label for="tamnacardC">가맹점</label>
								<input id="tamnacardN" type="radio" name="tamnacardMngYn" value="N" <c:if test="${result.tamnacardMngYn eq 'N'}">checked="checked"</c:if>><label for="tamnacardN">비가맹점</label>
							</td>
						</tr>
						<tr>
							<th scope="row">업태</th>
							<td>
								<form:input path="bsncon" type="text" class="input_text20" value="${result.bsncon}" />
							</td>
							<th scope="row">업종</th>
							<td>
								<form:input path="bsntyp" type="text" class="input_text20" value="${result.bsntyp}" />
							</td>
						</tr>
						<tr>
							<th scope="row">판매예정상품</th>
							<td colspan="3">
								<form:input path="salePrdtList" type="text" class="input_text20" value="${result.salePrdtList}" />
							</td>
						</tr>
						<tr>
							<th scope="row">예금주명</th>
							<td>
								<form:input path="depositor" type="text" class="input_text20" value="${result.depositor}" />
							</td>
							<th scope="row">계좌은행</th>
							<td>
								<form:input path="bankNm" type="text" class="input_text20" value="${result.bankNm}" />
							</td>
						</tr>
						<tr>
							<th scope="row">계좌번호</th>
							<td colspan="3">
								<form:input path="accNum" type="text" class="input_text20" value="${result.accNum}" />
							</td>
						</tr>
					</table>
					<!--// 업체 기본 정보 -->
					<!-- 담당자 정보 -->
					<h4 class="title03 margin-top25">담당자 정보</h4>
					<table border="1" class="table02">
						<colgroup>
							<col width="15%" />
							<col width="35%" />
							<col width="15%" />
							<col width="35%" />
						</colgroup>
						<tr>
							<th scope="row">담당자 성명</th>
							<td>
								<form:input path="admNm" type="text" class="input_text20" value="${result.admNm}" />
							</td>
							<th scope="row">담당자 email</th>
							<td>
								<form:input path="admEmail" type="text" class="input_text20" value="${result.admEmail}" />
							</td>
						</tr>
						<tr>
							<th scope="row">담당자 휴대전화</th>
							<td>
								<form:input path="admMobile" type="text" class="input_text20" onkeyup="addHyphenToPhone(this);" value="${result.admMobile}" />
							</td>
							<th scope="row">직통전화</th>
							<td>
								<form:input path="admTelnum" type="text" class="input_text20" onkeyup="addHyphenToPhone(this);" value="${result.admTelnum}" />
							</td>
						</tr>
						<tr>
							<th scope="row">소속부서</th>
							<td>
								<form:input path="admDep" type="text" class="input_text20" value="${result.admDep}" />
							</td>
							<th scope="row">직위</th>
							<td>
								<form:input path="admOfcpos" type="text" class="input_text20" value="${result.admOfcpos}" />
							</td>
						</tr>
					</table>
					<!--// 담당자 정보 -->

					<h4 class="title03 margin-top25">입점 서류</h4>
					<table border="1" class="table02">
						<colgroup>
							<col width="15%" />
							<col width="35%" />
							<col width="15%" />
							<col width="35%" />
						</colgroup>
						<c:set var="acceptExt" value="${Constant.FILE_CHECK_EXT}" />
						<tr>
							<th scope="row">사업자등록증</th>
							<td>
								<div id="divFile1" <c:if test="${empty cprfMap['1']}">style="display:none;"</c:if>>
									${cprfMap['1'].realFileNm}
									<button type="button" class="btn sm" onclick="window.open('${cprfMap['1'].savePath}${cprfMap['1'].saveFileNm}')">보기</button>
									<button type="button" class="btn red sm" onclick="fn_deleteFile('${cprfMap['1'].requestNum}', '${cprfMap['1'].fileNum}')">삭제</button>
								</div>
								<div id="divInputFile1" <c:if test="${!empty cprfMap['1']}">style="display:none;"</c:if>>
									<input type="file" name="businessLicense" id="businessLicense" accept="${acceptExt}" class="full" onchange="checkFile(this, '${acceptExt}', 5)" />
								</div>
							</td>
							<th scope="row">통장</th>
							<td>
								<div id="divFile2" <c:if test="${empty cprfMap['2']}">style="display:none;"</c:if>>
									${cprfMap['2'].realFileNm}
									<button type="button" class="btn sm" onclick="window.open('${cprfMap['2'].savePath}${cprfMap['2'].saveFileNm}')">보기</button>
									<button type="button" class="btn red sm" onclick="fn_deleteFile('${cprfMap['2'].requestNum}', '${cprfMap['2'].fileNum}')">삭제</button>
								</div>
								<div id="divInputFile2" <c:if test="${!empty cprfMap['2']}">style="display:none;"</c:if>>
									<input type="file" name="passbook" id="passbook" accept="${acceptExt}" class="full" onchange="checkFile(this, '${acceptExt}', 5)" />
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">영업신고증 및 <br>각종 허가증</th>
							<td>
								<div id="divFile3" <c:if test="${empty cprfMap['3']}">style="display:none;"</c:if>>
									${cprfMap['3'].realFileNm}
									<button type="button" class="btn sm" onclick="window.open('${cprfMap['3'].savePath}${cprfMap['3'].saveFileNm}')">보기</button>
									<button type="button" class="btn red sm" onclick="fn_deleteFile('${cprfMap['3'].requestNum}', '${cprfMap['3'].fileNum}')">삭제</button>
								</div>
								<div id="divInputFile3" <c:if test="${!empty cprfMap['3']}">style="display:none;"</c:if>>
									<input type="file" name="businessCard" id="businessCard" accept="${acceptExt}" class="full" onchange="checkFile(this, '${acceptExt}', 5)" />
								</div>
							</td>
							<th scope="row">통신판매업신고증</th>
							<td>
								<div id="divFile4" <c:if test="${empty cprfMap['4']}">style="display:none;"</c:if>>
									${cprfMap['4'].realFileNm}
									<button type="button" class="btn sm" onclick="window.open('${cprfMap['4'].savePath}${cprfMap['4'].saveFileNm}')">보기</button>
									<button type="button" class="btn red sm" onclick="fn_deleteFile('${cprfMap['4'].requestNum}', '${cprfMap['4'].fileNum}')">삭제</button>
								</div>
								<div id="divInputFile4" <c:if test="${!empty cprfMap['4']}">style="display:none;"</c:if>>
									<input type="file" name="salesCard" id="salesCard" accept="${acceptExt}" class="full" onchange="checkFile(this, '${acceptExt}', 5)" />
								</div>
							</td>
						</tr>
					</table>
					<p class="text-right"><span class="font02">* 등록가능 파일: ${Constant.FILE_CHECK_SIZE}MB 이하의 ${fn:toUpperCase(fn:replace(acceptExt, ".", ""))} 파일</span></p>

					<ul class="btn_rt01">
						<li class="btn_sty02"><a href="javascript:fn_updateCorpPnsReq();">저장</a></li>
						<li class="btn_sty01"><a href="javascript:fn_ListCorpPnsReq()">목록</a></li>
					</ul>
				</form:form>
			</div>
		</div>
	</div>
</div>

</body>
</html>