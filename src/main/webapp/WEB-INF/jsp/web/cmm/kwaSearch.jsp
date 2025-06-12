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
<meta name="robots" content="noindex">


<jsp:include page="/web/includeJs.do" />



<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css?version=1.2'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/sub.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/multiple-select.css'/>" />


<script type="text/javascript">


$(document).ready(function(){
});
</script>

</head>
<body>
	<header id="header">
		<jsp:include page="/web/head.do" />
	</header>

	<div class="sh-top">
		<div class="inner">
			<div class="box__result">
				'<em><c:out value="${KWAVO.kwaNm}" /></em>' 검색결과
				<strong class="count"><c:out value="${prdtSum}"/>개</strong>
			</div>				
            <%--<div class="box__sch">
                <div class="box__keyword">
                    <h3>연관검색어</h3>
                    <ul class="list__keyword">
                        <li class="list-item">
                            <a href="" title="검색결과 페이지로 이동합니다." class="keyword-link">제주도호텔</a>
                        </li>
                        <li class="list-item">
                            <a href="" title="검색결과 페이지로 이동합니다." class="keyword-link">제주도맛집</a>
                        </li>
                        <li class="list-item">
                            <a href="" title="검색결과 페이지로 이동합니다." class="keyword-link">제주도카페</a>
                        </li>
                        <li class="list-item">
                            <a href="" title="검색결과 페이지로 이동합니다." class="keyword-link">제주도레저</a>
                        </li>
                        <li class="list-item">
                            <a href="" title="검색결과 페이지로 이동합니다." class="keyword-link">제주도렌터카</a>
                        </li>
                        <li class="list-item">
                            <a href="" title="검색결과 페이지로 이동합니다." class="keyword-link">제주도펜션</a>
                        </li>
                    </ul>
                </div>
                <div class="sort-search">
                    <input type="text" class="" placeholder="검색 결과 내 재검색" autocapitalize="off">
                    <button type="button" title="검색" class="sort-search-btn" ></button> <!--  onclick="fn_subSearch()"  -->
                </div>
           	</div>--%>
		</div>
	</div>           	

	<!-- 상품 목록 -->
	<div class="socialItem">
		<h2 class="sec-caption">검색결과</h2>
		<div class="inner">		
	
			<c:if test="${fn:length(kwaprdtListAD) != 0}">
				<div class="item-area">
					<h2 class="listTitle1">숙소</h2>
						<ul class="col5">
							<c:forEach items="${kwaprdtListAD}" var="product">
								<li class="list-item">
									 <a href="<c:url value='/web/ad/detailPrdt.do?sPrdtNum=${product.prdtNum}'/>" class="link__item">
										<div class="box__image">				
											<img src="${product.savePath}thumb/${product.saveFileNm}" alt="" onerror="this.src='/images/web/other/no-image.jpg'">
										</div>								 
									 	<div class="box__information">
											<div class="bxTitle">[<c:out value="${product.adAreaNm}"/>]<c:out value="${product.adNm}"/></div>
											<div class="bxEvent"><c:out value="${product.adSimpleExp}" default="　"/></div>
											<div class="bxPrice">
												<span class="text__price"><fmt:formatNumber value="${product.saleAmt}"/></span><span class="text__unit">원</span>
											</div>								 	
									 	</div>
									 </a>
								</li>
							</c:forEach>	
						</ul>					
				</div>	
			</c:if>

			<c:if test="${fn:length(kwaprdtListRC) != 0}">
				<div class="item-area">
					<h2 class="listTitle1">렌터카</h2>
						<ul class="col5">
							<c:forEach items="${kwaprdtListRC}" var="product">
								<li class="list-item">
									 <a href="<c:url value='/web/rentcar/car-detail.do?prdtNum=${product.prdtNum}&searchYn=N'/> " class="link__item">
										<div class="box__image">				
											<img src="${product.saveFileNm}" alt="" onerror="this.src='/images/web/other/no-image.jpg'">
										</div>								 
									 	<div class="box__information">
											<div class="bxTitle"><c:out value="${product.rcNm}"/></div>
											<div class="bxEvent"><c:out value="${product.prdtNm}" default="　"/></div>
											<div class="bxPrice">
												<span class="text__price"><fmt:formatNumber value="${product.saleAmt}"/></span><span class="text__unit">원</span>
											</div>								 	
									 	</div>
									 </a>
								</li>
							</c:forEach>	
						</ul>					
				</div>	
			</c:if>
			
			<c:if test="${fn:length(kwaprdtListSPC100) != 0}">
				<div class="item-area">
					<h2 class="listTitle1">패키지할인상품</h2>
						<ul class="col5">
							<c:forEach items="${kwaprdtListSPC100}" var="product">
								<li class="list-item">
									 <a href="<c:url value='/web/sp/detailPrdt.do?prdtNum=${product.prdtNum}&prdtDiv=${product.prdtDiv}'/>" class="link__item">
										<div class="box__image">				
											<img src="${product.savePath}thumb/${product.saveFileNm}" alt="" onerror="this.src='/images/web/other/no-image.jpg'">
										</div>								 
									 	<div class="box__information">
											<div class="bxTitle"><c:out value="${product.prdtNm}"/></div>
											<div class="bxEvent"><c:out value="${product.prdtInf}" default="　"/></div>
											<div class="bxPrice">
												<c:if test="${product.prdtDiv ne Constant.SP_PRDT_DIV_FREE }">
													<span class="text__price"><fmt:formatNumber value="${product.saleAmt}"/></span><span class="text__unit">원</span>
												</c:if>		 	
											</div>						
									 	</div>
									 </a>
								</li>
							</c:forEach>	
						</ul>					
				</div>	
			</c:if>			
			
			<c:if test="${fn:length(kwaprdtListSPC200) != 0}">
				<div class="item-area">
					<h2 class="listTitle1">관광지/레저</h2>
						<ul class="col5">
							<c:forEach items="${kwaprdtListSPC200}" var="product">
								<li class="list-item">
									 <a href="<c:url value='/web/sp/detailPrdt.do?prdtNum=${product.prdtNum}&prdtDiv=${product.prdtDiv}'/>" class="link__item">
										<div class="box__image">				
											<img src="${product.savePath}thumb/${product.saveFileNm}" alt="" onerror="this.src='/images/web/other/no-image.jpg'">
										</div>								 
									 	<div class="box__information">
											<div class="bxTitle"><c:out value="${product.prdtNm}"/></div>
											<div class="bxEvent"><c:out value="${product.prdtInf}" default="　"/></div>
											<div class="bxPrice">
												<c:if test="${product.prdtDiv ne Constant.SP_PRDT_DIV_FREE }">
													<span class="text__price"><fmt:formatNumber value="${product.saleAmt}"/></span><span class="text__unit">원</span>
												</c:if>
											</div>								 	
									 	</div>
									 </a>
								</li>
							</c:forEach>	
						</ul>					
				</div>	
			</c:if>				

			<c:if test="${fn:length(kwaprdtListSPC300) != 0}">
				<div class="item-area">
					<h2 class="listTitle1">음식/뷰티</h2>
						<ul class="col5">
							<c:forEach items="${kwaprdtListSPC300}" var="product">
								<li class="list-item">
									 <a href="<c:url value='/web/sp/detailPrdt.do?prdtNum=${product.prdtNum}&prdtDiv=${product.prdtDiv}'/>" class="link__item">
										<div class="box__image">				
											<img class="img" src="${product.savePath}thumb/${product.saveFileNm}" alt="" onerror="this.src='/images/web/other/no-image.jpg'">
										</div>								 
									 	<div class="box__information">
											<div class="bxTitle"><c:out value="${product.prdtNm}"/></div>
											<div class="bxEvent"><c:out value="${product.prdtInf}" default="　"/></div>
											<div class="bxPrice">
												<c:if test="${product.prdtDiv ne Constant.SP_PRDT_DIV_FREE }">
													<span class="text__price"><fmt:formatNumber value="${product.saleAmt}"/></span><span class="text__unit">원</span>
												</c:if>
											</div>								 	
									 	</div>
									 </a>
								</li>
							</c:forEach>	
						</ul>					
				</div>	
			</c:if>	

			<c:if test="${fn:length(kwaprdtListSPC500) != 0}">
				<div class="item-area">
					<h2 class="listTitle1">카시트/유모차</h2>
						<ul class="col5">
							<c:forEach items="${kwaprdtListSPC500}" var="product">
								<li class="list-item">
									 <a href="<c:url value='/web/sp/detailPrdt.do?prdtNum=${product.prdtNum}&prdtDiv=${product.prdtDiv}'/>" class="link__item">
										<div class="box__image">				
											<img class="img" src="${product.savePath}thumb/${product.saveFileNm}" alt="" onerror="this.src='/images/web/other/no-image.jpg'">
										</div>								 
									 	<div class="box__information">
											<div class="bxTitle"><c:out value="${product.prdtNm}"/></div>
											<div class="bxEvent"><c:out value="${product.prdtInf}" default="　"/></div>
											<div class="bxPrice">
												<c:if test="${product.prdtDiv ne Constant.SP_PRDT_DIV_FREE }">
													<span class="text__price"><fmt:formatNumber value="${product.saleAmt}"/></span><span class="text__unit">원</span>
												</c:if>
											</div>								 	
									 	</div>
									 </a>
								</li>
							</c:forEach>	
						</ul>					
				</div>	
			</c:if>	
			
			<c:if test="${fn:length(kwaprdtListSV) != 0}">
				<div class="item-area">
					<h2 class="listTitle1">제주특산/기념품</h2>
						<ul class="col5">
							<c:forEach items="${kwaprdtListSV}" var="product">
								<li class="list-item">
									 <a href="<c:url value='/web/sv/detailPrdt.do?prdtNum=${product.prdtNum}'/>" class="link__item">
										<div class="box__image">				
											<img class="img" src="${product.savePath}thumb/${product.saveFileNm}" alt="" onerror="this.src='/images/web/other/no-image.jpg'">
										</div>								 
									 	<div class="box__information">
											<div class="bxTitle"><c:out value="${product.prdtNm}"/></div>
											<div class="bxEvent"><c:out value="${product.prdtInf}" default="　"/></div>
											<div class="bxPrice">
												<span class="text__price"><fmt:formatNumber value="${product.saleAmt}"/></span><span class="text__unit">원</span>
											</div>								 	
									 	</div>
									 </a>
								</li>
							</c:forEach>	
						</ul>					
				</div>	
			</c:if>			
		</div>
	</div>
	
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



