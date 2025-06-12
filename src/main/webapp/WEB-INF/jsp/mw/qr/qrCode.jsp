<!DOCTYPE html>
<html lang="ko">
<%@page import="java.awt.print.Printable"%>
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
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta name="author" content="nextez">
	<meta name="format-detection" content="telephone=no">
	<meta name="apple-mobile-web-app-capable" content="yes">
	
	<!-- css -->	
	<link rel="stylesheet" href="<c:url value='/css/comm/jquery-ui.css'/>">
	<link rel="stylesheet" href="<c:url value='/css/mw/common.css'/>">
	<link rel="stylesheet" href="<c:url value='/css/mw/qr-code.css'/>">
	
	<!-- script -->
	<jsp:include page="/mw/includeJs.do" flush="false"></jsp:include>
	<script src="<c:url value='/js/jquery-1.11.1.js'/>"></script>
	<script src="<c:url value='/js/jquery-ui-1.11.4.js'/>"></script>
	
	<script>
		//자세히 보기
		function detail_btn() {
			var obj = '.detail-btn';					//object
			
			$(obj).on('click', function() {
				if($(this).parents('li').find('dd').css('display')=='none') {
					$('.qr-list-box dd').hide();
					$(this).parents('li').find('dd').show();
					
					$('.detail-btn').html('자세히보기');
					$(this).html('접기');
					
					$('.detail-btn').removeClass('active');
					$(this).addClass('active');
				}
				else {
					$('.qr-list-box dd').hide();
					$('.detail-btn').html('자세히보기');
					$('.detail-btn').removeClass('active');
				}
				
			});
		}
		
		function show_popup(obj) {
			if($(obj).is(":hidden")){
				$(obj).show();
				$('#wrap').after('<div class="lock-bg"></div>');
			}else{
				$(obj).hide();
				$('.lock-bg').remove();
			}
		}
		
		function close_popup(obj) {
			$(obj).hide();
			$('.lock-bg').remove();
		}
	
		$(document).ready(function () {
			detail_btn();								//자세히 보기 실행
		});
		
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
				data: $("#useApprForm").serialize() ,
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
					}
					else {
						if(data.success == '${Constant.JSON_SUCCESS}'){
							$('.pop-seller, #cover').fadeToggle();
						}
					}
				},
				error : fn_AjaxError
			});
		}
		
		// 쿠폰 사용처리
		function fn_spUseAppr() {
			$.ajax({
				type:"post", 
				dataType:"json",
				async:false,
				url:"<c:url value='/mw/mypage/spUseAppr.ajax'/>",
				data: $("#useApprForm").serialize() ,
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
					}
					else {
						if(data.success == '${Constant.JSON_SUCCESS}'){
							alert("사용처리가 정상적으로 처리 되었습니다.");
							location.href="<c:url value='/mw/qr.do?rsvNum=${rsvNum}&telNum=${telNum}&SCID=tamnao'/>";
						}
					}
				},
				error : fn_AjaxError
			});
		}
	</script>
</head>
<body>
  <div id="wrap">
		<header id="header">
			<h2 class="logo"><img src="<c:url value='/images/mw/common/logo.gif'/>" alt="탐나오"></h2>
			<div class="r-area"><span>고객센터 :</span> <strong>1522-3454</strong></div>
		</header>

		<main id="main">
			<section class="contents-wrap">
				<h2 class="sec-caption">QR코드 내역</h2>
				
				<!--change contents-->
				<div class="rese-wrap">
					<div class="ar-wrap">
						<div class="number"><strong>예약번호</strong> : <span>${qrRsvMap.rsvNum }</span></div>
						<div class="day"><strong>예약일자</strong> : <span>${qrRsvMap.regDttm }</span></div>
					</div>
				</div>
				
				<div class="ct-container">
					<div class="code-img"><img src="<c:url value='${fileName}'/>" alt="qr code"></div>
					
					<div class="coupon-count">
						<div class="re">남은 쿠폰 <strong><fmt:formatNumber value="${qrRsvMap.remainRsv }" /> </strong></div>
						<div class="total">
							<span>전체 쿠폰 <strong><fmt:formatNumber value="${qrRsvMap.totalRsv }" /></strong></span>
							<span> / </span>
							<span>사용(만료) 쿠폰 <strong><fmt:formatNumber value="${qrRsvMap.totalRsv - qrRsvMap.remainRsv }" /></strong></span>
						</div>
					</div>
					
					<section class="qr-list-box">
						<h3 class="sec-caption">QR코드 리스트 내용</h3>
						
						<!-- QR코드 -->
						<c:if test="${fn:length(qrRsvMap.posList) != 0 }">
						<article>
							<h3 class="title1"><img class="icon" src="<c:url value='/images/mw/qr/t1_bg.png'/>" alt="" /> QR코드 사용 쿠폰</h3>
							<c:forEach var="cpn" items="${qrRsvMap.posList }">
							<ul>
								<li>
									<dl>
										<dt>
											<div class="l-area">
												<c:choose>
													<c:when test="${Constant.RSV_STATUS_CD_UCOM eq cpn.rsvStatusCd or Constant.RSV_STATUS_CD_SREQ eq cpn.rsvStatusCd }">
													<span class="label1">사용<br>완료</span>
													</c:when>
													<c:when test="${Constant.RSV_STATUS_CD_COM eq cpn.rsvStatusCd and !(cpn.exprEndDt - SVR_TODAY < 0 and cpn.prdtDiv eq Constant.SP_PRDT_DIV_COUP) }">
													<span class="label2">사용<br>가능</span>
													</c:when>
													<c:otherwise>
													<span class="label3">기간<br>만료</span>
													</c:otherwise>
												</c:choose>
											</div>
											<div class="r-area">
												<p class="title">${cpn.prdtNm }</p>
												<p class="memo">${cpn.prdtInf }</p>
											</div>
										</dt>
										<dd>
											<table>
												<colgroup>
													<col style="width: 70px">
													<col>
												</colgroup>
												<tbody>
													<tr class="red">
														<th>[유효기간]</th>
														<fmt:parseDate value='${cpn.exprStartDt}' var='exprStartDt' pattern="yyyyMMdd" scope="page"/>
                                               			<fmt:parseDate value='${cpn.exprEndDt}' var='exprEndDt' pattern="yyyyMMdd" scope="page"/>
														<td><fmt:formatDate value="${exprStartDt}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${exprEndDt}" pattern="yyyy-MM-dd"/></td>
													</tr>								
													<tr>
														<th>[상품금액]</th>
														<td><fmt:formatNumber value="${cpn.saleAmt }" />원</td>
													</tr>
													<tr>
														<th>[쿠폰할인]</th>
														<td>-<fmt:formatNumber value="${cpn.disAmt }" />원</td>
													</tr>
													<tr class="total">
														<th>[결제금액]</th>
														<td><fmt:formatNumber value="${cpn.saleAmt - cpn.disAmt }" /></td>
													</tr>
													<tr>
														<th>[판 매 처]</th>
														<td>${cpn.corpNm } (${cpn.rsvTelnum })</td>
													</tr>
												</tbody>
											</table>
											
											<div class="info-text">
												<h4>[안내사항]</h4>
												<c:if test="${cpn.exprEndDt - SVR_TODAY < 0 and cpn.prdtDiv eq Constant.SP_PRDT_DIV_COUP}">
													<p>유효기간이 만료되어 사용할 수 없는 상품입니다.</p>
												</c:if>
												<c:if test="${not empty cpn.useAbleDttm and cpn.exprEndDt - SVR_TODAY >=0}">
													<p>${cpn.useAbleDttm} 이후 이용 가능 상품입니다.</p>
												</c:if>
											</div>
										</dd>
									</dl>
									<button type="button" class="detail-btn">자세히보기</button>
								</li>
							</ul>
							</c:forEach>
						</article>
						</c:if>
						
						<!-- QR코드 별도 발송 -->
						<!-- <article>
							<h3 class="title1"><img class="icon" src="<c:url value='/images/mw/qr/t2_bg.png'/>" alt="" /> QR코드 별도 발송</h3>
							<ul>
								<li>
									<dl>
										<dt>
											<div class="l-area">
												<span class="label1">사용<br>완료</span>
												<span class="label2">사용<br>가능</span>
												<span class="label3">기간<br>만료</span>
											</div>
											<div class="r-area">
												<p class="title">소인국테마파크</p>
												<p class="memo">성인입장권 | 수량 : 2</p>
											</div>
										</dt>
										<dd>
											<table>
												<colgroup>
													<col style="width: 70px">
													<col>
												</colgroup>
												<tbody>
													<tr class="red">
														<th>[유효기간]</th>
														<td>2016-02-24 ~ 2016-03-09</td>
													</tr>								
													<tr>
														<th>[상품금액]</th>
														<td>120,000원</td>
													</tr>
													<tr>
														<th>[쿠폰할인]</th>
														<td>-0원</td>
													</tr>
													<tr class="total">
														<th>[결제금액]</th>
														<td>120,000</td>
													</tr>
													<tr>
														<th>[판 매 처]</th>
														<td>넥스트이지 (064-721-8118)</td>
													</tr>
												</tbody>
											</table>
											
											<div class="info-text">
												<h4>[안내사항]</h4>
												<p>안내메시지 출력</p>
											</div>
										</dd>
									</dl>
									<button type="button" class="detail-btn">자세히보기</button>
								</li>
							</ul>
						</article> -->
						
						<!-- QR코드 없음 -->
						<c:if test="${fn:length(qrRsvMap.directList) != 0 }">
						<article>
							<h3 class="title1"><img class="icon" src="<c:url value='/images/mw/qr/t3_bg.png'/>" alt="" /> 업체 확인 쿠폰</h3>
							<c:forEach var="cpn" items="${qrRsvMap.directList }">
							<ul>
								<li>
									<dl>
										<dt>
											<div class="l-area">
												<c:set var="rsvAbleFlag" value="${Constant.RSV_STATUS_CD_COM eq cpn.rsvStatusCd and !(cpn.exprEndDt - SVR_TODAY < 0 and cpn.prdtDiv eq Constant.SP_PRDT_DIV_COUP) }" />
												<c:choose>
													<c:when test="${Constant.RSV_STATUS_CD_UCOM eq cpn.rsvStatusCd or Constant.RSV_STATUS_CD_SREQ eq cpn.rsvStatusCd }">
													<span class="label1">사용<br>완료</span>
													</c:when>
													<c:when test="${rsvAbleFlag }">
													<span class="label2">사용<br>가능</span>
													</c:when>
													<c:otherwise>
													<span class="label3">기간<br>만료</span>
													</c:otherwise>
												</c:choose>
											</div>
											<div class="r-area">
												<p class="title">${cpn.prdtNm }</p>
												<p class="memo">${cpn.prdtInf }</p>
											</div>
										</dt>
										<dd>
											<table>
												<colgroup>
													<col style="width: 70px">
													<col>
												</colgroup>
												<tbody>
													<tr class="red">
														<th>[유효기간]</th>
														<fmt:parseDate value='${cpn.exprStartDt}' var='exprStartDt' pattern="yyyyMMdd" scope="page"/>
                                               			<fmt:parseDate value='${cpn.exprEndDt}' var='exprEndDt' pattern="yyyyMMdd" scope="page"/>
														<td><fmt:formatDate value="${exprStartDt}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${exprEndDt}" pattern="yyyy-MM-dd"/></td>
													</tr>								
													<tr>
														<th>[상품금액]</th>
														<td><fmt:formatNumber value="${cpn.saleAmt + cpn.disAmt }" />원</td>
													</tr>
													<tr>
														<th>[쿠폰할인]</th>
														<td>-<fmt:formatNumber value="${cpn.disAmt }" />원</td>
													</tr>
													<tr class="total">
														<th>[결제금액]</th>
														<td><fmt:formatNumber value="${cpn.saleAmt}" /></td>
													</tr>
													<tr>
														<th>[판 매 처]</th>
														<td>${cpn.corpNm } (${cpn.rsvTelnum })</td>
													</tr>
												</tbody>
											</table>
											
											<div class="info-text">
												<h4>[안내사항]</h4>
												<c:if test="${cpn.exprEndDt - SVR_TODAY < 0 and cpn.prdtDiv eq Constant.SP_PRDT_DIV_COUP}">
													<p>유효기간이 만료되어 사용할 수 없는 상품입니다.</p>
												</c:if>
												<c:if test="${not empty cpn.useAbleDttm and cpn.exprEndDt - SVR_TODAY >=0}">
													<p>${cpn.useAbleDttm} 이후 이용 가능 상품입니다.</p>
												</c:if>
											</div>
											<c:if test="${rsvAbleFlag }">
											<div class="btn-wrap">
												<a href="javascript:void(0)" class="use-btn" onclick="fn_viewUseAppr('${cpn.spRsvNum}')">사용</a>
											</div>
											</c:if>
										</dd>
									</dl>
									<button type="button" class="detail-btn">자세히보기</button>
								</li>
							</ul>
							</c:forEach>
						</article>
						</c:if>
					</section>
					
					<h3 class="title2">이용안내</h3>
					<ul class="list-style1">
						<li>유효기간 내 사용하지 못한 입장권(이용권)은 환불되지 않습니다.</li>
					</ul>
					
					<h3 class="title2">이용제한 안내</h3>
					<ul class="list-style1">
						<li>본 상품은 렌터카, 자가운전자, 도보여행객 등 개별여행객만 사용이 가능합니다.<br>
							(일반 정기 투어, 단체관광, 택시관광 등 기사를동반한 여행인 경우 사용하실 수 없습니다.)
						</li>
						<li>타 할인(국가유공자, 장애인, 경로, 다른 할인 쿠폰 등)과 중복할인 불가 합니다.</li>
					</ul>
					
					
					<!-- 기존 상품사용 팝업 -->
					<div class="pop-seller pop-seller_ticket">
						<a class="btn-close" onclick="close_popup('.pop-seller')">
							<img src="<c:url value='/images/mw/sub_common/delete.png'/>" width="10" alt="닫기">
						</a>
						<form name="useApprForm" id="useApprForm">
						<input type="hidden" name="prdtRsvNum" id="prdtRsvNum" />
						<div class="pw-form">
							<h5 class="title"><img src="<c:url value='/images/mw/sub/ticket.png'/>" alt="ticket"> 해당 상품을 사용하시겠습니까?</h5>
							<p class="sub_title">관광지 매표소 직원에게 보여주세요!</p>
							
							<p class="pw"><input class="full" type="password" name="usePwd" id="usePwd" maxlength="4" placeholder="관리자 비밀번호를 입력해 주세요"></p>
							<p class="sub_text">주의) 비밀번호 입력 시 사용처리 됩니다.</p>
							
							<div class="button">
								<a class="btn btn1" href="javascript:fn_spUseAppr();">확인</a>
								<a class="btn btn2" onclick="close_popup('.pop-seller')">취소</a>
							</div>
						</div>
						</form>
					</div>
					<!-- //기존 상품사용 팝업 -->
					
				</div> <!-- //ct-container -->
				<!--//change contents-->
				
			</section> <!--//contents-wrap-->
		</main>

		<!-- 푸터 s -->
		<jsp:include page="/mw/foot.do" flush="false"></jsp:include>
        
	</div> <!-- //wrap -->
</body>
</html>