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
	                <div class="title-info">
	                	<h3 class="title">B2B시스템 이란?</h3>
	                	<p class="memo">B2B시스템은 탐나오에 입점한 실시간 개별 관광사업체(숙박, 렌터카, 골프)와 여행사가 1:1 판매대행업무 계약을 체결하여<br />상품 판매를 촉진하고 보다 활성화시킬 수 있는 입점업체 간 판매대행 계약 시스템 입니다.</p>
	                </div>
	                
	                <h4 class="title08">B2B시스템 프로세스</h4>
	                <div class="photo"><img src="<c:url value='/images/mas/b2b/process.jpg'/>" alt="b2b 프로세스"></div>
	                
	                <div class="info-btn">
	                	<c:if test="${corpConfVO.statusCd eq Constant.TRADE_STATUS_APPR_REQ}"><p class="memo">현재 검토 중입니다.</p></c:if>
	                	<c:if test="${corpConfVO.statusCd eq Constant.TRADE_STATUS_APPR_REJECT}">
	                		<div class="btn-wrap">
	                			<span class="caption">반려 되었습니다. ▶</span> <a class="btn blue" onclick="show_popup('#rstrPop');">반려상세</a>
	                		</div>
	                	</c:if>
	                	<c:if test="${corpConfVO == null}">
	                	<div class="btn-wrap">
	                		<span class="caption">B2B 시스템 등록하러 가기 ▶</span> <a href="<c:url value='/mas/b2b/term.do'/>" class="btn blue">등록하기</a>
	                	</div>
	                	</c:if>
	                </div>
	                
	                <ul class="list-style1">
				        <li>B2B시스템은 시스템 사용 등록을 완료한 입점업체만 이용할 수 있습니다.</li>
					    <li>B2B시스템은 상호 확인 및 승인 후 이용할 수 있습니다.</li>
					    <li>B2B시스템 사용 등록 후 사용을 원치 않으시면 취소할 수 있습니다.</li>
					    <li>등록하기 버튼을 클릭하시면 더욱 자세한 이용약관을 확인할 수 있습니다.</li>
					    <li>반려 시에는 반려상세 내용을 확인 후 재등록요청을 하실 수 있습니다.</li>
				    </ul>
				</div>
                <!-- //change contents -->		
			</div>			
			 
			<!--//본문--> 
		</div>
	</div>
	<!--//Contents 영역--> 
</div>
<!-- layer popup  -->
<div class="blackBg"></div>

<div id="rstrPop" class="layer-popup">
    <div class="content-wrap" style="width: 600px"> <!--클래스 추가 → sm : 작은팝업, big : 큰팝업, 수치입력 : style="width: 500px"-->
        <div class="ct-wrap">
            <div class="head">
                <h3 class="title">B2B시스템 사용등록 반려</h3>
                <button type="button" class="close" onclick="close_popup('#rstrPop');"><img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="닫기"></button>
            </div>

            <div class="main">
            	<div class="info"><strong>반려업체 :</strong> <span>제주관광협회 탐나오</span></div>
            	<div class="info"><strong>반려일시 :</strong> <span><c:out value="${corpConfVO.rstrDttm}" /></span></div>
            	
                <div class="scroll" style="height: auto"> <!--scroll 시에만 class 사용 (높이지정가능) / 불필요시 클래스 및 div삭제-->
                	<div class="memo">
	                    <c:out value="${corpConfVO.rstrContents}" escapeXml="false"/>
					</div>
                </div>
                
                <div class="info"><strong>요청업체 :</strong> <span><c:out value="${corpConfVO.corpNm}" /></span></div>
            </div>

            <div class="foot">
            	<!-- a링크 사용가능 -->
            	<!-- <a href="" class="btn red">확인</a> -->
                <a class="close btn" href="<c:url value='/mas/b2b/b2bReReq.do'/>">재등록 요청</a>
            	<a class="btn red" onclick="close_popup('#rstrPop');">확인</a>
            </div>
        </div>
    </div>
</div> <!--//layer-popup-->
</body>
</html>