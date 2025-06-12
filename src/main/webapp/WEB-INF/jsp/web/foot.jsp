<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn"	 	uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-MJBHPNP"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->
<script>
var getContextPath = "${pageContext.request.contextPath}";
var servletPath = "${requestScope['javax.servlet.forward.servlet_path']}";

$(document).ready(function (){
	
    if (document.location.href.indexOf("/web/sv/") >= 0 || document.location.href.indexOf("/web/goods/jeju.do") >= 0){
        $(".skyscraper").show();
        $(".main-cs").hide();
    }

    let newGoodsList = [];
    let goodsDate = new Date();

    const dateDiff = Math.ceil((goodsDate.getTime()-new Date(localStorage.getItem('newGoodsTime')))/(1000*3600*24)); //하루

    if(!localStorage.getItem('newGoodsTime') || dateDiff > 1) {
        localStorage.setItem('newGoodsTime',goodsDate); //시간 설정
        localStorage.removeItem('newGoodsList'); //초기화
    }

    if(localStorage.getItem('newGoodsList')){
        newGoodsList = JSON.parse(localStorage.getItem('newGoodsList'));
    }

    let goodsHtml = '';
    $.each(newGoodsList, function(i, list){
        goodsHtml += '<li>';
        goodsHtml += '    <a class="imgSelect" title="'+list.prdtNm+'" href="/web/sv/detailPrdt.do?prdtNum='+list.prdtNum+'">';
        goodsHtml += '        <img src="'+list.imgPath+'" alt="">';
        goodsHtml += '    </a>';
        goodsHtml += '    <div class="detail">';
        goodsHtml += '        <span class="thumbnail-name">'+list.prdtNm+'</span>';
        goodsHtml += '        <span class="price">';
        goodsHtml += '            <em class="sales-price">'+list.saleAmt.replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",")+'</em>원';
        goodsHtml += '        </span>';
        //goodsHtml += '        <a href="javascript:void(0);" class="btn_delete delNewGoodsItem"></a>';
        goodsHtml += '        <a id="btn-delete-delNewGoodsItem" class="btn_delete delNewGoodsItem"></a>';
        goodsHtml += '    </div>';
        goodsHtml += '</li>';

        //console.log(82*(i+1));
        $("#yesNewGoods").css('height', 82*(i+1));
    });
    $("#newSeeGoods").html(goodsHtml);

    if (goodsHtml == ""){
        $("#yesNewGoods").hide();
        $("#noNewGoods").show();
    }

    //최근 본 상품 삭제
    $(document).on("click","#newSeeGoods > li > div > a", function(){
        const index = $(this).parents("li").index();
        newGoodsList.splice(index,1);
        if (newGoodsList.length < 1){
            $("#yesNewGoods").hide();
            $("#noNewGoods").show();
        }
        //영역 조절
        $.each(newGoodsList, function(i, list){
            $("#yesNewGoods").css('height', 82*(i+1));
        });

        $("#newSeeGoods > li:eq("+index+")").remove();
        localStorage.setItem('newGoodsList', JSON.stringify(newGoodsList));
    });
});

function go_top() {
	$('html, body').animate({scrollTop : 0}, 400);
	return false;
}
</script>
    <div id="_footer" data-container="footer" class="footer_wrap">
        <div class="skyscraper" style="display: none">
            <div class="recent_products">
                <div class="sv-cs">
                    <a href="<c:url value='/web/coustmer/qaList.do' />"><img src="/images/web/main/sv_cs.png" width="94" height="202" alt="탐나오 고객센터"></a>
                </div>
                <section class="lately selected">
                    <h2>최근 본 상품</h2>
                    <div class="lst" id="yesNewGoods">
                        <ul class="point_lnb_ul_0" id="newSeeGoods">
                        </ul>
                    </div>

                    <p class="no_data" id="noNewGoods" style="display: none;">
                        <span>
                            상품이<br>없습니다.
                        </span>
                    </p>
                </section>
            </div>
        </div>

        <div class="service_support">
            <div class="f_inner">
                <div class="top-wrap">
                    <a class="main-cs" href="<c:url value='/web/coustmer/qaList.do' />"><img src="/images/web/main/sv_cs.png" width="94" height="202" alt="탐나오 고객센터"></a>
                    <span onclick="go_top();" class="go-top" style="cursor:pointer;"><img src="/images/web/comm/top.png" width="55" height="55" loading="lazy" alt="맨위로"></span>
                </div>
                <ul>
                    <li><a href="/web/etc/introduction.do" title="회사소개"><span>회사소개</span></a></li>
                    <li><a href="/web/etc/buyToS.do" title="이용약관"><span>이용약관</span></a></li>
                    <li><a href="/web/coustmer/viewCorpPns.do" title="입점/제휴안내"><span>입점/제휴안내</span></a></li>
                    <li><a href="/web/etc/personalData.do" title="개인정보처리방침"><strong>개인정보처리방침</strong></a></li>
                    <li><a href="/web/coustmer/qaList.do" title="고객센터"><span>고객센터</span></a></li>
                    <li><a href="https://www.ftc.go.kr/info/bizinfo/communicationViewPopup.jsp?wrkr_no=6168204092" target="_blank" title="새창 열림"><span>사업자정보확인</span></a></li>
                    <li><a href="https://pgweb.tosspayments.com/ms/escrow/s_escrowYn.do?mertid=tamnao" target="_blank" title="새창 열림"><span>매매보호서비스</span></a></li>
                </ul>
            </div>
        </div>
        <div class="corp_wrap">
            <div class="corp_wrap_row">
                <div class="f_inner">
                    <div class="corp_info">
                        <dl class="company-area">
                            <dt><img src="/images/web/r_main/company-logo.png" alt="제주특별자치도관광협회 소개"></dt>
                            <dd class="company-note">1962년 2월 22일 관광진흥법 제45조에 의거 제주관광산업의 성장 발전과 회원업체의 사업발전 및 복리증진에 기여할 목적으로 설립하였습니다. 제주관광정책에 대한 조사ㆍ연구,
                                <br>
                                관광객 수용시설 및 서비스의 질 개선, 관광통계 작성, 관광안내소 및 국내홍보센터 운영, 관광객 불편사항 처리, 관광윤리 확립 및 관광질서 지도 등의 사업을 수행하고 있습니다.</dd>
                        </dl>
                        <dl>
                            <dt class="hidden-text">탐나오</dt>
                            <dd class="corp_info_cs">
                                <p>
                                    <em>1522-3454</em>
                                    <span>월~금 09:00 - 18:00</span>
                                    <span>점심시간 12:00 - 13:00</span>
                                </p>
                            </dd>
                            <dd class="corp_info_tx">
                                <p>
                                    <span>대표이사:강동훈</span>
                                    <span>63309 제주특별자치도 제주시 첨단로 213-65 제주종합비즈니스센터 3층</span>
                                    <span>법인 등록번호:220121-0000107</span>
                                    <span>사업자 등록번호:616-82-04092</span>
                                </p>
                                <p>
                                    <span>통신판매업번호:제2018-제주아라0049호</span>
                                    <span>개인정보관리책임자:김대철</span>
                                    <span>E-mail : tamnao@tamnao.com</span>
                                    <span>Fax : 064-749-7445</span>
                                </p>
                            </dd>
                            <dd class="corp_info_copy">
                                <p>탐나오는 통신판매중개자로서 거래당사자가 아니므로 개별 판매자가 등록한 상품거래정보 및 거래에 대해서 책임을 지지 않습니다.</p>
                                <p>이 사이트는 Google reCAPTCHA에 의해 보호되며, Google
                                    <a href="https://policies.google.com/privacy" target="_blank">개인정보 보호정책</a> 및 <a href="https://policies.google.com/terms" target="_blank">서비스 약관</a>이 적용됩니다.
                                </p>
                                <p>Copyright 2018. 제주특별자치도관광협회 All Rights Reserved.</p>
                            </dd>
                        </dl>
                    </div>
                    <div class="corp_rgt" >
                        <div class="f_sns">
                            <a href="https://blog.naver.com/jta0119" class="bl" target="_blank"><span class="blind">블로그</span></a>
                            <a href="https://www.instagram.com/tamnao_jeju/" class="ig" target="_blank"><span class="blind">인스타그램</span></a>
                            <a href="https://www.youtube.com/channel/UC5Hk3MfM3RFDz5_Xm9BDJZQ" class="ub" target="_blank"><span class="blind">유튜브</span></a>
                            <a href="https://www.facebook.com/JEJUTAMNAOTRAVEL" class="fb" target="_blank"><span class="blind">페이스북</span></a>
                            <a href="https://pf.kakao.com/_xhMCrj" class="ko" target="_blank"><span class="blind">카카오채널</span></a>
                        </div>
                        <div class="f_down">
                            <a href="https://apps.apple.com/kr/app/%ED%83%90%EB%82%98%EC%98%A4-%EC%A0%9C%EC%A3%BC%EC%97%AC%ED%96%89%EC%8A%A4%ED%86%A0%EC%96%B4/id1489404866" target="_blank">
                                <img src="/images/web/r_main/apple.png" width="80" height="80" alt="애플 앱다운로드" loading="lazy">
                                <span>iOS</span>
                            </a>
                            <a href="https://play.google.com/store/apps/details?id=kr.or.hijeju.tamnao" target="_blank">
                                <img src="/images/web/r_main/google.png" width="80" height="80" alt="구글 앱다운로드" loading="lazy">
                                <span>Android</span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="mark-zone">
                <div class="f_inner">
                    <div class="award">
                        <ul>
							<%-- <li><img src="/images/web/mark/gcs.png" alt="gcs"></li>--%>
                            <li><img src="/images/web/mark/maket.png" width="147" height="29" alt="2019 한국관광혁신대상 마케팅부분 최우수상" loading="lazy"></li>
                            <li><img src="/images/web/mark/int.png" width="112" height="31" alt="제13회 대한민국 인터넷대상" loading="lazy"></li>
                            <li><img src="/images/web/mark/web.png" width="104" height="31" alt="웹어워드 18 FINALIST" loading="lazy"></li>
                            <li><img src="/images/web/mark/nba.png" width="151" height="29" alt="2018 국가브랜드 대상" loading="lazy"></li>
                            <li><img src="/images/web/mark/ieco.png" width="104" height="31" alt="ieco AWARD 17 NOMINEE" loading="lazy"></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- AceCounter Log Gathering Script V.8.0.2019080601 -->
<script>
    var chkPath = document.location.pathname;
    if(chkPath.indexOf("rentcar") >= 0){
        $("h1").append("제주도렌트카 가격비교 및 할인 예약 - 탐나오 | 추천 렌터카 서비스");
    }else if(chkPath.indexOf("stay") >= 0){
        $("h1").append("제주숙소: 제주여행 공공플랫폼 탐나오, 저렴한 숙소 예약");
    }else if(chkPath.indexOf("tour") >= 0){
        $("h1").append("제주관광지: 제주여행 공공플랫폼 탐나오에서 예약하세요.");
    }else if(chkPath.indexOf("av") >= 0){
        $("h1").append("제주도항공권: 제주여행 공공플랫폼 탐나오");
    }else if(chkPath.indexOf("goods") >= 0){
        $("h1").append("제주도 공공플랫폼 탐나오 특산기념품 농수산물 배송");
    }else{
        $("h1").append("탐나오 TAMNAO - 제주도 공식 여행 공공 플랫폼");
    }
    var _AceGID=(function(){var Inf=['gtc15.acecounter.com','8080','AS2A40380465474','AW','0','NaPm,Ncisy','ALL','0']; var _CI=(!_AceGID)?[]:_AceGID.val;var _N=0;var _T=new Image(0,0);if(_CI.join('.').indexOf(Inf[3])<0){ _T.src =( location.protocol=="https:"?"https://"+Inf[0]:"http://"+Inf[0]+":"+Inf[1]) +'/?cookie'; _CI.push(Inf);  _N=_CI.length; } return {o: _N,val:_CI}; })();
    var _AceCounter=(function(){var G=_AceGID;var _sc=document.createElement('script');var _sm=document.getElementsByTagName('script')[0];if(G.o!=0){var _A=G.val[G.o-1];var _G=(_A[0]).substr(0,_A[0].indexOf('.'));var _C=(_A[7]!='0')?(_A[2]):_A[3];var _U=(_A[5]).replace(/\,/g,'_');_sc.src=(location.protocol.indexOf('http')==0?location.protocol:'http:')+'//cr.acecounter.com/Web/AceCounter_'+_C+'.js?gc='+_A[2]+'&py='+_A[4]+'&gd='+_G+'&gp='+_A[1]+'&up='+_U+'&rd='+(new Date().getTime());_sm.parentNode.insertBefore(_sc,_sm);return _sc.src;}})();
</script>
<noscript><img src='//gtc15.acecounter.com:8080/?uid=AS2A40380465474&je=n&' width='0' height='0'></noscript>
<!-- AceCounter Log Gathering Script End -->

<!-- 네이버 유입추척 (2018-01-25, By JDongS) -->
<script src="//wcs.naver.net/wcslog.js"> </script>
<script>
if (!wcs_add) var wcs_add={};
wcs_add["wa"] = "s_34e207b42ae3";
if (!_nasa) var _nasa={};
wcs.inflow("m.tamnao.com");
wcs_do(_nasa);
</script>

<!-- Google 리마케팅 SCRIPT START 2017.03.30 -->
<%--<script>
/* <![CDATA[ */
var google_conversion_id = 856580262;
var google_custom_params = window.google_tag_params;
var google_remarketing_only = true;
/* ]]> */
</script>
<script async src="//www.googleadservices.com/pagead/conversion.js">
</script>
<noscript>
<div style="display:inline;">
<img height="1" width="1" style="border-style:none;" src="//googleads.g.doubleclick.net/pagead/viewthroughconversion/856580262/?guid=ON&amp;script=0">
</div>
</noscript>--%>
<!-- // Google 리마케팅 SCRIPT END 2017.03.30 -->

<!-- Facebook Pixel Code 2018.02.26 -->
<script>
!function(f,b,e,v,n,t,s)
{if(f.fbq)return;n=f.fbq=function(){n.callMethod?
n.callMethod.apply(n,arguments):n.queue.push(arguments)};
if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';
n.queue=[];t=b.createElement(e);t.async=!0;
t.src=v;s=b.getElementsByTagName(e)[0];
s.parentNode.insertBefore(t,s)}(window,document,'script',
'https://connect.facebook.net/en_US/fbevents.js');
fbq('init', '424270624670832');
fbq('track', 'PageView');

var face_url = $(location).attr('href');

/* 웹 모바일 공통  */
if( face_url.match("cart.do") ){ //장바구니 페이지 일때
	fbq('track', 'AddToCart');
/* 웹 모바일 구분 웹 (웹:web/signUp04.do 모바일:mw/signUp02.do)  */	
}else if( face_url.match("web/signUp04.do") ){ //회원가입 했을때
	fbq('track', 'CompleteRegistration');
/* 웹모바일 공통  */
}else if( face_url.match("orderComplete.do") ){ //구매완료 했을때  ( value_won은 구매 금액 ) 
	setTimeout(function(){
		var value_won =  "${rsvInfo.totalSaleAmt}";
		value_won = parseInt(value_won.replace( /,/gi, ''));
		fbq('track', 'Purchase', {value: value_won, currency: 'KRW'});
	},1000)
}
</script>
<noscript>
    <img height="1" width="1" alt="페이스북">
</noscript>
<!-- End Facebook Pixel Code -->

<%-- 카카오 유입추적 모바일--%>
<script src="//t1.daumcdn.net/adfit/static/kp.js"></script>
<script>
    kakaoPixel('1824481670434828332').pageView();
</script>
<script>
    kakaoPixel('1996779769008668271').pageView();
</script>

<script src="//adimg.daumcdn.net/rt/roosevelt.js" async></script>
<!-- // 다음 DDN  리마케팅 SCRIPT END 2017.06.15 -->

<script>
/** CS이미지 메인화면에서만 ON  */
var pathNm = document.location.pathname;
if(pathNm != "/web/av/mainList.do" && pathNm != "/web/av/productList.do"){
	if (pathNm == '/' || pathNm.indexOf("mainList") > 0 || pathNm.indexOf("productList") > 0 || pathNm.indexOf("packageList") > 0 || pathNm.indexOf("detailPrdt") > 0) {
    	$(".main-cs").css("display","block");
	}
}
</script>

<!-- WIDERPLANET  SCRIPT START 2023.4.17 -->
<div id="wp_tg_cts" style="display:none;"></div>
<script>
var wptg_tagscript_vars = wptg_tagscript_vars || [];
wptg_tagscript_vars.push(
(function() {
	return {
		wp_hcuid:"",   /*고객넘버 등 Unique ID (ex. 로그인  ID, 고객넘버 등 )를 암호화하여 대입.
				*주의 : 로그인 하지 않은 사용자는 어떠한 값도 대입하지 않습니다.*/
		ti:"54575",	/*광고주 코드 */
		ty:"Home",	/*트래킹태그 타입 */
		device:"web"	/*디바이스 종류  (web 또는  mobile)*/

	};
}));
</script>
<script async src="//cdn-aitg.widerplanet.com/js/wp_astg_4.0.js"></script>
<!-- // WIDERPLANET  SCRIPT END 2023.4.17 -->