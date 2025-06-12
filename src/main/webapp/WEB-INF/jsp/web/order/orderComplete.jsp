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
<script type="text/javascript">
var _JV="AMZ2013010701";//script Version
var _UD='undefined';var _UN='unknown';
var _ace_countvar = 0;
var _DC = document.cookie ;
function _IDV(a){return (typeof a!=_UD)?1:0}
var _CRL='http://'+'gtc15.acecounter.com:8080/';
var _GCD='AS2A40380465474';
if( document.URL.substring(0,8) == 'https://' ){ _CRL = 'https://gtc15.acecounter.com/logecgather/' ;};
if(!_IDV(_A_i)) var _A_i = new Image() ;if(!_IDV(_A_i0)) var _A_i0 = new Image() ;if(!_IDV(_A_i1)) var _A_i1 = new Image() ;if(!_IDV(_A_i2)) var _A_i2 = new Image() ;if(!_IDV(_A_i3)) var _A_i3 = new Image() ;if(!_IDV(_A_i4)) var _A_i4 = new Image() ;
function _RP(s,m){if(typeof s=='string'){if(m==1){return s.replace(/[#&^@,]/g,'');}else{return s.replace(/[#&^@]/g,'');} }else{return s;} };
if(!_IDV(_ll)) var _ll=''; if(!_IDV(_AEC_order_code)) var _AEC_order_code='';
function _AGC(nm) { var cn = nm + "="; var nl = cn.length; var cl = _DC.length; var i = 0; while ( i < cl ) { var j = i + nl; if ( _DC.substring( i, j ) == cn ){ var val = _DC.indexOf(";", j ); if ( val == -1 ) val = _DC.length; return unescape(_DC.substring(j, val)); }; i = _DC.indexOf(" ", i ) + 1; if ( i == 0 ) break; } return ''; }
function _ASC( nm, val, exp ){var expd = new Date(); if ( exp ){ expd.setTime( expd.getTime() + ( exp * 1000 )); document.cookie = nm+"="+ escape(val) + "; expires="+ expd.toGMTString() +"; path="; }else{ document.cookie = nm + "=" + escape(val);};}
function AEC_B_L(){var _AEC_order_code_cookie='';var olt=[];var oll=[];var olk=[];var oct=0;if(document.cookie.indexOf('AECORDERCODE')>=0){_AEC_order_code_cookie=_AGC('AECORDERCODE');};if(_AEC_order_code!=''&&_AEC_order_code==_AEC_order_code_cookie){return'';}else{_ASC("AECORDERCODE",_AEC_order_code,86400*30*12);_ll='';for(var i=0;i<_A_pl.length;i++){var _a=_A_pn[i];var _o=olt[_a];olt[_a]=[_RP(_A_ct[i]),_RP(_a),parseInt(_RP(_A_amt[i],1))+((_o)?_o[2]:0),parseInt(_RP(_A_nl[i],1))+((_o)?_o[3]:0)];if(!_o){oll.push(olt[_a].join('@'));olk[_a]=oct;oct++;}else{oll[olk[_a]]=olt[_a].join('@');}};_ll=oll.join("^");};};
function AEC_S_F(str,md,idx){ var i = 0,_A_cart = ''; var k = eval('_A_i'+idx); md=md.toLowerCase(); if( md == 'b' || md == 'i' || md == 'o'){ _A_cart = _CRL+'?cuid='+_GCD ; _A_cart += '&md='+md+'&ll='+(str)+'&'; k.src = _A_cart;window.setTimeout('',2000);};};
if(!_IDV(_A_pl)) var _A_pl = Array(1) ;
if(!_IDV(_A_nl)) var _A_nl = Array(1) ;
if(!_IDV(_A_ct)) var _A_ct = Array(1) ;
if(!_IDV(_A_pn)) var _A_pn = Array(1) ;
if(!_IDV(_A_amt)) var _A_amt = Array(1) ;
/* 모비온 추가  */
var _A_cm = Array(1) ;
</script>

<!-- 에이스카운터 + 모비온  -->
<c:forEach items="${orderList}" var="order" varStatus="status">
<script language='javascript'>
	_A_amt[_ace_countvar] = "<c:out value='${order.nmlAmt}'/>";
	_A_nl[_ace_countvar] = "<c:out value='${order.prdtCnt}'/>";
	_A_pl[_ace_countvar] = "<c:out value='${order.prdtNum}'/>";
	_A_pn[_ace_countvar] = "<c:out value='${order.prdtNm}'/>";
	_A_ct[_ace_countvar] = "<c:out value='${order.ctgrNm}'/>";
	/* 모비온 추가  */
	_A_cm[_ace_countvar] = "<c:out value='${order.corpNm}'/>";
	_ace_countvar++;
</script>
</c:forEach>

<script type="text/javascript">
var _AEC_order_code = "<c:out value='${rsvInfo.rsvNum}'/>";		// 주문코드
var _amt = "<c:out value='${rsvInfo.totalSaleAmt}'/>";              // 총 구매액
AEC_B_L();			// 구매완료 함수
</script>

<jsp:include page="/web/includeJs.do" flush="false"></jsp:include>
<!-- 구글 전환추적 2018.02.01 By JS  -->
<script>
  gtag('event', 'conversion', {
      'send_to': 'AW-10926637573/iO5MCNjXgMMDEIWEndoo',
      'value': "<c:out value='${rsvInfo.totalSaleAmt}'/>",
      'currency': 'KRW',
      'transaction_id': ''
  });
</script>
<script>
  gtag('event', 'conversion', {
      'send_to': 'AW-818795361/c6k-CMv0-XsQ4aa3hgM',
      'value': "<c:out value='${rsvInfo.totalSaleAmt}'/>",
      'currency': 'KRW',
      'transaction_id': ''
  });
</script>
<script>
  gtag('event', 'conversion', {
      'send_to': 'AW-10926598396/lS_MCIjkx8UDEPzRmtoo',
      'value': "<c:out value='${rsvInfo.totalSaleAmt}'/>",
      'currency': 'KRW',
      'transaction_id': ''
  });
</script>



<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css'/>" />
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" /> --%>


<script type="text/javascript">
$(document).ready(function(){
	scrollTop('.rightArea', 500);
    var new_curr_url = new URL(document.URL);
    //url에서 type이라는 파라미터를 찾아서 param에 넣음
    var param = new_curr_url.searchParams.get("closeWin");
    if(param == "Y"){
        var childWindow = window.parent;
        var parentWindow = childWindow.opener;
        parentWindow.location.href ="/web/orderComplete.do?rsvNum=${rsvInfo.rsvNum}";
        childWindow.close();
    }
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
            <span>예약하기</span>
            <!-- <span>실시간 숙박</span> <span class="gt">&gt;</span>
            <span>숙박상세</span> -->
        </div>
    </div>
    <!-- quick banner -->
    <jsp:include page="/web/left.do" flush="false"></jsp:include>
    <!-- //quick banner -->
    <div class="subContainer">
		<div class="subHead"></div>
		<div class="subContents">
            <!-- new contents -->
            <div class="pay-end">
                    <div class="bgWrap2">
                        <div class="Fasten">
                            <div class="comm_pay">
                                <div class="pay-title">
                                    <h2>주문완료</h2>
                                    <!-- <p>
                                        <span><img src="../images/web/icon/pay3.jpg" height="70" alt="상품선택"></span>
                                    </p> -->
                                </div>
                                <div class="title-box">
                                    <h2>“감사합니다. 주문이 완료되었습니다”</h2>
                                    <p><c:out value="${rsvInfo.rsvNm}"/>님의 주문이 정상적으로 완료되었습니다. 주문번호 [<c:out value="${rsvInfo.rsvNum}"/>]</p>
                                </div>
                                <ul class="commList1">
                                    <li>주문상세내역은 사이트상단의 <strong>마이페이지 &gt; 나의 예약/구매 내역</strong>에서 확인하실 수 있습니다</li>
                                    <li>주문과 관련된 문의사항이 있으신경우 <strong>고객센터</strong>를 통해 문의해 주시기 바랍니다.</li>
                                </ul>
                                <article class="ct-wrap">
                                    <h5 class="title">주문하신 상품</h5>
                                    <table class="commCol product-info">
                                        <thead>
                                        <tr>
                                            <th class="title1">구분</th>
                                            <th class="title2">상품정보</th>
                                            <th class="title3">상품금액</th>

                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:set var="rcYn" value="N" />
                                        <c:forEach var="order" items="${orderList}" varStatus="status">
                                            <tr>
                                                <td>${order.prdtCdNm}</td>
                                                <td class="left">
                                                    <h5 class="product"><span class="cProduct">[<c:out value="${order.corpNm}"/>] <c:out value="${order.prdtNm}"/></span></h5>
                                                    <p class="infoText"><c:out value="${order.prdtInf}"/></p>
                                                </td>
                                                <td class="money">
                                                    <fmt:formatNumber><c:out value="${order.nmlAmt}"/></fmt:formatNumber>
                                                </td>
                                            </tr>
                                            <c:if test="${order.prdtCd eq 'RC'}">
                                                <c:set var="rcYn" value="Y" />
                                            </c:if>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </article>
                                <article class="ct-wrap">
                                    <h5 class="title">결제내역</h5>
                                    <div class="total-wrap">
                                        <ul>
                                            <li>
                                                <dl>
                                                    <dt>
                                                        <span class="text">주문금액</span>
                                                        <span class="price"><strong><fmt:formatNumber><c:out value="${rsvInfo.totalNmlAmt}"/></fmt:formatNumber></strong>원</span>
                                                        <span class="icon"><img src="<c:url value='/images/web/cart/subtract.png'/>" alt="빼기"></span>
                                                    </dt>
                                                </dl>
                                            </li>
                                            <li>
                                                <dl>
                                                    <dt>
                                                        <span class="text">할인금액</span>
                                                        <span class="price"><strong><fmt:formatNumber><c:out value="${rsvInfo.totalDisAmt + rsvInfo.lpointUsePoint + rsvInfo.usePoint}"/></fmt:formatNumber></strong>원</span>
                                                        <span class="icon"><img src="<c:url value='/images/web/cart/sum.png'/>" alt="합계"></span>
                                                    </dt>
                                                    <dd>
                                                    	<c:if test="${rsvInfo.totalDisAmt > 0 }">
                                                        <p>
                                                        	<span class="text">ㆍ 할인쿠폰</span>
                                                        	<span class="price"><strong><fmt:formatNumber><c:out value="${rsvInfo.totalDisAmt}"/></fmt:formatNumber></strong> 원</span>
                                                        </p>
                                                        </c:if>
                                                        <c:if test="${rsvInfo.lpointUsePoint > 0 }">
                                                        <p>
                                                        	<span class="text">ㆍ L.POINT</span>
                                                        	<span class="price"><strong><fmt:formatNumber><c:out value="${rsvInfo.lpointUsePoint}"/></fmt:formatNumber></strong> P</span>
                                                        </p>
                                                        </c:if>
                                                        <c:if test="${rsvInfo.usePoint > 0 }">
                                                        <p>
                                                            <span class="text">ㆍ ${rsvInfo.partnerNm} 포인트</span>
                                                            <span class="price"><strong><fmt:formatNumber><c:out value="${rsvInfo.usePoint}"/></fmt:formatNumber></strong> P</span>
                                                        </p>
                                                        </c:if>
                                                    </dd>
                                                </dl>
                                            </li>
                                            <li>
                                                <dl class="total">
                                                    <dt>
                                                        <span class="text">결제금액</span>
                                                        <span class="price"><strong><fmt:formatNumber><c:out value="${rsvInfo.totalSaleAmt}"/></fmt:formatNumber></strong>원</span>
                                                    </dt>
                                                </dl>
                                            </li>
                                        </ul>
                                    </div>
                                </article>

                                <!-- 0605_리뷰이벤트 배너 추가 -->

         <%--                       <div class="complete_content__banner">
                                    <div class="complete_content__banner-inner">
                                        <a href="https://m.site.naver.com/1ocCs" class="inner--link" target="_blank">
                                            <img class="mypage_banner" src="/images/web/banner/complete_banner.png" width="982" height="114" alt="리뷰이벤트 ">
                                        </a>
                                    </div>
                                </div>--%>


                                <c:if test="${rcYn eq 'Y'}">
                                <!-- 0129 카시트/유모차/숙박 카테고리 노출 -->
                                <div class="cta-banner">
                                    <div class="cta-visual">
                                        <a href="/web/tour/jeju.do?sCtgr=C500" class="banner_grid-wrapper">
                                            <div class="banner_title">
                                                <h2>유모차/카시트 예약하셨나요?</h2>
                                                <div>예약하러 가기</div>
                                            </div>
                                            <img class="banner_image" src="/images/web/banner/cta_carseat_visual.png" alt="카시트/유모차">
                                        </a>
                                    </div>
                                    <div class="cta-visual">
                                        <a href="/web/stay/jeju.do" class="banner_grid-wrapper">
                                            <div class="banner_title">
                                                <h2>더욱 저렴한 가격에 이용하세요.</h2>
                                                <div>예약하러 가기</div>
                                            </div>
                                            <img class="banner_image" src="/images/web/banner/cta_hotel_visual.png" alt="호텔/숙박">
                                        </a>
                                    </div>
                                </div> <!-- // 0129 카시트/유모차/숙박 카테고리 노출 -->
                                </c:if>

                                <!--button-->
                                <div class="comm-button2">
                                    <a href="<c:url value='/main.do'/>" class="color1">홈으로</a>
                                </div>
                            </div> <!--//comm_pay-->
                        </div> <!--//Fasten-->

                        <%--<c:if test="${rcYn eq 'Y'}">
                            <section>
                                <div class="carseat-banner">
                                    <a href="<c:url value='/web/tour/jeju.do?sCtgr=C500' />">
                                        <img src="/images/web/banner/carseat.png" alt="유모차카시트바로가기">
                                    </a>
                                </div>
                            </section>
                        </c:if>--%>
                    </div> <!--//bgWrap2-->
                </div> <!-- //lodge3 -->
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
var google_conversion_label = "hnBTCJ7_sXAQpsG5mAM";
var google_remarketing_only = false;
/* ]]> */
</script>
<script type="text/javascript" src="//www.googleadservices.com/pagead/conversion.js">
</script>
<noscript>
<div style="display:inline;">
<img height="1" width="1" style="border-style:none;" alt="" src="//www.googleadservices.com/pagead/conversion/856580262/?label=hnBTCJ7_sXAQpsG5mAM&amp;guid=ON&amp;script=0"/>
</div>
</noscript>--%>
<!-- // Google 애드워즈 SCRIPT END 2017.04.14 -->

<!-- 네이버 전환분석 START (2018-01-30, By JDongS) -->
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script> 
<script type="text/javascript"> 
var _nasa={};
_nasa["cnv"] = wcs.cnv("1","<c:out value='${rsvInfo.totalSaleAmt}'/>"); // 전환유형(구매완료), 전환가치 설정
</script> 
<!-- // 네이버 전환분석 END -->

<jsp:include page="/web/right.do" flush="false"></jsp:include>
<jsp:include page="/web/foot.do" flush="false"></jsp:include>

<%-- 카카오 유입추적 모바일--%>
<script type="text/javascript" charset="UTF-8" src="//t1.daumcdn.net/adfit/static/kp.js"></script>
<script type="text/javascript">
    kakaoPixel('1824481670434828332').pageView();
    kakaoPixel('1824481670434828332').purchase({
        total_quantity: "${order.prdtCnt}", // 주문 내 상품 개수(optional)
        total_price: "${rsvInfo.totalNmlAmt}",  // 주문 총 가격(optional)
        currency: "KRW"     // 주문 가격의 화폐 단위(optional, 기본 값은 KRW)
    });
</script>
<script type="text/javascript">
    kakaoPixel('1996779769008668271').pageView();
    kakaoPixel('1996779769008668271').purchase({
        total_quantity: "${order.prdtCnt}", // 주문 내 상품 개수(optional)
        total_price: "${rsvInfo.totalNmlAmt}",  // 주문 총 가격(optional)
        currency: "KRW"     // 주문 가격의 화폐 단위(optional, 기본 값은 KRW)
    });
</script>

<!-- WIDERPLANET PURCHASE SCRIPT START 2023.4.17 -->
<div id="wp_tg_cts" style="display:none;"></div>
<script type="text/javascript">
var wptg_tagscript_vars = wptg_tagscript_vars || [];
wptg_tagscript_vars.push(
(function() {
	return {
        wp_hcuid:"",  /*Cross device targeting을 원하는 광고주는 로그인한 사용자의 Unique ID (ex. 로그인 ID, 고객넘버 등)를 암호화하여 대입.
                     *주의: 로그인 하지 않은 사용자는 어떠한 값도 대입하지 않습니다.*/
        ti:"54575",
        ty:"PurchaseComplete",         /*트래킹태그 타입*/
        device:"web",                  /*디바이스 종류 (web 또는 mobile)*/
        items:[{
            i:"주문완료",          /*전환 식별 코드 (한글, 영문, 숫자, 공백 허용)*/
            t:"<c:out value='${rsvInfo.rsvNum}'/>",          /*전환명 (한글, 영문, 숫자, 공백 허용)*/
            p:"<c:out value='${rsvInfo.totalSaleAmt}'/>",    /*전환가격 (전환 가격이 없을 경우 1로 설정)*/
            q:"<c:out value='${fn:length(orderList) }'></c:out>" /*전환수량 (전환 수량이 고정적으로 1개 이하일 경우 1로 설정)*/
        }]
    };
}));
</script>
<script type="text/javascript" async src="//cdn-aitg.widerplanet.com/js/wp_astg_4.0.js"></script>
<!-- // WIDERPLANET PURCHASE SCRIPT END 2023.4.17 -->

<%--구글전환스크립트 202.07.07--%>
<script>
    let itemJson = {};
    let itemArray = [];
    for (let i = 0; i < _A_pl.length ; i ++ ) {
        itemJson.item_id = _A_pl[i];
        itemJson.item_name = _A_pn[i];
        itemJson.item_brand = _A_cm[i];
        itemJson.affiliation = "TAMNAO";
        itemJson.category = _A_ct[i];
        itemJson.price = _A_amt[i];
        itemJson.quantity = _A_nl[i];
        itemArray.push(itemJson);
    }

    gtag("event", "purchase", {
        transaction_id: "${rsvInfo.rsvNum}",
        value: "${rsvInfo.totalSaleAmt}",
        shipping: "0",
        currency: "KRW",
        items: itemArray
    });
</script>

</body>
</html>