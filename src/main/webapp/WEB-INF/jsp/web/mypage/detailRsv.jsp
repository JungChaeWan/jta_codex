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
<meta name="robots" content="noindex, nofollow">
<jsp:include page="/web/includeJs.do" />
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>

<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/sub.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/multiple-select.css?version=${nowDate}'/>" />
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" /> --%>

<c:if test="${recPntYn == 'Y'}">
	<script language='JavaScript' src='https://pgweb.tosspayments.com/WEB_SERVER/js/receipt_link.js'></script>
</c:if>
<title></title>
<script type="text/javascript">
/**
 * DAUM 연동 주소찾기
 */
function openDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            document.getElementById('postNum').value = data.zonecode;
            document.getElementById('roadNmAddr').value = data.address;
            document.getElementById('dtlAddr').focus();
        }
    }).open();
}

/** 상품 단건 취소 */
function fn_ReqCancelPop(prdtRsvNum){
    /** 무통장입금의 입금상태일 경우*/
    if("${rsvInfo.LGD_CASFLAGY}" == "I" || "${rsvInfo.payDiv}" == "${Constant.PAY_DIV_TC_WI}" || "${rsvInfo.payDiv}" == "${Constant.PAY_DIV_TC_MI}"){
        $("#refundItem").val(prdtRsvNum);
        show_popup('#refundPopupArea');
    }else{
		fn_ReqCancelPopProc(prdtRsvNum)
    }
}
/** 상품 단건 취소 */
function fn_ReqCancelPopProc(prdtRsvNum){
	$("#prdtRsvNum").val(prdtRsvNum);
	var parameters = "prdtRsvNum=" + prdtRsvNum;

	$.ajax({
		type:"post",
		dataType:"json",
		// async:false,
		url:"<c:url value='/web/selectByOrder.ajax'/>",
		data:parameters ,
		success:function(data){
			var addHtml = "";
			addHtml += "<tr>";
			addHtml += "	<td>" + data.orderVO.prdtCdNm + "</td>";
			addHtml += "	<td class=\"left\">";
			addHtml += "		<h5 class=\"product\"><span class=\"cProduct\">" + data.orderVO.corpNm + " " + data.orderVO.prdtNm + "</span></h5>";
			addHtml += "		<p class=\"infoText interval\">" + data.orderVO.prdtInf+ "</p>";
			addHtml += "	</td>";
			addHtml += "</tr>";

			$("#cancelTbody").html(addHtml);
			$("#cancelGuide").html(data.orderVO.cancelGuide);

			show_popup('#cancelDiv');
		}
	});
}

function fn_ReqCancel(){
	if (window.confirm("취소 시 철회가 불가능합니다.\n취소/환불 규정을 확인해주세요.\n해당 상품을 취소 하시겠습니까?")){
		var parameters = "prdtRsvNum=" + $("#prdtRsvNum").val();
		parameters += "&cancelRsn=" + $("#cancelRsn").val();
		parameters += "&refundBankCode=" + $("#refundBankCode").val();
		parameters += "&refundAccNum=" + $("#refundAccNum").val();
		parameters += "&refundDepositor=" + $("#refundDepositor").val();
		parameters += "&userId=" + "${rsvInfo.userId}";
		parameters += "&LGD_CASFLAGY=" + "${rsvInfo.LGD_CASFLAGY}";
		/** 단건취소시 전체예약번호는 TB_RSV에 환불계좌등록 후 MODEL에서 삭제*/
		parameters += "&rsvNum=${rsvInfo.rsvNum}";
		parameters += "&payDiv=${rsvInfo.payDiv}";
		if(doubleSubmitFlag) {
			return;
		}
		doubleSubmitCheck();
		$.ajax({
			type:"post",
			dataType:"json",
			// async:false,
			url:"<c:url value='/web/reqCancel.ajax'/>",
			data:parameters ,
			success:function(data){
				if(data.success == "apiFail") {
					alert("취소요청이 실패 하였습니다.\n탐나오고객센터(1522-3454)에 문의 바랍니다.");
					return;
				} else {
					location.reload();
				}
			}
		});
	}
}

function fn_DetailPrdt(prdtNum){

	var code = prdtNum.substring(0,2);
	if(code=='${Constant.RENTCAR}' ){
		location.href = "<c:url value='/web/rentcar/car-detail.do'/>?prdtNum="+prdtNum;
	}else if(code=='${Constant.ACCOMMODATION}'){
		location.href = "<c:url value='/web/ad/detailPrdt.do'/>?sPrdtNum="+prdtNum;
	}else if(code=='${Constant.GOLF}' ){
		location.href = "<c:url value='/web/gl/detailPrdt.do'/>?sPrdtNum="+prdtNum;
	}else if(code=='${Constant.SOCIAL}'){
		location.href = "<c:url value='/web/sp/detailPrdt.do'/>?prdtNum="+prdtNum;
	}else if(code=='${Constant.SV}'){
		location.href = "<c:url value='/web/sv/detailPrdt.do'/>?prdtNum="+prdtNum;
	}

}

/** 상품 전체 취소 */
function fn_ReqCancelPopAll(){
    /** 단건 아이템번호 삭제*/
    $("#refundItem").val("");
    /** 무통장입금의 입금상태일 경우*/
	if("${rsvInfo.LGD_CASFLAGY}" == "I" || "${rsvInfo.payDiv}" == "${Constant.PAY_DIV_TC_WI}" || "${rsvInfo.payDiv}" == "${Constant.PAY_DIV_TC_MI}"){
        show_popup('#refundPopupArea');
    }else{
		show_popup('#cancelAllDiv');
    }
}

function fn_ReqCancelAll(){

	if (window.confirm("해당 예약건을 취소 하시겠습니까?")){
		var parameters = "rsvNum=${rsvInfo.rsvNum}";
		parameters += "&cancelRsn=" + $("#cancelAllRsn").val();
		parameters += "&refundBankCode=" + $("#refundBankCode").val();
		parameters += "&refundAccNum=" + $("#refundAccNum").val();
		parameters += "&refundDepositor=" + $("#refundDepositor").val();
		parameters += "&userId=" + "${rsvInfo.userId}";
		parameters += "&LGD_CASFLAGY=" + "${rsvInfo.LGD_CASFLAGY}";
		parameters += "&payDiv=${rsvInfo.payDiv}";
		if(doubleSubmitFlag) {
			return;
		}
		doubleSubmitCheck();
		$.ajax({
			type:"post",
			dataType:"json",
			// async:false,
			url:"<c:url value='/web/reqCancelAll.ajax'/>",
			data:parameters ,
			success:function(data){
				location.reload();
			}
		});
	}
}

function fn_ChangeDlv() {
	if(isNull($("#useNm").val())){
		alert("이름을 입력해주세요.");
		$("#useNm").focus();
		return;
	}
	if(isNull($("#useTelnum").val())){
		alert("전화번호를 입력해주세요.");
		$("#useTelnum").focus();
		return;
	}

	if(!checkIsHP($("#useTelnum").val())){
		alert("<spring:message code='errors.phone'/>");
		$("#useTelnum").focus();
		return;
	}

	if(isNull($("#postNum").val()) || isNull($("#roadNmAddr").val()) || isNull($("#dtlAddr").val())) {
		alert("배송지 주소를 입력해주세요.");
		$("#dtlAddr").focus();
		return ;
	}

	var parameters = "rsvNum=${rsvInfo.rsvNum}";
	parameters += "&" + $("#f_changeDlv").serialize();
	$.ajax({
		type:"post",
		dataType:"json",
		// async:false,
		url:"<c:url value='/web/changeDlv.ajax'/>",
		data:parameters ,
		success:function(data){
			location.reload();
		}
	});
}

function fn_goDlv(svRsvNum, dlvNum) {
	var parameters = "rsvNum=" + svRsvNum;
	var popup = window.open('about:blank', "_blank");
	$.ajax({
		type:"post",
		dataType:"json",
		// async:false,
		url:"<c:url value='/web/dlvTrace.ajax'/>",
		data:parameters ,
		success:function(data){
			//window.open(data.url + dlvNum, "_blank");
			popup.location= data.url + dlvNum;
		}
	});
}

function fn_OrderCancel(){
	if(doubleSubmitFlag) {
		return;
	}
	doubleSubmitCheck();
	var parameters = "rsvNum=${rsvInfo.rsvNum}";
	$.ajax({
		type:"post",
		dataType:"json",
		// async:false,
		url:"<c:url value='/web/orderCancel.ajax'/>",
		data:parameters ,
		success:function(data){
			if(data.success == "${Constant.FLAG_Y}"){
				alert("자동취소됐습니다.");
				location.reload();
			}else{
				alert(data.rtnMsg);
			}
		}
	});
}

function fn_goComfirmOrder(svRsvNum) {
	var parameters = "svRsvNum=" + svRsvNum;
	$.ajax({
		type:"post",
		dataType:"json",
		// async:false,
		url:"<c:url value='/web/confirmOrder.ajax'/>",
		data:parameters ,
		success:function(data){
			location.reload();
		}
	});
}

let doubleSubmitFlag = false;

function doubleSubmitCheck() {
	if(doubleSubmitFlag) {
		alert("취소중입니다.");
		return doubleSubmitFlag;
	} else {
		doubleSubmitFlag = true;
		return false;
	}
}

function fn_chkLogin() {
	alert('회원은 로그인 후 이용후기를 작성하실 수 있고,\n비회원은 이용후기를 작성할 수 없습니다.');
	return;
}

function fn_updateFile(dtlRsvNum){

    var form = $('#frm'+ dtlRsvNum)[0];
	var data = new FormData(form);

	$.ajax({
		type:"post",
		enctype: 'multipart/form-data',
		url:"<c:url value='/web/mypage/uploadRsvFile.ajax'/>",
		data: data,
		processData: false,
		contentType: false,
		success:function(data){
			if (data.Status == 'success') {
				alert('증빙자료가 제출 되었습니다.');
				location.reload();
			}
		},
		error : fn_AjaxError
	});
}

function fn_rsvFileDelete(xSeq, xSavePath, xSaveFileNm){
	if (confirm('첨부 파일을 삭제하겠습니까?')) {
		$.ajax({
			type:"post",
			url:"<c:url value='/web/mypage/deleteRsvFile.ajax'/>",
			data:"seq=" + xSeq + "&savePath=" + xSavePath + "&saveFileNm=" + xSaveFileNm,
			success:function(data){
				if (data.Status == 'success') {
					alert('파일을 삭제 했습니다.');
					location.reload();
				}
			},
			error : fn_AjaxError
		});
	}
}

$(document).ready(function(){
    $("#refundItem").click(function(){
        if(!$("#refundAccNum").val()){
            alert("계좌번호를 입력하세요.");
            $("#refundAccNum").focus();
            return;
		}
		if(!$("#refundDepositor").val()){
            alert("예금주명을 입력하세요.");
            $("#refundDepositor").focus();
            return;
		}
        close_popup("#refundPopupArea");
        if($("#refundItem").val()){
			fn_ReqCancelPopProc($("#refundItem").val());
		}else{
			show_popup("#cancelAllDiv");
		}
	});

	$("#refundPopupClose").click(function(){
	    close_popup("#refundPopupArea");
	});
});

</script>

</head>
<body>
<header id="header">
	<jsp:include page="/web/head.do" />
</header>
<main id="main">
	<div class="mapLocation"> <!--index page에서는 삭제-->
		<div class="inner">
			<span>홈</span> <span class="gt">&gt;</span>
			<span>마이페이지</span> <span class="gt">&gt;</span>
			<span>나의 예약/구매내역</span>
		</div>
	</div>
	<!-- quick banner -->
	<jsp:include page="/web/left.do" />
	<!-- //quick banner -->
	<div class="subContainer">
		<div class="subHead"></div>
		<div class="subContents">
			<!-- new contents -->
			<div class="mypage sideON">
				<div class="bgWrap2">
					<div class="inner">
						<div class="tbWrap">
							<jsp:include page="/web/mypage/left.do?menu=rsv" />
							<div class="rContents smON">
								<h3 class="mainTitle">나의 예약/구매 내역</h3>
								<c:if test="${Constant.SV ne orderDiv}">
									<article class="payArea">
										<h4 class="comm-title2">예약현황</h4>
										<table class="commRow">
											<tbody>
												<tr>
													<th class="table--width">예약번호</th>
													<td class="comm-color0"><c:out value="${rsvInfo.rsvNum}"/></td>
												</tr>
												<tr>
													<th class="table--width">예약일</th>
													<td><c:out value="${rsvInfo.regDttm}"/></td>
												</tr>
												<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_READY}">
													<tr>
														<th class="table--width">처리상태</th>
														<td>
															<span class="comm-color1">예약처리중</span>
															<span class="sub"> ( <strong class="realTimeAttack"></strong> 후에는 예약이 <span class="comm-color1">자동 취소</span>됩니다. )</span>
														</td>
													</tr>
												</c:if>
											</tbody>
										</table>
									</article>
								</c:if>

								<c:if test="${Constant.SV eq orderDiv}">
									<article class="payArea">
										<h4 class="comm-title2">구매현황</h4>
										<table class="commRow">
											<tbody>
												<tr>
													<th class="table--width">구매번호</th>
													<td><c:out value="${rsvInfo.rsvNum}"/></td>
												</tr>
												<tr>
													<th class="table--width">구매일</th>
													<td><c:out value="${rsvInfo.regDttm}"/></td>
												</tr>
												<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_READY}">
													<tr>
														<th class="table--width">처리상태</th>
														<td>
															<span class="comm-color1">구매처리중</span>
															<span class="sub"> ( <strong class="realTimeAttack"></strong> 후에는 구매가 <span class="comm-color1">자동 취소</span>됩니다. )</span>
														</td>
													</tr>
												</c:if>
											</tbody>
										</table>
									</article>
								</c:if>

								<article class="payArea">
									<h4 class="comm-title2">
										상품정보
										<c:if test="${recPntYn=='Y'}">
											<!-- 카드영수증 출력 -->
											<c:if test="${recPntType=='card'}">
											<span class="comm-btWrap">
												<a class="writeBT" href="javascript:showReceiptByTID('${LGD_MID}', '${LGD_TID}', '${authdata}')">카드영수증 출력
													<img src="/images/web/button/document.png" alt="카드영수증 출력">
												</a>
											</span>
											</c:if> <!-- //카드영수증 출력 -->

											<!-- 현금영수증 출력 -->
											<c:if test="${recPntType=='cash'}">
											<span class="comm-btWrap">
												<a class="writeBT" href="javascript:showCashReceipts('${LGD_MID}', '${LGD_OID}', '001', '${cashType}', '${CST_PLATFORM}')">현금영수증 출력
													<img src="/images/web/button/document.png" alt="현금영수증 출력">
												</a>
											</span>
											</c:if><!-- //현금영수증 출력 -->

											<c:if test="${recPntType=='Nocash'}">
											<span class="comm-btWrap">
												<a class="writeBT" href="javascript:alert('현금영수증을 신청하지 않았습니다.')">현금영수증 미신청</a>
											</span>
											</c:if>
										</c:if>
										<c:if test="${useepilRegYn eq 'Y'}">
										<span class="comm-btWrap">
											<c:if test="${isLogin =='Y'}">
												<a class="writeBT" href="<c:url value='/web/coustmer/viewInsertUseepil.do?sRsvNum=${rsvInfo.rsvNum}'/>" >
											</c:if>
											<c:if test="${isLogin !='Y'}">
												<a class="writeBT" href="/web/coustmer/viewInsertUseepil.do" >
											</c:if>
												이용후기 작성
												<img src="/images/web/button/write.png" alt="이용후기 작성">
											</a>
										</span>
										</c:if>
									</h4>
									<!--상품정보-->
									<table class="commCol product-info myp-info">
										<thead>
											<tr>
												<c:if test="${Constant.SV ne orderDiv}">
													<th class="title1">구분</th>
												</c:if>
												<th class="title2">상품정보</th>
<%--												<th class="title3">상품금액</th>--%>
												<c:if test="${Constant.SV eq orderDiv}">
													<th class="title4">배송비</th>
												</c:if>
												<th class="title5">상품금액</th>
												<th class="title6">처리상태</th>
											</tr>
										</thead>
										<tbody>
											<c:set var="cancelYn" value="N" />
											<c:set var="allCancelYn" value="Y" />
											<c:set var="totalDlvAmt" value="0" />
											<c:set var="sv_dlvAmtDiv" value="NULL" />
											<c:set var="sv_pCorpId" value="NULL" />
											<c:set var="sv_prdc" value="NULL"/>
											<c:set var="acceptExt" value="${Constant.FILE_CHECK_EXT}" />
											<c:forEach items="${orderList}" var="order" varStatus="status">
												<c:if test="${(order.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM) or (order.rsvStatusCd eq Constant.RSV_STATUS_CD_SCOM)}">
													<c:set var="cancelYn" value="Y" />
												</c:if>
												<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_COM}">
													<c:set var="allCancelYn" value="N" />
												</c:if>
												<tr>
													<c:if test="${Constant.SV ne orderDiv}">
														<td>${order.prdtCdNm}</td>
													</c:if>
													<td class="left1">
														<div class="coupon-info--point">
														<a onclick="fn_DetailPrdt('${order.prdtNum}');">
														<h5 class="product"><span class="cProduct">[${order.corpNm}] ${order.prdtNm}</span></h5>
														<p class="infoText"><c:out value="${order.prdtInf}"/></p>
														<c:if test="${not empty order.exprStartDt and not empty order.exprEndDt }">
															<p class="ticket-info ticket-info2">
																<fmt:parseDate value='${order.exprStartDt}' var='exprStartDt' pattern="yyyyMMdd" scope="page"/>
																<fmt:parseDate value='${order.exprEndDt}' var='exprEndDt' pattern="yyyyMMdd" scope="page"/>
																유효기간 : <fmt:formatDate value="${exprStartDt}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${exprEndDt}" pattern="yyyy-MM-dd"/>
															</p>
														</c:if>
														<c:if test="${order.exprEndDt - SVR_TODAY < 0 and order.prdtDiv eq Constant.SP_PRDT_DIV_COUP}">
															<p class="ticket-info">유효기간이 만료되어 사용할 수 없는 상품입니다.</p>
														</c:if>
														<c:if test="${not empty order.useAbleDttm and order.exprEndDt - SVR_TODAY >=0}">
															<p class="ticket-info">${order.useAbleDttm} 이후 이용 가능 상품입니다.</p>
														</c:if>
														<c:if test="${not empty spRsvHistMap[order.prdtRsvNum]}">
															<c:forEach items="${spRsvHistMap[order.prdtRsvNum]}" var="spRsvHist">
																<ul class="use-msg">
																	<li>
																		<p class="date"><c:out value="${spRsvHist.regDttm}" /></p>
																		<p class="memo"><c:out value="${spRsvHist.usehist}" /></p>
																	</li>
																</ul>
															</c:forEach>
														</c:if>
														</a>
														</div>
													</td>
<%--													<td>--%>
<%--														<p class="price"><fmt:formatNumber><c:out value="${order.nmlAmt}"/></fmt:formatNumber></p>--%>
<%--														<p class="sale">-<fmt:formatNumber><c:out value="${order.disAmt}"/></fmt:formatNumber></p>--%>
<%--													</td>--%>
													<%--생산자별 묶음배송으로 로직 변경 (prdc 조건 추가) 2021.06.07 chaewan.jung --%>
													<c:if test="${orderDiv eq Constant.SV}">
														<c:choose>
														<c:when test="${(order.corpId ne sv_pCorpId) or (order.corpId eq sv_pCorpId and order.dlvAmtDiv ne sv_dlvAmtDiv or order.prdc ne sv_prdc) or (order.dlvAmtDiv eq Constant.DLV_AMT_DIV_DLV) or (order.dlvAmtDiv eq Constant.DLV_AMT_DIV_MAXI)  }">
															<c:set var="c_row" value="0" />
															<c:if test="${Constant.DLV_AMT_DIV_APL eq order.dlvAmtDiv or Constant.DLV_AMT_DIV_FREE eq order.dlvAmtDiv}">
																<c:forEach items="${orderList}" var="sub_order" varStatus="sub_status">
																	<c:if test="${sub_order.corpId eq order.corpId and sub_order.dlvAmtDiv eq order.dlvAmtDiv  and sub_order.prdc eq order.prdc}">
																		<c:set var="c_row" value="${c_row + 1}" />
																	</c:if>
																</c:forEach>
															</c:if>
															<td class=shipping <%--rowspan="${c_row}"--%>>
																<c:set var="totalDlvAmt" value="${totalDlvAmt + order.dlvAmt}" />
																<span><fmt:formatNumber><c:out value="${order.dlvAmt}"/></fmt:formatNumber></span>원
															</td>

															<c:set var="sv_pCorpId" value="${order.corpId}" />
															<c:set var="sv_dlvAmtDiv" value="${order.dlvAmtDiv}" />
															<c:set var="sv_prdc" value="${order.prdc}"/>
														</c:when>
														<c:otherwise>
															<td><span>묶음배송</span></td>
														</c:otherwise>
														</c:choose>
													</c:if>
													<td class="money">
														<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_EXP}">
															<span class="nt">예약마감</span>
														</c:if>
														<c:if test="${order.rsvStatusCd != Constant.RSV_STATUS_CD_EXP}">
															<span><fmt:formatNumber><c:out value="${order.saleAmt - order.dlvAmt}"/></fmt:formatNumber></span>원
														</c:if>
													</td>
													<td class="bt">
														<c:if test="${order.prdtCd ne Constant.SV}">
															<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_READY}"><span class="comm-color2">미결제</span></c:if>
															<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_COM}">
																<p style="margin-bottom: 5px;">예약</p>
																	<a href="javascript:fn_ReqCancelPop('${order.prdtRsvNum}');">취소요청</a>
															</c:if>
															<c:if test="${(order.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ) or (orderInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2)}"><span class="comm-color1">취소처리중<br>(철회불가)</span></c:if>
															<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM}">취소완료</c:if>
															<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_UCOM}">사용완료</c:if>
															<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_ECOM}">기간만료</c:if>
															<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_ACC}">자동취소</c:if>
															<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_SREQ}">부분환불요청</c:if>
															<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_SCOM}">부분환불완료</c:if>
														</c:if>
														<c:if test="${order.prdtCd eq Constant.SV}">
															<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_READY}">구매처리중</c:if>
															<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_COM}">
																<p style="margin-bottom: 5px;">결제완료</p>
																<a href="javascript:fn_ReqCancelPop('${order.prdtRsvNum}');">취소요청</a>
															</c:if>
															<c:if test="${(order.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ) or (order.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2)}"><span class="comm-color1">취소처리중<br>(철회불가)</span></c:if>
															<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM}">취소완료</c:if>
															<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_UCOM}">구매확정</c:if>
															<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_ECOM}">기간만료</c:if>
															<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_ACC}"><span class="comm-color2">자동취소</span></c:if>
															<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_SREQ}">부분환불요청</c:if>
															<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_SCOM}">부분환불완료</c:if>
															<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_DLV}"><p class="info">배송중</p></c:if>
															<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_DLVE}"><p class="info">배송완료</p></c:if>
														</c:if>
													</td>
												</tr>
                                                <c:if test="${(order.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ) or (orderInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2) or (order.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2)}">
                                                <form name="frm${order.prdtRsvNum}" id="frm${order.prdtRsvNum}" method="post" onSubmit="return false;" enctype="multipart/form-data">
                                                <input type="hidden" name="rsvNum" value="${rsvInfo.rsvNum}" />
                                                <input type="hidden" name="category" value="PROVE" /> <!--증빙자료-->
                                                <input type="hidden" name="dtlRsvNum" value="${order.prdtRsvNum}" />
												<tr>
													<td class="left1"> 취소관련<br/>증빙자료</td>
													<td class="left1">증빙자료 제출 필요 시 파일 선택을 통하여 제출</td>
													<td class="left1 attachments" colspan="2">
														<c:set var="fileCnt" value="1" />
														<c:forEach items="${fileList }" var="file" varStatus="stat">
															<c:if test="${file.dtlRsvNum eq order.prdtRsvNum}">
																<p class="file" id="fileTool_${stat.index }">${file.realFileNm } <a href="javascript:fn_rsvFileDelete('${file.seq}','${file.savePath}','${file.saveFileNm}')">[삭제]</a></p>
																<c:set var="fileCnt" value="${fileCnt + 1}" />
															</c:if>
														</c:forEach>

														<c:forEach var="i" begin="${fileCnt}" end="2">
															<p class="file"><input type="file" name="file_${order.prdtRsvNum}_${i}" onchange="checkFile(this, '${acceptExt}', 5)"></p>
														</c:forEach>
													</td>
													<td>
														<div class="comm-button5">
															<!--증빙자료 2개 올렸으면 제출 버튼 막음-->
															<c:if test="${fileCnt ne 3 }">
																<a class="color1" href="javascript:fn_updateFile('${order.prdtRsvNum}')">제출</a>
															</c:if>
															<c:if test="${fileCnt eq 3 }">
																<a href="javascript:alert('증빙자료는 두개까지 올리실 수 있습니다.');">제출</a>
															</c:if>
														</div>
													</td>
												</tr>
                                                </form>
                                                </c:if>
											</c:forEach>
										</tbody>
									</table>

								</article>

								<c:if test="${Constant.SV ne orderDiv}">
									<!-- 예약자, 사용자 정보 입력 -->
									<div class="payArea-wrap">
										<article class="payArea userWrap1">
											<h5 class="title">예약자정보</h5>
											<table class="commRow">
												<tr>
													<th>이름</th>
													<td><c:out value="${rsvInfo.rsvNm}"/></td>
												</tr>
												<tr>
													<th>전화번호</th>
													<td><c:out value="${rsvInfo.rsvTelnum}"/></td>
												</tr>
												<tr>
													<th>이메일</th>
													<td><c:out value="${rsvInfo.rsvEmail}"/></td>
												</tr>
											</table>
										</article>
										<article class="payArea userWrap2">
											<h5 class="title">사용자정보</h5>
											<table class="commRow">
												<tr>
													<th>이름</th>
													<td><c:out  value="${rsvInfo.useNm}"/></td>
												</tr>
												<tr>
													<th>전화번호</th>
													<td><c:out value="${rsvInfo.useTelnum}"/></td>
												</tr>
												<tr>
													<th>이메일</th>
													<td><c:out value="${rsvInfo.useEmail}"/></td>
												</tr>
											</table>
										</article>
									</div>
								</c:if>

								<c:if test="${Constant.SV eq orderDiv}">
									<article class="payArea buyer">
										<h4 class="comm-title2">구매자 정보</h4>
										<table class="commRow">
											<tbody>
												<tr>
													<th>이름</th>
													<td><c:out value="${rsvInfo.rsvNm}"/></td>
												</tr>
												<tr>
													<th>이메일</th>
													<td><c:out value="${rsvInfo.rsvEmail}"/></td>
												</tr>
												<tr>
													<th>휴대폰</th>
													<td><c:out value="${rsvInfo.rsvTelnum}"/></td>
												</tr>
											</tbody>
										</table>
									</article>

									<article class="payArea deli-address">
										<h4 class="comm-title2">배송지 정보
											<%--<span class="comm-btWrap">
												<a class="writeBT" href="javascript:void(0)" onclick="show_popup('#addr_layer');">배송지 변경
													<img src="/images/web/button/change.png" alt="배송지 변경">
												</a>
											</span>--%>
										</h4>
										<table class="commRow">
											<tbody>
												<tr>
													<th>이름</th>
													<td><c:out  value="${rsvInfo.useNm}"/></td>
												</tr>
												<tr>
													<th>휴대폰</th>
													<td><c:out value="${rsvInfo.useTelnum}"/></td>
												</tr>
												<tr>
													<th>배송지 주소</th>
													<td>(<c:out value="${rsvInfo.postNum}"/>) <c:out value="${rsvInfo.roadNmAddr}"/> <c:out value="${rsvInfo.dtlAddr}"/></td>
												</tr>
												<tr>
													<th>배송 시 요청사항</th>
													<td><c:out value="${rsvInfo.dlvRequestInf}"/></td>
												</tr>
											</tbody>
										</table>
										<c:if test="${allCancelYn == 'N' or rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_READY }">
										<div id="addr_layer" class="layer-popup comm-layer-popup">
											<div class="comm-close">
												<a onclick="close_popup('#addr_layer');">
													<img src="/images/web/icon/popup_close.png" alt="닫기">
												</a>
											</div>
											<div class="option-box ">
												<h4 class="addr-change">배송지 변경</h4>
												<form name="f_changeDlv" id="f_changeDlv">
												<div class="check">
													<p class="name">
														<span class="title">이름</span>
														<input type="text" name="useNm" id="useNm">
													</p>
													<p class="phone">
														<span class="title">휴대폰</span>
														<input type="text" name="useTelnum" id="useTelnum" onkeyup="addHyphenToPhone(this);">
													</p>
													<p class="addr">
														<span class="title">주소</span>
														<input class="num" type="text" name="postNum" id="postNum">
														<a href="javascript:openDaumPostcode()" class="btn">주소검색</a>
														<span class="addr-form">
															<input class="addr1" name="roadNmAddr" type="text" id="roadNmAddr">
															<input class="addr2" name="dtlAddr" type="text" id="dtlAddr">
														</span>
													</p>
												</div>
												</form>
												<div class="comm-button2">
													<a href="javascript:fn_ChangeDlv();" class="color1">배송지 변경</a>
													<a href="javascript:void(0)" class="color2" onclick="close_popup('#addr_layer');">취소</a>
												</div>
											</div>
										</div> <!-- //option-wrap -->
										</c:if>
									</article>
								</c:if>

								<article class="payArea">
									<h4 class="comm-title2">결제정보</h4>
									<table class="commRow comm-payInfo">
										<colgroup>
											<col style="width: 140px">
											<col style="width: 255px">
											<col style="width: 140px">
											<col>
										</colgroup>
										<tr>
											<th>총상품금액</th>
											<td colspan="3"><strong><fmt:formatNumber><c:out value="${rsvInfo.totalNmlAmt - totalDlvAmt}"/></fmt:formatNumber></strong>원</td>
										</tr>
										<tr>
											<th>쿠폰할인</th>
											<td colspan="3" class="sale"><img src="<c:url value='/images/web/icon/sale.png'/>" alt="-"> <strong><fmt:formatNumber><c:out value="${rsvInfo.totalDisAmt}"/></fmt:formatNumber></strong>원</td>
										</tr>
										<c:if test="${rsvInfo.usePoint > 0}">
										<tr>
											<th>${rsvInfo.partnerNm} 포인트</th>
											<td colspan="3" class="sale"><img src="<c:url value='/images/web/icon/sale.png'/>" alt="-"> <strong><fmt:formatNumber><c:out value="${rsvInfo.usePoint}"/></fmt:formatNumber></strong>원</td>
										</tr>
										</c:if>
										<c:if test="${rsvInfo.lpointUsePoint > 0 || rsvInfo.lpointSavePoint > 0}">
										<tr>
											<th>L.POINT 사용</th>
											<td class="sale"><img src="<c:url value='/images/web/icon/sale.png'/>" alt="-"> <strong><fmt:formatNumber><c:out value="${rsvInfo.lpointUsePoint}"/></fmt:formatNumber></strong>원</td>
											<th class="accumulate">L.POINT 적립 예정</th>
											<td><strong><fmt:formatNumber><c:out value="${rsvInfo.lpointSavePoint}"/></fmt:formatNumber> P</strong></td>
										</tr>
										</c:if>
										<c:if test="${orderDiv eq Constant.SV}">
											<tr>
												<th>총 배송비</th>
												<td colspan="3" class="shipping"><fmt:formatNumber><c:out value="${totalDlvAmt}"/></fmt:formatNumber>원</td>
											</tr>
										</c:if>
										<tr>
											<th>결제금액</th>
											<td colspan="3" class="total-wrap">
												<strong class="comm-color1"><fmt:formatNumber><c:out value="${rsvInfo.totalSaleAmt}"/></fmt:formatNumber></strong>원
											</td>
										</tr>
										<tr>
											<th>결제방법</th>
											<td colspan="3">
												<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_CI}">카드결제</c:if>
												<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_HI}">휴대폰결제</c:if>
												<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_TI}">계좌이체</c:if>
												<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_ETI}">계좌이체(에스크로)</c:if>
												<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_MI}">무통장입금</c:if>
												<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_EMI}">무통장입금(에스크로)</c:if>
												<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_KI}">카카오페이</c:if>
												<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_TC_WI}">탐나는전 PC결제</c:if>
												<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_TC_MI}">탐나는전 모바일결제</c:if>
											</td>
										</tr>
									</table>
								</article>

								<c:if test="${cancelYn == 'Y'}">
									<article class="payArea">
										<div class="title-bt">
											<h4 class="comm-title2">취소정보</h4>
											<table class="commRow comm-payInfo">
												<tr>
													<th>취소금액</th>
													<td class="cancel--color"><fmt:formatNumber><c:out value="${rsvInfo.totalCancelAmt}"/></fmt:formatNumber>원</td>
												</tr>
												<tr>
													<th>취소수수료금액</th>
													<td><fmt:formatNumber><c:out value="${rsvInfo.totalCmssAmt}"/></fmt:formatNumber>원</td>
												</tr>
												<tr>
													<th>할인취소금액</th>
													<td><fmt:formatNumber><c:out value="${rsvInfo.totalDisCancelAmt}"/></fmt:formatNumber>원</td>
												</tr>
											</table>
										</div>
									</article>
								</c:if>

								 <!-- 안내사항 -->
								<article class="info">
									<h4 class="tit">안내사항</h4>
									<div class="txt">
										ㆍ 전체취소 시 쇼핑 항목의 경우에는 주문상태가 '입금대기, 결제완료' 일때만 정상처리 됩니다.
									</div>
								</article>

								<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_COM }">
								<!-- 광고배너 -->
								<article>
									<img class="bubble" src="/images/web/mypage/shop_banner.png" alt="면세점">
								</article>
								</c:if>
								
								<p class="comm-button2">
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_READY and difTime > 0}">
										<c:if test="${rsvInfo.LGD_CASFLAGY eq 'R'}">
										<a class="color1" href="<c:url value='/web/orderCompleteVaccount.do?rsvNum=${rsvInfo.rsvNum}'/>">입금정보확인</a>
										</c:if>
										<c:if test="${rsvInfo.LGD_CASFLAGY ne 'R'}">
										<a class="color1" href="<c:url value='/web/order03.do?rsvNum=${rsvInfo.rsvNum}'/>">결제하기</a>
										</c:if>
										<a class="color0" href="javascript:fn_OrderCancel();">취소하기</a>
									</c:if>
									<c:if test="${allCancelYn == 'N'}">
										<!-- 탐나오상품권 사용하지 않은 특산/기념품 일 경우에만 전체취소 가능-->
										<c:if test="${orderDiv eq 'SV'}">
											<a class="color0" href="javascript:fn_ReqCancelPopAll();">전체취소</a>
										</c:if>
									</c:if>
								</p>
							</div> <!--//rContents-->
						</div> <!--//tbWrap-->
					</div> <!--//inner-->
				</div> <!--//bgWrap2-->

				<!--전체취소-->
				<div class="comm-fullPopup rent-detail cancel-popup comm-layer-popup" id="cancelAllDiv">
					<h4 class="title">전체취소</h4>
					<div class="comm-close2">
						<a onclick="close_popup('#cancelAllDiv')";>
							<img src="/images/web/icon/popup_close.png" alt="닫기">
						</a>
					</div>

					<c:forEach items="${orderList}" var="order" varStatus="status">
						<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_COM}">
							<h5 class="sub-title">상품정보</h5>
							<table class="commCol product-info myp-info popup-table">
								<thead>
								<tr>
									<th class="title1">구분</th>
									<th class="title2">상품정보</th>
								</tr>
								</thead>
								<tbody>
								<tr>
									<td>${order.prdtCdNm}</td>
									<td class="left">
										<h5 class="product"><span class="cProduct">${order.corpNm} ${order.prdtNm}</span></h5>
										<p class="infoText interval"><c:out value="${order.prdtInf}"/></p>
									</td>
								</tr>
								</tbody>
							</table>
							<div class="popup-coupon-text">
								<b>* 할인쿠폰, 포인트 사용 건 취소 안내</b>
								<p>A. 취소 수수료 부과 시 수수료 적용 순서는 아래와 같습니다.</p>
								<p>&nbsp;&nbsp;&nbsp;&nbsp;포인트 → 결제금액 → 쿠폰 (수수료 발생 시 포인트부터 차감)</p>
								<p>B. 취소 시 조기마감 된 할인쿠폰은 재사용이 불가합니다.</p>

							</div>
							<br>
							<h5 class="sub-title">취소/환불규정</h5>
							<div class="memoMsg">
								<c:out value="${order.cancelGuide}" escapeXml="false" />
							</div>
						</c:if>
					</c:forEach>

					<h5 class="sub-title">취소사유</h5>
					<input type="text" id="cancelAllRsn" class="full" placeholder="취소사유를 입력해주세요" maxlength="300">
					<div class="comm-button1">
						<a href="javascript:fn_ReqCancelAll();" class="color1">전체취소</a>
					</div>
				</div><!--//전체취소-->

				<!-- 부분취소 -->
				<div class="comm-fullPopup rent-detail cancel-popup" id="cancelDiv">
					<input type="hidden" name="prdtRsvNum" id="prdtRsvNum" >
					<h4 class="title">
						예약(구매)취소
						<a class="option-close" onclick="close_popup('.comm-fullPopup');"><img src="/images/web/icon/popup_close.png" alt="닫기"></a>
					</h4>
					<h5 class="sub-title"> 상품정보</h5>
					<table class="commCol product-info myp-info popup-table">
						<thead>
							<tr>
								<th class="title1">구분</th>
								<th class="title2">상품정보</th>
							</tr>
						</thead>
						<tbody id="cancelTbody">
						</tbody>
					</table>
					<div class="popup-coupon-text">
						<b>* 할인쿠폰, 포인트 사용 건 취소 안내</b>
						<p>A. 취소 수수료 부과 시 수수료 적용 순서는 아래와 같습니다.</p>
						<p>&nbsp;&nbsp;&nbsp;&nbsp;포인트 → 결제금액 → 쿠폰 (수수료 발생 시 포인트부터 차감)</p>
						<p>B. 취소 시 조기마감 된 할인쿠폰은 재사용이 불가합니다.</p>
					</div>
					<br>
					<h5 class="sub-title"> 취소/환불규정</h5>
					<div class="memoMsg" id="cancelGuide">

					</div>
					<h5 class="sub-title">취소사유</h5>
					<input type="text" class="full" id="cancelRsn" placeholder="취소사유를 입력해주세요" maxlength="300">
					<div class="comm-button1">
						<a href="javascript:fn_ReqCancel();" class="color1">취소요청</a>
					</div>
				</div>

<%--				<!-- 전체취소 예제 -->--%>
<%--				<div class="comm-fullPopup rent-detail cancel-popup" id="cancelAllDiv">--%>
<%--					<h4 class="title">--%>
<%--						전체 취소요청 <a class="option-close" onclick="close_popup('.comm-fullPopup');"><img src="<c:url value="/images/web/cart/close.gif"/>" alt="닫기"></a>--%>
<%--					</h4>--%>

<%--					<c:forEach items="${orderList}" var="order" varStatus="status">--%>
<%--					  	<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_COM}">--%>
<%--							<h5 class="sub-title"><img src="<c:url value="/images/web/travel/sb.gif"/>" alt="말풍선"> 상품정보</h5>--%>
<%--							<table class="commCol product-info myp-info">--%>
<%--								<thead>--%>
<%--									<tr>--%>
<%--										<th class="title1">구분</th>--%>
<%--										<th class="title2">상품정보</th>--%>
<%--									</tr>--%>
<%--								</thead>--%>
<%--								<tbody>--%>
<%--									<tr>--%>
<%--										<td>${order.prdtCdNm}</td>--%>
<%--										<td class="left">--%>
<%--											<h5 class="product"><span class="cProduct">${order.corpNm} ${order.prdtNm}</span></h5>--%>
<%--											<p><c:out value="${order.prdtInf}"/></p>--%>
<%--										</td>--%>
<%--									</tr>--%>
<%--								</tbody>--%>
<%--							</table>--%>
<%--							<div style="color:red;font-size:12px;">*빅할인이벤트 쿠폰 사용 결제건의 경우에는 취소 완료 시 쿠폰 반환이 불가합니다.</div>--%>
<%--							<br>--%>
<%--							<h5 class="sub-title"><img src="<c:url value="/images/web/travel/sb.gif"/>" alt="말풍선"> 취소/환불규정</h5>--%>
<%--							<div class="memoMsg">--%>
<%--							  <c:out value="${order.cancelGuide}" escapeXml="false" />--%>
<%--							</div>--%>
<%--					  	</c:if>--%>
<%--					</c:forEach>--%>

<%--					<h5 class="sub-title"><img src="<c:url value="/images/web/travel/sb.gif"/>" alt="말풍선"> 취소사유</h5>--%>
<%--					<input type="text" id="cancelAllRsn" class="full" placeholder="취소사유를 입력해주세요" maxlength="300">--%>
<%--					<div class="comm-button1">--%>
<%--						<a href="javascript:fn_ReqCancelAll();" class="color1">전체 취소요청</a>--%>
<%--					</div>--%>
<%--				</div>--%>

				<div id="refundPopupArea" class="comm-fullPopup rent-detail cancel-popup">
					<div class="content-wrap">
						<div class="content">
							<div class="head">
								<h4 class="title">환불받으실 계좌번호
									<a class="option-close" id="refundPopupClose"><img src="<c:url value="/images/web/cart/close.gif"/>" alt="닫기"></a>
								</h4>
							</div>

							<div class="main">
								<table class="table-row">
									<caption>포인트 조회 항목</caption>
									<colgroup>
										<col style="width: 25%">
										<col>
									</colgroup>
									<tbody>
										<tr>
											<th>은행</th>
											<td>
												<select name="refundBankCode" id="refundBankCode">
													<c:forEach items="${cdRfac}" var="code" varStatus="status">
														<option value="${code.cdNum}" <c:if test="${code.cdNum eq refundAccInf.bankCode}">selected="selected"</c:if>> ${code.cdNm}</option>
													</c:forEach>
												</select>
											</td>
										</tr>
										<tr>
											<th>계좌번호</th>
											<td>
												<div class="input-btn-col2">
													<input type="text" id="refundAccNum" name="refundAccNum" value="${refundAccInf.accNum}" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" placeholder="숫자만가능합니다.">
												</div>
											</td>
										</tr>
										<tr>
											<th>입금자명</th>
											<td>
												<div class="input-btn-col2">
													<input type="text" id="refundDepositor" name="refundDepositor" value="${refundAccInf.depositorNm}" placeholder="입금자명이 정확해야합니다.">
													<button type="button" class="comm-btn red" id="refundItem" value="">취소진행</button>
												</div>
											</td>
										</tr>
									</tbody>
								</table>

								<div class="popup-area-list">
									<ul class="list-disc">
										<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_TC_WI || rsvInfo.payDiv eq Constant.PAY_DIV_TC_WI}">
										<li>결제하신 결제수단은 <strong class="red">취소수수료발생 시</strong> 고객님의 은행계좌가 있어야 환불이 가능합니다.(수수료 미 발생시 탐나는전으로 환불)</li>
										</c:if>
										<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_MI}">
										<li>결제하신 결제수단은 <strong>고객님의 은행계좌</strong>가 있어야 환불이 가능합니다.</li>
										</c:if>
										<li>은행/계좌번호/입금자명이 <strong>정확해야</strong> 환불이 가능합니다.</li>
										<li>계좌번호는 <strong>숫자</strong>만 입력하셔야 합니다.</li>
										<li>환불은 취소완료 후 3~5일정도 소요됩니다.</li>
									</ul>
								</div>
								<%--<div class="logo-area">--%>
									<%--<img src="/images/mw/common/tamnao-logo.gif" alt="닫기">--%>
								<%--</div>--%>
							</div>
						</div>
					</div>
				</div> <!--레이어팝업-->
			</div> <!-- //mypage1 -->
			<!-- //new contents -->
		</div> <!-- //subContents -->
	</div> <!-- //subContainer -->
</main>

<jsp:include page="/web/foot.do" />

<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_READY}">
	<script type="text/javascript">
	var itv;
	var timeLeft = "<c:out value='${difTime}' />";

	var updateLeftTime = function() {
		timeLeft = (timeLeft <= 0) ? 0 : -- timeLeft;

		if(timeLeft > 0) {
			var hours = Math.floor(timeLeft / 3600);
			var minutes = Math.floor((timeLeft - 3600 * hours) / 60);
			var seconds = timeLeft % 60;

			var time_text = "";
			if(minutes > 0) {
				time_text += minutes + "분 ";
			}
			time_text += seconds + "초";

			$(".realTimeAttack").text(time_text);
		} else {
			$(".sub").remove();
			clearInterval(itv);
		}
	}

	$(document).ready(function() {
		if(timeLeft > 0){
			itv = setInterval(updateLeftTime, 1000);
		} else {
			$(".sub").remove();
		}
	});
	</script>
</c:if>
</body>
</html>