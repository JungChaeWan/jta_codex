<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0"%>

<un:useConstants var="Constant" className="common.Constant" />

<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>

<link rel="stylesheet" type="text/css"href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">
/**
 * 조회 & 페이징
 */
function fn_Search(pageIndex) {
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/mas/sv/productList.do'/>";
	document.frm.submit();
}

/**
 * 상품 수정 화면 가기
 */
function fn_UdtPrdt(prdtNum) {
	document.frm.prdtNum.value = prdtNum;
	document.frm.action = "<c:url value='/mas/sv/viewUpdateSv.do'/>";
	document.frm.submit();
}

/**
 * 상품 삭제하기
 */
function fn_DelPrdt(prdtNum) {
	$.ajax({
		url : "<c:url value='/mas/sv/checkExsistPrdt.ajax'/>",
		dataType:"json",
		data : "sPrdtNum=" + prdtNum,
		success: function(data) {
			if(data.chkInt > 0){
				alert("판매되었던 상품은 삭제할 수 없습니다.");
				return;
			}else{
				if(confirm("<spring:message code='common.delete.msg'/>")) {
					document.frm.prdtNum.value = prdtNum;
					document.frm.action = "<c:url value='/mas/sv/deletePrdt.do'/>";
					document.frm.submit();
				}
			}
		},
		error : function(request, status, error) {
			fn_AjaxError(request, status, error);
		}
	});

}

/**
 * 상품 등록 화면 가기
 */
function fn_insertProduct() {

	if("${corpDlvAmtVO.dlvAmt}" == "" ) {
		alert("배송비를 먼저 설정해 주세요.");
		show_popup($('#div_dlvInf'));
		return ;
	}

	document.frm.action = "<c:url value='/mas/sv/viewInsertPrdt.do'/>";
	document.frm.submit();
}

/**
 * 상품 승인취소
 */
function fn_approvalCancel(prdtNum) {
	$.ajax({
		url : "<c:url value='/mas/sv/approvalCancel.ajax'/>",
		data : "prdtNum=" + prdtNum,
		dataType:"json",
		success: function(data) {
			fn_Search(document.frm.pageIndex.value);
		},
		error : fn_AjaxError
	})
}

/**
 * 상품 판매중지
 */
function fn_SaleStop(prdtNum) {
	$.ajax({
		url : "<c:url value='/mas/sv/saleStop.ajax'/>",
		data : "prdtNum=" + prdtNum,
		dataType:"json",
		success: function(data) {
			fn_Search(document.frm.pageIndex.value);
		},
		error : fn_AjaxError
	})
}

/**
 * 상품 판매전환
 */
function fn_SaleStart(prdtNum) {
	$.ajax({
		url : "<c:url value='/mas/sv/saleStart.ajax'/>",
		data : "prdtNum=" + prdtNum,
		dataType:"json",
		success: function(data) {
			fn_Search(document.frm.pageIndex.value);
		},
		error : fn_AjaxError
	})
}

/**
 * 상품 복제하기
 */
function fn_copyProduct(prdtNum) {
	if (window.confirm("해당 상품을 복제하시겠습니까?")) {
		document.frm.prdtNum.value = prdtNum;
		document.frm.action = "<c:url value='/mas/sv/copyProduct.do'/>";
		document.frm.submit();
	}
}

function fn_goPreview(prdtNum, prdtDiv, optCnt) {

	if(optCnt == 0) {
		alert(" 옵션을 등록해 주세요.");
		return ;
	}
	window.open("<c:url value='/mas/preview/svDetailProduct.do?prdtNum="+prdtNum +"'/> ", "_blank");
}

/**
 * 배송비 설정 저장
 */
function fn_SaveCorpDlvAmt() {
	if(isNull($("#dlvAmt").val())) {
		alert("<spring:message code='common.required.msg' arguments='도외배송비'/>");
		$("#dlvAmt").focus();
		return ;
	}
	if(isNull($("#inDlvAmt").val())) {
		alert("<spring:message code='common.required.msg' arguments='도내배송비'/>");
		$("#inDlvAmt").focus();
		return ;
	}
	if(isNull($("#aplAmt").val())) {
		alert("<spring:message code='common.required.msg' arguments='조건부무료'/>");
		$("#aplAmt").focus();
		return ;
	}
	if(!isNumber($("#dlvAmt").val())) {
		alert("기본배송비는 숫자만 입력해 주세요.");
		$("#dlvAmt").focus();
		return ;
	}
	if(!isNumber($("#aplAmt").val())) {
		alert("조건부무료는 숫자만 입력해 주세요.");
		$("#dlvAmt").focus();
		return ;
	}
	$.ajax({
		url : "<c:url value='/mas/sv/saveCorpDlvAmt.ajax'/>",
		data : $("#SV_CORPDLVAMT").serialize(),
		dataTye : "json",
		success : function(data) {
			fn_Search($("#pageIndex").val());
		},
		error : fn_AjaxError
	});
}

$(function() {
	$("#sSaleStartDt").datepicker({
		onClose : function(selectedDate) {
			$("#sSaleEndDt").datepicker("option", "minDate", selectedDate);
		}
	});
	$("#sSaleEndDt").datepicker({
		onClose : function(selectedDate) {
			$("#sSaleStartDt").datepicker("option", "maxDate",selectedDate);
		}
	});
});
</script>

</head>
<body>
	<div id="wrapper">
		<jsp:include page="/mas/head.do?menu=product" />
		<!--Contents 영역-->
		<div id="contents_wrapper">
			<div id="contents_area">
				<form name="frm" method="get" onSubmit="return false;">
					<input type="hidden" id="prdtNum" name="prdtNum" /> 
					<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}" />

					<div id="contents">
						<!--검색-->
		                <div class="search_box">
		                    <div class="search_form">
		                    	<div class="tb_form">
									<table width="100%" border="0">
										<colgroup>
											<col width="55" />
											<col width="*" />
											<col width="100" />
											<col width="*" />
										</colgroup>
		               					<tbody>
		               						<tr>
		          								<th scope="row">상&nbsp;품&nbsp;명</th>
		          								<td><input type="text" id="sPrdtNm" class="input_text13" name="sPrdtNm" value="${searchVO.sPrdtNm}" title="검색하실 상품명를 입력하세요." /></td>
		          								<th scope="row">거래상태</th>
		       									<td>
		       										<select name="sTradeStatus">
		       											<option value="">전체</option>
		       											<c:forEach items="${tsCd}" var="code" varStatus="status">
		       												<option value="${code.cdNum}" <c:if test="${code.cdNum eq searchVO.sTradeStatus}">selected="selected"</c:if>>${code.cdNm}</option>
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
						<p class="search_list_ps title-btn">상품 목록 [총 <strong>${totalCnt}</strong>건]
							<span class="side-wrap">
								 <a class="btn_sty04" href="javascript:show_popup($('#div_dlvInf'));">배송비설정</a>
							</span>
						</p> <!--리스트 검색 건수-->
					 	<div class="list">
							<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
								<thead>
									<tr>
										<th>상품번호</th>
										<th>상품명</th>
										<th>카테고리</th>
										<th>판매기간</th>
										<th>거래상태</th>
										<th>등록일</th>
										<th>관리자툴</th>
									</tr>
								</thead>
								<tbody>
									<!-- 데이터 없음 -->
									<c:if test="${fn:length(resultList) == 0}">
										<tr>
											<td colspan="8" class="align_ct"><spring:message code="common.nodata.msg" /></td>
										</tr>
									</c:if>
									<c:forEach var="prdtInfo" items="${resultList}"	varStatus="status">
										<tr style="cursor: pointer;">
											<td class="align_ct"><c:out value="${prdtInfo.prdtNum}" /></td>
											<td><c:out value="${prdtInfo.prdtNm}"/></td>
											<td class="align_ct"><c:out value="${prdtInfo.ctgrNm}" /> - <c:out value="${prdtInfo.subCtgrNm}" /></td>
											<td class="align_ct"><fmt:parseDate value="${prdtInfo.saleStartDt}" var="saleStartDt"	pattern="yyyyMMdd" />
												<fmt:parseDate value="${prdtInfo.saleEndDt}" var="saleEndDt" pattern="yyyyMMdd" /> <fmt:formatDate value="${saleStartDt}" pattern="yyyy-MM-dd" />~<c:if test="${prdtInfo.saleEndDt ne '99990101'}"><fmt:formatDate value="${saleEndDt}" pattern="yyyy-MM-dd" /></c:if></td>
											<td class="align_ct">
												<c:if test="${Constant.TRADE_STATUS_REG eq prdtInfo.tradeStatus}">
													등록중
												</c:if>
												<c:if test="${Constant.TRADE_STATUS_APPR_REQ eq prdtInfo.tradeStatus}">
													승인요청
												</c:if>
												<c:if test="${Constant.TRADE_STATUS_APPR eq prdtInfo.tradeStatus}">
													승인
												</c:if>
												<c:if test="${Constant.TRADE_STATUS_APPR_REJECT eq prdtInfo.tradeStatus}">
													승인거절
												</c:if>
												<c:if test="${Constant.TRADE_STATUS_STOP eq prdtInfo.tradeStatus}">
													판매중지
												</c:if>
												<c:if test="${Constant.TRADE_STATUS_STOP_REQ eq prdtInfo.tradeStatus}">
													판매중지요청
												</c:if>
												<c:if test="${Constant.TRADE_STATUS_EDIT eq prdtInfo.tradeStatus}">
													수정요청
												</c:if>
											</td>
											<td class="align_ct"><fmt:parseDate value="${prdtInfo.frstRegDttm}" var="frstRegDttm" pattern="yyyy-MM-dd" />
												<fmt:formatDate value="${frstRegDttm}" pattern="yyyy-MM-dd" /></td>
											<td class="align_ct">
													<div class="btn_sty06"><span><a href="javascript:fn_UdtPrdt('${prdtInfo.prdtNum}')">수정</a></span></div>
												<c:if test="${Constant.TRADE_STATUS_REG eq prdtInfo.tradeStatus || Constant.TRADE_STATUS_EDIT eq prdtInfo.tradeStatus}">
													<%-- <div class="btn_sty06"><span><a href="javascript:fn_UdtSocial('${prdtInfo.prdtNum}')">수정</a></span></div>--%>
													<div class="btn_sty09"><span><a href="javascript:fn_DelPrdt('${prdtInfo.prdtNum}')">삭제</a></span></div>
												</c:if>
												<c:if test="${Constant.TRADE_STATUS_APPR_REQ eq prdtInfo.tradeStatus }">
													<%-- <div class="btn_sty06"><span><a href="javascript:fn_UdtSocial('${prdtInfo.prdtNum}')">수정</a></span></div> --%>
													<div class="btn_sty06"><span><a href="javascript:fn_approvalCancel('${prdtInfo.prdtNum}')">요청취소</a></span></div>
												</c:if>
												<c:if test="${Constant.TRADE_STATUS_APPR eq prdtInfo.tradeStatus }">
													<%--<div class="btn_sty06"><span><a href="javascript:fn_detailSocial('${prdtInfo.prdtNum}')">상세</a></span></div> --%>
													<div class="btn_sty06">
														<%-- <span><a href="javascript:fn_SaleStopSocial('${prdtInfo.prdtNum}')">판매중지</a></span> --%>
														<span><a href="javascript:fn_copyProduct('${prdtInfo.prdtNum}');">복제</a></span>
													</div>
												</c:if>
												<c:if test="${Constant.TRADE_STATUS_STOP eq prdtInfo.tradeStatus || Constant.TRADE_STATUS_APPR_REJECT eq prdtInfo.tradeStatus}">
													<%--<div class="btn_sty06"><span><a href="javascript:fn_detailSocial('${prdtInfo.prdtNum}')">상세</a></span></div> --%>
													<div class="btn_sty06">
														<%-- <span><a href="javascript:fn_SaleStartSocial('${prdtInfo.prdtNum}')">판매전환</a></span> --%>
														<span><a href="javascript:fn_copyProduct('${prdtInfo.prdtNum}');">복제</a></span>
													</div>
												</c:if>
												<div class="btn_sty06"><span><a href="javascript:fn_goPreview('${prdtInfo.prdtNum}', '${prdtInfo.optCnt}')">미리보기</a></span></div>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<p class="list_pageing">
							<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
						</p>
						<ul class="btn_rt01">
							<li class="btn_sty04"><a href="javascript:fn_insertProduct()">등록</a></li>
						</ul>
					</div>
				</form>
			</div>
		</div>
	</div>
<div class="blackBg"></div>

<div id="div_dlvInf" class="lay_popup lay_ct"  style="display:none;">
	<span class="popup_close"><a href="javascript:;" onclick="close_popup($('#div_dlvInf'));" title="창닫기"><img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a></span>
	<ul class="form_area">
		<li>
           	<form name="SV_CORPDLVAMT" id="SV_CORPDLVAMT" method="post" onsubmit="return false" >
				<input type="hidden" name="corpId" value="${corpInfo.corpId }" />

			   	<table border="1" cellpadding="0" cellspacing="0" class="table02">
					<caption class="tb02_title">
						배송비 설정<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span>
					</caption>
					<colgroup>
						<col width="33%" />
						<col width="65%" />
					</colgroup>
					<tr>
						<th>도외배송비<span class="font_red">*</span></th>
						<td><input type="text" name="dlvAmt" id="dlvAmt" class="input_text_full"  value="${corpDlvAmtVO.dlvAmt}" maxlength="30" /></td>
					</tr>
					<tr>
						<th>도내배송비<span class="font_red">*</span></th>
						<td><input type="text" name="inDlvAmt" id="inDlvAmt" class="input_text_full"  value="${corpDlvAmtVO.inDlvAmt}" maxlength="30" /></td>
					</tr>
					<tr>
						<th>조건부무료<span class="font_red">*</span></th>
						<td>
							<input type="text" name="aplAmt" id="aplAmt" class="input_text_full"  value="${corpDlvAmtVO.aplAmt}" maxlength="30" />
							<p>이상 구매시 무료</p>
						</td>
					</tr>
				</table>
			</form>
		</li>
	</ul>
	<div class="btn_rt01"><span class="btn_sty04"><a href="javascript:fn_SaveCorpDlvAmt();">저장</a></span></div>
</div>
</body>
</html>