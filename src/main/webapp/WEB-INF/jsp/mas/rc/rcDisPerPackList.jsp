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
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
<script type="text/javascript" src="<c:url value='/js/multiple-select.js'/>"></script>

<validator:javascript formName="RC_DISPERINFVO" staticJavascript="false" xhtml="true" cdata="true"/>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/multiple-select.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">

function fn_Search(){
	document.disPerInf.action = "<c:url value='/mas/rc/disPerPackList.do'/>";
	document.disPerInf.submit();
}

/**
 * 기간할인율 수정 layer 창 열기
 */
function fn_UdtRangeDisPerLay(prdtNum, disPerNum){
	var parameters = "prdtNum=" + prdtNum;
	parameters += "&disPerNum=" + disPerNum;
	
	$.ajax({
		type:"post", 
		dataType:"json",
		async:false,
		url:"<c:url value='/mas/rc/selectByDisPerInf.ajax'/>",
		data:parameters ,
		success:function(data){
			// 수정 값 초기화
			$("#viewAplStartDt").val(fn_addDate(data.disPerInfVO.aplStartDt));
			$("#aplStartDt").val(data.disPerInfVO.aplStartDt);
			$("#viewAplEndDt").val(fn_addDate(data.disPerInfVO.aplEndDt));
			$("#aplEndDt").val(data.disPerInfVO.aplEndDt);
			$("#rangeWdayDisPer").val(data.disPerInfVO.wdayDisPer);
			$("#rangeWkdDisPer").val(data.disPerInfVO.wkdDisPer);
			$("#rangeDisPerNum").val(data.disPerInfVO.disPerNum);
			
			$("#gubun2").val("U");
			
			// 에러 문구값 초기화
			$(".error_text").text("");
			
			show_popup($("#lay_popup2"));
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
 * 기간할인율 등록 layer 창 열기
 */
function fn_InsRangeDisPerLay(){
	// 에러 문구값 초기화
	$(".error_text").text("");
	
	// init
	$("#RC_DISPERINFVO input:text:not([id=rangePrdtNum])").val("");
	$("#gubun2").val("I");
	show_popup($("#lay_popup2"));
}

function fn_InsRangeDisPer(){
	if($("#rangePrdtNum").val() == null){
		alert("상품을 선택해주세요.");
		$("#rangePrdtNum").focus();
		return;
	}
	// validation 체크
	if(!validateRC_DISPERINFVO(document.rangeDisPer)){
		return;
	}
	
	/* if(!checkPercentNum90($("#rangeWdayDisPer").val())){
		alert("할인율은 최대 90% 까지 입력 가능합니다.");
		$("#rangeWdayDisPer").focus();
		return;
	}
	if(!checkPercentNum90($("#rangeWkdDisPer").val())){
		alert("할인율은 최대 90% 까지 입력 가능합니다.");
		$("#rangeWkdDisPer").focus();
		return;
	} */
	
	if(!checkByFromTo($('#viewAplStartDt').val(), $("#viewAplEndDt").val(), "Y")){
		alert("적용일이 올바르지 않습니다.");
		return;
	}
	if($("#gubun2").val() == "U"){
		document.rangeDisPer.action = "<c:url value='/mas/rc/updateRangeDisPer.do'/>";
		document.rangeDisPer.submit();
	}else if($("#gubun2").val() == "I"){
		// 기간 할인율 등록
		var parameters = $("#RC_DISPERINFVO").serialize();
	
		$.ajax({
			type:"post", 
			// dataType:"json",
			// async:false,
			url:"<c:url value='/mas/rc/insertRangeDisPer.ajax'/>",
			data:parameters,
			success:function(data){
				if(data.error == "Y"){
					alert(data.errorMsg);
				}else{
					alert("기간할인율이 일괄등록되었습니다.");
					
					document.rangeDisPer.action = "<c:url value='/mas/rc/disPerPackList.do'/>";
					document.rangeDisPer.submit();
				}
			},
			error:fn_AjaxError
		});
		
		// document.rangeDisPer.action = "<c:url value='/mas/rc/insertRangeDisPer.do'/>";
		// document.rangeDisPer.submit();
	}
}

/**
 * 기본 할인율 등록 레이어 열기
 */
function fn_OpenAddDefDisPer(){
	$("#gubun").val("I");
	show_popup($("#lay_popup"));
}

/**
 * 기본 할인율 수정
 */
function fn_OpenUdtDefDisPer(prdtNum, disPerNum, wdayDisPer, wkdDisPer){
	$("#gubun").val("U");
	$("#prdtNum").val(prdtNum);
	$("#disPerNum").val(disPerNum);
	$("#wdayDisPer").val(wdayDisPer);
	$("#wkdDisPer").val(wkdDisPer);
	
	show_popup($("#lay_popup"));
}

/**
 * 기간 할인율 단건 삭제
 */
function fn_DelRangeDisPer(prdtNum, disPerNum){
	if(confirm("<spring:message code='common.delete.msg'/>")){
		var parameters = "prdtNum=" + prdtNum;
		parameters += "&disPerNum=" + disPerNum;
		
		$.ajax({
			type:"post", 
			// dataType:"json",
			// async:false,
			url:"<c:url value='/mas/rc/deleteRangeDisPer.ajax'/>",
			data:parameters,
			success:function(data){
				alert("기간할인율이 삭제되었습니다.");

				document.rangeDisPer.action = "<c:url value='/mas/rc/disPerPackList.do'/>";
				document.rangeDisPer.submit();
				
			},
			error:fn_AjaxError
		});
	}
}

function fn_InsDisPer(){
	if(isNull($("#wdayDisPer").val())){
		alert("평일할인율을 입력하세요.");
		$("#wdayDisPer").focus();
		return;
	}
	if(isNull($("#wkdDisPer").val())){
		alert("주말할인율을 입력하세요.");
		$("#wkdDisPer").focus();
		return;
	}
	/* if(!checkPercentNum90($("#wdayDisPer").val())){
		alert("할인율은 최대 90% 까지 입력 가능합니다.");
		$("#wdayDisPer").focus();
		return;
	}
	if(!checkPercentNum90($("#wkdDisPer").val())){
		alert("할인율은 최대 90% 까지 입력 가능합니다.");
		$("#wkdDisPer").focus();
		return;
	} */
	if($("#gubun").val() == "U"){
		
		var parameters = "prdtNum=" + prdtNum;
		parameters += "&disPerNum=" + disPerNum;
		parameters += "&wdayDisPer=" + wdayDisPer;
		parameters += "&wkdDisPer=" + wkdDisPer;
		
		$.ajax({
			type:"post", 
			// dataType:"json",
			// async:false,
			url:"<c:url value='/mas/rc/updateDefDisPer.ajax'/>",
			data:parameters,
			success:function(data){
				alert("기본할인율이 수정되었습니다.");
					
				document.rangeDisPer.action = "<c:url value='/mas/rc/disPerPackList.do'/>";
				document.rangeDisPer.submit();
				
			},
			error:fn_AjaxError
		});
		
	}else if($("#gubun").val() == "I"){
		document.defDisPer.action = "<c:url value='/mas/rc/insertDefDisPer.do'/>";
		document.defDisPer.submit();
	}
}

/**
 * 선택 할인율 변경 레이어
 */
function fn_ChkDisPerLay(){
	var prdtNum = [];
	var disPerNum = [];
	$("input:checkbox[name=chk]").each(function(index){
		if($(this).is(":checked")){
			prdtNum.push($("input[name=l_prdtNum]").eq(index).val());
			disPerNum.push($("input[name=l_disPerNum]").eq(index).val());
		}
	});
	if(prdtNum.length == 0){
		alert("선택된 할인율이 없습니다.");
		return;
	}
	show_popup($("#lay_popup3"));
}

/**
 * 선택 할인율 변경 처리
 */
function fn_UdtChkDisPer(){
	var prdtNum = [];
	var disPerNum = [];
	$("input:checkbox[name=chk]").each(function(index){
		if($(this).is(":checked")){
			prdtNum.push($("input[name=l_prdtNum]").eq(index).val());
			disPerNum.push($("input[name=l_disPerNum]").eq(index).val());
		}
	});
	if(prdtNum.length == 0){
		alert("선택된 할인율이 없습니다.");
		return;
	}
	if(prdtNum.length != disPerNum.length){
		alert("할인율 선택 오류. 다시 선택해주세요.");
		document.rangeDisPer.action = "<c:url value='/mas/rc/disPerPackList.do'/>";
		document.rangeDisPer.submit();
		return;
	}
	if(isNull($("#chkWdayDisPer").val())){
		alert("평일할인율을 입력하세요.");
		$("#chkWdayDisPer").focus();
		return;
	}
	if(isNull($("#chkWkdDisPer").val())){
		alert("주말할인율을 입력하세요.");
		$("#chkWkdDisPer").focus();
		return;
	}
	/* if(!checkPercentNum90($("#chkWdayDisPer").val())){
		alert("할인율은 최대 90% 까지 입력 가능합니다.");
		$("#chkWdayDisPer").focus();
		return;
	}
	if(!checkPercentNum90($("#chkWkdDisPer").val())){
		alert("할인율은 최대 90% 까지 입력 가능합니다.");
		$("#chkWkdDisPer").focus();
		return;
	} */
	
	var parameters = "prdtNum=" + prdtNum;
	parameters += "&disPerNum=" + disPerNum;
	parameters += "&wdayDisPer=" + $("#chkWdayDisPer").val();
	parameters += "&wkdDisPer=" + $("#chkWkdDisPer").val();
	
	$.ajax({
		type:"post", 
		// dataType:"json",
		// async:false,
		url:"<c:url value='/mas/rc/updateChkDisPer.ajax'/>",
		data:parameters,
		success:function(data){
			alert("할인율이 일괄 수정되었습니다.");
				
			document.rangeDisPer.action = "<c:url value='/mas/rc/disPerPackList.do'/>";
			document.rangeDisPer.submit();
			
		},
		error:fn_AjaxError
	});
}

/**
 * 기본 할인율 등록
 *  - 기본할인율이 등록되지 않은 상품을 조회 하여 등록폼 제공 
 */
function fn_InsDisPerLay(){
	// 기본 할인율 등록 안된 상품 조회
	var parameters = "";
	
	$.ajax({
		type:"post", 
		// dataType:"json",
		// async:false,
		url:"<c:url value='/mas/rc/selectDefDisPerPrdt.ajax'/>",
		data:parameters,
		success:function(data){
			if(data.prdtList.length == 0){
				alert("모든 상품에 이미 기본할인율이 입력되어있습니다.");
				return;
			}else{
				var addHtml = "";
				
				$.each(data.prdtList, function(index, onerow) {
					addHtml += "<option value='" + onerow.prdtNum + "'>" + onerow.prdtNm + "</option>";
				});
				$("#defPrdtNum").html(addHtml);
				
				$("#defPrdtNum").multipleSelect({
					filter 		: true,
					multiple 	: true,
					multipleWidth : 300,
					maxHeight	: 110,
					selectAllText : "전체차량",
					allSelected : "전체차량",
					minimumCountSelected : 7
				});
				
				show_popup($("#lay_popup4"));
			}
			
		},
		error:fn_AjaxError
	});
}

/**
 * 기본할인율 등록
 */
function fn_InsDefDisPer(){
	if($("#defPrdtNum").val() == null){
		alert("상품을 선택해주세요.");
		$("#defPrdtNum").focus();
		return;
	}
	if(isNull($("#defWdayDisPer").val())){
		alert("평일할인율을 입력하세요.");
		$("#defWdayDisPer").focus();
		return;
	}
	if(isNull($("#defWkdDisPer").val())){
		alert("주말할인율을 입력하세요.");
		$("#defWkdDisPer").focus();
		return;
	}
	/* if(!checkPercentNum90($("#defWdayDisPer").val())){
		alert("할인율은 최대 90% 까지 입력 가능합니다.");
		$("#defWdayDisPer").focus();
		return;
	}
	if(!checkPercentNum90($("#defWkdDisPer").val())){
		alert("할인율은 최대 90% 까지 입력 가능합니다.");
		$("#defWkdDisPer").focus();
		return;
	} */
	
	var parameters = "prdtNum=" + $("#defPrdtNum").val();
	parameters += "&wdayDisPer=" + $("#defWdayDisPer").val();
	parameters += "&wkdDisPer=" + $("#defWkdDisPer").val();
	
	$.ajax({
		type:"post", 
		// dataType:"json",
		// async:false,
		url:"<c:url value='/mas/rc/insertDefDisPer.ajax'/>",
		data:parameters,
		success:function(data){
			if(data.error == "Y"){
				alert(data.errorMsg);
				return;
			}else{
				alert("기본할인율이 일괄 등록되었습니다.");
					
				document.disPerInf.action = "<c:url value='/mas/rc/disPerPackList.do'/>";
				document.disPerInf.submit();
			}
		},
		error:fn_AjaxError
	});
}

function fn_DelChkDisPer(){
	if(confirm("정말 삭제 하시겠습니까?")){
        fn_DelChkConfirm();
	}
}

/*선택할인율 삭제*/
function fn_DelChkConfirm(){
    var prdtNum = [];
    var disPerNum = [];
    $("input:checkbox[name=chk]").each(function(index){
        if($(this).is(":checked")){
            prdtNum.push($("input[name=l_prdtNum]").eq(index).val());
            disPerNum.push($("input[name=l_disPerNum]").eq(index).val());
        }
    });
    if(prdtNum.length == 0){
        alert("선택된 할인율이 없습니다.");
        return;
    }
    if(prdtNum.length != disPerNum.length){
        alert("할인율 선택 오류. 다시 선택해주세요.");
        document.rangeDisPer.action = "<c:url value='/mas/rc/disPerPackList.do'/>";
        document.rangeDisPer.submit();
        return;
    }
    /* if(!checkPercentNum90($("#chkWdayDisPer").val())){
        alert("할인율은 최대 90% 까지 입력 가능합니다.");
        $("#chkWdayDisPer").focus();
        return;
    }
    if(!checkPercentNum90($("#chkWkdDisPer").val())){
        alert("할인율은 최대 90% 까지 입력 가능합니다.");
        $("#chkWkdDisPer").focus();
        return;
    } */

    var parameters = "prdtNum=" + prdtNum;
    parameters += "&disPerNum=" + disPerNum;

    $.ajax({
        type:"post",
        // dataType:"json",
        // async:false,
        url:"<c:url value='/mas/rc/deleteChkDisPer.ajax'/>",
        data:parameters,
        success:function(data){
            history.go(0);
            alert("선택된 할인율이 삭제되었습니다.");

        },
        error:fn_AjaxError
    });
}

$(document).ready(function(){

	$("#viewAplStartDt").datepicker({
		dateFormat: "yy-mm-dd",
		onClose : function(selectedDate) {
			$("#viewAplEndDt").datepicker("option", "minDate", selectedDate);
		}
	});
	
	$("#viewAplEndDt").datepicker({
		dateFormat: "yy-mm-dd",
		onClose : function(selectedDate) {
			$("#viewAplStartDt").datepicker("option", "maxDate", selectedDate);
		}
	});
	
	$('#viewAplStartDt').change(function() {
		$('#aplStartDt').val($('#viewAplStartDt').val().replace(/-/g, ''));
	});
	$('#viewAplEndDt').change(function() {
		$('#aplEndDt').val($('#viewAplEndDt').val().replace(/-/g, ''));
	});
	
	$("#sFromDtView").datepicker({
		dateFormat: "yy-mm-dd"
	});
	
	if("${error}" == "Y"){
		show_popup($("#lay_popup2"));
	}
	
	$("#rangePrdtNum").multipleSelect({
		filter 		: true,
		multiple 	: true,
		multipleWidth : 300,
		maxHeight	: 110,
		selectAllText : "전체차량",
		allSelected : "전체차량",
		minimumCountSelected : 7
	});
	
	$("#allChk").click(function(){
		if($(this).is(":checked")){
			$("input:checkbox[name=chk]").each(function(){
				if($(this).prop("disabled") == false){
					$(this).prop("checked", true);
				}
			});
			// $("input:checkbox[name=chk]").prop("checked", true);
		}else{
			$("input:checkbox[name=chk]").prop("checked", false);
		}
	});
	
});

</script>

</head>
<body>
<div class="blackBg"></div>
<div id="wrapper">
	<jsp:include page="/mas/head.do?menu=product" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area">
			<div id="contents">
				<h2 class="title08">할인율 관리</h2>
				<h7> ※할인율 적용우선순위 <br>
					1. 대여기간에 기간할인율이 100% 설정되어 있는 상품은 노출되지 않음. <br>
					2. 대여기간에 기간할인율이 두가지 이상일 경우 낮은 할인율로 적용. <br>
					3. 대여기간에 기간할인율과 기본할인율이 겹칠경우 기간할인율로 적용.<br>
					4. 대여기간이 기간할인율 외 기간일 경우 기본할인율로 적용. <br>
				</h7>
				<form name="disPerInf" method="post" onSubmit="return false;">
				<div class="search_box">
                    <div class="search_form">
                    	<div class="tb_form">
							<table width="100%" border="0">
								<colgroup>
									<col width="55" />
									<col width="*" />
									<col width="100" />
									<col width="*" />
								</colgroup>
               					<tbody>
               						<tr>
          								<th scope="row">상&nbsp;품&nbsp;명</th>
          								<td>
          									<select id="sPrdtNum" name="sPrdtNum">
          										<option value="">전체</option>
          										<c:forEach items="${prdtList}" var="prdt" varStatus="status">
          											<option value="${prdt.prdtNum}" <c:if test="${searchVO.sPrdtNum == prdt.prdtNum}">selected="selected"</c:if>>${prdt.prdtNm}</option>
          										</c:forEach>
          									</select>
          								</td>
          								<th scope="row">거래상태</th>
       									<td>
       										<select name="sTradeStatus">
       											<option value="">전체</option>
       											<c:forEach items="${tsCd}" var="code" varStatus="status">
       												<option value="${code.cdNum}" <c:if test="${code.cdNum eq searchVO.sTradeStatus}">selected="selected"</c:if>>${code.cdNm}</option>
       											</c:forEach>
       										</select>
       									</td>
       								</tr>
       								<tr>
										<th scope="row">할인율구분</th>
										<td>
											<select name="sDisperDiv">
												<option value="">전체</option>
												<option value="1" <c:if test="${'1' eq searchVO.sDisperDiv}">selected="selected"</c:if>>기본할인율</option>
												<option value="2" <c:if test="${'1' ne searchVO.sDisperDiv and not empty searchVO.sDisperDiv}">selected="selected"</c:if>>기간할인율</option>
											</select>
										</td>
       									<th scope="row">검색일</th>
       									<td colspan="3">
       										<input type="text" name="sFromDtView" id="sFromDtView" class="input_text4 center" readonly="readonly" value="${searchVO.sFromDtView}" />
       										&nbsp;<span class="font03">(해당 날짜 이후 할인율 검색)</span>
       									</td>
       								</tr>
       							</tbody>
                 			</table>
                 		</div>
						<span class="btn">
							<input type="image" src="<c:url value='/images/oss/btn/search_btn01.gif'/>" alt="검색" onclick="javascript:fn_Search()" />
						</span>
                    </div>
                </div>

                <ul class="btn_rt01">
					<li class="btn_sty04">
						<a href="javascript:fn_ChkDisPerLay();">선택할인율변경</a>
					</li>
					<li class="btn_sty04">
						<a href="javascript:fn_DelChkDisPer();">선택할인율삭제</a>
					</li>
					<li class="btn_sty04">
						<a href="javascript:fn_InsRangeDisPerLay();">기간할인율등록</a>
					</li>
					<li class="btn_sty04">
						<a href="javascript:fn_InsDisPerLay();">기본할인율등록</a>
					</li>
				</ul>
                <div class="list">
                	<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01">
                		<colgroup>
                			<col width="5%" />	<!-- 체크박스 -->
                			<col width="12%" /> <!-- 상품번호 -->
                			<col width="12%" /> <!-- 상품명 -->
                			<col width="12%" /> <!-- 할인율구분 -->

							<col width="6%" /> <!-- 보험구분 -->
							<col width="6%" /> <!-- 승인구분 -->

                			<col width="12%" /> <!-- 적용시작일 -->
                			<col width="12%" /> <!-- 적용종료일-->
                			<col width="5%" />  <!-- 평인할인율-->
                			<col width="5%" /> <!-- 주말할인율-->
                			<col />
                		</colgroup>
                		<thead>
                			<tr>
                				<th>
                					<input type="checkbox" id="allChk" />
                				</th>
                				<th>상품번호</th>
                				<th>상품명</th>
                				<th>할인율구분</th>

								<th>보험구분</th>
								<th>승인구분</th>

                				<th>적용시작일</th>
                				<th>적용종료일</th>

                				<th>평일할인율</th>
                				<th>주말할인율</th>
                				<th>기능툴</th>
                			</tr>
                		</thead>
                		<tbody>
                			<!-- 데이터 없음 -->
							<c:if test="${fn:length(disPerInfList) == 0}">
								<tr>
									<td colspan="11" class="align_ct">
										<spring:message code="common.nodata.msg" />
									</td>
								</tr>
							</c:if>
                			<c:forEach items="${disPerInfList}" var="disPerInf" varStatus="status">
                				<tr>
                					<td class="align_ct">
                						<input type="checkbox" name="chk" />
                						<input type="hidden" name="l_prdtNum" value="${disPerInf.prdtNum}" />
                						<input type="hidden" name="l_disPerNum" value="${disPerInf.disPerNum}" />
                					</td>
                					<td class="align_ct">
                						<c:out value="${disPerInf.prdtNum}" />
                					</td>
                					<td class="align_ct">
                						<c:out value="${disPerInf.prdtNm}" />
                					</td>
                					<td class="align_ct">
                						<c:if test="${disPerInf.disPerNum == 1}">기본할인율</c:if>
                						<c:if test="${disPerInf.disPerNum != 1}">기간할인율</c:if>
                					</td>
									<td class="align_ct">
										<c:forEach var="code" items="${isrDivCd}" varStatus="status">
											<c:if test="${disPerInf.isrDiv==code.cdNum}"><c:out value='${code.cdNm}'/></c:if>
										</c:forEach>
										<c:if test="${disPerInf.isrDiv=='ID10'}">
											<c:if test="${disPerInf.isrTypeDiv=='LUXY'}">
												(고급)
											</c:if>
											<c:if test="${disPerInf.isrTypeDiv=='GENL'}">
												(일반)
											</c:if>
										</c:if>
									</td>
									<td class="align_ct">
										<c:forEach items="${tsCd}" var="code" varStatus="status">
											<c:if test="${code.cdNum eq disPerInf.tradeStatus}">${code.cdNm}</c:if>
										</c:forEach>
									</td>
                					<td class="align_ct">
                						<c:if test="${disPerInf.disPerNum != 1}">
                							<fmt:parseDate value='${disPerInf.aplStartDt}' var='aplStartDt' pattern="yyyyMMdd" scope="page"/>
											<fmt:formatDate value='${aplStartDt}' pattern='yyyy-MM-dd' />
                						</c:if>
                					</td>
                					<td class="align_ct">
                						<c:if test="${disPerInf.disPerNum != 1}">
                							<fmt:parseDate value='${disPerInf.aplEndDt}' var='aplEndDt' pattern="yyyyMMdd" scope="page"/>
											<fmt:formatDate value='${aplEndDt}' pattern='yyyy-MM-dd' />
                						</c:if>
                					</td>
                					<td class="align_ct">
                						<c:out value="${disPerInf.wdayDisPer}" />%
                					</td>
                					<td class="align_ct">
                						<c:out value="${disPerInf.wkdDisPer}" />%
                					</td>
                					<td class="align_ct">
                						<c:if test="${disPerInf.disPerNum == 1}">
                							<div class="btn_sty06"><span><a href="javascript:fn_OpenUdtDefDisPer('${disPerInf.prdtNum}', '${disPerInf.disPerNum}', '${disPerInf.wdayDisPer}', '${disPerInf.wkdDisPer}')">수정</a></span></div>
                						</c:if>
                						<c:if test="${disPerInf.disPerNum != 1}">
                							<div class="btn_sty06"><span><a href="javascript:fn_UdtRangeDisPerLay('${disPerInf.prdtNum}', '${disPerInf.disPerNum}')">수정</a></span></div>
                							<div class="btn_sty09"><span><a href="javascript:fn_DelRangeDisPer('${disPerInf.prdtNum}','${disPerInf.disPerNum}')">삭제</a></span></div>
                						</c:if>
                					</td>
                				</tr>
                			</c:forEach>
                		</tbody>
                	</table>
                </div>
                </form>
			</div>
			<div id="lay_popup" class="lay_popup lay_ct" style="display:none;"> <!--왼쪽정렬:lay_lt, 오른쪽정렬:lay_rt, 가운데정렬:lay_ct--> 
	            <span class="popup_close"><a href="javascript:;" onclick="close_popup($('#lay_popup'))" title="창닫기">
	            	<img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a>
	            </span>
	            <form name="defDisPer">
	            	<input type="hidden" id="prdtNum" name="prdtNum" value="${disPerInfVO.prdtNum}" />
	            	<input type="hidden" id="disPerNum" name="disPerNum" />
	            	<input type="hidden" id="gubun" name="gubun" />
	            <ul class="form_area">
	            	<li>
	            		<table border="1" class="table02" >
			            	<caption class="tb01_title">기본할인율관리<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span></caption>
			            	<colgroup>
		                        <col width="170" />
		                        <col width="*" />
		                    </colgroup>
							<tr>
								<th>평일할인율<span class="font02">*</span></th>
								<td>
									<input type="text" name="wdayDisPer" id="wdayDisPer" class="input_text2 center" maxlength="3" value="${defDisPerVO.wdayDisPer}" onkeydown="javascript:fn_checkNumber();" /> %
								</td>
							</tr>
							<tr>
								<th>주말할인율<span class="font02">*</span></th>
								<td>
									<input type="text" name="wkdDisPer" id="wkdDisPer" class="input_text2 center" maxlength="3" value="${defDisPerVO.wkdDisPer}" onkeydown="javascript:fn_checkNumber();" /> %
								</td>
							</tr>
						</table>
	            	</li>
	            </ul>
	            </form>
	            <div class="btn_rt01">
	            	<span class="btn_sty04"><a href="javascript:fn_InsDisPer()">저장</a></span>
	            </div>
	        </div>
			<div id="lay_popup2" class="lay_popup lay_ct" style="display:none;"> <!--왼쪽정렬:lay_lt, 오른쪽정렬:lay_rt, 가운데정렬:lay_ct--> 
	            <span class="popup_close"><a href="javascript:;" onclick="close_popup($('#lay_popup2'))" title="창닫기">
	            	<img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a>
	            </span>
	            <form:form commandName="RC_DISPERINFVO" name="rangeDisPer">
	            	<input type="hidden" id="rangeDisPerNum" name="disPerNum" />
	            	<input type="hidden" id="gubun2" name="gubun2" value="${disPerInfVO.gubun2}" />
	            <ul class="form_area">
	            	<li>
	            		<table border="1" class="table02" >
			            	<caption class="tb01_title">기간할인율관리<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span></caption>
			            	<colgroup>
		                        <col width="170" />
		                        <col width="*" />
		                    </colgroup>
		                    <tr>
		                    	<th>적용상품<span class="font02">*</span></th>
		                    	<td>
		                    		<select id="rangePrdtNum" name="prdtNum"  multiple="multiple">
   										<c:forEach items="${prdtList}" var="prdt" varStatus="status">
   											<option value="${prdt.prdtNum}" <c:if test="${searchVO.sPrdtNum == prdt.prdtNum}">selected="selected"</c:if>>
											${prdt.prdtNm}
											<c:forEach var="code" items="${isrDivCd}" varStatus="status">
												<c:if test="${prdt.isrDiv==code.cdNum}"><c:out value='[${code.cdNm}]'/></c:if>
											</c:forEach>
											<c:if test="${prdt.isrDiv=='ID10'}">
												<c:if test="${prdt.isrTypeDiv=='LUXY'}">
													(고급)
												</c:if>
												<c:if test="${prdt.isrTypeDiv=='GENL'}">
													(일반)
												</c:if>
											</c:if>
											</option>
   										</c:forEach>
   									</select>
		                    	</td>
		                    </tr>
			            	<tr>
								<th>적용시작일<span class="font02">*</span></th>
								<td>
									<form:input path="viewAplStartDt" id="viewAplStartDt" class="input_text4 center" readonly="readonly" value="${disPerInfVO.viewAplStartDt}" />
									<input type="hidden" name="aplStartDt" id="aplStartDt" value="${disPerInfVO.aplStartDt}" />
									<form:errors path="viewAplStartDt"  cssClass="error_text" />
								</td>
							</tr>
			            	<tr>
								<th>적용종료일<span class="font02">*</span></th>
								<td>
									<form:input path="viewAplEndDt" id="viewAplEndDt" class="input_text4 center" readonly="readonly" value="${disPerInfVO.viewAplEndDt}" />
									<input type="hidden" name="aplEndDt" id="aplEndDt" value="${disPerInfVO.aplEndDt}" />
									<form:errors path="viewAplEndDt"  cssClass="error_text" />
								</td>
							</tr>
							<tr>
								<th>평일할인율<span class="font02">*</span></th>
								<td>
									<form:input path="wdayDisPer" id="rangeWdayDisPer" class="input_text2 center" maxlength="3" value="${disPerInfVO.wdayDisPer}" onkeydown="javascript:fn_checkNumber();" /> %
									<form:errors path="wdayDisPer"  cssClass="error_text" />
								</td>
							</tr>
							<tr>
								<th>주말할인율<span class="font02">*</span></th>
								<td>
									<form:input path="wkdDisPer" id="rangeWkdDisPer" class="input_text2 center" maxlength="3" value="${disPerInfVO.wkdDisPer}" onkeydown="javascript:fn_checkNumber();" /> %
									<form:errors path="wkdDisPer"  cssClass="error_text" />
								</td>
							</tr>
						</table>
	            	</li>
	            </ul>
	            </form:form>
	            <div class="btn_rt01">
	            	<span class="btn_sty04"><a href="javascript:fn_InsRangeDisPer()">저장</a></span>
	            </div>
	        </div>
	        <!-- 선택 할인율 변경 레이어 -->
	        <div id="lay_popup3" class="lay_popup lay_ct" style="display:none;"> <!--왼쪽정렬:lay_lt, 오른쪽정렬:lay_rt, 가운데정렬:lay_ct--> 
	            <span class="popup_close"><a href="javascript:;" onclick="close_popup($('#lay_popup3'))" title="창닫기">
	            	<img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a>
	            </span>
	            <form name="defDisPer2">
	            	<input type="hidden" id="chkPrdtNum" name="prdtNum" />
	            	<input type="hidden" id="chkDisPerNum" name="disPerNum" />
	            <ul class="form_area">
	            	<li>
	            		<table border="1" class="table02" >
			            	<caption class="tb01_title">선택할인율변경<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span></caption>
			            	<colgroup>
		                        <col width="170" />
		                        <col width="*" />
		                    </colgroup>
							<tr>
								<th>평일할인율<span class="font02">*</span></th>
								<td>
									<input type="text" name="chkWdayDisPer" id="chkWdayDisPer" class="input_text2 center" maxlength="3" onkeydown="javascript:fn_checkNumber();" /> %
								</td>
							</tr>
							<tr>
								<th>주말할인율<span class="font02">*</span></th>
								<td>
									<input type="text" name="chkWkdDisPer" id="chkWkdDisPer" class="input_text2 center" maxlength="3" onkeydown="javascript:fn_checkNumber();" /> %
								</td>
							</tr>
						</table>
	            	</li>
	            </ul>
	            </form>
	            <div class="btn_rt01">
	            	<span class="btn_sty04"><a href="javascript:fn_UdtChkDisPer();">저장</a></span>
	            </div>
	        </div>
	        <!-- 기본할인율 등록 레이어 -->
	        <div id="lay_popup4" class="lay_popup lay_ct" style="display:none;"> <!--왼쪽정렬:lay_lt, 오른쪽정렬:lay_rt, 가운데정렬:lay_ct--> 
	            <span class="popup_close"><a href="javascript:;" onclick="close_popup($('#lay_popup4'))" title="창닫기">
	            	<img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a>
	            </span>
	            <form name="defDisPer3" id="defDisPer3">
	            <ul class="form_area">
	            	<li>
	            		<table border="1" class="table02" >
			            	<caption class="tb01_title">기본할인율등록<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span></caption>
			            	<colgroup>
		                        <col width="170" />
		                        <col width="*" />
		                    </colgroup>
		                    <tr>
		                    	<th>적용상품<span class="font02">*</span></th>
		                    	<td>
		                    		<select id="defPrdtNum" name="defPrdtNum"  multiple="multiple">
										<c:forEach items="${prdtList}" var="prdt" varStatus="status">
											<option value="${prdt.prdtNum}" <c:if test="${searchVO.sPrdtNum == prdt.prdtNum}">selected="selected"</c:if>>
													${prdt.prdtNm}
												<c:forEach var="code" items="${isrDivCd}" varStatus="status">
													<c:if test="${prdt.isrDiv==code.cdNum}"><c:out value='[${code.cdNm}]'/></c:if>
												</c:forEach>
												<c:if test="${prdt.isrDiv=='ID10'}">
													<c:if test="${prdt.isrTypeDiv=='LUXY'}">
														(고급)
													</c:if>
													<c:if test="${prdt.isrTypeDiv=='GENL'}">
														(일반)
													</c:if>
												</c:if>
											</option>
										</c:forEach>
   									</select>
		                    	</td>
		                    </tr>
							<tr>
								<th>평일할인율<span class="font02">*</span></th>
								<td>
									<input type="text" name="defWdayDisPer" id="defWdayDisPer" class="input_text2 center" maxlength="3" onkeydown="javascript:fn_checkNumber();" /> %
								</td>
							</tr>
							<tr>
								<th>주말할인율<span class="font02">*</span></th>
								<td>
									<input type="text" name="defWkdDisPer" id="defWkdDisPer" class="input_text2 center" maxlength="3" onkeydown="javascript:fn_checkNumber();" /> %
								</td>
							</tr>
						</table>
	            	</li>
	            </ul>
	            </form>
	            <div class="btn_rt01">
	            	<span class="btn_sty04"><a href="javascript:fn_InsDefDisPer();">저장</a></span>
	            </div>
	        </div>
		</div>
	</div>
</div>
</body>
</html>