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
<jsp:include page="/mw/includeJs.do"></jsp:include>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub_package.css'/>">		
<script type="text/javascript">
function fn_Search(){
	document.frm.action = "<c:url value='/mw/tour/jeju.do'/>";
	document.frm.submit();
}

function fn_Reset(){
	$("#sAplDt").val('');
	$("#sCtgr").val('${fn:substring(searchVO.sCtgr, 0, 2)}00');
	$("#sPrice").val('');
}

$(document).ready(function(){
	$("#sAplDt").datepicker({
		dateFormat : "yy-mm-dd",
		minDate : "${SVR_TODAY}"
	});
});
</script>
</head>
<body>
<div id="wrap">

<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do"></jsp:include>
</header>
<!-- 헤더 e -->

<!-- 콘텐츠 s -->
<h2 class="sr-only">서브콘텐츠</h2>
<section id="subContent">

	<div class="menu-bar">
		<p class="btn-prev"><img src="<c:url value='/images/mw/common/btn_prev.png'/>" width="20" alt="이전페이지"></p>
		<h2>패키지 할인상품</h2>
	</div>
	<div class="sub-content">
	<div class="package">
			<div class="con-box">
			<form name="frm" id="frm" method="get" onSubmit="return false;">
				<input type="hidden" name="sCtgrTab" id="sCtgrTab" value="${searchVO.sCtgrTab}"/>		
				<div class="form1 form1-0">
					<label>유형</label><br>
					<select style="width: 100%; margin-bottom:10px;" name="sCtgr" id="sCtgr">
						<option value="${fn:substring(searchVO.sCtgr, 0, 2)}00">전체</option>
						<c:forEach items="${categoryList}" var="category" varStatus="status">
							<option value="${category.cdNum}" <c:if test="${category.cdNum == searchVO.sCtgr}">selected</c:if> ><c:out value="${category.cdNm}" /></option>
						</c:forEach>
					</select>
				</div>
				<div class="form1 form1-1">
					<label>여행희망일 / 가격</label><br>
					<span class="cal">
						<input type="text" readonly="readonly" name="sAplDt" id="sAplDt">
					</span>
					<select name="sPrice" id="sPrice">
						<option value="">가격선택</option>
						<option value="end5">~5만원</option>
						<option value="5to10">5만원~10만원</option>
						<option value="start10">10만원~</option>
						<option value="start20">20만원~</option>
					</select>
				</div>
				</form>
				<p class="btn-list btn-in">
					<a href="javascript:fn_Search();" class="btn btn1">검색하기</a>
					<a href="javascript:fn_Reset();" class="btn btn2"><img src="<c:url value='/images/mw/sub_common/reload.png'/>" width="11" alt=""> 초기화</a>
				</p>
			</div>
			
			<!--베스트상품-->
			<div class="best-item">
				<div class="goods-list goods-slide">
					<ul>
						<c:forEach items="${bestProductList}" var="bestProduct">
						<li>
							<a href="<c:url value='/mw/sp/detailPrdt.do?prdtNum=${bestProduct.prdtNum}'/>">
								<div class="goods-image">
									<p class="tag3">BEST<br>상품</p>
									<ul class="view">
										<li><img src="${bestProduct.savePath}thumb/${bestProduct.saveFileNm}" alt=""></li>
									</ul>
								</div>
								<p class="info">
									<span class="txt">
										<strong><c:out value='${bestProduct.prdtNm}'/></strong>
										<em><c:out value="${bestProduct.prdtInf}"/></em>
				
										<c:if test="${bestProduct.prdtDiv eq Constant.SP_PRDT_DIV_COUP }">
						                    <!-- 옵션추가 (상품구분 - 옵션명 기준) -->
							                <%-- <span class="product">
												<span>상품구분) </span> <span><c:out value="${bestProduct.prdtDivNm}" /> - <c:out value="${bestProduct.optNm}" /> 기준</span>
											</span> --%>
						                </c:if>
										
										<span class="heart">
											<img src="<c:url value='/images/mw/sub_common/heart.png'/>" alt="평점">
											<span class="ind_grade"><strong>${bestProduct.gpaAvg }</strong>/5</span>
										</span>
									</span>
									<span class="price">
										<em><fmt:formatNumber value="${1 - (bestProduct.saleAmt / bestProduct.nmlAmt)}" type="percent"/></em><br>
										<del><fmt:formatNumber value='${bestProduct.nmlAmt}'  type='number'  />원</del> <img src="../../images/mw/sub_common/price_arrow.png" width="8" alt=""> <strong><fmt:formatNumber value='${bestProduct.saleAmt}'  type='number'  /></strong>원~
									</span>
								</p>
							</a>
						</li>
						</c:forEach>
					</ul>
					<p>
						<span class="btn-prev"></span>
						<span class="btn-next"></span>
					</p>

				</div>
			</div>
			<!--//베스트상품-->
		</div>
	</div>
</section>
<!-- 콘텐츠 e -->


<!-- 푸터 s -->
<jsp:include page="/mw/foot.do" flush="false"></jsp:include>
</div>
</body>
</html>

	