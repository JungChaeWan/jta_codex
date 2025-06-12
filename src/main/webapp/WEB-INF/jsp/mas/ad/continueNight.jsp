<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<%@page import="java.awt.print.Printable"%>
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
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>


<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">

/**
 * 목록
 */
function fn_ListPrdt(){
	document.prdtImg.action = "<c:url value='/mas/ad/productList.do'/>";
	document.prdtImg.submit();
}


/**
 * 상품 승인 요청
 */
function fn_ApprovalReqPrdt(){
	$.ajax({
		url : "<c:url value='/mas/ad/approvalPrdt.ajax'/>",
		dataType:"json",
		data : "prdtNum=${adPrdinf.prdtNum}",
		success: function(data) {
			//location.reload(true);
			location.href = "<c:url value='/mas/ad/imgList.do'/>?prdtNum=${adPrdinf.prdtNum}";
		},
		error : function(request, status, error) {
			if(request.status == "500"){
				alert("<spring:message code='fail.common.logout'/>");
				location.reload(true);
			}else{
				alert("<spring:message code='fail.common.msg'/>");
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		}
	});
}

/**
 * 상품 승인 취소 요청
 */
function fn_CancelApproval(){
	$.ajax({
		url : "<c:url value='/mas/ad/cancelApproval.ajax'/>",
		dataType:"json",
		data : "prdtNum=${adPrdinf.prdtNum}",
		success: function(data) {
			//location.reload(true);
			location.href = "<c:url value='/mas/ad/imgList.do'/>?prdtNum=${adPrdinf.prdtNum}";
		},
		error : function(request, status, error) {
			if(request.status == "500"){
				alert("<spring:message code='fail.common.logout'/>");
				location.reload(true);
			}else{
				alert("<spring:message code='fail.common.msg'/>");
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		}
	});
}



$(document).ready(function(){
	
	$("#startDt").datepicker({
		dateFormat: "yy-mm-dd",
		minDate: "${today}",
		maxDate: '+1y',
		onClose : function(selectedDate) {
			$("#endDt").datepicker("option", "minDate", selectedDate);
		}
	});

	$("#endDt").datepicker({
		dateFormat: "yy-mm-dd",
		minDate: "${today}",
		maxDate: '+10y',
		changeMonth: true,
		changeYear: true
	});

	// 연박 적용 여부 select
	$('#ctnAplYn').click(function() {
		var aplYn = $(this).prop('checked') ? 'Y' : 'N';
		$.ajax({
			url : "<c:url value='/mas/ad/updateCtnAplYn.ajax'/>",
			dataType : "json",
			data : "prdtNum=${adPrdinf.prdtNum}&ctnAplYn=" + aplYn,
			success : function(data) {
				alert('연박 적용여부를 변경했습니다.;')
			},
			error : function(request, status, error) {
				if(request.status == "500"){
					alert("<spring:message code='fail.common.logout'/>");
					location.reload(true);
				}else{
					alert("<spring:message code='fail.common.msg'/>");
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			}
		});
	});

	// 기간 관리 등록
	$("#actionPeriodBtn").click(function() {
		<c:forEach items="${ctnInfoList }" var="ctn" varStatus="sts">
		if($("#actionPeriodBtn").text() == "수정"){
			if("${ctn.ctnInfSn}" !=  $("input[name=ctnInfSn]").val()){
				$("input[name=ctnInfSn]").val()
				if("${ctn.startDt}" <= $('#endDt').val().replace(/-/gi,"") && "${ctn.endDt}" >= $('#startDt').val().replace(/-/gi,"") ){
					alert("날짜 범위가 중복됩니다.");
					return;
				}	
			}
		}else{
			if("${ctn.startDt}" <= $('#endDt').val().replace(/-/gi,"") && "${ctn.endDt}" >= $('#startDt').val().replace(/-/gi,"") ){
				alert("날짜 범위가 중복됩니다.");
				return;
			}
		}	
			
	    </c:forEach>
		
		if ($('#startDt').val() == "") {
			alert("적용 기간 시작 일자를 선택 하세요.");
			return;
		}
		if ($('#endDt').val() == "") {
			alert("적용 기간 종료 일자를 선택 하세요.");
			return;
		}

		$('#ctnForm').submit();
	});

	// 기간 관리 수정폼
	$('.modifyBtn').click(function() {
		$('.modifyBtn').show();
		$('#price_area').hide();

		$.obj = $(this);
		$.infSn = $.obj.attr('alt');
		$.ajax({
			url : "<c:url value='/mas/ad/ctnInfModify.ajax'/>",
			dataType : "json",
			data : "prdtNum=${adPrdinf.prdtNum}&ctnInfSn=" + $.infSn,
			success : function(data) {
				$('#startDt').val(data.ctnInf.startDt.substring(0, 4) + '-' + data.ctnInf.startDt.substring(4, 6) + '-' + data.ctnInf.startDt.substring(6, 8));
				$('#endDt').val(data.ctnInf.endDt.substring(0, 4) + '-' + data.ctnInf.endDt.substring(4, 6) + '-' + data.ctnInf.endDt.substring(6, 8));
				$('input[name=ctnExp]').val(data.ctnInf.ctnExp);

				$('input[name=ctnInfSn]').val($.infSn);
				$('#actionPeriodBtn').text('수정');
				$('#resetPeriodBtn').text('취소');
				$($.obj).hide();
			},
			error : function(request, status, error) {
				if(request.status == "500"){
					alert("<spring:message code='fail.common.logout'/>");
					location.reload(true);
				}else{
					alert("<spring:message code='fail.common.msg'/>");
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			}
		});
	});

	// 기간 관리 초기화
	$("#resetPeriodBtn").click(function() {
		$('#ctnForm').each(function() {
			this.reset();
		})
		$('#actionPeriodBtn').text('추가');
		$('#resetPeriodBtn').text('초기화');
		$('.modifyBtn').show();
	});
	
	// 기간 삭제
	$('.delPeriodBtn').click(function() {
		if (confirm('[ ' + $('#ctnStr' + $(this).attr('alt')).text() + ' ] 기간을 삭제하겠습니까?\n(복구 불가)')) {
			console.log("ctnInfSn => " + $(this).attr('alt'));
			
			location.href = "<c:url value='/mas/ad/deleteCtnInf.do'/>?prdtNum=${adPrdinf.prdtNum}&ctnInfSn=" + $(this).attr('alt');
		}
		return false;
	});

	// 요금 리스트 출력
	$('.priceBtn').click(function() {
		$(".ctnInfSn").val($(this).attr('alt'));

		$.ajax({
			url : "<c:url value='/mas/ad/selectCtnAmt.ajax'/>",
			dataType : "json",
			data : "prdtNum=${adPrdinf.prdtNum}&ctnInfSn=" + $(".ctnInfSn").val(),
			success : function(data) {
				for (var bak=1; bak<=5; bak++) {
					//$('#priceType_' + bak).text(data[bak].amtDiv == 'A' ? '원' : '%');
					//$('#amtDiv_' + data[bak].amtDiv + '_' + bak).prop('checked', true);

					if (data[bak] != undefined && data[bak].disAmt != null && data[bak].disAmt != 0) {
						$('#disAmt_' + bak).prop('disabled', false);
						$('#disAmt_' + bak).val(data[bak].disAmt);
						$('input[name=checkApl_' + bak + ']').prop('checked', true);
					} else {
						$('#disAmt_' + bak).val('');
						$('#disAmt_' + bak).prop('disabled', true);
						$('input[name=checkApl_' + bak + ']').prop('checked', false);
					}
				}

				// 금액 소숫점 추가
			    $('.numFormat').each(function() {
			    	$(this).val($(this).val().replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'));
			    });
			},
			error : function(request, status, error) {
				if(request.status == "500"){
					alert("<spring:message code='fail.common.logout'/>");
					location.reload(true);
				}else{
					alert("<spring:message code='fail.common.msg'/>");
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			}
		});

		$('#price_area').show();
	});

	// 요금 관리 초기화
	$("#resetAmtBtn").click(function() {
		$('#ctnAmt').each(function() {
			this.reset();
		})
	});
	
	// 요금 관리 등록
	$("#actionAmtBtn").click(function() {
		for (var i=1; i<=5; i++) {
			if ($('input[name=checkApl_' + i + ']').prop('checked')) {
				if ($('#disAmt_' + i).val() == "") {
					alert(i + "박의 값을 입력하세요.");
					$('#disAmt_' + i).focus();
					return;
				}
			}
		}

		// 콤마 제거
		delCommaFormat();

		var param = $("#ctnAmt").serialize();
		$.ajax({
			type:"post",
			url:"<c:url value='/mas/ad/actionCtnAmt.ajax' />",
			data : param,
			success:function(data) {
				$('#continueAmt_' + data['ctnAmt'].ctnInfSn).html(data['amtStr'].replace(/@/gi, '<br>'));

				// 금액 소숫점 추가
			    $('.numFormat').each(function() {
			    	$(this).val($(this).val().replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'));
			    });

				alert("수정되었습니다.");
			},
			error : function(request, status, error) {
				if(request.status == "500"){
					alert("<spring:message code='fail.common.logout'/>");
					location.reload(true);
				}else{
					alert("<spring:message code='fail.common.msg'/>");
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			}
		});
	});

	// 요금 적용 클릭
	/* $('.amtDiv').click(function() {
		var id_arr = $(this).attr('id').split('_');
		$('#priceType_' + id_arr[2]).text($(this).attr('value') == 'A' ? '원' : '%');
	}); */

	// 적용 체크박스 클릭
	var prevAmt = '';
	$('.checkApl').click(function() {
		var name_arr = $(this).attr('name').split('_');
		$('#disAmt_' + name_arr[1]).prop('disabled', $(this).prop('checked') ? false : true);

		if ($('#disAmt_' + name_arr[1]).val() != '')
			prevAmt = $('#disAmt_' + name_arr[1]).val();

		$('#disAmt_' + name_arr[1]).val($(this).prop('checked') == false ? '' : prevAmt);
	});
});
</script>
</head>
<body>
<div id="wrapper">
	<jsp:include page="/mas/head.do?menu=product" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area">
			<div id="contents">
				<h2 class="title08"><c:out value="${adPrdinf.prdtNm}"/></h2>
				<div id="menu_depth3">
					<ul>
			            <li><a class="menu_depth3" href="<c:url value='/mas/ad/detailPrdt.do?prdtNum=${adPrdinf.prdtNum}'/>">객실정보</a></li>
		              	<!-- <li><a class="menu_depth3" href="<c:url value='/mas/ad/cntList.do?prdtNum=${adPrdinf.prdtNum}'/>">수량관리</a></li> -->
		              	<li><a class="menu_depth3" href="<c:url value='/mas/ad/imgList.do?prdtNum=${adPrdinf.prdtNum}'/>">객실이미지</a></li>
		              	<li><a class="menu_depth3" href="<c:url value='/mas/ad/amtList.do?prdtNum=${adPrdinf.prdtNum}'/>">요금관리</a></li>
		              	<li class="on"><a class="menu_depth3" href="<c:url value='/mas/ad/continueNight.do?prdtNum=${adPrdinf.prdtNum}'/>">연박 요금관리</a></li>
		              	<li><a class="menu_depth3" href="<c:url value='/mas/ad/adAddamtPrdtList.do?prdtNum=${adPrdinf.prdtNum}'/>">객실인원추가요금</a></li>
	                </ul>
	                 <div class="btn_rt01">
	                	<c:if test="${adPrdinf.tradeStatus==Constant.TRADE_STATUS_REG || adPrdinf.tradeStatus==Constant.TRADE_STATUS_EDIT}">
	                	<div class="btn_sty01"><a href="javascript:fn_ApprovalReqPrdt();">승인요청</a></div>
	                	</c:if>
	                	<c:if test="${adPrdinf.tradeStatus==Constant.TRADE_STATUS_APPR_REQ}">
	                	<div class="btn_sty01"><a href="javascript:fn_CancelApproval();">승인요청취소</a></div>
	                	</c:if>
	                </div>
	        	</div>
	        	<!-- 연박요금관리 -->
				<div class="split-50 ad-price">
					<div class="l-area">
						<div class="top-title">
							<h4 class="title08">기간관리</h4>
							<%-- <div class="side-box">
								<label>
									<input type="checkbox" name='ctnAplYn' id="ctnAplYn" <c:if test="${adPrdinf.ctnAplYn eq 'Y' }">checked</c:if> />
									<span>연박 적용여부</span>
								</label>
							</div> --%>
						</div>
						<table class="table01 center">
					        <colgroup>
					            <col width="5%">
					            <col width="16%">
					            <col width="16%">
					            <col width="18%">
					            <col width="20%">
					            <col width="25%">
					        </colgroup>
					        <thead>
					            <tr>
					                <th>No</th>
					                <th>시작일</th>
					                <th>종료일</th>
					                <th>설명</th>
					                <th>내역</th>
					                <th>관리</th>
					            </tr>
					        </thead>
					        <tbody>
					        	<c:forEach items="${ctnInfoList }" var="ctn" varStatus="sts">
					            <tr>
					                <td>${sts.count }</td>
					                <td>${fn:substring(ctn.startDt,0,4)}-${fn:substring(ctn.startDt,4,6)}-${fn:substring(ctn.startDt,6,8)}</td>
					                <td>${fn:substring(ctn.endDt,0,4)}-${fn:substring(ctn.endDt,4,6)}-${fn:substring(ctn.endDt,6,8)}</td>
					                <td class="left" id="ctnStr${ctn.ctnInfSn }">${ctn.ctnExp }</td>					                
					                <td id="continueAmt_${ctn.ctnInfSn }">${fn:replace(ctn.ampInf, '@', '<br>') }</td>
					                <td>
					                	<a href="#" class="btn blue sm modifyBtn" alt="${ctn.ctnInfSn }">수정</a>
					                	<a href="#" class="btn black sm priceBtn" alt="${ctn.ctnInfSn }">요금</a>
					                	<a href="#" class="btn red sm delPeriodBtn" alt="${ctn.ctnInfSn }">삭제</a>
					                </td>
					            </tr>
					            </c:forEach>
					            <form name="ctnForm" id="ctnForm" method="post" action="<c:url value='/mas/ad/actionCtnInf.do' />">
					            <input type="hidden" name="ctnInfSn" value="" />
					            <input type="hidden" name="prdtNum" value="${adPrdinf.prdtNum}" />
					            <tr>
					                <td><c:out value="${fn:length(ctnInfoList)+1 }"/> </td>
					                <td><input type="text" class="input_text3 center" name="startDt" id="startDt" readonly /></td>
					                <td><input type="text" class="input_text3 center" name="endDt" id="endDt" readonly /></td>
					                <td><input type="text" class="width100" name="ctnExp" /></td>
					                <td> </td>
					                <td>
					                	<a href="#" id="actionPeriodBtn" class="btn blue sm">추가</a>
					                	<a href="#" id="resetPeriodBtn" class="btn red sm">초기화</a>
					                </td>
					            </tr>
					            </form>
					        </tbody>
					    </table>
					</div> <!-- //l-area -->

					<div class="r-area">
						<div id="price_area" style="display: none;">
							<div class="top-title">
								<h4 class="title08">요금관리</h4>
							</div>
							<table class="table01 center">
						        <colgroup>
						            <col width="25%">
						            <col width="45%">
						            <col>
						        </colgroup>
						        <tbody>
						          <form:form commandName="ctnAmt" name="ctnAmt" method="post" onSubmit="return false;">
						        	<c:forEach begin="1" end="5" var="bak">
						          <input type="hidden" name="ctnAmt[${bak-1 }].ctnInfSn" class="ctnInfSn" value="" />
						          <input type="hidden" name="ctnAmt[${bak-1 }].aplNight" value="${bak }" />
						            <tr>
						                <td>${bak }박</td>
						                <td class="left">
						                	<label>
												<input type="radio" name="ctnAmt[${bak-1 }].amtDiv" class='amtDiv' id="amtDiv_A_${bak }" value="A" checked="checked" />
												<span>요금할인</span>
											</label>
											<label>
												<input type="checkbox" name='checkApl_${bak }' class='checkApl' />
												<span>적용</span>
											</label>
											<%-- <label>
												<input type="radio" name="ctnAmt[${bak-1 }].amtDiv" class='amtDiv' id="amtDiv_P_${bak }" value="P" />
												<span>비율할인</span>
											</label> --%>
						                </td>
						                <td class="right">
						                	<div class="int-label">
						                		<input type="text" name="ctnAmt[${bak-1 }].disAmt" id="disAmt_${bak }" class="numFormat" value="" onkeydown="return fn_checkNumber3(event)">
						                		<span id="priceType_${bak}">원</span>
						                	</div>
						                </td>
						            </tr>
						            </c:forEach>
						          </form:form>
						        </tbody>
						    </table>
						    <div class="btn-wrap1">
						    	<a href="#" id="actionAmtBtn" class="btn blue">등록</a>
						    	<a href="#" id="resetAmtBtn" class="btn red">초기화</a>
						    </div>

						    <ul class="list-style1">
						    	<li class="font02" style="font-size: 17px">숙박 이용 전체요금에서 금액 할인을 적용</li>
						        <li>최대 박수 설정은 5박까지 설정</li>
						    </ul>
					    </div>
					</div> <!-- //r-area -->
				</div> <!-- //split-50 -->
				<!-- //연박요금관리 -->
	        </div>
        </div>
	</div>
	<!--//Contents 영역-->
</div>
</body>
</html>