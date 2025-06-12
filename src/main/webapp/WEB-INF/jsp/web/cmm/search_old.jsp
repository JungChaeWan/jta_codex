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

function fn_DetailPrdt(prdtNum, corpCd, aplDt){
	var strApl = fn_addDate(aplDt);
	var arrApl = strApl.split('-');
	var date1 = new Date(arrApl[0], arrApl[1]-1, arrApl[2]);
	console.log(date1);
    date1.setDate(date1.getDate() + 1)
    var yy = date1.getFullYear();
    var mm = date1.getMonth()+1; mm = (mm < 10) ? '0' + mm : mm;
    var dd = date1.getDate(); dd = (dd < 10) ? '0' + dd : dd;
    var strDate = yy + '-' +  mm  + '-' + dd;
    var strDate2 = strDate.replace(/-/gi, "");


	var code = prdtNum.substring(0,2);
	if(code=='${Constant.RENTCAR}' ){
		//location.href = "<c:url value='/web/rentcar/car-detail.do'/>?prdtNum="+prdtNum;
		window.open("<c:url value='/web/rentcar/car-detail.do'/>?prdtNum="+prdtNum+"&sPrdtNm=${search}&searchYn=${Constant.FLAG_N}", '_blank');
	}else if(code=='${Constant.ACCOMMODATION}'){
		//location.href = "<c:url value='/web/ad/detailPrdt.do'/>?sPrdtNum="+prdtNum;
		window.open("<c:url value='/web/ad/detailPrdt.do'/>?sPrdtNum="+prdtNum+"&sFromDtView="+fn_addDate(aplDt)+"&sFromDt="+aplDt+"&sToDtView="+strDate+"&sToDt="+strDate2+"&sSearchYn=${Constant.FLAG_N}", '_blank');
	}else if(code=='${Constant.GOLF}' ){
		//location.href = "<c:url value='/web/gl/detailPrdt.do'/>?sPrdtNum="+prdtNum;
		window.open("<c:url value='/web/gl/detailPrdt.do'/>?sPrdtNum="+prdtNum, '_blank');
	}else if(code=='${Constant.SOCIAL}'){
		location.href = "<c:url value='/web/sp/detailPrdt.do'/>?prdtNum="+prdtNum;
	}else if(code=='${Constant.SV}'){
		location.href = "<c:url value='/web/sv/detailPrdt.do'/>?prdtNum="+prdtNum;
	}

}



function fn_AdSearch(pageIndex){
	$("#cmmfrm input[name=pageIndex]").val(pageIndex);

	$("#orderCd").val("GPA");


	var parameters = $("#cmmfrm").serialize() + "&" + $("#adfrm").serialize()+"&totSch=Y";

	//alert(parameters);

	$.ajax({
		type:"post",
		url:"<c:url value='/web/ad/adList.ajax'/>",
		data:parameters ,
		beforeSend:function(){
			//$(".loading-wrap").show();
		},
		success:function(data){
			//$("#tabs-1").html(data);
			$("#dataAD").html(data);
		},
		error:fn_AjaxError
	});
}

function fn_RcSearch(pageIndex){
	$("#cmmfrm input[name=pageIndex]").val(pageIndex);
	var parameters = $("#cmmfrm").serialize() + "&" + $("#rcfrm").serialize()+"&totSch=Y&searchYn=Y";
    console.log(parameters)
	$.ajax({
		type:"post",
		// dataType:"json",
		// async:false,
		url:"<c:url value='/web/rc/rcList.ajax'/>",
		data:parameters ,
		beforeSend:function(){
			//$(".loading-wrap").show();
		},
		success:function(data){
			//$(".loading-wrap").hide();
			//$("#tabs-1").html(data);
			$("#dataRC").html(data);
		},
		error:fn_AjaxError
	});
}

function fn_GlSearch(pageIndex){
	$("#cmmfrm input[name=pageIndex]").val(pageIndex);
	var parameters = $("#cmmfrm").serialize() + "&" + $("#glfrm").serialize()+"&totSch=Y";

	$.ajax({
		type:"post",
		url:"<c:url value='/web/gl/glList.ajax'/>",
		data:parameters ,
		beforeSend:function(){
			$(".loading-wrap").show();
		},
		success:function(data){
			$(".loading-wrap").hide();
			$("#tabs-1").html(data);
		},
		error:fn_AjaxError
	});
}

function fn_SpSearchPackage(pageIndex){
	$("#cmmfrm input[name=pageIndex]").val(pageIndex);

	$("#spfrm input[name=sCtgr]").val("${Constant.CATEGORY_PACKAGE}");

	var parameters = $("#cmmfrm").serialize() + "&" + $("#spfrm").serialize()+"&totSch=Y";
	var url = "";
	url = "<c:url value='/web/sp/packageList.ajax'/>";

	$.ajax({
		type:"post",
		url:url,
		data:parameters ,
		beforeSend:function(){
			//$(".loading-wrap").show();
		},
		success:function(data){
			//$(".loading-wrap").hide();
			//$("#tabs-1").html(data);
			$("#dataPackage").html(data);
		},
		error:fn_AjaxError
	});
}

function fn_SpSearchTure(pageIndex){
	$("#cmmfrm input[name=pageIndex]").val(pageIndex);

	$("#spfrm input[name=sCtgr]").val("${Constant.CATEGORY_TOUR}");

	var parameters = $("#cmmfrm").serialize() + "&" + $("#spfrm").serialize()+"&totSch=Y";
	var url = "";
	url = "<c:url value='/web/sp/productList.ajax'/>";

	$.ajax({
		type:"post",
		url:url,
		data:parameters ,
		beforeSend:function(){
			//$(".loading-wrap").show();
		},
		success:function(data){
			//$(".loading-wrap").hide();
			//$("#tabs-1").html(data);
			$("#dataTure").html(data);
		},
		error:fn_AjaxError
	});
}


function fn_SpSearchFood(pageIndex){
	$("#cmmfrm input[name=pageIndex]").val(pageIndex);

	$("#spfrm input[name=sCtgr]").val("${Constant.CATEGORY_ETC}");

	var parameters = $("#cmmfrm").serialize() + "&" + $("#spfrm").serialize()+"&totSch=Y";
	var url = "";
	url = "<c:url value='/web/sp/productList.ajax'/>";

	$.ajax({
		type:"post",
		url:url,
		data:parameters ,
		beforeSend:function(){
			//$(".loading-wrap").show();
		},
		success:function(data){
			//$(".loading-wrap").hide();
			//$("#tabs-1").html(data);
			$("#dataFood").html(data);
		},
		error:fn_AjaxError
	});
}

function fn_SpSearchStroller(pageIndex){
	$("#cmmfrm input[name=pageIndex]").val(pageIndex);

	$("#spfrm input[name=sCtgr]").val("${Constant.CATEGORY_BABY_SHEET}");

	var parameters = $("#cmmfrm").serialize() + "&" + $("#spfrm").serialize()+"&totSch=Y";
	var url = "";
	url = "<c:url value='/web/sp/productList.ajax'/>";
	$.ajax({
		type:"post",
		url:url,
		data:parameters ,
		beforeSend:function(){
			//$(".loading-wrap").show();
		},
		success:function(data){
			//$(".loading-wrap").hide();
			//$("#tabs-1").html(data);
			$("#dataStroller").html(data);
		},
		error:fn_AjaxError
	});
}



function fn_SvSearch(pageIndex){
	$("#cmmfrm input[name=pageIndex]").val(pageIndex);
	var parameters = $("#cmmfrm").serialize() + "&" + $("#svfrm").serialize()+"&totSch=Y&";

	$.ajax({
		type:"post",
		url:"<c:url value='/web/sv/productList.ajax'/>",
		data:parameters ,
		beforeSend:function(){
			//$(".loading-wrap").show();
		},
		success:function(data){
			//$(".loading-wrap").hide();
			//$("#tabs-1").html(data);
			$("#dataSV").html(data);
		},
		error:fn_AjaxError
	});
}

function fn_ChangeTab(type, obj){
	$(".menuList li>a").removeClass("select");
	$(obj).addClass("select");
	if(type == "AD") {
		$('#prdtTool').hide();
		$('#areaTool').show();
		fn_AdSearch(1);
		$("#tabType").val("AD");
		$("li.distance").css('display', 'inline-block');
	} else if(type == "RC") {
		$('#prdtTool').show();
		$('#areaTool').hide();
		fn_RcSearch(1);
		$("#tabType").val("RC");
		$("li.distance").css('display', 'none');
	} else if(type == "GL") {
		$('#prdtTool').show();
		$('#areaTool').hide();
		fn_GlSearch(1);
		$("#tabType").val("GL");
		$("li.distance").css('display', 'none');
	} else if(type == "PACKAGE") {
		$('#prdtTool').show();
		$('#areaTool').hide();
		$("#spfrm input[name=sCtgr]").val("${Constant.CATEGORY_PACKAGE}");
		fn_SpSearch(1);
		$("#tabType").val("PACKAGE");
		$("li.distance").css('display', 'none');
	} else if(type == "TOUR") {
		$('#prdtTool').show();
		$('#areaTool').hide();
		$("#spfrm input[name=sCtgr]").val("${Constant.CATEGORY_TOUR}");
		fn_SpSearch(1);
		$("#tabType").val("TOUR");
		$("li.distance").css('display', 'inline-block');
	} else if(type == "FOOD") {
		$('#prdtTool').show();
		$('#areaTool').hide();
		$("#spfrm input[name=sCtgr]").val("${Constant.CATEGORY_ETC}");
		fn_SpSearch(1);
		$("#tabType").val("FOOD");
		$("li.distance").css('display', 'inline-block');
	} else if(type == "FOOD") {
		$('#prdtTool').show();
		$('#areaTool').hide();
		$("#spfrm input[name=sCtgr]").val("${Constant.CATEGORY_BABY_SHEET}");
		fn_SpSearch(1);
		$("#tabType").val("FOOD");
		$("li.distance").css('display', 'inline-block');
	} else if(type == "SV") {
		$('#prdtTool').show();
		$('#areaTool').hide();
		fn_SvSearch(1);
		$("#tabType").val("SV");
		$("li.distance").css('display', 'none');
	}
}

function fn_OrderChange(orCd, orAs, obj, area){
	$(".array>li").removeClass("select");
	$(obj).parent("li").addClass("select");
	$("#orderCd").val(orCd);
	$("#orderAsc").val(orAs);

	$("#sAdAdar").val(area);

	var type = $("#tabType").val();
	if(type == "AD") {
		fn_AdSearch($("#pageIndex").val());
	} else if(type == "RC") {
		fn_RcSearch($("#pageIndex").val());
	} else if(type == "GL") {
		fn_GlSearch($("#pageIndex").val());
	} else if(type == "PACKAGE") {
		fn_SpSearch($("#pageIndex").val());
	} else if(type == "TOUR") {
		fn_SpSearch($("#pageIndex").val());
	} else if(type == "FOOD") {
		fn_SpSearch($("#pageIndex").val());
	} else if(type == "CATEGORY_BABY_SHEET") {
		fn_SpSearch($("#pageIndex").val());	
	} else if(type == "SV") {
		fn_SvSearch($("#pageIndex").val());
	}
}

function fn_ChangeOrderDist( lat, lon) {
	$("#sLON").val(lon);
	$("#sLAT").val(lat);

	fn_OrderChange('${Constant.ORDER_DIST}','${Constant.ORDER_ASC}', $(".distance a"));
	close_popup($('.map-wrap'));
}

function fn_ShowProducts(category){
	$("#" + category +  " .item").removeClass('off');

	var offset = $("#" + category).offset();
	        $('html, body').animate({scrollTop : offset.top}, 400);

}

$(document).ready(function(){

	if("${adCnt}">0) fn_AdSearch(1);
	if("${rcCnt}">0) fn_RcSearch(1);
	if("${packageCnt}">0) fn_SpSearchPackage(1);
	if("${tourCnt}">0) fn_SpSearchTure(1);
	if("${foodCnt}">0) fn_SpSearchFood(1);
	if("${strollerCnt}">0) fn_SpSearchStroller(1);
	if("${svCnt}">0) fn_SvSearch(1);
	

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
			<span>검색</span>
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
                        	<c:if test="${adCnt + rcCnt + glCnt + packageCnt + tourCnt + foodCnt + svCnt + strollerCnt == 0 }">
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
                        	<c:if test="${adCnt + rcCnt + glCnt + packageCnt + tourCnt + foodCnt + svCnt + strollerCnt > 0 }">
                            <div class="sh-top">
                                <h3>
                                	 <img src="<c:out value='/images/web/icon/search.gif'/>" alt="">
                                    <strong class="comm-color1">"<c:out value="${search}" />"</strong>에 대한 <strong class="count"><c:out value="${adCnt + rcCnt + packageCnt + tourCnt + foodCnt + svCnt + strollerCnt}"/></strong>건의 검색결과입니다.
                                </h3>
                             </div> <!--  //top -->


                             <div class="list-item">
                             	<c:if test="${adCnt>0}">
                             		<h5 class="listTitle1">숙소 <span>(<c:out value="${adCnt}"/>)</span>
                             		  <c:if test="${adCnt > 8}">
	                             		<a href="javascript:fn_ShowProducts('dataAD')" class="more"><img src="<c:url value='/images/web/main/more.jpg'/>" alt="더보기"></a>
	                             	  </c:if>
	                             	</h5>
                             		<div id="dataAD">
                             			<div class="loading-wrap" ><img src="<c:url value='/images/web/icon/loading.gif'/>" alt="로딩중"></div>
                             		</div>
                             	</c:if>
								 <input type="hidden" name="sFromDt" value="${rcSearch.sFromDt}"/>
								 <input type="hidden" name="sToDt" value="${rcSearch.sToDt}"/>
								 <input type="hidden" name="sFromTm" value="${rcSearch.sFromTm}"/>
								 <input type="hidden" name="sToTm" value="${rcSearch.sToTm}"/>
								<c:if test="${rcCnt>0}">
	                             	<h5 class="listTitle1">렌터카 <span>(<c:out value="${rcCnt}"/>)</span>
	                             	  <c:if test="${rcCnt > 8}">
										  <a href="javascript:fn_ShowProducts('dataRC')" class="more"><img src="<c:url value='/images/web/main/more.jpg'/>" alt="더보기"></a>
	                             	  </c:if>
	                             	</h5>
	                             	<div id="dataRC">
	                             		<div class="loading-wrap" ><img src="<c:url value='/images/web/icon/loading.gif'/>" alt="로딩중"></div>
	                             	</div>
	                             </c:if>

								<c:if test="${packageCnt>0}">
                             		<h5 class="listTitle1">여행사 상품 <span>(<c:out value="${packageCnt}"/>)</span>
                             		  <c:if test="${packageCnt > 8}">
										  <a href="javascript:fn_ShowProducts('dataPackage')" class="more"><img src="<c:url value='/images/web/main/more.jpg'/>" alt="더보기"></a>
                             		  </c:if>
                             		</h5>
	                             	<div id="dataPackage">
    	                         		<div class="loading-wrap" ><img src="<c:url value='/images/web/icon/loading.gif'/>" alt="로딩중"></div>
        	                     	</div>
        	                    </c:if>

								<c:if test="${tourCnt>0}">
									<h5 class="listTitle1">관광지/레저 <span>(<c:out value="${tourCnt}"/>)</span>
									  <c:if test="${tourCnt > 8}">
										  <a href="javascript:fn_ShowProducts('dataTure')" class="more"><img src="<c:url value='/images/web/main/more.jpg'/>" alt="더보기"></a>
                             		  </c:if>
                             		</h5>
	                             	<div id="dataTure">
    	                         		<div class="loading-wrap" ><img src="<c:url value='/images/web/icon/loading.gif'/>" alt="로딩중"></div>
        	                     	</div>
        	                    </c:if>

								<c:if test="${foodCnt>0}">
                             		<h5 class="listTitle1">맛집 <span>(<c:out value="${foodCnt}"/>)</span>
                             		  <c:if test="${foodCnt > 8}">
										  <a href="javascript:fn_ShowProducts('dataFood')" class="more"><img src="<c:url value='/images/web/main/more.jpg'/>" alt="더보기"></a>
                             		  </c:if>
                             		</h5>
	                             	<div id="dataFood">
	                             		<div class="loading-wrap" ><img src="<c:url value='/images/web/icon/loading.gif'/>" alt="로딩중"></div>
	                             	</div>
	                            </c:if>
	                            
								<c:if test="${strollerCnt>0}">
                             		<h5 class="listTitle1">유모차/카시트 <span>(<c:out value="${strollerCnt}"/>)</span>
                             		  <c:if test="${strollerCnt > 8}">
										  <a href="javascript:fn_ShowProducts('dataStroller')" class="more"><img src="<c:url value='/images/web/main/more.jpg'/>" alt="더보기"></a>
                             		  </c:if>
                             		</h5>
	                             	<div id="dataStroller">
	                             		<div class="loading-wrap" ><img src="<c:url value='/images/web/icon/loading.gif'/>" alt="로딩중"></div>
	                             	</div>
	                            </c:if>

								<c:if test="${svCnt>0}">
									<h5 class="listTitle1">제주특산/기념품 <span>(<c:out value="${svCnt}"/>)</span>
									  <c:if test="${svCnt > 8}">
										  <a href="javascript:fn_ShowProducts('dataSV')" class="more"><img src="<c:url value='/images/web/main/more.jpg'/>" alt="더보기"></a>
                             		  </c:if>
                             		</h5>
	                             	<div id="dataSV">
    	                         		<div class="loading-wrap" ><img src="<c:url value='/images/web/icon/loading.gif'/>" alt="로딩중"></div>
        	                     	</div>
        	                     </c:if>

						    </div> <!-- //list-item -->
                         </c:if>
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
		<input type="hidden" name="sToDt" value="${adSearch.sToDt}"/>
		<input type="hidden" name="sNights" value="${adSearch.sNights}"/>
		<input type="hidden" name="sSearchYn" value="N">
		<input type="hidden" name="sAdultCnt" value="2">
		<input type="hidden" name="sChildCnt" value="0">
		<input type="hidden" name="sBabyCnt" value="0">
		<input type="hidden" name="sAdAdar" id="sAdAdar" value="${searchVO.sAdAdar}" />
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



