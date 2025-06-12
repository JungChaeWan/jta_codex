<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
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
<title></title>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/Chart.bundle.min.js'/>"></script>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css' />" />

<script type="text/javascript">
function fn_Category(category) {
	// form reset
	$('form').each(function() {
		this.reset();
	});
	<c:if test="${searchVO.sCategory != '' && searchVO.sCategory != 'RC' }">	
	$('#sType0').prop("checked", true);
	</c:if>
	document.frm.sCorpNm.value = "";
	document.frm.pageIndex.value = 1;
	document.frm.sCategory.value = category;
	document.frm.action = "<c:url value='/oss/bisCorp.do'/>";
	document.frm.submit();
}
function fn_Search(pageIndex, gubun){	
	// form reset
	if (gubun != 'search') {
		$('form').each(function() {
			this.reset();
		});
	}

	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/oss/bisCorp.do'/>";
	document.frm.submit();
}

function fn_fieldSort(fieldSort) {
	// form reset
	$('form').each(function() {
		this.reset();
	});
	
	if (document.frm.sSortField.value == fieldSort) {
		if (document.frm.sSortOption.value == 'DESC')
			document.frm.sSortOption.value = 'ASC';
		else document.frm.sSortOption.value = 'DESC';	
	}
	else document.frm.sSortOption.value = 'DESC';
		
	document.frm.pageIndex.value = 1;
	document.frm.sSortField.value = fieldSort;
	document.frm.action = "<c:url value='/oss/bisCorp.do'/>";
	document.frm.submit();
}

function fn_changeDate(term) {
	var searchDate = new Date();

	$('#sEndDt').val(searchDate.getFullYear() + "-" + ("0" + (searchDate.getMonth() + 1)).slice(-2) + "-" + ("0" + searchDate.getDate()).slice(-2));	
	
	if (term == 0 || term >= 7)
		searchDate.setDate(searchDate.getDate() - term);
	else
		searchDate.setMonth(searchDate.getMonth() - term);
	
	$('#sStartDt').val(searchDate.getFullYear() + "-" + ("0" + (searchDate.getMonth() + 1)).slice(-2) + "-" + ("0" + searchDate.getDate()).slice(-2));	
}

function fn_ExcelDown() {
	var parameters = $('#frm').serialize();
	frmFileDown.location = "<c:url value='/oss/bisCorpExcelDown.do?' />"+ parameters;
}

$(function() {	
	$("#sStartDt").datepicker({
		dateFormat : "yy-mm-dd"
	});
	$("#sEndDt").datepicker({
		dateFormat : "yy-mm-dd"
	});
});

</script>
</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/oss/head.do?menu=bis" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
        <div id="side_area"> 
            <!--사이드메뉴-->
            <div class="side_menu">
                <jsp:include page="/oss/left.do?menu=bis&sub=corp" flush="false"></jsp:include>
            </div>
            <!--//사이드메뉴-->
        </div>
        <div id="contents_area">
            <div id="contents">
                
                <!-- change contents -->
                <!-- 3Depth menu -->
                <div id="menu_depth3">
					<ul>
						<li<c:if test="${empty searchVO.sCategory }"> class="on"</c:if>><a class="menu_depth3" href="javascript:fn_Category('');">전체</a></li>
					  <c:forEach items="${corpCdList }" var="corp">
					  	<li<c:if test="${searchVO.sCategory eq corp.cdNum }"> class="on"</c:if>><a class="menu_depth3" href="javascript:fn_Category('${corp.cdNum }');">${corp.cdNm }</a></li>
					  </c:forEach>
						<%-- <li<c:if test="${empty searchVO.sCategory }"> class="on"</c:if>><a class="menu_depth3" href="javascript:fn_Category('');">전체</a></li>
						<li<c:if test="${searchVO.sCategory eq 'AD' }"> class="on"</c:if>><a class="menu_depth3" href="javascript:fn_Category('AD');">숙소</a></li>
						<li<c:if test="${searchVO.sCategory eq 'RC' }"> class="on"</c:if>><a class="menu_depth3" href="javascript:fn_Category('RC');">렌터카</a></li>
						<li<c:if test="${searchVO.sCategory eq 'SPC' }"> class="on"</c:if>><a class="menu_depth3" href="javascript:fn_Category('SPC');">관광지</a></li>
						<li<c:if test="${searchVO.sCategory eq 'SPF' }"> class="on"</c:if>><a class="menu_depth3" href="javascript:fn_Category('SPF');">음식/뷰티</a></li>
						<li<c:if test="${searchVO.sCategory eq 'SPT' }"> class="on"</c:if>><a class="menu_depth3" href="javascript:fn_Category('SPT');">패키지</a></li>
						<li<c:if test="${searchVO.sCategory eq 'SV' }"> class="on"</c:if>><a class="menu_depth3" href="javascript:fn_Category('SV');">기념품</a></li> --%>
					</ul>
				</div>
				
				<!-- 검색옵션 -->
				<form name="frm" id="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="sCategory" name="sCategory" value="${searchVO.sCategory}" />
				<input type="hidden" id="sSortField" name="sSortField" value="${searchVO.sSortField}" />
				<input type="hidden" id="sSortOption" name="sSortOption" value="${searchVO.sSortOption}" />
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
				<div class="search_box">
			        <div class="search_form">
			            <div class="tb_form">
			                <table width="100%" border="0">
			                    <colgroup>
			                        <col style="widht: 100px" />
			                        <col />
			                    </colgroup>
			                    <tbody>
			                    	<c:if test="${searchVO.sCategory eq 'CADO' or searchVO.sCategory eq 'CSPT' or searchVO.sCategory eq 'CSPF' or searchVO.sCategory eq 'CSPU' }">
			                    	<tr>
			                            <th scope="row">유형</th>
			                            <td>
			                                <label class="lb"><input type="radio" id="sType0" name="sType"<c:if test="${empty searchVO.sType }" >checked="checked"</c:if> value="" /> <span>전체</span></label>
			                                <c:forEach var="data" items="${categoryList}" varStatus="status">
                                            	<label class="lb"><input id="sType${status.index+1}" type="radio" name="sType" value="${data.cdNum}" <c:if test="${searchVO.sType==data.cdNum}">checked="checked"</c:if>><label for="sType${status.index+1}">${data.cdNm }</label></label>
                                            </c:forEach>
			                            </td>
			                        </tr>
			                        </c:if>			                        
			                        <tr>
			                            <th scope="row">기간</th>
			                            <td class="date-wrap">
			                            	<button type="button" onclick="fn_changeDate('0');">오늘</button>
			                            	<button type="button" onclick="fn_changeDate('7');">7일</button>
			                            	<button type="button" onclick="fn_changeDate('15');">15일</button>
			                            	<button type="button" onclick="fn_changeDate('1');">1개월</button>
			                            	<button type="button" onclick="fn_changeDate('3');">3개월</button>
			                            	<button type="button" onclick="fn_changeDate('6');">6개월</button>
			                            	
			                                <input type="text" id="sStartDt" class="input_text4 center" name="sStartDt" title="검색시작일" value="${searchVO.sStartDt }" /> ~ 
	               							<input type="text" id="sEndDt" class="input_text4 center" name="sEndDt"  title="검색종료일" value="${searchVO.sEndDt }" />
			                            </td>
			                        </tr>
			                        <tr>
			                            <th scope="row">업체명</th>
			                            <td>
			                                <input type="text" name="sCorpNm" placeholder="업체명을 입력해주세요." style="width: 245px" value="${searchVO.sCorpNm }" />
			                            </td>
			                        </tr>
			                    </tbody>
			                </table>
			            </div>
			            <span class="btn"><input type="image" src="/images/oss/btn/search_btn01.gif" alt="검색" onclick="javascript:fn_Search('1', 'search')" /></span>
			        </div>
			    </div>
			    </form>
			    
			    <!-- 검색결과 -->
			    <h4 class="title08">
			      <c:if test="${empty searchVO.sCategory }">업체 </c:if>
			      <c:forEach items="${corpCdList }" var="corp">			      
			      	<c:if test="${searchVO.sCategory eq corp.cdNum }">${corp.cdNm } </c:if>
			      </c:forEach>
			      <c:if test="${empty searchVO.sType }" > 전체</c:if>
			      <c:if test="${!empty searchVO.sType }" >
			        <c:forEach items="${categoryList }" var="info">
			          <c:if test="${info.cdNum eq searchVO.sType }"><c:out value="${info.cdNm }" /></c:if>
			        </c:forEach>
			      </c:if>
			    </h4>
			    <div class="search-value">
			    	<ul>
			    		<li>
			    			<h5 class="title">예약</h5>
			    			<p class="count"><span><fmt:formatNumber value="${sumCorpAnls.totalRsvCnt }"/></span> <small>건</small></p>
	    				</li>
	    				<li>
			    			<h5 class="title">평점</h5>
			    			<p class="count"><span>${sumCorpAnls.totalGpaAvg }</span> <small>점</small></p>
	    				</li>
	    				<li>
			    			<h5 class="title">1:1 문의</h5>
			    			<p class="count"><span><fmt:formatNumber value="${sumCorpAnls.totalOtoinqCnt }"/></span> <small>건</small></p>
	    				</li>
	    				<li>
			    			<h5 class="title">View(click)</h5>
			    			<p class="count"><span><fmt:formatNumber value="${sumCorpAnls.totalViewCnt }"/></span> <small>건</small></p>
	    				</li>
	    				<li>
			    			<h5 class="title">예약취소</h5>
			    			<p class="count"><span><fmt:formatNumber value="${sumCorpAnls.totalCancelCnt }"/></span> <small>건</small></p>
	    				</li>
	    				<li>
			    			<h5 class="title">이용후기</h5>
			    			<p class="count"><span><fmt:formatNumber value="${sumCorpAnls.totalUseepilCnt }"/></span> <small>건</small></p>
	    				</li>
	    				<li>
			    			<h5 class="title">SNS 공유</h5>
			    			<p class="count"><span><fmt:formatNumber value="${sumCorpAnls.totalSnsCnt }"/></span> <small>건</small></p>
	    				</li>
	    				<li>
			    			<h5 class="title">재구매</h5>
			    			<p class="count"><span><fmt:formatNumber value="${sumCorpAnls.totalDuplCnt }"/></span> <small>건</small></p>
	    				</li>
			    	</ul>
			    </div>
				
				<table class="table01 center">
			        <colgroup>
			            <col style="width: 6%">
			            <col>
						<col style="width: 9%">
			            <col style="width: 9%">
			            <col style="width: 9%">
			            <col style="width: 9%">
			            <col style="width: 9%">
			            <col style="width: 9%">
			            <col style="width: 9%">
			            <col style="width: 9%">
			            <col style="width: 9%">
			        </colgroup>
			        <thead>
			            <tr>
			                <th class="sort">No.</th>
			                <th class="sort">업체명</th>
			                <th class="sort" onclick="fn_fieldSort('RSV_CNT');">예약
			                <c:if test="${searchVO.sSortField eq 'RSV_CNT' }">
			                 <span class="sign"><c:if test="${searchVO.sSortOption eq 'DESC' }">▼</c:if><c:if test="${searchVO.sSortOption eq 'ASC' }">▲</c:if></span>
			                </c:if>
			                </th>
							<th class="sort" onclick="fn_fieldSort('NML_AMT');">매출
								<c:if test="${searchVO.sSortField eq 'NML_AMT' }">
									<span class="sign"><c:if test="${searchVO.sSortOption eq 'DESC' }">▼</c:if><c:if test="${searchVO.sSortOption eq 'ASC' }">▲</c:if></span>
								</c:if>
							</th>
			                <th class="sort" onclick="fn_fieldSort('CANCEL_CNT');">예약 취소
			                <c:if test="${searchVO.sSortField eq 'CANCEL_CNT' }">
			                 <span class="sign"><c:if test="${searchVO.sSortOption eq 'DESC' }">▼</c:if><c:if test="${searchVO.sSortOption eq 'ASC' }">▲</c:if></span>
			                </c:if>
			                </th>
			                <th class="sort" onclick="fn_fieldSort('GPA_AVG');">평점
			                <c:if test="${searchVO.sSortField eq 'GPA_AVG' }">
			                 <span class="sign"><c:if test="${searchVO.sSortOption eq 'DESC' }">▼</c:if><c:if test="${searchVO.sSortOption eq 'ASC' }">▲</c:if></span>
			                </c:if>
			                </th>
			                <th class="sort" onclick="fn_fieldSort('USEEPIL_CNT');">이용후기
			                <c:if test="${searchVO.sSortField eq 'USEEPIL_CNT' }">
			                 <span class="sign"><c:if test="${searchVO.sSortOption eq 'DESC' }">▼</c:if><c:if test="${searchVO.sSortOption eq 'ASC' }">▲</c:if></span>
			                </c:if>
			                </th>
			                <th class="sort" onclick="fn_fieldSort('OTOINQ_CNT');">1:1 문의
			                <c:if test="${searchVO.sSortField eq 'OTOINQ_CNT' }">
			                 <span class="sign"><c:if test="${searchVO.sSortOption eq 'DESC' }">▼</c:if><c:if test="${searchVO.sSortOption eq 'ASC' }">▲</c:if></span>
			                </c:if>
			                </th>
			                <th class="sort" onclick="fn_fieldSort('SNS_CNT');">SNS 공유
			                <c:if test="${searchVO.sSortField eq 'SNS_CNT' }">
			                 <span class="sign"><c:if test="${searchVO.sSortOption eq 'DESC' }">▼</c:if><c:if test="${searchVO.sSortOption eq 'ASC' }">▲</c:if></span>
			                </c:if>
			                </th>
			                <th class="sort" onclick="fn_fieldSort('VIEW_CNT');">View
			                <c:if test="${searchVO.sSortField eq 'VIEW_CNT' }">
			                 <span class="sign"><c:if test="${searchVO.sSortOption eq 'DESC' }">▼</c:if><c:if test="${searchVO.sSortOption eq 'ASC' }">▲</c:if></span>
			                </c:if>
			                </th>
			                <th class="sort" onclick="fn_fieldSort('DUPL_CNT');">재구매
			                <c:if test="${searchVO.sSortField eq 'DUPL_CNT' }">
			                 <span class="sign"><c:if test="${searchVO.sSortOption eq 'DESC' }">▼</c:if><c:if test="${searchVO.sSortOption eq 'ASC' }">▲</c:if></span>
			                </c:if>
			                </th>
			            </tr>
			        </thead>
			        <tbody>			        	
			        	<c:forEach items="${corpAnlsList }" var="anls" varStatus="idx">
			            <tr>
			                <td>${(searchVO.pageIndex-1) * searchVO.pageSize + idx.count }</td>
			                <td>${anls.corpNm }
			                <c:if test="${anls.tradeStatusCd == 'TS05' }"> <font color='#e8202e'>(판매중지)</font></c:if>
			                <c:if test="${anls.tradeStatusCd == 'TS07' }"> <font color='#e8202e'>(거래중지)</font></c:if>
			                </td>
			                <td><fmt:formatNumber value="${anls.rsvCnt }"/> 건</td>
							<td><fmt:formatNumber value="${anls.nmlAmt }"/>원</td>
			                <td><fmt:formatNumber value="${anls.cancelCnt }"/> 건</td>
			                <td>${anls.gpaAvg } 점</td>
			                <td><fmt:formatNumber value="${anls.useepilCnt }"/> 건</td>
			                <td><fmt:formatNumber value="${anls.otoinqCnt }"/> 건</td>
			                <td><fmt:formatNumber value="${anls.snsCnt }"/> 건</td>
			                <td><fmt:formatNumber value="${anls.viewCnt }"/> 건</td>
			                <td><fmt:formatNumber value="${anls.duplCnt }"/> 건</td>
			            </tr>
			            </c:forEach>			          
			            <c:if test="${fn:length(corpAnlsList) == 0 }">
			            <tr>
			                <td colspan="10">
			                	<div class="not-content">검색된 결과가 없습니다.</div>
			                </td>
			            </tr>
			            </c:if>
			        </tbody>
			    </table>
				
				<ul class="btn_rt01">
					<li class="btn_sty04"><a href="javascript:fn_ExcelDown();">엑셀다운로드</a></li>
				</ul>			    
			    
			    <p class="list_pageing">
			        <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
			    </p>
                <!-- //change contents -->
                
            </div>
        </div>
	</div>
</div>
<iframe name="frmFileDown" style="display:none"></iframe>
</body>
</html>