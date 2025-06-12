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
<script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>

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
function fn_Search(){
	//document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/oss/bannerList.do'/>";
	document.frm.submit();
}


function fn_Udt(bannerNum){
	document.frm.bannerNum.value = bannerNum;
	document.frm.action = "<c:url value='/oss/bannerUdtView.do' />";
	document.frm.submit();
}


function fn_Ins(){
	//document.frm.bannerPos.value = bannerPos;
	document.frm.action = "<c:url value='/oss/bannerInsView.do' />";
	document.frm.submit();
}

function fn_Del(bannerNum){
	if(confirm("삭제 하시겠습니까?")){
		document.frm.bannerNum.value = bannerNum;
		document.frm.action = "<c:url value='/oss/bannerDel.do' />";
		document.frm.submit();
	}
}

function fn_ViewPic(imgPath, bannerPos){
	// var parameters = $("#frm").serialize();
	// var retVal = window.open(imgPath,"viewPic", "width=600, height=400, scrollbars=yes, status=no, toolbar=no;");

	if(bannerPos == 'BN01'){
		//팝업창 크기 조정
		var retVal = window.open(imgPath,"viewPic", "width=600, height=400, scrollbars=yes, status=no, toolbar=no;");
	}/*else if(bannerPos == 'CENTER'){
		var retVal = window.open(imgPath,"viewPic", "width=400, height=300, scrollbars=yes, status=no, toolbar=no;");
	}else if(bannerPos == 'MAIN'){
		var retVal = window.open(imgPath,"viewPic", "width=1920, height=625, scrollbars=yes, status=no, toolbar=no;");
	}else if(bannerPos == 'FOOT1' || bannerPos == 'FOOT2'){
		var retVal = window.open(imgPath,"viewPic", "width=109, height=32, scrollbars=yes, status=no, toolbar=no;");
	}*/else{
		var retVal = window.open(imgPath,"viewPic", "width=600, height=400, scrollbars=yes, status=no, toolbar=no;");
	}
}

</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=site" />
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=site&sub=banner" />

		<div id="contents_area">
			<div id="contents">
				<form name="frm" method="post" onSubmit="return false;">
					<input type="hidden" name="bannerNum" id="bannerNum" />

					<h4 class="title03">배너/팝업 관리</h4>
					<div class="search_box">
						<div class="search_form">
							<div class="tb_form">
								<table width="100%" border="0">
									<colgroup>
										<col width="120" />
										<col width="*" />
									</colgroup>
									<tbody>
										<tr>
											<th scope="row">배너/팝업 섹션</th>
											<td colspan="5">
												<select name="location" onchange="fn_Search();">
													<c:forEach var="bnCd" items="${bnCdList}">
														<option value="${bnCd.cdNum}" <c:if test="${bnCd.cdNum eq BANNERVO.location}">selected="true"</c:if>><c:out value="${bnCd.cdNm} (${bnCd.cdNum})" /></option>
													</c:forEach>
												</select>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<!--검색-->

					<p class="search_list_ps">
						[총 <strong>${fn:length(resultList)}</strong>건]
						<c:if test="${BANNERVO.location == 'BN04'}"><span class="font01 font_red"> ※ 모바일 메인 팝업은 1개만 열리도록 설정해주세요.</span></c:if>
					</p>
					<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
						<thead>
							<tr>
								<th>번호</th>
								<th>명칭</th>
								<th>적용기간</th>
								<th>이미지</th>
								<th>URL</th>
								<th>새창</th>
								<th>사용여부</th>
								<th>기능</th>
							</tr>
						</thead>
						<tbody>
							<!-- 데이터 없음 -->
							<c:if test="${fn:length(resultList) == 0}">
								<tr>
									<td colspan="8" class="align_ct"><spring:message code="common.nodata.msg" /></td>
								</tr>
							</c:if>
							<c:forEach var="result" items="${resultList}" varStatus="status">
								<tr>
									<td class="align_ct">${result.printSn}</td>
									<td><c:out value="${result.bannerNm}"/></td>
									<td class="align_ct">
										<fmt:parseDate value="${result.startDttm}" var="startDttm"	pattern="yyyyMMdd" />
										<fmt:parseDate value="${result.endDttm}" var="endDttm" pattern="yyyyMMdd" />
										<fmt:formatDate value="${startDttm}" pattern="yyyy-MM-dd" />
										~
										<fmt:formatDate value="${endDttm}" pattern="yyyy-MM-dd" />
									</td>
									<td class="align_ct">
										<c:if test="${not empty result.imgFileNm}">
											<button type="button" class="btn sm " onclick="fn_ViewPic('<c:url value='${result.imgPath}'/>${result.imgFileNm}', '${result.location}')">보기</button>
										</c:if>
									</td>
									<td>
										<a href="${result.url}" target="_blank">
											<c:out value="${result.url}"/>
										</a>
									</td>
									<td class="align_ct">
										<c:if test="${result.nwd == 'Y' }">새창</c:if>
										<c:if test="${result.nwd != 'Y' }">같은창</c:if>
									</td>
									<td class="align_ct">
										<c:if test="${result.printYn == 'Y' }">사용</c:if>
										<c:if test="${result.printYn != 'Y' }">미사용</c:if>
									</td>
									<td class="align_ct">
										<div class="btn_sty06"><span><a href="javascript:fn_Udt('${result.bannerNum}')">수정</a></span></div>
										<div class="btn_sty09"><span><a href="javascript:fn_Del('${result.bannerNum}')">삭제</a></span></div>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</form>

				<ul class="btn_rt01">
					<li class="btn_sty01"><a href="javascript:fn_Ins();">등록</a></li>
				</ul>
			</div>
		</div>
	</div>
</div>


</body>
</html>