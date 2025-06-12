<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 			uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />
<head>
<c:set var="strServerName" value="${pageContext.request.serverName}"/>
<c:set var="strURL" value="${strServerName}${pageContext.request.contextPath}${requestScope['javax.servlet.forward.servlet_path']}?prmtDiv=${prmtVO.prmtDiv}&prmtNum=${prmtVO.prmtNum}"/>

<jsp:include page="/web/includeJs.do">
	<jsp:param name="title" value="제주여행 ${prmtVO.prmtNm}, 탐나오"/>
</jsp:include>
<meta property="og:title" content="제주여행 ${prmtVO.prmtNm}, 탐나오" />
<meta property="og:url" content="https://${strURL}" />
<meta property="og:description" content="<c:out value='${prmtVO.prmtNm}'/>" />
<c:if test="${not empty prmtVO.listImg}">
<meta property="og:image" content="https://${strServerName}${prmtVO.listImg}" />
</c:if>
<meta property="fb:app_id" content="182637518742030" />

<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css?version=${nowDate}'/>" /> --%>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css?version=${nowDate}'/>" />
<link rel="stylesheet" href="../../css/web/number-ticker.css">

<!-- SNS관련----------------------------------------- -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="<c:url value='/js/sns.js'/>"></script>
<script type="text/javascript">
function fn_list() {
	document.frmPrmt.action = "<c:url value='/web/evnt/promotionList.do'/>";
	document.frmPrmt.submit();
}

function fn_Detail(prmtNum) {
	document.frmPrmt.prmtNum.value = prmtNum;
	document.frmPrmt.action = "<c:url value='/web/evnt/detailPromotion.do'/>";
	document.frmPrmt.submit();
}

function fn_prmtCmtList(pageIndex) {
	let parameters = "prmtNum=${prmtVO.prmtNum}&pageIndex=" + pageIndex;
	$.ajax({
		type:"post",
		url:"<c:url value='/web/evnt/prmtCmtList.ajax' />",
		data:parameters,
		success:function(data){
			$("#divComment").html(data);
		},
		error:fn_AjaxError
	});
}

function fn_prmtCmtInsert(){
	if($("#cmtContents").val().length == 0) {
		alert("<spring:message code="errors.required2" arguments="댓글" />");
		$("#cmtContents").focus();
		return;
	}
	if($("#cmtContents").val().length > 500) {
		alert("<spring:message code="errors.maxlength" arguments="댓글,500" />");
		$("#cmtContents").focus();
		return;
	}
	let parameters = $("#prmtCmtFrm").serialize();
	$.ajax({
		type:"post",
		url:"<c:url value='/web/evnt/prmtCmtInsert.ajax' />",
		data:parameters,
		success:function(data){
			if(data["Status"] == "success") {
				alert("<spring:message code="success.common.insert" />");
				$("#cmtContents").val("");
				fn_prmtCmtList(1);
			} else {
				alert("<spring:message code="fail.common.insert" />");
			}
		},
		error:fn_AjaxError
	});
}

function fn_prmtCmtDelete(cmtSn) {
	$("#cmtSn").val(cmtSn);
	let parameters = $("#prmtCmtFrm").serialize();
	$.ajax({
		type:"post",
		url:"<c:url value='/web/evnt/prmtCmtDelete.ajax' />",
		data:parameters,
		success:function(data){
			if(data["Status"] == "success") {
				alert("<spring:message code="success.common.delete" />");

				fn_prmtCmtList(1);
			} else {
				alert("<spring:message code="fail.common.delete" />");
			}
		},
		error:fn_AjaxError
	});
}

function fn_confirmLogin() {
	if(confirm("<spring:message code="confirm.login" />")) {
		fn_login();
	}
}

function event2021Cnt(){
	var parameters = {"cpIds":["CP00000670","CP00000671","CP00000672","CP00000673","CP00000674"]};
	$.ajax({
		url : "<c:url value='/web/couponUseCnt.ajax'/>",
		data : parameters,
		dataType:"json",
		success: function(data) {
			if(data.success == "Y") {
				$(".number-ticker").attr("data-value",data.cnt*100);
			}
		},
		error : function(request, status, error) {
			fn_AjaxError(request, status, error);
		}
	});
}

function event2021Donation(){
	if("${isLogin}" != 'Y'){
		if(confirm('로그인 후 기부하실 수 있습니다.\n로그인 하시겠습니까?')) {
			fn_login();
		}
	}else if("${isLogin}" == 'Y'){
		let parameters = "userId=ALL";
		$.ajax({
			url : "<c:url value='/web/event2021Donation.ajax'/>",
			data : parameters,
			dataType:"json",
			success: function(data) {
				if(data.success == "Y") {
					$(".number-ticker").attr("data-value",Number($(".number-ticker").attr("data-value")) + 1);
					alert("기부 되었습니다.");
					/*location.href="/web/mypage/couponList.do";*/
				}else{
					alert("이미 기부 하셨습니다.");
					/*location.href="/web/mypage/couponList.do";*/
				}
			},
			error : function(request, status, error) {
				fn_AjaxError(request, status, error);
			}
		});
	}
}

$(document).ready(function(){
	<c:if test="${prmtVO.cmtYn eq 'Y'}">
	fn_prmtCmtList(1);
	</c:if>

	//공유하기-모달팝업
	isShow = true;

	$('.sns-share').click(function () {
		if(isShow) {
			isShow = false;

			$('#sns_popup').show();
		}else {
			isShow = true;

			$('#sns_popup').hide();
		}
	})

	event2021Cnt();
});
</script>

</head>
<body>
<header id="header">
	<jsp:include page="/web/head.do" />
</header>
<main id="main">
	<!-- 다시ON, 고향사랑기부제 -->
	<c:if test="${prmtVO.prmtNum ne 'PM0000XXXX'}">
	<div class="mapLocation">
			<div class="inner">
				<span>홈</span> <span class="gt">&gt;</span>
				<span>이벤트</span>
			</div>
	</div>
	<div class="subContainer">
	    <div class="subHead"></div>
	    <div class="subContents">
	        <div class="event2-wrap event-detail">
			    <div class="bgWrap2">
			        <div class="Fasten">
			            <div class="tabs-wrap">
							<form name="frmPrmt" method="post" onsubmit="return false;">
								<input type="hidden" name="pageIndex" value="${prmtVO.pageIndex}"/>
								<input type="hidden" name="finishYn" value="${prmtVO.finishYn}"/>
								<input type="hidden" name="winsYn" value="${prmtVO.winsYn}"/>
								<input type="hidden" name="prmtDiv" value="${Constant.PRMT_DIV_EVNT}" />
								<input type="hidden" name="prmtNum" id="prmtNum" />
							</form>
			              	<c:if test="${prmtVO.winsYn eq 'N'}">
							<div class="tabs-left">
								<div class="title-area">
									<h2 class="title">
										${prmtVO.prmtNm}
										<span class="date">
											<fmt:parseDate value="${prmtVO.startDt}" var="startDt" pattern="yyyyMMdd" />
											<fmt:parseDate value="${prmtVO.endDt}" var="endDt" pattern="yyyyMMdd" />
											<fmt:formatDate value="${startDt}" pattern="yyyy.MM.dd" /> ~ <fmt:formatDate value="${endDt}" pattern="yyyy.MM.dd" />
										</span>
									</h2>
									<!-- 0310 공유하기-모달팝업 -->
									<div class="icon-group">
										<button class="sns-share" type="button">
											<img src="<c:url value='/images/web/icon/sns.png' />" alt="sns">
										</button>
									</div>
									<div id="sns_popup" class="sns-popup">
										<ul class="sns-area">
											<li>
												<a href="javascript:shareStory('${strURL}'); snsCount('${prmtVO.prmtNum}', 'PC', 'KAKAO');">
													<img src="<c:url value='/images/web/icon/sns/kakaostory.png' />" alt="카카오스토리">
													<span>카카오톡</span>
												</a>
											</li>
											<li>
												<a href="javascript:shareFacebook('${strURL}'); snsCount('${prmtVO.prmtNum}', 'PC','FACEBOOK');">
													<img src="<c:url value='/images/web/icon/sns/facebook.png' />" alt="페이스북">
													<span>페이스북</span>
												</a>
											<li>
											<li>
												<a href="javascript:shareBand('${strURL}'); snsCount('${prmtVO.prmtNum}', 'PC', 'BAND' );">
													<img src="<c:url value='/images/web/icon/sns/band.png' />" alt="밴드">
													<span>네이버 밴드</span>
												</a>
											</li>
										</ul>
									</div><!-- //0310 공유하기-모달팝업 -->
								</div>

								<ul class="event-list">
									<li><img src="${prmtVO.dtlImg}" alt="${prmtVO.prmtNm}"></li>
								</ul>

								<jsp:useBean id="now" class="java.util.Date" />
								<fmt:formatDate value="${endDt}" var="endDtStr" pattern="yyyyMMdd" />
								<fmt:formatDate value="${now}" var="nowDt" pattern="yyyyMMdd" />

								<c:if test="${nowDt <= endDtStr}">
									<%--상품노출구분_리스트형--%>
									<c:if test="${prmtVO.prdtViewDiv eq '1000'}">
										<div class="product-wrap">
											<c:if test="${!(empty prmtVO.dtlUrl)}">
												<p class="oss-quick"><a href="${prmtVO.dtlUrl}" <c:if test="${prmtVO.dtlNwdYn eq 'Y'}">target="_blank"</c:if>>바로가기</a></p>
											</c:if>

											<c:if test="${prdtSum != 0}">
												<ul class="product-list">
													<c:forEach items="${prmtPrdtList}" var="prdt">
														<c:set value="${prdt.data}" var="product"/>
														<li>
															<c:choose>
																<c:when test="${prdt.corpCd eq Constant.ACCOMMODATION}">
																	<c:set var="paramStr" value="sPrdtNum" />
																</c:when>
																<c:otherwise>
																	<c:set var="paramStr" value="prdtNum" />
																</c:otherwise>
															</c:choose>
															<c:set var="addUrl" value="" />
															<c:if test="${(prdt.corpCd eq Constant.SOCIAL) and (product.prdtDiv eq Constant.SP_PRDT_DIV_FREE)}">
																<c:set var="addUrl" value="&prdtDiv=${product.prdtDiv}" />
															</c:if>
															<a href="<c:url value='/web/${fn:toLowerCase(prdt.corpCd)}/detailPrdt.do?${paramStr}=${product.prdtNum}${addUrl}'/>" target="_blank">
																<div class="cell cell1">
																	<p class="photo">
																		<c:choose>
																			<c:when test="${prdt.corpCd eq Constant.SOCIAL}">
																				<img src="${product.saveFileNm}" class="product" alt="${product.prdtNm}">
																			</c:when>
																			<c:when test="${prdt.corpCd eq Constant.RENTCAR}">
																				<img src="${product.saveFileNm}" class="product" alt="${product.prdtNm}">
																			</c:when>
																			<c:when test="${prdt.corpCd eq Constant.ACCOMMODATION}">
																				<img src="${product.savePath}thumb/${product.saveFileNm}" class="product" alt="${product.adNm}">
																			</c:when>
																			<c:otherwise>
																				<img src="${product.savePath}thumb/${product.saveFileNm}" class="product" alt="${product.prdtNm}">
																			</c:otherwise>
																		</c:choose>
																	</p>
																</div>
																<div class="cell cell2">
																	<c:choose>
																		<c:when test="${prdt.corpCd eq Constant.SOCIAL}">
																			<img src="${product.saveFileNm}" class="product" alt="${product.prdtNm}">
																		</c:when>
																		<c:when test="${prdt.corpCd eq Constant.ACCOMMODATION}">
																			<h5 class="title"><c:out value="${product.adNm}" /><small> - <c:out value="${product.roomNm}" /></small></h5>
																			<p class="subTitle"><c:out value="${product.adSimpleExp}" /></p>
																		</c:when>
																		<c:when test="${prdt.corpCd eq Constant.RENTCAR}">
																			<h5 class="title"><c:out value="${product.prdtNm}" /></h5>
																			<p class="subTitle"><c:out value="${product.rcNm}" /></p>
																		</c:when>
																		<c:otherwise>
																			<h5 class="title"><c:out value="${product.prdtNm}" /></h5>
																			<p class="subTitle"><c:out value="${product.prdtInf}" /></p>
																		</c:otherwise>
																	</c:choose>

																	<div class="event-label-group">
																		<c:if test="${not empty prmtPrdtMap[product.prdtNum].label1}">
																			<span class="event-label list-red">${labelMap[prmtPrdtMap[product.prdtNum].label1]}</span>
																		</c:if>
																		<c:if test="${not empty prmtPrdtMap[product.prdtNum].label2}">
																			<span class="event-label list-green">${labelMap[prmtPrdtMap[product.prdtNum].label2]}</span>
																		</c:if>
																		<c:if test="${not empty prmtPrdtMap[product.prdtNum].label3}">
																			<span class="event-label list-yellow">${labelMap[prmtPrdtMap[product.prdtNum].label3]}</span>
																		</c:if>
																	</div>
																</div>
																<div class="cell cell5">
																	<p class="memo">${prmtPrdtMap[product.prdtNum].note}</p>
																</div>
																<div class="cell cell3">
																	<div class="saleWrap">
																		<c:if test="${not ((prdt.corpCd eq Constant.SOCIAL) and (product.prdtDiv eq Constant.SP_PRDT_DIV_FREE))}">
																			<c:if test="${product.saleAmt ne product.nmlAmt}">
																				<p class="sale"><fmt:formatNumber value="${1 - (product.saleAmt / product.nmlAmt)}" type="percent"/></p>
																			</c:if>
																			<p class="won">
																				<span class="won2"><fmt:formatNumber>${product.saleAmt}</fmt:formatNumber></span><span class="won">원~</span>
																			</p>
																		</c:if>
																		<c:if test="${(prdt.corpCd eq Constant.SOCIAL) and (product.prdtDiv eq Constant.SP_PRDT_DIV_FREE)}">
																			<p class="sale">쿠폰 상품</p>
																		</c:if>
																	</div>
																</div>
																<div class="cell cell4">
																</div>
															</a>
														</li>
													</c:forEach>
												</c:if>
											</ul>
										</div> <!-- //product-wrap -->
									</c:if>
									<%--상품노출구분_갤러리형--%>
									<c:if test="${prmtVO.prdtViewDiv eq '2000'}">
										<div class="product-wrap event-detail2">
											<c:if test="${!(empty prmtVO.dtlUrl)}">
												<p class="oss-quick"><a href="${prmtVO.dtlUrl}" <c:if test="${prmtVO.dtlNwdYn eq 'Y'}">target="_blank"</c:if>>바로가기</a></p>
											</c:if>

											<c:if test="${prdtSum != 0}">
												<h5 class="listTitle1"></h5>
												<section class="product-item-area margin0">
													<h2 class="sec-caption">상품 목록</h2>
													<div class="Fasten">
														<div class="item-area">
															<ul class="col3">
																<c:forEach var="prdt" items="${prmtPrdtList}">
																	<c:set var="product" value="${prdt.data}" />
																	<li>
																		<div class="photo">
																			<c:choose>
																				<c:when test="${prdt.corpCd eq Constant.ACCOMMODATION}">
																					<c:set var="paramStr" value="sPrdtNum" />
																				</c:when>
																				<c:otherwise>
																					<c:set var="paramStr" value="prdtNum" />
																				</c:otherwise>
																			</c:choose>
																			<c:set var="addUrl" value="" />
																			<c:if test="${(prdt.corpCd eq Constant.SOCIAL) and (product.prdtDiv eq Constant.SP_PRDT_DIV_FREE)}">
																				<c:set var="addUrl" value="&prdtDiv=${product.prdtDiv}" />
																			</c:if>
																			<a href="<c:url value='/web/${fn:toLowerCase(prdt.corpCd)}/detailPrdt.do?${paramStr}=${product.prdtNum}${addUrl}'/>" target="_blank">
																				<div class="memo">${prmtPrdtMap[product.prdtNum].note}</div>

																				<c:set var="label1" value="${prmtPrdtMap[product.prdtNum].label1}" />

																				<c:if test="${not empty label1}">
																					<c:choose>
																						<c:when test="${label1 eq 'LB01'}">
																							<c:set var="imgUrl" value="/images/web/event/special_price.png" />
																						</c:when>
																						<c:when test="${label1 eq 'LB02'}">
																							<c:set var="imgUrl" value="/images/web/event/hot.png" />
																						</c:when>
																						<c:when test="${label1 eq 'LB08'}">
																							<c:set var="imgUrl" value="/images/web/event/w-only.png" />
																						</c:when>
																						<c:otherwise>
																							<c:set var="imgUrl" value="" />
																						</c:otherwise>
																					</c:choose>
																					<img src="${imgUrl}" class="tamnaolabel" alt="${labelMap[label1]}">
																				</c:if>

																				<c:choose>
																					<c:when test="${prdt.corpCd eq Constant.RENTCAR}">
																						<img src="${product.saveFileNm}" class="product" alt="${product.prdtNm}">
																					</c:when>
																					<c:when test="${prdt.corpCd eq Constant.ACCOMMODATION}">
																						<img src="${product.savePath}thumb/${product.saveFileNm}" class="product" alt="${product.adNm}">
																					</c:when>
																					<c:otherwise>
																						<img src="${product.savePath}thumb/${product.saveFileNm}" class="product" alt="${product.prdtNm}">
																					</c:otherwise>
																				</c:choose>
																			</a>
																		</div>
																		<div class="info">
																			<div class="text-area">
																				<div class="title">
																					<c:choose>
																						<c:when test="${prdt.corpCd eq Constant.ACCOMMODATION}">
																							<span><c:out value="${product.adNm}" /><small> - <c:out value="${product.roomNm}" /></small></span>
																						</c:when>
																						<c:when test="${prdt.corpCd eq Constant.RENTCAR}">
																							<span><c:out value="${product.prdtNm}" /><small> - <c:out value="${product.corpNm}" /></small></span>
																						</c:when>
																						<c:otherwise>
																							<span><c:out value="${product.prdtNm}" /></span>
																						</c:otherwise>
																					</c:choose>
																				</div>
																			</div>
																		</div>
																		<div class="price-area">
																			<div class="money">
																				<c:if test="${not ((prdt.corpCd eq Constant.SOCIAL) and (product.prdtDiv eq Constant.SP_PRDT_DIV_FREE))}">
																					<c:if test="${product.saleAmt ne product.nmlAmt}">
																						<span class="red-percent"><fmt:formatNumber value="${1 - (product.saleAmt / product.nmlAmt)}" type="percent" /></span>
																					</c:if>
																					<span class="cost">
																						<span class="price"><fmt:formatNumber value="${product.saleAmt}" /></span><span class="won">원~</span>
																					</span>
																				</c:if>
																				<c:if test="${(prdt.corpCd eq Constant.SOCIAL) and (product.prdtDiv eq Constant.SP_PRDT_DIV_FREE)}">
																					<span class="single">쿠폰상품</span>
																				</c:if>
																				<c:if test="${not empty prmtPrdtMap[product.prdtNum].label2}">
																					<span class="event-label freeship">${labelMap[prmtPrdtMap[product.prdtNum].label2]}</span>
																				</c:if>
																				<c:if test="${not empty prmtPrdtMap[product.prdtNum].label3}">
																					<span class="event-label oneplus">${labelMap[prmtPrdtMap[product.prdtNum].label3]}</span>
																				</c:if>
																			</div>
																		</div>
																	</li>
																</c:forEach>
															</ul>
														</div> <!-- //item-area -->
													</div>
												</section>
											</c:if>
										</div>
									</c:if>
								</c:if>

								<c:if test="${prmtVO.cmtYn eq 'Y'}">
									<!--이벤트댓글-->
									<div class="event-review">
										<c:if test="${nowDt <= endDtStr}">
											<form name="frm" id="prmtCmtFrm" method="post" onSubmit="return false;">
												<input type="hidden" name="cmtSn" id="cmtSn" />
												<input type="hidden" name="prmtNum" value="${prmtVO.prmtNum}"/>

												<div class="regi">
													<c:if test="${isLogin eq 'Y'}">
														<textarea class="review-t" name="contents" id="cmtContents" placeholder="최대 500자 까지 작성할 수 있습니다."></textarea>
														<a href="javascript:fn_prmtCmtInsert()" class="cm-btn">등록</a>
													</c:if>
													<c:if test="${isLogin eq 'N'}">
														<textarea class="review-t" name="contents" id="cmtContents" placeholder="로그인 시 댓글을 작성할 수 있습니다." onclick="javascript:fn_confirmLogin();"></textarea>
														<a href="javascript:fn_confirmLogin()" class="cm-btn">등록</a>
													</c:if>
												</div>
											</form>
										</c:if>

										<div id="divComment">
										</div>
									</div>
								</c:if>
							</div>
			              	</c:if>
							<%--당첨자 페이지--%>
			              	<c:if test="${prmtVO.winsYn eq 'Y'}">
							<div class="tabs-left">
								<ul class="event-list">
									<li><img src="${prmtVO.winsImg}" alt="${prmtVO.prmtNm}"></li>
								</ul>
							</div>
			              	</c:if>
							<div class="row-paging">
								<!-- 이전글, 다음글 -->
								<div class="row-area">
									<c:if test="${not empty prmtPrevNext.prevPrmtNum}">
										<fmt:parseDate var="starDt" value="${prmtPrevNext.prevStartDt}" pattern="yyyyMMdd" />
										<fmt:parseDate var="endDt" value="${prmtPrevNext.prevEndDt}" pattern="yyyyMMdd" />
										<div class="row prev">
											<%-- <span class="col title"><a href="javascript:void(0)" onclick="fn_Detail('${prmtPrevNext.prevPrmtNum}');">${prmtPrevNext.prevPrmtNm}</a></span> --%>
											<span class="col title"><span onclick="fn_Detail('${prmtPrevNext.prevPrmtNum}');" style="cursor: pointer;">${prmtPrevNext.prevPrmtNm}</span></span>
											<span class="col date"><fmt:formatDate value="${starDt}" pattern="yyyy-MM-dd" /> ~ <fmt:formatDate value="${endDt}" pattern="yyyy-MM-dd" /></span>
										</div>
									</c:if>
									<c:if test="${not empty prmtPrevNext.nextPrmtNum}">
										<fmt:parseDate var="starDt" value="${prmtPrevNext.nextStartDt}" pattern="yyyyMMdd" />
										<fmt:parseDate var="endDt" value="${prmtPrevNext.nextEndDt}" pattern="yyyyMMdd" />
										<div class="row prev">
											<%-- <span class="col title"><a href="javascript:void(0)" onclick="fn_Detail('${prmtPrevNext.nextPrmtNum}');">${prmtPrevNext.nextPrmtNm}</a></span> --%>
											<span class="col title"><span onclick="fn_Detail('${prmtPrevNext.nextPrmtNum}');" style="cursor: pointer;">${prmtPrevNext.nextPrmtNm}</span></span>
											<span class="col date"><fmt:formatDate value="${starDt}" pattern="yyyy-MM-dd" /> ~ <fmt:formatDate value="${endDt}" pattern="yyyy-MM-dd" /></span>
										</div>
									</c:if>
								</div>

								<div class="btn-wrap right">
									<!-- <a href="javascript:void(0)" onclick="fn_list();" class="comm-btn black typeB">목록</a> -->
									<span onclick="fn_list();" class="comm-btn black typeB" style="cursor: pointer;">목록</span>
								</div>
							</div>
			            </div>
			        </div>
			    </div>
			</div>
	    </div>
	</div>
	</c:if>
	<!-- 다시ON -->
	<%--<c:if test="${prmtVO.prmtNum eq 'PM00001667'}">
		<!-- 0911 event-page -->
		<div class="event-page">
			<div class="big-event_02">
				<div class="container count">
					<div class="number-ticker" data-value="10000000"></div>
					<span class="unit">원</span>
				</div>
			</div>
			<a href="https://www.tamnao.com/web/mypage/couponList.do" class="event-btn">쿠폰받고 기부하기</a>
		</div><!-- //event-page -->
	</c:if>--%>
	<c:set var="acceptExt" value="${Constant.FILE_CHECK_EXT}" />
	<%-- 승선이벤트 --%>
	<%--<c:if test="${prmtVO.prmtNum eq 'PM00001750'}">
		<div class="Fasten" style="padding-top: 65px;">
			<ul class="event-list">
				<li><img src="${prmtVO.dtlImg}" alt="${prmtVO.prmtNm}"></li>
			</ul>
		</div>
		<div class="event-page">
			<div>
				<form name="frm${prmtVO.prmtNum}" id="frm${prmtVO.prmtNum}" method="post" onSubmit="return false;" enctype="multipart/form-data">
					<input type="hidden" name="userId" value="${userInfo.userId}"/>
					<input style="display: none;" type="file" id="uploadfileImg" name="file_${prmtVO.prmtNum}" onchange="fn_updatePrmtFile('${prmtVO.prmtNum}',this)">
				</form>
				<span onclick="javascript:fn_isLogin();" class="event-btn" style="cursor: pointer;">승성권 업로드</span>
			</div>
		</div>
	</c:if>--%>
	<%-- 승선이벤트 --%>
	<%-- 혁신이벤트 --%>
	<c:if test="${prmtVO.prmtNum eq 'PM0000XXXX'}">
		<div class="event-page">
			<div>
				<div class="big-event_01">
					<img src="/images/web/event/on_jeju_promotion_1.jpg" alt="렌트카 숙소 40% 할인"/>
				</div>
			</div>
			<div>
				<a href="/web/rentcar/jeju.do?sCouponCnt=1" class="event-btn">렌트카 바로가기</a>
				<a href="https://www.tamnao.com/web/evnt/detailPromotion.do?prmtDiv=PLAN&prmtNum=PM00002030" class="event-btn">숙소 바로가기</a>
			</div>
		</div>

		<%-- 우수관광사업체 --%>
<%--		<div class="event-page">
			<div>
				<div class="big-event_02">
					<img src="/images/web/event/event_244_2.jpg" alt="이벤트2"/>
					<form name="frm${prmtVO.prmtNum}" id="frm${prmtVO.prmtNum}" method="post" onSubmit="return false;" enctype="multipart/form-data">
						<input type="hidden" name="userId" value="${userInfo.userId}"/>
						<input style="display: none;" type="file" id="uploadfileImg" name="file_${prmtVO.prmtNum}" onchange="fn_updatePrmtFile('${prmtVO.prmtNum}',this)">
					</form>
					<a href="https://www.tamnao.com/web/mypage/couponList.do" class="event-btn">우수관광업체 바로가기</a>
				</div>
			</div>
		</div>--%>
		<div class="event-page">
			<div>
				<div class="big-event_02">
					<img src="/images/web/event/on_jeju_promotion_2.jpg" alt="수능수험표인증 30% 할인"/>
					<form name="frm${prmtVO.prmtNum}" id="frm${prmtVO.prmtNum}" method="post" onSubmit="return false;" enctype="multipart/form-data">
						<input type="hidden" name="userId" value="${userInfo.userId}"/>
						<input style="display: none;" type="file" id="uploadfileImg" name="file_${prmtVO.prmtNum}" onchange="fn_updatePrmtFile('${prmtVO.prmtNum}',this)">
					</form>
					<span onclick="javascript:fn_isLogin();" class="event-btn" style="cursor: pointer;">수능 수험표 인증하기 CLICK!</span>
				</div>
			</div>
		</div>
		<div class="event-page">
			<div class="big-event_03">
				<img src="/images/web/event/on_jeju_promotion_3.jpg" alt="쿠폰1개발급 100월 자동 기부"/>
				<div class="container count">
					<div class="number-ticker" data-value="10000000"></div>
					<span class="unit">원</span>
				</div>
			</div>
		</div>
	</c:if>
</main>
<script>
	var checkUpload = false;

	/** 파일 체크 */
	function checkPrmtFile(el, ext, size){
		console.log("checkFile");
		var file = el.files;
		var fileName = file[0].name;
		var fileSize = file[0].size;
		// 파일 확장자 체크
		// var ext = ".png,.jpg,.jpeg,.gif,.pdf";
		var extList = ext.split(",");
		var extName = fileName.substring(fileName.lastIndexOf(".")).toLowerCase();
		
		var tfCheck;
		for(var i=0; i < extList.length; i++) {
			if(extName == $.trim(extList[i])) {
				tfCheck = true;
				break;
			} else {
				tfCheck = false;
			}
		}
		if(!tfCheck) {
			alert("업로드 불가능한 파일입니다.");
			checkUpload = false;
		} else {
			// 파일 용량 체크
			if(fileSize > (size * 1024 * 1024)) {
				alert("파일은 " + size + "MB 이하이어야 합니다.");
				checkUpload = false;
			} else {
				checkUpload = true;
				return;
			}
		}
		el.outerHTML = el.outerHTML;
	}

	function fn_isLogin(){
		<c:if test="${isLogin eq 'N' or isLogin eq 'G' }">
			if(confirm('로그인 후 수험생 이벤트에 참여할 수 있습니다.\n로그인 하시겠습니까?')) {
				fn_login();
			}
		</c:if>
		<c:if test="${isLogin eq 'Y' }">
			$("#uploadfileImg").click();
		</c:if>
	}

	/*function fn_updateHometownFile(prmtNum,obj){

		<c:if test="${isLogin eq 'Y' }">
			var file = $("input[name=file_"+prmtNum+"]").val();
			if(file == ""){
				alert("기부제 증명서 이미지파일을 선택해주세요.");
				return;
			}

			checkPrmtFile(obj, '${acceptExt}', 5)
			if(!checkUpload){
				return;
			}

		    var form = $('#frm'+ prmtNum)[0];
			var data = new FormData(form);
			data.append("prmtNum", prmtNum);
			$.ajax({
				type:"post",
				enctype: 'multipart/form-data',
				url:"<c:url value='/web/evnt/uploadHometownFile.ajax'/>",
				data: data,
				processData: false,
				contentType: false,
				success:function(data){
					if (data.Status == 'success') {
						alert('기부제 증명서가 등록 되었습니다.');
						location.reload();
					}
				},
				error : fn_AjaxError
			});
		</c:if>
	}*/
	
	function fn_updatePrmtFile(prmtNum,obj){
		
		<c:if test="${isLogin eq 'Y' }">
			var file = $("input[name=file_"+prmtNum+"]").val();
			if(file == ""){
				alert("이미지파일을 선택해주세요.");
				return;
			}
			
			checkPrmtFile(obj, '${acceptExt}', 5);
			if(!checkUpload){
				return;
			}
			
		    var form = $('#frm'+ prmtNum)[0];
			var data = new FormData(form);
			data.append("prmtNum", prmtNum);
			$.ajax({
				type:"post",
				enctype: 'multipart/form-data',
				url:"<c:url value='/web/evnt/uploadPrmtFile.ajax'/>",
				data: data,
				processData: false,
				contentType: false,
				success:function(data){
					if (data.Status == 'success') {
						alert('이미지가 등록 되었습니다.');
						location.reload();
					}
				},
				error : fn_AjaxError
			});
		</c:if>
	}
</script>
<script src="<c:url value='/js/number-ticker.js'/>"></script>
<jsp:include page="/web/right.do" />
<jsp:include page="/web/foot.do" />
</body>
</html>