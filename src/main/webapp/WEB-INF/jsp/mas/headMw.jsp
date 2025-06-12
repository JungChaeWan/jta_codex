<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />

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

$(document).ready(function(){


});

</script>

	<header id="header">
			<h1 class="logo"><a href="#"><img src="<c:url value='/images/adm_mw/comm/logo.png'/>" alt="logo"></a></h1>

			<!--left menu-->
			<%--
			<div class="left-menu">
				<a id="left_btn" href="#"><img src="<c:url value='/images/adm_mw/comm/menu_left.png'/>" alt="메인메뉴"></a>

				<div id="left_menu" class="menu">
					<a id="left_close" class="close" href="#"><img src="<c:url value='/images/adm_mw/comm/close.png'/>" alt="닫기"></a>

					<div id="main_menu" class="nav-wrap">
						<nav>
							<a href="#">Main Menu1</a>
							<ul>
								<li><a href="">Sub Menu1</a></li>
								<li><a href="">Sub Menu2</a></li>
								<li><a href="">Sub Menu3</a></li>
							</ul>
						</nav>
						<nav>
							<a href="#">Main Menu2</a>
							<ul>
								<li><a href="">Sub Menu1</a></li>
								<li><a href="">Sub Menu2</a></li>
								<li><a href="">Sub Menu3</a></li>
							</ul>
						</nav>
						<nav>
							<a href="#">Main Menu3</a>
							<ul>
								<li><a href="">Sub Menu1</a></li>
								<li><a href="">Sub Menu2</a></li>
								<li><a href="">Sub Menu3</a></li>
							</ul>
						</nav>
					</div> <!--//nav-wrap-->
				</div> <!--//menu-->
			</div>
			 --%>

			<!--right menu-->
			<div class="right-menu">
				<a id="right_btn" href="#"><img src="<c:url value='/images/adm_mw/comm/menu_right.png'/>" alt="서브메뉴"></a>

				<div id="right_menu" class="menu">
					<nav>
						<a href="/"><img src="<c:url value='/images/adm_mw/comm/top_3.png'/>" alt="site"><span>탐나오 바로가기</span></a>
						<a href="<c:url value='/mw/viewLogin.do?rtnUrl=/mw/mypage/viewChangePw.do'/>" alt="site"><img src="<c:url value='/images/adm_mw/comm/top_2.png'/>" alt="pw"><span>비밀번호 변경</span></a>
						<%-- <a href="<c:url value='/mw/mas/masLogout.do'/>"><img src="<c:url value='/images/adm_mw/comm/top_1.png'/>" alt="logout"><span>로그아웃</span></a> --%>
					</nav>
				</div> <!--//menu-->
			</div>
		</header>

