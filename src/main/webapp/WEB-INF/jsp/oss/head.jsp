<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

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

function fn_layerDetailCorp(corpId) {
	$.ajax({
		url :"<c:url value='/oss/detailCorp.ajax'/>",
		data : "corpId=" + corpId,
		success: function(data) {
			$("#div_blank_htnl").html(data);
			show_popup($("#div_blank"));
		},
		error : fn_AjaxError
	})
}

var itv;
var timeLeft = 60*60*2;

var updateLeftTime = function() {
	timeLeft = (timeLeft <= 0) ? 0 : -- timeLeft;

	if(timeLeft > 0) {
		var hours = Math.floor(timeLeft / 3600);
		var minutes = Math.floor((timeLeft - 3600 * hours) / 60);
		var seconds = timeLeft % 60;

		var msg = "<b>";
		if(hours > 0) {
			msg += hours + "시간";
		}
		if(minutes > 0) {
			msg += minutes + "분 ";
		}
		msg += seconds + "초</b>";

		$("#waitingTime").html("남은시간 " + msg);
	} else {
		$("#waitingTime").html("세션시간 초과");
		clearInterval(itv);
	}
}

$(document).ready(function(){
	if(timeLeft > 0) {
			itv = setInterval(updateLeftTime, 1000);
	} else {
		$("#btnBuy").remove();
		$("#waitingTime").html("세션시간 초과");
	}

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
	}
	if("${menuNm}" == "setting"){
		$(".menu02").addClass("on");
	}
	if("${menuNm}" == "user"){
		$(".menu03").addClass("on");
	}
	if("${menuNm}" == "corp"){
		$(".menu11").addClass("on");
	}
	if("${menuNm}" == "product"){
		$(".menu05").addClass("on");
	}
	if("${menuNm}" == "community"){
		$(".menu06").addClass("on");
	}
	if("${menuNm}" == "maketing"){
		$(".menu10").addClass("on");
	}
	if("${menuNm}" == "site"){
		$(".menu13").addClass("on");
	}
	if("${menuNm}" == "rsv"){
		$(".menu07").addClass("on");
	}
	if("${menuNm}" == "adj"){
		$(".menu09").addClass("on");
	}
	if("${menuNm}" == "anls"){
		$(".menu08").addClass("on");
	}
	if("${menuNm}" == "support"){
		$(".menu04").addClass("on");
	}
	if("${menuNm}" == "bis"){
		$(".menu08").addClass("on");
	}
	if("${menuNm}" == "mntr"){
		$(".menu-bi").addClass("on");
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
<script type="text/javascript">
// Bootstrap 및 반응형 처리를 위한 공통 스크립트
$(function(){
    if($("meta[name='viewport']").length === 0){
        $('<meta name="viewport" content="width=device-width, initial-scale=1">').prependTo('head');
    }

    // 테이블, 셀렉트 박스, 입력폼에 부트스트랩 클래스 적용
    $('table').addClass('table table-striped table-bordered');
    $('select').addClass('form-select');
    $('input[type="text"], input[type="password"], input[type="number"], textarea').addClass('form-control');
    $('input[type="radio"], input[type="checkbox"]').addClass('form-check-input');
});
</script>

<!--Header 영역-->
<nav id="header_wrapper" class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#"><img src="<c:url value='/images/oss/common/logo.gif'/>" alt="탐나오 통합운영지원 시스템" /></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminNavbar" aria-controls="adminNavbar" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="adminNavbar">
            <ul class="navbar-nav me-auto gnb_menu">
		<li class="menu01"><a href="<c:url value='/oss/home.do' />">홈</a>
			<!-- <ul class="gnb_depth" id="menu01" style="display:none">
			</ul> -->
		</li>
		<li class="menu02"><a href="<c:url value='/oss/logoManage.do' />">환경설정</a>
			<ul class="gnb_depth" id="menu02" style="display:none">
				<li><a href="<c:url value='/oss/logoManage.do'/>">로고 설정</a></li>
				<li><a href="<c:url value='/oss/siteManage.do'/>">운영 설정</a></li>
				<li><a href="<c:url value='/oss/codeList.do' />">코드 관리</a></li>
				<li><a href="<c:url value='/oss/cmssList.do' />">수수료 관리</a></li>
				<li><a href="<c:url value='/oss/cmssPgList.do' />">PG사 수수료 관리</a></li>
				<li><a href="<c:url value='/oss/channelTalkManage.do' />">채널톡 관리</a></li>
				<li><a href="<c:url value='/oss/bbsList.do'/>">게시판 관리</a></li>
			</ul>
		</li>
		<li class="menu03"><a href="<c:url value='/oss/userList.do'/>">고객관리</a>
			<ul class="gnb_depth" id="menu03" style="display:none">
				<li><a href="<c:url value='/oss/userList.do'/>">사용자 관리</a></li>
				<li><a href="<c:url value='/oss/dropUserList.do'/>">탈퇴사용자 관리</a></li>
			</ul>
		</li>
		<li class="menu11"><a href="<c:url value='/oss/corpList.do'/>">업체/제휴관리</a>
			<ul class="gnb_depth" id="menu11" style="display:none">
				<li><a href="<c:url value='/oss/corpList.do'/>">입점업체 관리</a></li>
				<li><a href="<c:url value='/oss/corpPnsReqList.do'/>">입점신청 관리</a></li>
				<%-- <li><a href="<c:url value='/oss/b2bReqList.do'/>">B2B 신청관리</a></li>
				<li><a href="<c:url value='/oss/b2bCtrtList.do'/>">B2B 계약관리</a></li> --%>
				<li><a href="<c:url value='/oss/nbbs/bbsList.do'/>?bbsNum=MASNOTI">업체 공지사항</a></li>
				<li><a href="<c:url value='/oss/nbbs/bbsList.do'/>?bbsNum=MASQA">업체 Q&amp;A 게시판</a></li>
				<li><a href="<c:url value='/oss/corpLevel.do'/>">입점업체 지수</a></li>
				<li><a href="<c:url value='/oss/tamnaoPartners.do'/>">파트너사 관리</a></li>
				<li><a href="<c:url value='/oss/visitjejuList.do'/>">비짓제주 연동</a></li>
			</ul>
		</li>
		<li class="menu05"><a href="<c:url value='/oss/prdtList.do'/>">상품관리</a>
			<ul class="gnb_depth" id="menu05" style="display:none">
				<li><a href="<c:url value='/oss/prdtList.do'/>">상품 관리</a></li>
				<li><a href="<c:url value="/oss/socialProductList.do"/>">소셜상품 관리</a></li>
				<li><a href="<c:url value="/oss/svPrdtList.do"/>">제주특산/기념품 관리</a></li>
				<li><a href="<c:url value="/oss/chckPrdtExpireList.do"/>">상품 기한 관리</a></li>
				<li><a href="<c:url value="/oss/couponList.do"/>">탐나오쿠폰</a></li>
				<li><a href="<c:url value="/oss/promotionList.do"/>">프로모션 승인 관리</a></li>
				<li><a href="<c:url value="/oss/cardivList.do"/>">차종 관리</a></li>
				<li><a href="<c:url value="/oss/point/couponList.do"/>">포인트 관리</a></li>
			</ul>
		</li>
		<li class="menu06"><a href="<c:url value='/oss/otoinqList.do'/>">커뮤니티</a>
			<ul class="gnb_depth" id="menu06" style="display:none">
				<li><a href="<c:url value="/oss/otoinqList.do"/>">1:1 문의</a></li>
				<li><a href="<c:url value="/oss/useepilList.do"/>">상품평 관리</a></li>
				<li><a href="<c:url value="/oss/useepilAdd.do"/>">상품평 추가</a></li>
				<li><a href="<c:url value='/oss/nbbs/bbsList.do'/>?bbsNum=NOTICE">공지사항</a></li>
				<li><a href="<c:url value='/oss/etc/sccList.do'/>">홍보영상</a></li>
				<li><a href="<c:url value='/oss/nbbs/bbsList.do'/>?bbsNum=NEWS">보도자료</a></li>
				<li><a href="<c:url value='/oss/nbbs/bbsList.do'/>?bbsNum=DESIGN">디자인요청</a></li>
			</ul>
		</li>
		<li class="menu07"><a href="<c:url value='/oss/rsvList.do'/>">예약/구매관리</a>
			<ul class="gnb_depth" id="menu07" style="display:none">
				<li><a href="<c:url value='/oss/rsvList.do'/>">예약 관리</a></li>
				<li><a href="<c:url value='/oss/rsvSvList.do'/>">제주특산/기념품 구매 관리</a></li>
				<li><a href="<c:url value='/oss/rsvAtPrdtList.do'/>">상품별 예약 관리</a></li>
				<li><a href="<c:url value='/oss/refundRsvList.do'/>">환불요청 예약 관리</a></li>
				<li><a href="<c:url value='/oss/adminRsvRegExcel.do?corpDiv=SV'/>">관리자 예약(EXCEL)</a></li>
<%--				<li><a href="<c:url value='/oss/rsvAvList.do'/>"><del>항공 예약 관리</del></a></li>--%>
			</ul>
		</li>
		<li class="menu10"><a href="<c:url value='/oss/smsForm.do' />">마케팅 관리</a>
			<ul class="gnb_depth" id="menu10" style="display:none">
				<li><a href="<c:url value='/oss/smsForm.do' />">문자 전송</a></li>
				<li><a href="<c:url value='/oss/emailForm.do' />">E-Mail 전송</a></li>
				<li><a href="<c:url value='/oss/evntInfList.do' />">이벤트 정보 관리</a></li>
			</ul>
		</li>
		<li class="menu13"><a href="<c:url value='/oss/eventList.do' />">사이트 관리</a>
			<ul class="gnb_depth" id="menu13" style="display:none">
				<li><a href="<c:url value='/oss/mainConfig.do' />">메인 관리</a></li>
				<li><a href="<c:url value='/oss/brandShopConfig.do' />">브랜드관 관리</a></li>
				<li><a href="<c:url value='/oss/eventList.do' />">프로모션</a></li>
				<li><a href="<c:url value='/oss/svCrtnList.do' />">제주특산/기념품 큐레이션</a></li>
				<li><a href="<c:url value='/oss/kwaList.do' />">해시태그 광고 관리</a></li>
				<li><a href="<c:url value='/oss/bestprdtList.do' />">베스트상품 관리</a></li>
				<li><a href="<c:url value='/oss/mdsPickList.do' />">MD's Pick 관리</a></li>
				<li><a href="<c:url value='/oss/bannerList.do' />">배너 관리</a></li>
				<li><a href="<c:url value='/oss/fileList.do' />">파일 관리</a></li>
			</ul>
		</li>
		<li class="menu09"><a href="<c:url value='/oss/adjList.do'/>">정산</a>
			<ul class="gnb_depth" id="menu09" style="display:none">
				<li><a href="<c:url value='/oss/adjList.do'/>">정산 관리</a></li>
			</ul>
		</li>
		<%-- <li class="menu08"><a href="<c:url value='/oss/anls06.do'/>">통계</a>
			<ul class="gnb_depth" id="menu08" style="display:none">
				<li><a href="<c:url value='/oss/anls06.do'/>">매출통계</a></li>
				<li><a href="<c:url value='/oss/anls05.do'/>">고객통계</a></li>
				<li><a href="<c:url value='/oss/anls03.do'/>">일별현황</a></li>
			</ul>
		</li> --%>
		<li class="menu08"><a href="<c:url value='/oss/bisDayPresentCondition.do'/>">BI시스템</a>
			<ul class="gnb_depth" id="menu08" style="display:none">
				<%--<li><a href="<c:url value='/oss/bisCusUse.do'/>">고객이용 통계</a></li>--%>
				<li><a href="<c:url value='/oss/bisCorp.do'/>">입점업체 통계</a></li>
				<li><a href="<c:url value='/oss/bisDayCorpAnls.do'/>">입점업체 현황</a></li>
				<li><a href="<c:url value='/oss/bisDayPresentCondition.do'/>">일일 현황</a></li>
				<li><a href="<c:url value='/oss/bisSaleYear.do'/>">판매 통계</a></li>
				<li><a href="<c:url value='/oss/bisProductAnls.do'/>">상품별 판매통계</a></li>
				<li><a href="<c:url value='/oss/bisAdj.do'/>">정산 통계</a></li>
			</ul>
		</li>
		<li class="menu-bi"><a href="<c:url value='/oss/tlCancelErrList.do'/>">모니터링</a>
			<ul class="gnb_depth" id="menu-bi" style="display:none">
				<li><a href="<c:url value='/oss/tlCancelErrList.do'/>">TL린칸 취소전송 오류</a></li>
				<li><a href="<c:url value='/oss/tlCorpList.do'/>">TL린칸 연동 업체</a></li>
				<li><a href="<c:url value='/oss/lsProductList.do'/>">관광지API상품현황</a></li>
				<li><a href="<c:url value='/oss/lsCompanyList.do'/>">관광지API업체현황</a></li>
				<li><a href="<c:url value='/oss/pointRsvErrList.do'/>">포인트 결제 오류</a></li>
			</ul>
		</li>
            </ul>
            <ul class="navbar-nav ms-auto lnb_menu">
                <li class="nav-item"><b>${userNm}</b>님 접속 </li>
                <li class="nav-item" id="waitingTime"><a class="nav-link" href="/" target="_blank">남은시간</a></li>
                <li class="nav-item home"><a class="nav-link" href="/" target="_blank">탐나오바로가기</a></li>
                <li class="nav-item"><a class="nav-link" href="<c:url value='/web/viewLogin.do?rtnUrl=/web/mypage/viewChangePw.do'/>" target="_blank">비밀번호변경</a></li>
                <li class="nav-item log"><a class="nav-link" href="<c:url value='/oss/ossLogout.do'/>">로그아웃</a></li>
            </ul>
        </div>
    </div>
</nav>
<!--//Header 영역-->

