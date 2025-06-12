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
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/align_tablesorter.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />

<title></title>
<script type="text/javascript">
function fn_DtlAdjList(){
	document.frm.action = "<c:url value='/mas/adjList.do'/>";
	document.frm.submit();
}

// 정렬 기준
var order;
var direction;
var currentSort;

function fn_SortInfo() {
	order = currentSort[0][0];
	direction = currentSort[0][1];

	if(order == 1) {
		order = "PRDT_NM";
	} else if(order == 2) {
		order = "PRDT_INF";
	} else {
		order = "RSV_NUM";
	}
	if(direction == 1) {
		direction = "DESC";
	} else {
		direction = "ASC";
	}
}

function fn_ExcelDown(){
	fn_SortInfo();

	var parameters = "sAdjDt=${searchVO.sAdjDt}&sCorpId=${searchVO.sCorpId}";
	parameters += "&sOrder=" + order + "&sDirection=" + direction;
	
	frmFileDown.location = "<c:url value='/mas/adjustExcelDown1.do' />?" + parameters;
}

$(document).ready(function(){
	// 테이블 정렬
	var corpCd = "${corpInfo.corpCd}";
	var sortColumn = 0;			// 예약번호 순 - 기본
	if(corpCd == "AD" || corpCd == "RC") {
		sortColumn = 2;			// 상품정보(사용일) 순 - AD,RC
	}

	$(".tableSorter").tablesorter({
		headers: {
			2: {sorter: 'text'},
			3: {sorter: false}, 4: {sorter: false}, 5: {sorter: false}, 6: {sorter: false}, 7: {sorter: false}, 8: {sorter: false}, 9: {sorter: false}, 10: {sorter: false}
		},
		sortList: [[sortColumn,0]]
	}).bind("sortEnd", function (sorter) {
		currentSort = sorter.target.config.sortList;
	});

});

</script>
</head>
<body>
<div id="wrapper">
	<jsp:include page="/mas/head.do?menu=adj" />
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area">
			<div id="contents">
				<div id="menu_depth3">
					<div class="btn_rt01">
						<div class="btn_sty04"><a href="javascript:fn_ExcelDown();">엑셀다운로드</a></div>
						<div class="btn_sty01"><a href="javascript:fn_DtlAdjList();">뒤로</a></div>
					</div>
				</div>
            	<h4 class="title03">정산상세</h4>
            	<form name="frm" method="post">
            		<input type="hidden" name="sAdjDt" id="sAdjDt" value="${searchVO.sAdjDt}" />
                </form>
                <div class="list margin-top5 margin-btm15">
					<table class="table01 list_tb tableSorter">
						<colgroup>
							<col width="120" />
							<col width="*" />
							<col width="*" />
							<col width="140" />
							<col width="100" />
							<col width="120" />
							<col width="100" />
							<col width="120" />
							<col width="120" />
							<col width="120" />
							<col width="120" />
							<col width="80" />
						</colgroup>
						<thead>
							<tr>
								<th>예약번호 <a class="down"><img src="<c:url value="/images/web/air/down.gif"/>" alt="내림"></a> <a class="up"><img src="<c:url value="/images/web/air/up.gif"/>" alt="올림"></a></th>
								<th>상품명 <a class="down"><img src="<c:url value="/images/web/air/down.gif"/>" alt="내림"></a> <a class="up"><img src="<c:url value="/images/web/air/up.gif"/>" alt="올림"></a></th>
								<th>상품정보 <a class="down"><img src="<c:url value="/images/web/air/down.gif"/>" alt="내림"></a> <a class="up"><img src="<c:url value="/images/web/air/up.gif"/>" alt="올림"></a></th>
								<th>예약자</th>
								<th>예약 결과</th>
								<th>판매금액</th>
								<th>L.Point 사용</th>
								<th>취소 수수료</th>
								<th>판매 수수료</th>
								<th>정산 금액</th>
								<th>업체할인지원금</th>
								<th>수수료율</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${fn:length(resultList) == 0}">
								<tr>
									<td colspan="12" class="align_ct"><spring:message code="common.nodata.msg" /></td>
								</tr>
							</c:if>
							<c:forEach var="result" items="${resultList}" varStatus="status">
								<tr>
									<td><strong>${result.rsvNum}</strong></td>
									<td><strong>${result.prdtNm}</strong></td>
									<td>${result.prdtInf}</td>
									<td class="align_ct">${result.rsvNm}</td>
									<td class="align_ct">
										<c:if test="${result.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM}">취소</c:if>
										<c:if test="${result.rsvStatusCd eq Constant.RSV_STATUS_CD_UCOM}">사용완료</c:if>
										<c:if test="${result.rsvStatusCd eq Constant.RSV_STATUS_CD_ECOM}">기간만료</c:if>
										<c:if test="${result.rsvStatusCd eq Constant.RSV_STATUS_CD_SCOM}">부분환불완료</c:if>
									</td>
									<td class="align_rt"><fmt:formatNumber>${result.saleAmt}</fmt:formatNumber>원</td>
									<td class="align_ct">${result.lpointUseFlag}</td>
									<td class="align_rt"><fmt:formatNumber>${result.cmssAmt}</fmt:formatNumber>원</td>

									<td class="align_rt">
										<fmt:formatNumber>${result.saleCmss + result.disCmssAmt + result.pointCmssAmt}</fmt:formatNumber>원
									</td>
									<td class="align_rt font_red">
										<strong>
											<c:if test="${(result.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM) or (result.rsvStatusCd eq Constant.RSV_STATUS_CD_SCOM)}">
												<fmt:formatNumber>${result.disJsYsAmt + result.masJsYsAmt + result.pointJsYsAmt }</fmt:formatNumber>원
											</c:if>
											<c:if test="${(result.rsvStatusCd eq Constant.RSV_STATUS_CD_UCOM) or (result.rsvStatusCd eq Constant.RSV_STATUS_CD_ECOM)}">
												<fmt:formatNumber>${result.disJsYsAmt + result.masJsYsAmt + result.pointJsYsAmt }</fmt:formatNumber>원
											</c:if>
										</strong>
									</td>
									<td class="align_rt">
										<fmt:formatNumber>${result.corpDisAmt}</fmt:formatNumber>원
									</td>
									<td class="align_ct">${result.adjAplPct}%</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>	
				</div>
            </div>
		</div>
	</div>
</div>
<iframe name="frmFileDown" style="display:none"></iframe>
</body>
</html>