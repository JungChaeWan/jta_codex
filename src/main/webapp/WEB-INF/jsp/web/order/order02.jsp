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
	<jsp:include page="/web/includeJs.do"></jsp:include>

	<script language="javascript" src="//xpay.tosspayments.com/xpay/js/xpay_crossplatform.js" type="text/javascript"></script>

	<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css'/>" />



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
				data:parameters,
				success:function(data){
					if(data.success == "N") {
						alert("기결제된 예약건이거나 예약정보가 올바르지 않습니다.");
						return;
					} else {
						if(fn_AppCheck() != "PC") {
							if(confirm("올바르지 않은 유입 경로입니다.\n모바일 페이지를 이용해 예약하시겠습니까?")) {
								location.href = "<c:url value='/mw/order03.do'/>?rsvNum=${LGD_OID}";
							}
							return;
						}
						if(!$("#agree5").is(":checked")) {
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
									console.log(httpsStr);
									/*if($("#CST_PLATFORM").val() != "test"){
										httpsStr = data.tamnacardLinkUrl.replace("http","https");
									}*/
									var win =  window.open("tamnao.com", '_blank', "top=-20, left=10, width=800, height=900");
									win.document.write('<iframe width="100%", height="100%" src="'+httpsStr + '" frameborder="0" allowfullscreen></iframe>');
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
							if($(":radio[name=payWay]:checked").val() == "SC0060") {
								$("#CST_MID").val($("#CST_MID_HP").val());
								$("#LGD_HASHDATA").val($("#LGD_HASHDATA_HP").val());
								$("#LGD_MID").val($("#LGD_MID_HP").val());
							} else {
								$("#CST_MID").val($("#CST_MID_CO").val());
								$("#LGD_HASHDATA").val($("#LGD_HASHDATA_CO").val());
								$("#LGD_MID").val($("#LGD_MID_CO").val());
							}
							$("#LGD_CUSTOM_USABLEPAY").val($(":radio[name=payWay]:checked").val());

							if(fn_AppCheck() == "PC") {
								lgdwin = openXpay(document.getElementById('rsvFrm'), $("#CST_PLATFORM").val(), "iframe", null, "", "");

								$("#_lguplus_popup__div").css("z-index", "2147483646");
							} else {
								if(confirm("올바르지 않은 유입 경로입니다.\n모바일 페이지를 이용해 예약하시겠습니까?")) {
									location.href = "<c:url value='/mw/order03.do'/>?rsvNum=${LGD_OID}";
								}
								return;
							}
							</c:if>

							<c:if test="${rsvInfo.totalDisAmt eq 0 and rsvInfo.lpointUsePoint eq 0 and rsvInfo.totalSaleAmt eq 0  and usePoint eq 0}">
							alert("결제할 금액이 없습니다.");
							return;
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
							document.rsvFrm.action = "<c:url value='/web/order05.do'/>";
							document.rsvFrm.submit();
							</c:if>
						}
					}
				},
				error:fn_AjaxError
			});
		}

		/** 토스인증결과 처리 */
		function payment_return() {
			if($('#payWay4').is(':checked')) {
				document.location.hash = "SC0040";
			}
			var fDoc = lgdwin.contentWindow || lgdwin.contentDocument;
			if(fDoc.document.getElementById('LGD_RESPCODE').value == "0000") {
				$(".modal-spinner").show();
				var payKey = fDoc.document.getElementById("LGD_PAYKEY").value;
				$("#LGD_PAYKEY").val(payKey);
				$("#PayMethod").val("LG");
				doubleSubmitCheck();
				document.rsvFrm.target = "_self";
				document.rsvFrm.action = "<c:url value='/web/order05.do'/>";
				document.rsvFrm.submit();
			} else {
				alert("LGD_RESPCODE (결과코드) : " + fDoc.document.getElementById('LGD_RESPCODE').value + "\n" + "LGD_RESPMSG (결과메시지): " + fDoc.document.getElementById('LGD_RESPMSG').value);
			}
			closeIframe();
		}

		$(document).ready(function(){
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

			/** 뒤로가기시 무통장입금상태 유지 */
			if(document.location.hash){
				if(document.location.hash == "#SC0040" ){
					location.href = "/web/mypage/detailRsv.do?rsvNum=${LGD_OID}";
				}
			}

			/** PG사인지 탐나는전인지  */
			$("input[name='payWay']").change(function () {
				if($('input:radio[name="payWay"]:checked').val() == "SC0040" && flag == "N"){
					alert("무통장입금 결제 후 취소 시에는 환불 완료까지 영업일 기준 2~3일이 소요되오니 참고하여 주시기 바랍니다.");
					flag = "Y";
				}

				//에스크로 설정 (특산/기념품 실시간계좌이체 일 경우만)
				if ( '${orderDiv}' == '${Constant.SV}' && $('input:radio[name="payWay"]:checked').val() == "SC0030"){
					$("#LGD_ESCROW_USEYN").val("Y");
					$(".escrow-param").prop("disabled", false);
				}else{
					$("#LGD_ESCROW_USEYN").val("N");
					$(".escrow-param").prop("disabled", true);
				}

				/*if($(":radio[name=payWay]:checked").val() == "SC0050") {
					alert("탐나는전 결제는 현재 모바일로만 가능합니다.\r불편을 드려 죄송합니다.");
				}*/

				//간편결제 설정
				if (this.id == "payWay6" || this.id == "payWay7" || this.id == "payWay8" || this.id == "payWay9"){
					$("#LGD_EASYPAY_ONLY").val($(this).data('easypay'));
					$(".easypay-param").prop("disabled", false);
				}else{
					$("#LGD_EASYPAY_ONLY").val("");
					$(".easypay-param").prop("disabled", true);
				}
			});

			$("#appDiv").val(fn_AppCheck());


		});
	</script>

</head>
<body>
<header id="header">
	<jsp:include page="/web/head.do" />
</header>
<main id="main">
	<div class="mapLocation"> <!-- index page에서는 삭제 -->
		<div class="inner">
			<span>홈</span> <span class="gt">&gt;</span>
			<span>예약하기</span>
		</div>
	</div>
	<!-- quick banner -->
	<jsp:include page="/web/left.do" />
	<!-- //quick banner -->
	<div class="subContainer">
		<div class="subHead"></div>
		<div class="subContents">
			<!-- new contents -->
			<div class="lodge3">
				<div class="bgWrap2">
					<div class="Fasten">
						<div class="comm_pay">
							<div class="pay-title">
								<h2>결제하기</h2>
							</div>
							<article class="payArea">
								<form name="rsvFrm" id="rsvFrm" method="post" accept-charset="UTF-8">
									<%-- 토스 --%>
									<input type="hidden" name="LGD_RETURN_MERT_CUSTOM_PARAM"      id="LGD_RETURN_MERT_CUSTOM_PARAM"  value="Y">
									<input type="hidden" name="rsvNum" 					id="rsvNum" 					value="${LGD_OID}" />
									<input type="hidden" name="CST_PLATFORM" 			id="CST_PLATFORM" 				value="${CST_PLATFORM}" />	<!-- 테스트, 서비스 구분 -->
									<input type="hidden" name="CST_MID" 				id="CST_MID" 					value="${CST_MID}" />	<!-- 상점아이디 -->
									<input type="hidden" name="CST_MID_HP" 				id="CST_MID_HP" 				value="${CST_MID_HP}" />	<!-- 상점아이디 -->
									<input type="hidden" name="CST_MID_CO" 				id="CST_MID_CO" 				value="${CST_MID}" />	<!-- 상점아이디 -->
									<input type="hidden" name="CST_WINDOW_TYPE" 		id="CST_WINDOW_TYPE" 			value="submit" />
									<input type="hidden" name="LGD_MID" 				id="LGD_MID" 					value="${LGD_MID}" />	<!-- 상점아이디 -->
									<input type="hidden" name="LGD_MID_HP" 				id="LGD_MID_HP" 				value="${LGD_MID_HP}" />	<!-- 상점아이디 -->
									<input type="hidden" name="LGD_MID_CO" 				id="LGD_MID_CO" 				value="${LGD_MID}" />	<!-- 상점아이디 -->
									<input type="hidden" name="LGD_RETURNURL" 			id="LGD_RETURNURL" 				value="${LGD_RETURNURL}" />	<!-- 응답수신페이지 -->
									<input type="hidden" name="LGD_OID" 				id="LGD_OID" 					value="${LGD_OID}" />	<!-- 주문번호 -->
									<input type="hidden" name="LGD_BUYER" 				id="LGD_BUYER" 					value="${rsvInfo.rsvNm}" />	<!-- 구매자 -->
									<input type="hidden" name="LGD_PRODUCTINFO" 		id="LGD_PRODUCTINFO" 			value="탐나오 관광상품" />	<!-- 상품정보 -->
									<input type="hidden" name="LGD_AMOUNT" 				id="LGD_AMOUNT" 				value="${rsvInfo.totalSaleAmt}" />	<!-- 결제금액 -->
									<input type="hidden" name="LGD_BUYEREMAIL" 			id="LGD_BUYEREMAIL" 			value="${rsvInfo.rsvEmail}" />	<!-- 구매자 이메일 -->
									<input type="hidden" name="LGD_CUSTOM_SKIN" 		id="LGD_CUSTOM_SKIN" 			value="red" />	<!-- 결제창 SKIN -->
									<input type="hidden" name="LGD_CUSTOM_PROCESSTYPE" 	id="LGD_CUSTOM_PROCESSTYPE" 	value="TWOTR" />	<!-- 트랜잭션 처리방식 -->
									<input type="hidden" name="LGD_CUSTOM_SESSIONTIMEOUT" 	id="LGD_CUSTOM_SESSIONTIMEOUT" 	value="1200" />	<!-- 결제창 세션시간 -->
									<input type="hidden" name="LGD_TIMESTAMP" 			id="LGD_TIMESTAMP" 				value="${timeStamp}" />	<!-- 타임스탬프 -->
									<input type="hidden" name="LGD_HASHDATA" 			id="LGD_HASHDATA" 				value="${LGD_HASHDATA}" />	<!-- MD5 해쉬암호값 -->
									<input type="hidden" name="LGD_HASHDATA_HP" 		id="LGD_HASHDATA_HP" 			value="${LGD_HASHDATA_HP}" />	<!-- MD5 해쉬암호값-휴대폰 -->
									<input type="hidden" name="LGD_HASHDATA_CO" 		id="LGD_HASHDATA_CO" 			value="${LGD_HASHDATA}" />	<!-- MD5 해쉬암호값-다른 결제수단 -->
									<input type="hidden" name="LGD_VERSION" 			id="LGD_VERSION" 				value="JSP_SmartXPay_1.0" />	<!-- 버전정보 (삭제하지 마세요) -->
									<input type="hidden" name="LGD_WINDOW_VER" 			id="LGD_WINDOW_VER" 			value="2.5" />	<!-- 버전정보 (삭제하지 마세요) -->
									<input type="hidden" name="LGD_CUSTOM_USABLEPAY" 	id="LGD_CUSTOM_USABLEPAY" 		value="" />	<!-- 디폴트 결제수단 -->
									<input type="hidden" name="LGD_CUSTOM_SWITCHINGTYPE" id="LGD_CUSTOM_SWITCHINGTYPE" 	value="SUBMIT" />	<!-- 신용카드 카드사 인증 페이지 연동 방식 -->
									<input type="hidden" name="LGD_ENCODING" 			id="LGD_ENCODING" 				value="UTF-8" />
									<input type="hidden" name="LGD_ENCODING_NOTEURL" 	id="LGD_ENCODING_NOTEURL" 		value="UTF-8" />
									<input type="hidden" name="LGD_ENCODING_RETURNURL" 	id="LGD_ENCODING_RETURNURL" 	value="UTF-8" />
									<input type="hidden" name="LGD_PAYKEY" 				id="LGD_PAYKEY" 				value="">
									<input type="hidden" name="LGD_CASNOTEURL"			id="LGD_CASNOTEURL" 			value="${LGD_CASNOTEURL}">
									<input type="hidden" name="LGD_CLOSEDATE"			id="LGD_CLOSEDATE" 				value="">
									<input type="hidden" name="LGD_ESCROW_USEYN" 		id="LGD_ESCROW_USEYN" 	value="N" />	<!-- 에스크로 설정여부 -->
									<input type="hidden" name="LGD_OSTYPE_CHECK" 		id="LGD_OSTYPE_CHECK" 	value="P" />

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

									<h5 class="title">상품 정보</h5>
									<table class="commCol product-info">
										<c:if test="${orderDiv eq Constant.SV}">
											<colgroup>
												<col style="width: 10%">
												<col>
												<col style="width: 12%">
												<col style="width: 12%">
											</colgroup>
										</c:if>
										<thead>
										<tr>
											<th class="title1">구분</th>
											<th class="title2">상품정보</th>
											<th class="title3">상품금액</th>
											<c:if test="${orderDiv eq Constant.SV}">
												<th class="title5">배송비</th>
											</c:if>
<%--											<th class="title4">최종금액</th>--%>
										</tr>
										</thead>
										<tbody>
										<c:set var="totalDlvAmt" value="0" />
										<c:set var="sv_dlvFlag" value="NULL" />
										<c:set var="sv_dlvAmtDiv" value="NULL" />
										<c:set var="sv_pCorpId" value="NULL" />
										<c:set var="sv_prdc" value="NULL" />

										<c:forEach items="${orderList}" var="order" varStatus="status">
											<tr>
												<td>
													<c:out value="${order.prdtCdNm}"/>
												</td>
												<td class="left">
													<h5 class="product">
														<span class="cProduct">[<c:out value="${order.corpNm}"/>]<c:out value="${order.prdtNm}"/></span>
													</h5>
													<p class="infoText"><c:out value="${order.prdtInf}"/></p>
												</td>
												<td class="money">
													<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_READY}">
													<fmt:formatNumber><c:out value="${order.nmlAmt-order.dlvAmt}"/></fmt:formatNumber>원
													</c:if>
													<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_EXP}">
													<span class="nt">예약마감</span>
													</c:if>
												</td>
												<%--생산자별 묶음배송으로 로직 변경 (prdc 조건 추가) 2021.06.03 chaewan.jung --%>
												<c:if test="${orderDiv eq Constant.SV}">
													<c:if test="${(order.corpId ne sv_pCorpId) or (order.corpId eq sv_pCorpId and order.dlvAmtDiv ne sv_dlvAmtDiv)  or (order.directRecvYn ne sv_directRecvYn) or (order.prdc ne sv_prdc) or (order.dlvAmtDiv eq Constant.DLV_AMT_DIV_MAXI)}">
														<c:set var="c_row" value="0"/>
														<c:if test="${(Constant.DLV_AMT_DIV_APL eq order.dlvAmtDiv) or (Constant.DLV_AMT_DIV_FREE eq order.dlvAmtDiv) or (Constant.DLV_AMT_DIV_DLV eq order.dlvAmtDiv)}">
															<c:forEach items="${orderList}" var="sub_order" varStatus="sub_status">
																<c:if test="${(sub_order.corpId eq order.corpId) and (sub_order.dlvAmtDiv eq order.dlvAmtDiv) and (sub_cart.directRecvYn eq cart.directRecvYn) and (sub_order.prdc eq order.prdc)}">
																	<c:set var="c_row" value="${c_row + 1}"/>
																</c:if>
															</c:forEach>
														</c:if>
														<td class="shipping-fee" <c:if test="${c_row > 1 }"> rowspan="${c_row}" </c:if>>
															<c:set var="sv_dlvFlag" value="true"/>
															<c:set var="totalDlvAmt" value="${totalDlvAmt + order.dlvAmt}"/>
															<p class="price">
																<fmt:formatNumber><c:out value="${order.dlvAmt}"/></fmt:formatNumber>원</p>
														</td>
													</c:if>
													<c:set var="sv_pCorpId" value="${order.corpId}"/>
													<c:set var="sv_dlvAmtDiv" value="${order.dlvAmtDiv}"/>
													<c:set var="sv_prdc" value="${order.prdc}"/>
                                                    <c:set var="sv_directRecvYn" value="${order.directRecvYn}" />
													<%--에스크로 다수 상품 결제 파라미터 추가 2021.09.07 chaewan.jung--%>
													<input type="hidden" class="escrow-param" disabled name="LGD_ESCROW_GOODID" 	id="LGD_ESCROW_GOODID" 		value="${order.prdtRsvNum}" />	<!-- 에스크로 상품번호 -->
													<input type="hidden" class="escrow-param" disabled name="LGD_ESCROW_GOODNAME" 	id="LGD_ESCROW_GOODNAME" 	value="${order.prdtNm}" />	<!-- 에스크로 상품명 -->
													<input type="hidden" class="escrow-param" disabled name="LGD_ESCROW_GOODCODE" 	id="LGD_ESCROW_GOODCODE" 	value="${order.prdtNum}" />	<!-- 에스크로 상품코드 -->
													<input type="hidden" class="escrow-param" disabled name="LGD_ESCROW_UNITPRICE" id="LGD_ESCROW_UNITPRICE" 	value="${order.saleAmt}" />	<!-- 에스크로 상품금액 -->
													<input type="hidden" class="escrow-param" disabled name="LGD_ESCROW_QUANTITY" 	id="LGD_ESCROW_QUANTITY" 	value="1" />				<!-- 에스크로 상품수량 -->
												</c:if>
											</tr>
										</c:forEach>
										</tbody>
									</table>
								</form>
							</article>

							<article class="payArea payInfoWrap">
								<h5 class="title">결제정보 선택</h5>
								<table class="commRow">
									<tr>
										<th>일반결제</th>
										<td>
											<c:if test="${rsvInfo.totalSaleAmt ne 0}">
												<div class="paySelect">
													<c:if test="${onlyTamnacard ne 'Y' and param.mnuricard ne 'Y'}">
														<input id="payWay1" type="radio" name="payWay" value="SC0010" checked><label for="payWay1">신용카드</label>
														<input id="payWay2" type="radio" name="payWay" value="SC0060"><label for="payWay2">휴대폰</label>
<%--														<c:if test="${orderDiv ne Constant.SV}">--%>
															<input id="payWay3" type="radio" name="payWay" value="SC0030"><label for="payWay3">실시간계좌이체</label>
															<%--<input id="payWay4" type="radio" name="payWay" value="SC0040"><label for="payWay4">무통장입금</label>--%>
<%--														</c:if>--%>
													</c:if>
													<c:if test="${!empty rsvInfo.tamnacardLinkUrl and param.mnuricard ne 'Y'}">
														<input id="payWay5" type="radio" name="payWay" value="SC0050" <c:if test="${onlyTamnacard eq 'Y'}"> checked </c:if> ><label for="payWay5">탐나는전</label>
													</c:if>
													<c:if test="${param.mnuricard eq 'Y' }">
														<input id="payWay11" type="radio" name="payWay" value="SC0010" checked ><label for="payWay11">문화누리카드</label>
													</c:if>
												</div>
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
										</td>
									</tr>
									<c:if test="${rsvInfo.totalSaleAmt ne 0 and param.mnuricard ne 'Y'}">
									<tr>
										<th>간편결제</th>
										<td>
											<div class="paySelect">
												<c:if test="${onlyTamnacard ne 'Y' and param.mnuricard ne 'Y'}">
													<input id="payWay6" type="radio" name="payWay" value="SC0010" data-easypay="NAVERPAY"><label for="payWay6">네이버페이</label>
													<input id="payWay7" type="radio" name="payWay" value="SC0010" data-easypay="KAKAOPAY"><label for="payWay7">카카오페이</label>
													<%--<input id="payWay8" type="radio" name="payWay" value="SC0010" data-easypay="APPLEPAY"><label for="payWay8">애플페이</label>--%>
													<%--<input id="payWay9" type="radio" name="payWay" value="SC0010" data-easypay="TOSSPAY"><label for="payWay9">토스페이</label>--%>
												</c:if>
											</div>
										</td>
									</tr>
									</c:if>
								</table>
								<c:if test="${param.mnuricard eq 'Y' }">
								<span class="blinking" style="font-size: 12px;color:royalblue">* 문화누리카드로 이용 시, 실물카드와 신분증을 티켓발권 현장에서 제시하셔야 합니다.</span>
								</c:if>
								<span class="text-red" id="waitingTime3"></span>
							</article>

							<article class="payArea">
								<h4 class="comm-title2">결제정보</h4>
								<table class="commRow">
									<colgroup>
										<col style="width: 140px">
										<col style="width: 370px">
										<col style="width: 140px">
										<col>
									</colgroup>
									<tbody>
									<tr>
										<th>총상품금액</th>
										<td colspan="3" class="pay-st"><strong><fmt:formatNumber><c:out value="${rsvInfo.totalNmlAmt- totalDlvAmt}"/></fmt:formatNumber></strong>원</td>
									</tr>
									<tr>
										<th>쿠폰할인</th>
										<td colspan="3" class="sale">(-) <fmt:formatNumber><c:out value="${rsvInfo.totalDisAmt}"/></fmt:formatNumber>원</td>
									</tr>
									<c:if test="${rsvInfo.lpointUsePoint > 0 || rsvInfo.lpointSavePoint > 0}">
									<tr>
										<th>L.POINT 적용</th>
										<td>
											<div class="sale">(-) <fmt:formatNumber><c:out value="${rsvInfo.lpointUsePoint}"/></fmt:formatNumber> P</div>
										</td>
										<th>L.POINT 적립 예정</th>
										<td><fmt:formatNumber><c:out value="${rsvInfo.lpointSavePoint}"/></fmt:formatNumber> P</td>
									</tr>
									</c:if>
									<c:if test="${usePoint > 0}">
									<tr>
										<th>${rsvInfo.partnerNm} 포인트</th>
										<td colspan="3" class="sale">(-) <fmt:formatNumber><c:out value="${usePoint}"/></fmt:formatNumber>원</td>
									</tr>
									</c:if>
									<c:if test="${sv_dlvFlag}">
										<tr>
											<th>배송비</th>
											<td colspan="3" class="shipping"><fmt:formatNumber><c:out value="${totalDlvAmt}"/></fmt:formatNumber>원</td>
										</tr>
									</c:if>
									<tr>
										<th>최종결제금액</th>
										<td colspan="3" class="total-wrap pay-st">
											<strong class="comm-color1"><fmt:formatNumber><c:out value="${rsvInfo.totalSaleAmt}"/></fmt:formatNumber></strong>원
										</td>
									</tr>
									</tbody>
								</table>
							</article>

							<ul class="commList1">
								<li>패키지할인상품은 판매여행사의 예약확인 통화를 하신 후 예약이 확정됨을 양해바랍니다.</li>
								<li>관광지 / 레저 / 음식,뷰티 이용권은 유효기간과 사용법을 숙지바랍니다.</li>
								<li>모든 상품의 취소환불규정을 숙지바랍니다.</li>
								<li>탐나오는 오픈마켓으로 통신판매 중개자이며 통신판매의 당사자가 아닙니다.</li>
							</ul>

							<div class="comm-agree1">
								<p class="memo">구매내역 등을 최종 확인했으며, 구매에 동의하시겠습니까?</p>
								<p class="agree">
									<input id="agree5" type="checkbox">
									<label for="agree5"><strong class="big">동의합니다.</strong></label> <span>(전자금융거래법 제 7조 제 1항)</span>
								</p>
							</div>

							<p class="comm-button4"><a href="javascript:fn_Buy();" class="color1" id="btnBuy">결제하기</a></p>
							<%--<span class="text-red" id="waitingTime"></span>--%>
							<div class="modal-spinner">
								<div class="popBg"></div>
								<div class="loading-popup">
									<div class="spinner-con">
										<strong class="spinner-txt">제주여행 공공 플랫폼 탐나오</strong>
										<div class="spinner-sub-txt">
											<span>실시간 가격 비교</span>
										</div>
										<div class="spinner-sub-txt">
											<span>믿을 수 있는 상품 구매</span>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div> <!--//Fasten-->
				</div> <!--bgWrap-->
			</div> <!-- //lodge3 -->
			<!-- //new contents -->
		</div> <!-- //subContents -->
	</div> <!-- //subContainer -->

</main>
<jsp:include page="/web/foot.do" />

<!-- 다음 유입추적 2018.02.01 By JS -->
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

			/*$("#waitingTime").html("남은시간 " + msg);*/

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
		if(timeLeft > 0) {
			itv = setInterval(updateLeftTime, 1000);
		} else {
			$("#btnBuy").remove();
			$("#waitingTime").html("결제시간 초과");
			$("#waitingTime3").html("결제시간 초과");
		}
	});
</script>

</body>
</html>