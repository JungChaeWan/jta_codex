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
<jsp:include page="/mw/includeJs.do" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui-mobile.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/font-awesome/css/font-awesome.min.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub_mypage.css?version=2.1'/>">

<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>

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
		$('#refundPopupArea').show();
    }else{
		fn_ReqCancelPopProc(prdtRsvNum)
    }
}

/**
 * 상품 단건 취소
 */
function fn_ReqCancelPopProc(prdtRsvNum){

	$("#prdtRsvNum").val(prdtRsvNum);
	var parameters = "prdtRsvNum=" + prdtRsvNum;
	$.ajax({
		type:"post",
		dataType:"json",
		url:"<c:url value='/web/selectByOrder.ajax'/>",
		data:parameters,
		success:function(data){
			var infoHtml = "<h5 class='product'><span>[" + data.orderVO.corpNm + "] " + data.orderVO.prdtNm + "</span></h5>";
			infoHtml += "<p>" + data.orderVO.prdtInf+ "</p>";

			$("#productInfo").html(infoHtml);
			$("#cancelGuide").html(data.orderVO.cancelGuide);

			$('#cancelGuide').show();
			layer_popup2('#cancelPopup');
		}
	});
}

function fn_ReqCancel(){
	if(confirm("취소 시 철회가 불가능합니다. 취소/환불 규정을 확인해주세요.\n취소처리 하시겠습니까?")){
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
			data:parameters,
			success:function(data){
				if(data.success == "apiFail") {
					alert("취소처리가 실패 하였습니다.\n탐나오고객센터(1522-3454)에 문의 바랍니다.");
					return;
				} else {
					location.href="<c:url value='/mw/mypage/detailRsv.do?rsvNum=${rsvInfo.rsvNum}'/>";
				}
			}
		});
	}
}

/** 상품 전체 취소 */
function fn_ReqCancelPopAll(){
    /** 단건 아이템번호 삭제*/
    $("#refundItem").val("");
    /** 무통장입금의 입금상태일 경우*/
	if("${rsvInfo.LGD_CASFLAGY}" == "I" || "${rsvInfo.payDiv}" == "${Constant.PAY_DIV_TC_WI}" || "${rsvInfo.payDiv}" == "${Constant.PAY_DIV_TC_MI}"){
        $('#refundPopupArea').show();
    }else{
		$("#cancelAllPopup").show();
    }
}

function fn_ReqCancelAll(){
	if(confirm("전체 취소 요청하시겠습니까?")){
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
			data:parameters,
			success:function(data){
				location.href="<c:url value='/mw/mypage/detailRsv.do?rsvNum=${rsvInfo.rsvNum}'/>";
			}
		});
	}
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

/**
 * 사용처리 레이어
 */
function fn_viewUseAppr(prdtRsvNum) {
	$("#prdtRsvNum").val(prdtRsvNum);

	$.ajax({
		type:"post",
		dataType:"json",
		async:false,
		url:"<c:url value='/mw/mypage/validateUseAbleDttm.ajax'/>",
		data:$("#useApprForm").serialize(),
		success:function(data){
			if(data.exprOut == "Y"){
				alert("유효기간이 맞지 않습니다.\n" + fn_addDate(data.exprStartDt) + " ~ " + fn_addDate(data.exprEndDt));
				return ;
			} else if(data.useAbleOut == "Y") {
				alert(data.useAbleDttm + " 이후 사용가능합니다.");
				return ;
			} else if(data.password == "Y") {
				alert("비밀번호가 맞지 않습니다.");
				return ;
			} else {
				if(data.success == "${Constant.JSON_SUCCESS}"){


					layer_popup2('#usePopup');
				}
			}
		},
		error : fn_AjaxError
	});
}

function fn_DetailPrdt(prdtNum){

	var code = prdtNum.substring(0,2);
	if(code == "${Constant.RENTCAR}") {
		location.href = "<c:url value='/mw/rentcar/car-detail.do'/>?prdtNum="+prdtNum;
	} else if(code == "${Constant.ACCOMMODATION}") {
		location.href = "<c:url value='/mw/ad/detailPrdt.do'/>?sPrdtNum="+prdtNum;
	} else if(code == "${Constant.GOLF}") {
		location.href = "<c:url value='/mw/gl/detailPrdt.do'/>?sPrdtNum="+prdtNum;
	} else if(code == "${Constant.SOCIAL}") {
		location.href = "<c:url value='/mw/sp/detailPrdt.do'/>?prdtNum="+prdtNum;
	} else if(code == "${Constant.SV}") {
		location.href = "<c:url value='/mw/sv/detailPrdt.do'/>?prdtNum="+prdtNum;
	}
}

function fn_spUseAppr() {
	$.ajax({
		type:"post",
		dataType:"json",
		async:false,
		url:"<c:url value='/mw/mypage/spUseAppr.ajax'/>",
		data:$("#useApprForm").serialize(),
		success:function(data){
			if(data.exprOut == "Y"){
				alert("유효기간이 맞지 않습니다.\n" + fn_addDate(data.exprStartDt) + " ~ " + fn_addDate(data.exprEndDt));
				return ;
			} else if(data.useAbleOut == "Y") {
				alert(data.useAbleDttm + " 이후 사용가능합니다.");
				return ;
			} else if(data.password == "Y") {
				alert("비밀번호가 맞지 않습니다.");
				return ;
			} else {
				if(data.success == "${Constant.JSON_SUCCESS}") {
					alert("사용처리가 정상적으로 처리됐습니다.");
					location.href="<c:url value='/mw/mypage/detailRsv.do?rsvNum=${rsvInfo.rsvNum}'/>";
				}
			}
		},
		error : fn_AjaxError
	});
}

function fn_ChangeDlv() {
	if(isNull($("#useNm").val())) {
		alert("이름을 입력해주세요.");
		$("#useNm").focus();
		return;
	}
	if(isNull($("#useTelnum").val())) {
		alert("전화번호를 입력해주세요.");
		$("#useTelnum").focus();
		return;
	}
	if(!checkIsHP($("#useTelnum").val())) {
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
		data:parameters,
		success:function(data){
			location.reload();
		}
	});
}

function fn_OrderCancel() {
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
		data:parameters,
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

function fn_goDlv(svRsvNum, dlvNum) {
	var parameters = "rsvNum=" + svRsvNum;
//	var popup = window.open('about:blank', "_blank");
	$.ajax({
		type:"post",
		dataType:"json",
		// async:false,
		url:"<c:url value='/mw/dlvTrace.ajax'/>",
		data:parameters,
		success:function(data){
			if(fn_AppCheck() == "IA" || fn_AppCheck() == "AA") {
				document.location = data.url + dlvNum + "&newopen=yes";
			} else {
				window.open(data.url + dlvNum);
			}
		}
	});
}

function fn_goConfirmOrder(svRsvNum) {
	var parameters = "svRsvNum=" + svRsvNum;

	$.ajax({
		type:"post",
		dataType:"json",
		// async:false,
		url:"<c:url value='/web/confirmOrder.ajax'/>",
		data:parameters,
		success:function(data){
			location.reload();
		}
	});
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

$(document).ready(function() {
    $("#refundItem").click(function(){
        if(!$("#refundAccNum").val()) {
            alert("계좌번호를 입력하세요.");
            $("#refundAccNum").focus();
            return;
		}
		if(!$("#refundDepositor").val()) {
            alert("예금주명을 입력하세요.");
            $("#refundDepositor").focus();
            return;
		}
        close_popup("#refundPopupArea");

        if($("#refundItem").val()) {
			fn_ReqCancelPopProc($("#refundItem").val());
		} else {
			$("#cancelAllPopup").show();
		}
	});

	$("#cancelBtn").click(function(){
		fn_ReqCancel();
	});

	$("#refundPopupClose").click(function(){
	    close_popup("#refundPopupArea");
	});

	$("#cancelPopupClose").click(function(){
		close_popup("#cancelPopup");
	});

	$("#usePopupClose").click(function(){
		close_popup("#usePopup");
	});

	$("#cancelAllPopupClose").click(function(){
		close_popup("#cancelAllPopup");
	});

	/** 레이어팝업 버튼클릭 위치에 따라 이동이 가능 */
	var btn2 = $('.btn2');

	btn2.click(function(event){
	   var y = event.pageY;
	   var stdHeight;

	  /* if(y - $("#refundPopupArea").height() > 100) {
			stdHeight = 200;
	   } else {
			stdHeight = y - $("#refundPopupArea").height();
	   }
	   $(".comm-layer-popup").css("top", y - $("#refundPopupArea").height() - stdHeight + "px");*/
	})
});

</script>
</head>

<body>
<div id="wrap">
<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do">
		<jsp:param name="headTitle" value="나의 예약/구매 내역"/>
	</jsp:include>
</header>
<!-- 헤더 e -->
<!-- 콘텐츠 s -->
<h2 class="sr-only">서브콘텐츠</h2>
<section id="subContent">
	<div class="menu-bar">
		<p class="btn-prev"><img src="<c:url value="/images/mw/common/btn_prev.png"/>" width="20" alt="이전페이지"></p>
		<h2>나의 예약/구매 내역</h2>
	</div>

	<div class="sub-content">
		<div class="mypage">
			<c:if test="${Constant.SV ne orderDiv}">
				<!--예약현황-->
				<article class="payArea">
					<h4>예약현황</h4>
					<table>
						<tr>
							<th>예약번호</th>
							<td class="number"><strong>${rsvInfo.rsvNum}</strong></td>
						</tr>
						<tr>
							<th>예약일</th>
							<td>${rsvInfo.regDttm}</td>
						</tr>
						<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_READY}">
							<tr>
								<th>처리상태</th>
								<td>
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_READY}">예약처리중</c:if>
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_COM}">예약</c:if>
									<p class="sub"> (<strong class="realTimeAttack"></strong> 후에는 예약이 <span class="comm-color1">자동 취소</span>됩니다. )</p>
								</td>
							</tr>
						</c:if>
					</table>
				</article>
			</c:if>

			<c:if test="${Constant.SV eq orderDiv}">
				<article class="payArea">
					<h4>구매현황</h4>
					<table>
						<tr>
							<th>구매번호</th>
							<td class="number"><strong>${rsvInfo.rsvNum}</strong></td>
						</tr>
						<tr>
							<th>구매일</th>
							<td>${rsvInfo.regDttm}</td>
						</tr>
						<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_READY}">
							<tr>
								<th>처리상태</th>
								<td>
									<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_READY}">구매처리중</c:if>
									<p class="sub"> (<strong class="realTimeAttack"></strong> 후에는 구매가 <span class="comm-color1">자동 취소</span>됩니다. )</p>
								</td>
							</tr>
						</c:if>
					</table>
				</article>
			</c:if>
			<!--상품정보-->
			<article class="payArea">
				<div class="side-wrap">
					<h4>상품정보</h4>
				</div>
				<span class="comm-color1">(결제영수증은 "PC 마이페이지 > 나의 예약/구매 내역 > 주문상세"에서 확인할 수 있습니다.)</span>
				<ul>
					<c:set var="cancelYn" value="N" />
					<c:set var="allCancelYn" value="Y" />
					<c:set var="totalDlvAmt" value="0" />
					<c:set var="acceptExt" value="${Constant.FILE_CHECK_EXT}" />

					<c:forEach items="${orderList}" var="order" varStatus="status">
						<c:if test="${(order.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM) or (order.rsvStatusCd eq Constant.RSV_STATUS_CD_SCOM)}">
                    		<c:set var="cancelYn" value="Y" />
                    	</c:if>
                    	<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_COM}">
                    		<c:set var="allCancelYn" value="N" />
                    	</c:if>
						<li>
							<table>
								<tr>
									<td colspan="2" class="product-wrap">
										<ul class="product-list">
											<li>
												<a onclick="fn_DetailPrdt('${order.prdtNum}');">
												<h5 class="product">[${order.corpNm}] <span class="cProduct">${order.prdtNm}</span></h5>
												<p class="infoText">${order.prdtInf}</p>
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
																<p class="date"><c:out value="${spRsvHist.regDttm}"/></p>
																<p class="memo"><c:out value="${spRsvHist.usehist}" /></p>
															</li>
														</ul>
	                                                </c:forEach>
												</c:if>
												</a>
											</li>
										</ul>
									</td>
								</tr>
								<tr>
									<th>금액</th>
									<td class="price-wrap">
										<p>
											<span class="text">상품금액</span>
											<span class="price"><span><fmt:formatNumber>${order.nmlAmt}</fmt:formatNumber></span>원</span>
										</p>
										<p>
											<span class="text">(-)쿠폰할인</span>
											<span class="price"><span><fmt:formatNumber>${order.disAmt}</fmt:formatNumber></span>원</span>
										</p>
										<c:if test="${orderDiv eq Constant.SV}">
											<p>
												<c:set var="totalDlvAmt" value="${totalDlvAmt + order.dlvAmt}" />
												<span class="text">배송비</span>
												<span class="price"><span>${order.dlvAmt}</span>원</span>
											</p>
										</c:if>
										<p class="total">
											<span class="text"><strong>결제금액</strong></span>
											<span class="price">
												<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_EXP}">
													<strong>예약마감</strong>
												</c:if>
												<c:if test="${order.rsvStatusCd != Constant.RSV_STATUS_CD_EXP}">
													<strong><fmt:formatNumber>${order.saleAmt}</fmt:formatNumber></strong>원
												</c:if>
											</span>
										</p>
									</td>
								</tr>
								<tr>
									<th>처리상태</th>
									<td class="remark">
										<c:if test="${order.prdtCd ne Constant.SV}">
                                           	<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_READY}">미결제</c:if>
                                            <c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_COM}">예약

                                  					<a class="btn btn2" href="javascript:fn_ReqCancelPop('${order.prdtRsvNum}');">취소요청</a>

                                  				<c:if test="${empty order.useDttm and Constant.SP_PRDT_DIV_COUP eq order.prdtDiv}">
		                                   			<a class="btn btn4" href="javascript:fn_viewUseAppr('${order.prdtRsvNum}');">사용</a>
		                                   		</c:if>
                                            </c:if>
                                           	<c:if test="${(order.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ) or (orderInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2)}">취소처리중(철회 불가)</c:if>
                                           	<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM}">취소완료</c:if>
	                                        <c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_UCOM}">사용완료</c:if>
	                                        <c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_ECOM}">기간만료</c:if>
	                                        <c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_ACC}">자동취소</c:if>
	                                        <c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_SREQ}">부분환불요청</c:if>
	                                        <c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_SCOM}">부분환불완료</c:if>
                                      	</c:if>
                                       	<c:if test="${order.prdtCd eq Constant.SV}">
											<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_READY}">구매처리중</c:if>
                                        	<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_COM}">구매완료

                                  					<a class="btn btn2" style="font-size: .8rem;width:80px;margin-left:10px" href="javascript:fn_ReqCancelPop('${order.prdtRsvNum}');">취소요청</a>

                                  				<c:if test="${empty order.useDttm and Constant.SP_PRDT_DIV_COUP eq order.prdtDiv}">
		                                   			<a class="btn btn4" style="font-size: .8rem;width:80px;margin-left:10px" href="javascript:fn_viewUseAppr('${order.prdtRsvNum}');" >사용</a>
		                                   		</c:if>
		                                   	</c:if>
                                           	<c:if test="${(order.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ) or (order.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2)}">취소처리중(철회불가)</c:if>
                                           	<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM}">취소완료</c:if>
	                                        <c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_UCOM}">구매확정</c:if>
	                                        <c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_ECOM}">기간만료</c:if>
	                                        <c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_ACC}">자동취소</c:if>
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
									<th>증빙자료</th>
									<td class="attachments">
										<p class="label" style="color:#FE434C">* 취소관련 증빙자료가 필요 할 때만 제출</p>
										<c:set var="fileCnt" value="1" />
										<c:forEach items="${fileList }" var="file" varStatus="stat">
											<c:if test="${file.dtlRsvNum eq order.prdtRsvNum}">
												<p class="file" id="fileTool_${stat.index }">${file.realFileNm } <a href="javascript:fn_rsvFileDelete('${file.seq}','${file.savePath}','${file.saveFileNm}')">[삭제]</a></p>
												<c:set var="fileCnt" value="${fileCnt + 1}" />
											</c:if>
										</c:forEach>

										<c:forEach var="i" begin="${fileCnt}" end="2">
											<p class="file"><input type="file" name="file_${order.prdtRsvNum}_${i}" onchange="checkFile(this, '${acceptExt}', 5)" ></p>
										</c:forEach>

										<!--증빙자료 2개 올렸으면 제출 버튼 막음-->
										<c:if test="${fileCnt ne 3 }">
											<a class="btn btn1" href="#" onclick="fn_updateFile('${order.prdtRsvNum}')">제출</a>
										</c:if>
										<c:if test="${fileCnt eq 3 }">
											<a class="btn btn5" href="javascript:alert('증빙자료는 두개까지 올리실 수 있습니다.');">제출</a>
										</c:if>
									</td>
								</tr>
								</form>
								</c:if>
							</table>
						</li>
					</c:forEach>
				</ul>
			</article>


			<c:if test="${Constant.SV ne orderDiv}">
				<!--예약자정보-->
				<article class="payArea">
					<h4>예약자정보</h4>
					<table>
						<tr>
							<th>이름</th>
							<td><c:out value="${rsvInfo.rsvNm}"/><!-- <input class="full" type="text"> --></td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td><c:out value="${rsvInfo.rsvTelnum}"/><!-- <input class="full" type="text"> --></td>
						</tr>
						<tr>
							<th>이메일</th>
							<td><c:out value="${rsvInfo.rsvEmail}"/><!-- <input class="full" type="text"> --></td>
						</tr>
						<!--
						<tr>
							<th>휴대폰</th>
							<td><input class="full" type="text"></td>
						</tr>
						 -->
					</table>
					<%-- <p class="check"><input id="ordNm" type="checkbox"> <label for="ordNm">사용자가 예약자와 동일한 경우 체크해주세요</label></p>--%>
				</article>
				<!--예약자정보-->
				<article class="payArea">
					<h4>사용자정보</h4>
					<table>
						<tr>
							<th>이름</th>
							<td><c:out value="${rsvInfo.useNm}"/><!-- <input class="full" type="text"> --></td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td><c:out value="${rsvInfo.useTelnum}"/><!-- <input class="full" type="text"> --></td>
						</tr>
						<tr>
							<th>이메일</th>
							<td><c:out value="${rsvInfo.useEmail}"/><!-- <input class="full" type="text"> --></td>
						</tr>
						<!--
						<tr>
							<th>휴대폰</th>
							<td><input class="full" type="text"></td>
						</tr>
						 -->
					</table>
				</article>
			</c:if>

			<c:if test="${Constant.SV eq orderDiv}">
				<article class="payArea">
					<h4>구매자 정보</h4>
					<table>
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

				<article class="payArea">
					<h4>배송지 정보</h4>
					<table>
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
								<th>배송 시<br>요청사항</th>
								<td><c:out value="${rsvInfo.dlvRequestInf}"/></td>
							</tr>
						</tbody>
					</table>
					<c:if test="${allCancelYn == 'N' or rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_READY }">
						<div class="btn-wrap text-right">
							<a href="javascript:void(0)" class="btn btn2 view-seller2">배송지 변경</a>
						</div>
					</c:if>
				</article>
			</c:if>

			<!--결제정보-->
			<article class="payArea">
				<h4>결제정보</h4>
				<table>
					<tr>
						<th>금액</th>
						<td class="price-wrap">
							<p>
								<span class="text">상품금액</span>
								<span class="price"><span><fmt:formatNumber>${rsvInfo.totalNmlAmt}</fmt:formatNumber></span>원</span>
							</p>
							<p>
								<span class="text">(-)쿠폰할인</span>
								<span class="price"><span><fmt:formatNumber>${rsvInfo.totalDisAmt}</fmt:formatNumber></span>원</span>
							</p>
							<p>
								<c:if test="${rsvInfo.usePoint > 0}">
								<span class="text">(-)${rsvInfo.partnerNm} 포인트</span>
								<span class="price"><span><fmt:formatNumber>${rsvInfo.usePoint}</fmt:formatNumber></span>원</span>
								</c:if>

								<c:if test="${rsvInfo.lpointUsePoint > 0 || rsvInfo.lpointSavePoint > 0}">
									<span class="text">(-)L.POINT 할인</span>
									<span class="price"><span><fmt:formatNumber>${rsvInfo.lpointUsePoint}</fmt:formatNumber></span>원</span>
								</c:if>
							</p>
							<c:if test="${Constant.SV eq orderDiv}">
								<p>
									<span class="text">총 배송비</span>
									<span class="price"><span><fmt:formatNumber>${totalDlvAmt}</fmt:formatNumber></span>원</span>
								</p>
							</c:if>
							<p>
								<span class="text">취소수수료</span>
								<span class="price"><span><fmt:formatNumber>${rsvInfo.totalCmssAmt}</fmt:formatNumber></span>원</span>
							</p>
							<p class="total">
								<span class="text"><strong>결제금액</strong></span>
								<span class="price"><strong class="comm-color1"><fmt:formatNumber>${rsvInfo.totalSaleAmt}</fmt:formatNumber></strong>원</span>
							</p>
						</td>
					</tr>
					<c:if test="${rsvInfo.lpointUsePoint > 0 || rsvInfo.lpointSavePoint > 0}">
					<tr>
						<th>L.POINT<br>적립 예정</th>
						<td class="center"><c:out value="${rsvInfo.lpointSavePoint}"/>원</td>
					</tr>
					</c:if>
					<tr>
						<th>결제방법</th>
						<td class="center">
							<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_CI}">카드결제</c:if>
                          	<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_HI}">휴대폰결제</c:if>
                          	<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_TI}">계좌이체</c:if>
							<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_ETI}">계좌이체(에스크로)</c:if>
							<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_MI}">무통장입금</c:if>
							<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_EMI}">무통장입금(에스크로)</c:if>
                          	<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_KI}">카카오페이</c:if>
							<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_LI}">L.Point결제</c:if>
							<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_TC_WI}">탐나는전 PC결제</c:if>
							<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_TC_MI}">탐나는전 모바일결제</c:if>
						<!-- 카드결제 -->
						</td>
					</tr>
				</table>
			</article>
			<c:if test="${cancelYn == 'Y'}">
				<article class="payArea">
					<div class="title-bt">
						<h4>취소정보</h4>
					</div>
					<table>
						<tr>
                            <th>취소금액</th>
                            <td><fmt:formatNumber><c:out value="${rsvInfo.totalCancelAmt}"/></fmt:formatNumber></td>
                        </tr>
                        <tr>
                            <th>취소수수료금액</th>
                            <td><fmt:formatNumber><c:out value="${rsvInfo.totalCmssAmt}"/></fmt:formatNumber></td>
                        </tr>
                        <tr>
                            <th>할인취소금액</th>
                            <td><fmt:formatNumber><c:out value="${rsvInfo.totalDisCancelAmt}"/></fmt:formatNumber></td>
                        </tr>
					</table>
				</article>
			</c:if>
			<p class="btn-list">
				<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_READY and difTime > 0}">
					<c:if test="${rsvInfo.LGD_CASFLAGY eq 'R'}">
					<a href="<c:url value='/mw/orderCompleteVaccount.do?rsvNum=${rsvInfo.rsvNum}'/>" class="btn btn3">입금정보확인</a>
					</c:if>
					<c:if test="${rsvInfo.LGD_CASFLAGY ne 'R'}">
					<a href="<c:url value='/mw/order03.do?rsvNum=${rsvInfo.rsvNum}'/>" class="btn btn3">결제하기</a>
					</c:if>
					<a href="javascript:fn_OrderCancel();" class="btn btn4">취소</a>
				</c:if>
				<c:if test="${allCancelYn == 'N'}">
					<c:if test="${orderDiv eq 'SV'}">
						<a href="javascript:fn_ReqCancelPopAll();" class="btn btn2">전체취소요청</a>
					</c:if>
				</c:if>
			</p>
			<!--//layer-popup-->
			<div id="refundPopupArea" class="comm-layer-popup point-search">
				<div class="content-wrap">
					<div class="content">
						<div class="head">
							<h3 class="title">환불받으실 계좌번호</h3>
							<button type="button" id="refundPopupClose" class="close popup_close">
								<img src="<c:url value="/images/mw/icon/close/dark-gray.png"/>" alt="닫기">
							</button>
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
												<input type="number" id="refundAccNum" name="refundAccNum" value="${refundAccInf.accNum}" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" placeholder="숫자만가능합니다.">
											</div>
										</td>
									</tr>
									<tr>
										<th>입금자명</th>
										<td>
											<div class="input-btn-col2">
												<input type="text" id="refundDepositor" name="refundDepositor" value="${refundAccInf.depositorNm}" placeholder="입금자명이 정확해야 합니다.">
											</div>
										</td>
									</tr>
								</tbody>
							</table>

							<div class="popup-area-list">
								<ul class="list-disc">
									<button type="button" class="comm-btn red" id="refundItem" value="">취소진행</button>
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
						</div>
					</div>
				</div>
			</div>
			<!-- 부분취소 -->
			<div id="cancelPopup" class="comm-layer-popup point-search cancelPopup">
				<div class="content-wrap">
					<div class="content">
						<div class="head">
							<h3 class="title">예약(구매)취소</h3>
							<button type="button" id="cancelPopupClose" class="close popup_close">
								<img src="<c:url value="/images/mw/icon/close/dark-gray.png"/>" alt="닫기">
							</button>
						</div>

						<div class="main">
							<h5 class="sub-title">상품정보</h5>
							<div id="productInfo" class="productInfo"></div>
							<h5 class="sub-article">
								<b>* 할인쿠폰, 포인트 사용 건 취소 안내</b>
								<p>A. 취소 수수료 부과 시 수수료 적용 순서는 아래와 같습니다.</p>
								<p>포인트 → 결제금액 → 쿠폰 (수수료 발생 시 포인트부터 차감)</p>
								<p>B. 취소 시 조기마감 된 할인쿠폰은 재사용이 불가합니다.</p>
							</h5>

							<h5 class="sub-title"> 취소/환불규정</h5>
							<div id="cancelGuide" class="cancelGuide">
							</div>

							<h5 class="sub-title">취소사유</h5>
							<input type="text" id="cancelRsn" class="full cancelRsn" placeholder="취소사유를 입력해주세요" maxlength="300">

							<div class="popup-area-list">
								<div class="list-disc">
									<button type="button" class="comm-btn red" id="cancelBtn">취소진행</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 전체취소 -->
			<div id="cancelAllPopup" class="comm-layer-popup point-search cancelPopup">
				<div class="content-wrap">
					<div class="content">
						<div class="head">
							<h3 class="title">전체 취소 요청</h3>
							<button type="button" id="cancelAllPopupClose" class="close"><img src="<c:url value="/images/mw/icon/close/dark-gray.png"/>" alt="닫기"></button>
						</div>

						<div class="main">
							<c:forEach var="order" items="${orderList}" varStatus="status">
								<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_COM}">
									<h5 class="sub-title"><img src="<c:url value="/images/web/travel/sb.gif"/>" alt="말풍선"> 상품정보</h5>
									<div class="productInfo">
										<h5 class="product"><span>[${order.corpNm}] ${order.prdtNm}</span></h5>
										<p>${order.prdtInf}</p>
									</div>

									<h5 class="sub-title"><img src="<c:url value="/images/web/travel/sb.gif"/>" alt="말풍선"> 취소/환불규정</h5>
									<div class="cancelGuide">
										<c:out value="${order.cancelGuide}" escapeXml="false" />
									</div>
								</c:if>
							</c:forEach>

							<h5 class="sub-title"><img src="<c:url value="/images/web/travel/sb.gif"/>" alt="말풍선"> 취소사유</h5>
							<input type="text" id="cancelAllRsn" class="full cancelRsn" placeholder="취소사유를 입력해주세요" maxlength="300">

							<div class="popup-area-list">
								<div class="list-disc">
									<button type="button" class="comm-btn red" onclick="javascript:fn_ReqCancelAll();">전체취소진행</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<%--<c:if test="${rsvInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_COM }">
            	<img src="/data/prmt/adv/m1.jpg" class="width100" alt="면세점">
            </c:if>--%>

		</div>
	</div>
</section>
<!-- 콘텐츠 e -->

<!-- 셀러정보 팝업s -->
<div id="usePopup" class="comm-layer-popup pop-seller_ticket">
	<form name="useApprForm" id="useApprForm">
	<input type="hidden" name="prdtRsvNum" id="prdtRsvNum" />
	<div class="pw-form">
		<div class="head">
			<h5 class="title">해당 상품을 사용하시겠습니까?</h5>
			<button type="button" id="usePopupClose" class="close popup_close">
				<img src="/images/mw/icon/close/dark-gray.png" alt="닫기">
			</button>
		</div>
		<p class="sub_title">관광지 매표소 직원에게 보여주세요!</p>

		<p class="pw"><input type="number" name="usePwd" id="usePwd" class="full" placeholder="관리자 비밀번호 입력" maxlength="4"></p>
		<p class="sub_text">주의) 비밀번호 입력 시 사용처리 됩니다.</p>

		<div class="button">
			<a class="btn btn1" href="javascript:fn_spUseAppr();">확인</a>
			<a class="btn btn2" href="javascript:close_popup('#usePopup');">취소</a>
		</div>
	</div>
	</form>
</div>
<!-- 셀러정보 팝업e -->

<div class="pop-seller2 pop-seller_addr">
	<a class="btn-close2"><img src="<c:url value="/images/mw/sub_common/delete.png"/>" width="10" alt="닫기"></a>
	<div class="pw-form">
		<div class="info-text">
			<form name="f_changeDlv" id="f_changeDlv">
				<div class="int"><input type="text" name="useNm" id="useNm" placeholder="이름"></div>
				<div class="int"><input type="tel" name="useTelnum" id="useTelnum" placeholder="휴대폰"></div>
				<div class="addr-form">
					<div>
						<input class="num" type="text" name="postNum" id="postNum">
						<button type="button" class="btn" onclick="openDaumPostcode();">주소검색</button>
					</div>
					<div>
						<input class="addr1" type="text" name="roadNmAddr" id="roadNmAddr">
						<input class="addr2" type="text" name="dtlAddr" id="dtlAddr">
					</div>
				</div>
			</form>
		</div>

		<div class="button">
			<a class="btn btn1" href="javascript:fn_ChangeDlv();">확인</a>
			<a class="btn btn2 btn-close2" href="javascript:void(0)">취소</a>
		</div>
	</div>
</div>


<!-- 푸터 s -->
<jsp:include page="/mw/foot.do" />
<!-- 푸터 e -->
</div>

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
    	$(".btn-list").hide();
    }
}

$(document).ready(function() {
	if(timeLeft > 0) {
		itv = setInterval(updateLeftTime, 1000);
	} else {
		$(".sub").remove();
	}
});
</script>

</body>
</html>
