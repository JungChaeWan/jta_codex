<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="un" uri="http://jakarta.apache.org/taglibs/unstandard-1.0"%>

<un:useConstants var="Constant" className="common.Constant" />
<head>

<jsp:include page="/web/includeJs.do" />



<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css'/>" />


<script type="text/javascript">


$(document).ready(function(){
});
</script>

</head>
<body>
	<header id="header">
		<jsp:include page="/web/head.do" />
	</header>
	<main id="main">
	<div class="mapLocation">
		<!--index page에서는 삭제-->
		<div class="inner">
			<span>홈</span> <span class="gt">&gt;</span>
			<span>키워드 광고</span>
		</div>
	</div>

	<!-- quick banner -->
	<jsp:include page="/web/left.do" />
	<!-- //quick banner -->
	<div class="subContainer">
		<div class="subHead"></div>
            <div class="subContents">
                <!-- new contents -->
                <div class="sh-page">
                    <div class="bgWrap2">
                        <div class="Fasten">
                        	<%--
                        	<c:if test="${adCnt + rcCnt + glCnt + packageCnt + tourCnt + foodCnt + svCnt == 0 }">
                        		<div class="sh-top">
                                <!-- 콘텐츠 없을 시 -->
                                <h3 class="not">
                                    <img src="<c:url value='/images/web/icon/search.gif'/>" alt=""><strong class="comm-color1">"<c:out value="${search}" />"</strong>에 대한 검색결과가 없습니다.
                                </h3>
                                <div class="item-noContent">
                                    <p><img src="<c:url value='/images/web/icon/warning2.gif'/>" alt="경고"></p>
                                    <p class="text">죄송합니다.<br><strong class="comm-color1">"<c:out value="${search}" />"</strong>에 대한 검색결과가 없습니다.</p>
                                </div>
                            </div> <!-- //top -->
                        	</c:if>
                        	<c:if test="${adCnt + rcCnt + glCnt + packageCnt + tourCnt + foodCnt + svCnt > 0 }">
                        	 --%>
                            <div class="sh-top">
                                <h3>
                                	 <img src="<c:out value='/images/web/icon/search.gif'/>" alt="">
                                    <strong class="comm-color1">"<c:out value="${KWAVO.kwaNm}" />"</strong>에 대한 <strong class="count"><c:out value="${prdtSum}"/></strong>건의 검색결과입니다.
                                </h3>
                            </div>

                              <div class="list-item">

								<c:if test="${fn:length(kwaprdtListAD) != 0}">
							        <div class="itemWrap">
							            <h5 class="listTitle1">숙박</h5>
							            <c:forEach items="${kwaprdtListAD}" var="product">
	                                    	<div class="item">
								            <a href="<c:url value='/web/ad/detailPrdt.do?sPrdtNum=${product.prdtNum}'/>">
								                <p class="photo">
								                    <img class="img" src="${product.savePath}thumb/${product.saveFileNm}" alt="">
								                </p>
								                <article class="textWrap">
								                    <h5 class="title">[<c:out value="${product.adAreaNm}"/>]<c:out value="${product.adNm}"/></h5>
								                    <p class="subTitle"><c:out value="${product.adSimpleExp}"/></p>
								                    <ul class="info">
								                        <li class="saleWrap">
								                            <p class="sale">
								                            	<span class="t_price">탐나오가</span>
								                            	<%-- <c:if test="${product.nmlAmt>0 }">
	                                                        		<fmt:formatNumber value='${1-product.saleAmt/product.nmlAmt }' type="percent" />
	                                                        	</c:if>
	                                                        	<c:if test="${!(product.nmlAmt>0) }">
										                      		0%
										                      	</c:if> --%>
								                            </p>
								                            <p class="won"><span class="won1"><fmt:formatNumber>${product.nmlAmt}</fmt:formatNumber></span><span class="won2"><fmt:formatNumber>${product.saleAmt}</fmt:formatNumber>~</span></p>
								                        </li>
								                        <!-- <li class="comment">
								                            <p class="like">
								                                <span><img src="../images/web/icon/heart.gif" alt="하트"></span>
								                                <span class="ind_grade"><strong>4.8</strong>/5</span>
								                            </p>
								                        </li> -->
								                    </ul>
								                </article>
								            </a>
								        	</div> <!-- //item -->
										</c:forEach>
							        </div> <!-- //itemWrap -->
							   </c:if>

							   <c:if test="${fn:length(kwaprdtListRC) != 0}">
							   		<div class="itemWrap">
							            <h5 class="listTitle1">렌터카</h5>
								   		<c:forEach items="${kwaprdtListRC}" var="product">
	                                  		<div class="item">
									            <a href="<c:url value='/web/rentcar/car-detail.do?prdtNum=${product.prdtNum}&searchYn=N'/>">
									                <p class="photo">
									                    <img class="img" src="${product.saveFileNm}" alt="">
									                </p>
									                <article class="textWrap">									                    
									                    <p class="subTitle"><c:out value="${product.rcNm}"/></p>
									                    <h5 class="title"><c:out value="${product.prdtNm}"/></h5>
									                    <ul class="info">
									                        <li class="saleWrap">
									                            <p class="sale">
									                            	<span class="t_price">탐나오가</span>
									                            	<%-- <c:out value="${product.disPer}"/>% --%>
									                            </p>
									                            <p class="won"><span class="won1"><fmt:formatNumber>${product.nmlAmt}</fmt:formatNumber></span><span class="won2"><fmt:formatNumber>${product.saleAmt}</fmt:formatNumber>~</span></p>
									                        </li>
									                        <!-- <li class="comment">
									                            <p class="like">
									                                <span><img src="../images/web/icon/heart.gif" alt="하트"></span>
									                                <span class="ind_grade"><strong>4.8</strong>/5</span>
									                            </p>
									                        </li> -->
									                    </ul>
									                </article>
									            </a>
									        </div> <!-- //item -->
	                               		</c:forEach>
	                               	</div>
							   </c:if>

							   <c:if test="${fn:length(kwaprdtListSPC100) != 0}">
						       		<div class="itemWrap">
							            <h5 class="listTitle1">패키지할인상품</h5>
								   		<c:forEach items="${kwaprdtListSPC100}" var="product">
	                                     	<div class="item">
									            <a href="<c:url value='/web/sp/detailPrdt.do?prdtNum=${product.prdtNum}&prdtDiv=${product.prdtDiv}'/>">
									                <p class="photo">
									                    <img class="img" src="${product.savePath}thumb/${product.saveFileNm}" alt="">
									                </p>
									                <article class="textWrap">
									                    <h5 class="title"><c:out value="${product.prdtNm}"/></h5>
									                    <p class="subTitle"><c:out value="${product.prdtInf}"/></p>
									                    <ul class="info">
									                    	<li class="saleWrap">
	                                                            <c:if test="${product.prdtDiv ne Constant.SP_PRDT_DIV_FREE }">
	                                                        	<p class="sale"><span class="t_price">탐나오가</span><%-- <fmt:formatNumber value="${1 - (product.saleAmt / product.nmlAmt)}" type="percent"/> --%></p>
	                                                            <p class="won"><span class="won1"><fmt:formatNumber value="${product.nmlAmt}" type="number"/></span><span class="won2"><fmt:formatNumber value="${product.saleAmt }" type="number"/><c:if test="${result.prdtDiv eq Constant.SP_PRDT_DIV_TOUR}">~</c:if></span></p>
	                                                        	</c:if>
	                                                        </li>
									                    </ul>
									                </article>
									            </a>
									        </div> <!-- //item -->
	                                     </c:forEach>
	                               	</div>
	                            </c:if>

	                            <c:if test="${fn:length(kwaprdtListSPC200) != 0}">
						       		<div class="itemWrap">
							            <h5 class="listTitle1">관광지/레저</h5>
								   		<c:forEach items="${kwaprdtListSPC200}" var="product">
	                                     	<div class="item">
									            <a href="<c:url value='/web/sp/detailPrdt.do?prdtNum=${product.prdtNum}&prdtDiv=${product.prdtDiv}'/>">
									                <p class="photo">
									                    <img class="img" src="${product.savePath}thumb/${product.saveFileNm}" alt="">
									                </p>
									                <article class="textWrap">
									                    <h5 class="title"><c:out value="${product.prdtNm}"/></h5>
									                    <p class="subTitle"><c:out value="${product.prdtInf}"/></p>
									                    <ul class="info">
									                    	<li class="saleWrap">
	                                                            <c:if test="${product.prdtDiv ne Constant.SP_PRDT_DIV_FREE }">
	                                                        	<p class="sale"><span class="t_price">탐나오가</span><%-- <fmt:formatNumber value="${1 - (product.saleAmt / product.nmlAmt)}" type="percent"/> --%></p>
	                                                            <p class="won"><span class="won1"><fmt:formatNumber value="${product.nmlAmt}" type="number"/></span><span class="won2"><fmt:formatNumber value="${product.saleAmt }" type="number"/><c:if test="${result.prdtDiv eq Constant.SP_PRDT_DIV_TOUR}">~</c:if></span></p>
	                                                        	</c:if>
	                                                        </li>
									                    </ul>
									                </article>
									            </a>
									        </div> <!-- //item -->
	                                     </c:forEach>
	                               	</div>
	                            </c:if>

	                            <c:if test="${fn:length(kwaprdtListSPC300) != 0}">
						       		<div class="itemWrap">
							            <h5 class="listTitle1">음식/뷰티</h5>
								   		<c:forEach items="${kwaprdtListSPC300}" var="product">
	                                     	<div class="item">
									            <a href="<c:url value='/web/sp/detailPrdt.do?prdtNum=${product.prdtNum}&prdtDiv=${product.prdtDiv}'/>">
									                <p class="photo">
									                    <img class="img" src="${product.savePath}thumb/${product.saveFileNm}" alt="">
									                </p>
									                <article class="textWrap">
									                    <h5 class="title"><c:out value="${product.prdtNm}"/></h5>
									                    <p class="subTitle"><c:out value="${product.prdtInf}"/></p>
									                    <ul class="info">
									                    	<li class="saleWrap">
	                                                            <c:if test="${product.prdtDiv ne Constant.SP_PRDT_DIV_FREE }">
	                                                        	<p class="sale"><span class="t_price">탐나오가</span><%-- <fmt:formatNumber value="${1 - (product.saleAmt / product.nmlAmt)}" type="percent"/> --%></p>
	                                                            <p class="won"><span class="won1"><fmt:formatNumber value="${product.nmlAmt}" type="number"/></span><span class="won2"><fmt:formatNumber value="${product.saleAmt }" type="number"/><c:if test="${result.prdtDiv eq Constant.SP_PRDT_DIV_TOUR}">~</c:if></span></p>
	                                                        	</c:if>
	                                                        </li>
									                    </ul>
									                </article>
									            </a>
									        </div> <!-- //item -->
	                                     </c:forEach>
	                               	</div>
	                            </c:if>

								  <c:if test="${fn:length(kwaprdtListSPC500) != 0}">
									  <div class="itemWrap">
										  <h5 class="listTitle1">카시트/유모차</h5>
										  <c:forEach items="${kwaprdtListSPC500}" var="product">
											  <div class="item">
												  <a href="<c:url value='/web/sp/detailPrdt.do?prdtNum=${product.prdtNum}&prdtDiv=${product.prdtDiv}'/>">
													  <p class="photo">
														  <img class="img" src="${product.savePath}thumb/${product.saveFileNm}" alt="">
													  </p>
													  <article class="textWrap">
														  <h5 class="title"><c:out value="${product.prdtNm}"/></h5>
														  <p class="subTitle"><c:out value="${product.prdtInf}"/></p>
														  <ul class="info">
															  <li class="saleWrap">
																  <c:if test="${product.prdtDiv ne Constant.SP_PRDT_DIV_FREE }">
																	  <p class="sale"><span class="t_price">탐나오가</span><%-- <fmt:formatNumber value="${1 - (product.saleAmt / product.nmlAmt)}" type="percent"/> --%></p>
																	  <p class="won"><span class="won1"><fmt:formatNumber value="${product.nmlAmt}" type="number"/></span><span class="won2"><fmt:formatNumber value="${product.saleAmt }" type="number"/><c:if test="${result.prdtDiv eq Constant.SP_PRDT_DIV_TOUR}">~</c:if></span></p>
																  </c:if>
															  </li>
														  </ul>
													  </article>
												  </a>
											  </div> <!-- //item -->
										  </c:forEach>
									  </div>
								  </c:if>

						        <c:if test="${fn:length(kwaprdtListSV) != 0}">
							   		<div class="itemWrap">
							            <h5 class="listTitle1">제주특산/기념품</h5>
								   		<c:forEach items="${kwaprdtListSV}" var="product">
	                                     	<div class="item">
									            <a href="<c:url value='/web/sv/detailPrdt.do?prdtNum=${product.prdtNum}'/>">
									                <p class="photo">
									                    <img class="img" src="${product.savePath}thumb/${product.saveFileNm}" alt="">
									                </p>
									                <article class="textWrap">
									                    <h5 class="title"><c:out value="${product.prdtNm}"/></h5>
									                    <p class="subTitle"><c:out value="${product.prdtInf}"/></p>
									                    <ul class="info">
									                    	<li class="saleWrap">
	                                                        	<p class="sale">
	                                                        		<%-- <c:if test="${product.saleAmt ne product.nmlAmt}">
	                                                        			<fmt:formatNumber value="${1 - (product.saleAmt / product.nmlAmt)}" type="percent"/>
	                                                        		</c:if>
	                                                        		<c:if test="${product.saleAmt eq product.nmlAmt}"> --%>
	                                                        			<span class="t_price">탐나오가</span>
	                                                        		<%-- </c:if> --%>
																</p>
	                                                            <p class="won">
	                                                            	<c:if test="${product.saleAmt ne product.nmlAmt}">
	                                                            		<span class="won1"><fmt:formatNumber value="${product.nmlAmt}" type="number"/></span>
	                                                            	</c:if>
	                                                            	<span class="won2"><fmt:formatNumber value="${product.saleAmt }" type="number"/></span>
	                                                            </p>
	                                                        </li>
									                    </ul>
									                </article>
									            </a>
									        </div> <!-- //item -->
	                                     </c:forEach>
	                               	</div>
							   </c:if>
						    </div> <!-- //list-item -->
                        </div> <!-- //Fasten -->
                    </div> <!-- //bgWrap2 -->
                </div> <!-- //sh-page -->
                <!-- //new contents -->
            </div> <!-- //subContents -->
        </div> <!-- //subContainer -->
	</main>
	<form name="cmmfrm" id="cmmfrm" method="get" onSubmit="return false;">
		<input type="hidden" name="pageIndex" id="pageIndex"/>
		<input type="hidden" name="orderCd" id="orderCd"/>
		<input type="hidden" name="orderAsc" id="orderAsc"/>
		<input type="hidden" name="sLON"  id="sLON"/>
		<input type="hidden" name="sLAT" id="sLAT"/>
		<input type="hidden" name="searchWord" value="<c:out value='${search}'/>"/>
	</form>
	<form name="adfrm" id="adfrm" method="get" onSubmit="return false;">
		<input type="hidden" name="sFromDt" value="${adSearch.sFromDt}"/>
		<input type="hidden" name="sNights" value="${adSearch.sNights}"/>
	</form>
	<form name="glfrm" id="glfrm" method="get" onSubmit="return false;">
		<input type="hidden" name="sFromDt" value="${glSearch.sFromDt}"/>
		<input type="hidden" name="sNights" value="${glSearch.sNights}"/>
	</form>
	<form name="rcfrm" id="rcfrm" method="get" onSubmit="return false;">
		<input type="hidden" name="sFromDt" value="${rcSearch.sFromDt}"/>
		<input type="hidden" name="sToDt" value="${rcSearch.sToDt}"/>
		<input type="hidden" name="sFromTm" value="${rcSearch.sFromTm}"/>
		<input type="hidden" name="sToTm" value="${rcSearch.sToTm}"/>
	</form>
	<form name="spfrm" id="spfrm" method="get" onSubmit="return false;">
		<input type="hidden" name="sCtgr" />
	</form>
	<form name="svfrm" id="svfrm" method="get" onSubmit="return false;">
		<input type="hidden" name="sCtgr" />
	</form>
	<input type="hidden" id="tabType" value="AD">

	<!-- AceCounter eCommerce (Product_Search) v8.0 Start -->
	<script language='javascript'>
		var _skey = '${search}';
	</script>
	<!-- AceCounter eCommerce (Product_Search) v8.0 End -->

	<jsp:include page="/web/right.do" />
	<jsp:include page="/web/foot.do" />
</body>
</html>



