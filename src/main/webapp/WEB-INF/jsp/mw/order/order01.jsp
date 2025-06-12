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
<jsp:include page="/mw/includeJs.do" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/bootstrap/css/bootstrap.min.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub_cart.css?version=2.2'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub_mypage.css'/>">

<script type="text/javascript" src="<c:url value='/js/mw_adDtlCalendar.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/mw_glDtlCalendar.js'/>"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>

<script type="text/javascript">

/** 특별처리빅이벤트*/
/*let date = new Date();
let yy = date.getFullYear();
let mm = date.getMonth()+1; mm = (mm < 10) ? '0' + mm : mm;
let dd = date.getDate(); dd = (dd < 10) ? '0' + dd : dd;
let hh = date.getHours();*/
/** 전역변수*/
/*curTime = String(yy) + String(mm) + String(dd) + String(hh);*/
//우편번호 찾기 화면을 넣을 element
let element_layer;

function closeDaumPostcode() {
    // iframe을 넣은 element를 안보이게 한다.
    element_layer.style.display = 'none';
}

function initLayerPosition() {
    let width = '100%'; //우편번호서비스가 들어갈 element의 width
    let height = '100%'; //우편번호서비스가 들어갈 element의 height
    let borderWidth = 5; //샘플에서 사용하는 border의 두께

    element_layer.style.width = width;
    element_layer.style.height = height;
    element_layer.style.border = borderWidth + 'px solid';
}

function sample2_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            localStorage.setItem("localAreaYn", fnLocalAreaYn());
            let fullAddr = data.address; // 최종 주소 변수
            let extraAddr = ''; // 조합형 주소 변수

            // 기본 주소가 도로명 타입일때 조합한다.
            if(data.addressType === 'R'){
                //법정동명이 있을 경우 추가한다.
                if(data.bname !== ''){
                    extraAddr += data.bname;
                }
                // 건물명이 있을 경우 추가한다.
                if(data.buildingName !== ''){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postNum').value = data.zonecode; //5자리 새우편번호 사용
            document.getElementById('roadNmAddr').value = fullAddr;
            setLocalStorage();
            let jejuYn = data.address.search("제주특별자치도");
            if(jejuYn < 0){
                fnChangeLocalArea("N");
            }else{
                fnChangeLocalArea("Y");
            }

            // iframe을 넣은 element를 안보이게 한다.
            // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
            element_layer.style.display = 'none';
        },
        width : '100%',
        height : '100%'
    }).embed(element_layer);
    // iframe을 넣은 element를 보이게 한다.
    element_layer.style.display = 'block';
    // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
    initLayerPosition();
}

/* 중복 SUBMIT 방지 */
var doubleSubmitFlag = false;

function doubleSubmitCheck() {
    if(doubleSubmitFlag) {
        return doubleSubmitFlag;
    } else {
        doubleSubmitFlag = true;
        return false;
    }
}

/**
 * DAUM 연동 주소찾기
 */
function openDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            document.getElementById('postNum').value = data.zonecode;
            document.getElementById('roadNmAddr').value = data.address;
            document.getElementById('dtlAddr').focus();
        }
    }).open();
}

function fn_RsvConfirm() {
    if(doubleSubmitFlag) {
        return;
    }

    //최종 결제금액이 0보다 낮을 경우 처리
    if($("#lastAmt").text().replace(/,/g, '') < 0){
        alert("포인트 또는 쿠폰을 초과하여 사용 하였습니다.\n최종 결제 금액을 확인 해 주세요.");
        return;
    }

	if(isNull($("#rsvNm").val())) {
		alert("예약자 이름을 입력해주세요.");
		$("#rsvNm").focus();
		return;
	}
	if(isNull($("#rsvEmail").val())) {
		alert("예약자 이메일을 입력해주세요.");
		$("#rsvEmail").focus();
		return;
	}
	if(isNull($("#rsvTelnum").val())) {
		alert("예약자 전화번호를 입력해주세요.");
		$("#rsvTelnum").focus();
		return;
	}
	if(isNull($("#useNm").val())) {
		alert("사용자 이름을 입력해주세요.");
		$("#useNm").focus();
		return;
	}
    if(strLengthCheck($("#useNm").val()) > 40 ) {
        alert("사용자 이름은 12자를 초과하실 수 없습니다.");
        $("#useNm").focus();
        return;
    }
	if("${orderDiv ne Constant.SV}" && isNull($("#useEmail").val())) {
		alert("사용자 이메일을 입력해주세요.");
		$("#useEmail").focus();
		return;
	}
	if(isNull($("#useTelnum").val())) {
		alert("사용자 전화번호를 입력해주세요.");
		$("#useTelnum").focus();
		return;
	}
	// 휴대폰번호 체크
	if(!checkIsHP($("#rsvTelnum").val())) {
		alert("<spring:message code='errors.phone'/>");
		$("#rsvTelnum").focus();
		return;
	}
	if(!checkIsHP($("#useTelnum").val())) {
		alert("<spring:message code='errors.phone'/>");
		$("#useTelnum").focus();
		return;
	}

	// L.Point 체크
	var lpointSave = eval($("#lPointBalance").val().replace(/[^\d]+/g, ''));

	if(lpointSave!='' && lpointSave < $("input[name=lpointUsePoint]").val()) {
		alert('사용할 금액이 잔액보다 초과되었습니다.');
		return false;
	}
	if(${orderDiv eq Constant.SV}) {
		if(isNull($("#postNum").val()) || isNull($("#roadNmAddr").val())) {
			alert("배송지 주소를 입력해 주세요.");
			$("#roadNmAddr").focus();
			return ;
		}
		if(isNull($("#dtlAddr").val())) {
			alert("상세 주소를 입력해 주세요.");
			$("#dtlAddr").focus();
			return ;
		}
	}
	if($("#chkUserSmsYn").is(":checked")){
		$("#userSmsYn").val("Y");
	}

    //협력사(파트너)포인트에 콤마가 있으면 제거, 입력 안했을 경우 0 처리
    let usePoint = 0
    if ($("#usePoint").val() != undefined && $("#usePoint").val() != ""){
        usePoint = $("#usePoint").val().replace(/,/gi,"");
    }
    $("#usePoint").val(usePoint);

    doubleSubmitCheck();

	if(document.location.hash){ // 예약확인을 한번 클릭 한 이후에는 만료페이지로 보냄
       location.href = "/htmls/mw/expiration.html";
    }else{ // 처음 예약확인 클릭 시
        document.location.hash = 1
        document.rsvInfo.action = "<c:url value='/mw/order02.do'/>";
        document.rsvInfo.submit();
    }
}

function fn_RsvConfirmSV() {
    if(doubleSubmitFlag) {
        return;
    }

    //최종 결제금액이 0보다 낮을 경우 처리
    if($("#lastAmt").text().replace(/,/g, '') < 0){
        alert("포인트 또는 쿠폰을 초과하여 사용 하였습니다.\n최종 결제 금액을 확인 해 주세요.");
        return;
    }

	if(isNull($("#rsvNmSV").val())) {
		alert("구매자 이름을 입력해주세요.");
		$("#rsvNmSV").focus();
		return;
	}
	if(isNull($("#rsvEmailSV").val())) {
		alert("구매자 이메일을 입력해주세요.");
		$("#revEmailSV").focus();
		return;
	}
	if(isNull($("#rsvTelnumSV").val())) {
		alert("구매자 전화번호를 입력해주세요.");
		$("#rsvTelnumSV").focus();
		return;
	}
	if("${svDirRecv}" == "N") {
		if(isNull($("#useNmSV").val())) {
			alert("수령인 이름을 입력해주세요.");
			$("#useNmSV").focus();
			return;
		}

        if(strLengthCheck($("#useNmSV").val()) > 40 ) {
            alert("수령인 이름은 12자를 초과하실 수 없습니다.");
            $("#useNmSV").focus();
            return;
        }

		if(isNull($("#useTelnumSV").val())) {
			alert("수령인 전화번호를 입력해주세요.");
			$("#useTelnumSV").focus();
			return;
		}
		if(!checkIsHP($("#useTelnumSV").val())) {
			alert("<spring:message code='errors.phone'/>");
			$("#useTelnumSV").focus();
			return;
		}
		if(${orderDiv eq Constant.SV}) {
			if(isNull($("#postNum").val()) || isNull($("#roadNmAddr").val())) {
				alert("배송지 주소를 입력해 주세요.");
				$("#roadNmAddr").focus();
				return ;
			}
			if(isNull($("#dtlAddr").val())) {
				alert("상세 주소를 입력해 주세요.");
				$("#dtlAddr").focus();
				return ;
			}
		}
	}

	// L.Point 체크
	var lpointSave = eval($("#lPointBalance").val().replace(/[^\d]+/g, ""));

	if(lpointSave != "" && lpointSave < $("input[name=lpointUsePoint]").val()) {
		alert("사용할 금액이 잔액보다 초과되었습니다.");
		return false;
	}
	if($("#chkUserSmsYn").is(":checked")) {
		$("#userSmsYn").val("Y");
	}

    //협력사(파트너)포인트에 콤마가 있으면 제거, 입력 안했을 경우 0 처리
    let usePoint = 0
    if ($("#usePoint").val() != undefined && $("#usePoint").val() != ""){
        usePoint = $("#usePoint").val().replace(/,/gi,"");
    }
    $("#usePoint").val(usePoint);

    doubleSubmitCheck();

    if(document.location.hash){ // 예약확인을 한번 클릭 한 이후에는 만료페이지로 보냄
        location.href = "/htmls/mw/expiration.html";
    }else{ // 처음 예약확인 클릭 시
        document.location.hash = 1;
        document.rsvInfo.action = "<c:url value='/mw/order02.do'/>";
        document.rsvInfo.submit();
    }
}

function fn_CalRsvAmt() {
	$(".goodsAmt").each(function(index){
		$(this).html(commaNum(parseInt($("input[name=cartTotalAmt]").eq(index).val()) + parseInt($("input[name=dlvAmt]").eq(index).val()) - parseInt($("input[name=totalDisAmt]").eq(index).val())));
	});

	var disAmt = 0;
	$("input[name=totalDisAmt]").each(function(index){
		disAmt += parseInt($(this).val());
	});

	$("#cpDisAmtView").html("- " + commaNum(disAmt));

    let usePoint = 0
    if ( $("#usePoint").val() != undefined  && $("#usePoint").val() != ""){
        usePoint = $("#usePoint").val().replace(/,/gi,"");
    }
    // 총금액 = 상품 금액 - 할인쿠폰 - L.Point 사용액 - 파트너 포인트 사용액
    $("#lastAmt").html(commaNum(parseInt($("input[name=totalPrdtAmt]").val()) + parseInt($("input[name=totalDlvAmt]").val()) - disAmt - $("input[name=lpointUsePoint]").val() - usePoint));
}

function fn_CpAbleCheck(cartSn) {
	var cpDisAmt   = 0;
	var cpAmt      = 0;

	$("input[name=cpDisAmt]").each(function(index){
		cpDisAmt += $(this).val();
	});

	$(".pop-coupon input[name=cpChk]").each(function(index){
		if($(this).is(":checked")) {
			cpAmt += $(".pop-coupon input[name=disAmt]").eq(index).val();
		}
	});

	$(".pop-coupon input[name=cpChk]").each(function(index){
        var prdtDiv         = $("#cartPrdtDiv" + cartSn).val();
        var cartPrdtNum     = $("#cartPrdtNum" + cartSn).val();
        var cartCorpId      = $("#cartCorpId" + cartSn).val();
        // var cpDiv           = $(".pop-coupon input[name=cpDiv]").eq(index).val();
		var prdtCtgrList    = $(".pop-coupon input[name=prdtCtgrList]").eq(index).val();
        var prdtNum         = $(".pop-coupon input[name=prdtNum]").eq(index).val();
        var corpId         = $(".pop-coupon input[name=corpId]").eq(index).val();
        var disDiv          = $(".pop-coupon input[name=disDiv]").eq(index).val();
        var aplprdtDiv      = $(".pop-coupon input[name=aplprdtDiv]").eq(index).val();
        var useYn			= $(".pop-coupon input[name=useYn]").eq(index).val();
        var cpCode			= $(".pop-coupon input[name=cpCode]").eq(index).val();
        var chkVal          = parseInt($(".pop-coupon input[name=disAmt]").eq(index).val());
        var buyMiniAmt      = parseInt($(".pop-coupon input[name=buyMiniAmt]").eq(index).val());
        var cpNm			= $(".pop-coupon input[name=cpNm]").eq(index).val();

        /**탐나는전 특별처리*/
        if("${tamnacardYn}" == "N" && cpNm.indexOf("탐나는전") >= 0  ){
            $(".pop-coupon tr").eq(index + 1).addClass('hide');
        }

		if(disDiv == "${Constant.CP_DIS_DIV_FREE}") {
			var cartOptSn = "";
			var cartOptDivSn = "";
            var cartPrdtUseNum = $("#prdtUseNum" + cartSn).val();
            var optDivSn = "";
            var optSn = "";
            var prdtUseNum = $(".pop-coupon input[name=prdtUseNum]").eq(index).val();
			
			if(prdtNum.substring(0, 2) == "${Constant.SOCIAL}" || prdtNum.substring(0, 2) == "${Constant.SV}") {
                cartOptDivSn = $("#optDivSn" + cartSn).val();
                cartOptSn = $("#optSn" + cartSn).val();
				optDivSn = $(".pop-coupon input[name=optDivSn]").eq(index).val();
                optSn = $(".pop-coupon input[name=optSn]").eq(index).val();
            }
		}
        // 적용불가 쿠폰 숨기기
        if(isNull(useYn) && !isNull(cpCode)) {      		// 코드입력쿠폰은 탐나오쿠폰내역보기에서만 입력 가능
            if(!$(this).is(":checked")) {
                $(".pop-coupon tr").eq(index + 1).addClass('hide');
            }
        } else if(disDiv == "${Constant.CP_DIS_DIV_FREE}"
            && (prdtUseNum >= cartPrdtUseNum && optSn == cartOptSn && optDivSn == cartOptDivSn) == false) {		// 무료쿠폰인데 상품수,구분번호,옵션번호 중 하나가 다른 경우
            if(!$(this).is(":checked")) {
                $(".pop-coupon tr").eq(index + 1).addClass('hide');
            }
        } else if(chkVal > parseInt($("#cartTotalAmt" + cartSn).val())
            || parseInt($("#cartTotalAmt" + cartSn).val()) < buyMiniAmt) {     // (할인금액 > 판매금액) 또는 (판매금액 < 최소구매금액)
            if(!$(this).is(":checked")) {
                $(".pop-coupon tr").eq(index + 1).addClass('hide');
            }
        } else {
            $(".pop-coupon tr").eq(index + 1).removeClass("off");
            $(".pop-coupon input[name=cpChk]").eq(index).prop("disabled", false);
        }
	});

}

function fn_CpLayer(obj, cartSn) {
    $(".pop-coupon").html("");
    $(".pop-coupon").hide();

    var parameters = "cartSn=" + cartSn;
    /*parameters += "&saleAmt=" + ($('#cartTotalAmt' + cartSn).val() - $('#cartOverAmt' + cartSn).val());*/
    parameters += "&saleAmt=" + $('#cartTotalAmt' + cartSn).val();
    parameters += "&prdtNum=" + $('#cartPrdtNum' + cartSn).val();
    parameters += "&corpId=" + $('#cartCorpId' + cartSn).val();
    parameters += "&ctgr=" + $('#cartCtgr' + cartSn).val();
    parameters += "&qty=" + $('#prdtUseNum' + cartSn).val();
    parameters += "&optNm=" + $('#cartOptNm' + cartSn).val();


    $.ajax({
        type:"post",
        url:"<c:url value='/mw/cpOptionLayer.ajax'/>",
        data:parameters,
        success:function(data){
            $(".pop-coupon").html(data);

            fn_CpAbleCheck(cartSn);

            $("input[name=useCpNum]").each(function(index, el){
                $("input[name=cpNum]").each(function(index2, el2){
                    if($(el).val() == $(el2).val()){
                        $(".pop-coupon tr").eq(index2 + 1).addClass("off");
                        $(".pop-coupon input[name=cpChk]").eq(index2).prop("disabled", true);
                    }
                });
            });

            $(".pop-coupon .btn-close").click(function(){
                $(".pop-coupon, #cover").fadeToggle();
            });

/*            $(".modal").show();*/
            // 팝업 위치 설정
            var couponBT = $("#cpTbl_" + cartSn);
            var btnTop = couponBT.offset().top;

/*            $(".pop-coupon").attr("style", "top:" + btnTop + "px;");*/
            $(".pop-coupon, #cover").fadeToggle();

            // 애니메이션 추가
            $("html, body").addClass("not_scroll");
            $('.pop-coupon').css('position', 'fixed');
            $('.pop-coupon').animate( {'top' : '20%'}, 200);
            $("body").after("<div class='lock-bg'></div>"); // 검은 불투명 배경
        },
        error:fn_AjaxError
    });
}

function fn_CpLayerOk(sn) {
	var disAmt = 0;
	var addHtml = "";

    if($(".pop-coupon input[name=cpChk]").is(":checked") == false) {
        alert("쿠폰을 선택해주세요");
        return false;
    }

	$(".pop-coupon input[name=cpChk]").each(function(index){
		if($(this).is(":checked")) {
			disAmt = parseInt($(".pop-coupon input[name=disAmt]").eq(index).val());

            addHtml += "<p class='add-ct'>";
            addHtml += $("input[name=cpNm]").eq(index).val() + " ";
            addHtml += "<strong>"+ commaNum($("input[name=disAmt]").eq(index).val()) + "</strong>원 ";
            addHtml += "<a onclick='javascript:fn_DelCp(this, " + sn + ");'><img src='/images/mw/sub/close.png' width='15' alt='닫기'></a>";
            addHtml += "<input type='hidden' name='useCpNum' value='" + $(".pop-coupon input[name=cpNum]").eq(index).val() + "' />";
            addHtml += "<input type='hidden' name='cpDisAmt' value='" + $(".pop-coupon input[name=disAmt]").eq(index).val() + "' />";
            addHtml += "<input type='hidden' name='mapSn' value='" + sn + "' />";
            addHtml += "</p>";
		}
	});

	$("#totalDisAmt" + sn).val(disAmt);
    $("#viewTotalDisAmt"+ sn).html("- " + commaNum($("#totalDisAmt" + sn).val()));

	$("#addCp" + sn).html(addHtml);

	$(".pop-coupon").html("");
	$('.pop-coupon, #cover').fadeToggle();

	fn_CalRsvAmt();

    $(".lock-bg").removeClass();
    $(".not_scroll").removeClass();

    if($("#lpointUsePopupBtn").html() == "사용 취소"){
        $("#lpointUsePopupBtn").click();
        alert("할인쿠폰금액에 따라 L.point 최대사용금액이 달라집니다. 사용하실 L.point 금액을 다시 적용해주세요.");
    }
}

function fn_CpLayerClose(obj) {
    $(obj).parents(".pop-coupon").hide();
    $(".pop-coupon").html("");

    $(obj).hide();
    $('.pop-coupon').css('top', 'auto');
    $(".lock-bg").remove();
    $(".not_scroll").removeClass();
}

function fn_DelCp(obj, sn) {
	$("#totalDisAmt" + sn).val(parseInt($("#totalDisAmt" + sn).val()) - parseInt($(obj).parent().children("input[name=cpDisAmt]").val()));
    $("#viewTotalDisAmt" + sn).html("0");
	$(obj).parent().remove();

	fn_CalRsvAmt();
}

//쿠폰 받기
let mwCouponClickTime = 0;
function fn_couponDownload(cpId, idx) {

	const currentTime = new Date().getTime();
    const timeDiff = currentTime - mwCouponClickTime;

    if (timeDiff < 500) {
        e.preventDefault();
        return;
    }

    mwCouponClickTime = currentTime;

    var parameters = "cpId=" + cpId;
    $.ajax({
        url:"<c:url value='/mw/couponDownload.ajax'/>",
        data:parameters,
        async:false,
        success:function(data){
            if(data.result == "success") {
                $("#btnCoupon" + idx).addClass("hide");
                $("#cpChk" + idx).removeClass("hide");
                $("#cpNum" + idx).val(data.cpNum);

                alert("<spring:message code='success.coupon.download'/>");
            } else if(data.result == "duplication") {
            	alert("이미 발급된 쿠폰 입니다.");
            } else {
                alert("<spring:message code='fail.coupon.download'/>");
            }
        },
        error: fn_AjaxError
    })
}

function fn_EvntCdConfirm() {
	if(isNull($("#vEvntCd").val())) {
		$("#evntCd").val("");
		$("#vEvntCd2").val("");
		itemSingleHide('#code_popup');
		$('#cover').hide();
	} else {
		var parameters = "evntCd=" + $("#vEvntCd").val();

		$.ajax({
			type:"post",
			url:"<c:url value='/web/evntCdConfirm.ajax'/>",
			data:parameters,
			success:function(data){
				if(data.result == 'Y') {
					$("#evntCd").val($("#vEvntCd").val());
					$("#vEvntCd2").val($("#vEvntCd").val());
                    itemSingleHide('#code_popup');
					$('#cover').hide();
				} else {
					$(".helper2").text("존재하지 않는 이벤트 코드 입니다.");
				}
			}
		});
	}
}

function maxLpoint(){
	let maxLpoint = 0;
    $(".goodsAmt").each(function(index){
        let comVal  = parseInt($("input[name=cartTotalAmt]").eq(index).val()) + parseInt($("input[name=dlvAmt]").eq(index).val()) - parseInt($("input[name=totalDisAmt]").eq(index).val());
        if(maxLpoint < comVal ){
            maxLpoint = comVal;
        }
    });
	$("#lpointMaxPoint").val(maxLpoint);
}

function setLocalStorage(){
	localStorage.setItem("rsvEmailSV", $("#rsvEmailSV").val());
	localStorage.setItem("r_addr", $("input[name=r_addr]:checked").val());
	localStorage.setItem("d_userAddr", $("#d_userAddr").val());
	localStorage.setItem("d_newAddr", $("#d_newAddr").val());
	localStorage.setItem("d_userAddr", $("#d_userAddr").val());
	localStorage.setItem("postNum", $("#postNum").val());
	localStorage.setItem("roadNmAddr", $("#roadNmAddr").val());
	localStorage.setItem("dtlAddr", $("#dtlAddr").val());
	localStorage.setItem("dlvRequestInf", $("#dlvRequestInf").val());
}

function getLocalStorage(){
	if(localStorage.getItem("rsvEmailSV")){
		$("#rsvEmailSV").val(localStorage.getItem("rsvEmailSV"));
	}
	if(localStorage.getItem("r_addr")){
		$('input:radio[name=r_addr]:input[value=' + localStorage.getItem("r_addr") + ']').click();
		$('input:radio[name=r_addr]:input[value=' + localStorage.getItem("r_addr") + ']').attr("checked", true);
	}
	if(localStorage.getItem("d_userAddr")){
		$("#d_userAddr").val(localStorage.getItem("d_userAddr"));
	}
	if(localStorage.getItem("d_newAddr")){
		$("#d_newAddr").val(localStorage.getItem("d_newAddr"));
	}
	if(localStorage.getItem("d_userAddr")){
		$("#d_userAddr").val(localStorage.getItem("d_userAddr"));
	}
	if(localStorage.getItem("postNum")){
		$("#postNum").val(localStorage.getItem("postNum"));
	}
	if(localStorage.getItem("roadNmAddr")){
		$("#roadNmAddr").val(localStorage.getItem("roadNmAddr"));
	}
	if(localStorage.getItem("dtlAddr")){
		$("#dtlAddr").val(localStorage.getItem("dtlAddr"));
	}
	if(localStorage.getItem("dlvRequestInf")){
		$("#dlvRequestInf").val(localStorage.getItem("dlvRequestInf"));
	}
}

/** 현재 주소가 도내인지 도외인지 */
function fnLocalAreaYn(){
	let localAreaYn = "N";
    if ('${svDirRecv}' == 'N') {
        if($("input[name=r_addr]:checked").val() == "USER"){
            if("${userVO.roadNmAddr}"){
                if($("#d_userAddr p").text().search("제주특별자치도") < 0){
                    localAreaYn = "N";
                }else{
                    localAreaYn = "Y";
                }
            }else{
                if($("#roadNmAddr").val().search("제주특별자치도") < 0){
                    localAreaYn = "N";
                }else{
                    localAreaYn = "Y";
                }
            }
        }else{
            if($("#roadNmAddr").val().search("제주특별자치도") < 0){
                localAreaYn = "N";
            }else{
                localAreaYn = "Y";
            }
        }
    }
	return localAreaYn;
}

function fnChangeLocalArea(localAreaYn){
	let param = "localAreaYn=" + localAreaYn;
	$.ajax({
		url:"<c:url value='/web/changeDlvArea.ajax'/>",
		data:param,
		success:function(){
			if(fnLocalAreaYn() != localStorage.getItem("localAreaYn") ){
				localStorage.setItem("localAreaYn", localAreaYn);
				setLocalStorage();
				if($(".add-ct").length > 0){
					alert("지역변경으로 쿠폰을 다시 적용해 주시기 바랍니다.");
				}
				location.reload();
			}else{
				setLocalStorage();
			}
		},
		error: fn_AjaxError
	});
}


$(document).ready(function(){
    $("#mnuricard").on("click", function () {
		if($(this).val() == 'N'){
			$(this).val("Y")
		}else{
			$(this).val("N")
		}
	});
    //예약하기 클릭 후 새로 고침 시 만료페이지로 보냄
    if(document.location.hash) {
        location.href = "/htmls/mw/expiration.html";
    }


    //back버튼 클릭 시 처리
    window.onpageshow = function(event) {
        if ( event.persisted || (window.performance && window.performance.navigation.type == 2)) {
            location.href = "/htmls/mw/expiration.html";
        }
    }

    element_layer = document.getElementById('layer');

	$("#chk").click(function(){
		if($(this).is(":checked")) {
			$("#useNm").val($("#rsvNm").val());
			$("#useTelnum").val($("#rsvTelnum").val());
			$("#useEmail").val($("#rsvEmail").val());
		} else {
			$("#useNm").val("");
			$("#useTelnum").val("");
			$("#useEmail").val("");
		}
	});

    // 적용가능쿠폰 체크
	$('.layer-1').each(function(){
		var cartSn = $(this).attr('cartSn');
        var parameters = "cartSn=" + cartSn + "&saleAmt=" + $('#cartTotalAmt' + cartSn).val() + "&prdtNum=" + $('#cartPrdtNum' + cartSn).val() + "&corpId=" + $('#cartCorpId' + cartSn).val() + "&ctgr=" + $('#cartCtgr' + cartSn).val() + "&qty=" + $('#prdtUseNum' + cartSn).val() + "&optNm=" + $('#cartOptNm' + cartSn).val() ;
		$.ajax({
			type:"post",
			url:"<c:url value='/mw/cpOptionLayer.ajax'/>",
			data:parameters,
			success:function(data){
				$(".pop-coupon").html(data);

				fn_CpAbleCheck(cartSn);

				if ($(".cpListTr").length != $(".cpListTr.hide").length) {
					$("#cpTbl_" + cartSn).removeClass("hide");
                    chkCouponYn += 1;
                    $("#chkCouponYn").val( parseInt($("#chkCouponYn").val()) + 1);
				}
			},
			error:fn_AjaxError
		});
	});

	$("#s_dlvRequestInf").change(function() {
		$("#dlvRequestInf").val($(this).val());
		$("#dlvTextLength").text($(this).val().length);
	});

	$("input[name=r_addr]").change(function(){
		if($(this).val() == "USER") {
			if(isNull("${userVO.roadNmAddr}")) {
				$("div.addr-wrap").css("display", "none");
				$("#postNum").val("");
				$("#roadNmAddr").val("");
				$("#dtlAddr").val("");
				$("#useNm").val("${userVO.userNm}");
				$("#useTelnum").val("${userVO.telNum}");
				$("#d_newAddr").css("display", "block");
			} else {
				$("div.addr-wrap").css("display", "none");
				$("#useNm").val("${userVO.userNm}");
				$("#useTelnum").val("${userVO.telNum}");
				$("#postNum").val("${userVO.postNum}");
				$("#roadNmAddr").val("${userVO.roadNmAddr}");
				$("#dtlAddr").val("${userVO.dtlAddr}");
				$("#d_userAddr").css("display", "block");
			}
            fnChangeLocalArea(fnLocalAreaYn());
		} else if($(this).val() == "ORDER") {
			$.ajax({
				type:"post",
				url:"<c:url value='/web/orderRecentDlv.ajax'/>",
				data:"userId=${userVO.userId}",
				success:function(data){
					$("div.addr-wrap").css("display", "none");

					if(data.dlv == null) {
						if(isNull("${userVO.roadNmAddr}")) {
							$("#postNum").val("");
							$("#roadNmAddr").val("");
							$("#dtlAddr").val("");
							$("#useNm").val("");
							$("#useTelnum").val("");
						} else {
							$("#postNum").val("${userVO.postNum}");
							$("#roadNmAddr").val("${userVO.roadNmAddr}");
							$("#dtlAddr").val("${userVO.dtlAddr}");
							$("#useNm").val("${userVO.userNm}");
							$("#useTelnum").val("${userVO.telNum}");
						}
					} else {
						$("#useNm").val(data.dlv.useNm);
						$("#useTelnum").val(data.dlv.useTelnum);
						$("#postNum").val(data.dlv.postNum);
						$("#roadNmAddr").val(data.dlv.roadNmAddr);
						$("#dtlAddr").val(data.dlv.dtlAddr);
					}
					$("#d_newAddr").css('display', 'block');
                    let jejuYn = data.dlv.roadNmAddr.search("제주특별자치도");
                    if(jejuYn < 0){
                        fnChangeLocalArea("N");
                    }else{
                        fnChangeLocalArea("Y");
                    }
				}
			});
		} else if($(this).val() == "NEW") {
			$("div.addr-wrap").css('display', 'none');
			$("#postNum").val('');
			$("#roadNmAddr").val('');
			$("#dtlAddr").val('');
			$("#useNm").val('');
			$("#useTelnum").val('');
			$("#d_newAddr").css('display', 'block');
            fnChangeLocalArea(fnLocalAreaYn());
		}
	});

	$("#dlvRequestInf").keyup(function (){
		// var textLength = strLengthCheck($(this).val());
        var textLength = $(this).val().length;
		$("#dlvTextLength").text(textLength);

        var dlvText = "";
		if(textLength > 50) {
            dlvText = $(this).val().substr(0, $(this).val().length - 1 );
			$(this).val(dlvText);
			$("#dlvTextLength").text(50);
		}
	});

	scrollTop(".rightArea", 500);

	fn_CalRsvAmt();

	$("#appDiv").val(fn_AppCheck());

	$("#point_use_close").click(function(){
		$("#point_search").hide();
        $('.comm-layer-popup').css('top', '0px');
        $(".lock-bg").remove();
        $(".not_scroll").removeClass();
    });

	$("#point_save_close").click(function(){
		$("#point_saving").hide();
        $('.comm-layer-popup').css('top', '0px');
        $(".lock-bg").remove();
        $(".not_scroll").removeClass();
    });

	// L.Point 사용 클릭 시
	$("#lpointUsePopupBtn, #lPointUsePoint").click(function(){
	    maxLpoint();

		 if($("input[name=lpointUsePoint]").val() > 0) {	// L.Point 사용 취소 시
				// L.POINT 적립 블라인드 취소
				$("#lpointSaveLockDiv").hide();
				// L.POINT 사용 Btn 타이틀 수정
				$("#lpointUsePopupBtn").html("L.POINT 조회ㆍ사용");

				$("#lPointUsePoint").val(0);
				$("#lPointAmtView").html("- " + 0);
				$("#lastAmt").html(commaNum($("input[name=totalPrdtAmt]").val()));
				$("input[name=lpointUsePoint]").val(0);

				fn_CalRsvAmt();
			} else {
				layer_popup2('#point_search');

				// 적립포인트 초기화
				$("#lpointSavePoint").val(0);
			}
    });

	// L.Point 카드번호 & 비번 체크
	$("#lPointSearchBtn").click(function(){
		var parameters = "serviceID=O100&cdno=" + $("#lPointCardU1").val() + $("#lPointCardU2").val() + $("#lPointCardU3").val() + $("#lPointCardU4").val();

		$.ajax({
			type:"post",
			url:"<c:url value='/web/actionLPoint.ajax'/>",
			data:parameters,
			success:function(data){
				if(data.lpoint.msgCn2 == "") {
					parameters = "serviceID=O720&cdno=" + $("#lPointCardU1").val() + $("#lPointCardU2").val() + $("#lPointCardU3").val() + $("#lPointCardU4").val() + "&pswd=" + $("#pswd").val();

					$.ajax({
						type:"post",
						url:"<c:url value='/web/actionLPoint.ajax'/>",
						data:parameters,
						success:function(data){
							if(data.lpoint.rspMsgCn == "SUCCESS") {
								$("#lPointBalance").val(commaNum(data.lpoint.avlPt));
								$("#lpointCardNo").val($("#lPointCardU1").val() + $("#lPointCardU2").val() + $("#lPointCardU3").val() + $("#lPointCardU4").val());
							} else {
								alert(data.lpoint.rspMsgCn);
							}
						}
					});
				} else {
					alert("조회 실패 [사유 : " + data.lpoint.msgCn2 + " ]");
				}
			}
		});
	});
	// L.Point 포인트 적용 시
	$("#lPointUseBtn").click(function(){
        /** L.Point 취대이용가능 금액 재계산*/
        if(Number($("#lpointMaxPoint").val()) < Number($("#lPointApplyUsePoint").val())){
            alert("최대사용한 L.POINT 금액은 "+ commaNum($("#lpointMaxPoint").val()) + "원 입니다.");
            return false;
        }
		var point = eval($("#lPointApplyUsePoint").val());

		if($("#lPointBalance").val() == "") {
			alert("잔액이 조회되지 않았습니다.");
			return false;
		}
		if(point == "" || point <= 0) {
			alert("사용할 금액을 입력해 주세요.");
			return false;
		}
		if(point % 10 != 0) {
			alert("사용할 금액은 10원 단위로 입력 바랍니다.");
			return false;
		}
		if(eval($("#lPointBalance").val().replace(/[^\d]+/g, "")) < point) {
			alert("사용할 금액이 잔액보다 초과되었습니다.");
			return false;
		}
		$("#lPointUsePoint").val(commaNum(point));
		$("#lPointAmtView").html("- " + $("#lPointUsePoint").val());
		$("#lastAmt").html(commaNum(parseInt($("input[name=totalPrdtAmt]").val()) - point));
		$("input[name=lpointUsePoint]").val(point);
		// L.POINT 적립 블라인드
		$("#lpointSaveLockDiv").show();
		// L.POINT 사용 Btn 타이틀 수정
		$("#lpointUsePopupBtn").html("사용 취소");

		$("#point_use_close").click();

		fn_CalRsvAmt();
	});
	// L.Point 적립 클릭 시
	$("#lpointSavePopupBtn").click(function() {
		if($("#lpointSavePoint").val() > 0) {
			// L.POINT 사용 블라인드 취소
			$("#lpointUseLockDiv").hide();
			// L.POINT 적립 Btn 타이틀 수정
			$("#lpointSavePopupBtn").html("적립하기");

			$("#lpointSavePoint").val(0);
			// $("#lPointAmtSave").html(0);
			$("#lPointAmtSavePop").html(0);
		} else {
			layer_popup2('#point_saving');
			// 사용 포인트 초기화
			$("input[name=lpointUsePoint]").val(0);
		}

	});
	// L.Point 적립 시
	$("#lPointSaveBtn").click(function(){
		var parameters = "serviceID=O100&cdno=" + $("#lPointCardS1").val() + $("#lPointCardS2").val() + $("#lPointCardS3").val() + $("#lPointCardS4").val();

		$.ajax({
			type:"post",
			url:"<c:url value='/web/actionLPoint.ajax'/>",
			data:parameters,
			success:function(data){
				if(data.lpoint.msgCn2 == '') {
					var point = parseInt(parseInt($("input[name=totalPrdtAmt]").val()) * "${Constant.LPOINT_SAVE_PERCENT}" / 100);

					$("#lpointSavePoint").val(point);
					// $("#lPointAmtSave").html(commaNum(point));
					$("#lPointAmtSavePop").html(commaNum(point));
					$("#lpointCardNo").val($("#lPointCardS1").val() + $("#lPointCardS2").val() + $("#lPointCardS3").val() + $("#lPointCardS4").val());
					// L.POINT 사용 블라인드
					$("#lpointUseLockDiv").show();
					// L.POINT 적립 Btn 타이틀 수정
					$("#lpointSavePopupBtn").html("적립취소");

					$("#point_save_close").click();
				} else {
					alert("조회 실패 [사유 : " + data.lpoint.msgCn2 + " ]");
				}
			}
		});
	});

    /** 저장된 스토리지 불러오기 특산기념품상품만 */
    if("${orderDiv}" == "${Constant.SV}"){
        getLocalStorage();
        fnChangeLocalArea(fnLocalAreaYn());
        if (self.name != 'reload') {
             if(fnLocalAreaYn() == "Y"){
                 self.name = 'reload';
                 self.location.reload(true);
             }
         }
         else self.name = '';
    }

    /** 제휴업체 포인트 사용*/
    $("#partnerUseMainBtn").click(function(){

        let disAmt = 0;
        $("input[name=totalDisAmt]").each(function(index){
            disAmt += parseInt($(this).val());
        });

        const point = parseInt($("#usePoint").val().replace(/,/gi, ""));
        const lastAmt = parseInt($("input[name=totalPrdtAmt]").val()) + parseInt($("input[name=totalDlvAmt]").val()) - disAmt;

        if (isNaN(point)) {
            setPartnerBaseAmt();
            return;
        }
        //사용포인트 > 적립포인트
        if (point > parseInt(${partnerPoint.ablePoint})) {
            setPartnerBaseAmt();
            alert("포인트를 적립 포인트 보다 많이 입력하였습니다.");
            return;
        }

        //사용포인트 > 최종결제금액
        if (point > lastAmt) {
            setPartnerBaseAmt();
            alert("최종결제금액 보다 포인트를 더 많이 입력하였습니다.");
            return;
        }

        $("#usePoint").val(commaNum(point));
        $("#partnerPointAmtView").text("- " + $("#usePoint").val());
        alert($("#usePoint").val() + "포인트를 정상적으로 사용 하셨습니다.");
        fn_CalRsvAmt();
    });

    /**파트너사 포인트 전부 사용*/
    $("#useAllPointBtn").click(function () {
        let disAmt = 0;
        $("input[name=totalDisAmt]").each(function(index){
            disAmt += parseInt($(this).val());
        });
        const lastAmt = parseInt($("input[name=totalPrdtAmt]").val()) + parseInt($("input[name=totalDlvAmt]").val()) - disAmt;
        if (lastAmt >= ${partnerPoint.ablePoint}) {
            $("#usePoint").val(${partnerPoint.ablePoint});
        }else{
            $("#usePoint").val(lastAmt);
        }
        $("#partnerUseMainBtn").click();
    });

    $("#partnerSaveMainBtn").click(function(){
        //fn_CenterPos(".couponRegPop_2");
        $.ajax({
            type   : "post",
            data   : "isMobile=Y&cssView=order",
            url    : "<c:url value='/web/point/couponRegPop.do'/>",
            success: function (data) {
                $(".couponRegPop_2").html(data);
                layer_popup2($(".couponRegPop_2"));
            },
            error  : fn_AjaxError
        });
    });

    $("#partnerPntHisBtn").click(function(){
        //fn_CenterPos(".couponRegPop_1");
        $.ajax({
            type   : "post",
            data   : "isMobile=Y&cssView=order",
            url    : "<c:url value='/web/point/pointHistoryPop.do'/>",
            success: function (data) {
                $(".couponRegPop_1").html(data);
                layer_popup2($(".couponRegPop_1"));
            },
            error  : fn_AjaxError
        });
    });

    //포인트 적용 enter 처리
    $("#usePoint").on("keyup",function(key){
        if(key.keyCode==13) {
            $("#partnerUseMainBtn").click();
        }
    });

    /** 문화누리카드 */
	if($("#cartPrdtNum1").val() == "SP00002180"){
			let mdata = "telNum=" + $("#rsvTelnum").val();
			$.ajax({
			type   : "post",
			data   : mdata,
			url    : "<c:url value='/web/daehongPreventSaleNum.ajax'/>",
			success: function (data) {
				let totalCnt = data.resultCnt + $("input[name=cartPrdtNum]").length;
				if(totalCnt > 4){
					alert("개인당 4매 이상 구매 불가능한 상품입니다. 10초 후 탐나오메인으로 이동합니다.");
					$(".applyBtn").attr("onclick","");
					$(".applyBtn").text("예약불가");
					setTimeout(function() {
						location.href = "/mw"
					}, 10000);
				}
			},
			error  : fn_AjaxError
			});
		$("input[name=cartPrdtNum]").length;
	}

});

//파트너 결제정보 초기 설정
function setPartnerBaseAmt(){
    $("#usePoint").val(0);
    $("#partnerPointAmtView").text("- 0");
    fn_CalRsvAmt();
}



// 중앙정렬
function fn_CenterPos(id){
    const left = ( $(window).scrollLeft() + ($(window).width() - $(this).width()) / 2 );
    const top = ( $(window).scrollTop() + ($(window).height() - $(this).height()) / 2 );
    $(""+id).css({"left":left, "top":top});

}

window.onload = function() {
//적용가능쿠폰이 없을 경우 할인쿠폰 hide 처리
    if ($("#chkCouponYn").val() <= 0) {
        $(".clscpDiscount").hide();
    }
};

</script>
</head>
<body>
<div id="wrap">
    <!-- 헤더 s -->
    <header id="header" class="transBG">
        <jsp:include page="/mw/head.do" >
            <jsp:param name="headTitle" value="주문"/>
        </jsp:include>
    </header>
    <!-- 헤더 e -->
    <!-- 콘텐츠 s -->
    <h2 class="sr-only">서브콘텐츠</h2>
    <section id="subContent" class="transBG">
        <div class="menu-bar">
            <p class="btn-prev"><img src="<c:url value="/images/mw/common/btn_prev.png"/>" width="20" alt="이전페이지"></p>
            <h2>
                <c:if test="${orderDiv eq Constant.SV}">구매하기</c:if>
                <c:if test="${orderDiv ne Constant.SV}">예약하기</c:if>
            </h2>
        </div>
        <input type="hidden" name="chkCouponYn" id="chkCouponYn" value="0" > <!--쿠폰할인 text 제어용-->
        <div class="sub-content">
            <form name="rsvInfo" id="rsvInfo" onSubmit="return false;" accept-charset="UTF-8">
                <input type="hidden" name="rsvDiv" value="${rsvDiv}">
                <input type="hidden" name="appDiv" id="appDiv">
                <input type="hidden" name="flowPath" id="flowPath" value="${flowPath}">
                <input type="hidden" name="lpointCardNo" id="lpointCardNo" value="">
                <input type="hidden" name="lpointSavePoint" id="lpointSavePoint" value="0">
                <input type="hidden" id="lpointMaxPoint" value="0">
                <div class="reserve">
                    <c:set var="totalPrdtAmt" value="0" />
                    <c:set var="totalDlvAmt" value="0" />
                    <c:set var="sv_dlvAmtDiv" value="NULL" />
                    <c:set var="sv_corpId" value="NULL" />
                    <c:set var="sv_prdc" value="NULL"/>

                    <c:forEach var="cart" items="${orderList}" varStatus="status">
                        <dl class="goods-info" <c:if test="${status.count > 1}">class="bt-none"</c:if>>
                            <input type="hidden" name="cartSn" value="${cart.cartSn}">
                            <c:set var="totalPrdtAmt" value="${totalPrdtAmt + cart.totalAmt}" />
                            <c:set var="category" value="${fn:substring(cart.prdtNum, 0, 2)}" />

                            <c:choose>
                                <c:when test="${category eq Constant.ACCOMMODATION}">
                                    <input type="hidden" name="cartPrdtDiv" id="cartPrdtDiv${cart.cartSn}" value="${Constant.ACCOMMODATION}">
                                    <input type="hidden" name="cartPrdtNum" id="cartPrdtNum${cart.cartSn}" value="${cart.prdtNum}">
                                    <input type="hidden" name="cartCorpId" id="cartCorpId${cart.cartSn}" value="${cart.corpId}">
                                    <input type="hidden" name="cartSaleAmt" id="cartSaleAmt${cart.cartSn}" value="${cart.addAmt}">
                                    <input type="hidden" name="cartOverAmt" id="cartOverAmt${cart.cartSn}" value="${cart.adOverAmt}">
                                    <input type="hidden" name="prdtUseNum" id="prdtUseNum${cart.cartSn}" value="${cart.night}">
                                    <input type="hidden" name="cartCtgr" id="cartCtgr${cart.cartSn}" value="${cart.ctgr}">
                                    <input type="hidden" name="cartOptNm" id="cartOptNm${cart.cartSn}" value="${cart.optNm}">
                                    <dt><strong>[${cart.corpNm}]</strong><br>${cart.prdtNm}</dt>
                                    <dd>
                                        <fmt:parseDate var="fromDttm" value="${cart.startDt}" pattern="yyyyMMdd" scope="page"/>
                                        <span><fmt:formatDate value="${fromDttm}" pattern="yyyy-MM-dd"/> 부터 ${cart.night}박</span>
                                        <br>
                                        <span>성인 ${cart.adultCnt}명, 소아 ${cart.juniorCnt}명, 유아 ${cart.childCnt}명</span>

                                        <table class="coupon-wrap public hide " id="cpTbl_${cart.cartSn}">
                                            <tr>
                                                <td class="tBT">
                                                    <c:if test="${isGuest == 'N' && (ssPartnerCode eq '' || pointCpVO.eventCouponYn eq 'Y')}">
                                                        <a class="layer-1" onclick="fn_CpLayer(this, '${cart.cartSn}')" cartSn="${cart.cartSn}">
                                                            <span class="couponBT"><em>%</em> 할인쿠폰 선택하기</span>
                                                        </a>
                                                    </c:if>
                                                </td>
                                                <td class="add" id="addCp${cart.cartSn}">
                                                </td>
                                            </tr>
                                        </table>
                                    </dd>
                                </c:when>
                                <c:when test="${category eq Constant.RENTCAR}">
                                    <fmt:parseDate var="fromDttm" value="${cart.fromDt}${cart.fromTm}" pattern="yyyyMMddHHmm" scope="page"/>
                                    <fmt:parseDate var="toDttm" value="${cart.toDt}${cart.toTm}" pattern="yyyyMMddHHmm" scope="page"/>
                                    <input type="hidden" name="cartPrdtDiv" id="cartPrdtDiv${cart.cartSn}" value="${Constant.RENTCAR}">
                                    <input type="hidden" name="cartPrdtNum" id="cartPrdtNum${cart.cartSn}" value="${cart.prdtNum}">
                                    <input type="hidden" name="cartCorpId" id="cartCorpId${cart.cartSn}" value="${cart.corpId}">
                                    <input type="hidden" name="cartOverAmt" id="cartOverAmt${cart.cartSn}" value="0">

                                    <fmt:parseNumber var="startDateTime" value="${fromDttm.time / (1000 * 3600) }" integerOnly="true" />
                                    <fmt:parseNumber var="endDateTime" value="${toDttm.time / (1000 * 3600) }" integerOnly="true" />
                                    <input type="hidden" name="prdtUseNum" id="prdtUseNum${cart.cartSn}" value="${endDateTime - startDateTime}">
                                    <input type="hidden" name="cartCtgr" id="cartCtgr${cart.cartSn}" value="${cart.ctgr}">
                                    <input type="hidden" name="cartOptNm" id="cartOptNm${cart.cartSn}" value="${cart.optNm}">

                                    <c:set var="prdtNms" value="${fn:split(cart.prdtNm, '/')}" />
                                    <dt><strong>[${cart.corpNm}]</strong><br>${prdtNms[0]}</dt>
                                    <dd>
                                        <span>${prdtNms[1]} | ${prdtNms[2]}</span>
                                        <br>
                                        <span><fmt:formatDate value="${fromDttm}" pattern="yyyy-MM-dd HH:mm"/> ~ <fmt:formatDate value="${toDttm}" pattern="yyyy-MM-dd HH:mm"/></span>

                                        <table class="coupon-wrap public hide" id="cpTbl_${cart.cartSn}">
                                            <tr>
                                                <td class="tBT">
                                                    <c:if test="${isGuest == 'N' && (ssPartnerCode eq '' || pointCpVO.eventCouponYn eq 'Y')}">
                                                        <a class="layer-1" onclick="javascript:fn_CpLayer(this, '${cart.cartSn}');" cartSn="${cart.cartSn}">
                                                            <span class="couponBT"><em>%</em> 할인쿠폰 선택하기</span>
                                                        </a>
                                                    </c:if>
                                                </td>
                                                <td class="add" id="addCp${cart.cartSn}">
                                                </td>
                                            </tr>
                                        </table>
                                    </dd>
                                </c:when>
                                <c:when test="${category eq Constant.SOCIAL}">
                                    <input type="hidden" name="cartPrdtDiv" id="cartPrdtDiv${cart.cartSn}" value="${Constant.SOCIAL}">
                                    <input type="hidden" name="cartPrdtNum" id="cartPrdtNum${cart.cartSn}" value="${cart.prdtNum}">
                                    <input type="hidden" name="cartCorpId" id="cartCorpId${cart.cartSn}" value="${cart.corpId}">
                                    <input type="hidden" name="cartOverAmt" id="cartOverAmt${cart.cartSn}" value="0">
                                    <input type="hidden" name="prdtUseNum" id="prdtUseNum${cart.cartSn}" value="${cart.qty}">
                                    <input type="hidden" name="optDivSn" id="optDivSn${cart.cartSn}" value="${cart.spDivSn}">
                                    <input type="hidden" name="optSn" id="optSn${cart.cartSn}" value="${cart.spOptSn}">
                                    <input type="hidden" name="cartCtgr" id="cartCtgr${cart.cartSn}" value="${cart.ctgr}">
                                    <input type="hidden" name="cartOptNm" id="cartOptNm${cart.cartSn}" value="${cart.optNm}">

                                    <dt><strong>[${cart.corpNm}]</strong><br>${cart.prdtNm}</dt>
                                    <dd>
                                        <span>${cart.prdtDivNm}</span>
                                        <c:if test="${not empty cart.aplDt}">
                                            <fmt:parseDate var="aplDt" value="${cart.fromDt}${cart.aplDt}" pattern="yyyyMMdd" scope="page"/>
                                            <span> | <fmt:formatDate value="${aplDt}" pattern="yyyy-MM-dd"/></span>
                                        </c:if>
                                        <span> | ${cart.optNm}</span>
                                        <c:if test="${not empty cart.addOptNm}">
                                            <span> | ${cart.addOptNm}</span>
                                        </c:if>
                                        <br>
                                        <span>수량 : ${cart.qty}</span>

                                        <table class="coupon-wrap public hide" id="cpTbl_${cart.cartSn}">
                                            <tr>
                                                <td class="tBT">
                                                    <c:if test="${isGuest == 'N' && (ssPartnerCode eq '' || pointCpVO.eventCouponYn eq 'Y')}">
                                                        <a class="layer-1" onclick="javascript:fn_CpLayer(this, '${cart.cartSn}')" cartSn="${cart.cartSn}">
                                                            <span class="couponBT"><em>%</em> 할인쿠폰 선택하기</span>
                                                        </a>
                                                    </c:if>
                                                </td>
                                                <td class="add" id="addCp${cart.cartSn}">
                                                </td>
                                            </tr>
                                        </table>
                                    </dd>
                                </c:when>
                                <c:when test="${category eq Constant.SV}">
                                    <input type="hidden" name="cartPrdtDiv" id="cartPrdtDiv${cart.cartSn}" value="${Constant.SV}">
                                    <input type="hidden" name="cartPrdtNum" id="cartPrdtNum${cart.cartSn}" value="${cart.prdtNum}">
                                    <input type="hidden" name="cartCorpId" id="cartCorpId${cart.cartSn}" value="${cart.corpId}">
                                    <input type="hidden" name="cartOverAmt" id="cartOverAmt${cart.cartSn}" value="0">
                                    <input type="hidden" name="prdtUseNum" id="prdtUseNum${cart.cartSn}" value="${cart.qty}">
                                    <input type="hidden" name="optDivSn" id="optDivSn${cart.cartSn}" value="${cart.svDivSn}">
                                    <input type="hidden" name="optSn" id="optSn${cart.cartSn}" value="${cart.svOptSn}">
                                    <input type="hidden" name="cartCtgr" id="cartCtgr${cart.cartSn}" value="${cart.ctgr}">
                                    <input type="hidden" name="cartOptNm" id="cartOptNm${cart.cartSn}" value="${cart.optNm}">

                                    <dt><strong>[${cart.corpNm}]</strong><br>${cart.prdtNm}</dt>
                                    <dd>
                                        <span>${cart.prdtDivNm} | ${cart.optNm} <c:if test="${not empty cart.addOptNm}"> | ${cart.addOptNm}</c:if></span>
                                        <br>
                                        <span>수량 : ${cart.qty}</span>
                                        <table class="coupon-wrap public hide" id="cpTbl_${cart.cartSn}">
                                            <tr>
                                                <td class="tBT">
                                                    <c:if test="${isGuest == 'N' && (ssPartnerCode eq '' || pointCpVO.eventCouponYn eq 'Y')}">
                                                        <a class="layer-1" onclick="javascript:fn_CpLayer(this, '${cart.cartSn}');" cartSn="${cart.cartSn}">
                                                            <span class="couponBT"><em>%</em> 할인쿠폰 선택하기</span>
                                                        </a>
                                                    </c:if>
                                                </td>
                                                <td class="add" id="addCp${cart.cartSn}">
                                                </td>
                                            </tr>
                                        </table>
                                    </dd>
                                </c:when>
                            </c:choose>
                        </dl>
                        <c:if test="${orderDiv ne Constant.SV}">
                            <dl class="goods-price line">
                                <input type="hidden" name="cartTotalAmt" id="cartTotalAmt${cart.cartSn}" value="${cart.totalAmt}">
                                <input type="hidden" name="totalDisAmt" id="totalDisAmt${cart.cartSn}" value="0">
                                <input type="hidden" name="dlvAmt" value="0">

                                <dt>
                                    <p>상품금액</p>
                                    <p class="clscpDiscount">쿠폰할인</p>
                                </dt>
                                <dd>
                                    <p><fmt:formatNumber><c:out value="${cart.totalAmt}"/></fmt:formatNumber>원</p>
                                    <p class="clscpDiscount"><span class="text-red" id="viewTotalDisAmt${cart.cartSn}">0</span></p>
                                </dd>
                                <dt>최종금액</dt>
                                <dd><span class="goodsAmt text-red">0</span>원</dd>
                            </dl>
                        </c:if>
                        <c:if test="${orderDiv eq Constant.SV}">
                            <c:set var="sv_dlvAmt" value="0" />
                            <dl class="goods-price line">
                                <input type="hidden" name="cartTotalAmt" id="cartTotalAmt${cart.cartSn}" value="${cart.totalAmt}">
                                <input type="hidden" name="totalDisAmt" id="totalDisAmt${cart.cartSn}" value="0">
                                <dt>
                                    <p>상품금액</p>
                                    <p class="clscpDiscount">쿠폰할인</p>
                                    <p>배송비</p>
                                </dt>
                                <dd>
                                    <p><fmt:formatNumber><c:out value="${cart.totalAmt}"/></fmt:formatNumber>원</p>
                                    <p class="clscpDiscount"><span class="text-red" id="viewTotalDisAmt${cart.cartSn}">0</span></p>
                                    <p>
                                        <%--생산자별 묶음배송으로 로직 변경 (prdc 조건 추가) 2021.06.03 chaewan.jung --%>
                                        <c:if test="${(cart.corpId ne sv_corpId) or ((cart.corpId eq sv_corpId) and ((cart.dlvAmtDiv ne sv_dlvAmtDiv) or (cart.directRecvYn ne sv_directRecvYn) or (cart.prdc ne sv_prdc) )) or (cart.dlvAmtDiv eq Constant.DLV_AMT_DIV_MAXI)}">
                                            <c:set var="c_SaleAmt" value="0" />

                                            <c:if test="${(cart.dlvAmtDiv eq Constant.DLV_AMT_DIV_APL) or (cart.dlvAmtDiv eq Constant.DLV_AMT_DIV_FREE) or (cart.dlvAmtDiv eq Constant.DLV_AMT_DIV_DLV)}">
                                                <c:forEach var="sub_cart" items="${orderList}" varStatus="sub_status">
                                                    <c:if test="${(fn:substring(sub_cart.prdtNum, 0, 2) eq Constant.SV) and (sub_cart.corpId eq cart.corpId) and (sub_cart.dlvAmtDiv eq cart.dlvAmtDiv) and (sub_cart.directRecvYn eq cart.directRecvYn) and (sub_cart.prdc eq cart.prdc)}">
                                                        <c:set var="c_SaleAmt" value="${c_SaleAmt + sub_cart.totalAmt}" />
                                                    </c:if>
                                                </c:forEach>
                                            </c:if>

                                            <c:choose>
                                                <c:when test="${cart.directRecvYn == 'Y'}">
                                                    <c:set var="sv_dlvAmt" value="0" />
                                                    무료(직접수령)
                                                </c:when>
                                                <c:when test="${cart.dlvAmtDiv eq Constant.DLV_AMT_DIV_DLV}">
                                                    <c:set var="sv_dlvAmt" value="${cart.dlvAmt}" />
                                                    <fmt:formatNumber>${sv_dlvAmt}</fmt:formatNumber>원
                                                </c:when>
                                                <c:when test="${cart.dlvAmtDiv eq Constant.DLV_AMT_DIV_APL}">
                                                    <c:if test="${cart.aplAmt <= c_SaleAmt}">
                                                        <c:set var="sv_dlvAmt" value="0" />
                                                        무료
                                                    </c:if>
                                                    <c:if test="${cart.aplAmt > c_SaleAmt}">
                                                        <c:set var="sv_dlvAmt" value="${cart.dlvAmt}" />
                                                        <fmt:formatNumber>${sv_dlvAmt}</fmt:formatNumber>원
                                                    </c:if>
                                                </c:when>
                                                <c:when test="${cart.dlvAmtDiv eq Constant.DLV_AMT_DIV_MAXI}">
                                                    <c:set var="sv_dlvAmt" value="${cart.dlvAmt}" />
                                                    <fmt:formatNumber>${sv_dlvAmt}</fmt:formatNumber>원
                                                </c:when>
                                                <c:when test="${cart.dlvAmtDiv eq Constant.DLV_AMT_DIV_FREE}">
                                                    <c:set var="sv_dlvAmt" value="0" />
                                                    무료
                                                </c:when>
                                            </c:choose>
                                        </c:if>
                                        <c:if test="${(cart.corpId eq sv_corpId) and (cart.dlvAmtDiv eq sv_dlvAmtDiv) and (cart.directRecvYn eq sv_directRecvYn) and (cart.prdc eq sv_prdc) and (cart.dlvAmtDiv ne Constant.DLV_AMT_DIV_MAXI)}">
                                            (묶음상품)
                                        </c:if>
                                    </p>
                                    <input type="hidden" name="dlvAmt" value="${sv_dlvAmt}">
                                </dd>
                                <dt>최종금액</dt>
                                <dd><span class="goodsAmt text-red">0</span>원</dd>
                            </dl>
                            <c:set var="totalDlvAmt" value="${totalDlvAmt + sv_dlvAmt}" />
                            <c:set var="sv_corpId" value="${cart.corpId}" />
                            <c:set var="sv_dlvAmtDiv" value="${cart.dlvAmtDiv}" />
                            <c:set var="sv_directRecvYn" value="${cart.directRecvYn}" />
                            <c:set var="sv_prdc" value="${cart.prdc}"/>
                        </c:if>
                    </c:forEach>

                    <c:if test="${orderDiv ne Constant.SV}">
                        <%--<c:set var="loop_flag" value="false" />
                        <c:forEach var="cart" items="${orderList}" varStatus="status">
                        <c:if test="${not loop_flag }">
                            <c:if test="${cart.prdtNum eq 'SP00002180' }">
                                <c:set var="loop_flag" value="true" />
                            <div>
                                <p>
                                    <label for="mnuricard">
                                    <span class="couponBT" style="background:royalblue;display: inline-block;background: royalblue;color: #fff;font-size: 0.8rem;padding: 10px;min-width: 70px;text-align: center;border-radius: 4px;">
                                        문화누리카드 결제 &nbsp;&nbsp;<input type="checkbox" name="mnuricard" id="mnuricard" value="N">
                                    </span>
                                    </label>
                                    <span style="font-size: 11px;color: royalblue"> * 문화누리카드 소지자에 한해 좌측 버튼 체크▷하단 '예약확인' 클릭 후 결제</span>
                                </p>
                            </div>
                            </c:if>
                        </c:if>
                        </c:forEach>--%>
                        <h2>예약자정보</h2>
                        <table class="bt-none">
                            <tr>
                                <th><label for="rsvNm">예약자명</label></th>
                                <td>
                                    <input type="text" name="rsvNm" id="rsvNm" class="full" value="${userVO.userNm}" >
                                </td>
                            </tr>
                            <tr>
                                <th><label for="rsvEmail">이메일</label></th>
                                <td>
                                    <input type="text" name="rsvEmail" id="rsvEmail" class="full" value="${userVO.email}" <c:if test="${isGuest == 'N'}"></c:if> placeholder="이메일을 입력하세요">
                                </td>
                            </tr>
                            <tr>
                                <th><label for="rsvTelnum">휴대폰</label></th>
                                <td>
                                    <input type="text" name="rsvTelnum" id="rsvTelnum" class="full" value="${userVO.telNum}" onKeyup="addHyphenToPhone(this);" maxlength="13">
                                </td>
                            </tr>
                        </table>
                        <div class="check_bg">
                            <p class="check"><input type="checkbox" id="chk"><label for="chk">사용자가 예약자와 동일한 경우 체크해주세요</label></p>
                            <p class="check"><input type="checkbox" id="chkUserSmsYn"><label for="chkUserSmsYn">사용자에게 문자보내기</label></p>
                            <input type="hidden" name="userSmsYn" id="userSmsYn" value="N">
                        </div>

                        <h2>사용자 정보</h2>
                        <table class="bt-none">
                            <tr>
                                <th><label for="useNm">예약자명</label></th>
                                <td><input type="text" name="useNm" id="useNm" class="full"></td>
                            </tr>
                            <tr>
                                <th><label for="useEmail">이메일</label></th>
                                <td>
                                    <input type="text" name="useEmail" id="useEmail" class="full">
                                </td>
                            </tr>
                            <tr>
                                <th><label for="useTelnum">휴대폰</label></th>
                                <td>
                                    <input type="text" name="useTelnum" id="useTelnum" class="full" onKeyup="addHyphenToPhone(this);" maxlength="13">
                                </td>
                            </tr>
                        </table>

                    </c:if>

                    <c:if test="${orderDiv eq Constant.SV}">
                        <h2>구매자 정보</h2>
                        <table class="bt-none">
                            <tr>
                                <th><label for="rsvNm">이름</label></th>
                                <td>
                                    <input type="text" name="rsvNm" id="rsvNmSV" class="full" value="${userVO.userNm}" >
                                </td>
                            </tr>
                            <tr>
                                <th><label for="rsvEmail">이메일</label></th>
                                <td>
                                    <input type="text" name="rsvEmail" id="rsvEmailSV" class="full" value="${userVO.email}" <c:if test="${isGuest == 'N'}"> </c:if> placeholder="이메일을 입력하세요">
                                </td>
                            </tr>
                            <tr>
                                <th><label for="rsvTelnum">휴대폰</label></th>
                                <td>
                                    <input type="text" name="rsvTelnum" id="rsvTelnumSV" class="full" value="${userVO.telNum}" onKeyup="addHyphenToPhone(this);" maxlength="13">
                                </td>
                            </tr>
                        </table>

                        <c:if test="${svDirRecv == 'N'}">
                            <h2>배송지 정보</h2>
                            <table class="bt-none deli-address">
                                <colgroup>
                                    <col width="23%">
                                    <col width="*">
                                </colgroup>
                                <tr>
                                    <th><label>배송지<br>선택</label></th>
                                    <td>
                                        <input type="radio" name="r_addr" value="USER" id="address1">
                                        <label for ="address1"><span>기본</span></label>
                                        <input type="radio" name="r_addr" value="ORDER" id="address2">
                                        <label for ="address2"><span>최근 배송지</span></label>
                                        <input type="radio" name="r_addr" value="NEW" id="address3">
                                        <label for="address3"><span>새로 입력</span></label>
                                    </td>
                                </tr>
                                <tr>
                                    <th><label for="useNm">이름</label></th>
                                    <td><input type="text" name="useNm" id="useNmSV" class="full" value="${userVO.userNm}"></td>
                                </tr>
                                <tr>
                                    <th><label for="useTelnum">휴대폰</label></th>
                                    <td><input type="text" name="useTelnum" id="useTelnumSV" class="full" value="${userVO.telNum}" onKeyup="addHyphenToPhone(this);" maxlength="13"></td>
                                </tr>
                                <tr>
                                    <th>배송지<br>주소</th>
                                    <td>
                                        <!-- 기본 -->
                                        <c:if test="${not empty userVO.roadNmAddr}">
                                            <div class="addr-wrap" id="d_userAddr">
                                                <p class="load">(${userVO.postNum}) ${userVO.roadNmAddr} ${userVO.dtlAddr}</p>
                                            </div>
                                        </c:if>
                                        <!-- 신규 -->
                                        <div class="addr-wrap" id="d_newAddr" <c:if test="${not empty userVO.roadNmAddr}"> style="display:none"</c:if>>
                                            <input type="text" name="postNum" id="postNum" class="addr0" title="우편번호" readonly value="${userVO.postNum}">
                                            <a href="javascript:void(0)" onclick="sample2_execDaumPostcode();" class="btn">우편번호검색</a>
                                            <input type="text" name="roadNmAddr" id="roadNmAddr" class="addr1" title="기본주소 입력" readonly value="${userVO.roadNmAddr}">
                                            <input type="text" name="dtlAddr" id="dtlAddr" class="addr2" title="상세주소 입력" value="${userVO.dtlAddr}">
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th><label>배송시<br>요청사항</label></th>
                                    <td>
                                        <div class="requests">
                                            <select title="요청사항 선택" id="s_dlvRequestInf">
                                                <option value="">배송시 요청사항을 선택해주세요.</option>
                                                <option value="배송 전 연락 바랍니다.">배송 전 연락 바랍니다.</option>
                                                <option value="부재시 전화 주세요.">부재시 전화 주세요.</option>
                                                <option value="부재시 경비실에 맡겨주세요.">부재시 경비실에 맡겨주세요.</option>
                                                <option value="부재시 집 앞에 놔주세요.">부재시 집 앞에 놔주세요.</option>
                                                <option value="택배함에 놔주세요.">택배함에 놔주세요.</option>
                                            </select>
                                            <div class="memo">
                                                <textarea rows="4" name="dlvRequestInf" id="dlvRequestInf" placeholder="기타내용을 입력해주세요"></textarea>
                                                <span>(<strong id="dlvTextLength">0</strong>/50자)</span>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </c:if>
                    </c:if>
                    <c:if test="${pointCpVO.partnerCode eq null}">
                    <table class="bt-none">
                        <h2>제휴 할인</h2>
                        <tbody>
                            <tr>
                                <th>L.POINT<br>사용</th>
                                <td>
                                    <div class="l-point-search">
                                        <input type="hidden" name="lpointUsePoint" value="0" />
                                        <input type="text" id="lPointUsePoint" class="disabled" readonly>
                                        <%--<button type="button" class="btn btn6" id="lpointUsePopupBtn">L.POINT 조회</button>--%>
                                        <a href="javascript:void(0)" class="btn btn6" id="lpointUsePopupBtn">조회ㆍ사용</a>
                                        <div class="button-lock" id="lpointUseLockDiv" style="display:none"></div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>L.POINT<br>적립</th>
                                <td>
                                    <div class="l-point-search">
                                        <span class="value-point"><span id="lPointAmtSavePop">0</span> P 적립예정</span>
                                        <%--<button type="button" class="btn btn6" id="lpointSavePopupBtn">L.POINT 적립</button>--%>
                                        <a href="javascript:void(0)" id="lpointSavePopupBtn" class="btn btn6">적립하기</a>
                                        <div id="lpointSaveLockDiv" class="button-lock" style="display:none"></div>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="caption-typeC text-red">(L.POINT는 사용과 적립 중에 하나의 서비스만 이용 가능)</div>
                    <!-- 조회/사용 팝업 -->
                    <div id="point_search" class="comm-layer-popup point-search faq-popup">
                        <div class="content-wrap">
                            <div class="content">
                                <div class="head">
                                    <h3 class="title">L.POINT 조회/사용</h3>
                                    <button type="button" id="point_use_close" class="popup_close">
                                        <img src="<c:url value="/images/mw/icon/close/dark-gray.png"/>" alt="닫기" onclick="itemSingleHide('.faq-popup');">
                                    </button>
                                </div>
                                <div class="main">
                                    <table class="table-row">
                                        <caption>포인트 조회 항목</caption>
                                        <colgroup>
                                            <col style="width: 25%">
                                            <col>
                                        </colgroup>
                                        <tbody>
                                        <tr>
                                            <th>카드번호</th>
                                            <td>
                                                <div class="input-col4">
                                                    <input type="text" id="lPointCardU1" value="">
                                                    <input type="text" id="lPointCardU2" value="">
                                                    <input type="password" id="lPointCardU3" value="">
                                                    <input type="password" id="lPointCardU4" value="">
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>L.POINT 비밀번호</th>
                                            <td>
                                                <div class="input-btn-col2">
                                                    <input type="password" name="lpointCardPw" id="pswd" value="">
                                                    <button type="button" id="lPointSearchBtn" class="btn btn6">조회</button>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>잔액</th>
                                            <td>
                                                <input type="text" id="lPointBalance" class="full" disabled>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>사용할 금액</th>
                                            <td>
                                                <div class="input-btn-col2">
                                                    <input type="text" id="lPointApplyUsePoint" value="0">
                                                    <button type="button" id="lPointUseBtn" class="btn btn4">사용하기</button>
                                                </div>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                    <div class="popup-area-list">
                                        <ul class="list-disc">
                                            <li>카드번호와 L.POINT 비밀번호를 정확히 입력해야 잔액 확인이 가능합니다.</li>
                                            <li>L.POINT는 10원 단위로 사용이 가능하며, 단일상품의 최대결제금액 내에서 사용 가능합니다.</li>
                                            <li> 'L.POINT 비밀번호'는 온라인에서 포인트를 사용하기 위해 설정된 비밀번호로, 숫자 6자리입니다. L.POINT Web/App 로그인 시 입력하는 비밀번호와는 별도의 비밀번호이며, L.POINT Web/App에서 언제든 간단하게 재설정하실 수 있습니다.</li>
                                            <!-- <li>L.POINT 비밀번호는 영문 및 숫자 혼합 6~8자리 입니다.</li> -->
                                            <li>5회 이상 비밀번호 입력 오류 시 새로운 비밀번호를 등록하셔야 합니다.</li>
                                            <!-- <li>L.POINT 적립은 PC와 모바일 모두 가능합니다.</li> -->
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div> <!--//layer-popup-->

                    <!-- 적립 팝업 -->
                    <div id="point_saving" class="comm-layer-popup point-saving faq-popup">
                        <div class="content-wrap">
                            <div class="content">
                                <div class="head">
                                    <h3 class="title">L.POINT 적립</h3>
                                    <button type="button" id="point_save_close" class="popup_close">
                                        <img src="/images/mw/icon/close/dark-gray.png" alt="닫기" onclick="itemSingleHide('.faq-popup');">
                                    </button>
                                </div>
                                <div class="main">
                                    <table class="table-row">
                                        <caption>포인트 조회 항목</caption>
                                        <colgroup>
                                            <col style="width: 25%">
                                            <col>
                                        </colgroup>
                                        <tbody>
                                        <tr>
                                            <th>카드번호</th>
                                            <td>
                                                <div class="input-col4-btn">
                                                    <input type="text" id="lPointCardS1" value="">
                                                    <input type="text" id="lPointCardS2" value="">
                                                    <input type="password" id="lPointCardS3" value="">
                                                    <input type="password" id="lPointCardS4" value="">

                                                    <button type="button" id="lPointSaveBtn" class="btn btn4">확인</button>
                                                </div>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                    <div class="popup-area-list">
                                        <ul class="list-disc">
                                            <li>적립 시점<br>
                                                - 관광상품 : 숙박, 렌터카, 쿠폰 등 이용 완료 후 10일 뒤 적립<br>
                                                - 특산/기념품 : 제품을 수령하고 '구매확정' 클릭 후 10일 뒤 적립
                                            </li>
                                            <li>카드번호가 잘못 입력된 경우 적립이 불가능 하오니 정확히 입력해주세요.</li>
                                            <li>L.POINT 적립은 신청한 건에 한해 적립이 가능하며 추후 적립은 불가 합니다.</li>
                                            <li>이벤트코드, 할인쿠폰 등 각종 할인 수단을 제외한 실제 결제금액의 ${Constant.LPOINT_SAVE_PERCENT}%가 적립됩니다.</li>
                                            <!-- <li>L.POINT 적립은 PC와 모바일앱에서만 가능합니다.</li> -->
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div> <!--//layer-popup-->
                    </c:if>
                    <!-- 파트너(협력사) 포인트 -->
                    <c:if test="${pointCpVO.partnerCode ne null}">
                        <input type="hidden" name="lpointUsePoint" value="0" />
                        <input type="hidden" class="full" id="lPointBalance" disabled value="0">
                        <h2>${pointCpVO.partnerNm} 포인트</h2>
                        <table class="bt-none">
                            <colgroup>
                                <col width="23%">
                                <col width="*">
                            </colgroup>
                            <tbody>
                            <tr>
                                <th>포인트<br>사용</th>
                                <td>
                                    <div class="l-point-search butler-point">

                                        <a class="value-point exposure-point" id="partnerPntHisBtn" href="javascript:void(0)">
                                            <span id="partnerAmtSave"><fmt:formatNumber value="${partnerPoint.ablePoint}" type="number"/></span>
                                            <span class="possible">P 사용가능</span>
                                        </a>
                                        <input type="text" id="usePoint" name="usePoint" >
                                        <div class="point-control">
                                            <button type="button" class="comm-btn" id="partnerUseMainBtn">적용</button>
                                            <button type="button" class="comm-btn" id="useAllPointBtn">전부 사용</button>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>포인트<br>등록</th>
                                <td>
                                    <div class="l-point-search butler-point">
                                        <c:if test="${isGuest eq 'N'}"><a class="comm-btn" id="partnerSaveMainBtn" href="javascript:void(0)" onfocus="this.blur()">등록하기</a></c:if>
                                        <div id="partnerUseLockDiv" class="button-lock" style="display:none"></div>
                                    </div>
                                </td>
                            </tr>
                            </tbody>
                        </table>

                        <!-- 포인트 내역 / 레이어팝업 -->
                        <div class="couponRegPop_1 pop-seller"></div>

                        <!-- 쿠폰등록 / 레이어팝업 -->
                        <div class="couponRegPop_2 pop-seller2"></div>
                    </c:if>

                    <!-- 이벤트 코드 -->
                    <c:if test="${pointCpVO.partnerCode eq null}">
                    <h2>이벤트 코드</h2>
                    <table class="bt-none">
                        <colgroup>
                            <col width="23%">
                            <col width="*">
                        </colgroup>
                        <tr>
                            <th>코드번호</th>
                            <td>
                                <div class="event-code">
                                    <input type="text" name="vEvntCd2" id="vEvntCd2" class="disabled" size="20" disabled="disabled">
                                    <input type="hidden" name="evntCd" id="evntCd" />
                                    <a href="javascript:show_popup('#code_popup');fn_resizeHeight();$('#cover').show();" class="btn btn6 add_bg">조회</a>
                                </div> <!--//event-code-->
                            </td>
                        </tr>
                    </table>
                    </c:if>
                    <!-- //이벤트 코드 -->

                    <h2>결제정보</h2>
                    <dl class="total bt-none">
                        <dt>총 상품금액</dt>
                        <dd>
                            <input type="hidden" name="totalDlvAmt" value="${totalDlvAmt}" >
                            <input type="hidden" name="totalPrdtAmt" value="${totalPrdtAmt}" >

                            <strong><fmt:formatNumber><c:out value="${totalPrdtAmt}"/></fmt:formatNumber></strong>원
                            <p>쿠폰할인 <span class="text-red" id="cpDisAmtView">- 0</span>원</p>
                            <c:if test="${pointCpVO.partnerCode eq null}">
                            <p>L.POINT 사용	<span class="text-red" id="lPointAmtView">- 0</span> P</p>
                            </c:if>
                            <c:if test="${pointCpVO.partnerCode ne null}">
                                <p>${pointCpVO.partnerNm} 포인트 사용 <span class="text-red" id="partnerPointAmtView">- 0</span> P</p>
                            </c:if>
                            <%--<p>L.POINT 적립 <span id="lPointAmtSave">0</span>P</p>--%>
                            <c:if test="${orderDiv eq Constant.SV }">
                                <p>총 배송비 + <fmt:formatNumber>${totalDlvAmt}</fmt:formatNumber>원</p>
                            </c:if>
                        </dd>
                    </dl>
                    <dl class="total bt-none">
                        <dt>최종결제금액</dt>
                        <dd>
                            <strong class="red" id="lastAmt"><fmt:formatNumber><c:out value="${totalPrdtAmt}"/></fmt:formatNumber></strong>원<br>
                        </dd>
                    </dl>
                    <c:if test="${orderDiv ne Constant.SV}">
                        <p><a href="javascript:void(0)" class="btn btn1 applyBtn" onclick="fn_RsvConfirm();">예약확인</a></p>
                    </c:if>
                    <c:if test="${orderDiv eq Constant.SV}">
                        <p><a href="javascript:void(0)" class="btn btn1 applyBtn" onclick="fn_RsvConfirmSV();">구매확인</a></p>
                    </c:if>
                </div>
            </form>
        </div>

        <div class="modal">
        </div>
    </section>
    <!-- 쿠폰1 s -->
    <div class="pop-coupon">
    </div>
    <!-- 쿠폰1 e -->

    <div id="code_popup">
        <div class="popup">
            <a href="javascript:itemSingleHide('#code_popup');$('#cover').hide();" class="btn btn7"></a>
            <div class="code-box">
                <p class="helper">소지하신 이벤트 코드를 정확히 입력해 주세요.</p>
                <div class="input-box">
                    <input type="text" name="vEvntCd" id="vEvntCd" size="30">
                </div>
                <p class="helper2 red"></p>
            </div>
            <div class="comm-btnWrap">
                <a href="javascript:void(0)" class="btn btn4" onclick="fn_EvntCdConfirm();">확인</a>
            </div>
        </div>
    </div> <!--//code-content-->

    <!-- 콘텐츠 e -->
    <!-- 푸터 s -->
    <jsp:include page="/mw/foot.do" />
    <!-- 푸터 e -->
    </div>

    <div id="layer" style="display:none; position:fixed; overflow:hidden; z-index:11; -webkit-overflow-scrolling: touch; left: 0; right: 0; top:0; bottom: 0; max-width: 320px; max-height: 460px; overflow-y: auto; margin: auto;">
    <img src="<c:url value="/images/mw/icon/close.png"/>" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:12" onclick="closeDaumPostcode();" alt="닫기 버튼">
</div>

</body>
</html>
