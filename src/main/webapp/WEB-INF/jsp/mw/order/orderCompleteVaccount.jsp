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

<c:forEach items="${orderList}" var="order" varStatus="status">
<script language='javascript'>
	_A_amt[_ace_countvar] = "<c:out value='${order.saleAmt}'/>'";
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
<jsp:include page="/mw/includeJs.do" flush="false"></jsp:include>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common/jquery-ui-mobile.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/mw/common.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/mw/sub.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/mw/sub_cart.css">

<script type="text/javascript" src="<c:url value='/js/mw_adDtlCalendar.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/mw_glDtlCalendar.js'/>"></script>

</head>
<body>
<div id="wrap">

<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do" flush="false"></jsp:include>
</header>
<!-- 헤더 e -->

<!-- 콘텐츠 s -->
<h2 class="sr-only">서브콘텐츠</h2>
<section id="subContent">

	<div class="menu-bar">
		<p class="btn-prev"><img src="${pageContext.request.contextPath}/images/mw/common/btn_prev.png" width="20" alt="이전페이지"></p>
		<h2>예약페이지</h2>
	</div>
	<div class="sub-content">
		<div class="reserve">
			<div class="txt-box">
				<p class="tit">${payInfo.LGD_RESPMSG} 상태입니다. <c:if test="${payInfo.LGD_CASFLAGY eq 'I'}"> 예약완료 되었습니다.</c:if></p>
				<p class="txt">
					<c:choose>
						<c:when test="${payInfo.LGD_CASFLAGY eq 'I'}">
							<p><c:out value="${rsvInfo.rsvNm}"/>님의 입금이 확인되었습니다.. 주문번호 [<c:out value="${rsvInfo.rsvNum}"/>]</p>
						</c:when>
						<c:otherwise>
							<p><c:out value="${rsvInfo.rsvNm}"/>님의 입금이 확인되면 예약이 완료됩니다. 주문번호 [<c:out value="${rsvInfo.rsvNum}"/>]</p>
						</c:otherwise>
					</c:choose>
				</p>
			</div>

			<p class="info-txt">
				* 주문상세내역은 사이트상단의 <em>마이페이지 > 나의예약/구매내역</em>에서 확인하실 수 있습니다.<br>
				* 주문과 관련된 문의사항이 있으신 경우 고객센터를 통해 문의해 주시기 바랍니다.
			</p>
			<h2>주문정보</h2>
			<dl class="total-ok bt-none">
				<dt>
					<strong>주문금액</strong>
				</dt>
				<dd>
					<strong><fmt:formatNumber><c:out value="${rsvInfo.totalNmlAmt}"/></fmt:formatNumber>원</strong>
				</dd>
			</dl>
			<dl class="total-ok bt-none">
				<dt>
					<strong>할인금액</strong>
				</dt>
				<dd>
					<strong><fmt:formatNumber><c:out value="${rsvInfo.totalDisAmt}"/></fmt:formatNumber>원</strong>
				</dd>
			</dl>
			<dl class="total-ok bt-none">
				<dt>
					<strong>할인금액</strong>					
				</dt>
				<dd class="sale-area">
					<div>
						<span class="title">할인쿠폰</span>
						<span class="point"><strong><fmt:formatNumber><c:out value="${rsvInfo.totalDisAmt}"/></fmt:formatNumber> 원</strong></span>
					</div>
					<div>
						<span class="title">L.POINT 할인</span>
						<span class="point"><strong><fmt:formatNumber><c:out value="${rsvInfo.lpointUsePoint}"/></fmt:formatNumber> P</strong></span>
					</div>
				</dd>
			</dl>
			<dl class="total-ok bt-none">
				<dt>
					<strong>결제금액</strong>
				</dt>
				<dd>
					<strong class="red"><fmt:formatNumber><c:out value="${rsvInfo.totalSaleAmt}"/></fmt:formatNumber>원</strong>
				</dd>
			</dl>

			<h2 class="border-none">주문하신 상품</h2>
			<c:set var="rcYn" value="N" />
			<c:forEach items="${orderList}" var="order" varStatus="status">
				<dl class="goods-info">
					<dt><strong><c:out value="${order.prdtCdNm}"/></strong> </dt>
					<dd>
						[<c:out value="${order.corpNm}"/>]<c:out value="${order.prdtNm}"/><br>
						<c:out value="${order.prdtInf}"/>
					</dd>
				</dl>
				<dl class="goods-price goods-price1">
					<dt>상품금액</dt>
					<dd><fmt:formatNumber><c:out value="${order.saleAmt}"/></fmt:formatNumber>원</dd>
				</dl>
				<c:if test="${order.prdtCd eq 'RC'}">
					<c:set var="rcYn" value="Y" />
				</c:if>
			</c:forEach>

			<h2 class="border-none">입금 안내</h2>
			<dl class="total-ok bt-none">
				<dt>
					<strong>은행명</strong>
				</dt>
				<dd>
					<strong>${payInfo.LGD_FINANCENAME}</strong>
				</dd>
			</dl>
			<dl class="total-ok bt-none">
				<dt>
					<strong>입금계좌번호</strong>
				</dt>
				<dd>
					<strong>${payInfo.LGD_ACCOUNTNUM}</strong>
				</dd>
			</dl>
			<dl class="total-ok bt-none">
				<dt>
					<strong>입금자명</strong>
				</dt>
				<dd>
					<strong>${payInfo.LGD_PAYER}</strong>
				</dd>
			</dl>
			<dl class="total-ok bt-none">
				<dt>
					<strong>입금하실금액</strong>
				</dt>
				<dd>
					<strong> <fmt:formatNumber><c:out value="${payInfo.LGD_AMOUNT}"/></fmt:formatNumber></strong>
				</dd>
			</dl>
			<dl class="total-ok bt-none">
				<dt>
					<strong>결제남은시간</strong>
				</dt>
				<dd>
					<%--<strong>${payInfo.LGD_FINANCENAME}</strong>--%>
					<c:choose>
						<c:when test="${payInfo.LGD_CASFLAGY eq 'I'}">
					<strong class="text-red">결제완료</strong>
						</c:when>
						<c:otherwise>
					<strong class="text-red" id="waitingTime2"></strong>
						</c:otherwise>
					</c:choose>
				</dd>
			</dl>

			<p class="btn-list">
				<a href="${pageContext.request.contextPath}/mw/main.do" class="btn btn1 center">홈으로</a>
			</p>

			<c:if test="${rcYn eq 'Y'}">
				<div class="carseat-banner-m">
					<a href="${pageContext.request.contextPath}/mw/tour/jeju.do?sCtgr=C500"><img src="/images/mw/banner/carseat-m.jpg" alt="유모차카시트바로가기"></a>
				</div>
			</c:if>
		</div>
	</div>
</section>
<!-- 콘텐츠 e -->

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

<%-- 모바일 에이스 카운터 추가 2017.04.25 --%>
<!-- AceCounter Mobile eCommerce (Cart_Inout) v7.5 Start -->
<script language='javascript'>
var AM_Cart=(function(){
	var c={
		<c:forEach items="${orderList}" var="order" varStatus="status">
			<c:choose>
				<c:when test="${Constant.ACCOMMODATION eq fn:substring(order.prdtNum,0,2)}">
					<c:set var="strprdtNm" value="숙소" />
				</c:when>
				<c:when test="${Constant.RENTCAR eq fn:substring(order.prdtNum,0,2)}">
					<c:set var="strprdtNm" value="렌터카" />
				</c:when>
				<c:when test="${Constant.GOLF eq fn:substring(order.prdtNum,0,2)}">
					<c:set var="strprdtNm" value="골프" />
				</c:when>
				<c:when test="${Constant.SOCIAL eq fn:substring(order.prdtNum,0,2)}">
					<c:set var="strprdtNm" value="${order.ctgrNm}" />
				</c:when>
				<c:when test="${Constant.SV eq fn:substring(order.prdtNum,0,2)}">
					<c:set var="strprdtNm" value="제주특산/기념품" />
				</c:when>
			</c:choose>
			pd:'<c:out value='${order.prdtNum}'/>',pn:'<c:out value='${order.prdtNm}'/>',am:'${rsvInfo.totalSaleAmt}',qy:'<c:out value='${order.prdtCnt}'/>',ct:'<c:out value='${strprdtNm}'/>'
			<c:if test='${!status.last}'>,</c:if>
		</c:forEach>
	};
	var u=(!AM_Cart)?[]:AM_Cart; u[c.pd]=c;return u;

})();
</script>

<script language='javascript'>
var m_order_code='${rsvInfo.rsvNum}';		// 주문코드 필수 입력
var m_buy="finish"; //구매 완료 변수(finish 고정값)
</script>

<!-- AceCounter Mobile WebSite Gathering Script V.7.5.20170208 -->
<script language='javascript'>
	var _AceGID=(function(){var Inf=['tamnao.com','m.tamnao.com,www.tamnao.com,tamnao.com','AZ3A70537','AM','0','NaPm,Ncisy','ALL','0']; var _CI=(!_AceGID)?[]:_AceGID.val;var _N=0;if(_CI.join('.').indexOf(Inf[3])<0){ _CI.push(Inf);  _N=_CI.length; } return {o: _N,val:_CI}; })();
	var _AceCounter=(function(){var G=_AceGID;var _sc=document.createElement('script');var _sm=document.getElementsByTagName('script')[0];if(G.o!=0){var _A=G.val[G.o-1];var _G=(_A[0]).substr(0,_A[0].indexOf('.'));var _C=(_A[7]!='0')?(_A[2]):_A[3];var _U=(_A[5]).replace(/\,/g,'_');_sc.src=(location.protocol.indexOf('http')==0?location.protocol:'http:')+'//cr.acecounter.com/Mobile/AceCounter_'+_C+'.js?gc='+_A[2]+'&py='+_A[1]+'&up='+_U+'&rd='+(new Date().getTime());_sm.parentNode.insertBefore(_sc,_sm);return _sc.src;}})();
</script>
<noscript><img src='https://gmb.acecounter.com/mwg/?mid=AZ3A70537&tp=noscript&ce=0&' border='0' width='0' height='0' alt=''></noscript>
<!-- AceCounter Mobile Gathering Script End -->

<!-- 네이버 전환분석 START (2018-01-30, By JDongS) -->
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script> 
<script type="text/javascript"> 
var _nasa={};
_nasa["cnv"] = wcs.cnv("1","<c:out value='${rsvInfo.totalSaleAmt}'/>"); // 전환유형(구매완료), 전환가치 설정
</script> 
<!-- // 네이버 전환분석 END -->

<!-- 푸터 s -->
<jsp:include page="/mw/foot.do" flush="false"></jsp:include>
<!-- 푸터 e -->
<jsp:include page="/mw/menu.do" flush="false"></jsp:include>
</div>

<!-- 다음 전환추적 2018.02.01 By JS  -->
<script type="text/javascript">
	var DaumConversionDctSv="type=P,orderID=${rsvInfo.rsvNum},amount=${rsvInfo.totalSaleAmt}";
	var DaumConversionAccountID="U5sW2MKXVzOa73P2jSFYXw00";
	if(typeof DaumConversionScriptLoaded=="undefined"&&location.protocol!="file:"){
		var DaumConversionScriptLoaded=true;
		document.write(unescape("%3Cscript%20type%3D%22text/javas"+"cript%22%20src%3D%22"+(location.protocol=="https:"?"https":"http")+"%3A//t1.daumcdn.net/cssjs/common/cts/vr200/dcts.js%22%3E%3C/script%3E"));
	}
</script>

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
<!-- 구글 전환추적 2019.01.10 By JS  -->
<script>
    ga('require', 'ecommerce', 'ecommerce.js');

    ga('ecommerce:addTransaction', {
        'id': '${rsvInfo.rsvNum}',                     // Transaction ID. Required.
        'revenue': '${rsvInfo.totalSaleAmt}',               // Grand Total.
        'shipping': '',                  // Shipping.
    });

    for (var i = 0; i < _A_pl.length ; i ++ ) {
        ga('ecommerce:addItem', {
            'id': '${rsvInfo.rsvNum}',                     // Transaction ID. Required.
            'name': _A_pn[i],    // Product name. Required.
            'sku': _A_pl[i],                 // SKU/code.
            'category': _A_ct[i],         // Category or variation.
            'price': _A_amt[i],                 // Unit price.
            'quantity': _A_nl[i]                  // Quantity.
        });
    }
    ga('ecommerce:send');
</script>

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
	kakaoPixel('5986927315880161684').pageView();
	kakaoPixel('5986927315880161684').purchase({
		total_quantity: "${order.prdtCnt}", // 주문 내 상품 개수(optional)
		total_price: "${rsvInfo.totalNmlAmt}",  // 주문 총 가격(optional)
		currency: "KRW"     // 주문 가격의 화폐 단위(optional, 기본 값은 KRW)
	});
</script>

<script>
var itv;
var timeLeft = "<c:out value='${difTime}' />";

var updateLeftTime = function() {
	timeLeft = (timeLeft <= 0) ? 0 : -- timeLeft;

	if(timeLeft > 0) {
		var hours = Math.floor(timeLeft / 3600);
		var minutes = Math.floor((timeLeft - 3600 * hours) / 60);
		var seconds = timeLeft % 60;

		var txtTime = "남은시간 <b>";
		if(minutes > 0) {
			txtTime += minutes + "분 ";
		}
		txtTime += seconds + "초</b>";

		$("#waitingTime2").html(txtTime);
	} else {
		$("#waitingTime2").html("결제시간 초과");
		$("#btnBuy").remove();
		clearInterval(itv);
	}
}

$(document).ready(function() {
	if(timeLeft > 0) {
		itv = setInterval(updateLeftTime, 1000);
	} else {
		$("#btnBuy").remove();
		$("#waitingTime2").html("결제시간 초과");
	}
});
</script>

</body>
</html>
