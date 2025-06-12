<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />

<head>
<meta name="robots" content="noindex, nofollow">
<jsp:include page="/mw/includeJs.do"></jsp:include>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub_member.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/style.css'/>">
	
<!-- 구글 전환추적 2018.02.01 By JS  -->
<script>
  gtag('event', 'conversion', {'send_to': 'AW-10926637573/qr4zCP7TgMMDEIWEndoo'});
</script>
<script>
  gtag('event', 'conversion', {'send_to': 'AW-818795361/QyuiCNKK53sQ4aa3hgM'});
</script>
<script>
  gtag('event', 'conversion', {'send_to': 'AW-10926598396/15V7CM7WxcUDEPzRmtoo'});
</script>
<script type="text/javascript">
$(document).ready(function(){
});
</script>
</head>
<body>
<div id="wrap">

<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do"></jsp:include>
</header>
<!-- 헤더 e -->

<!-- 콘텐츠 s -->
<h2 class="sr-only">서브콘텐츠</h2>
<section id="subContent">
	<div class="sub-content">
		<div class="join-wrap">

			<!--회원가입완료-->
			<div class="join join4">
				<h2>회원가입 완료</h2>
				<div class="join-end">
					<h3 class="title">회원가입 완료! <br>환영합니다!</h3>
					<p class="memo">탐나오쿠폰, 이벤트 참여 등<br>다양한 혜택을 받으실 수 있습니다.</p>
				</div>
				<div class="character"><img src="/images/mw/common/character.png" alt="탐나오"></div>
				<p class="btn-list2">
					<a href="<c:url value='/mw/main.do'/>" class="btn22">홈으로</a>
					<a href="<c:url value='/mw/mypage/couponList.do?type=coupon'/>" class="btn2">쿠폰내역보기</a>
				</p>
			</div>
		</div>
	</div>
</section>
<!-- 콘텐츠 e -->

<!-- 네이버 전환분석 START (2018-01-30, By JDongS) -->
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script> 
<script type="text/javascript"> 
var _nasa={};
_nasa["cnv"] = wcs.cnv("2","1"); // 전환유형(회원가입), 전환가치 설정
</script> 
<!-- // 네이버 전환분석 END -->

<!-- 푸터 s -->
<jsp:include page="/mw/foot.do"></jsp:include>

<%-- 카카오 유입추적 모바일--%>
<script type="text/javascript" charset="UTF-8" src="//t1.daumcdn.net/adfit/static/kp.js"></script>
<script type="text/javascript">
	kakaoPixel('1824481670434828332').pageView();
	kakaoPixel('1824481670434828332').completeRegistration();
</script>
<script type="text/javascript">
	kakaoPixel('5986927315880161684').pageView();
	kakaoPixel('5986927315880161684').completeRegistration();
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
        device:"mobile"                  /*디바이스 종류  (web 또는  mobile)*/
        ,items:[{
            i:"회원 가입 ",          /*전환 식별 코드  (한글 , 영어 , 번호 , 공백 허용 )*/
            t:"회원 가입 ",          /*전환명  (한글 , 영어 , 번호 , 공백 허용 )*/
            p:"1",                   /*전환가격  (전환 가격이 없을 경우 1로 설정 )*/
            q:"1"                   /*전환수량  (전환 수량이 고정적으로 1개 이하일 경우 1로 설정 )*/
        }]
    };
}));
</script>
<script type="text/javascript" async src="//cdn-aitg.widerplanet.com/js/wp_astg_4.0.js"></script>
<!-- // WIDERPLANET  SCRIPT END 2023.4.17 -->

</div>
</body>
</html>
