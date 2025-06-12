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

<!-- SNS관련----------------------------------------- -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="<c:url value='/js/sns.js'/>"></script>

<script type="text/javascript">
function fn_list() {
	document.frm.action = "<c:url value='/web/evnt/prmtPlanList.do'/>";
	document.frm.submit();
}

function fn_Detail(prmtNum) {
	document.frm.prmtNum.value = prmtNum;
	document.frm.action = "<c:url value='/web/evnt/detailPromotion.do'/>";
	document.frm.submit();
}

$(document).ready(function(){

});
</script>
</head>

<body>

<jsp:include page="/web/head.do" />

<main id="main">
	<div class="mapLocation">
	    <div class="inner">
	        <span>홈</span> <span class="gt">&gt;</span>
			<span>기획전</span>
	    </div>
	</div>

	<div class="subContainer">
	    <div class="subHead"></div>
	    <div class="subContents">
	        <!-- Change Contents -->
	        <div class="event2-wrap event-detail <c:if test="${prmtVO.prdtViewDiv eq '2000'}">event-detail2</c:if>">
			    <div class="bgWrap3">
			        <div class="Fasten">
			            <div class="tabs-wrap">
							<div class="tabs-left">
								<form name="frm" method="post" onSubmit="return false;">
									<input type="hidden" name="pageIndex" value="${prmtVO.pageIndex}"/>
									<input type="hidden" name="finishYn" value="${prmtVO.finishYn}"/>
									<input type="hidden" name="winsYn" value="${prmtVO.winsYn}"/>
									<input type="hidden" name="type" value="plan" />
									<input type="hidden" name="prmtDiv" value="${Constant.PRMT_DIV_PLAN}" />
									<input type="hidden" name="prmtNum" id="prmtNum" />
								</form>

								<ul class="event-list">
									<li class="page-view"><img src="${prmtVO.dtlImg}" alt="${prmtVO.prmtNm}"></li>
								</ul>

								<%--상품노출구분_리스트형--%>
								<c:if test="${prmtVO.prdtViewDiv eq '1000'}">
									<div class="product-wrap" style="<c:if test="${not empty prmtVO.dtlBgColor}">background-color:#${prmtVO.dtlBgColor}; </c:if><c:if test="${not empty prmtVO.dtlBgImg}">background-image:url(${prmtVO.dtlBgImg});</c:if>">
                                        <ul class="product-list">
                                            <c:forEach var="prdt" items="${prmtPrdtList}">
                                                <c:set var="product" value="${prdt.data}" />
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
                                                                        <p class="sale"><fmt:formatNumber value="${1 - (product.saleAmt / product.nmlAmt)}" type="percent" /></p>
                                                                    </c:if>
                                                                    <p class="won"><span class="won2"><fmt:formatNumber>${product.saleAmt}</fmt:formatNumber></span><span class="won">원~</span></p>
                                                                </c:if>
                                                                <c:if test="${(prdt.corpCd eq Constant.SOCIAL) and (product.prdtDiv eq Constant.SP_PRDT_DIV_FREE)}">
                                                                    <p class="won"><span class="won2">쿠폰 상품</span></p>
                                                                </c:if>
                                                            </div>
                                                        </div>
                                                        <div class="cell cell4">
                                                        </div>
                                                    </a>
                                                </li>
                                            </c:forEach>
										</ul>
										<c:if test="${!(empty prmtVO.dtlUrl)}">
											<p class="oss-quick"><a href="${prmtVO.dtlUrl}" <c:if test="${prmtVO.dtlNwdYn eq 'Y'}">target="_blank"</c:if>>바로가기</a></p>
										</c:if>
									</div> <!-- //product-wrap -->
								</c:if>
								<%--상품노출구분_갤러리형--%>
								<c:if test="${prmtVO.prdtViewDiv eq '2000'}">
									<div class="product-wrap" style="<c:if test="${not empty prmtVO.dtlBgColor}">background-color:#${prmtVO.dtlBgColor}; </c:if><c:if test="${not empty prmtVO.dtlBgImg}">background-image:url(${prmtVO.dtlBgImg});</c:if>">
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
																		<div class="memo-black">
																			<c:if test="${not empty prmtPrdtMap[product.prdtNum].note}">
																			<div class="memo">${prmtPrdtMap[product.prdtNum].note}</div>
																			</c:if>
																		</div>

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
																					<span><c:out value="${product.prdtNm}" /></span>
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
																				<%--<del><fmt:formatNumber value="${product.nmlAmt}" /></del>--%>
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
										<c:if test="${!(empty prmtVO.dtlUrl)}">
										<p class="oss-quick"><a href="${prmtVO.dtlUrl}" <c:if test="${prmtVO.dtlNwdYn eq 'Y'}">target="_blank"</c:if>>바로가기</a></p>
										</c:if>
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
							</div> <!--//tabs-left-->
			            </div> <!--//tabs-wrap-->
			        </div> <!--//Fasten-->
			    </div> <!--//bgWrap-->
			</div> <!-- //event2-wrap -->
	        <!-- //Change Contents -->
	    </div> <!-- //subContents -->
	</div> <!-- //subContainer -->
</main>

<jsp:include page="/web/right.do" />
<jsp:include page="/web/foot.do" />

</body>
</html>