<!DOCTYPE html>
<html lang="ko">
<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />
<head>
<meta name="robots" content="noindex">
<c:if test="${fn:length(imgList) == 0}">
	<c:set value="" var="seoImage"/>
</c:if>

<jsp:include page="/web/includeJs.do" flush="false">
	<jsp:param name="title" value="${prdtVO.prdtNm}"/>
	<jsp:param name="keywordsLinkNum" value="${prdtVO.prdtNum}"/>
	<jsp:param name="keywordAdd1" value="${prdtVO.prdtNm}"/>
	<jsp:param name="keywordAdd2" value="${prdtVO.corpNm}"/>
	<jsp:param name="description" value="[${prdtVO.corpNm}] ${prdtVO.prdtNm} : ${prdtVO.carDivNm}, ${prdtVO.modelYear}년식, ${prdtVO.transDivNm}, ${prdtVO.useFuelDivNm}, 승차인원 ${prdtVO.maxiNum}명 "/>
	<jsp:param name="imagePath" value="${seoImage}"/>
	<jsp:param name="headTitle" value="${prdtVO.prdtNm}"/>
</jsp:include>

<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css'/>" />

<script type="text/javascript" src="<c:url value='/js/useepil.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/otoinq.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/bloglink.js'/>"></script>
<script type="text/javascript">
// 검색폼
function fn_formSubmit() {	
	document.frm.action = "<c:url value='/web/rentcar/car-list.do'/>";
	document.frm.submit();
}

/**
 * 대여기간 텍스트 변경
 */
function fn_ChangeRange(){
	$("#info_sDt").html($("#sFromDtView").val());
	$("#info_sTm").html($("#vFromTm :selected").text().substring(0,2) + "시");
	$("#info_eDt").html($("#sToDtView").val());
	$("#info_eTm").html($("#vToTm :selected").text().substring(0,2) + "시");
}

function fn_OnchangeTime(){
	$("#sFromTm").val($("#vFromTm :selected").val());
	$("#sToTm").val($("#vToTm :selected").val());

//	fn_CalRent();
}

/**
 * 선택사항 변경 시
 */
function fn_OptChange(obj){
	$("#insuSaleAmt").val($(obj).val());
	$("#vInsuSaleAmt").html(commaNum($(obj).val()));
	fn_TotalCmt();
}

$(document).ready(function(){
	$("#sFromDtView").datepicker({
		dateFormat: "yy-mm-dd",
		minDate: "${SVR_TODAY}",
		maxDate: "${AFTER_DAY}",
		defaultDate: "${searchVO.sFromDtView}",
		onSelect : function(selectedDate) {
			$('#sFromDt').val($('#sFromDtView').val().replace(/-/g, ''));

			$('#sToDtView').datepicker("destroy");

			$("#sToDtView").datepicker({
				dateFormat: "yy-mm-dd",
				minDate: "${SVR_TODAY}",
				defaultDate: fn_NexDay(selectedDate),
				onSelect : function(selectedDate) {
					$('#sToDt').val($('#sToDtView').val().replace(/-/g, ''));					
			//		fn_CalRent();

				}
			});
			
			$("#sToDtView").val(fn_NexDay(selectedDate)).datepicker("option", "minDate", selectedDate);

			$('#sToDt').val($('#sToDtView').val().replace(/-/g, ''));

		//	fn_CalRent();

		//	$("#sToDtView").datepicker("option", "minDate", selectedDate);
			
		}
	});

	$("#sToDtView").datepicker({
		dateFormat: "yy-mm-dd",
		minDate: "${SVR_TODAY}",
		maxDate: "${AFTER_DAY}",
		defaultDate: "${searchVO.sToDtView}",
		onSelect : function(selectedDate) {
			$('#sToDt').val($('#sToDtView').val().replace(/-/g, ''));
		//	fn_CalRent();

		}
	});

	
	fn_ChangeRange();
	
	$('input[name=sCarDivCdStr]').click(function() {	
		$('#sCarDivCd').val($(this).val());
		$('#carDivStr').text($("label[for=" + $(this).attr('id') + "]").text());
		optionClose($("#rent_zone"));
	});	
});
</script>

</head>
<body>
<header id="header">
	<jsp:include page="/web/head.do" flush="false"></jsp:include>
</header>
<main id="main">
	<div class="mapLocation">
	    <div class="inner">
	        <span>홈</span> <span class="gt">&gt;</span>
	        <span>렌터카 가격비교</span>
	    </div>
	</div>
	
	<div class="subContainer">
	    <div class="subHead"></div>
	    <div class="subContents">
	
	        <!-- Change Contents -->
	        <!-- 검색바 -->
	        <section class="search-typeA">
	        	<h2 class="sec-caption">렌터카 검색</h2>
	        	<c:if test="${searchVO.searchYn eq Constant.FLAG_Y}">
	        	  <c:set var="form_url" value="/web/rentcar/car-detail.do" />
	        	</c:if>
	        	<c:if test="${searchVO.searchYn eq Constant.FLAG_N}">
	        	  <c:set var="form_url" value="/web/rentcar/car-list.do" />
	        	</c:if>
	        	<form name="frm" id="frm" method="get" action="<c:url value='${form_url }' />">
					<input type="hidden" name="mYn" id="mYn" value="${searchVO.mYn}" />					
					<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}" />
					<input type="hidden" name="sCarDivCdView" id="sCarDivCdView" value="${searchVO.sCarDivCdView}" />
					<input type="hidden" name="orderCd" id="orderCd" value="${searchVO.orderCd}" />
					<input type="hidden" name="orderAsc" id="orderAsc" value="${searchVO.orderAsc}" />
					<input type="hidden" name="mYn" id="mYn" value="${searchVO.mYn}" />
					<input type="hidden" name="searchYn" id="searchYn" value="${Constant.FLAG_Y}" />
					<input type="hidden" name="prdtNum" id="prdtNum" value="${prdtVO.prdtNum}" />
					<input type="hidden" name="sIsrDiv" id="sIsrDiv" value="${searchVO.sIsrDiv}" />	<!-- 보험여부 -->
					<input type="hidden" name="sCorpId" id="sCorpId" value="${searchVO.sCorpId}" /> <!-- 렌터카회사 -->
					<input type="hidden" name="sCarDivCd" id="sCarDivCd" value="${searchVO.sCarDivCd}" /> <!-- 차량 유형 검색 -->
	        	<div class="Fasten">
		        	<!-- 코드중복(include) -->
					<div class="form-area">
					    <div class="search-area rent">
					        <div class="area date">
					            <dl>
					                <dt>대여일</dt>
					                <dd>
					                    <div class="value-text">
					                        <div class="date-time-area">
					                        	<input type="hidden" name="sFromDt" id="sFromDt" value="${searchVO.sFromDt}">
					                            <div class="date-container">
					                                <span class="date-wrap">
					                                    <input class="datepicker" type="text" name="sFromDtView" id="sFromDtView" placeholder="대여일 선택" value="${searchVO.sFromDtView}" onclick="optionClose('.popup-typeA')">
					                                </span>
					                            </div>
					                            <div class="time-area">
					                                <select name="sFromTm" id="sFromTm" class="full" title="시간선택">
					                                	<c:forEach begin="8" end="20" step="1" var="fromTime">
                                                    	<c:if test='${fromTime < 10}'>
                                                    		<c:set var="fromTime_v" value="0${fromTime}00" />
                                                    		<c:set var="fromTime_t" value="0${fromTime}:00" />
                                                    	</c:if>
                                                    	<c:if test='${fromTime > 9}'>
                                                    		<c:set var="fromTime_v" value="${fromTime}00" />
                                                    		<c:set var="fromTime_t" value="${fromTime}:00" />
                                                    	</c:if>
	                                                    <option value="${fromTime_v}" <c:if test="${searchVO.sFromTm == fromTime_v}">selected="selected"</c:if>>${fromTime_t}</option>
	                                                </c:forEach>
					                                </select>
					                            </div>
					                        </div>
					                    </div>
					                </dd>
					            </dl>
					            <span class="guide"></span>
					            <dl>
					                <dt>반납일</dt>
					                <dd>
					                    <div class="value-text">
					                        <div class="date-time-area">
					                        	<input type="hidden" name="sToDt" id="sToDt" value="${searchVO.sToDt}">
					                            <div class="date-container">
					                                <span class="date-wrap">
					                                    <input class="datepicker" type="text" name="sToDtView" id="sToDtView" placeholder="반납일 선택" value="${searchVO.sToDtView}" onclick="optionClose('.popup-typeA')">
					                                </span>
					                            </div>
					                            <div class="time-area">
					                                <select name="sToTm" id="sToTm" class="full" title="시간선택">
					                                    <c:forEach begin="8" end="20" step="1" var="toTime">
                                                    	<c:if test='${toTime < 10}'>
                                                    		<c:set var="toTime_v" value="0${toTime}00" />
                                                    		<c:set var="toTime_t" value="0${toTime}:00" />
                                                    	</c:if>
                                                    	<c:if test='${toTime > 9}'>
                                                    		<c:set var="toTime_v" value="${toTime}00" />
                                                    		<c:set var="toTime_t" value="${toTime}:00" />
                                                    	</c:if>
	                                                    <option value="${toTime_v}" <c:if test="${searchVO.sToTm == toTime_v}">selected="selected"</c:if>>${toTime_t}</option>
	                                                </c:forEach>
					                                </select>
					                            </div>
					                        </div>
					                    </div>
					                </dd>
					            </dl>
					        </div>
					        <div class="area type select">
					            <dl>
					                <dt>렌터카 유형</dt>
					                <dd>
					                  <c:if test="${searchVO.searchYn eq Constant.FLAG_Y}">
					                    <div class="value-text lock"><a href="javascript:void(0)">전체</a></div>
					                  </c:if>
					                  <c:if test="${searchVO.searchYn eq Constant.FLAG_N}">
					                    <!-- <div class="value-text"><a href="javascript:void(0)" onclick="optionPopup('#rent_zone', this)" id="carDivStr">전체</a></div> -->
					                    <div class="value-text"><a href="javascript:void(0)" onclick="optionPopup('#rent_zone', this)" id="carDivStr">					                    
					                    <c:if test="${empty searchVO.sCarDivCd }">
					                      전체
					                    </c:if>
					                    <c:if test="${not empty searchVO.sCarDivCd }">
						                  <c:forEach var="code" items="${carDivCd}" varStatus="status">
		                                    <c:if test="${code.cdNum eq searchVO.sCarDivCd}">
		                                      ${code.cdNm}
		                                    </c:if>
		                                  </c:forEach>
		                                </c:if>
					                    </a></div>
					                    <div id="rent_zone" class="popup-typeA rent-zone">
					                        <ul class="select-menu col3">
					                            <li><a href="javascript:void(0)"></a>
					                                <div class="lb-box">
					                                    <input type="radio" id="sCarDivCd0" name="sCarDivCdStr" value="" checked>
					                                    <label for="sCarDivCd0">전체</label>
					                                </div>
					                            </li>
					                            <c:forEach var="code" items="${carDivCd}" varStatus="status">
					                            <li><a href="javascript:void(0)"></a>
					                                <div class="lb-box">
					                                    <input type="radio" id="sCarDivCd${status.count}" name="sCarDivCdStr" value="${code.cdNum}">
					                                    <label for="sCarDivCd${status.count}">${code.cdNm}</label>
					                                </div>
					                            </li>
					                            </c:forEach>					                            
					                        </ul>
					                    </div>
					                  </c:if>
					                </dd>
					            </dl>
					        </div>
					        <div class="area name">
					            <dl>
					                <dt>차 이름</dt>
					                <dd>
					                    <div class="value-text">
					                      <c:if test="${searchVO.searchYn eq Constant.FLAG_Y}">
					                        <input type="text" class="full disabled" placeholder="차명을 입력해 주세요" disabled>
					                      </c:if>
					                      <c:if test="${searchVO.searchYn eq Constant.FLAG_N}">
					                        <input type="text" name="sPrdtNm" value="${searchVO.sPrdtNm }" id="sPrdtNm" class="full" placeholder="차명을 입력해 주세요" onclick="optionClose('.popup-typeA');">
					                      </c:if>
					                    </div>
					                </dd>
					            </dl>
					        </div>
					        <div class="area search">
					            <!-- form 사용시 submit 변경 -->
					            <button type="button" class="btn red" onclick="fn_formSubmit();">
					            <c:if test="${searchVO.searchYn eq Constant.FLAG_N}">
					            검색
					            </c:if>
					            <c:if test="${searchVO.searchYn eq Constant.FLAG_Y}">
					            재검색
					            </c:if>
					            </button>
					        </div>
					    </div> <!-- //search-area -->
					</div> <!-- //form-area -->
					<!-- //코드중복(include) -->
				</div>
				</form>
	        </section> <!-- //search-typeA -->
	        
	        <section class="product-more-area">
	        	<div class="Fasten">
	        		<div class="rent-qna">
	        			<img src="<c:url value='/images/web/rent/qna.jpg' />" alt="">
	        		</div>
	        	</div>
	        </section>
			</div> <!-- //new-detail -->
	        <!-- //Change Contents -->
	
	    </div> <!-- //subContents -->
	</div> <!-- //subContainer -->
</main>
<jsp:include page="/web/foot.do" flush="false"></jsp:include>
</body>
</html>