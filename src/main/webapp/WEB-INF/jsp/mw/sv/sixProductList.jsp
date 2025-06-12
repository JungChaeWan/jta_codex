<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />
<head>
<jsp:include page="/mw/includeJs.do">
	<jsp:param name="title" value="제주 농부의 장  목록, 탐나오"/>
	<jsp:param name="description" value="제주산 원물을 가공한 음식품, 농축산물, 생활용품 등을 구경하세요. 제주도가 지원하고 제주관광협회가 운영하는 믿을 수 있는 곳. 탐나오와 함께라면 빠르고 안전하게 배송받을 수 있습니다."/>
	<jsp:param name="keywords" value="6차산업,제주,제주도,간식,음료차,식초,유제품,육가공,발효식품,반찬,원물가공,잼,꿀,조청,과일,생활용품,화장품,분재"/>
</jsp:include>
<meta property="og:title" content="제주 농부의 장 목록, 탐나오">
<meta property="og:url" content="https://www.tamnao.com/mw/sv/sixProductList.do" >
<meta property="og:description" content="제주산 원물을 가공한 음식품, 농축산물, 생활용품 등을 구경하세요. 제주도가 지원하고 제주관광협회가 운영하는 믿을 수 있는 곳. 탐나오와 함께라면 빠르고 안전하게 배송받을 수 있습니다." >
<meta property="og:image" content="https://www.tamnao.com/data/kakao_tamnao.jpg">
	
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common2.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/style.css?version=${nowDate}' />">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sv.css?version=${nowDate}' />">

<script type="text/javascript" src="<c:url value='/js/jquerySetAttrVal.js?version=${nowDate}'/>"></script>
<script type="text/javascript">
var prevIndex = 0;
function fn_SvSearch(pageIndex) {
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
		url:"<c:url value='/mw/sv/sixProductList.ajax'/>",
		data:parameters,
		success:function(data){
			if(pageIndex == 1) {
				$("#div_productAjax").html("");
			}
			$("#div_productAjax").append(data);
			$("#totPage").text($("#pageInfoCnt").attr("totalPageCnt"));
			$('#moreBtn').show();
			if(pageIndex >= $("#totPage").text() || $("#pageInfoCnt").attr("totalCnt") == 0) {
				$('#moreBtn').hide();
			}
			++prevIndex;
			history.replaceState($("main").html(), "title", "?prevIndex="+ prevIndex);
			currentState = history.state;
		},
		error:function(request, status, error){
		//    alert("code:"+request.status+"\n"+"\n"+"error:"+error);
		}
	});
}

function fn_MoreSearch() {
	fn_SvSearch(parseInt($("#pageIndex").val()) + 1);
}

function fn_OrderChange() {
	$("#orderCd").val($("#orderSelect>option:selected").val());
	fn_SvSearch(1);
}

function fn_ChangeTab(carDiv, carSubDiv, obj) {
	++prevIndex;
	history.replaceState($("main").html(), "title", "?prevIndex="+ prevIndex);
	$("#sCtgr").val(carDiv);
	$("#sSubCtgr").val(carSubDiv);
	$("#top_menu_list>li").removeClass("active");
	$(obj).parent().addClass("active");
	$(obj).parents('.depth2').parent('li').addClass("active");

	fn_SvSearch(1);
}

function fn_Search() {
	document.frm.action = "<c:url value='/mw/sv/sixProductList.do'/>";
	document.frm.submit();
}

$(document).ready(function(){
    var currentState = history.state;
    if(currentState){
        $("#main").html(currentState);
    }else{
        fn_SvSearch(1);
    }

	$("#proInfo").change(function(){
		$("#sPrdtDiv").val($("#proInfo option:selected").val());

		fn_SvSearch(1);
	});

	/*fn_SvSearch(1);*/

	$("#search_btn").on("click", function() {
		if($(".con-box").css("display") == "none") {
			$(this).text("닫기");
			$(".con-box").css("display", "block");
		}
		else {
			$(this).text("검색");
			$(".con-box").css("display", "none");
		}
	});
	
	$("#moreBtnLink").click(function() {
		fn_SvSearch(eval($("#pageIndex").val()) + 1);
	});
	
	var xCoordB = $(".scroll-area .on").offset().left;
	$('#scroll_menuB').scrollLeft(xCoordB);

	$("#div_productAjax li ").click(function(){
		++prevIndex;
		history.replaceState($("main").html(), "title", "?prevIndex="+ prevIndex);
	});

	$('#payCheck').click(function (){
		//탐나는전 session 설정
		if ($("#payCheck").is(":checked") == true) {
			sessionStorage.setItem("tamnacardChk","Y");
		} else{
			sessionStorage.setItem("tamnacardChk","N");
		}

		fn_SvSearch(1);
	});
});
</script>
</head>
<body class="svbody">
<div id="wrap" class="m_wrap">

<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do">
		<jsp:param name="headTitle" value="제주농부의 장"/>
	</jsp:include>
</header>
<!-- 헤더 e -->

<!-- 콘텐츠 s -->
<main id="main">
	<!--//change contents-->
	<div class="mw-list-area">
		<div class="menu-typeB">
			<h2 class="sec-caption">메뉴 선택</h2>
			<nav id="scroll_menuB" class="scroll-menuB">
				<div class="scroll-area">
					<ul>
					  	<c:forEach items="${tsCdList}" var="tsCdList">
							<li>
								<a href="<c:url value='/mw/sv/sixProductList.do?sCtgr=${tsCdList.cdNum}'/>"  <c:if test="${tsCdList.cdNum eq param.sCtgr}">class="on"</c:if>><c:out value="${tsCdList.cdNm}"/></a>
							</li>
					  	</c:forEach>
					</ul>
				</div>
			</nav>
		</div>

		<!-- 0302 탐나는전 check point -->
		<div class="pay-check">
			<input type="checkbox" name="payCheck" id="payCheck" >
			<label for="payCheck">
				<img src="../../images/mw/icon/form/jejupay_icon.png" alt="탐나는전">
			</label>
		</div><!-- //0302 탐나는전 check point -->

		<form action="<c:url value='/web/sv/productList.do'/>" name="searchForm" id="searchForm" method="get">
        	<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}" />
        	<input type="hidden" name="sCtgr" id="sCtgr" value="${searchVO.sCtgr}" />
        	<input type="hidden" name="sSubCtgr" id="sSubCtgr" value="${searchVO.sSubCtgr}" />
        	<input type="hidden" name="sCrtnNum" id="sCrtnNum" value="" />
        	<input type="hidden" name="orderCd" id="orderCd" value="${searchVO.orderCd}" />
        	<input type="hidden" name="prdtNum" id="prdtNum" />
        	<input type="hidden" name="searchWord" id="searchWord" value="${searchVO.searchWord}"/><%--통합검색 더보기를 위함 --%>
        	<input type="hidden" name="sCorpId" id="sCorpId" value="${searchVO.sCorpId}" />
        </form>

		<section class="social-list-area">
			<div class="option-area">
				<select title="정렬 선택" id="orderSelect" onchange="fn_OrderChange(this.value);">
					<option value="${Constant.ORDER_SALE}" <c:if test="${searchVO.orderCd eq Constant.ORDER_SALE}">selected</c:if>>판매순</option>
					<option value="${Constant.ORDER_PRICE}" <c:if test="${searchVO.orderCd eq Constant.ORDER_PRICE}">selected</c:if>>가격순</option>
					<option value="${Constant.ORDER_NEW}" <c:if test="${searchVO.orderCd eq Constant.ORDER_NEW}">selected</c:if>>최신상품순</option>
					<option value="${Constant.ORDER_GPA}" <c:if test="${searchVO.orderCd eq Constant.ORDER_GPA}">selected</c:if>>탐나오 추천순</option>
				</select>
			</div>

			<div class="mw-list">
				<h2 class="sec-caption">특산/기념품 목록</h2>
				<div id="div_productAjax">
				</div>
			</div>
	    </section> <!-- //social-list-area -->

	    <div class="paging-wrap" id="moreBtn">
	    	<a href="javascript:void(0)" class="mobile" id="moreBtnLink">더보기 <span id="curPage">1</span>/<span id="totPage">1</span></a>
		</div>
	</div> <!--//mw-list-area-->
	<!--//change contents-->
</main>
<!-- 콘텐츠 e -->
<!-- 푸터 s -->
<jsp:include page="/mw/foot.do" />
<!-- 푸터 e -->
</div>
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

