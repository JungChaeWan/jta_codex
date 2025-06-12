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

<script type="text/javascript" src="<c:url value='/js/mw_adDtlCalendar.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/mw_glDtlCalendar.js'/>"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0">
<meta name="format-detection" content="telephone=no">

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/bootstrap/css/bootstrap.min.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub_cart.css?version=2.2'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub_mypage.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/marathon.css'/>">

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

/*
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
*/
function sample2_execDaumPostcode(spOptSn, index) {
    new daum.Postcode({
        oncomplete: function(data) {
            //localStorage.setItem("localAreaYn", fnLocalAreaYn());
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
            document.getElementById('apctPostNum_'+spOptSn+"_"+index).value = data.zonecode; //5자리 새우편번호 사용
            document.getElementById('apctRoadNmAddr_'+spOptSn+"_"+index).value = fullAddr;
            document.getElementById('apctDtlAddr_'+spOptSn+"_"+index).focus();
            /*
            setLocalStorage();
            let jejuYn = data.address.search("제주특별자치도");
            if(jejuYn < 0){
                fnChangeLocalArea("N");
            }else{
                fnChangeLocalArea("Y");
            }
			*/
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

/**
 * DAUM 연동 주소찾기
 */
function openDaumPostcode(spOptSn, index) {
    new daum.Postcode({
        oncomplete: function(data) {
            document.getElementById('apctPostNum_'+spOptSn+"_"+index).value = data.zonecode;
            document.getElementById('apctRoadNmAddr_'+spOptSn+"_"+index).value = data.address;
            document.getElementById('apctDtlAddr_'+spOptSn+"_"+index).focus();
            
        }
    }).open();
}

function fn_tshirtsCheck(cartSn, index){

	var txt = $('#tshirts_'+cartSn+"_"+index + " option:selected").text();
	var val = $('#tshirts_'+cartSn+"_"+index + " option:selected").val();
	if("선택" != txt){
		let number = txt.match(/\(.*\)/gi).toString();
		number = number.replace(/[^0-9]/g, "");	
		if(number < 1){
			alert("현재 "+val+"사이즈 수량이 없습니다.\n다른 사이즈를 선택해주세요.");
			$('#tshirts_'+cartSn+"_"+index).val("");
			return;
		}
	}	
	
	let txsCnt = 0;
	let tsCnt = 0;
	let tmCnt = 0;
	let tlCnt = 0;
	let txlCnt = 0;
	let t2xlCnt = 0;
	let t3xlCnt = 0;
	var txsMaxCnt = "${tshirtsCntVO.txsCnt}";
	var tsMaxCnt = "${tshirtsCntVO.tsCnt}";
	var tmMaxCnt = "${tshirtsCntVO.tmCnt}";
	var tlMaxCnt = "${tshirtsCntVO.tlCnt}";
	var txlMaxCnt = "${tshirtsCntVO.txlCnt}";
	var t2xlMaxCnt = "${tshirtsCntVO.t2xlCnt}";
	var t3xlMaxCnt = "${tshirtsCntVO.t3xlCnt}";
	
	$("select[name='tshirts']").each(function(idx, item){
		
		for(var i=0;i < $(item).length;i++){
			if($(item).val() == "XS"){
				txsCnt += $(item).length;
				if(txsCnt > txsMaxCnt){
					alert(""+$(item).val()+"사이즈 수량이 없습니다.\n다른 사이즈를 선택해주세요.");
					$('#tshirts_'+cartSn+"_"+index).val("");
					return;
				}
			} else if($(item).val() == "S"){
				tsCnt += $(item).length;
				if(tsCnt > tsMaxCnt){
					alert(""+$(item).val()+"사이즈 수량이 없습니다.\n다른 사이즈를 선택해주세요.");
					$('#tshirts_'+cartSn+"_"+index).val("");
					return;
				}
			} else if($(item).val() == "M"){
				tmCnt += $(item).length;
				if(tmCnt > tmMaxCnt){
					alert(""+$(item).val()+"사이즈 수량이 없습니다.\n다른 사이즈를 선택해주세요.");
					$('#tshirts_'+cartSn+"_"+index).val("");
					return;
				}
			} else if($(item).val() == "L"){
				tlCnt += $(item).length;
				if(tlCnt > tlMaxCnt){
					alert(""+$(item).val()+"사이즈 수량이 없습니다.\n다른 사이즈를 선택해주세요.");
					$('#tshirts_'+cartSn+"_"+index).val("");
					return;
				}
			} else if($(item).val() == "XL"){
				txlCnt += $(item).length;
				if(txlCnt > txlMaxCnt){
					alert(""+$(item).val()+"사이즈 수량이 없습니다.\n다른 사이즈를 선택해주세요.");
					$('#tshirts_'+cartSn+"_"+index).val("");
					return;
				}
			} else if($(item).val() == "2XL"){
				t2xlCnt += $(item).length;
				if(t2xlCnt > t2xlMaxCnt){
					alert(""+$(item).val()+"사이즈 수량이 없습니다.\n다른 사이즈를 선택해주세요.");
					$('#tshirts_'+cartSn+"_"+index).val("");
					return;
				}
			} else if($(item).val() == "3XL"){
				t3xlCnt += $(item).length;
				if(t3xlCnt > t3xlMaxCnt){
					alert(""+$(item).val()+"사이즈 수량이 없습니다.\n다른 사이즈를 선택해주세요.");
					$('#tshirts_'+cartSn+"_"+index).val("");
					return;
				}
			}
		}
	});
}

//마라톤신청자 체크
function fn_mrtnCheck(){
	
	var mrtnCheckFlag = true;
	
	$("input[name='apctNm']").each(function(index, item){
		if(isNull($(item).val())){
			alert("신청자 이름을 입력해주세요.");
			$(item).focus();
			mrtnCheckFlag = false;
			return false;	
		} else {
			if(strLengthCheck($(item).val()) > 40) {
				alert("신청자 이름은 12자를 초과하실 수 없습니다.");
				$(item).focus();
				mrtnCheckFlag = false;
				return false;	
			} else {
				//mrtnCheckFlag = true;
			}
		}
	});
	
	$("input[name='apctEmail']").each(function(index, item){
		if(isNull($(item).val())){
			//필수는 아님
			mrtnCheckFlag = true;
		} else {
			if(!fn_is_email($(item).val())) {
				alert("" + $(item).val() + "은(는) 유효하지 않은 이메일 주소입니다.");
				$(item).focus();
				mrtnCheckFlag = false;
				return false;
			} else {
				//mrtnCheckFlag = true;
			}
		}
	});
	
	$("input[name='apctTelnum']").each(function(index, item){
		if(isNull($(item).val())){
			alert("신청자 전화번호를 입력해주세요.");
			$(item).focus();
			mrtnCheckFlag = false;
			return false;
		} else {
			if(!checkIsHP($(item).val())){
				alert("<spring:message code='errors.phone'/>");
				$(item).focus();
				mrtnCheckFlag = false;
				return false;
			} else {
				//mrtnCheckFlag = true;
			}
		}
	});
	
	$("input[name='birth']").each(function(index, item){
		if(isNull($(item).val())){
			alert("신청자 생년월일을 입력해주세요.");
			$(item).focus();
			mrtnCheckFlag = false;
			return false;
		} else {
			if($(item).val().length != 8){
				alert("신청자 생년월일 8자리를 입력해주세요.");
				$(item).focus();
				mrtnCheckFlag = false;	
				return false;
			} else {
				//mrtnCheckFlag = true;
			}
			
			if(!fn_is_birth($(item).val())){
				alert("생년월일을 다시 확인해주세요.");
				$(item).focus();
				mrtnCheckFlag = false;
				return false;	
			} else {
				//mrtnCheckFlag = true;
			}
		}
	});
	
	$("input[name='lrrn']").each(function(index, item){
		if(isNull($(item).val())){
			alert("주민번호 뒷자리를 입력해주세요.");
			$(item).focus();
			mrtnCheckFlag = false;
			return false;
		} else {
			if($(item).val().length != 7){
				alert("주민번호 뒷 7자리를 입력해주세요.");	
				$(item).focus();
				mrtnCheckFlag = false;
				return false;
			} else {
				//mrtnCheckFlag = true;
			}
			
			if(!fn_is_lrrn($(item).val())){
				alert("주민번호 뒷자리를 다시 확인해주세요.");
				$(item).focus();
				mrtnCheckFlag = false;
				return false;	
			} else {
				//mrtnCheckFlag = true;
			}
		}
	});
	
	$("select[name='ageRange']").each(function(index, item){
		if(isNull($(item).val())){
			alert("나이대를 선택해주세요.");
			$(item).focus();
			mrtnCheckFlag = false;
			return false;
		} else {
			//mrtnCheckFlag = true;
		}
	});
	
	$("select[name='gender']").each(function(index, item){
		if(isNull($(item).val())){
			alert("성별을 선택해주세요.");
			$(item).focus();
			mrtnCheckFlag = false;
			return false;
		} else {
			//mrtnCheckFlag = true;
		}
	});
	
	$("select[name='bloodType']").each(function(index, item){
		if(isNull($(item).val())){
			alert("혈액형을 선택해주세요.");
			$(item).focus();
			mrtnCheckFlag = false;
			return false;
		} else {
			//mrtnCheckFlag = true;	
		}
	});
	
	$("select[name='region']").each(function(index, item){
		if(isNull($(item).val())){
			alert("거주지역을 선택해주세요.");
			$(item).focus();
			mrtnCheckFlag = false;
			return false;
		} else {
			//mrtnCheckFlag = true;
		}
	});
	
	$("input[name='apctPostNum']").each(function(index, item){
		if(isNull($(item).val())){
			alert("주소검색 버튼을 클릭하여 우편번호, 주소를 선택해주세요.");
			$(item).focus();
			mrtnCheckFlag = false;
			return false;
		} else {
			//mrtnCheckFlag = true;
		}
	});
	
	$("input[name='apctRoadNmAddr']").each(function(index, item){
		if(isNull($(item).val())){
			alert("주소검색 버튼을 클릭하여 우편번호, 주소를 선택해주세요.");
			$(item).focus();
			mrtnCheckFlag = false;
			return false;
		} else {
			//mrtnCheckFlag = true;
		}
	});
	
	$("input[name='apctDtlAddr']").each(function(index, item){
		if(isNull($(item).val())){
			alert("상세주소를 기입해주세요.");
			$(item).focus();
			mrtnCheckFlag = false;
			return false;
		} else {
			//mrtnCheckFlag = true;
		}
	});
	
	$("select[name='tshirts']").each(function(index, item){
		if(isNull($(item).val())){
			alert("티셔츠를 선택해주세요.");
			$(item).focus();
			mrtnCheckFlag = false;
			return false;
		} else {
			//mrtnCheckFlag = true;
		}
	});
	
	if(mrtnCheckFlag){
		var params = jQuery("#rsvInfo").serialize();
		$.ajax({
			type:"post",
			url:"<c:url value='/web/sp/chkMrtnUser.ajax'/>",
			data:params,
			async: false,
			success:function(data){
				
				if(data.FLAG == "FAIL") {
					alert(data.RESULT + "님은 중복 신청되었습니다.\n다시 확인해주세요.");
					mrtnCheckFlag = false;
					return false; 
				}
			},
			error:fn_AjaxError
		});
	}
	
	if(mrtnCheckFlag){
		var checked = $("#collectionAgreement").is(":checked");
        if(!checked){
        	alert("개인정보처리방침에 동의해주세요.");
        	mrtnCheckFlag = false;
        	$("#collectionAgreement").focus();
        	return false;
        }
	}
	
	if(mrtnCheckFlag){
		var checked = $("#insuranceAgree").is(":checked");
        if(!checked){
        	alert("보험약관에 동의해주세요.");
        	mrtnCheckFlag = false;
        	$("#insuranceAgree").focus();
        	return false;
        }
	}
	
	if(mrtnCheckFlag){
		var checked = $("#noticeAgree").is(":checked");
        if(!checked){
        	alert("참가자 필수 유의사항/동의사항에 동의해주세요.");
        	mrtnCheckFlag = false;
        	$("#noticeAgree").focus();
        	return false;
        }
	}
	
	if(mrtnCheckFlag){
		var checked = $("#joinCheck").is(":checked");
        if(!checked){
        	alert("서약내역에 동의해주세요.");
        	mrtnCheckFlag = false;
        	$("#joinCheck").focus();
        	return false;
        }
	}
	
	return mrtnCheckFlag;
}

let mwRsvClickTime = 0;
function fn_RsvConfirm() {
   
	const currentTime = new Date().getTime();
    const timeDiff = currentTime - mwRsvClickTime;

    if (timeDiff < 500) {
        e.preventDefault();
        return;
    }

    mwRsvClickTime = currentTime;
    
    //최종 결제금액이 0보다 낮을 경우 처리
    if($("#lastAmt").text().replace(/,/g, '') < 0){
        alert("포인트 또는 쿠폰을 초과하여 사용 하였습니다.\n최종 결제 금액을 확인 해 주세요.");
        return;
    }

  	//예약자명 체크
	if(isNull($("#rsvNm").val())) {
		alert("예약자 이름을 입력해주세요.");
		$("#rsvNm").focus();
		return;
	} else {
		if(strLengthCheck($("#rsvNm").val()) > 40 ) {
    		alert("예약자 이름은 12자를 초과하실 수 없습니다.");
    		$("#rsvNm").focus();
    		return;
		}
	}
	
	//예약자 이메일 체크
	if(isNull($("#rsvEmail").val())) {
		alert("예약자 이메일을 입력해주세요.");
		$("#rsvEmail").focus();
		return;
	} else {
		if(!fn_is_email($("#rsvEmail").val())) {
    		alert("<spring:message code='errors.email' arguments='" + $("#rsvEmail").val() + "'/>");
    		$("#rsvEmail").focus();
    		return;
    	}	
	}
	
	//예약자 전화번호 체크
	if(isNull($("#rsvTelnum").val())){
		alert("예약자 전화번호를 입력해주세요.");
		$("#rsvTelnum").focus();
		return;
	} else {
		if(!checkIsHP($("#rsvTelnum").val())) {
    		alert("<spring:message code='errors.phone'/>");
    		$("#rsvTelnum").focus();
    		return;
    	}	
	}
	
	//비회원 일경우
	if(isNull($("#useEmail").val())) {
		$("#useEmail").val($("#rsvEmail").val());
		return;
	}
	
	if(fn_mrtnCheck()){
	
		// 황금빛 제주 포인트 사용 시
		if($("#gsPointYn").val() == "Y") {
			// 적용되어있는 쿠폰 리셋
			$("input[name=mapSn]").each(function(index){
				var obj = $(this).parent().children("a");
				fn_DelCp(obj, $(this).val());
			});
			// L.Point 사용 0원 처리
			$("#lPointUsePoint").val(0);
			$("#lPointAmtView").html("- " + 0);
		}
		// L.Point 체크
		var lpointSave = eval($("#lPointBalance").val().replace(/[^\d]+/g, ''));
	
		if(lpointSave!='' && lpointSave < $("input[name=lpointUsePoint]").val()) {
			alert('사용할 금액이 잔액보다 초과되었습니다.');
			return false;
		}
		
	    //협력사(파트너)포인트에 콤마가 있으면 제거, 입력 안했을 경우 0 처리
	    let usePoint = 0
	    if ($("#usePoint").val() != undefined && $("#usePoint").val() != ""){
	        usePoint = $("#usePoint").val().replace(/,/gi,"");
	    }
	    $("#usePoint").val(usePoint);
	
		if(document.location.hash){ // 예약확인을 한번 클릭 한 이후에는 만료페이지로 보냄
	       location.href = "/htmls/mw/expiration.html";
	    }else{ // 처음 예약확인 클릭 시
	    	
	    	var params = jQuery("#rsvInfo").serialize();
    	    $.ajax({
    			type:"post",
    			url:"<c:url value='/web/sp/chkTshirtsBySize.ajax'/>",
    			data:params,
    			async: false,
    			success:function(data){
    				
    				if(data.FLAG == "SUCCESS") {
    					document.location.hash = 1;
    			        document.rsvInfo.action = "<c:url value='/mw/order02.do'/>";
    			        document.rsvInfo.submit();			
    				} else {
    					alert("사이즈 수량이 마감되었습니다.\n다른 사이즈를 선택해주세요.");
    					return;
    				}		
    			},
    			error:fn_AjaxError
    		});	
	    }
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
        // var cpDiv           = $(".pop-coupon input[name=cpDiv]").eq(index).val();
		var prdtCtgrList    = $(".pop-coupon input[name=prdtCtgrList]").eq(index).val();
        var prdtNum         = $(".pop-coupon input[name=prdtNum]").eq(index).val();
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
        } else if(aplprdtDiv == "${Constant.CP_APLPRDT_DIV_TYPE}" && prdtCtgrList.indexOf(prdtDiv) == -1) {     // 유형지정쿠폰인데 상품유형이 다른 경우
            if(!$(this).is(":checked")) {
                $(".pop-coupon tr").eq(index + 1).addClass('hide');
            }
        } else if(aplprdtDiv == "${Constant.CP_APLPRDT_DIV_PRDT}" && prdtNum != cartPrdtNum) {      // 상품지정쿠폰인데 상품번호가 다른 경우
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

    $.ajax({
        type:"post",
        url:"<c:url value='/mw/cpOptionLayer.ajax'/>",
        data:parameters,
        success:function(data){
            $(".pop-coupon").html(data);
            /** 특별처리빅이벤트 */
            /*if(curTime > '2021100109' && curTime < '2021112201' ){
                $(".pop-coupon").prepend("<img src='/images/mw/etc/popupBigEvnt2020.jpg' style='width:100%;'  alt='빅이벤트' border='0'>");
            }*/
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

            /** 특별처리빅이벤트 */
            /*if(curTime > '2021100109' && curTime < '2021112201' ){
                $(".comm-btn.black").text("동의하고받기");
            }*/
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
	};
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

    $("#lpointUsePopupBtn, #lpointSavePopupBtn, #lPointUsePoint").click(function(){
        $('body').append('<div class="lock-bg"></div>');
	});

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
		/*var parameters = "cartSn=" + cartSn + "&saleAmt=" + ($('#cartTotalAmt' + cartSn).val() - $('#cartOverAmt' + cartSn).val()) + "&prdtNum=" + $('#cartPrdtNum' + cartSn).val();*/
        var parameters = "cartSn=" + cartSn + "&saleAmt=" + $('#cartTotalAmt' + cartSn).val() + "&prdtNum=" + $('#cartPrdtNum' + cartSn).val();

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
    });
	
	$("#point_save_close").click(function(){
		$("#point_saving").hide();
        $('.comm-layer-popup').css('top', '0px');
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
            data   : "isMobile=Y&cssView=order&divView=mrtn",
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
            data   : "isMobile=Y&cssView=order&divView=mrtn",
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
	
	//신청자 주소일치 체크박스
    $("#adrCheck:checkbox").change(function(){    
       
       if($("#apctPostNum_1_0").val() == ""){
          alert("우편번호검색 버튼을 클릭하여 주소를 기입해주세요.");
          $("#adrCheck:checkbox").prop("checked",false);
          return;
       }
       if($("#apctRoadNmAddr_1_0").val() == ""){
          alert("우편번호검색 버튼을 클릭하여 주소를 기입해주세요.");
          $("#adrCheck:checkbox").prop("checked",false);
          return;
       }
       if($("#apctDtlAddr_1_0").val() == ""){
          alert("상세주소를 기입해주세요.");
          $("#apctDtlAddr_1_0").focus();
          $("#adrCheck:checkbox").prop("checked",false);
          return;
       }
       
       var checked = $("#adrCheck").is(":checked");
       if(checked){
          $("input[name='apctPostNum']").each(function(index, item){
             $(item).val($("#apctPostNum_1_0").val());
          });
          $("input[name='apctRoadNmAddr']").each(function(index, item){
             $(item).val($("#apctRoadNmAddr_1_0").val());
          });
          $("input[name='apctDtlAddr']").each(function(index, item){
             $(item).val($("#apctDtlAddr_1_0").val());
          });
       } else {
          $("input[name='apctPostNum']").each(function(index, item){
             $(item).val("");
          });
          $("input[name='apctRoadNmAddr']").each(function(index, item){
             $(item).val("");
          });
          $("input[name='apctDtlAddr']").each(function(index, item){
             $(item).val("");
          });
       }
    });
	
    $("#terms-all:checkbox").change(function(){
		var checked = $("#terms-all").is(":checked");
		if(checked){
			$("#collectionAgreement:checkbox").prop("checked", true);
			$("#insuranceAgree").prop("checked", true);
			$("#noticeAgree:checkbox").prop("checked", true);
			$("#joinCheck:checkbox").prop("checked", true);
		} else {
			$("#collectionAgreement:checkbox").prop("checked", false);
			$("#insuranceAgree").prop("checked", false);
			$("#noticeAgree:checkbox").prop("checked", false);
			$("#joinCheck:checkbox").prop("checked", false);
		}
	 });
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
            <form name="rsvInfo" id="rsvInfo" onSubmit="return false;">
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
                                <c:when test="${category eq Constant.SOCIAL}">
                                    <input type="hidden" name="cartPrdtDiv" id="cartPrdtDiv${cart.cartSn}" value="${Constant.SOCIAL}">
                                    <input type="hidden" name="cartPrdtNum" id="cartPrdtNum${cart.cartSn}" value="${cart.prdtNum}">
                                    <input type="hidden" name="cartOverAmt" id="cartOverAmt${cart.cartSn}" value="0">
                                    <input type="hidden" name="prdtUseNum" id="prdtUseNum${cart.cartSn}" value="${cart.qty}">
                                    <input type="hidden" name="optDivSn" id="optDivSn${cart.cartSn}" value="${cart.spDivSn}">
                                    <input type="hidden" name="optSn" id="optSn${cart.cartSn}" value="${cart.spOptSn}">
									<input type="hidden" name="cartCorpId" id="cartCorpId${cart.cartSn}" value="${cart.corpId}">
									
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
                                                            <span class="couponBT"><em>%</em>할인쿠폰 선택하기</span>
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
                    </c:forEach>
					
                    <c:set var="loop_flag" value="false" />
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
                    </c:forEach>
                    <h2>예약자 정보</h2>
                    <table class="bt-none">
                        <tr>
                            <th><label for="rsvNm">예약자명</label></th>
                            <td>
                                <input type="text" name="rsvNm" id="rsvNm" class="full" value="${userVO.userNm}" readonly>
                            </td>
                        </tr>
                        <tr>
                            <th><label for="rsvEmail">이메일</label></th>
                            <td>
                                <input type="text" name="rsvEmail" id="rsvEmail" class="full" value="${userVO.email}" <c:if test="${isGuest == 'N'}">readonly</c:if> placeholder="이메일을 입력하세요">
                            </td>
                        </tr>
                        <tr>
                            <th><label for="rsvTelnum">휴대폰</label></th>
                            <td>
                                <input type="text" name="rsvTelnum" id="rsvTelnum" class="full" value="${userVO.telNum}" readonly onKeyup="addHyphenToPhone(this);" maxlength="13">
                            </td>
                        </tr>
                    </table>
		
                    <h2>신청자 정보</h2>
                    <c:set var="totQty" value="0"/>
		<c:forEach var="cart" items="${orderList}" varStatus="status">
			<c:forEach var="i" begin="0" end="${cart.qty-1}">
				<c:set var="totQty" value="${totQty +1}"/>
			</c:forEach>
		</c:forEach>
		
		<table class="bt-none">
                        <tr>
                            <th><label for="groupNm">그룹명</label></th>
                            <td>
                                <c:choose>
                                 <c:when test="${totQty > 1}">
							<input type="text" name="groupNm" id="groupNm" value="" class="full" maxlength="20">
						</c:when>
						<c:otherwise>
							<input type="text" name="groupNm" id="groupNm" value="" class="full disabled" maxlength="20" readonly="readonly">
						</c:otherwise>
					</c:choose>
                            </td>
                        </tr>
                    </table>
                    
                    <input type="hidden" name="useNm" id="useNm" value="${userVO.userNm}">
					<input type="hidden" name="useEmail" id="useEmail" value="${userVO.email}">
					<input type="hidden" name="useTelnum" id="useTelnum" value="${userVO.telNum}">
					<input type="hidden" name="postNum" id="postNum" value="${userVO.postNum}">													
					<input type="hidden" name="roadNmAddr" id="roadNmAddr" value="${userVO.roadNmAddr}">
					<input type="hidden" name="dtlAddr" id="dtlAddr" value="${userVO.dtlAddr}">
												
                    <c:forEach var="cart" items="${orderList}" varStatus="status">
                    	<c:forEach var="i" begin="0" end="${cart.qty-1}">
                    	<c:set var="j" value="${j+1}"/>
                    	<h2>- 코스 : ${cart.optNm}</h2>
                    	<input type="hidden" name="course" id="course_${cart.cartSn}_${i}" value="${cart.spOptSn}">
                     <table class="bt-none deli-address">
                     	<colgroup>
                                <col width="23%">
                                <col width="*">
                            </colgroup>
                         <tr>
                             <th><label for="apctNm_${cart.cartSn}_${i}">이름</label></th>
                             <td><input type="text" name="apctNm" id="apctNm_${cart.cartSn}_${i}" class="full" maxlength="13"></td>
                         </tr>
                         <tr>
                             <th><label for="apctEmail_${cart.cartSn}_${i}">이메일</label></th>
                             <td>
                                 <input type="text" name="apctEmail" id="apctEmail_${cart.cartSn}_${i}" class="full" maxlength="24">
                             </td>
                         </tr>
                         <tr>
                             <th><label for="apctTelnum_${cart.cartSn}_${i}">휴대폰</label></th>
                             <td>
                                 <input type="text" name="apctTelnum" id="apctTelnum_${cart.cartSn}_${i}" class="full" onKeyup="addHyphenToPhone(this);" onkeydown="javascript:fn_checkNumber();" maxlength="13">
                             </td>
                         </tr>
                         <tr>
					<th><label for="birth_${cart.cartSn}_${i}">생년월일</label></th>
					<td><input type="text" name="birth" id="birth_${cart.cartSn}_${i}" class="inpName" onkeydown="javascript:fn_checkNumber();" placeholder="ex)YYYYMMDD" maxlength="8"></td>
				</tr>
				<tr>
					<th><label for="lrrn_${cart.cartSn}_${i}">주민등록번호 뒷7자리</label></th>
					<td><input type="text" name="lrrn" id="lrrn_${cart.cartSn}_${i}" class="inpName" onkeydown="javascript:fn_checkNumber();" maxlength="7"  placeholder="*보험 가입시 필요"></td>
				</tr>
				<tr>
					<th><label for="ageRange_${cart.cartSn}_${i}">나이대</label></th>
					<td>
						<div class="requests">
							<select name="ageRange" id="ageRange_${cart.cartSn}_${i}">
								<option value="">선택</option>
								<option value="10D">10대미만</option>
								<option value="10R">10대</option>
								<option value="20R">20대</option>
								<option value="30R">30대</option>
								<option value="40R">40대</option>
								<option value="50R">50대</option>
								<option value="60R">60대</option>
								<option value="70U">70대이상</option>
							</select>
						</div>
					</td>
				</tr>
				<tr>
					<th><label for="gender_${cart.cartSn}_${i}">성별</label></th>
					<td>
						<div class="requests">
							<select name="gender" id="gender_${cart.cartSn}_${i}">
								<option value="">선택</option>
								<option value="M">남성</option>
								<option value="F">여성</option>
							</select>
						</div>
					</td>
				</tr>
				<tr>
					<th><label for="bloodType_${cart.cartSn}_${i}">혈액형</label></th>
					<td>
						<div class="requests">
							<select name="bloodType" id="bloodType_${cart.cartSn}_${i}">
								<option value="">선택</option>
								<option value="AP">A+</option>
								<option value="BP">B+</option>
								<option value="OP">O+</option>
								<option value="ABP">AB+</option>
								<option value="AM">A-</option>
								<option value="BM">B-</option>
								<option value="OM">O-</option>
								<option value="ABM">AB-</option>
							</select>
						<div class="requests">
					</td>	
				</tr>
				<tr>
					<th><label for="tshirts_${cart.cartSn}_${i}">티셔츠</label></th>
					<td>
						<div class="requests">
							<select name="tshirts" id="tshirts_${cart.cartSn}_${i}" onchange="fn_tshirtsCheck(${cart.cartSn}, ${i});">
								<option value="">선택</option>
								<option value="XS">XS(잔여수량 : ${tshirtsCntVO.txsCnt} 개)</option>
								<option value="S">S(잔여수량 : ${tshirtsCntVO.tsCnt} 개)</option>
								<option value="M">M(잔여수량 : ${tshirtsCntVO.tmCnt} 개)</option>
								<option value="L">L(잔여수량 : ${tshirtsCntVO.tlCnt} 개)</option>
								<option value="XL">XL(잔여수량 : ${tshirtsCntVO.txlCnt} 개)</option>
								<option value="2XL">2XL(잔여수량 : ${tshirtsCntVO.t2xlCnt} 개)</option>
								<option value="3XL">3XL(잔여수량 : ${tshirtsCntVO.t3xlCnt} 개)</option>
							</select>
						</div>
					</td>
				</tr>
				<tr>
					<th><label for="region_${cart.cartSn}_${i}">거주지역</label></th>
					<td>
						<div class="requests">
							<select name="region" id="region_${cart.cartSn}_${i}">
								<option value="">선택</option>
								<option value="GW">강원도</option>
								<option value="GG">경기도</option>
								<option value="GN">경상남도</option>
								<option value="GB">경상북도</option>
								<option value="GJ">광주광역시</option>
								<option value="DG">대구광역시</option>
								<option value="DJ">대전광역시</option>
								<option value="BS">부산광역시</option>
								<option value="SU">서울특별시</option>
								<option value="SJ">세종특별자치시</option>
								<option value="US">울산광역시</option>
								<option value="IC">인천광역시</option>
								<option value="JN">전라남도</option>
								<option value="JB">전라북도</option>
								<option value="JJ">제주특별자치도</option>
								<option value="CN">충청남도</option>
								<option value="CB">충청북도</option>
							</select>
						</div>
					</td>
				</tr>
				<tr>
					<th>전체주소</th>
					<td>
						<div class="addr-wrap" id="d_newAddr">
							<input type="text" name="apctPostNum" id="apctPostNum_${cart.cartSn}_${i}" class="addr0" title="우편번호" readonly>
							<a href="javascript:sample2_execDaumPostcode(${cart.cartSn}, ${i});" class="btn">우편번호검색</a>
							<input type="text" name="apctRoadNmAddr" id="apctRoadNmAddr_${cart.cartSn}_${i}" class="addr1" title="기본주소 입력" readonly>
							<input type="text" name="apctDtlAddr" id="apctDtlAddr_${cart.cartSn}_${i}" class="addr2" title="상세주소 입력" maxlength="30">
						</div>
					</td>
				</tr>
				
                     </table>
                     <c:if test="${totQty > 1}">
	                     <c:if test="${j eq 1}">
							<div class="unity-check">
								<input type="checkbox" name="adrCheck" id="adrCheck" value="N" >
								<label for="adrCheck" class="label-check">상품 전달을 위해 배송되는 주소가 전부 일치하면 체크해주세요.</label>
							</div>
						</c:if>
					</c:if>
                     </c:forEach>
		</c:forEach>



                    <!-- SIZE DETAIL -->
                    <article class="payArea userWrap3">
                        <h2 class="title">SIZE DETAIL (단위 : cm)</h2>
                        <div class="clothing-size">
                            <img src="../../../images/web/bg/clothing-size.png" alt="치수">
                            <table class="size-detail-wrap">
                                <tr>
                                    <th>구분</th>
                                    <th>어깨넓이</th>
                                    <th>가슴둘레</th>
                                    <th>밑단둘레</th>
                                    <th>총기장</th>
                                </tr>
                                <tr>
                                    <td>XS</td>
                                    <td>39</td>
                                    <td>92</td>
                                    <td>90</td>
                                    <td>63.5</td>
                                </tr>
                                <tr>
                                    <td>S</td>
                                    <td>41</td>
                                    <td>97</td>
                                    <td>95</td>
                                    <td>65</td>
                                </tr>
                                <tr>
                                    <td>M</td>
                                    <td>43</td>
                                    <td>102</td>
                                    <td>100</td>
                                    <td>66.5</td>
                                </tr>
                                <tr>
                                    <td>L</td>
                                    <td>45</td>
                                    <td>107</td>
                                    <td>105</td>
                                    <td>68</td>
                                </tr>
                                <tr>
                                    <td>XL</td>
                                    <td>47</td>
                                    <td>112</td>
                                    <td>110</td>
                                    <td>69.5</td>
                                </tr>
                                <tr>
                                    <td>2XL</td>
                                    <td>49</td>
                                    <td>117</td>
                                    <td>115</td>
                                    <td>71</td>
                                </tr>
                                <tr>
                                    <td>3XL</td>
                                    <td>51</td>
                                    <td>122</td>
                                    <td>120</td>
                                    <td>72.5</td>
                                </tr>
                            </table>
                        </div>
                        <ul class="sub-txt">
                            <li>1. 사이즈 재는 위치에 따라 1~2cm 차이가 있을 수 있습니다.</li>
                            <li>2. 사이즈 단계별 2~3cm 차이가 납니다.</li>
                            <li>3. 후디제품의 경우 총길이는 모자길이를 뺀 목에서 부터 밑단 까지 입니다.</li>
                        </ul>
                    </article> <!-- //SIZE DETAIL -->

                    <!-- 동의 내역 -->
                    <article class="payArea userWrap4">
                        <h2 class="title">동의 내역</h2>
                        <div class="participate-form">
                        <%--    <div class="agreement-txt">
                                제주국제관광마라톤축제 참가자들은 축제 사무국 (사)제주특별자치도관광협회 대표자 및 보험계약자로 다음과 같은 조건으로
                                "주최자배상책임보험"과 "단체상해보험"에 가입되어 있습니다.
                            </div>--%>

                            <div class="join_body">
                                <div class="box_join-terms-container">
                                    <div class="join-agree">
                                        <div class="box_terms-list">
                                            <div class="box_terms-all">
                                                <input type="checkbox" name id="terms-all" class="form_checkbox sprite_join-default">
                                                <label for="terms-all" class="text_all-agree">전체동의</label>
                                            </div>
                                            <div class="box_list-terms">
                                                <ul class="list_terms-group">

                                                    <!-- 개인정보처리방침 -->
                                                    <li class="list-item_terms-group">
                                                        <input type="checkbox" id="collectionAgreement" class="form_checkbox sprite_join-default necessary">
                                                        <label for="collectionAgreement" class="label_terms">
                                                            개인정보처리방침
                                                            <span class="text_importance">(필수)</span>
                                                        </label>
                                                        <button class="link_terms-view" onclick="layer_popup2('#collection-agreement');">내용보기
                                                            <img src="../../../images/mw/sub/arrow.png" alt="내용보기">
                                                        </button>
                                                    </li>

                                                    <!-- 개인정보처리방침 / layer-popup -->
                                                    <div id="collection-agreement" class="agreement_memo comm-layer-popup">
                                                        <div class="content-wrap">
                                                            <div class="content">
                                                                <div class="head">
                                                                    <h3 class="title">개인정보처리방침</h3>
                                                                    <button type="button" class="close">
                                                                        <img src="/images/mw/icon/close/dark-gray.png" alt="닫기" onclick="itemSingleHide('agreement_memo');">
                                                                    </button>
                                                                </div>

                                                                <div class="sign_rules-wrap">
                                                                    <dl class="comm-rule">
                                                                        <dd>
                                                                            '제주특별자치도관광협회'는 (이하'탐나오'는) 고객님의개인정보를 중요시하며 "정보통신망 이용촉진 및 정보보호"에 관한 법률을 준수하고 있습니다.
                                                                            협회는 개인정보처리방침을 통하여 고객님께서 제공하시는 개인정보가 어떠한 용도와 방식으로 이용되고 있으며, 개인정보보호를 위해 어떠한 조취가 취해지고 있는지 알려드립니다.
                                                                            협회는 개인정보처리방침을 개정하는 경우 웹사이트 공지사항(또는 개별공지)을 통하여 공지할 것입니다.
                                                                            본 방침은 : 2023년 3월 01일부터 시행됩니다.
                                                                        </dd>
                                                                        <dt>마라톤 상품에서 수집하는 개인정보 항목 </dt>
                                                                        <dd>
                                                                            탐나오는 회원가입, 상담, 서비스 신청 등등을 위해 아래와 같은 개인정보를 수집하고 있습니다.
                                                                            수집항목 : 이름, 생년월일, 성별, 로그인ID, 비밀번호, 비밀번호 질문과 답변, 자택 전화번호, 자택 주소, 휴대전화번호, 이메일, 회사명 , 부서, 주민등록번호
                                                                        </dd>
                                                                        <dd>
                                                                            이하 탐나오 개인정보처리방침에 따름.
                                                                            탐나오 개인정보처리방침 : https://www.tamnao.com/web/etc/personalData.do
                                                                        </dd>
                                                                    </dl>
                                                                </div>

                                                                <!-- 확인 / button -->
                                                                <button type="button" class="check" onclick="itemSingleHide('#collection-agreement');">확인</button>
                                                            </div>
                                                        </div>
                                                    </div> <!-- //개인정보처리방침 / layer-popup -->

                                                    <!-- 보험약관 -->
                                                    <li class="list-item_terms-group">
                                                        <input type="checkbox" id="insuranceAgree" class="form_checkbox sprite_join-default necessary">
                                                        <label for="insuranceAgree" class="label_terms">
                                                            보험약관
                                                            <span class="text_importance">(필수)</span>
                                                        </label>

                                                        <button href="" class="link_terms-view" onclick="layer_popup2('#insurance-agreement');">내용보기
                                                            <img src="../../../images/mw/sub/arrow.png" alt="내용보기">
                                                        </button>
                                                    </li>

                                                    <!-- 보험약관 / layer-popup -->
                                                    <div id="insurance-agreement" class="agreement_memo comm-layer-popup">
                                                        <div class="content-wrap">
                                                            <div class="content">
                                                                <div class="head">
                                                                    <h3 class="title">보험약관</h3>
                                                                    <button type="button" class="close">
                                                                        <img src="/images/mw/icon/close/dark-gray.png" alt="닫기" onclick="itemSingleHide('agreement_memo');">
                                                                    </button>
                                                                </div>

                                                                <div class="sign_rules-wrap">
                                                                    <dl class="comm-rule">
                                                                        <dt>보험약관 동의</dt>
                                                                        <dd>
                                                                            제주국제관광마라톤축제 참자들은 축제 사무국 (사)제주특별자치도관광협회 대표자 및 보험계약자로 다음과 같은 조건으로 “주최자배상책임보험”과 “단체상해보험”에 참가신청 완료시 가입 됩니다.
                                                                            보험가입 시 이름, 주민번호 등 개인정보를 수집하여 보험사에 제공됩니다. <br>
                                                                            개인정보 불일치시 사전 통보 없이 가입이 제한됩니다. 주민번호는 보험가입 이외에 사용 및 제3자에 제공되지 않습니다.
                                                                        </dd>
                                                                        <dt>주최자배상책임보험</dt>
                                                                        <dd>
                                                                            - 행사운영 중 발생한 우연한 사고로 인해 제3자의 신체 및 재산에 손해를 입혀 발생한 주최자의 법률적 배상책임을 보상하는 상품 <br>
                                                                            보상하는 손해(대인담보, 대물담보)
                                                                            피보험자가 피해자에게 지급할 법률상 손해방금 <br>
                                                                            손해방지비용
                                                                            피보험자가 미리 회사의 동의를 받아 지급한 소송비용, 변호사 비용, 중재, 화해 또는 조정에 관한 비용
                                                                            ※ 주최측 법률상 과실여부에 따라 지급
                                                                        </dd>
                                                                        <dt>보상하는 손해(치료비)</dt>
                                                                        <dd>
                                                                            피보험자에게 배상책임이 없는 사고가 발생하였으나, 피공제자의 업무수행으로 생긴 우연한 사고로 타인이 입은 상해에 대한 치료비
                                                                            ※ 법률상 과실여부를 묻지 않고 지급 (단, 대인과 중복보상 지급 불가)
                                                                        </dd>
                                                                        <dd>
                                                                            보상하지 않는 손해
                                                                            고의로 생긴 손해
                                                                            천재지변으로 생긴 손해
                                                                            피공제자가 소유, 점유, 임차, 사용하거나 보호, 관리, 통제하는 재물의 손해
                                                                            계약상의 가중책임
                                                                            피공제자의 근로자가 업무 중 입은 상해에 대한 치료비 손해배상책임
                                                                            보상한도
                                                                            대인 (1인당/1사고당) : 1억원/3억원
                                                                            대물 (1사고당) : 1억원
                                                                            치료비 (1인당/1사고당) : 3백만원/1천만원
                                                                            ※ 보상한도 등은 심사 결과에 따라 지급 거부 및 변동될 수 있습니다.
                                                                        </dd>
                                                                        <dt>단체상해보험</dt>
                                                                        <dd>
                                                                            - 가입 담보/금액 <br>
                                                                            (상해) 보험가입금액(원)
                                                                            상해사망 담보 : 100,000,000
                                                                            상해후유장해 담보 : 100,000,000 <br>
                                                                            (질병) 보험가입금액(원)
                                                                            상질병사망 담보 : 10,000,000
                                                                            질병 80%이상 고도후유장해 담보 : 10,000,000 <br>
                                                                            (실손 의료비) 보험가입금액(원)
                                                                            상해급여의료비(공제 20%) : 10,000,000
                                                                            상해비급여의료비(공제 30%) : 10,000,000
                                                                            ※ 보상한도 및 담보금액 등은 심사 결과에 따라 변동될 수 있습니다.
                                                                            ※ 단체상해보험 보장 안내문 “별첨”
                                                                        </dd>
                                                                        <dt>단체상해보험 보장 안내</dt>
                                                                        <dd>
                                                                            1. 상해사망, 후유장해 <br>
                                                                            상해사망 후유장해 (24시간 담보) <br>
                                                                            보험기간 중에 급격하고도 우연한 외래의 사고로 신체에 상해를 입었을때 그 상해로 생긴 손해를 보상
                                                                            상기의 상해에는 유독가스 또는 유독물질을 우연하게도 일시에 흡입, 흡수 또는 섭취하였을 때에 생긴 중독증상 포함.
                                                                            (단, 세균성 음식물 중독과 상습적으로 흡입, 흡수 또는 섭취한 결과로 생긴 중독증상은 포함하되지 않음.) <br>
                                                                            주요 면책 <br>
                                                                            1) 피보험자의 고의 (다만, 피보험자가 심신상실 등로 자유로운 의사결정을 할 수 없는 상태에서 자신을 해친 경우 보험금 지급) <br>
                                                                            2) 보험수익자의 고의 (다만, 그 보험수익자가 보험금의 일부 보험수익자인 경우에는 다른 보험수익자에 대한 보험금 지급) <br>
                                                                            3) 계약자의 고의 <br>
                                                                            2. 질병사망, 고도후유장해
                                                                        </dd>
                                                                        <dd>
                                                                            질병사망
                                                                            피보험자가 보험기간 중 질병의 직접결과로 사망한 경우 사망보험금 지급
                                                                            80% 이상 고도후유장해
                                                                            보험기간 중 질병의 직접결과로 장해분류표에서 정한 장해 지급율이 80% 이상에 해당하는 장해 상채가 될 경우 고도후유장해보험금으로 지급 <br>
                                                                            3. 실손의료비(세부내용)
                                                                        </dd>
                                                                        <dt>상해급여</dt>
                                                                        <dd>
                                                                            피보험자가 상해로 인하여 의료기관에 입원 또는 통원하여 급여 치료를 받거나 급여 처방조제를 받는 경우에 보상 <br>
                                                                            상해비급여
                                                                            피보험자가 상해로 인하여 의료기관에 입원 또는 통원하여 비급여 치료를 받거나 처방조제를 받는 경우에 보상 (3대 비급여 제외)
                                                                        </dd>
                                                                    </dl>
                                                                </div>

                                                                <!-- 확인 / button -->
                                                                <button type="button" class="check" onclick="itemSingleHide('#insurance-agreement');">확인</button>
                                                            </div>
                                                        </div>
                                                    </div> <!-- 보험약관 / layer-popup -->

                                                    <!-- 참가자 필수 요의사항/동의사항 -->
                                                    <li class="list-item_terms-group">
                                                        <input type="checkbox" id="noticeAgree" class="form_checkbox sprite_join-default necessary">
                                                        <label for="noticeAgree" class="label_terms">
                                                            참가자 필수 <br>유의사항/동의사항
                                                            <span class="text_importance">(필수)</span>
                                                        </label>
                                                        <button class="link_terms-view" onclick="layer_popup2('#notice-Agreement');">내용보기
                                                            <img src="../../../images/mw/sub/arrow.png" alt="내용보기">
                                                        </button>
                                                    </li>

                                                    <!-- 참가자 필수 유의사항/동의사항 layer-popup -->
                                                    <div id="notice-Agreement" class="agreement_memo comm-layer-popup" style="top: 0">
                                                        <div class="content-wrap">
                                                            <div class="content">
                                                                <div class="head">
                                                                    <h3 class="title">참가자 필수 유의사항/동의사항</h3>
                                                                    <button type="button" class="close" onclick="itemSingleHide('agreement_memo');">
                                                                        <img src="/images/mw/icon/close/dark-gray.png" alt="닫기">
                                                                    </button>
                                                                </div>
                                                                <div class="sign_rules-wrap">
                                                                    <dl class="comm-rule">
                                                                        <dt>동의 1</dt>
                                                                        <dd>
                                                                            제28회 제주국제관광마라톤축제에 참가하면서, 주관측이 규정하는 참가자 동의사항 및 유의사항에 대해 다음과 같이 동의하고 확인합니다.
                                                                            모든 안전사고에 대해 모두 본인이 책임지고, 아래 모든 내용에 동의합니다.
                                                                            <br>
                                                                            제28회 제주국제관광마라톤축제에서 제공하는 마라톤대회, 각종 이벤트 등에 참가하는 것에 동의합니다.
                                                                            제28회 제주국제관광마라톤축제 안전하게 완주할 수 있는 양호한 건강상태임을 확인하며 의료적으로 문제가 없으며 적절하게 훈련하였음을 확인합니다.
                                                                            제28회 제주국제관광마라톤축제 참가 전에 의사에게 자문을 받아야 할 책임이 참가자 본인에게 있음을 확인합니다.
                                                                            제28회 제주국제관광마라톤축제 도중 나의 건강상의 문제로 인해 발생하는 제반 사항(사태)에 대해서 축제 주최 및 주관측에 어떠한 책임도 묻지 않겠습니다.
                                                                            <br>
                                                                            제28회 제주국제관광마라톤축제에 참가하는 것이 잠재적으로 위험할 수 있는 활동이고 넘어지거나, 다른 참가자와 부딪히거나, 응원객 등 기타 사람들과의 충돌,
                                                                            차량 또는 기타 차량과의 접촉, 더위 및 미세먼지, 습기, 바람, 추위, 젖어 있거나 미끄러운 노면을 포함한 날씨의 영향, 달리는 행위 자체로 인한 신체적 부상,
                                                                            떨어지는 나뭇가지 또는 기타 머리 위의 물체, 코스의 붐비는 특성 및 기타 상황을 포함 등
                                                                            <br>
                                                                            위의 상황들을 포함해 이에 국한하지 않고 대회 참가로 인해 발생할 수 있는 모든 위험요인에 대해 감수할 것을 인정하며 모든 위험요인을 알고 있고 이를 인정하며
                                                                            이러한 요인 등으로 인해 발생하는 부상, 사고 등에 모든 사항에 대해 주최 및 주관측에 어떠한 책임을 묻지 않겠습니다.
                                                                            <br>
                                                                            코스의 교통 혼잡으로 인해 구간별 제한시간 이후에는 교통통제가 자동 해제됨을 알고 있으며, 제한시간 내 완주하지 못할 시 진행요원의 지시에 따라 회수차량에 탑승하겠습니다.
                                                                            탑승 거부로 발생하는 사고에 대해서 주최측에 책임을 묻지 않겠습니다. 또한, 제한시간 이후 골인할 경우 공식기록을 요청하지 않겠습니다.
                                                                            <br>
                                                                            탐나오 상세페이지에 공지된 참가자 유의사항/대회규정 사항을 확인하였으며 관련내용 모두에 동의합니다.
                                                                        </dd>
                                                                        <dt>동의 2</dt>
                                                                        <dd>
                                                                            제주국제관광마라톤축제 대회규정(아래 세부사항 포함)을 준수하며, 참가자 동의사항 및 유의사항을 위반하여 발생하는 모든 사항에 대해서 참가자 본인이 책임을 지겠습니다.
                                                                            등록 시 가명, 차명을 사용하지 않으며, 어떤 경우에도 참가권을 양도하지 않겠습니다.
                                                                        </dd>
                                                                        <dt>동의 3</dt>
                                                                        <dd>
                                                                            본인은 아래의 참가비 환불 조항을 숙지하였으며 동의합니다.
                                                                            4월 17일 까지의 취소 : 전액환불
                                                                            4월 18일 이후의 취소 : 환불불가 | 티셔츠 등 기념품을 드립니다.
                                                                        </dd>
                                                                        <dt>동의 4</dt>
                                                                        <dd>
                                                                            아래의 경우 [실격 처리] 및 [대회 공식기록 불인정] 에 동의합니다.

                                                                            번호표 및 칩을 착용하지 않았을 경우
                                                                            공식 번호표를 훼손했을 경우
                                                                            대리 참가할 경우
                                                                            다른 사람의 칩을 포함하여 기록측정용 칩을 복수로 착용하고 참가할 경우
                                                                            출발 / 도착지점과 중간지점의 기록 측정용 매트를 밟지 않고 주로를 이탈할 경우 회송버스로 골인지점으로 이동 후 골인할 경우
                                                                            다른 사람으로부터 도움을 받을 경우
                                                                            기타 부정행위라고 판단할 경우(육상연맹 판단)
                                                                            신청한 참가부문(풀코스, 하프코스, 10km코스, 5km걷기코스)을 임의로 변경한 경우
                                                                        </dd>
                                                                        <dt>동의 5</dt>
                                                                        <dd>
                                                                            대회관련 사진, 동영상, 방송중계 등 홍보 및 운영과 관련해 이름, 이미지 등 또는 연령, 성별, 거주지, 경기 결과를 포함 이에 국한하지 않는 인적 정보 등 참가자가 대회 참여에 대한 기타
                                                                            기록물을 제주국제관광마라톤축제 주최/주관측이 대회 홍보 또는 제주 관광에 대한 홍보에 사용될 수 있습니다.
                                                                        </dd>
                                                                        <dt>동의 6</dt>
                                                                        <dd>
                                                                            탈의실 및 물품보관소는 집합장소인 구좌종합운동장내 또는 부근에 설치되며, 귀중품은 보관할 수 없습니다.
                                                                            보관물품은 분실시 제주국제관광마라톤축제 주최/주관측이 책임지지 않습니다.
                                                                            탈의실 및 물품보관소에는 배번을 제시하지 않으면 출입할 수 없습니다.
                                                                        </dd>
                                                                        <dt>동의 7</dt>
                                                                        <dd>
                                                                            단체는 참가회원을 대신하여 단체 대표자가 일괄 동의한 것으로 간주합니다.
                                                                        </dd>
                                                                    </dl>
                                                                </div>

                                                                <!-- 확인 / button -->
                                                                <button type="button" class="check" onclick="itemSingleHide('#notice-Agreement');">확인</button>
                                                            </div>
                                                        </div>
                                                    </div> <!-- //참가자 필수 유의사항/동의사항 layer-popup -->
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="cover-check">
                                <input type="checkbox" name="joinCheck" id="joinCheck" value="N">
                                <label for="joinCheck" class="label-check">위 내용과 함께 상기 본인(단체)은 2024 제주국제관광마라톤축제의 제반규정을 준수하고 본인의 건강관리에 만전을 기하여 경기에 임할 것이며, 만일 대회도중 사고가
                                    발생하였을 경우 주최측에 어떠한 청구도 하지 않을 것을 서약하며 참가를 신청합니다.</label>
                            </div>
                        </div>
                    </article><!-- //동의 내역 -->
					
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
                    <p><a href="javascript:void(0)" class="btn btn1 applyBtn" onclick="fn_RsvConfirm();">예약확인</a></p>
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
