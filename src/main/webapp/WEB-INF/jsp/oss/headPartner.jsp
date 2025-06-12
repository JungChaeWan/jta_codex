<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
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
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#partnerNavbar" aria-controls="partnerNavbar" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="partnerNavbar">
            <ul class="navbar-nav me-auto gnb_menu">
<%--		<li class="menu01"><a href="<c:url value='/oss/home.do' />">홈</a></li>--%>
		<li class="menu03"><a href="<c:url value='/oss/pointUsageInfo.do'/>">사용현황</a></li>
		<li class="menu11" style="display: none;"><a href="<c:url value='/oss/corpPartnerList.do'/>">업체 관리</a></li>
		<li class="menu07"><a href="<c:url value='/oss/rsvList.do'/>">예약/구매관리</a>
			<ul class="gnb_depth" id="menu07" style="display:none">
				<li><a href="<c:url value='/oss/rsvList.do'/>">예약 관리</a></li>
				<li><a href="<c:url value='/oss/rsvSvList.do'/>">제주특산/기념품 구매 관리</a></li>
			</ul>
		</li>
<%--		<li class="menu09"><a href="<c:url value='/oss/adjList.do'/>">정산</a></li>--%>
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