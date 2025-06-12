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
<%@ taglib prefix="validator" 	uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

 <un:useConstants var="Constant" className="common.Constant" />
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />

<title></title>

<script type="text/javascript">

function fn_Reg(){
	if($("#btnReg").attr("disabled") != "disabled"){
		if(confirm("B2B 시스템을 등록요청 하시겠습니까?")){
			document.frm.action = "<c:url value='/mas/b2b/b2bReq.do'/>";
			document.frm.submit();
		}
	}
}

$(document).ready(function(){
	$("#chk").click(function(){
		if($(this).is(":checked")){
			$("#btnReg").removeClass("disabled");
			$("#btnReg").removeAttr("disabled");
		}else{
			$("#btnReg").addClass("disabled");
			$("#btnReg").attr("disabled", "disabled");
		}
	});
});
</script>
</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/mas/head.do?menu=b2b" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area"> 
			<!--본문-->
			
			<div id="contents">
				<!-- change contents -->
				<div class="max-wrap">
					<form name="frm" id="frm">
					</form>
	                <div class="title-info">
	                	<h3 class="title">B2B 판매대행계약 이용약관 (여행사)</h3>
	                </div>
	                
					<div class="comm-rule">
						<h3 class="title">제1조 (목적)</h3>
						<div class="memo">이 약관은 제주특별자치도관광협회(이하 "회사")가 운영하는 탐나오 사이트(http://www.tamnao.com 및 m.tamnao.com, 이하 “탐나오")에서 제공하는 인터넷 관련 서비스(이하 “서비스”라 한다)를 이용함에 있어 마켓과 이용자의 권리, 의무 및 책임사항을 규정함을 목적으로 합니다.  ※「인터넷, 정보통신망, 모바일 및 기타 IT Device 등을 이용하는 전자상거래에 대하여도 그 성질에 반하지 않는 한 이 약관을 준용합니다」</div>
						
						<h3 class="title">제2조 (용어의 정의)</h3>
						<div class="memo">① 이 약관에서 사용하는 용어의 정의는 다음과 같습니다.  1. 탐나오 : 사단법인 제주특별자치도관광협회가 재화 또는 서비스(이하 “재화 등”이라 함)를 이용자에게 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하여 재화 등을 거래할 수 있도록 전자상거래 시스템과 그 운영을 위한 웹사이트를 말합니다.</div>
						
						<h3 class="title">제1조 (목적)</h3>
						<div class="memo">이 약관은 제주특별자치도관광협회(이하 "회사")가 운영하는 탐나오 사이트(http://www.tamnao.com 및 m.tamnao.com, 이하 “탐나오")에서 제공하는 인터넷 관련 서비스(이하 “서비스”라 한다)를 이용함에 있어 마켓과 이용자의 권리, 의무 및 책임사항을 규정함을 목적으로 합니다.  ※「인터넷, 정보통신망, 모바일 및 기타 IT Device 등을 이용하는 전자상거래에 대하여도 그 성질에 반하지 않는 한 이 약관을 준용합니다」</div>
						
						<h3 class="title">제2조 (용어의 정의)</h3>
						<div class="memo">① 이 약관에서 사용하는 용어의 정의는 다음과 같습니다.  1. 탐나오 : 사단법인 제주특별자치도관광협회가 재화 또는 서비스(이하 “재화 등”이라 함)를 이용자에게 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하여 재화 등을 거래할 수 있도록 전자상거래 시스템과 그 운영을 위한 웹사이트를 말합니다.</div>
						
						<h3 class="title">제2조 (용어의 정의)</h3>
						<div class="memo">① 이 약관에서 사용하는 용어의 정의는 다음과 같습니다.  1. 탐나오 : 사단법인 제주특별자치도관광협회가 재화 또는 서비스(이하 “재화 등”이라 함)를 이용자에게 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하여 재화 등을 거래할 수 있도록 전자상거래 시스템과 그 운영을 위한 웹사이트를 말합니다.</div>
						
						<h3 class="title">제2조 (용어의 정의)</h3>
						<div class="memo">① 이 약관에서 사용하는 용어의 정의는 다음과 같습니다.  1. 탐나오 : 사단법인 제주특별자치도관광협회가 재화 또는 서비스(이하 “재화 등”이라 함)를 이용자에게 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하여 재화 등을 거래할 수 있도록 전자상거래 시스템과 그 운영을 위한 웹사이트를 말합니다.</div>
					</div>
					
					<div class="agree-wrap">
						<label><input type="checkbox" id="chk"> <span>B2B 판매대행계약 이용약관 동의</span></label>
					</div>
					
					<div class="btn-wrap1">
						<a class="btn blue big disabled" id="btnReg" onclick="fn_Reg();" disabled="disabled">등록요청</a>
					</div>
			    </div>
                <!-- //change contents -->		
			</div>			
			 
			<!--//본문--> 
		</div>
	</div>
	<!--//Contents 영역--> 
</div>
</body>
</html>