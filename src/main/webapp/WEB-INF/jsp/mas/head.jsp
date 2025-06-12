<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />

<script type="text/javascript">
/** http -> https 변환*/
if(document.location.protocol == 'http:') {
	var chkInclude = document.location.host;

	if(!chkInclude.includes("localhost") && !chkInclude.includes("dev") && !chkInclude.includes("218.157.128.119") && chkInclude.indexOf("tamnao.iptime.org") < 0) {
		document.location.href = document.location.href.replace("http:", "https:");
	}
}
/** 서브도메인없을경우 www 변환*/
var url1 = 'tamnao.com';
var url2 = 'www.tamnao.com';
if( url1 == document.domain ) document.location.href = document.URL.replace(url1, url2);

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

//comma 제거
function delCommaFormat() {
	$('.numFormat').each(function() {
		$(this).val($(this).val().replace(/(,)/g, ""));
	});
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

	if("${menuNm}" == "home"){
		$(".menu01").addClass("on");
	} else if("${menuNm}" == "corp"){
		$(".menu02").addClass("on");
	} else if("${menuNm}" == "product"){
		$(".menu03").addClass("on");
	} else if("${menuNm}" == "realtime"){
		$(".menu04").addClass("on");
	} else if("${menuNm}" == "promotion"){
		$(".menu05").addClass("on");
	} else if("${menuNm}" == "rsv"){
		$(".menu06").addClass("on");
	} else if("${menuNm}" == "useepil"){
		$(".menu07").addClass("on");
	} else if("${menuNm}" == "adj"){
		$(".menu08").addClass("on");
	} else if("${menuNm}" == "ansl"){
		$(".menu09").addClass("on");
	} else if("${menuNm}" == "help"){
		$(".menu11").addClass("on");
	} else if("${menuNm}" == "b2b"){
		$(".menu-b2b").addClass("on");
	}

	// 금액 소숫점 추가
    $('.numFormat').each(function() {
    	$(this).val($(this).val().replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'));
    });
    $('.numFormat').change(function() {
    	var num = $(this).val().replace(/(,)/g, "");
    	$(this).val(num.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'));

    	$('.numFormat').each(function() {
	    	$(this).val($(this).val().replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'));
	    });
    });
});

</script>

<!--Header 영역-->
<div id="header_wrapper">
	<h1><img src="/images/mas/common/logo.gif" alt="탐나오 입점업체 관리자 시스템" /> <span class="title">- <c:out value="${topCorpNm }" /></span></h1>
	<!--상단 게시물 롤링-->
	<!-- <div class="header_alim">
		<ul>
			<li><a href="#">공항 부근으로 렌트카 주차장 부지 찾습니다 평수,금액 무관합...</a></li>
		</ul>
	</div> -->
	<!--//상단 게시물 롤링-->
	<ul class="lnb_menu">
		<li class="home"><a href="/" target="_blank">탐나오 바로가기</a></li>
		<li>
			<c:choose>
				<c:when test="${corpCd == Constant.ACCOMMODATION}">
					<a href="/data/manual/Tamnao_Manual_Accommodation_v2.1.pdf" target="_blank">매뉴얼 다운로드</a>
				</c:when>
				<c:when test="${corpCd == Constant.RENTCAR}">
					<a href="/data/manual/Tamnao_Manual_Rentcar_v2.1.pdf" target="_blank">매뉴얼 다운로드</a>
				</c:when>
				<c:when test="${corpCd == Constant.SOCIAL}">
					<a href="/data/manual/Tamnao_Manual_Social_v2.1.pdf" target="_blank">매뉴얼 다운로드</a>
				</c:when>
				<c:when test="${corpCd == Constant.SV}">
					<a href="/data/manual/Tamnao_Manual_Shop_v1.2.pdf " target="_blank">매뉴얼 다운로드</a>
				</c:when>
			</c:choose>
		</li>
		<li><a href="<c:url value='/web/viewLogin.do?rtnUrl=/web/mypage/viewChangePw.do'/>" target="_blank">비밀번호변경</a></li>
		<li class="log"><a href="<c:url value='/mas/masLogout.do'/>">로그아웃</a></li>
	</ul>
	<!--상단메뉴-->
	<h2 class="lay_none">상단메뉴</h2>
	<ul class="gnb_menu">
		<li class="menu01"><a href="<c:url value='/mas/home.do'/>">홈</a>
			<!-- <ul class="gnb_depth" id="menu01" style="display:none">
			</ul> -->
		</li>
		<li class="menu02"><a href="<c:url value='/mas/detailCorp.do' />">업체정보</a>
			<ul class="gnb_depth" id="menu02" style="display:none">
				<li><a href="<c:url value='/mas/detailCorp.do' />">기본정보</a></li>
				<c:choose>
					<c:when test="${corpCd == Constant.ACCOMMODATION}">
						<li><a href="<c:url value='/mas/ad/adInfo.do' />">숙소정보</a></li>
						<li><a href="<c:url value='/mas/ad/adInfoImgList.do' />">숙소이미지</a></li>
						<li><a href="<c:url value='/mas/ad/adAddamtList.do' />">인원추가요금(공통)</a></li>
					</c:when>
					<c:when test="${corpCd == Constant.RENTCAR}">
						<li><a href="<c:url value='/mas/rc/rentCarInfo.do' />">판매정책</a></li>
					</c:when>
					<c:when test="${corpCd == Constant.SOCIAL}">
						<li><a href="<c:url value='/mas/detailSpAddInfo.do' />">판매처관리</a></li>
					</c:when>
					<c:when test="${corpCd == Constant.SV}">
						<li><a href="<c:url value='/mas/detailSpAddInfo.do' />">판매처관리</a></li>
						<li><a href="<c:url value='/mas/dlvCorpMng.do' />">배송업체관리</a></li>
						<li><a href="<c:url value='/mas/sv/detailSvDftinf.do' />">직접수령위치관리</a></li>
					</c:when>
				</c:choose>
				<li><a href="<c:url value='/mas/corpAdtm.do' />">광고정보</a></li>
			</ul>
		</li>
		<li class="menu03"><a href="<c:url value='/mas/${fn:toLowerCase(corpCd)}/productList.do'/>">상품관리</a>
			<!-- 상품관리 부분은 각 업체코드별로 분기 -->
			<c:choose>
				<c:when test="${corpCd == Constant.ACCOMMODATION}">
					<ul class="gnb_depth" id="menu03" style="display:none">
						<li><a href="<c:url value='/mas/ad/productList.do' />">객실관리</a></li>
<%--						<li><a href="<c:url value='/mas/couponList.do' />">할인쿠폰</a></li>  2021.03.12 chaewan.jung 사용 안함 처리  --%>
					</ul>
				</c:when>
				<c:when test="${corpCd == Constant.RENTCAR}">
					<ul class="gnb_depth" id="menu03" style="display:none">
						<li><a href="<c:url value='/mas/rc/productList.do' />">차종관리</a></li>
						<li><a href="<c:url value='/mas/rc/disPerPackList.do' />">할인율관리</a></li>
						<%--<li><a href="<c:url value='/mas/couponList.do' />">할인쿠폰</a></li>--%>
					</ul>
				</c:when>
				<c:when test="${corpCd == Constant.SOCIAL}">
					<ul class="gnb_depth" id="menu03" style="display:none">
						<li><a href="<c:url value='/mas/sp/productList.do' />">상품관리</a></li>
						<li><a href="<c:url value='/mas/sp/stockList.do' />">재고관리</a></li>
						<%--<li><a href="<c:url value='/mas/couponList.do' />">할인쿠폰</a></li>--%>
					</ul>
				</c:when>
				<c:when test="${corpCd == Constant.SV}">
					<ul class="gnb_depth" id="menu03" style="display:none">
						<li><a href="<c:url value='/mas/sv/productList.do' />">상품관리</a></li>
						<li><a href="<c:url value='/mas/sv/stockList.do' />">재고관리</a></li>
						<%--<li><a href="<c:url value='/mas/couponList.do' />">할인쿠폰</a></li>--%>
					</ul>
				</c:when>
			</c:choose>
		</li>
		<c:if test="${corpCd!=Constant.SOCIAL and corpCd!=Constant.SV}">
			<li class="menu04"><a href="<c:url value='/mas/${fn:toLowerCase(corpCd)}/realTimeList.do' />">수량관리</a></li>
		</c:if>
		<li class="menu05"><a href="<c:url value='/mas/prmt/promotionList.do' />">프로모션</a></li>
		<c:if test="${corpCd ne Constant.SV}">
			<li class="menu06"><a href="<c:url value='/mas/${fn:toLowerCase(corpCd)}/rsvList.do' />">예약관리</a>
				<c:if test="${corpCd == Constant.RENTCAR}">
					<ul class="gnb_depth" id="menu06" style="display:none">
						<li><a href="<c:url value='/mas/${fn:toLowerCase(corpCd)}/rsvList.do' />">예약관리</a></li>
						<li><a href="<c:url value='/mas/rc/rsvChart.do' />">예약현황</a></li>
					</ul>
				</c:if>
			</li>
		</c:if>
		<c:if test="${corpCd eq Constant.SV}">
			<li class="menu06"><a href="<c:url value='/mas/${fn:toLowerCase(corpCd)}/rsvList.do' />">구매관리</a></li>
		</c:if>

		<%-- <li class="menu-b2b"><a href="<c:url value='/mas/b2b/ctrtCorpList.do'/>">B2B시스템</a>
			<ul class="gnb_depth" id="menu-b2b" style="display:none">
				<li><a href="<c:url value='/mas/b2b/ctrtCorpList.do' />">계약관리</a></li>
				<c:if test="${corpCd eq Constant.ACCOMMODATION}">
					<li><a href="<c:url value='/mas/b2b/${fn:toLowerCase(corpCd)}/corpGrpList.do' />">요금관리</a></li>
				</c:if>
				<c:if test="${corpCd eq Constant.RENTCAR}">
					<li><a href="<c:url value='/mas/b2b/${fn:toLowerCase(corpCd)}/corpGrpList.do' />">할인율관리</a></li>
				</c:if>
				<c:if test="${corpCd eq Constant.SOCIAL}">
					<li><a href="<c:url value='/mas/b2b/sp/adList.do' />">상품구매</a></li>
					<li><a href="<c:url value='/mas/b2b/rsvList.do' />">구매내역</a></li>
				</c:if>
			</ul>
		</li> --%>

		<li class="menu07"><a href="<c:url value='/mas/${fn:toLowerCase(corpCd)}/otoinqList.do' />">커뮤니티</a>
			<ul class="gnb_depth" id="menu07" style="display:none">
				<li><a href="<c:url value='/mas/${fn:toLowerCase(corpCd)}/otoinqList.do' />">1:1문의</a></li>
				<li><a href="<c:url value='/mas/${fn:toLowerCase(corpCd)}/useepilList.do' />">상품평조회</a></li>
			</ul>
		</li>
		<li class="menu08"><a href="<c:url value='/mas/adjList.do' />">정산</a>
			<ul class="gnb_depth" id="menu08" style="display:none">
				<li><a href="<c:url value='/mas/adjList.do' />">정산</a></li>
				<li><a href="<c:url value='/mas/adjGrandSale2018List.do' />">탐나오상품권정산</a></li>
			</ul>
		</li>
		<li class="menu09"><a href="<c:url value='/mas/anls02.do'/>">통계</a></li>
		<li class="menu11"><a href="<c:url value='/mas/bbs/bbsList.do'/>?bbsNum=MASNOTI">지원</a>
			<ul class="gnb_depth" id="menu11" style="display:none">
				<li><a href="<c:url value='/mas/bbs/bbsList.do'/>?bbsNum=MASNOTI">업체공지사항</a></li>
				<li><a href="<c:url value='/mas/bbs/bbsList.do'/>?bbsNum=MASQA">업체 Q&amp;A 게시판</a></li>
				<!-- 20.05.14 디자인요청 게시판 추가_김지연  -->
				<c:if test="${corpCd eq Constant.SOCIAL or corpCd eq Constant.SV}">
					<li><a href="<c:url value='/mas/bbs/bbsList.do'/>?bbsNum=DESIGN">디자인 요청</a></li>
				</c:if>
			</ul>
		</li>
	</ul>
	<!--//상단메뉴-->
</div>
<!--//Header 영역-->

