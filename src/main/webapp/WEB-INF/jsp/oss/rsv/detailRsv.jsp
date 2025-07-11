<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="validator" 	uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="un" 			uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
           
<un:useConstants var="Constant" className="common.Constant" />

<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui-1.11.4.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>


<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />

<title></title>

<script type="text/javascript">

function fn_rcpInfo(userId,cpId){
	var parameters = "userId=" + userId + "&cpId=" + cpId;

	/*var parameters = "userId=U160298050&cpId=CP00000705"*/

	$.ajax({
		type:"post",
		dataType:"json",
		async:false,
		url:"<c:url value='/oss/selectRCpList.ajax'/>",
		data:parameters ,
		success:function(data){
			if(data.result.length > 0){
					for(let tempData of data.result){
					alert(tempData.usedCp)
				}
			}else{
				alert("연계쿠폰이 없습니다.");
			}



		},
		error:fn_AjaxError
	});
}


function fn_ListRsv(){
	document.frm.action = "<c:url value='/oss/rsvList.do'/>";
	document.frm.submit();
}

function fn_RefundComplete(prdtRsvNum){
	var parameters = "prdtRsvNum=" + prdtRsvNum + "&rsvNum=" + $("#rsvNum").val();

	$.ajax({
		type:"post", 
		dataType:"json",
		async:false,
		url:"<c:url value='/oss/refundComplete.ajax'/>",
		data:parameters ,
		success:function(data){
			alert("환불완료처리가 정상적으로 처리됐습니다.");
			document.frm.action = "<c:url value='/oss/detailRsv.do'/>";
			document.frm.submit();
		},
		error:fn_AjaxError
	});
}

function fn_chgRsvStatus(prdtRsvNum,rsvStatusCd, prevRsvStatusCd, prdtDiv ) {
	if(prevRsvStatusCd == "RS20"){
		if (!confirm("PG사에서 환불취소가 가능한가요?\n(실시간렌터카,하이제주 업체에게 예약API를 재전송을 하진 않습니다.) ")) {
			return;
		}
	}

	if (confirm("예약상태를 변경하시겠습니까? ")) {
		var parameters = "prdtRsvNum=" + prdtRsvNum + "&rsvNum=" + $("#rsvNum").val() + "&rsvStatusCd=" + rsvStatusCd + "&prdtDiv=" + prdtDiv;

		$.ajax({
			type:"post", 
			dataType:"json",
			async:false,
			url:"<c:url value='/oss/chgRsvStatus.ajax'/>",
			data:parameters ,
			success:function(data){
				if(data.success == "apiFail") {
					alert("취소요청이 실패 하였습니다.\n담당자에게 문의 바랍니다.");
					return;
				}else {
					fn_sendCancel(prdtRsvNum, rsvStatusCd);
				}
			},
			error:fn_AjaxError
		});
	}
}

function fn_sendCancel(prdtRsvNum, rsvStatusCd) {
	if(rsvStatusCd == "RS10"){ //RS10(취소요청) 일 경우에만
		if (confirm("문자/이메일을 발송하시겠습니까? ")) {
			var parameters = "prdtRsvNum=" + prdtRsvNum;
			
			$.ajax({
				type:"post", 
				dataType:"json",
				async:false,
				url:"<c:url value='/oss/reqCancel.ajax'/>",
				data:parameters ,
				success:function(data){
					alert("예약상태가 변경됐습니다.");
					document.frm.action = "<c:url value='/oss/detailRsv.do'/>";
					document.frm.submit();
				},
				error:fn_AjaxError
			});
			return;
		}
	}
	alert("예약상태가 변경됐습니다.");
	document.frm.action = "<c:url value='/oss/detailRsv.do'/>";
	document.frm.submit();
}

function fn_LoginMas(corpId){
	var parameters = "corpId=" + corpId;
	
	$.ajax({
		type:"post", 
		dataType:"json",
		// async:false,
		url:"<c:url value='/oss/masLogin.ajax'/>",
		data:parameters ,
		success:function(data){
			if(data.success == "Y"){
				window.open("<c:url value='/mas/home.do'/>", '_blank');
			}else{
				alert("업체 로그인에 실패했습니다.");
			}
		}
	});
}

function fn_LoginMasRsv(corpId,rsvNm,rsvTelNum,prdtCd){
	prdtCd = prdtCd.toLowerCase();
	if(prdtCd != "ad" && prdtCd != "rc"){
        prdtCd = "sp";
    }
	var parameters = "corpId=" + corpId;

	$.ajax({
		type:"post",
		dataType:"json",
		// async:false,
		url:"<c:url value='/oss/masLogin.ajax'/>",
		data:parameters ,
		success:function(data){
			if(data.success == "Y"){
				window.open("/mas/"+prdtCd+"/rsvList.do?sRsvNm="+rsvNm + "&sRsvTelnum=" +rsvTelNum, '_blank');
			}else{
				alert("업체 로그인에 실패했습니다.");
			}
		}
	});
}

function altRadioChk(){
	$("input[name=chkUserType][value='2']").prop("checked",true);
}

function sendMMS(){

/** 파라미터 타입
  * 0:예약자 연락처
  * 1:사용자 연락처
  * 2:연락처 직접입력 */
	if($("input[name=chkUserType]:checked").val() == "2"){
	    if(!$("#userTelNum").val()){
			alert("연락처를 입력해야합니다.");
			return;
		}
	}
	var confirmMsg = "";
	var parameters = {};
    parameters['rsvNum'] = $("#rsvNum").val();
	if($("input[name=chkUserType]:checked").val() == "0"){
		parameters['rsvTelnum'] = "${rsvInfo.rsvTelnum}";
		parameters['telnumType'] = "0";
		confirmMsg = "<spring:message code='to.rsvNum' />";
	}else if($("input[name=chkUserType]:checked").val() == "1"){
		parameters['useTelnum'] = "${rsvInfo.useTelnum}";
		parameters['telnumType'] = "1";
		confirmMsg = "<spring:message code='to.useNum' />";
	}else{
		parameters['directInput'] = $("#userTelNum").val();
		parameters['telnumType'] = "2";
		confirmMsg = $("#userTelNum").val() + "<spring:message code='to.customNum' />";
	}

	if(!confirm(confirmMsg + " " + "<spring:message code='to.sendAllocatedNum' />")){
	    return;
    }

	$.ajax({
		type:"post",
		dataType:"json",
		url:"/web/sendMMSmsg.ajax",
		data:parameters ,
		success:function(data){
			alert(data.success);
		}
	});
}

function sendLscompanyMMS(prdtRsvNum){
    var parameters = "spRsvNum=" + prdtRsvNum;

	$.ajax({
		type:"post",
		dataType:"json",
		url:"/apiLs/sendLscompanyMMSmsg.ajax",
		data:parameters ,
		success:function(data){
			alert(data.success);
		}
	});
}

function sendLscompanyOrderChk(prdtRsvNum,prdtCnt){
    let parameters = "spRsvNum="+prdtRsvNum+"&buyNum="+prdtCnt;
	$.ajax({
		type:"post",
		dataType:"json",
		url:"/apiLs/sendLscompanyOrderChk.ajax",
		data:parameters ,
		success:function(data){

			for (var key in data){
				if(key != "searchVO"){
					alert("예약번호: " + key + ", 상태: " + data[key]);
				}
			}
		}
	});
}

function sendVpassOrderChk(rsvNum,prdtRsvNum,prdtCnt){
    let parameters = "rsvNum="+rsvNum+"&spRsvNum="+prdtRsvNum+"&buyNum="+prdtCnt;
	$.ajax({
		type:"post",
		dataType:"json",
		url:"/apiVp/sendLscompanyOrderChk.ajax",
		data:parameters ,
		success:function(data){

			for (var key in data){
				if(key != "searchVO"){
					let strFlag = "";
					if(data[key] == "Y"){
						strFlag = "취소가능"
					}else if(data[key] == "N"){
						strFlag = "취소불가"
					}else if(data[key] == "C"){
						strFlag = "취소완료"
					}

					alert("예약번호: " + key + ", 상태: " + strFlag);
				}
			}
		}
	});
}

function sendVpassMMS(rsvNum,prdtRsvNum,useTelnum){
    var parameters = "rsvNum=" + rsvNum+"&spRsvNum=" + prdtRsvNum+"&useTelnum=" + useTelnum;

	$.ajax({
		type:"post",
		dataType:"json",
		url:"/apiVp/sendVpassMMSmsg.ajax",
		data:parameters ,
		success:function(data){
			alert(data.success);
		}
	});
}

function fn_PopupCall(subject, noticeNum) {
	// 상위 이벤트 방지
	event.stopPropagation();

	var parameters = "bbsNum=CALL&userId=" + $("#userId").val() + "&subject=" + subject;

	$.ajax({
		type:"post",
		url:"<c:url value='/oss/noticeDetail.ajax'/>",
		data:parameters,
		success:function(data){
			var call = data.result;

			$("#noticeNum").val("");
			$("#hrkNoticeNum").val("");
			$("#ansSn").val("");
			$("#callContents").val("");

			if(call.length > 0) {
				$.each(call, function(i){
					if(i == 0) {
						$("#hrkNoticeNum").val(this.noticeNum);
					}
					if(this.noticeNum == noticeNum) {
						$("#noticeNum").val(this.noticeNum);
						$("#hrkNoticeNum").val(this.hrkNoticeNum);
						$("#ansSn").val(this.ansSn);
						$("#callContents").val(this.contents);
					}
				});
			}
			$("#callSubject").val(subject);
			$("#popupCall").show();
		},
		error:fn_AjaxError
	});
}

function fn_SaveCall() {
	if($("#callContents").val().trim() == "") {
		alert("<spring:message code="errors.required2" arguments="내용" />");
		return false;
	}
	var parameters = $("#frmCall").serialize();

	$.ajax({
		type:"post",
		url:"<c:url value='/oss/saveCall.ajax'/>",
		data:parameters,
		success:function(data){
			$("#popupCall").hide();
			alert(data.resultMsg);

			fn_CallList();
		},
		error:fn_AjaxError
	});
}

function fn_CallList() {
	var parameters = "bbsNum=CALL&subject=" + $("#callSubject").val();

	$.ajax({
		type:"post",
		url:"<c:url value='/oss/noticeList.ajax'/>",
		data:parameters,
		success:function(data){
			var addHtml = "";

			$.each(data.result, function(){
				addHtml += "<tr>";
				addHtml += "<td class=\"align_ct\">" + this.subject + "</td>";
				addHtml += "<td>";
				addHtml += "<table class=\"table_noline\">";
				addHtml += "<tr>";
				addHtml += "<td>";
				for(var i=1; i <= this.ansSn; i++) {
					addHtml += "&nbsp;&nbsp;";
					if(this.ansSn == i) {
						addHtml += "└&nbsp;";
					}
				}
				addHtml += "</td>";
				addHtml += "<td style=\"white-space:pre-wrap;\">" + this.contents + "</td>";
				addHtml += "</tr>";
				addHtml += "</table>";
				addHtml += "</td>";
				addHtml += "<td class=\"align_ct\">" + this.writer + "</td>";
				addHtml += "<td class=\"align_ct\">" + this.frstRegDttm + "</td>";
				addHtml += "<td class=\"align_ct\">" + this.frstRegId + "</td>";
				addHtml += "<td class=\"align_ct\">" + this.lastModDttm + "</td>";
				addHtml += "<td class=\"align_ct\">" + this.lastModId + "</td>";
				addHtml += "<td class=\"align_ct\"><div class=\"btn_sty09\"><span><a href=\"javascript:void(0)\" onclick=\"fn_PopupCall('" + this.subject + "', '" + this.noticeNum + "');\">수정</a></span></div></td>";
				addHtml += "</tr>";
			});

			$("#callCount").html(data.result.length);
			$("#tbCall").html(addHtml);
		},
		error:fn_AjaxError
	});
}

// 사용자 상세
function fn_DetailUser() {
	location.href = "<c:url value='/oss/detailUser.do'/>?userId=${rsvInfo.userId}";
}

//취소 증빙자료 OSS 에서 파일 제출
function fn_updateFile(dtlRsvNum){
	var form = $('#frm'+ dtlRsvNum)[0];
	var data = new FormData(form);

	$.ajax({
		type:"post",
		enctype: 'multipart/form-data',
		url:"<c:url value='/web/mypage/uploadRsvFile.ajax'/>",
		data: data,
		processData: false,
		contentType: false,
		success:function(data){
			if (data.Status == 'success') {
				alert('증빙자료가 제출 되었습니다.');
				location.reload();
			}
		},
		error : fn_AjaxError
	});
}

//취소 중빙자료 삭제
function fn_rsvFileDelete(xSeq, xSavePath, xSaveFileNm){
	if (confirm('첨부 파일을 삭제하겠습니까?')) {
		$.ajax({
			type:"post",
			url:"<c:url value='/web/mypage/deleteRsvFile.ajax'/>",
			data:"seq=" + xSeq + "&savePath=" + xSavePath + "&saveFileNm=" + xSaveFileNm,
			success:function(data){
				if (data.Status == 'success') {
					alert('파일을 삭제 했습니다.');
					location.reload();
				}
			},
			error : fn_AjaxError
		});
	}
}

function fn_upRsvInfo(xRsvNum){

	const rsvHyphenCount  = ($('#rsvTelnum').val().match(/-/g) || []).length;
	const useHyphenCount  = ($('#useTelnum').val().match(/-/g) || []).length;

	if(rsvHyphenCount < 1 || useHyphenCount< 1) {
		alert("하이픈을 넣어 주세요.");
		return;
	}

	const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	if(!emailPattern.test($('#rsvEmail').val())) {
		$('#rsvEmail').focus();
		alert("예약자 이메일 형식이 올바르지 않습니다.");
		return;
	}
	if(!emailPattern.test($('#useEmail').val())) {
		$('#useEmail').focus();
		alert("사용자 이메일 형식이 올바르지 않습니다.");
		return;
	}

	const parameters = $("#frmRsvInfo").serialize() + "&rsvNum=" + xRsvNum;
	$.ajax({
		type:"post",
		dataType:"json",
		async:false,
		url:"<c:url value='/oss/updateRsvInfo.ajax'/>",
		data:parameters ,
		success:function(data){
			alert("정상적으로 처리됐습니다.");
		},
		error:fn_AjaxError
	});
}

$(document).ready(function(){
	// 팝업 이동
	$("#popupCall").draggable();

	$('.phone-number').on('input', function() {
		var input = $(this).val();
		var filteredInput = input.replace(/[^0-9-]/g, '');
		$(this).val(filteredInput);

		if(input === filteredInput) {
			$('#result').text('');
		}
	})
});
</script>
</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/oss/head.do?menu=rsv" />
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=rsv&sub=rsv" />
		<div id="contents_area"> 
			<form name="frm" method="post">
				<input type="hidden" name="rsvNum" id="rsvNum" value="${rsvInfo.rsvNum}" />
				<input type="hidden" name="sRsvNm" id="sRsvNm" value="${searchVO.sRsvNm}" />
				<input type="hidden" name="sStartDt" id="sStartDt" value="${searchVO.sStartDt}" />
				<input type="hidden" name="sEndDt" id="sEndDt" value="${searchVO.sEndDt}" />
				<input type="hidden" name="sAutoCancelViewYn" id="sAutoCancelViewYn" value="${searchVO.sAutoCancelViewYn}" />
				<input type="hidden" name="sRsvTelnum" id="sRsvTelnum" value="${searchVO.sRsvTelnum}" />
				<input type="hidden" name="userId" value="${searchVO.userId}" />
			</form>
			<div id="contents">
			<!--본문-->
			<!--상품 등록-->
					<ul class="form_area">
						<li>
							<form name="frmRsvInfo" id="frmRsvInfo" method="post" onSubmit="return false;">
							<table border="1" cellpadding="0" cellspacing="0" class="table02">
								<article class="payArea userWrap1">
								<h5 class="title">예약 기본 정보<div class="btn_sty03"><a href="javascript:fn_upRsvInfo('${rsvInfo.rsvNum}')">수정</a></div></h5>
								</article>
								<colgroup>
									<col width='15%' />
									<col width='35%' />
								<col width='15%' />
								<col width='35%' />
							</colgroup>
							<tr>
								<th> 예약번호 </th>
								<td colspan="3"><c:out value="${rsvInfo.rsvNum}"/></td>
							</tr>
							<tr>
								<th>예약자명</th>
								<td>
									<input type="text" name="rsvNm" id="rsvNm" value="${rsvInfo.rsvNm}" />
									<div class="btn_sty07"><span><a href="javascript:void(0)" onclick="fn_DetailUser();">사용자 정보</a></span></div>
								</td>
								<th>사용자명</th>
								<td><input type="text" name="useNm" id="useNm" value="${rsvInfo.useNm}" /></td>
							</tr>
							<tr>
								<th>예약자 이메일</th>
								<td><input type="text" name="rsvEmail" id="rsvEmail" size="40" value="${rsvInfo.rsvEmail}" /></td>
								<th>사용자 이메일</th>
								<td><input type="text" name="useEmail" id="useEmail" size="40" value="${rsvInfo.useEmail}" /></td>
							</tr>
							<tr>
								<th>예약자 전화번호</th>
								<td><input type="text" name="rsvTelnum" id="rsvTelnum" class="phone-number" value="${rsvInfo.rsvTelnum}" onkeyup="addHyphenToPhone(this);" /></td>
								<th>사용자 전화번호</th>
								<td><input type="text" name="useTelnum" id="useTelnum" class="phone-number" value="${rsvInfo.useTelnum}" onkeyup="addHyphenToPhone(this);" /></td>
							</tr>
						</table>
						</form>
					</li>
					<li>
						<table border="1" cellpadding="0" cellspacing="0" class="table01">
							<caption class="tb02_title">결제 정보</caption>
							<thead>
								<tr>
									<th scope="col">총상품금액</th>
									<th scope="col">결제금액</th>
									<th scope="col">L.Point 사용</th>
									<th scope="col">${rsvInfo.partnerNm} Point 사용</th>
									<th scope="col">쿠폰할인금액</th>
									<th scope="col">결제수단</th>
								</tr>
							</thead>
							<tr>
								<td class="align_ct"><fmt:formatNumber><c:out value="${rsvInfo.totalNmlAmt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${rsvInfo.totalSaleAmt}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${rsvInfo.lpointUsePoint}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${rsvInfo.usePoint}"/></fmt:formatNumber></td>
								<td class="align_ct"><fmt:formatNumber><c:out value="${rsvInfo.totalDisAmt}"/></fmt:formatNumber></td>
								<td class="align_ct">
									<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_CI}">카드결제</c:if>
									<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_HI}">휴대폰결제</c:if>
									<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_TI}">계좌이체</c:if>
									<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_ETI}">계좌이체(에스크로)</c:if>
									<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_MI}">무통장입금</c:if>
									<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_EMI}">무통장입금(에스크로)</c:if>
									<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_KI}">카카오페이</c:if>
									<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_LI}">L.Point결제</c:if>
									<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_NV_SI}">스마트스토어</c:if>
									<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_NV_LI}">라이브커머스</c:if>
									<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_TA_PI}">포인트결제</c:if>
									<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_TC_WI}">탐나는전(PC)</c:if>
									<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_TC_MI}">탐나는전<br>(모바일)</c:if>
									<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_KP}">카카오페이</c:if>
									<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_NP}">네이버페이</c:if>
									<c:if test="${rsvInfo.payDiv eq Constant.PAY_DIV_LG_AP}">애플페이</c:if>
								</td>
							</tr>
						</table>
					</li>
					<c:if test="${(rsvInfo.LGD_CASFLAGY eq 'R') or (rsvInfo.LGD_CASFLAGY eq 'I') or (rsvInfo.LGD_CASFLAGY eq 'C') }">
						<li>
							<table border="1" cellpadding="0" cellspacing="0" class="table01">
								<caption class="tb02_title">무통장입금 정보</caption>
								<thead>
									<tr>
										<th scope="col">은행</th>
										<th scope="col">가상계좌</th>
										<th scope="col">입금자명</th>
										<th scope="col">입금상태</th>
									</tr>
								</thead>
								<tr>
									<td class="align_ct">${rsvInfo.LGD_FINANCENAME}</td>
									<td class="align_ct">${rsvInfo.LGD_ACCOUNTNUM}</td>
									<td class="align_ct">${rsvInfo.LGD_PAYER}</td>
									<td class="align_ct">
										<c:if test="${rsvInfo.LGD_CASFLAGY eq 'R'}">입금대기</c:if>
										<c:if test="${rsvInfo.LGD_CASFLAGY eq 'I'}">입금완료</c:if>
										<c:if test="${rsvInfo.LGD_CASFLAGY eq 'C'}">입금취소</c:if>
									</td>
								</tr>
							</table>
						</li>
					</c:if>
					<li>
						<table border="1" cellpadding="0" cellspacing="0" class="table03">
							<caption class="tb02_title">예약 상품 정보</caption>
							<c:set var="acceptExt" value="${Constant.FILE_CHECK_EXT}" />
							<c:forEach items="${orderList}" var="order" varStatus="status">
								<tr class="bg01">
									<th scope="col">[${order.prdtCdNm}] <span class="font03">${order.prdtNm}</span></th>
									<th scope="col">상품번호 : ${order.prdtNum}
										<span class="font03">
											<c:choose>
												<c:when test="${order.prdtCd eq 'RC'}">
													<a target="_blank" href="/web/rentcar/car-detail.do?prdtNum=${order.prdtNum}">[상품바로가기]</a></span>
												</c:when>
												<c:when test="${order.prdtCd eq 'AD'}">
													<span class="font03"><a target="_blank" href="/web/ad/detailPrdt.do?sPrdtNum=${order.prdtNum}">[상품바로가기]</a></span>
												</c:when>
												<c:otherwise>
													<span class="font03"><a target="_blank" href="/web/sp/detailPrdt.do?prdtNum=${order.prdtNum}">[상품바로가기]</a></span>
												</c:otherwise>
											</c:choose>
										</span>
									</th>
									<th scope="col" >업체명 : ${order.corpNm} <span class="font03">
									<c:if test="${ssPartnerCode eq 'tamnao'}">
									<a href="javascript:fn_LoginMas('${order.corpId}');">[업체바로가기]</a>
									<a href="javascript:fn_LoginMasRsv('${order.corpId}','${rsvInfo.rsvNm}','${rsvInfo.rsvTelnum}','${order.prdtCd}');">[예약바로가기]</a>
									</c:if>
									</span></th>
									<th scope="col" >예약상태 :
										<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_READY}">예약처리중</c:if>
										<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_COM}">예약</c:if>
										<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ}">
											<span class="font02">취소요청</span>
											(<c:out value="${order.cancelRequestDttm}"/>)
										</c:if>
										<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2}">환불요청</c:if>
										<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM}">취소완료</c:if>
										<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_SREQ}">부분환불요청</c:if>
										<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_SCOM}">부분환불완료
										<c:if test="${order.prdtDiv eq Constant.SP_PRDT_DIV_COUP}">
											(<c:out value="${order.useDttm}"/>)
										</c:if>
										</c:if>
										<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_ACC}">자동취소</c:if>
										<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_UCOM}">
											사용완료
											<c:if test="${order.prdtDiv eq Constant.SP_PRDT_DIV_COUP}">
													(<c:out value="${order.useDttm}"/>)
											</c:if>
										</c:if>
										<c:if test="${order.rsvStatusCd eq Constant.RSV_STATUS_CD_ECOM}">기간만료</c:if>
<%--										<c:if test="${order.adjYn eq 'N' and (order.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ or order.rsvStatusCd eq Constant.RSV_STATUS_CD_UCOM or (order.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM and order.saleAmt eq order.cmssAmt))}">--%>
<%--											<li class="btn_sty03">--%>
<%--												<a href="javascript:fn_chgRsvStatus('${order.prdtRsvNum}','RS02','')">예약(변경)</a>--%>
<%--										</c:if>--%>
										<c:if test="${order.adjYn eq 'N' and (order.rsvStatusCd eq Constant.RSV_STATUS_CD_COM)}">
<%--											</li>--%>
											<li class="btn_sty03">
												<a href="javascript:fn_chgRsvStatus('${order.prdtRsvNum}','RS10','','${order.prdtCd}')">취소처리</a>
											</li>
										</c:if>
<%--										<c:if test="${order.adjYn eq 'N' and (order.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM) and order.disAmt eq '0'}">--%>
<%--											</li>--%>
<%--											<li class="btn_sty03">--%>
<%--												<a href="javascript:fn_chgRsvStatus('${order.prdtRsvNum}','RS02','RS20')">예약(변경)</a>--%>
<%--											</li>--%>
<%--										</c:if>--%>
									</th>
								</tr>
								<tr>
									<td colspan="4">
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_noline">
											<caption class="tb04_title">예약정보 상세
												<c:if test="${order.lsLinkYn eq 'Y'}">
													<span class="font03"><a href="javascript:sendLscompanyOrderChk('${order.prdtRsvNum}',${order.prdtCnt});">[LS상품주문확인]</a></span>
													<span class="font03"><a href="javascript:sendLscompanyMMS('${order.prdtRsvNum}');">[문자재전송]</a></span>
												</c:if>
												<c:if test="${order.lsLinkYn eq 'V'}">
													<span class="font03"><a href="javascript:sendVpassOrderChk('${rsvInfo.rsvNum}','${order.prdtRsvNum}',${order.prdtCnt});">[브이패스상품주문확인]</a></span>
													<span class="font03"><a href="javascript:sendVpassMMS('${rsvInfo.rsvNum}','${order.prdtRsvNum}','${rsvInfo.useTelnum}');">[문자재전송]</a></span>
												</c:if>
											</caption>
											<tr class="tr_line">
												<td>
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<colgroup>
														<col width="20%" />
														<col width="80%" />
														</colgroup>
														<tr>
															<th scope="col">ㆍ예약정보</th>
															<td><c:out value="${order.prdtInf}"/></td>
														</tr>
													</table>
												</td>
											</tr>
											<tr>
												<td>
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<colgroup>
															<col width="6%" />
															<col width="10%" />
															<col width="6%" />
															<col width="10%" />
															<col width="6%" />
															<col width="9%" />
															<col width="6%" />
															<col width="25%" />
															<col width="8%" />
															<col width="15%" />
														</colgroup>
														<tr>
															<th scope="col">ㆍ상품금액</th>
															<td><strong><fmt:formatNumber><c:out value="${order.nmlAmt}"/></fmt:formatNumber></strong> 원</td>
															<th scope="col">ㆍ판매금액</th>
															<td><strong class="font03">
																<fmt:formatNumber><c:out value="${order.saleAmt}"/></fmt:formatNumber></strong> 원
																<c:if test="${order.payPoint > 0}">
																(中 파트너 Point <fmt:formatNumber><c:out value="${order.payPoint}"/></fmt:formatNumber> 원)
																</c:if>
															</td>
															<th scope="col">ㆍ쿠폰금액</th>
															<td><strong><fmt:formatNumber><c:out value="${order.disAmt}"/></fmt:formatNumber></strong> 원</td>
															<th scope="col">ㆍ쿠폰명</th>
															<td class="font03" onclick="fn_rcpInfo('${rsvInfo.userId}', '${order.cpId}')" style="cursor: pointer;"><strong >${order.cpNm}</td>
															<th scope="col">ㆍL.Point 적립</th>
															<td><strong class="font03"><c:if test="${rsvInfo.lpointSavePoint > 0 }"><fmt:formatNumber><c:out value="${order.saleAmt * Constant.LPOINT_SAVE_PERCENT / 100 / 10 * 10 }"/></fmt:formatNumber></c:if><c:if test="${rsvInfo.lpointUsePoint > 0 or rsvInfo.lpointSavePoint eq 0 }">0</c:if></strong> 원</td>
														</tr>
													</table>
												</td>
											</tr>
											<c:if test="${(order.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ)
														or (order.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2)
														or (order.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM)}">
												<tr class="tr_line">
													<td>
														<table width="100%" border="0" cellspacing="0" cellpadding="0">
															<colgroup>
																<col width="10%">
																<col width="*">
															</colgroup>
															<tbody>
																<tr>
																	<th scope="col">ㆍ취소사유</th>
																	<td style="text-align: left"><c:out value="${order.cancelRsn}"/></td>
																</tr>
															</tbody>
														</table>
													</td>
												</tr>
											</c:if>

											<c:if test="${(order.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ) or (order.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2)}">
											<tr>
												<td>

													<form name='frm<c:out value="${order.prdtRsvNum}" />' id='frm<c:out value="${order.prdtRsvNum}" />' method="post" onSubmit="return false;" enctype="multipart/form-data">
														<input type="hidden" name="rsvNum" value="${rsvInfo.rsvNum}" />
														<input type="hidden" name="category" value="PROVE_OSS" /> <!--증빙자료 OSS에서 UPLOAD-->
														<input type="hidden" name="dtlRsvNum" value="${order.prdtRsvNum}" />


													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<colgroup>
															<col width="20%">
															<col width="50%">
															<col width="*">
														</colgroup>
														<tbody>
														<tr>
															<th scope="col"> ㆍ취소관련 증빙자료</th>
															<td>
																<c:set var="fileCnt" value="1" />
																<c:forEach items="${fileList }" var="file" varStatus="stat">
																	<c:if test="${file.dtlRsvNum eq order.prdtRsvNum}">
																		<p class="file" id="fileTool_${stat.index }">${file.realFileNm } <a href="javascript:fn_rsvFileDelete('${file.seq}','${file.savePath}','${file.saveFileNm}')">[삭제]</a></p>
																		<c:set var="fileCnt" value="${fileCnt + 1}" />
																	</c:if>
																</c:forEach>

																<c:forEach var="i" begin="${fileCnt}" end="2">
																	<p class="file"><input type="file" name="file_${order.prdtRsvNum}_${i}" onchange="checkFile(this, '${acceptExt}', 5)"></p>
																</c:forEach>
															</td>
															<td>
																<div class="btn_sty01">
																	<!--증빙자료 2개 올렸으면 제출 버튼 막음-->
																	<c:if test="${fileCnt ne 3 }">
																		<a class="color1" href="javascript:fn_updateFile('${order.prdtRsvNum}')">제출</a>
																	</c:if>
																	<c:if test="${fileCnt eq 3 }">
																		<a href="javascript:alert('증빙자료는 두개까지 올리실 수 있습니다.');">제출</a>
																	</c:if>
																</div>
															</td>
														</tr>
														</tbody>
													</table>
													</form>
												</td>
											</tr>
											</c:if>
										</table>
									</td>
								</tr>
								<c:if test="${	(order.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2) or
												(order.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM) or
												(order.rsvStatusCd eq Constant.RSV_STATUS_CD_SREQ) or
												(order.rsvStatusCd eq Constant.RSV_STATUS_CD_SCOM)}">
									<tr class="bg02">
										<td colspan="4">
											<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_noline">
												<caption class="tb04_title font02">예약취소 상세</caption>
												<tr>
													<td>
														<table width="100%" border="0" cellspacing="0" cellpadding="0">
															<colgroup>
																<col width="8%" />
																<col width="15%" />
																<col width="10%" />
																<col width="20%" />
																<col width="8%" />
																<col width="15%" />
																<col width="8%" />
																<col width="15%" />
																<col width="*" />
															</colgroup>
															<tr>
																<th scope="col">ㆍ환불 결제금액</th>
																<td><strong class="font03"><fmt:formatNumber><c:out value="${order.cancelAmt}"/></fmt:formatNumber></strong> 원</td>
																<th scope="col">ㆍ환불 파트너 Point</th>
																<td><strong class="font03"><fmt:formatNumber><c:out value="${rsvInfo.usePoint - order.usePoint}"/></fmt:formatNumber></strong> 원</td>
																<th scope="col">ㆍ환불 쿠폰금액</th>
																<td><strong class="font03"><fmt:formatNumber><c:out value="${order.disCancelAmt}"/></fmt:formatNumber></strong> 원</td>
																<th scope="col" class="font02">ㆍ취소 수수료</th>
																<td><strong class="font02">
																	<fmt:formatNumber><c:out value="${order.cmssAmt}"/></fmt:formatNumber></strong> 원
																	<c:if test="${order.usePoint > 0}">
																	( 中 파트너 Point <fmt:formatNumber><c:out value="${order.usePoint}"/></fmt:formatNumber>원)
																	</c:if>
																</td>
																<td>
																	<c:if test="${(order.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2) or (order.rsvStatusCd eq Constant.RSV_STATUS_CD_SREQ)}">
																		<div class="btn_sty09">
																			<a href="javascript:fn_RefundComplete('${order.prdtRsvNum}')">환불 완료</a>
																		</div>
																	</c:if>
																</td>
															</tr>
														</table>
													</td>
												</tr>
											</table>
										</td>
									</tr>
								</c:if>
							</c:forEach>
						</table>
					</li>
					<li>
						<table class="table01">
							<caption class="tb02_title">상담 정보</caption>
							<colgroup>
								<col width="120" />
								<col />
								<col width="120" />
								<col width="100" />
								<col width="100" />
								<col width="100" />
								<col width="100" />
								<col width="100" />
							</colgroup>
							<thead>
							<tr>
								<th>예약번호</th>
								<th>내용</th>
								<th>작성자</th>
								<th>등록일시</th>
								<th>등록ID</th>
								<th>수정일시</th>
								<th>수정ID</th>
								<th>기능툴</th>
							</tr>
							</thead>
							<tbody id="tbCall">
								<c:if test="${fn:length(callList) == 0}">
									<tr>
										<td colspan="8" class="align_ct"><spring:message code="info.nodata.msg" /></td>
									</tr>
								</c:if>
								<c:forEach var="call" items="${callList}" varStatus="stauts">
									<tr>
										<td class="align_ct">${call.subject}</td>
										<td>
											<table class="table_noline">
												<tr>
													<td>
														<c:forEach var="i" begin="1" end="${call.ansSn}">
															&nbsp;&nbsp;<c:if test="${call.ansSn == i}">└&nbsp;</c:if>
														</c:forEach>
													</td>
													<td style="white-space:pre-wrap;"><c:out value="${call.contents}" escapeXml="false" /></td>
												</tr>
											</table>
										</td>
										<td class="align_ct">${call.writer}</td>
										<td class="align_ct">${call.frstRegDttm}</td>
										<td class="align_ct">${call.frstRegId}</td>
										<td class="align_ct">${call.lastModDttm}</td>
										<td class="align_ct">${call.lastModId}</td>
										<td class="align_ct">
											<div class="btn_sty09"><span><a href="javascript:void(0)" onclick="fn_PopupCall('${call.subject}', '${call.noticeNum}');">수정</a></span></div>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</li>
				</ul>
				<!--//상품등록-->
				<!--//본문-->
				<ul class="btn_rt01">
					<c:if test="${ssPartnerCode eq 'tamnao'}">
					<li class="btn_sty04"><a href="javascript:void(0)" onclick="fn_PopupCall('${rsvInfo.rsvNum}', null);">상담등록</a></li>
					</c:if>
					<li class="btn_sty01"><a href="javascript:void(0)" onclick="fn_ListRsv();">목록</a></li>
				</ul>
			</div>
		</div>
	</div>
	<!--//Contents 영역-->
	<div id="popupCall" class="lay_popup lay_ct" style="display:none;">
		<span class="popup_close"><a href="javascript:void(0);" onclick="close_popup($('#popupCall'));" title="창닫기"><img src="/images/oss/btn/close_btn03.gif" alt="닫기" /></a></span>
		<ul class="form_area">
			<li>
				<h5 class="title06">상담 정보</h5>
				<form name="frmCall" id="frmCall" method="post" onSubmit="return false;">
					<input type="hidden" name="noticeNum" id="noticeNum">
					<input type="hidden" name="hrkNoticeNum" id="hrkNoticeNum">
					<input type="hidden" name="ansSn" id="ansSn">
					<input type="hidden" name="userId" id="userId" value="${rsvInfo.userId}">

					<table class="table02" border="1" cellpadding="0" cellspacing="0">
						<colgroup>
							<col width="110" />
							<col width="*" />
						</colgroup>
						<tr>
							<th>예약번호</th>
							<td><input type="text" name="subject" id="callSubject" readonly="readonly"></td>
						</tr>
						<tr>
							<th>내용</th>
							<td><textarea name="contents" id="callContents" rows="10" cols="100"></textarea></td>
						</tr>
					</table>
				</form>
			</li>
		</ul>
		<div class="btn_ct01"><span class="btn_sty04"><a href="javascript:void(0)" onclick="fn_SaveCall();">저장</a></span></div>
	</div>
</div>
</body>
</html>