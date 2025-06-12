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
<jsp:include page="/web/includeJs.do" flush="false">
	<jsp:param name="title" value="제주 특산 기념품 목록"/>
	<jsp:param name="keywords" value="제주, 특산물, 기념품, 탐나오"/>
	<jsp:param name="description" value="탐나오 제주특산/기념품 목록"/>
	<jsp:param name="headTitle" value="제주도 제주 특산 기념품"/>
</jsp:include>

<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common2.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style-md.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/sub.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/sv.css?version=${nowDate}'/>" />
</head>
<body>
<header id="header">
	<jsp:include page="/web/head.do" flush="false"></jsp:include>
</header>
<main id="main">
	<div class="mapLocation">
	    <div class="inner">
	        <span>홈</span>
	        <span class="gt">&gt;</span>
	        <span>특산/기념품</span>
	        <!-- <span class="gt">&gt;</span>
	        <select title="from jeju 1Depth 선택">
			    <option value="" selected="">농ㆍ수ㆍ축산물</option>
			    <option value="">가공식품</option>
			    <option value="">화장품/미용</option>
			    <option value="">제주기념품</option>
			</select>
			<span class="gt">&gt;</span>
			<select title="from jeju 2Depth 선택">
			    <option value="" selected="">농산물</option>
			    <option value="">수산물</option>
			</select> -->
	    </div>
	</div>
	<div class="socialTx">
		<div class="inner">
			<div class="social-title">${crtnInfo.crtnNm }</div>
		</div>
	</div>	
	
	<div id="subContents" class="sub_wrap">
		<!-- filter_wrap -->
		<div class="filter_wrap">
			<!-- 0304 탐나는전 check point -->
			<div class="filter_jejupay">
				<div class="pay-check">
					<input type="checkbox" name="payCheck" id="payCheck" value="Y" >
					<label for="payCheck">
						<img src="../../images/web/icon/jeju_pay_icon.png" width="22" height="20" alt="탐나는전">
						<span>탐나는전 가맹점보기</span>
					</label>
				</div>
			</div>
			<!-- //0304 탐나는전 check point -->
			<div class="filter_refine">
				<section>
					<h3>카테고리</h3>
					<div class="categoryMenu">
						<ul>
							<c:forEach items="${cntCtgrPrdtList}" var="cntCtgrPrdtList">
								<c:if test="${cntCtgrPrdtList.ctgr != 'S700'}">
								<li class="item-list active">
									<a href="<c:url value='/web/sv/productList.do?sCtgr=${cntCtgrPrdtList.ctgr}'/>"><c:out value="${cntCtgrPrdtList.ctgrNm}"/></a>
	                            	<c:if test="${fn:length(subCtgrMap[cntCtgrPrdtList.ctgr]) > 1 }">
                                	<ul>
										<c:forEach items="${subCtgrMap[cntCtgrPrdtList.ctgr] }" var="subCtgr">
											<c:if test="${cntCtgrPrdtList.ctgr != 'S700'}">
												<li>
													<a href="<c:url value='/web/sv/productList.do?sCtgr=${cntCtgrPrdtList.ctgr}&sSubCtgr=${subCtgr.cdNum }'/>">${subCtgr.cdNm }</a>
												</li>
											</c:if>
										</c:forEach>
									</ul>
									</c:if>
								</li>
								</c:if>
							</c:forEach>
							<li class="item-list active">
								<%-- <a href="javascript:void(0)">슬기로운 제주쇼핑</a> --%>
								<a id="jeju-shopping">슬기로운 제주쇼핑</a>
								<ul>
									<c:forEach items="${crtnList }" var="crtn" varStatus="status">
									<li <c:if test="${param.crtnNum eq crtn.crtnNum}">class='active'</c:if>>
										<a href="<c:url value='/web/sv/crtnList.do?crtnNum=${crtn.crtnNum}'/>">${crtn.crtnNm }</a>
									</li>
									</c:forEach>
								</ul>
							</li>							
						</ul>
					</div>
				</section>
                <section>
                    <h3>브랜드</h3>
                    <div class="categoryMenu">
	                    <ul>
	                    	<li class="item-list active">
	                    		<ul>
		                    		<c:forEach items="${brandPrdtList}" var="brandPrdtList" varStatus="status">
									<li>
										<a href="<c:url value='/web/sv/productList.do?sCorpId=${brandPrdtList.corpId}&sFlag=Brd'/>">${brandPrdtList.corpAliasNm}</a>
									</li>
									</c:forEach>
								</ul>
							</li>
						</ul>
					</div>
                </section>          				
			</div>
		</div><!-- // filter_wrap -->
                
        <!-- list_wrap -->
        <div class="list_wrap">
			<div class="item-area">	
				<ul class="col4" id="div_productAjax"></ul>
			</div>
			<div class="paging-wrap" id="moreBtn">
				<%-- <a href="javascript:void(0)" id="moreBtnLink" class="mobile">더보기 <span id="curPage">1</span>/<span id="totPage">1</span></a> --%>
				<a id="moreBtnLink" class="mobile">더보기 <span id="curPage">1</span>/<span id="totPage">1</span></a>
			</div>	
	   		<form action="<c:url value='/web/sv/productList.do'/>" name="searchForm" id="searchForm" method="get">
		       	<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}" />            	
		       	<input type="hidden" name="sCtgr" id="sCtgr" value="" />
		       	<input type="hidden" name="sSubCtgr" id="sSubCtgr" value="" />
		       	<input type="hidden" name="sCrtnNum" id="sCrtnNum" value="${crtnInfo.crtnNum }" />
		       	<input type="hidden" name="orderCd" id="orderCd" value="${Constant.ORDER_GPA}" />
		       	<input type="hidden" name="prdtNum" id="prdtNum" />
		       	<input type="hidden" name="searchWord" id="searchWord" value=""/><%--통합검색 더보기를 위함 --%>
	       </form>
   		</div> <!-- // list_wrap -->
   	</div> <!-- //subContents -->
</main>

<jsp:include page="/web/right.do" flush="false"></jsp:include>
<jsp:include page="/web/foot.do" flush="false"></jsp:include>

<script type="text/javascript">
function fn_SvSearchNoSrc(pageIndex) {
	$("#searchForm input[name=pageIndex]").val(pageIndex);
	$("#curPage").text(pageIndex);

	//탐나는전checkbox 설정
	if (sessionStorage.getItem("tamnacardChk") == "Y"){
		$("input:checkbox[id='payCheck']").prop("checked", true);
	} else {
		$("input:checkbox[id='payCheck']").prop("checked", false);
	}

	const parameters = $("#searchForm").serialize()+"&sTamnacardYn="+sessionStorage.getItem("tamnacardChk");
	$.ajax({
		type:"post",
		url:"<c:url value='/web/sv/productList.ajax'/>",
		data:parameters ,
		success:function(data){
			if (pageIndex == 1) {
				$("#div_productAjax").html("");
			}
			
			$("#div_productAjax").append(data);
			
			$("#totPage").text($("#pageInfoCnt").attr('totalPageCnt'));
			
			if (pageIndex == $("#totPage").text() || $("#pageInfoCnt").attr('totalCnt') == 0)
				$('#moreBtn').hide();
		},
		error:function(request,status,error){
	    //    alert("code:"+request.status+"\n"+"\n"+"error:"+error);
 	   }
	});
}

$(document).ready(function(){
	$('#moreBtnLink').click(function() {
        if(Number($("#pageIndex").val()) < Number($("#pageInfoCnt").attr('totalPageCnt')) ){
        	fn_SvSearchNoSrc(eval($("#pageIndex").val()) + 1);
        }
	});
	
	fn_SvSearchNoSrc($("#pageIndex").val());

	$('#payCheck').click(function (){
		//탐나는전 session 설정
		if ($("#payCheck").is(":checked") == true) {
			sessionStorage.setItem("tamnacardChk","Y");
		} else{
			sessionStorage.setItem("tamnacardChk","N");
		}
		fn_SvSearchNoSrc(1);
	});
});
</script>
<!-- 다음DDN SCRIPT START 2017.03.30 -->
<script type="text/j-vascript">
    var roosevelt_params = {
        retargeting_id:'U5sW2MKXVzOa73P2jSFYXw00',
        tag_label:'TNdyOePATUamc8VWDrd-ww'
    };
</script>
<script type="text/j-vascript" src="//adimg.daumcdn.net/rt/roosevelt.js" async></script>
<!-- // 다음DDN SCRIPT END 2016.03.30 -->
</body>
</html>