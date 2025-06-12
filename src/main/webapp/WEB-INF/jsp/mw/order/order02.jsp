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
<meta name="robots" content="noindex, nofollow">
<jsp:include page="/mw/includeJs.do" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub_cart.css'/>">

<script language="javascript" src="//xpay.tosspayments.com/xpay/js/xpay_crossplatform.js" type="text/javascript"></script>

<script type="text/javascript">
	let doubleSubmitFlag = false;
	function doubleSubmitCheck() {
		if(doubleSubmitFlag) {
			return doubleSubmitFlag;
		} else {
			doubleSubmitFlag = true;
			return false;
		}
	}

	console.log("고객님의 현재 IP " + "${connIp}");
let flag = "N";

function fn_Buy(){
	if(doubleSubmitFlag) {
		return;
	}
	if(!$(":radio[name=payWay]:checked").val() && "${rsvInfo.lpointUsePoint}" == "0" && "${usePoint}" == "0" ){
		alert("결제방식을 선택하셔야 합니다.");
		return;
	}

    if($(".nt").text().match("예약마감")){
        alert("예약마감된 상품이 있어 결제하실 수 없습니다.");
		return;
	}
	let parameters = $("#rsvFrm").serialize();
	$.ajax({
		type:"post",
		url:"<c:url value='/web/orderChk.ajax'/>",
		data:parameters ,
		success:function(data){
			if(data.success == "N"){
				alert("기결제된 예약건이거나 예약정보가 올바르지 않습니다.");
				return;
			}else{
				if(!$("#agree5").is(":checked")){
					alert("구매동의에 체크하셔야 합니다.");
					return;
				}

				/** 탐나는전 */
				if($(":radio[name=payWay]:checked").val() == "SC0050") {
					$.ajax({
						url :"<c:url value='/web/openTamnacard2.ajax'/>",
						data : parameters,
						success: function(data) {
							let httpsStr = data.tamnacardLinkUrl;

							window.location.replace(httpsStr);
							/*location.href = "/mw/order/orderTamnacard.do?tamnacardLinkUrl=" + httpsStr;*/
						},
						error : fn_AjaxError
					})
				/** PG사 */
				}else{
					<c:if test="${rsvInfo.totalSaleAmt ne 0}">
					// 할인쿠폰, L.Point 및 파트너포인트 사용 시 무료가 아니면...
					if("${rsvInfo.totalNmlAmt - rsvInfo.totalDisAmt - rsvInfo.lpointUsePoint - usePoint}" != "${rsvInfo.totalSaleAmt}") {
						alert("결제할 금액이 없습니다.");
						return;
					}
					/** 휴대폰 결제*/
					if($(":radio[name=payWay]:checked").val() == "SC0060"){
						$("#CST_MID").val($("#CST_MID_HP").val());
						$("#LGD_HASHDATA").val($("#LGD_HASHDATA_HP").val());
						$("#LGD_MID").val($("#LGD_MID_HP").val());
						$("#LGD_RETURNURL").val($("#LGD_RETURNURL_HP").val());
					}else{
						$("#CST_MID").val($("#CST_MID_CO").val());
						$("#LGD_HASHDATA").val($("#LGD_HASHDATA_CO").val());
						$("#LGD_MID").val($("#LGD_MID_CO").val());
						$("#LGD_RETURNURL").val($("#LGD_RETURNURL_CO").val());
					}
					$("#LGD_CUSTOM_USABLEPAY").val($(":radio[name=payWay]:checked").val());

					if(fn_AppCheck() == "IW"){
						$("#LGD_KVPMISPAUTOAPPYN").val("N");
						$("#LGD_MTRANSFERAUTOAPPYN").val("N");
					}
					$("#PayMethod").val("LG");
					if($('#payWay4').is(':checked')){
						document.location.hash = "SC0040";
					}
					lgdwin = open_paymentwindow(document.getElementById('rsvFrm'), $("#CST_PLATFORM").val(), "submit");
					</c:if>

					<c:if test="${(rsvInfo.totalDisAmt ne 0 or rsvInfo.lpointUsePoint ne 0 or usePoint ne 0) and rsvInfo.totalSaleAmt eq 0}">
					// 할인쿠폰, L.Point, 파트너포인트 사용 시 무료이면 바로 예약 완료 페이지로...
					if("${rsvInfo.totalDisAmt}" == "${rsvInfo.totalSaleAmt}" && ${rsvInfo.lpointUsePoint} == 0 && ${usePoint}  == 0) {// 무료 쿠폰 사용이면
						$("#PayMethod").val("FREECP");
					} else if("${rsvInfo.lpointUsePoint}" == "${rsvInfo.totalSaleAmt}" && ${rsvInfo.totalDisAmt} == 0 && ${usePoint} == 0 ) {// L.Point 사용이면
						$("#PayMethod").val("LPOINT");
					} else if("${rsvInfo.lpointUsePoint + rsvInfo.totalDisAmt}" == "${rsvInfo.totalNmlAmt}"){
						$("#PayMethod").val("LPOINT");
					}else if("${usePoint}" == "${rsvInfo.totalSaleAmt}" && ${rsvInfo.lpointUsePoint} == 0 && ${rsvInfo.totalDisAmt} == 0 ) {// 파트너(협력사)포인트 사용이면
						$("#PayMethod").val("POINT");
					}else if("${usePoint + rsvInfo.totalDisAmt}" == "${rsvInfo.totalNmlAmt}"){
						$("#PayMethod").val("POINT");
					}

					doubleSubmitCheck();
					document.rsvFrm.action = "<c:url value='/mw/order04.do'/>";
					document.rsvFrm.submit();
					</c:if>
				}
			}

		},
		error:fn_AjaxError
	});
}

$(document).ready(function(){

	//애플페이 show
	if ( fn_AppCheck() == "IA" || fn_AppCheck() == "IW"){
		$("#divPayWay8").show();
	}

	$("input[name='payWay']").change(function () {
		//에스크로 설정 (특산/기념품 실시간계좌이체 일 경우만)
		if ( '${orderDiv}' == '${Constant.SV}' && $('input:radio[name="payWay"]:checked').val() == "SC0030"){
			$("#LGD_ESCROW_USEYN").val("Y");
			$(".escrow-param").prop("disabled", false);
		}else{
			$("#LGD_ESCROW_USEYN").val("N");
			$(".escrow-param").prop("disabled", true);
		}

		/** 간편결제 설정*/
		if (this.id == "payWay6" || this.id == "payWay7" || this.id == "payWay8" || this.id == "payWay9"){
			$("#LGD_EASYPAY_ONLY").val($(this).data('easypay'));
			$(".easypay-param").prop("disabled", false);

			//간편결제 인증 후 app으로 이동
			if (fn_AppCheck() == "IA"){
				$("#LGD_MONEPAYAPPYN").val("Y");
				$("#LGD_MONEPAY_RETURNURL").val("tamnao");
			}
			// if (fn_AppCheck() == "AA"){
			// 	$("#LGD_MONEPAYAPPYN").val("Y");
			// 	$("#LGD_MONEPAY_RETURNURL").val("스키마 setting ~~~~~~");
			// }

		}else{
			$("#LGD_EASYPAY_ONLY").val("");
			$("#LGD_MONEPAYAPPYN").val("N");
			$("#LGD_MONEPAY_RETURNURL").val("");
			$(".easypay-param").prop("disabled", true);
		}
	});
});
</script>
</head>
<body>
<div id="wrap">

<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do" >
		<jsp:param name="headTitle" value="결제"/>
	</jsp:include>
</header>
<!-- 헤더 e -->

<!-- 콘텐츠 s -->
<h2 class="sr-only">서브콘텐츠</h2>
<section id="subContent" class="transBG">

	<div class="menu-bar">
		<p class="btn-prev"><img src="/images/mw/common/btn_prev.png" width="20" alt="이전페이지"></p>
		<h2>결제하기</h2>
	</div>
	<div class="sub-content">
		<div class="reserve">
			<form name="rsvFrm" id="rsvFrm" method="post" accept-charset="UTF-8">
				<input type="hidden" name="rsvNum" 					id="rsvNum" 					value="${LGD_OID}" />
				<input type="hidden" name="CST_PLATFORM" 			id="CST_PLATFORM" 				value="${CST_PLATFORM}" />	<!-- 테스트, 서비스 구분 -->
				<input type="hidden" name="CST_MID" 				id="CST_MID" 					value="${CST_MID}" />		<!-- 상점아이디 -->
				<input type="hidden" name="CST_MID_HP" 				id="CST_MID_HP" 				value="${CST_MID_HP}" />	<!-- 상점아이디 -->
				<input type="hidden" name="CST_MID_CO" 				id="CST_MID_CO" 				value="${CST_MID}" />	<!-- 상점아이디 -->
				<input type="hidden" name="CST_WINDOW_TYPE" 		id="CST_WINDOW_TYPE" 			value="submit" />
				<input type="hidden" name="LGD_MID" 				id="LGD_MID" 					value="${LGD_MID}" />		<!-- 상점아이디 -->
				<input type="hidden" name="LGD_MID_HP" 				id="LGD_MID_HP" 				value="${LGD_MID_HP}" />	<!-- 상점아이디 -->
				<input type="hidden" name="LGD_MID_CO" 				id="LGD_MID_CO" 				value="${LGD_MID}" />	<!-- 상점아이디 -->
				<input type="hidden" name="LGD_RETURNURL" 			id="LGD_RETURNURL" 				value="${LGD_RETURNURL}?rsvNum=${LGD_OID}" />	<!-- 응답수신페이지 -->
				<input type="hidden" name="LGD_RETURNURL_HP" 		id="LGD_RETURNURL_HP" 			value="${LGD_RETURNURL_HP}?rsvNum=${LGD_OID}" />	<!-- 응답수신페이지 -->
				<input type="hidden" name="LGD_RETURNURL_CO" 		id="LGD_RETURNURL_CO" 			value="${LGD_RETURNURL}?rsvNum=${LGD_OID}" />	<!-- 응답수신페이지 -->

				<input type="hidden" name="LGD_OID" 				id="LGD_OID" 					value="${LGD_OID}" />		<!-- 주문번호 -->
				<input type="hidden" name="LGD_BUYER" 				id="LGD_BUYER" 					value="${rsvInfo.rsvNm}" />	<!-- 구매자 -->
				<input type="hidden" name="LGD_PRODUCTINFO" 		id="LGD_PRODUCTINFO" 			value="탐나오 관광상품" />	<!-- 상품정보 -->
				<input type="hidden" name="LGD_AMOUNT" 				id="LGD_AMOUNT" 				value="${rsvInfo.totalSaleAmt}" />	<!-- 결제금액 -->
				<input type="hidden" name="LGD_BUYEREMAIL" 			id="LGD_BUYEREMAIL" 			value="${rsvInfo.rsvEmail}" />	<!-- 구매자 이메일 -->
				<input type="hidden" name="LGD_CUSTOM_SKIN" 		id="LGD_CUSTOM_SKIN" 			value="red" />				<!-- 결제창 SKIN -->
				<input type="hidden" name="LGD_CUSTOM_PROCESSTYPE" 	id="LGD_CUSTOM_PROCESSTYPE" 	value="TWOTR" />			<!-- 트랜잭션 처리방식 -->
				<input type="hidden" name="LGD_TIMESTAMP" 			id="LGD_TIMESTAMP" 				value="${timeStamp}" />		<!-- 타임스탬프 -->
				<input type="hidden" name="LGD_HASHDATA" 			id="LGD_HASHDATA" 				value="${LGD_HASHDATA}" />	<!-- MD5 해쉬암호값 -->
				<input type="hidden" name="LGD_HASHDATA_HP" 		id="LGD_HASHDATA_HP" 			value="${LGD_HASHDATA_HP}" />	<!-- MD5 해쉬암호값-휴대폰 -->
				<input type="hidden" name="LGD_HASHDATA_CO" 		id="LGD_HASHDATA_CO" 			value="${LGD_HASHDATA}" />	<!-- MD5 해쉬암호값-다른 결제수단 -->
				<input type="hidden" name="LGD_MTRANSFERAUTOAPPYN" 	id="LGD_MTRANSFERAUTOAPPYN" 	value="A" />	<!-- 계좌이체 결제처리방식(동기/비동기) -->

				<input type="hidden" name="LGD_VERSION" 			id="LGD_VERSION" 				value="JSP_SmartXPay_1.0" />	<!-- 버전정보 (삭제하지 마세요) -->
				<input type="hidden" name="LGD_WINDOW_VER" 			id="LGD_WINDOW_VER" 			value="2.5" />				<!-- 버전정보 (삭제하지 마세요) -->
				<input type="hidden" name="LGD_CUSTOM_USABLEPAY" 	id="LGD_CUSTOM_USABLEPAY" 		value="" />					<!-- 디폴트 결제수단 -->
				<input type="hidden" name="LGD_CUSTOM_SWITCHINGTYPE" id="LGD_CUSTOM_SWITCHINGTYPE" 	value="IFRAME" />			<!-- 신용카드 카드사 인증 페이지 연동 방식 -->
				<input type="hidden" name="LGD_CUSTOM_SESSIONTIMEOUT" 	id="LGD_CUSTOM_SESSIONTIMEOUT" 	value="1200" />	<!-- 결제창 세션시간 -->

				<input type="hidden" name="LGD_ENCODING" 			id="LGD_ENCODING" 				value="UTF-8" />
				<input type="hidden" name="LGD_ENCODING_NOTEURL" 	id="LGD_ENCODING_NOTEURL" 		value="UTF-8" />
				<input type="hidden" name="LGD_ENCODING_RETURNURL" 	id="LGD_ENCODING_RETURNURL" 	value="UTF-8" />
				<input type="hidden" name="LGD_PAYKEY" 				id="LGD_PAYKEY" 				value="">
				<input type="hidden" name="LGD_KVPMISPAUTOAPPYN" 	id="LGD_KVPMISPAUTOAPPYN" 		value="A" />
				<input type="hidden" name="LGD_KVPMISPWAPURL" 		id="LGD_KVPMISPWAPURL" 			value="tamnao://" />
				<input type="hidden" name="LGD_KVPMISPCANCELURL" 	id="LGD_KVPMISPCANCELURL" 		value="tamnao://" />
				<input type="hidden" name="LGD_CASNOTEURL"			id="LGD_CASNOTEURL" 			value="${LGD_CASNOTEURL}">
				<input type="hidden" name="LGD_CLOSEDATE"			id="LGD_CLOSEDATE" 				value="">
                <input type="hidden" name="LGD_ESCROW_USEYN" 	    id="LGD_ESCROW_USEYN" 			value="N" /> <!-- 에스크로 설정여부 -->
				<input type="hidden" name="LGD_CARDTYPE" 	    id="LGD_CARDTYPE" 			value="91" /> <!-- 에스크로 설정여부 -->

				<%--문화누리카드 --%>
				<c:if test="${param.mnuricard eq 'Y' }">
				<input type="hidden" name="LGD_CARDTYPE" 		id="LGD_CARDTYPE" 	value="91" />
				<input type="hidden" name="LGD_SELF_CUSTOM" 		id="LGD_SELF_CUSTOM" 	value="Y" />
				</c:if>
				<%-- 탐나오 --%>
				<input type="hidden" name="PayMethod" 		id="PayMethod" value="" />
				<input type="hidden" name="repPrdtNm" value="${repPrdtNm}"/>
				<input type="hidden" name="appDiv" id="appDiv">

				<!-- 간편결제 직호출(허브형) 파라미터 -->
				<input type="hidden" class="easypay-param" disabled name="LGD_SELF_CUSTOM" 	id="LGD_SELF_CUSTOM" 		value="N" />
				<input type="hidden" class="easypay-param" disabled name="LGD_EASYPAY_ONLY" id="LGD_EASYPAY_ONLY" 		value="" />
				<input type="hidden" class="easypay-param" disabled name="LGD_MONEPAYAPPYN" id="LGD_MONEPAYAPPYN" 		value="N" />
				<input type="hidden" class="easypay-param" disabled name="LGD_MONEPAY_RETURNURL" id="LGD_MONEPAY_RETURNURL" value="" />

			</form>
			<c:set var="totalDlvAmt" value="0" />
			<c:forEach items="${orderList}" var="order" varStatus="status">
				<dl class="goods-info">
					<dt><strong><c:out value="${order.prdtCdNm}"/></strong></dt>
					<dd>
						[<c:out value="${order.corpNm}"/>]<c:out value="${order.prdtNm}"/><br>
						<c:out value="${order.prdtInf}"/>
					</dd>
				</dl>
				<c:if test="${orderDiv ne Constant.SV}">
					<dl class="goods-price">
						<dt>상품금액</dt>
						<dd><fmt:formatNumber><c:out value="${order.nmlAmt}"/></fmt:formatNumber>원<br><em>(-<fmt:formatNumber><c:out value="${order.disAmt}"/></fmt:formatNumber>)</em></dd>
						<dt>최종금액</dt>
						<dd>
							<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_READY}">
								<fmt:formatNumber><c:out value="${order.saleAmt}"/></fmt:formatNumber>원
							</c:if>
							<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_EXP}">
								<span class="nt">예약마감</span>
							</c:if>
						</dd>
					</dl>
				</c:if>
				<c:if test="${orderDiv eq Constant.SV}">
					<dl class="goods-price line">
						<dt>
							<p>상품금액</p>
							<p>쿠폰할인</p>
							<p>배송비</p>
						</dt>
						<dd>
							<p><fmt:formatNumber><c:out value="${order.nmlAmt - order.dlvAmt}"/></fmt:formatNumber>원</p>
							<p>(-<fmt:formatNumber><c:out value="${order.disAmt}"/></fmt:formatNumber>)</p>
							<p><fmt:formatNumber><c:out value="${order.dlvAmt}"/></fmt:formatNumber></p>
							<c:set var="totalDlvAmt" value="${totalDlvAmt + order.dlvAmt}" />
						<dt>최종금액</dt>
						<dd>
							<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_READY}">
								<fmt:formatNumber><c:out value="${order.saleAmt}"/></fmt:formatNumber>원
							</c:if>
							<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_EXP}">
								<span class="nt">예약마감</span>
							</c:if>
						</dd>
					</dl>

					<%--에스크로 다수 상품 결제 파라미터 추가 2023.05.18 chaewan.jung--%>
					<input type="hidden" class="escrow-param" disabled name="LGD_ESCROW_GOODID" 	id="LGD_ESCROW_GOODID" 		value="${order.prdtRsvNum}" />	<!-- 에스크로 상품번호 -->
					<input type="hidden" class="escrow-param" disabled name="LGD_ESCROW_GOODNAME" 	id="LGD_ESCROW_GOODNAME" 	value="${order.prdtNm}" />	<!-- 에스크로 상품명 -->
					<input type="hidden" class="escrow-param" disabled name="LGD_ESCROW_GOODCODE" 	id="LGD_ESCROW_GOODCODE" 	value="${order.prdtNum}" />	<!-- 에스크로 상품코드 -->
					<input type="hidden" class="escrow-param" disabled name="LGD_ESCROW_UNITPRICE" id="LGD_ESCROW_UNITPRICE" 	value="${order.saleAmt}" />	<!-- 에스크로 상품금액 -->
					<input type="hidden" class="escrow-param" disabled name="LGD_ESCROW_QUANTITY" 	id="LGD_ESCROW_QUANTITY" 	value="1" />				<!-- 에스크로 상품수량 -->
				</c:if>
			</c:forEach>

			<h2>일반결제</h2>
			<p class="payment bt-none">

			<c:if test="${rsvInfo.totalSaleAmt ne 0}">
				<c:if test="${onlyTamnacard ne 'Y' and param.mnuricard ne 'Y'}">
					<input id="payWay1" type="radio" name="payWay" value="SC0010" checked><label for="payWay1">신용카드</label>
					<input id="payWay2" type="radio" name="payWay" value="SC0060"><label for="payWay2">휴대폰</label>
<%--						<c:if test="${orderDiv ne Constant.SV}">--%>
						<input id="payWay3" type="radio" name="payWay" value="SC0030"><label for="payWay3">실시간계좌이체</label>

						<%--<input style id="payWay4" type="radio" name="payWay" value="SC0040"><label for="payWay4">무통장입금</label>--%>
<%--						</c:if>--%>
				</c:if>
				<c:if test="${!empty rsvInfo.tamnacardLinkUrl and param.mnuricard ne 'Y'}">
				<input id="payWay5" type="radio" name="payWay" value="SC0050" <c:if test="${onlyTamnacard eq 'Y'}"> checked </c:if> ><label for="payWay5">탐나는전</label>
				</c:if>
				<c:if test="${param.mnuricard eq 'Y' }">
					<input id="payWay11" type="radio" name="payWay" value="SC0010" checked ><label for="payWay11">문화누리카드</label>
					<span style="font-size: 12px;color: royalblue">* 문화누리카드로 이용 시, 실물카드와 신분증을 티켓발권 현장에서 제시하셔야 합니다.</span>
				</c:if>
			</c:if>
			<c:if test="${rsvInfo.totalDisAmt ne 0 and rsvInfo.totalSaleAmt eq 0 and rsvInfo.lpointUsePoint eq 0  and rsvInfo.usePoint eq 0}">
				무료 할인쿠폰
			</c:if>
			<c:if test="${rsvInfo.lpointUsePoint ne 0 and rsvInfo.totalSaleAmt eq 0}">
				L.Point 결제
			</c:if>
			<c:if test="${rsvInfo.usePoint ne 0 and rsvInfo.totalSaleAmt eq 0}">
				${rsvInfo.partnerNm} 포인트 결제
			</c:if>
			</p>

			<c:if test="${rsvInfo.totalSaleAmt ne 0 and param.mnuricard ne 'Y'}">
			<h2>간편결제</h2>
			<p class="payment bt-none">
				<c:if test="${onlyTamnacard ne 'Y'}">
					<input id="payWay6" type="radio" name="payWay" value="SC0010" data-easypay="NAVERPAY">
					<label for="payWay6" class="naver-pay">
						<img src="/images/mw/etc/naver_pay.png" alt="네이버간편결제">
					</label>
					<input id="payWay7" type="radio" name="payWay" value="SC0010" data-easypay="KAKAOPAY">
					<label for="payWay7" class="kakao-pay">
						<img src="/images/mw/etc/kakao_pay.png" alt="카카오간편결제">
					</label>
					<a id="divPayWay8" style="display: none">
						<input id="payWay8" type="radio" name="payWay" value="SC0010" data-easypay="APPLEPAY">
						<label for="payWay8" class="apple-pay">
							<img src="/images/mw/etc/apple_pay.png" alt="애플간편결제">
						</label>
					</a>
                    <%--<input id="payWay9" type="radio" name="payWay" value="SC0010" data-easypay="TOSSPAY">
                    <label for="payWay9" class="toss-pay">
                        <img src="/images/mw/etc/toss_pay.png" alt="토스간편결제">
                    </label>--%>
				</c:if>
			</p>
			</c:if>




			<p id="waitingTime3" class="text-red"><%--남은시간<b>20분30초</b>--%></p>

			<h2>결제하기</h2>
			<dl class="total bt-none">
				<dt>총 상품금액</dt>
				<dd>
					<strong><fmt:formatNumber><c:out value="${rsvInfo.totalNmlAmt - totalDlvAmt}"/></fmt:formatNumber>원</strong><br>
					<p>쿠폰할인 (-) <span><fmt:formatNumber><c:out value="${rsvInfo.totalDisAmt}"/></fmt:formatNumber></span>원</p>
					<c:if test="${rsvInfo.lpointUsePoint > 0 || rsvInfo.lpointSavePoint > 0}">
					<p>L.POINT 할인	(-) <span><fmt:formatNumber><c:out value="${rsvInfo.lpointUsePoint}"/></fmt:formatNumber></span>P</p>
					<p>L.POINT 적립 예정 <span><fmt:formatNumber><c:out value="${rsvInfo.lpointSavePoint}"/></fmt:formatNumber></span>P</p>
					</c:if>
					<c:if test="${usePoint > 0}">
						<p>${rsvInfo.partnerNm}포인트 (-) <span><fmt:formatNumber><c:out value="${usePoint}"/></fmt:formatNumber></span>P</p>
					</c:if>
					<c:if test="${orderDiv eq Constant.SV }">
						<p>총 배송비 <fmt:formatNumber>${totalDlvAmt}</fmt:formatNumber>원</p>
					</c:if>
				</dd>
			</dl>
			<dl class="total bt-none">
				<dt>최종결제금액</dt>
				<dd>
					<strong class="red"><fmt:formatNumber><c:out value="${rsvInfo.totalSaleAmt}"/></fmt:formatNumber>원</strong><br>
				</dd>
			</dl>

			<article class="info-wrap info-wrap2">
				<ul>
                    <li>1 .패키지할인상품은 판매여행사의 예약확인 통화를 하신 후 예약이 확정됨을 양해바랍니다.</li>
                    <li>2 .관광지 / 레저 / 음식,뷰티 이용권은 유효기간과 사용법을 숙지바랍니다.</li>
                    <li>3. 모든 상품의 취소환불규정을 숙지바랍니다.</li>
					<li>4. <span class="text-red">탐나오는 오픈마켓으로 통신판매 중개자이며 통신판매의 당사자가 아닙니다.</span></li>
				</ul>
			</article>

			<p class="pament-agree bt-none">
				구매내역 등을 최종 확인했으며, 구매에 동의하시겠습니까?<br>
                <input type="checkbox" id="agree5">
				<label for="agree5">동의합니다. (전자금융거래법 제 7조 제 1항)</label>
			</p>

			<p>
				<span id="waitingTime"><%--남은시간<b>20분30초</b>--%></span>
				<a href="javascript:fn_Buy();" class="btn btn1" id="btnBuy">결제하기</a>
			</p>
		</div>
	</div>
</section>
<div class="option-wrap"></div>
<!-- 콘텐츠 e -->
<!-- 푸터 s -->
<jsp:include page="/mw/foot.do" />
<!-- 푸터 e -->
</div>

<div id="kakaopay_layer"  style="display: none"></div>

<iframe name="txnIdGetterFrame" id="txnIdGetterFrame" src=""  width="0" height="0"></iframe>

<!-- 다음 전환추적 2018.02.01 By JS  -->
<script type="text/javascript">
	var DaumConversionDctSv="type=W,orderID=${rsvInfo.rsvNum},amount=${rsvInfo.totalSaleAmt}";
	var DaumConversionAccountID="U5sW2MKXVzOa73P2jSFYXw00";
	if(typeof DaumConversionScriptLoaded=="undefined"&&location.protocol!="file:"){
		var DaumConversionScriptLoaded=true;
		document.write(unescape("%3Cscript%20type%3D%22text/javas"+"cript%22%20src%3D%22"+(location.protocol=="https:"?"https":"http")+"%3A//t1.daumcdn.net/cssjs/common/cts/vr200/dcts.js%22%3E%3C/script%3E"));
	}
</script>


<script type="text/javascript">
	var itv;
	var timeLeft = "<c:out value='${difTime}' />";

	$("#LGD_CLOSEDATE").val(${closeTime});

	var updateLeftTime = function() {
		timeLeft = (timeLeft <= 0) ? 0 : -- timeLeft;
		/** 결제창 세션시간 계산 */
		$("#LGD_CUSTOM_SESSIONTIMEOUT").val(timeLeft);

		if(timeLeft > 0) {
			var hours = Math.floor(timeLeft / 3600);
			var minutes = Math.floor((timeLeft - 3600 * hours) / 60);
			var seconds = timeLeft % 60;

			var msg = "<b>";
			if(minutes > 0) {
				msg += minutes + "분 ";
			}
			msg += seconds + "초</b>";

			$("#waitingTime").html("남은시간 " + msg);

			var orderType = "예약이";
			<c:if test="${orderDiv eq Constant.SV}">
				orderType = "구매가";
			</c:if>

			$("#waitingTime3").html(msg + " 후에는 " + orderType + " 자동취소됩니다.");
		} else {
			$("#waitingTime").html("결제시간 초과");
			$("#waitingTime3").html("결제시간 초과");
			$("#btnBuy").remove();
			clearInterval(itv);
		}
	}

	$(document).ready(function() {

		/** 중복클릭방지 */
		let lastClickTime = 0;

		$("#btnBuy").click(function(e){
			const currentTime = new Date().getTime();
			const timeDiff = currentTime - lastClickTime;

			// 일정 시간(예: 500ms) 이내에 다시 클릭한 경우 이벤트를 무시
			if (timeDiff < 10000) {
				e.preventDefault();
				return;
			}
			lastClickTime = currentTime;
		});

	    if(document.location.hash){
			console.log(document.location.hash);
			if(document.location.hash == "#SC0040" ){
				location.href = "/mw/mypage/detailRsv.do?rsvNum=${LGD_OID}";
			}
     	}

		if(timeLeft > 0) {
			itv = setInterval(updateLeftTime, 1000);
		} else {
			$("#btnBuy").remove();
			$("#waitingTime").html("결제시간 초과");
			$("#waitingTime3").html("결제시간 초과");
		}

		$("input[name='payWay']").change(function () {
			if($('input:radio[name="payWay"]:checked').val() == "SC0040" && flag == "N"){
				alert("무통장입금 결제 후 취소 시에는 환불 완료까지 영업일 기준 2~3일이 소요되오니 참고하여 주시기 바랍니다.");
				flag = "Y";
				return;
			}
		});

		$("#appDiv").val(fn_AppCheck());

	});
</script>
</body>
</html>
