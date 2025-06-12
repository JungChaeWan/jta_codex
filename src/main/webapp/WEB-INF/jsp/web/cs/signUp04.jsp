<!DOCTYPE html>
<html lang="ko">
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
<head>
<meta name="robots" content="noindex, nofollow">

<jsp:include page="/web/includeJs.do" flush="false"></jsp:include>
<!-- 구글 유입추적 2018.02.01 By JS -->
<script>
  gtag('event', 'conversion', {'send_to': 'AW-10926637573/qr4zCP7TgMMDEIWEndoo'});
</script>
<script>
  gtag('event', 'conversion', {'send_to': 'AW-818795361/QyuiCNKK53sQ4aa3hgM'});
</script>
<script>
  gtag('event', 'conversion', {'send_to': 'AW-10926598396/15V7CM7WxcUDEPzRmtoo'});
</script>

<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css'/>" />

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
    <div class="mapLocation"> <!-- index page에서는 삭제 -->
        <div class="inner">
            <span>홈</span> <span class="gt">&gt;</span>
            <span>회원가입</span>
        </div>
    </div>
    <!-- quick banner -->
    <jsp:include page="/web/left.do" flush="false"></jsp:include>
    <!-- //quick banner -->
    <div class="subContainer">
		<div class="subHead"></div>
		<div class="subContents">
            <!-- new contents -->
            <div class="sign-up4">
                    <div class="bgWrap2">
                        <div class="Fasten">
                            <div class="member-title">
                                <h2>회원가입</h2>
                                <%--<ul class="info">
                                    <li><img src="<c:url value='/images/web/sign/info1.jpg'/>" alt="약관동의"></li>
                                    <li><img src="<c:url value='/images/web/sign/info2.jpg'/>" alt="본인인증"></li>
                                    <li><img src="<c:url value='/images/web/sign/info3.jpg'/>" alt="회원정보입력"></li>
                                    <li><img src="<c:url value='/images/web/sign/info4_on.jpg'/>" alt="가입완료"></li>
                                </ul>--%>
                            </div>
                            <div class="member-ctWrap">
                                <span class="icon"><img src="<c:url value='/images/web/sign/icon2.jpg'/>" alt="가입완료"></span>
                                <span class="ct">
                                    회원가입이 완료됐습니다.<br>많은 이용 바랍니다.
                                </span>
                            </div> <!--//member-ctWrap-->
                            <p class="button comm-btWrap">
                            	<a href="<c:url value='/main.do'/>" class="comm-arrowBT comm-arrowBT2">홈으로</a>
                                <a href="<c:url value='/web/mypage/couponList.do'/>" class="comm-arrowBT gray">쿠폰내역보기</a>
                            </p>
                        </div>
                    </div>
                </div> <!-- //sign-up4 -->
            <!-- //new contents -->
        </div> <!-- //subContents -->
    </div> <!-- //subContainer -->
</main>

<!-- Google 애드워즈 SCRIPT START 2017.04.14 -->
<%--<script type="text/javascript">
/* <![CDATA[ */
var google_conversion_id = 856580262;
var google_conversion_language = "en";
var google_conversion_format = "3";
var google_conversion_color = "ffffff";
var google_conversion_label = "jqCiCL2AsnAQpsG5mAM";
var google_remarketing_only = false;
/* ]]> */
</script>
<script type="text/javascript" src="//www.googleadservices.com/pagead/conversion.js"></script>
<noscript>
<div style="display:inline;">
<img height="1" width="1" style="border-style:none;" alt="" src="//www.googleadservices.com/pagead/conversion/856580262/?label=jqCiCL2AsnAQpsG5mAM&amp;guid=ON&amp;script=0"/>
</div>
</noscript>--%>
<!-- // Google 애드워즈 SCRIPT END 2017.04.14 -->

<!-- 네이버 전환분석 START (2018-01-30, By JDongS) -->
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script>
<script type="text/javascript"> 
var _nasa={};
_nasa["cnv"] = wcs.cnv("2","1"); // 전환유형(회원가입), 전환가치 설정
</script> 

<jsp:include page="/web/right.do" flush="false"></jsp:include>
<jsp:include page="/web/foot.do" flush="false"></jsp:include>

<%-- 카카오 유입추적 모바일--%>
<script type="text/javascript" charset="UTF-8" src="//t1.daumcdn.net/adfit/static/kp.js"></script>
<script type="text/javascript">
    kakaoPixel('1824481670434828332').pageView();
    kakaoPixel('1824481670434828332').completeRegistration();
</script>
<script type="text/javascript">
    kakaoPixel('1996779769008668271').pageView();
    kakaoPixel('1996779769008668271').completeRegistration();
</script>

<!-- WIDERPLANET  SCRIPT START 2023.4.17 -->
<div id="wp_tg_cts" style="display:none;"></div>
<script type="text/javascript">
var wptg_tagscript_vars = wptg_tagscript_vars || [];
wptg_tagscript_vars.push(
(function() {
    return {
        wp_hcuid:"",  /*고객넘버 등 Unique ID (ex. 로그인  ID, 고객넘버 등 )를 암호화하여 대입.
                     *주의 : 로그인 하지 않은 사용자는 어떠한 값도 대입하지 않습니다.*/
        ti:"54575",
        ty:"Join",                        /*트래킹태그 타입 */
        device:"web",                  /*디바이스 종류  (web 또는  mobile)*/
        items:[{
            i:"회원 가입",          /*전환 식별 코드  (한글 , 영어 , 번호 , 공백 허용 )*/
            t:"회원 가입",          /*전환명  (한글 , 영어 , 번호 , 공백 허용 )*/
            p:"1",                   /*전환가격  (전환 가격이 없을 경우 1로 설정 )*/
            q:"1"                   /*전환수량  (전환 수량이 고정적으로 1개 이하일 경우 1로 설정 )*/
        }]
    };
}));
</script>
<script type="text/javascript" async src="//cdn-aitg.widerplanet.com/js/wp_astg_4.0.js"></script>
<!-- // WIDERPLANET  SCRIPT END 2023.4.17 -->
</body>
</html>