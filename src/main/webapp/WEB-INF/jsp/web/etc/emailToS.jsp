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
<meta name="robots" content="noindex, nofollow">
<jsp:include page="/web/includeJs.do" flush="false"></jsp:include>
 


<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css'/>" />
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" /> --%>


<script type="text/javascript">


$(document).ready(function(){

});

</script>

</head>
<body>
<header id="header">
	<jsp:include page="/web/head.do" flush="false"></jsp:include>
</header>
<main id="main">
        <div class="mapLocation"> <!--index page에서는 삭제-->
            <div class="inner">
                <span>홈</span> <span class="gt">&gt;</span>
                <span>이메일 무단수집거부</span>
            </div>
        </div>
        <!-- quick banner -->
   		<jsp:include page="/web/left.do" flush="false"></jsp:include>
        <!-- //quick banner -->
        <div class="subContainer">
        
        <!-- ------------------------------------------------------------------------------------------ -->
       		<div class="subHead"></div>
            <div class="subContents">
                <!-- new contents -->
                <div class="rules-wrap">
                    <div class="bgWrap2">
                        <div class="Fasten">
                            <article>
                                <h2 class="main-title">탐나오 회원 이메일(E-Mail) 주소 무단수집 및 영리목적의 광고성 정보전송 거부</h2>
                                <dl class="comm-rule">
                                    <dd>
                                        탐나오 회원의 이메일(E-Mail) 주소를 무단수집하거나, 이를 활용해 영리목적의 광고성 정보를 전송하는 것을 거부합니다. 

                                        위 사항에 위배되는 행위시 아래 법률 등에 의거 형사처벌 됨을 유념하시길 바랍니다.

                                        - 정보통신망이용촉진 및 정보보호 등에 관한 법률
                                    </dd>
                                    <dt>제50조 (영리목적의 광고성 정보 전송 제한)</dt>
                                    <dd>
                                        ① 누구든지 전자적 전송매체를 이용하여 영리목적의 광고성 정보를 전송하려면 그 수신자의 명시적인 사전 동의를 받아야 한다. 다만, 다음 각 호의 어느 하나에 해당하는 경우에는 사전 동의를 받지 아니한다.
                                        1. 재화등의 거래관계를 통하여 수신자로부터 직접 연락처를 수집한 자가 대통령령으로 정한 기간 이내에 자신이 취급하고 수신자와 거래한 것과 동종의 재화등에 대한 영리목적의 광고성 정보를 전송하려는 경우
                                        2. 「방문판매 등에 관한 법률」에 따른 전화권유판매자가 육성으로 전화권유를 하는 경우
                                        ② 전자적 전송매체를 이용하여 영리목적의 광고성 정보를 전송하려는 자는 제1항에도 불구하고 수신자가 수신거부의사를 표시하거나 사전 동의를 철회한 경우에는 영리목적의 광고성 정보를 전송하여서는 아니 된다.
                                        ③ 오후 9시부터 그 다음 날 오전 8시까지의 시간에 전자적 전송매체를 이용하여 영리목적의 광고성 정보를 전송하려는 자는 제1항에도 불구하고 그 수신자로부터 별도의 사전 동의를 받아야 한다. 다만, 대통령령으로 정하는 매체의 경우에는 그러하지 아니하다.
                                        ④ 전자적 전송매체를 이용하여 영리목적의 광고성 정보를 전송하는 자는 대통령령으로 정하는 바에 따라 다음 각 호의 사항 등을 광고성 정보에 구체적으로 밝혀야 한다.
                                        1. 전송자의 명칭 및 연락처
                                        2. 수신의 거부 또는 수신동의의 철회 의사표시를 쉽게 할 수 있는 조치 및 방법에 관한 사항
                                        ⑤ 전자적 전송매체를 이용하여 영리목적의 광고성 정보를 전송하는 자는 다음 각 호의 어느 하나에 해당하는 조치를 하여서는 아니 된다.
                                        1. 광고성 정보 수신자의 수신거부 또는 수신동의의 철회를 회피·방해하는 조치
                                        2. 숫자·부호 또는 문자를 조합하여 전화번호·전자우편주소 등 수신자의 연락처를 자동으로 만들어 내는 조치
                                        3. 영리목적의 광고성 정보를 전송할 목적으로 전화번호 또는 전자우편주소를 자동으로 등록하는 조치
                                        4. 광고성 정보 전송자의 신원이나 광고 전송 출처를 감추기 위한 각종 조치
                                        5. 영리목적의 광고성 정보를 전송할 목적으로 수신자를 기망하여 회신을 유도하는 각종 조치
                                        ⑥ 전자적 전송매체를 이용하여 영리목적의 광고성 정보를 전송하는 자는 수신자가 수신거부나 수신동의의 철회를 할 때 발생하는 전화요금 등의 금전적 비용을 수신자가 부담하지 아니하도록 대통령령으로 정하는 바에 따라 필요한 조치를 하여야 한다.
                                        ⑦ 전자적 전송매체를 이용하여 영리목적의 광고성 정보를 전송하려는 자는 수신자가 제1항에 따른 사전 동의, 제2항에 따른 수신거부의사 또는 수신동의 철회 의사를 표시할 때에는 해당 수신자에게 대통령령으로 정하는 바에 따라 수신동의, 수신거부 또는 수신동의 철회에 대한 처리 결과를 알려야 한다.
                                        ⑧ 제1항 또는 제3항에 따라 수신동의를 받은 자는 대통령령으로 정하는 바에 따라 정기적으로 광고성 정보 수신자의 수신동의 여부를 확인하여야 한다.
                                    </dd>
                                </dl>
                            </article>
                        </div>
                    </div>                    
                </div> <!-- // -->
                <!-- //new contents -->
             </div> <!-- //subContents -->
        
        <!-- ------------------------------------------------------------------------------------------ -->
            
        </div> <!-- //subContainer -->
	</main>
	
<jsp:include page="/web/right.do" flush="false"></jsp:include>
<jsp:include page="/web/foot.do" flush="false"></jsp:include>
</body>
</html>