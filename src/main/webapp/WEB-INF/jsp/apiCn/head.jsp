<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
var getContextPath = "${pageContext.request.contextPath}";

function show_popup(obj){
	if($(obj).is(":hidden")){
		$(obj).show();
		$('div.blackBg').fadeIn(100); // 검은 불투명 배경
	}else{
		$(obj).hide();
		$('div.blackBg').fadeOut(100);
	}
}

function close_popup(obj){
	$(obj).hide();
	$('div.blackBg').fadeOut(100);
}

function fn_layerDetailCorp(corpId) {
	$.ajax({
		url :"<c:url value='/oss/detailCorp.ajax'/>",
		data : "corpId=" + corpId,
		success: function(data) {
			$("#div_blank_htnl").html(data);
			show_popup($("#div_blank"));
		},
		error : fn_AjaxError
	}) 
}

$(document).ready(function(){
	$(".gnb_menu>li").hover(
		function(){
			$(this).children("ul").show();
		},
		function(){
			$(this).children("ul").hide();
		}
	);
	
	/* $(".lnb_menu>ul>li").each(function(){
		if($(this).attr("class") == "${menuLocation}"){
			$(this).addClass("on");
		}else{
			$(this).removeClass("on");
		}
	}); */
	
	if("${menuNm}" == "home"){
		$(".menu01").addClass("on");
	}
	if("${menuNm}" == "setting"){
		$(".menu02").addClass("on");
	}
	
});

</script>

	<!--Header 영역-->
	<div id="header_wrapper">
		<h1><img src="<c:url value='/images/apiCn/common/logo.gif'/>" alt="탐나오 통합운영지원 시스템" /></h1>
		<ul class="lnb_menu">
			<li class="home"><a href="/" target="_blank">탐나오바로가기</a></li>>
			<!-- <li class="home"><a href="/">홈으로</a></li> -->
			<li class="log"><a href="<c:url value='/apiCn/apiCnLogout.do'/>">로그아웃</a></li>
		</ul>
		<!--상단메뉴-->
		<h2 class="lay_none">상단메뉴</h2>
		<ul class="gnb_menu">
			<%-- <li class="menu01"><a href="<c:url value='/apiCn/home.do' />">홈</a>
				<!-- <ul class="gnb_depth" id="menu01" style="display:none">
				</ul> -->
			</li> --%>
			<li class="menu02"><a href="<c:url value='/apiCn/apiCnCorpList.do' />">업체연계</a>
				
			</li>
		</ul>
		
		<!--//상단메뉴-->
	</div>
	<!--//Header 영역--> 
	
