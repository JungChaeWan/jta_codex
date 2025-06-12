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
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/align_tablesorter.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />

<title></title>
<script type="text/javascript">
/**
 * 정산 특이건처리 팝업창
 */
function fn_Etc(adjDtlNum){
	var parameters = "adjDtlNum=" + adjDtlNum;

	$.ajax({
		type:"post", 
		dataType:"json",
		async:false,
		url:"<c:url value='/oss/adjModInfo.ajax'/>",
		data:parameters ,
		success:function(data){		
			$("#adjDtlNum").val(adjDtlNum);
			$("#adjAplPct").val(data.adjDtlInfVO.adjAplPct);
			$("#modYn").val(data.adjDtlInfVO.modYn);
			$("#modRsn").val(data.adjDtlInfVO.modRsn);
			
			show_popup($("#lay_popup"));
		}
	});
	
	return;
}

function fn_DtlAdjList(){
	document.frm.action = "<c:url value='/oss/dtlAdjList.do'/>";
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
	
	frmFileDown.location = "<c:url value='/oss/adjustExcelDown2.do' />?" + parameters;
}

function fn_AdjMod(){
	var parameters = "adjDtlNum=" + $("#adjDtlNum").val();
	parameters += "&adjAplPct=" + $("#adjAplPct").val();
	parameters += "&modYn=" + $("#modYn").val();
	parameters += "&modRsn=" + $("#modRsn").val();
	parameters += "&adjDt=" + $("#sAdjDt").val();
	parameters += "&corpId=" + $("#sCorpId").val();
	
	$.ajax({
		type:"post", 
		dataType:"json",
		async:false,
		url:"<c:url value='/oss/updateAdjModInfo.ajax'/>",
		data:parameters,
		success:function(data){
			document.frm.action = "<c:url value='/oss/dtlAdjInfList.do'/>";
			document.frm.submit();
		},
		error:fn_AjaxError
	});
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
			3: {sorter: false}, 4: {sorter: false}, 5: {sorter: false}, 6: {sorter: false}, 7: {sorter: false}, 8: {sorter: false}, 9: {sorter: false},
			10: {sorter: false}, 11: {sorter: false}, 12: {sorter: false}, 13: {sorter: false}, 14: {sorter: false}, 15: {sorter: false}
		},
		sortList: [[sortColumn,0]]
	}).bind("sortEnd", function (sorter) {
		currentSort = sorter.target.config.sortList;
	});

});

</script>
</head>
<body>
<div class="blackBg"></div>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=adj" />
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=adjust&sub=adj" />
		
		<div id="contents_area">
			<div id="contents">
				<div id="menu_depth3">
					<div class="btn_rt01">
						<div class="btn_sty04"><a href="javascript:fn_ExcelDown();">엑셀다운로드</a></div>
						<div class="btn_sty01"><a href="javascript:fn_DtlAdjList();">뒤로</a></div>
					</div>
				</div>
            	<h4 class="title03">정산상세 - ${corpInfo.corpNm}</h4>
            	<form name="frm" method="post">
            		<input type="hidden" name="sCorpId" id="sCorpId" value="${searchVO.sCorpId}" />
            		<input type="hidden" name="sAdjDt" id="sAdjDt" value="${searchVO.sAdjDt}" />
            		<input type="hidden" name="sFromYear" id="sFromYear" value="${searchVO.sFromYear}" />
            		<input type="hidden" name="sFromMonth" id="sFromMonth" value="${searchVO.sFromMonth}" />
                </form>
                <div class="list margin-top5 margin-btm15">
					<table class="table01 list_tb tableSorter">
						<colgroup>
							<col width="8%" />
							<col width="13%" />
							<col width="*" />
							<col width="5%" />
							<col width="5%" />
							<col width="5%" />
							<col width="6%" />
							<col width="5%" />
							<col width="5%" />
							<col width="5%" />
							<col width="4%" />
							<col width="4%" />
							<col width="5%" />
							<col width="5%" />
							<col width="5%" />
							<col width="5%" />
						</colgroup>
						<thead>
							<tr>
								<th>예약번호 <a class="down"><img src="<c:url value="/images/web/air/down.gif"/>" alt="내림"></a> <a class="up"><img src="<c:url value="/images/web/air/up.gif"/>" alt="올림"></a></th>
								<th>상품명 <a class="down"><img src="<c:url value="/images/web/air/down.gif"/>" alt="내림"></a> <a class="up"><img src="<c:url value="/images/web/air/up.gif"/>" alt="올림"></a></th>
								<th>상품정보 <a class="down"><img src="<c:url value="/images/web/air/down.gif"/>" alt="내림"></a> <a class="up"><img src="<c:url value="/images/web/air/up.gif"/>" alt="올림"></a></th>
								<th>예약자</th>
								<th>예약 결과</th>
								<th>판매금액</th>
								<th>지원<br>할인금액</th>
								<th>미지원<br>할인금액</th>
								<th>지원<br>포인트금액</th>
								<th>미지원<br>포인트금액</th>
								<th>L.Point<br>사용</th>
								<th>L.Point<br>적립</th>
								<th>취소<br>수수료</th>
								<th>판매<br>수수료</th>
								<th>수수료율</th>
								<th>결제방식</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${fn:length(resultList) == 0}">
								<tr>
									<td colspan="15" class="align_ct"><spring:message code="common.nodata.msg" /></td>
								</tr>
							</c:if>
							<c:forEach var="result" items="${resultList}" varStatus="status">
								<c:if test="${result.adjStatusCd == Constant.ADJ_STATUS_CD_READY}">
									<tr style="cursor:pointer;" onclick="fn_Etc('${result.adjDtlNum}');" <c:if test="${result.modYn == 'Y'}">class="error"</c:if>>
								</c:if>
								<c:if test="${result.adjStatusCd == Constant.ADJ_STATUS_CD_COM}">
									<tr <c:if test="${result.modYn == 'Y'}">class="error"</c:if>>
								</c:if>
									<td class="align_ct"><strong>${result.rsvNum}</strong></td>
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
									<td class="align_rt"><fmt:formatNumber>${result.supportDisAmt}</fmt:formatNumber>원</td>
									<td class="align_rt"><fmt:formatNumber>${result.unsupportedDisAmt}</fmt:formatNumber>원</td>
									<td class="align_rt"><fmt:formatNumber>${result.supportedPointAmt}</fmt:formatNumber>원</td>
									<td class="align_rt"><fmt:formatNumber>${result.unsupportedPointAmt}</fmt:formatNumber>원</td>
									<td class="align_ct">${result.lpointUseFlag}</td>
									<td class="align_ct">${result.lpointSaveFlag}</td>
									<td class="align_rt"><fmt:formatNumber>${result.cmssAmt}</fmt:formatNumber>원</td>
									<td class="align_rt"><fmt:formatNumber>${result.saleCmss}</fmt:formatNumber>원</td>
									<td class="align_rt">${result.adjAplPct}%</td>
									<td class="align_ct">
										<c:if test="${result.payDiv eq Constant.PAY_DIV_LG_CI}">카드결제</c:if>
										<c:if test="${result.payDiv eq Constant.PAY_DIV_LG_HI}">휴대폰결제</c:if>
										<c:if test="${result.payDiv eq Constant.PAY_DIV_LG_TI}">계좌이체</c:if>
										<c:if test="${result.payDiv eq Constant.PAY_DIV_LG_ETI}">계좌이체(에스크로)</c:if>
										<c:if test="${result.payDiv eq Constant.PAY_DIV_LG_MI}">무통장입금</c:if>
										<c:if test="${result.payDiv eq Constant.PAY_DIV_LG_EMI}">무통장입금(에스크로)</c:if>
										<c:if test="${result.payDiv eq Constant.PAY_DIV_LG_KI}">카카오페이</c:if>
										<c:if test="${result.payDiv eq Constant.PAY_DIV_LG_FI}">무료쿠폰결제</c:if>
										<c:if test="${result.payDiv eq Constant.PAY_DIV_LG_LI}">L.Point결제</c:if>
										<c:if test="${result.payDiv eq Constant.PAY_DIV_NV_SI}">스마트스토어</c:if>
										<c:if test="${result.payDiv eq Constant.PAY_DIV_TA_PI}">T.POINT</c:if>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>	
				</div>
            </div>
		</div>
	</div>
</div>
<div id="lay_popup" class="lay_popup lay_ct" style="display:none;"> <!--왼쪽정렬:lay_lt, 오른쪽정렬:lay_rt, 가운데정렬:lay_ct--> 
	<span class="popup_close">
		<a href="javascript:;" onclick="close_popup($('#lay_popup'))" title="창닫기">
		<img src="<c:url value="/images/oss/btn/close_btn03.gif"/>" alt="닫기" /></a>
	</span>
	<ul class="form_area">
		<li>
			<table border="1" class="table02" id="cntLay">
				<caption class="tb01_title">정산수정</caption>
				<colgroup>
				  <col width="170" />
				  <col width="*" />
				</colgroup>
				<tr>
					<th>정산수정건</th>
					<td>
						<input type="hidden" name="adjDtlNum" id="adjDtlNum">
						<select name="modYn" id="modYn">
							<option value="N">정상</option>
							<option value="Y">비정상</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>판매 수수료율</th>
					<td><input type="text" name="adjAplPct" id="adjAplPct" /> %</td>
				</tr>
				<tr>
					<th>수정사유</th>
					<td>
						<textarea name="modRsn" id="modRsn"  cols="15" rows="10" style="width:97%"></textarea>
					</td>
				</tr>
			</table>
      	</li>
	</ul>
	<div class="btn_rt01">
		<span class="btn_sty03" id="btnResist"><a href="javascript:fn_AdjMod()">정산수정</a></span>
	</div>
</div>
<iframe name="frmFileDown" style="display:none"></iframe>
</body>
</html>