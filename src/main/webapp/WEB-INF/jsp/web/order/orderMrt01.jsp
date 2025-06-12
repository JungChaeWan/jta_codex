<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		    uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />
<head>
	<meta name="robots" content="noindex, nofollow">
	<jsp:include page="/web/includeJs.do" />

	<script type="text/javascript" src="<c:url value='/js/adDtlCalendar.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/glDtlCalendar.js'/>"></script>
	<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>

	<!--[if lt IE 9]>
	<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/re/marathon.css'/>" />
	<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" /> --%>

	<script type="text/javascript">

		let doubleSubmitFlag = false;

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
		function openDaumPostcode(spOptSn, index) {

			new daum.Postcode({
				oncomplete: function(data) {

					/** 이전페이지의 도내/도외인지 저장*/
					//임시주석
					//localStorage.setItem("localAreaYn", fnLocalAreaYn());

					document.getElementById('apctPostNum_'+spOptSn+"_"+index).value = data.zonecode;
					document.getElementById('apctRoadNmAddr_'+spOptSn+"_"+index).value = data.address;
					document.getElementById('apctDtlAddr_'+spOptSn+"_"+index).focus();

					/* shy 임시주석
                    setLocalStorage();
                    let jejuYn = data.address.search("제주특별자치도");
                    if(jejuYn < 0){
                        fnChangeLocalArea("N");
                    }else{
                        fnChangeLocalArea("Y");
                    }
                    */
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
					//mrtnCheckFlag = true;
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

		let webRsvClickTime = 0;
		function fn_RsvConfirm() {

			const currentTime = new Date().getTime();
			const timeDiff = currentTime - webRsvClickTime;

			if (timeDiff < 500) {
				e.preventDefault();
				return;
			}

			webRsvClickTime = currentTime;

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
				let lpointSave = eval($("#lPointBalance").val().replace(/[^\d]+/g, ""));

				if(lpointSave != "" && lpointSave < $("input[name=lpointUsePoint]").val()) {
					alert("사용할 금액이 잔액보다 초과됐습니다.");
					return false;
				}

				//협력사(파트너)포인트에 콤마가 있으면 제거, 입력 안했을 경우 0 처리
				let usePoint = 0
				if ($("#usePoint").val() != undefined && $("#usePoint").val() != ""){
					usePoint = $("#usePoint").val().replace(/,/gi,"");
				}
				$("#usePoint").val(usePoint);
				
				if(document.location.hash){ // 예약확인을 한번 클릭 한 이후에는 만료페이지로 보냄
					location.href = "/htmls/web/expiration.html";
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
								document.rsvInfo.action = "<c:url value='/web/order02.do'/>";
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

		function fn_CpAbleCheck(cartSn) {

			$(".layerP1 input[name=cpChk]").each(function(index){
				var prdtDiv         = $("#cartPrdtDiv" + cartSn).val();
				var cartPrdtNum     = $("#cartPrdtNum" + cartSn).val();
				// var cpDiv           = $(".layerP1 input[name=cpDiv]").eq(index).val();
				var prdtCtgrList    = $(".layerP1 input[name=prdtCtgrList]").eq(index).val();
				var prdtNum         = $(".layerP1 input[name=prdtNum]").eq(index).val();
				var disDiv          = $(".layerP1 input[name=disDiv]").eq(index).val();
				var aplprdtDiv      = $(".layerP1 input[name=aplprdtDiv]").eq(index).val();
				var useYn			= $(".layerP1 input[name=useYn]").eq(index).val();
				var cpCode			= $(".layerP1 input[name=cpCode]").eq(index).val();
				var chkVal          = parseInt($(".layerP1 input[name=disAmt]").eq(index).val());
				var buyMiniAmt      = parseInt($(".layerP1 input[name=buyMiniAmt]").eq(index).val());
				var cpNm         = $(".layerP1 input[name=cpNm]").eq(index).val();

				/**탐나는전 특별처리*/
				if("${tamnacardYn}" == "N" && cpNm.indexOf("탐나는전") >= 0 ){
					$(".layerP1 tr").eq(index + 1).addClass('hide');
				}

				if(disDiv == "${Constant.CP_DIS_DIV_FREE}") {
					var cartOptDivSn = "";
					var cartOptSn = "";
					var cartPrdtUseNum = $("#prdtUseNum" + cartSn).val();
					var optDivSn = "";
					var optSn = "";
					var prdtUseNum = $(".layerP1 input[name=prdtUseNum]").eq(index).val();

					if(prdtNum.substring(0, 2) == "${Constant.SOCIAL}" || prdtNum.substring(0, 2) == "${Constant.SV}") {
						cartOptDivSn = $("#optDivSn" + cartSn).val();
						cartOptSn = $("#optSn" + cartSn).val();
						optDivSn = $(".layerP1 input[name=optDivSn]").eq(index).val();
						optSn = $(".layerP1 input[name=optSn]").eq(index).val();
					}
				}
				// 적용불가 쿠폰 숨기기
				if(isNull(useYn) && !isNull(cpCode)) {		// 코드입력쿠폰은 탐나오쿠폰내역보기에서만 입력 가능
					if(!$(this).is(":checked")) {
						$(".layerP1 tr").eq(index + 1).addClass('hide');
					}
				} else if(aplprdtDiv == "${Constant.CP_APLPRDT_DIV_TYPE}" && prdtCtgrList.indexOf(prdtDiv) == -1) {		// 유형지정쿠폰인데 상품유형이 다른 경우
					if(!$(this).is(":checked")) {
						$(".layerP1 tr").eq(index + 1).addClass('hide');
					}
				} else if(aplprdtDiv == "${Constant.CP_APLPRDT_DIV_PRDT}" && prdtNum != cartPrdtNum) {		// 상품지정쿠폰인데 상품번호가 다른 경우
					if(!$(this).is(":checked")) {
						$(".layerP1 tr").eq(index + 1).addClass('hide');
					}
				} else if(disDiv == "${Constant.CP_DIS_DIV_FREE}"
						&& (prdtUseNum >= cartPrdtUseNum && optSn == cartOptSn && optDivSn == cartOptDivSn) == false) {		// 무료쿠폰인데 상품수,구분번호,옵션번호 중 하나가 다른 경우
					if(!$(this).is(":checked")) {
						$(".layerP1 tr").eq(index + 1).addClass('hide');
					}
				} else if(chkVal > parseInt($("#cartTotalAmt" + cartSn).val())
						|| parseInt($("#cartTotalAmt" + cartSn).val()) < buyMiniAmt) {		// (할인금액 > 판매금액) 또는 (판매금액 < 최소구매금액)
					if(!$(this).is(":checked")) {
						$(".layerP1 tr").eq(index + 1).addClass('hide');
					}
				} else {
					$(".layerP1 tr").eq(index + 1).removeClass("off");
					$(".layerP1 input[name=cpChk]").eq(index).prop("disabled", false);
				}

				/** 특별처리빅이벤트 */
				/*if(curTime > '2021100109' && curTime < '2021112201' ){
					$(".comm-btn.sm.black").text("동의하고받기");
				}*/

			});
		}

		function fn_CpLayer(obj, cartSn) {
			$(".layerP1").html("");
			$(".layerP1").hide();

			var parameters = "cartSn=" + cartSn;
			/*parameters += "&saleAmt=" + ($('#cartTotalAmt' + cartSn).val() - $('#cartOverAmt' + cartSn).val());*/
			parameters += "&saleAmt=" + $('#cartTotalAmt' + cartSn).val();
			parameters += "&prdtNum=" + $('#cartPrdtNum' + cartSn).val();

			$.ajax({
				type: "post",
				url: "<c:url value='/web/cpOptionLayer.ajax'/>",
				data: parameters,
				success: function(data){
					$(".layerP1").html(data);
					fn_CpAbleCheck(cartSn);

					$("input[name=useCpNum]").each(function(index, el){
						$("input[name=cpNum]").each(function(index2, el2){
							if($(el).val() == $(el2).val()) {
								$(".layerP1 tr").eq(index2 + 1).addClass("off");
								$(".layerP1 input[name=cpChk]").eq(index2).prop("disabled", true);
							}
						});
					});

					// 팝업 위치 설정
					var couponBT = $("#cpTbl_" + cartSn);
					var btnLeft =  couponBT.offset().left;
					var btnTop = couponBT.offset().top - 250;

					$(".modal").fadeIn();
					$(".modal").show();

					$(".layerP1").attr("style", "width: 700px; left: 50%; top: 50%");
					/*			$(".layerP1 .bubble").attr("style", "left: 35px; right: 0;");*/

					$(".layerP1").show();
					$('body').addClass('not_scroll');

					/** 특별처리빅이벤트 */
					/*if(curTime > '2021100109' && curTime < '2021112201' ){
						$(".bigEvent2021 img").css("position", "absolute");
						$(".bigEvent2021 img").css("left", +btnLeft + "px");
						$(".bigEvent2021 img").css("top", +btnTop + $(".layerP1").innerHeight() + "px");
						$(".bigEvent2021 img").show();
					}*/
				},
				error: fn_AjaxError
			});
		}

		function fn_CpLayerOk(cartSn) {
			if($(".layerP1 input[name=cpChk]").is(":checked") == false) {
				alert("쿠폰을 선택해주세요");
				return false;
			}
			let disAmt = 0;
			let addHtml = "";

			$(".layerP1 input[name=cpChk]").each(function(index){
				if($(this).is(":checked")) {
					disAmt = parseInt($(".layerP1 input[name=disAmt]").eq(index).val());

					addHtml += "<p class='add-ct'>";
					addHtml += $("input[name=cpNm]").eq(index).val() + " ";
					addHtml += "<strong>"+ commaNum(disAmt) + "</strong>원";
					addHtml += "<a href='javascript:void(0)' onclick='fn_DelCp(this, " + cartSn + ");' class='close'><img src='/images/web/btn/circle_close.png' alt='닫기'></a>";
					addHtml += "<input type='hidden' name='useCpNum' value='" + $(".layerP1 input[name=cpNum]").eq(index).val() + "' />";
					addHtml += "<input type='hidden' name='cpDisAmt' value='" + disAmt + "' />";
					addHtml += "<input type='hidden' name='mapSn' value='" + cartSn + "' />";
					addHtml += "</p>";

					return false;
				}
			});

			$("#totalDisAmt" + cartSn).val(disAmt);
			$("#viewTotalDisAmt"+ cartSn).html("(-" + commaNum($("#totalDisAmt" + cartSn).val()) + ")");
			$("#addCp" + cartSn).html(addHtml);

			fn_CpLayerClose();
			fn_CalRsvAmt();

			if($("#lpointUseMainBtn").html() == "사용 취소"){
				$("#lpointUseMainBtn").click();
				alert("할인쿠폰금액에 따라 L.point 최대사용금액이 달라집니다. 사용하실 L.point 금액을 다시 적용해주세요.");
			}

			$("#couponUseYn").val("Y");
		}

		function fn_CpLayerClose() {
			$(".layerP1").hide();
			$(".layerP1").html("");
			$(".modal").hide();
			$(".bigEvent2021 img").hide();
			$("html, body").removeClass("not_scroll");
		}

		function fn_DelCp(obj, cartSn) {
			$("#totalDisAmt" + cartSn).val(parseInt($("#totalDisAmt" + cartSn).val()) - parseInt($(obj).parent().children("input[name=cpDisAmt]").val()));
			$("#viewTotalDisAmt" + cartSn).html("");
			$(obj).parent().remove();

			fn_CalRsvAmt();
		}

		// 쿠폰 받기
		let webCouponClickTime = 0;
		function fn_couponDownload(cpId, idx) {

			const currentTime = new Date().getTime();
			const timeDiff = currentTime - webCouponClickTime;

			if (timeDiff < 500) {
				e.preventDefault();
				return;
			}

			webCouponClickTime = currentTime;

			let parameters = "cpId=" + cpId;
			$.ajax({
				url:"<c:url value='/web/couponDownload.ajax'/>",
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

		function fn_CalRsvAmt() {
			$(".price span").each(function(index){
				$(this).html(commaNum(parseInt($("input[name=cartTotalAmt]").eq(index).val()) + parseInt($("input[name=dlvAmt]").eq(index).val()) - parseInt($("input[name=totalDisAmt]").eq(index).val())));
			});

			let disAmt = 0;
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

		function fn_revEmailHostChage(sltObj) {
			$("#revEmail_host").val(sltObj);
		}

		function fn_useEmailHostChage(sltObj) {
			$("#useEmail_host").val(sltObj);
		}

		function fn_revEmailHostSVChage(sltObj) {
			$("#revEmail_hostSV").val(sltObj);
		}

		function fn_EvntCdConfirm() {
			if(isNull($("#vEvntCd").val())) {
				$("#evntCd").val("");
				$("#vEvntCd2").val("");
				close_popup('#code_popup');
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
							close_popup('#code_popup');
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
			$(".price span").each(function(index){
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

		function fn_CouponReg(){
			//포인트, 수량 number 체크
			$.ajax({
				type:"post",
				url:"/web/point/couponReg.ajax",
				data: $("#frmPop").serialize(),
				dataType: "json",
				success:function(data){
					console.log(data.success);
					if (data.success == "Y"){
						alert('쿠폰이 정상적으로 등록 되었습니다.');
					}else{
						if (data.success == "CP_NONE") {
							alert('쿠폰번호가 존재하지 않습니다.');
						}else if(data.success == "CP_USE"){
							alert('해당 쿠폰이 아니거나, 이미 등록 되어 있습니다.');
						}else if(data.success == "APL_NONE"){
							alert('해당 쿠폰이 아니거나, 쿠폰 입력 가능 기간이 아닙니다.');
						}else{
							alert('알수 없는 오류로 등록에 실패 하였습니다.');
						}
						return;
					}
				},
				error : fn_AjaxError
			});
		}

		$(document).ready(function() {
			$("#mnuricard").on("click", function () {
				if($(this).val() == 'N'){
					$(this).val("Y")
				}else{
					$(this).val("N")
				}
			});

			/** 특별처리빅이벤트 */
			/*if(curTime > '2021100109' && curTime < '2021112201' ){
				$(".modal img").show();
			}*/

			//예약하기 클릭 후 새로 고침 시 만료페이지로 보냄
			if(document.location.hash) {
				location.href = "/htmls/web/expiration.html";
			}

			//back버튼 클릭 시 처리
			window.onpageshow = function(event) {
				if ( event.persisted || (window.performance && window.performance.navigation.type == 2)) {
					location.href = "/htmls/web/expiration.html";
				}
			}

			let strRevEmail = "${userVO.email}";

			if(strRevEmail != "") {
				let arrEmail = strRevEmail.split("@");

				$("#revEmailH").val(arrEmail[0]);
				$("#revEmail_host").val(arrEmail[1]);

				for(let i = 1; i < $("#revEmail_hostS option").length; i++ ) {
					if($("#revEmail_hostS option:eq("+i+")").val() == arrEmail[1]) {
						$("#revEmail_hostS").val(arrEmail[1]);
						break;
					}
				}
			}

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

			// 적용가능 쿠폰 체크
			$('.layer-1').each(function(){
				let cartSn = $(this).attr('cartSn');
				let parameters = "cartSn=" + cartSn;
				/*parameters += "&saleAmt=" + ($('#cartTotalAmt' + cartSn).val() - $('#cartOverAmt' + cartSn).val());*/
				parameters += "&saleAmt=" + $('#cartTotalAmt' + cartSn).val();
				parameters += "&prdtNum=" + $('#cartPrdtNum' + cartSn).val();

				$.ajax({
					type:"post",
					url:"<c:url value='/web/cpOptionLayer.ajax'/>",
					data:parameters,
					success:function(data){
						$(".layerP1").html(data);

						fn_CpAbleCheck(cartSn);
						if($(".cpListTr").length != $(".cpListTr.hide").length) {
							$("#cpTbl_" + cartSn).removeClass("hide");
						}
					},
					error:fn_AjaxError
				});
			});

			$("#s_dlvRequestInf").change(function(){
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
									$
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
							$("#d_newAddr").css("display", "block");
							let jejuYn = data.dlv.roadNmAddr.search("제주특별자치도");
							if(jejuYn < 0){
								fnChangeLocalArea("N");
							}else{
								fnChangeLocalArea("Y");
							}
						}
					});
				} else if($(this).val() == "NEW") {
					$("div.addr-wrap").css("display", "none");
					$("#postNum").val("");
					$("#roadNmAddr").val("");
					$("#dtlAddr").val("");
					$("#useNm").val("");
					$("#useTelnum").val("");
					$("#d_newAddr").css("display", "block");
					fnChangeLocalArea(fnLocalAreaYn());
				}
			});

			$("#dlvRequestInf").keyup(function(){
				// let textLength = strLengthCheck($(this).val());
				let textLength = $(this).val().length;
				$("#dlvTextLength").text(textLength);

				let dlvText = "";
				if(textLength > 50) {
					dlvText = $(this).val().substr(0, $(this).val().length - 1 );
					$(this).val(dlvText);
					$("#dlvTextLength").text(50);
				}
			});
			//scrollTop('.rightArea', 500);

			fn_CalRsvAmt();

			$("#appDiv").val(fn_AppCheck());

			$("#point_use_close").click(function(){
				$("#point_search").hide();
			});

			$("#point_save_close").click(function(){
				$("#point_saving").hide();
			});

			// L.Point 사용 클릭 시
			$("#lpointUseMainBtn").click(function(){
				if($("input[name=lpointUsePoint]").val() > 0) { // L.Point 사용 취소 시
					// L.POINT 적립 블라인드 취소
					$("#lpointSaveLockDiv").hide();

					// L.POINT 사용 Btn 타이틀 수정
					$("#lpointUseMainBtn").html("L.POINT 조회ㆍ사용");

					$("#lPointUsePoint").val(0);
					$("#lPointAmtView").html("- " + 0);
					$("#lastAmt").html(commaNum($("input[name=totalPrdtAmt]").val()));
					$("input[name=lpointUsePoint]").val(0);

					fn_CalRsvAmt();
				} else {
					layer_popup("#point_search");
					// 적립포인트 초기화
					$("#lpointSavePoint").val(0);
				}
			});

			// L.Point 카드번호 & 비번 체크
			$('#lPointSearchBtn').click(function(){
				let parameters = "serviceID=O100&cdno=" + $("#lPointCardU1").val() + $("#lPointCardU2").val() + $("#lPointCardU3").val() + $("#lPointCardU4").val();
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
										//	$("input[name=lpointUsePoint]").val(0);
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
				maxLpoint();
				if(Number($("#lpointMaxPoint").val()) < Number($("#lPointApplyUsePoint").val())){
					alert("최대사용한 L.POINT 금액은 "+ commaNum($("#lpointMaxPoint").val()) + "원 입니다.");
					return false;
				}

				let point = eval($("#lPointApplyUsePoint").val());
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
				if(eval($("#lPointBalance").val().replace(/[^\d]+/g, '')) < point) {
					alert('사용할 금액이 잔액보다 초과됐습니다.');
					return false;
				}
				$("#lPointUsePoint").val(commaNum(point));
				$("#lPointAmtView").html("- " + $("#lPointUsePoint").val());

				$("#lastAmt").html(commaNum(parseInt($("input[name=totalPrdtAmt]").val()) - point));
				$("input[name=lpointUsePoint]").val(point);

				// L.POINT 적립 블라인드
				$("#lpointSaveLockDiv").show();

				// L.POINT 사용 Btn 타이틀 수정
				$("#lpointUseMainBtn").html("사용 취소");

				$("#point_use_close").click();

				fn_CalRsvAmt();
			});

			// L.Point 적립 클릭 시
			$("#lpointSaveMainBtn").click(function(){
				if($("#lpointSavePoint").val() > 0) { // L.Point 적립 취소 시
					// L.POINT 사용 블라인드 취소
					$("#lpointUseLockDiv").hide();

					// L.POINT 적립 Btn 타이틀 수정
					$("#lpointSaveMainBtn").html("L.POINT 적립하기");

					$("#lpointSavePoint").val(0);
					// $("#lPointAmtSave").html(0);
					$("#lPointAmtSavePop").html(0);
				} else {
					layer_popup('#point_saving');
					// 사용 포인트 초기화
					$("input[name=lpointUsePoint]").val(0);
				}
			});

			// L.Point 적립 시
			$("#lPointSaveBtn").click(function(){
				let parameters = "serviceID=O100&cdno=" + $("#lPointCardS1").val() + $("#lPointCardS2").val() + $("#lPointCardS3").val() + $("#lPointCardS4").val();

				$.ajax({
					type:"post",
					url:"<c:url value='/web/actionLPoint.ajax'/>",
					data:parameters,
					success:function(data){
						if(data.lpoint.msgCn2 == "") {
							let point = parseInt(parseInt($("input[name=totalPrdtAmt]").val()) * "${Constant.LPOINT_SAVE_PERCENT}" / 100);

							$("#lpointSavePoint").val(point);
							// $("#lPointAmtSave").html(commaNum(point));
							$("#lPointAmtSavePop").html(commaNum(point));
							$("#lpointCardNo").val($("#lPointCardS1").val() + $("#lPointCardS2").val() + $("#lPointCardS3").val() + $("#lPointCardS4").val());

							// L.POINT 사용 블라인드
							$("#lpointUseLockDiv").show();

							// L.POINT 적립 Btn 타이틀 수정
							$("#lpointSaveMainBtn").html("적립 취소");

							$("#point_save_close").click();
						} else {
							alert("조회 실패 [사유 : " + data.lpoint.msgCn2 + " ]");
						}
					}
				});
			});

			/** 저장된 스토리지 불러오기 특산기념품상품만 */
			if("${orderDiv}" == "${Constant.SV}") {
				getLocalStorage();
				fnChangeLocalArea(fnLocalAreaYn());
				if (self.name != 'reload') {
					if (fnLocalAreaYn() == "Y") {
						self.name = 'reload';
						self.location.reload(true);
					}
				} else self.name = '';
			}

			/** 제휴업체 포인트 사용*/
			$("#partnerUseMainBtn").click(function () {
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
							$(".comm-button4 a").remove();
							$(".comm-button4").append('<a href="javascript:void(0)" class="color2">예약불가</a>');
							setTimeout(function() {
								location.href = "/"
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

		function fn_CouponRegPop() {
			fn_CenterPos(".couponRegPop_2");
			$.ajax({
				type   : "post",
				data   : "cssView=order&divView=mrtn",
				url    : "<c:url value='/web/point/couponRegPop.do'/>",
				success: function (data) {
					$(".couponRegPop_2").html(data);
					show_popup($(".couponRegPop_2"));
				},
				error  : fn_AjaxError
			});
		}

		function fn_PointHistoryPop() {
			fn_CenterPos(".couponRegPop_1");
			$.ajax({
				type   : "post",
				data   : "cssView=order&divView=mrtn",
				url    : "<c:url value='/web/point/pointHistoryPop.do'/>",
				success: function (data) {
					$(".couponRegPop_1").html(data);
					show_popup($(".couponRegPop_1"));
				},
				error  : fn_AjaxError
			});
		}

		// 중앙정렬
		function fn_CenterPos(id){
			const left = ( $(window).scrollLeft() + ($(window).width() - $(this).width()) / 2 );
			const top = ( $(window).scrollTop() + ($(window).height() - $(this).height()) / 2 ) -120;
			$(""+id).css({"left":left, "top":top});
		}
	</script>

</head>
<body class="marathon-wrap">
<header id="header">
	<jsp:include page="/web/head.do" />
</header>
<main id="main">
	<div class="mapLocation"> <!-- index page에서는 삭제 -->
		<div class="inner">
			<span>홈</span> <span class="gt">&gt;</span>
			<c:if test="${orderDiv eq Constant.SV}">
				<span>구매하기</span>
			</c:if>
			<c:if test="${orderDiv ne Constant.SV}">
				<span>예약하기</span>
			</c:if>
			<!-- <span>실시간 숙박</span> <span class="gt">&gt;</span>
            <span>숙박상세</span> -->
		</div>
	</div>
	<!-- quick banner -->
	<jsp:include page="/web/left.do" />
	<!-- //quick banner -->
	<div class="subContainer">
		<div class="subHead"></div>
		<div class="subContents">
			<!-- new contents -->
			<div class="lodge3">
				<div class="bgWrap2">
					<div class="Fasten">
						<form name="rsvInfo" id="rsvInfo" onSubmit="return false;">
							<input type="hidden" name="rsvDiv" value="${rsvDiv}" >
							<input type="hidden" name="appDiv" id="appDiv">
							<input type="hidden" name="flowPath" id="flowPath" value="${flowPath}">
							<input type="hidden" name="lpointCardNo" id="lpointCardNo" value="">
							<input type="hidden" name="lpointSavePoint" id="lpointSavePoint" value="0">
							<input type="hidden" id="lpointMaxPoint" value="0">
							<div class="comm_pay">
								<div class="pay-title">
									<h2>
										<c:if test="${orderDiv eq Constant.SV}">구매하기</c:if>
										<c:if test="${orderDiv ne Constant.SV}">예약하기</c:if>
									</h2>
								</div>
								<div class="container-grid">

									<c:if test="${orderDiv ne Constant.SV}">
									<c:set var="loop_flag" value="false" />
									<c:forEach var="cart" items="${orderList}" varStatus="status">
										<c:if test="${not loop_flag }">
											<c:if test="${cart.prdtNum eq 'SP00002180' }">
												<c:set var="loop_flag" value="true" />
												<div>
													<p>
														<br>
														<label for="mnuricard"><span class="couponBT" style="background:royalblue;">문화누리카드 결제 &nbsp;&nbsp;<input type="checkbox" name="mnuricard" id="mnuricard" value="N"> </span></label>
														<span style="font-size: 12px;"> * 문화누리카드 소지자에 한해 좌측 버튼 체크▷하단 '예약확인' 클릭 후 결제</span>
													</p>
												</div>
											</c:if>
										</c:if>
									</c:forEach>

									<div class="container-grid__left">

										<!-- 상품정보 / top -->
										<article class="payArea">
											<h5 class="title">상품 정보</h5>
											<table class="commCol product-info">
												<c:if test="${orderDiv eq Constant.SV}">
													<colgroup>
														<col>
														<col>
														<col>
														<col>
														<col>
													</colgroup>
												</c:if>
												<thead>
												<tr>
													<th class="title1">구분</th>
													<th class="title2">상품정보</th>
													<th class="title3">상품금액</th>
													<c:if test="${orderDiv eq Constant.SV}">
														<th class="title5">배송비</th>
													</c:if>
													<th class="title4">최종금액</th>
												</tr>
												</thead>
												<tbody>
												<c:set var="totalPrdtAmt" value="0" />
												<c:set var="totalDlvAmt" value="0" />
												<c:set var="sv_dlvAmtDiv" value="NULL" />
												<c:set var="sv_corpId" value="NULL" />
												<c:set var="sv_prdc" value="NULL"/>

												<c:forEach var="cart" items="${orderList}" varStatus="status">
													<input type="hidden" name="cartSn" value="${cart.cartSn}">
													<c:set var="totalPrdtAmt" value="${totalPrdtAmt + cart.totalAmt}" />
													<c:set var="category" value="${fn:substring(cart.prdtNum, 0, 2)}" />

													<c:choose>
														<c:when test="${category eq Constant.SOCIAL}">
															<tr>
																<td>${cart.ctgrNm}</td>
																<td class="left">
																	<h5 class="product"><span class="cProduct">[${cart.corpNm}] ${cart.prdtNm}</span></h5>
																	<p class="infoText">
																		<span>${cart.prdtDivNm}</span>
																		<c:if test="${not empty cart.aplDt}">
																			<fmt:parseDate var="aplDt" value="${cart.fromDt}${cart.aplDt}" pattern="yyyyMMdd" scope="page"/>
																			<span> | <fmt:formatDate value="${aplDt}" pattern="yyyy-MM-dd"/></span>
																		</c:if>
																		<span> | ${cart.optNm}</span>
																		<c:if test="${not empty cart.addOptNm}">
																			<span> | ${cart.addOptNm}</span>
																		</c:if>
																		<span>수량 : ${cart.qty}</span>
																	</p>
																	<table class="coupon-wrap hide" id="cpTbl_${cart.cartSn}">
																		<tr>
																			<td class="tBT">
																				<c:if test="${isGuest == 'N' && (ssPartnerCode eq '' || pointCpVO.eventCouponYn eq 'Y')}">
																					<a href="javascript:void(0)" class="layer-1" onclick="fn_CpLayer(this, '${cart.cartSn}');" cartSn="${cart.cartSn}">
																						<span class="couponBT">할인쿠폰 선택하기</span>
																					</a>
																				</c:if>
																			</td>
																			<td class="add" id="addCp${cart.cartSn}">
																			</td>
																		</tr>
																	</table>
																</td>
																<td>
																	<input type="hidden" name="dlvAmt" value="0" />
																	<input type="hidden" name="cartPrdtDiv" id="cartPrdtDiv${cart.cartSn}" value="${Constant.SOCIAL}">
																	<input type="hidden" name="cartPrdtNum" id="cartPrdtNum${cart.cartSn}" value="${cart.prdtNum}">
																	<input type="hidden" name="cartTotalAmt" id="cartTotalAmt${cart.cartSn}" value="${cart.totalAmt}">
																	<input type="hidden" name="cartOverAmt" id="cartOverAmt${cart.cartSn}" value="0">
																	<input type="hidden" name="totalDisAmt" id="totalDisAmt${cart.cartSn}" value="0">
																	<input type="hidden" name="prdtUseNum" id="prdtUseNum${cart.cartSn}" value="${cart.qty}">
																	<input type="hidden" name="optDivSn" id="optDivSn${cart.cartSn}" value="${cart.spDivSn}">
																	<input type="hidden" name="optSn" id="optSn${cart.cartSn}" value="${cart.spOptSn}">
																	<input type="hidden" name="cartCorpId" id="cartCorpId${cart.cartSn}" value="${cart.corpId}">

																	<p class="money"><fmt:formatNumber>${cart.totalAmt}</fmt:formatNumber>원</p>
																	<p class="sale"><span id="viewTotalDisAmt${cart.cartSn}"></span></p>
																</td>
																<td class="price">
																	<span>0</span>원
																</td>
															</tr>
														</c:when>
													</c:choose>
												</c:forEach>
												</tbody>
											</table>
										</article>
										<!-- //상품정보 / top -->
										<article class="payArea userWrap1">
											<h5 class="title">예약자 정보</h5>
											<table class="commRow">
												<tr>
													<th>이름</th>
													<td>
														<input type="text" name="rsvNm" id="rsvNm" class="inpName" value="${userVO.userNm}" readonly>
													</td>
													<th>이메일</th>
													<td>
														<input type="text" name="rsvEmail" id="rsvEmail" class="inpName" value="${userVO.email}" <c:if test="${isGuest == 'N'}">readonly</c:if> placeholder="이메일을 입력하세요">
													</td>
													<th>휴대폰</th>
													<td>
														<input type="text" name="rsvTelnum" id="rsvTelnum" class="inpName" value="${userVO.telNum}" readonly onKeyup="addHyphenToPhone(this);" maxlength="13" >
													</td>
												</tr>
											</table>
										</article>

										<article class="payArea userWrap2">
											<h5 class="title">신청자 정보</h5>
											<div class="caption-check">
												<strong class="necessary">*</strong> 필수 입력입니다.
											</div>
											<input type="hidden" name="useNm" id="useNm" value="${userVO.userNm}">
											<input type="hidden" name="useEmail" id="useEmail" value="${userVO.email}">
											<input type="hidden" name="useTelnum" id="useTelnum" value="${userVO.telNum}">
											<input type="hidden" name="postNum" id="postNum" value="${userVO.postNum}">
											<input type="hidden" name="roadNmAddr" id="roadNmAddr" value="${userVO.roadNmAddr}">
											<input type="hidden" name="dtlAddr" id="dtlAddr" value="${userVO.dtlAddr}">
											<c:set var="totQty" value="0"/>
											<c:forEach var="cart" items="${orderList}" varStatus="status">
												<c:forEach var="i" begin="0" end="${cart.qty-1}">
													<c:set var="totQty" value="${totQty +1}"/>
												</c:forEach>
											</c:forEach>

											<table class="commRow">
												<tr class="marathon-application__group">
													<th>신청 그룹명</th>
													<td>
														<c:choose>
															<c:when test="${totQty > 1}">
																<input type="text" name="groupNm" id="groupNm" value="" class="inpName" maxlength="20"/>
															</c:when>
															<c:otherwise>
																<input type="text" name="groupNm" id="groupNm" value="" class="inpName disabled" readonly="readonly"/>
															</c:otherwise>
														</c:choose>
													</td>
												</tr>
											</table>
											<br>

											<c:forEach var="cart" items="${orderList}" varStatus="status">
												<c:forEach var="i" begin="0" end="${cart.qty-1}" varStatus="status1">
													<c:set var="j" value="${j+1}"/>
													<h6>- 코스 : ${cart.optNm}</h6>
													<input type="hidden" name="course" id="course_${cart.cartSn}_${i}" value="${cart.spOptSn}">
													<table class="commRow">
														<tr>
															<th>이름 <strong class="necessary">*</strong></th>
															<td><input type="text" name="apctNm" id="apctNm_${cart.cartSn}_${i}" class="inpName" maxlength="13"></td>
															<th>이메일</th>
															<td><input type="text" name="apctEmail" id="apctEmail_${cart.cartSn}_${i}" class="inpName" maxlength="24"></td>
															<th>휴대폰 <strong class="necessary">*</strong></th>
															<td><input type="text" name="apctTelnum" id="apctTelnum_${cart.cartSn}_${i}" class="inpName" autocomplete="new-password" onKeyup="addHyphenToPhone(this);" onkeydown="javascript:fn_checkNumber();" maxlength="13" ></td>
														</tr>
														<tr>
															<th>생년월일 <strong class="necessary">*</strong></th>
															<td><input type="text" name="birth" id="birth_${cart.cartSn}_${i}" onkeydown="javascript:fn_checkNumber();" class="inpName" placeholder="ex)YYYYMMDD" maxlength="8"></td>
															<th>주민등록번호 뒷7자리 <strong class="necessary">*</strong></th>
															<td><input type="text" name="lrrn" id="lrrn_${cart.cartSn}_${i}" onkeydown="javascript:fn_checkNumber();" class="inpName" maxlength="7" placeholder="*보험 가입시 필요"></td>
															<th>나이대 <strong class="necessary">*</strong></th>
															<td>
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
															</td>
														</tr>
														<tr>
															<th>성별 <strong class="necessary">*</strong><br> / 혈액형 <strong class="necessary">*</strong></th>
															<td>
																<select name="gender" id="gender_${cart.cartSn}_${i}">
																	<option value="">선택</option>
																	<option value="M">남성</option>
																	<option value="F">여성</option>
																</select>
																&nbsp;
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
															</td>
															<th>티셔츠 <strong class="necessary">*</strong></th>
															<td>
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
															</td>
															<th>거주지역 <strong class="necessary">*</strong></th>
															<td>
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
															</td>
														</tr>
														<tr class="deli-address">
															<th>전체주소 <strong class="necessary">*</strong></th>
															<td colspan="5">
																<div id="d_newAddr" class="addr-wrap">
																	<a href="javascript:openDaumPostcode(${cart.cartSn}, ${i});" class="btn" >우편번호검색</a>
																	<input type="text" name="apctPostNum" id="apctPostNum_${cart.cartSn}_${i}" style="width:100px;min-width:100px" title="우편번호" readonly>
																	<input type="text" name="apctRoadNmAddr" id="apctRoadNmAddr_${cart.cartSn}_${i}" style="width:30%;" title="기본주소 입력" readonly>
																	<input type="text" name="apctDtlAddr" id="apctDtlAddr_${cart.cartSn}_${i}" style="width:28%;" title="상세주소 입력" maxlength="30">
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
										</article>

										<!-- SIZE DETAIL -->
										<article class="payArea userWrap3">
											<h5 class="title">SIZE DETAIL (단위 : cm)</h5>
											<div class="clothing-size">
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
												<img src="../../../images/web/bg/clothing-size.png" alt="치수">
											</div>
											<ul class="sub-txt">
												<li>1. 사이즈 재는 위치에 따라 1~2cm 차이가 있을 수 있습니다.</li>
												<li>2. 사이즈 단계별 2~3cm 차이가 납니다.</li>
												<li>3. 후디제품의 경우 총길이는 모자길이를 뺀 목에서 부터 밑단 까지 입니다.</li>
											</ul>
										</article> <!-- //SIZE DETAIL -->

										<!-- 동의 내역 -->
										<article class="payArea userWrap4">
												<h5 class="title">동의 내역</h5>
												<div class="participate-form">
			<%--										<div class="agreement-txt">
														제주국제관광마라톤축제 참가자들은 축제 사무국 (사)제주특별자치도관광협회 대표자 및 보험계약자로 다음과 같은 조건으로
															"주최자배상책임보험"과 "단체상해보험"에 가입되어 있습니다.
													</div>--%>

													<!-- 개인정보 / 보험약관 / 유의사항 / 동의사항 -->
													<div class="join_body">
														<div class="box_join-terms-container">
															<div class="join-agree">
																<div class="box_terms-list">
																	<div class="box_terms-all">
																		<input type="checkbox" id="terms-all" class="form_checkbox sprite_join-default">
																		<label for="terms-all" class="text_all-agree label-check">전체동의</label>
																	</div>
																	<div class="box_list-terms">
																		<ul class="list_terms-group">

																			<!-- 개인정보처리방침 -->
																			<li class="list-item_terms-group">
																				<input type="checkbox" id="collectionAgreement" class="form_checkbox sprite_join-default necessary">
																				<label for="collectionAgreement" class="label_terms label-check">
																					개인정보처리방침
																					<span class="text_importance">(필수)</span>
																				</label>
																				<button class="link_terms-view" onclick="show_popup('#collection-agreement');">내용보기
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
																								<img src="/images/web/icon/close/white.png" alt="닫기" onclick="close_popup('.agreement_memo');">
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
																						<button type="button" class="check" onclick="close_popup('#collection-agreement')">확인</button>
																					</div>
																				</div>
																			</div> <!-- //개인정보처리방침 / layer-popup -->

																			<!-- 보험약관 -->
																			<li class="list-item_terms-group">
																				<input type="checkbox" id="insuranceAgree" class="form_checkbox sprite_join-default necessary">
																				<label for="insuranceAgree" class="label_terms label-check">
																					보험약관
																					<span class="text_importance">(필수)</span>
																				</label>

																				<button href="" class="link_terms-view" onclick="show_popup('#insurance-agreement');">내용보기
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
																								<img src="/images/web/icon/close/white.png" alt="닫기" onclick="close_popup('.agreement_memo');">
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
																						<button type="button" class="check" onclick="close_popup('#insurance-agreement')">확인</button>
																					</div>
																				</div>
																			</div> <!-- 보험약관 / layer-popup -->

																			<!-- 참가자 필수 요의사항/동의사항 -->
																			<li class="list-item_terms-group">
																				<input type="checkbox" id="noticeAgree" class="form_checkbox sprite_join-default necessary">
																				<label for="noticeAgree" class="label_terms label-check">
																					참가자 필수 유의사항/동의사항
																					<span class="text_importance">(필수)</span>
																				</label>
																				<button class="link_terms-view" onclick="show_popup('#notice-agreement');">내용보기
																					<img src="../../../images/mw/sub/arrow.png" alt="내용보기">
																				</button>
																			</li>

																			<!-- 참가자 필수 유의사항/동의사항 layer-popup -->
																			<div id="notice-agreement" class="agreement_memo comm-layer-popup">
																				<div class="content-wrap">
																					<div class="content">
																						<div class="head">
																							<h3 class="title">참가자 필수 유의사항/동의사항</h3>
																							<button type="button" class="close" onclick="close_popup('.agreement_memo');">
																								<img src="/images/web/icon/close/white.png" alt="닫기">
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
																						<button type="button" class="check" onclick="close_popup('#notice-agreement')">확인</button>
																					</div>
																				</div>
																			</div> <!-- //참가자 필수 유의사항/동의사항 layer-popup -->
																		</ul>
																	</div>
																</div>
															</div>
														</div>
													</div> <!-- //개인정보 / 보험약관 / 유의사항 / 동의사항 -->

													<div class="cover-check">
														<input type="checkbox" name="joinCheck" id="joinCheck" value="N">
														<label for="joinCheck" class="label-check">위 내용과 함께 상기 본인(단체)은 2024 제주국제관광마라톤축제의 제반규정을 준수하고 본인의 건강관리에 만전을 기하여 경기에 임할 것이며, 만일 대회도중 사고가
															발생하였을 경우 주최측에 어떠한 청구도 하지 않을 것을 서약하며 참가를 신청합니다.</label>
													</div>

												</div>
										</article><!-- //동의 내역 -->
									</div>

									<div class="container-grid__right">
										<!-- 파트너(협력사) 포인트 -->
										<c:if test="${ssPartnerCode ne '' && isGuest == 'N'}">
											<input type="hidden" name="lpointUsePoint" value="0" />
											<input type="hidden" class="full" id="lPointBalance" disabled value="0">

											<div class="payArea l-point">
												<h4 class="comm-title2"> ${pointCpVO.partnerNm} 포인트
														<%--										<span class="caption-text-red">(${pointCpVO.partnerNm})</span>--%>
												</h4>
												<table class="commRow">
													<colgroup>
														<col style="width: 140px">
														<col style="width: 370px">
														<col style="width: 140px">
														<col>
													</colgroup>
													<tbody>
													<tr>
														<th>포인트 사용</th>
														<td>
															<div class="lock-area">
																<a class="value-point exposure-point" href="javascript:void(0)" onclick="fn_PointHistoryPop();">
																	<span id="partnerAmtSave"><fmt:formatNumber value="${partnerPoint.ablePoint}" type="number"/></span>
																	<span class="possible">P 사용가능</span>
																</a><p></p>
																<input type="text" id="usePoint" name="usePoint" >
																<button type="button" class="comm-btn" id="partnerUseMainBtn">적용</button>
																<button type="button" class="comm-btn" id="useAllPointBtn">전부사용</button>
																<div class="button-lock" id="partnerUseLockDiv" style="display:none"></div>
															</div>
															<!-- 조회/사용 팝업 -->
														</td>

														<th>포인트 등록</th>
														<td>
															<div class="lock-area">
																<a class="comm-btn" id="partnerSaveMainBtn" onclick="fn_CouponRegPop();" href="javascript:void(0)">등록하기</a>
																<!--사용 불가 처리 시 -->
																<div class="button-lock" id="partnerSaveLockDiv" style="display:none"></div>
																<!--//사용 불가 처리 시 -->
															</div>
														</td>
													</tr>
													</tbody>
												</table>
											</div>
										</c:if>

										<c:if test="${ssPartnerCode eq ''}">
											<div class="payArea l-point">
												<h4 class="comm-title2">제휴 할인
													<span class="caption-text-red">* L.POINT는 사용과 적립 중에 하나의 서비스만 이용할 수 있습니다.</span>
												</h4>
												<table class="commRow">
													<colgroup>
														<col style="width: 140px">
														<col style="width: 370px">
														<col style="width: 140px">
														<col>
													</colgroup>
													<tbody>
													<tr>
														<th>L. POINT 사용</th>
														<td>
															<input type="hidden" name="lpointUsePoint" value="0" />
															<div class="lock-area">
																<input type="text" id="lPointUsePoint" class="disabled" disabled>
																<button type="button" class="comm-btn" id="lpointUseMainBtn">L.POINT 조회ㆍ사용</button>
																<div class="button-lock" id="lpointUseLockDiv" style="display:none"></div>
															</div>

														</td>
														<th>L.POINT 적립</th>
														<td>
															<div class="lock-area">
																<span class="value-point"><span id="lPointAmtSavePop">0</span> P 적립예정</span>
																<button type="button" class="comm-btn" id="lpointSaveMainBtn">L.POINT 적립하기</button>
																<div class="button-lock" id="lpointSaveLockDiv" style="display:none"></div>
															</div>
														</td>
													</tr>
													</tbody>
												</table>
											</div>
										</c:if>

										<!-- 이벤트 코드 -->
										<c:if test="${pointCpVO.partnerCode eq null}">
											<article class="payArea">
												<h4 class="comm-title2">이벤트 코드</h4>
												<table class="commRow">
													<tbody>
													<tr>
															<%--					<th>코드 번호</th>--%>
														<td>
															<div class="event-code">
																<input type="text" name="vEvntCd2" id="vEvntCd2" size="30" class="disabled" disabled="disabled">
																<input type="hidden" name="evntCd" id="evntCd" />
																<a href="javascript:void(0)" class="comm-btn" onclick="show_popup('#code_popup');">조회</a>
															</div> <!--//event-code-->
														</td>
													</tr>
													</tbody>
												</table>
											</article>
										</c:if>

										<!-- 결제정보 -->
										<article class="payArea">
											<h4 class="comm-title2">결제정보</h4>
											<table class="commRow">
												<colgroup>
													<col style="width: 140px">
													<col>
												</colgroup>
												<tbody class="marathon-payment__info">
												<tr>
													<th>총상품금액</th>
													<td class="pay-st">
														<input type="hidden" name="totalPrdtAmt" value="${totalPrdtAmt}">
														<strong><fmt:formatNumber>${totalPrdtAmt}</fmt:formatNumber></strong>원
													</td>
												</tr>
												<tr>
													<th>쿠폰할인</th>
													<td class="sale"><span class="text-red" id="cpDisAmtView">- 0</span>원</td>
												</tr>
												<c:if test="${pointCpVO.partnerCode eq null}">
													<tr>
														<th>L.POINT 사용</th>
														<td>
															<div class="sale"><span class="text-red" id="lPointAmtView">- 0</span> P</div>
														</td>
													</tr>
												</c:if>
												<c:if test="${pointCpVO.partnerCode ne null}">
													<tr>
														<th>${pointCpVO.partnerNm} 포인트</th>
														<td>
															<div class="sale"><span class="text-red" id="partnerPointAmtView">- 0</span> P</div>
														</td>
													</tr>
												</c:if>
												<c:if test="${orderDiv eq Constant.SV}">
													<tr>
														<th>총 배송비</th>
														<td class="shipping">
															+ <fmt:formatNumber>${totalDlvAmt}</fmt:formatNumber>원
														</td>
													</tr>
												</c:if>
												<tr>
													<th>최종결제금액</th>
													<td class="total-wrap pay-st">
														<input type="hidden" name="totalDlvAmt" value="${totalDlvAmt}">
														<strong id="lastAmt" class="comm-color1"><fmt:formatNumber>${totalPrdtAmt}</fmt:formatNumber></strong>원
													</td>
												</tr>
												</tbody>
											</table>
										</article><!-- //결제정보 -->
										<p class="comm-button4">
											<a href="javascript:void(0)" class="color2" onclick="fn_RsvConfirm();">예약확인</a>
										</p>
									</div>

										<!-- 조회/사용 팝업 -->
										<div id="point_search" class="comm-layer-popup point-search">
											<div class="content-wrap">
												<div class="content">
													<div class="head">
														<h3 class="title">L.POINT 조회/사용</h3>
														<button type="button" id="point_use_close" class="close"><img src="<c:url value="/images/web/icon/close/white.png"/>" alt="닫기"></button>
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
																		<button type="button" class="comm-btn" id="lPointSearchBtn">조회</button>
																	</div>
																</td>
															</tr>
															<tr>
																<th>잔액</th>
																<td>
																	<input type="text" class="full" id="lPointBalance" disabled>
																</td>
															</tr>
															<tr>
																<th>사용할 금액</th>
																<td>
																	<div class="input-btn-col2">
																		<input type="text" id="lPointApplyUsePoint" value="0">
																		<button type="button" class="comm-btn red" id="lPointUseBtn">사용하기</button>
																	</div>
																</td>
															</tr>
															</tbody>
														</table>

														<div class="popup-area-list">
															<ul class="list-disc">
																<li>카드번호와 L.POINT 비밀번호를 정확히 입력해야 잔액 확인이 가능합니다.</li>
																<li>L.POINT는 10원 단위로 사용이 가능하며, 단일상품의 최대결제금액 내에서 사용 가능합니다.</li>
																<li>'L.POINT 비밀번호'는 온라인에서 포인트를 사용하기 위해 설정된 비밀번호로, 숫자 6자리입니다. L.POINT Web/App 로그인 시 입력하는 비밀번호와는 별도의 비밀번호이며, L.POINT Web/App에서 언제든 간단하게 재설정하실 수 있습니다.</li>
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
										<div id="point_saving" class="comm-layer-popup point-saving">
											<div class="content-wrap">
												<div class="content">
													<div class="head">
														<h3 class="title">L.POINT 적립</h3>
														<button type="button" id="point_save_close" class="close"><img src="<c:url value="/images/web/icon/close/white.png"/>" alt="닫기"></button>
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
																		<button type="button" class="comm-btn red" id="lPointSaveBtn">확인</button>
																	</div>
																</td>
															</tr>
															</tbody>
														</table>

														<div class="popup-area-list">
															<ul class="list-disc">
																<li>적립 시점<br>
																	- 관광상품 : 숙소, 렌터카, 쿠폰 등 이용 완료 후 10일 뒤 적립<br>
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

										<div id="code_popup" class="code-content comm-layer-popup_fixed">

											<div class="code-box">
												<p class="helper">소지하신 이벤트 코드를 정확히 입력해 주세요.</p>

												<div class="input-box">
													<input type="text" name="vEvntCd" id="vEvntCd" size="30">
													<!-- <a href="javascript:void(0)" class="comm-btn">조회</a> -->
												</div>

												<p class="helper2 red"></p>
											</div>

											<div class="comm-btnWrap">
												<a href="javascript:void(0)" class="comm-btn red" onclick="fn_EvntCdConfirm();">확인</a>
												<a href="javascript:void(0)" class="comm-btn gray" onclick="close_popup('#code_popup');">닫기</a>
											</div>
										</div> <!--//code-content-->
								</div>
								</c:if>

								<!-- 포인트 내역 / 레이어팝업 -->
								<div class="couponRegPop_1 comm-layer-popup"></div>

								<!-- 쿠폰등록 / 레이어팝업 -->
								<div class="couponRegPop_2 comm-layer-popup"></div>

								<c:if test="${orderDiv eq Constant.SV}">
									<article class="payArea buyer">

										<h5 class="title">구매자 정보</h5>
										<table class="commRow">
											<tbody>
											<tr>
												<th>이름</th>
												<td>
													<input type="text" name="rsvNm" id="rsvNmSV" class="inpName" value="${userVO.userNm}" readonly>
												</td>
											</tr>
											<tr>
												<th>이메일</th>
												<td>
													<input type="text" name="rsvEmail" id="rsvEmailSV" class="inpName" value="${userVO.email}" <c:if test="${isGuest == 'N'}">readonly</c:if> placeholder="이메일을 입력하세요">
												</td>
											</tr>
											<tr>
												<th>휴대폰</th>
												<td>
													<input type="text" name="rsvTelnum" id="rsvTelnumSV" class="inpName" value="${userVO.telNum}" readonly onKeyup="addHyphenToPhone(this);" maxlength="13" >
												</td>
											</tr>
											</tbody>
										</table>
									</article>
									<%--
									<c:if test="${svDirRecv == 'N'}">
										<article class="payArea deli-address">
											<h5 class="title">배송지 정보</h5>
											<table class="commRow">
												<tbody>
													<tr>
														<th>배송지 선택</th>
														<td>
															<label><input type="radio" name="r_addr" value="USER" checked> <span>기본</span></label>
															<label><input type="radio" name="r_addr" value="ORDER"> <span>최근 배송지</span></label>
															<label><input type="radio" name="r_addr" value="NEW"> <span>새로 입력</span></label>
														</td>
													</tr>
													<tr>
														<th>이름</th>
														<td><input type="text" name="useNm" id="useNmSV" class="inpName" value="${userVO.userNm}"></td>
													</tr>
													<tr>
														<th>휴대폰</th>
														<td>
															<input type="text" name="useTelnum" id="useTelnumSV" class="inpName" value="${userVO.telNum}" onKeyup="addHyphenToPhone(this);" maxlength="13">
														</td>
													</tr>
													<tr>
														<th>배송지 주소</th>
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
																<a href="javascript:openDaumPostcode()" class="btn" >우편번호검색</a>
																<input type="text" name="roadNmAddr" id="roadNmAddr" class="addr1" title="기본주소 입력" readonly value="${userVO.roadNmAddr}">
																<input type="text" name="dtlAddr" id="dtlAddr" class="addr2" title="상세주소 입력" value="${userVO.dtlAddr}">
															</div>
														</td>
													</tr>
													<tr>
														<th>배송시 요청사항</th>
														<td>
															<div class="requests">
																<select id="s_dlvRequestInf" title="요청사항 선택">
																	<option value="">배송시 요청사항을 선택해주세요.</option>
																	<option value="배송 전 연락 바랍니다.">배송 전 연락 바랍니다.</option>
																	<option value="부재시 전화 주세요.">부재시 전화 주세요.</option>
																	<option value="부재시 경비실에 맡겨주세요.">부재시 경비실에 맡겨주세요.</option>
																	<option value="부재시 집 앞에 놔주세요.">부재시 집 앞에 놔주세요.</option>
																	<option value="택배함에 놔주세요.">택배함에 놔주세요.</option>
																</select>

																<div class="memo">
																	<textarea rows="3" name="dlvRequestInf" id="dlvRequestInf" placeholder="기타내용을 입력해주세요"></textarea>
																	<span>(<strong id="dlvTextLength">0</strong>/50자)</span>
																</div>
															</div>
														</td>
													</tr>
												</tbody>
											</table>
										</article>
									</c:if>
									--%>
								</c:if>
							</div>
						</form>
					</div> <!--//Fasten-->
				</div> <!--bgWrap-->
			</div> <!-- //lodge3 -->
			<!-- //new contents -->
			<div class="modal"></div>
			<div class="bigEvent2021"><img src="/images/mw/etc/popupBigEvnt2020.jpg" style="display:none;width:545px;z-index: 1000"></div>
			<div class="layerP1 layerP2">

			</div>
		</div> <!-- //subContents -->
	</div> <!-- //subContainer -->
</main>
<jsp:include page="/web/foot.do"></jsp:include>
</body>
</html>