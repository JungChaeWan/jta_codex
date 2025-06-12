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
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

 <un:useConstants var="Constant" className="common.Constant" />
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/dext5editor/js/dext5editor.js'/>"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBh0Ju395u0pT0bl9w7H-Ux0jVglA-wzdc&sensor=false"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=71cf66fb54158dacb5fb5b656674ad70&libraries=services"></script>

<validator:javascript formName="SP_PRDTINFVO" staticJavascript="false" xhtml="true" cdata="true"/>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>

<script type="text/javascript">

/**
 * DAUM 연동 주소찾기
 */
function openDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            // 우편번호와 주소 정보를 해당 필드에 넣고, 커서를 상세주소 필드로 이동한다.
            // document.getElementById('post1').value = data.postcode1;
            // document.getElementById('post2').value = data.postcode2;
            // 2015.08.01 부터 우편번호 5자리 실행
            // document.getElementById('postNum').value = data.zonecode;
            document.getElementById('roadNmAddr').value = data.address;

            //전체 주소에서 연결 번지 및 ()로 묶여 있는 부가정보를 제거하고자 할 경우,
            //아래와 같은 정규식을 사용해도 된다. 정규식은 개발자의 목적에 맞게 수정해서 사용 가능하다.
            //var addr = data.address.replace(/(\s|^)\(.+\)$|\S+~\S+/g, '');
            //document.getElementById('addr').value = addr;

            document.getElementById('dtlAddr').focus();
        }
    }).open();
}

/**
 * 주소에 따른 경도 위도 구하기
 */
function fn_FindLocation(){
	var addr = $("#roadNmAddr").val();

	if(isNull(addr)){
		alert("주소를 입력해주세요.");
		$("#dtlAddr").focus();
		return;
	}

	var geocoder = new daum.maps.services.Geocoder();

    var callback = function(result, status) {
	    if(status === daum.maps.services.Status.OK){
            var lat = result[0].y
            var lng = result[0].x

	    	$("#lon").val(lng);
			$("#lat").val(lat);
	    }else{
	    	if(status === daum.maps.services.Status.ZERO_RESULT){
	    		alert("해당 주소에 대한 결과값이 없습니다.");
				return;
	    	}else if(status === daum.maps.services.Status.RESULT_NOT_FOUND){
	    		alert("해당 주소에 대한 결과값이 없습니다.");
				return;
	    	}else{
	    		alert("API 응답불가, 관리자에게 문의하세요.");
				return;
	    	}
	    }
	};
    geocoder.addressSearch(addr, callback);
}

/**
 * 상품 기본 정보 수정
 */
function fn_UpdateSpPrdtInfo(){

	// validation 체크
	if(!validateSP_PRDTINFVO(document.spPrdtInf)){
		return;
	}

	if($(":radio[name=prdtDiv]:checked").val() != "TOUR") {
		if($(":radio[name=exprDaynumYn]:checked").val() == "Y") {
			if($("#exprDaynum").val() == "" ) {
				alert("유효일수를 입력해 주세요.");
				$("#exprDaynum").focus();
				return ;
			}
		} else {
			if($("#exprStartDt").val() == '' || $("#exprEndDt").val() == '' ) {
				alert("유효기간을 입력해 주세요.");
				return ;
			}
		}
		if($(":radio[name=prdtDiv]:checked").val() != "FREE") {
			if(isNull($("#useAbleTm").val())) {
				alert("이용가능시간을 입력해 주세요.");
				$("#useAbleTm").focus();
				return ;
			}
		}
	}

	if($("#select_ctgr_1depth").val() == "${Constant.CATEGORY_ADRC}"){
		if($(":radio[name=prdtDiv]:checked").val() != "TOUR") {
			alert("특가상품은 여행상품(날짜별 요금을 적용하는 상품)만 선택이 가능합니다.");
			return;
		}
	}

	if($("#useAbleTm").val() != "" && (Number($("#useAbleTm").val()) > 72 || !isNumber($("#useAbleTm").val()))) {
		alert("이용가능시간이 잘못 입력되었습니다. 1~72 중에 입력하실 수 있습니다.");
		return ;
	}

	if($("#linkPrdtYn").val() == "${Constant.FLAG_Y}"){
		if(isNull($("#linkUrl").val())){
			alert("LINK URL을 입력해주세요");
			$("#linkUrl").focus();
			return;
		}
	}

	if($("#useAbleTm").val().trim() == "") {
		$("#useAbleTm").val(0);
	}

	$("#saleStartDt").val($('#saleStartDt').val().replace(/-/g, ""));
	$("#saleEndDt").val($('#saleEndDt').val().replace(/-/g, ""));
	$("#exprStartDt").val($('#exprStartDt').val().replace(/-/g, ""));
	$("#exprEndDt").val($('#exprEndDt').val().replace(/-/g, ""));

	$("#useQlfct").val(DEXT5.getBodyValueExLikeDiv('editor1'));
	$("#cancelGuide").val(DEXT5.getBodyValueExLikeDiv('editor2'));

	document.spPrdtInf.action = "<c:url value='/mas/sp/updateSocialProductInfo.do' />";
	document.spPrdtInf.submit();
}

// 상품 리스트
function fn_socialProductList() {
	document.tabForm.action = "<c:url value='/mas/sp/productList.do' />";
	document.tabForm.submit();
}

//승인요청
function fn_approvalReqSocial() {
	$.ajax({
		url : "<c:url value='/mas/sp/approvalReqSocial.ajax'/>",
		data : "prdtNum=${spPrdtInf.prdtNum}",
		success: function(data) {
			fn_goTap('PRODUCT');
		},
		error : fn_AjaxError
	});
}
// 승인취소하기
function fn_approvalCancelSocial() {
	$.ajax({
		url : "<c:url value='/mas/sp/approvalCancelSocial.ajax'/>",
		data : "prdtNum=${spPrdtInf.prdtNum}",
		success: function(data) {
			fn_goTap('PRODUCT');
		},
		error : fn_AjaxError
	});
}
// 2depth 카테고리
function loadSubCategory(cdNum) {
	$("#select_ctgr_2depth option").remove();
	$.ajax({
		url: "<c:url value='/getCodeList.ajax'/>",
		data: "cdNum="+cdNum,
		success:function(data) {
			var cdList = data.cdList;
			var dataArr = [];
			var inx = 0;
			if( cdList == "")
				$("#ctgr").val($("#select_ctgr_1depth option:selected").val());
			else {
				$(cdList).each( function() {
					dataArr[inx++] = "<option value=" + this.cdNum + ">" + this.cdNm + "</option> ";
				});

				$("#select_ctgr_2depth").append(dataArr);

				$("#ctgr").val($("#select_ctgr_2depth option:selected").val());
			}
		},
		error : fn_AjaxError
	});
}

// 상품 상세 이미지 삭제.
function fn_DelPrdtImg() {
	$("#d_prdtImgList").hide();
	$("#prdtDtlImgFile").show();
	$("#prdtDtlImg").val('');
}
// 판매중지 요청
function fn_SaleStopSocial() {
	$.ajax({
		url : "<c:url value='/mas/sp/saleStopSocial.ajax'/>",
		data : "prdtNum=${spPrdtInf.prdtNum }",
		success: function(data) {
			 fn_goTap("PRODUCT");
		},
		error : fn_AjaxError
	});
}
//판매전환
function fn_SaleStartSocial() {
	$.ajax({
		url : "<c:url value='/mas/sp/saleStartSocial.ajax'/>",
		data : "prdtNum=${spPrdtInf.prdtNum}",
		success: function(data) {
			 fn_goTap("PRODUCT");
		},
		error :fn_AjaxError
	});
}
//판매종료
function fn_PrintN(){
    if(confirm("해당 상품은 더이상 관리자에서 보이지 않습니다. 진행하시겠습니까?")){
        document.spPrdtInf.action = "<c:url value='/mas/sp/salePrintN.do' />";
        document.spPrdtInf.submit();
	}
}

//탭 이동
function fn_goTap(menu) {
	if(menu == "PRODUCT") {
		document.tabForm.action="<c:url value='/mas/sp/viewUpdateSocial.do' />";
	} else if( menu == "IMG") {
		document.tabForm.action="<c:url value='/mas/sp/imgList.do' />";
	} else if(menu == "IMG_DETAIL") {
		document.tabForm.action="<c:url value='/mas/sp/dtlImgList.do' />";
	} else if(menu == "OPTION") {
		document.tabForm.action="<c:url value='/mas/sp/viewOption.do' />";
	} else if(menu == "ADD_OPTION") {
		document.tabForm.action="<c:url value='/mas/sp/viewAddOption.do' />";
	} else if(menu == "DTLINF") {
		document.tabForm.action="<c:url value='/mas/sp/dtlinfList.do' />";
	}

	document.tabForm.submit();
}

function dext_editor_loaded_event() {
	//숨겨진 textarea에서 html 소스를 가져옵니다.
	var html_source = document.getElementById('cancelGuide').value; //에디터가 로드 되고 난 후 에디터에 내용을 입력합니다.
	DEXT5.setBodyValueExLikeDiv(html_source, 'editor2');

	var html_source1 = document.getElementById('useQlfct').value; //에디터가 로드 되고 난 후 에디터에 내용을 입력합니다.
	DEXT5.setBodyValueExLikeDiv(html_source1, 'editor1');

}

$(function() {

	if($('#saleEndDt').val() == "9999-01-01"){
		$('#saleEndDt').css('color','#eeeeee');
		$('#saleEndDt').css('background-color','#eeeeee')
	}

    $("#saleStartDt").datepicker({
        dateFormat: "yy-mm-dd",
        minDate : "${SVR_TODAY}",
        maxDate : "+1y",
        onClose : function(selectedDate) {
            if($('#saleEndDt').val() != "9999-01-01") {
                $("#saleEndDt").datepicker("option", "minDate", selectedDate);
            }
            $("#exprStartDt").datepicker('option', 'minDate', selectedDate);
        }
    });
    $("#saleEndDt").datepicker({
        dateFormat: "yy-mm-dd",
        minDate : "${SVR_TODAY}",
        maxDate : "+1y +2m",
        onClose : function(selectedDate) {
            $("#saleStartDt").datepicker("option", "maxDate", selectedDate);
            if($('#saleEndDt').val() == "9999-01-01"){
                $("#saleStartDt").datepicker("option", "maxDate", "9999-01-01");
            }
            $("#exprEndDt").datepicker('option', 'minDate', selectedDate);
        },
        beforeShow : function() {
            $('#saleEndDt').css('color','');
            $('#saleEndDt').css('background-color','');
            $('#saleEndDt').val($("#saleStartDt").val());

        }
    });
	$("#exprStartDt").datepicker({
		dateFormat: "yy-mm-dd",
		minDate : "${SVR_TODAY}",
		maxDate : "+1y",
		onClose : function(selectedDate) {
			//$("#exprEndDt").datepicker("option", "minDate", selectedDate);
		}
	});
	$("#exprEndDt").datepicker({
		dateFormat: "yy-mm-dd",
		minDate : "${SVR_TODAY}",
		maxDate : "+1y +2m",
		onClose : function(selectedDate) {
			$("#exprStartDt").datepicker("option", "maxDate", selectedDate);
		}
	});
	$("#select_ctgr_1depth").change(function() {
		loadSubCategory($("#select_ctgr_1depth option:selected").val());
		$("#tr_ad").hide();
		$("#tr_ad2").hide();
	});

	$("#select_ctgr_2depth").change(function() {
		$("#ctgr").val($("#select_ctgr_2depth option:selected").val());
		if($(this).val() == "${Constant.CATEGORY_PACK_AD}"){
			$("#tr_ad").show();
			$("#tr_ad2").show();
		}else{
			$("#tr_ad").hide();
			$("#tr_ad2").hide();
		}
	});


	$("input:radio[name='prdtDiv']:input[value='${spPrdtInf.prdtDiv}']").attr("checked",true);
	if(${Constant.SP_PRDT_DIV_COUP eq spPrdtInf.prdtDiv}) {
		$("#tr_exprDiv").show();
		<c:if test="${spPrdtInf.exprDaynumYn eq Constant.FLAG_N}" >
		$("#tr_exprDt").show();
		</c:if>
		<c:if test="${spPrdtInf.exprDaynumYn eq Constant.FLAG_Y}" >
		$("#tr_exprDay").show();
		</c:if>
	}
	if(${Constant.SP_PRDT_DIV_FREE eq spPrdtInf.prdtDiv}) {
		$("#tr_dicInf").show();
		$("#tr_cancelGuide").hide();
		$("#tr_exprDt").show();
	}
	if(${Constant.CATEGORY_PACK_AD eq spPrdtInf.ctgr}){
		$("#tr_ad").show();
		$("#tr_ad2").show();
	}else{
		$("#tr_ad").hide();
		$("#tr_ad2").hide();
	}
	//카테고리 기본 값 selected 2Depth
	$.ajax({
		url: "<c:url value='/getCodeList.ajax'/>",
		data: "cdNum=${fn:substring(spPrdtInf.ctgr,0,2)}00",
		success:function(data) {
			var cdList = data.cdList;
			var dataArr = [];
			var inx = 0;

			$(cdList).each( function() {
				if("${spPrdtInf.ctgr}" == this.cdNum)
					dataArr[inx++] = "<option value=" + this.cdNum + " selected='selected'>" + this.cdNm + "</option> ";
				else
					dataArr[inx++] = "<option value=" + this.cdNum + ">" + this.cdNm + "</option> ";
			});

			$("#select_ctgr_2depth").append(dataArr);
		},
		error : fn_AjaxError
	});

	$("input[name=exprDaynumYn]").change(function() {
		if($(this).val() === "${Constant.FLAG_Y}") { //유효일자
			$("#tr_exprDt").hide();
			$("#tr_exprDay").show();
			$("#exprDaynum").val('${spPrdtInf.exprDaynum}');

			if('${spPrdtInf.exprDaynum}' == "0") {
				$("#exprDaynum").val(0);
			}
		} else { //유효기간
			$("#tr_exprDt").show();
			$("#tr_exprDay").hide();

			if(!('${spPrdtInf.exprStartDt}')){
				$("#exprStartDt").val('');
				$("#exprEndDt").val('');
			}

		}
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
			<!--본문-->
			<!--상품 수정-->
			<form:form commandName="SP_PRDTINFVO" name="spPrdtInf" method="post" enctype="multipart/form-data">
				<input type="hidden" name="prdtNum" value="${spPrdtInf.prdtNum }" />
				<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}"/>
			<div id="contents">
				<h2 class="title08"><c:out value="${spPrdtInf.prdtNm}"/></h2>

				<div id="menu_depth3">
					<ul>
	                    <li class="on"><a class="menu_depth3" href="javascript:fn_goTap('PRODUCT');">상품정보</a></li>
	                    <li><a class="menu_depth3" href="javascript:fn_goTap('IMG');" >상품목록이미지</a></li>
	                    <li><a class="menu_depth3" href="javascript:fn_goTap('IMG_DETAIL');" >상세이미지</a></li>
	                    <li><a class="menu_depth3" href="javascript:fn_goTap('DTLINF');" >상세정보</a></li>
	                    <c:if test="${spPrdtInf.prdtDiv ne Constant.SP_PRDT_DIV_FREE }">
	                    <li><a class="menu_depth3" href="javascript:fn_goTap('OPTION');" >옵션설정</a></li>
	                    <li><a class="menu_depth3" href="javascript:fn_goTap('ADD_OPTION');" >추가옵션설정</a></li>
	                    </c:if>
	                </ul>
                	<div class="btn_rt01">
                		<c:if test="${Constant.TRADE_STATUS_REG eq btnApproval}">
	               		<div class="btn_sty01"><a href="javascript:fn_approvalReqSocial();">승인요청</a></div>
	               		</c:if>
	               		<c:if test="${Constant.TRADE_STATUS_APPR_REQ eq btnApproval }">
	               		<div class="btn_sty01"><a href="javascript:fn_approvalCancelSocial();">승인취소</a></div>
	               		</c:if>
	               </div>
	            </div>
	            <c:if test="${not empty apprMsg}">
				<h4 class="title03">전달 사항</h4>
				<table border="1" class="table01">
					<colgroup>
                        <col width="*" />
                    </colgroup>
                    <tr>
						<td>
							<c:out value="${apprMsg}"  escapeXml="false"/>
						</td>
					</tr>
				</table>
				</c:if>

				<h4 class="title03">상품정보</h4>
				<table border="1" class="table02">
					<colgroup>
                        <col width="200" />
                        <col width="*" />
                        <col width="200" />
                        <col width="*" />
                    </colgroup>
                    <tr>
                    	<th>상품 ID</th>
                    	<td><c:out value="${spPrdtInf.prdtNum}"></c:out></td>
                    	<th>거래상태</th>
                    	<td>
                    		<c:if test="${Constant.TRADE_STATUS_REG eq spPrdtInf.tradeStatus }">
                    			등록중
                    		</c:if>
                    		<c:if test="${Constant.TRADE_STATUS_APPR_REQ eq spPrdtInf.tradeStatus }">
                    			승인요청
                    		</c:if>
                    		<c:if test="${Constant.TRADE_STATUS_APPR eq spPrdtInf.tradeStatus }">
                    			승인
                    		</c:if>
                    		<c:if test="${Constant.TRADE_STATUS_APPR_REJECT eq spPrdtInf.tradeStatus }">
                    			승인거절
                    		</c:if>
                    		<c:if test="${Constant.TRADE_STATUS_STOP eq spPrdtInf.tradeStatus }">
                    			판매중지
                    		</c:if>
                    		<c:if test="${Constant.TRADE_STATUS_EDIT eq spPrdtInf.tradeStatus }">
                    			수정요청
                    		</c:if>
                    		<c:if test="${Constant.TRADE_STATUS_REJECT eq spPrdtInf.tradeStatus }">
                    			거래중지
                    		</c:if>
                    		<input type="hidden" name="tradeStatus" value="${spPrdtInf.tradeStatus }" />
                    	</td>
                    </tr>
					<c:if test="${spPrdtInf.lsLinkYn eq 'Y' || spPrdtInf.lsLinkYn eq 'J' || spPrdtInf.lsLinkYn eq 'V'}">
					<tr>
						<th>
							<c:if test="${spPrdtInf.lsLinkYn eq 'Y'}">
								LS컴퍼니 상품번호
							</c:if>
							<c:if test="${spPrdtInf.lsLinkYn eq 'J'}">
								야놀자 상품번호
							</c:if>
							<c:if test="${spPrdtInf.lsLinkYn eq 'V'}">
								브이패스 상품번호
							</c:if>
						</th>
						<td colspan="3">
							<input type="text" name="lsLinkPrdtNum" value="${spPrdtInf.lsLinkPrdtNum }" class="input_text20" />
						</td>
					</tr>
					</c:if>
					<tr>
						<th scope="row">상품카테고리<span class="font_red">*</span></th>
						<td colspan="3">
							<select id="select_ctgr_1depth" name="select_ctgr_1depth">
								<option value="">대분류 선택</option>
								<c:forEach var="categoryList" items="${categoryList}">
								<option value="${categoryList.cdNum}"<c:if test="${fn:substring(spPrdtInf.ctgr,0,2) eq fn:substring(categoryList.cdNum,0,2)}"> selected="selected"</c:if>>${categoryList.cdNm}</option>
								</c:forEach>
							</select>
							<select id="select_ctgr_2depth" name="select_ctgr_2depth">
								<option value="">소분류 선택</option>
							</select>
							<input type="hidden"  id="ctgr" name="ctgr"  value="${spPrdtInf.ctgr}"/>
							<form:errors path="ctgr"  cssClass="error_text" />
						</td>
					</tr>
					<tr>
						<th>상품명<span class="font_red">*</span></th>
						<td colspan="3">
							<form:input path="prdtNm" id="prdtNm" value="${spPrdtInf.prdtNm}" class="input_text20" maxlength="30" />
							<form:errors path="prdtNm"  cssClass="error_text" />
						</td>
					</tr>
					<tr>
						<th>상품구분<span class="font_red">*</span></th>
						<td  colspan="3">
							<input type="radio" name="prdtDiv" value="${spPrdtInf.prdtDiv}" checked> <label for="prdtDiv">
								<c:if test="${spPrdtInf.prdtDiv eq Constant.SP_PRDT_DIV_TOUR }">
									여행상품 : 날짜별 요금을 적용하는 상품
								</c:if>
								<c:if test="${spPrdtInf.prdtDiv eq Constant.SP_PRDT_DIV_COUP }">
									쿠폰상품 : 옵션별 요금과 유효기간을 적용하는 상품
								</c:if>
								<c:if test="${spPrdtInf.prdtDiv eq Constant.SP_PRDT_DIV_FREE }">
									무료쿠폰 : 구매 없이 이용가능한 무료할인쿠폰
								</c:if>
								</label></input>
						</td>
					</tr>
					<tr>
						<th>상품정보</th>
						<td colspan="3">
							<form:input path="prdtInf" id="prdtInf" value="${spPrdtInf.prdtInf}" class="input_text_full" maxlength="66" />
							<form:errors path="prdtInf"  cssClass="error_text" />
						</td>
					</tr>

					<tr>
						<th>검색어</th>
						<td colspan="3">
							<p>
								<input type="text" name="srchWord1" id="srchWord1" maxlength="30" value="${spPrdtInf.srchWord1}" />
								<input type="text" name="srchWord2" id="srchWord2" maxlength="30" value="${spPrdtInf.srchWord2}" />
								<input type="text" name="srchWord3" id="srchWord3" maxlength="30" value="${spPrdtInf.srchWord3}" />
								<input type="text" name="srchWord4" id="srchWord4" maxlength="30" value="${spPrdtInf.srchWord4}" />
								<input type="text" name="srchWord5" id="srchWord5" maxlength="30" value="${spPrdtInf.srchWord5}" />
							</p>
							<p>
								<input type="text" name="srchWord6" id="srchWord6" maxlength="30" value="${spPrdtInf.srchWord6}" />
								<input type="text" name="srchWord7" id="srchWord7" maxlength="30" value="${spPrdtInf.srchWord7}" />
								<input type="text" name="srchWord8" id="srchWord8" maxlength="30" value="${spPrdtInf.srchWord8}" />
								<input type="text" name="srchWord9" id="srchWord9" maxlength="30" value="${spPrdtInf.srchWord9}" />
								<input type="text" name="srchWord10" id="srchWord10" maxlength="30" value="${spPrdtInf.srchWord10}" />
							</p>
							<br /><span class="font02">※ 상품의 주요 특징을 적어주세요 (사용자의 통합 검색 시 검색되는 검색어 입니다)</span>
						</td>
					</tr>

					<tr>
						<th>판매시작일<span class="font_red">*</span></th>
						<td>
							<form:input path="saleStartDt" id="saleStartDt"  class="input_text5" value="${fn:substring(spPrdtInf.saleStartDt,0,4)}-${fn:substring(spPrdtInf.saleStartDt,4,6)}-${fn:substring(spPrdtInf.saleStartDt,6,8)}" readonly="true" />
							<form:errors path="saleStartDt"  cssClass="error_text" />
						</td>
						<th>판매종료일<span class="font_red">*</span></th>
						<td>
							<form:input path="saleEndDt" id="saleEndDt"  class="input_text5" value="${fn:substring(spPrdtInf.saleEndDt,0,4)}-${fn:substring(spPrdtInf.saleEndDt,4,6)}-${fn:substring(spPrdtInf.saleEndDt,6,8) }" readonly="true"/>
							<form:errors path="saleEndDt"  cssClass="error_text" />
                            <div class="btn_sty07" style="margin-left:5px;"><span><a href="javascript:$('#saleEndDt').val('9999-01-01');$('#saleEndDt').css('color','#eeeeee');$('#saleEndDt').css('background-color','#eeeeee');$('#saleStartDt').datepicker('option', 'maxDate', '9999-01-01');">종료일없음</a></span></div>
						</td>
					</tr>
					<tr id="tr_ad" style="display:none">
						<th>숙소 지역 <span class="font_red">*</span></th>
						<td>
							<select name="adArea" >
								<c:forEach var="data" items="${cdAdar}" varStatus="status">
									<option value="${data.cdNum}" <c:if test="${data.cdNum eq spPrdtInf.adArea}">selected="selected"</c:if>>${data.cdNm}</option>
								</c:forEach>
							</select>
						</td>
						<th>숙소 구분 <span class="font_red">*</span></th>
						<td>
							<select name="adDiv" >
								<c:forEach var="data" items="${cdAddv}" varStatus="status">
									<option value="${data.cdNum}" <c:if test="${data.cdNum eq spPrdtInf.adDiv}">selected="selected"</c:if>>${data.cdNm}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr id="tr_ad2" style="display:none">
						<th>주요정보</th>
						<td colspan="3">
							<c:forEach var="icon" items="${iconCdList}">
								<input type="checkbox" name="iconCd" value="${icon.iconCd}" <c:if test="${icon.checkYn eq 'Y'}">checked</c:if>>${icon.iconCdNm}</input>
							</c:forEach>
						</td>
					</tr>
					<tr id="tr_ad3">
						<th>업체주소</th>
						<td colspan="3">
							<div class="btn_sty07"><span><a href="javascript:openDaumPostcode()">주소검색</a></span></div>
							<form:input path="roadNmAddr" id="roadNmAddr"  class="input_text15" readonly="readonly" value="${spPrdtInf.roadNmAddr}" />
							<form:input path="dtlAddr" id="dtlAddr"  class="input_text15" maxlength="100" value="${spPrdtInf.dtlAddr}" />
							<form:errors path="roadNmAddr"  cssClass="error_text" />
							<form:errors path="dtlAddr"  cssClass="error_text" />
						</td>
					</tr>
					<tr id="tr_ad4">
						<th>위도/경도</th>
						<td colspan="3">
							<div class="btn_sty07"><span><a href="javascript:fn_FindLocation()">좌표찾기</a></span></div>
							위도 : <form:input path="lat" id="lat" readonly="readonly" value="${spPrdtInf.lat}" />
							경도 : <form:input path="lon" id="lon" readonly="readonly" value="${spPrdtInf.lon}" />
							<form:errors path="lat"  cssClass="error_text" />
							<form:errors path="lon"  cssClass="error_text" />
						</td>
					</tr>
					<c:if test="${linkPrdtUseYn eq Constant.FLAG_Y}">
					<tr>
						<th>LINK 상품 여부 <span class="font_red">*</span></th>
						<td>
							<select name="linkPrdtYn" id="linkPrdtYn">
								<option value="${Constant.FLAG_N}" <c:if test="${spPrdtInf.linkPrdtYn eq Constant.FLAG_N}">selected="selected"</c:if>>사용안함</option>
								<option value="${Constant.FLAG_Y}" <c:if test="${spPrdtInf.linkPrdtYn eq Constant.FLAG_Y}">selected="selected"</c:if>>사용</option>
							</select>
						</td>
						<th>LINK URL</th>
						<td>
							<input type="text" name="linkUrl" id="linkUrl" class="input_text30" maxlength="300" value="${spPrdtInf.linkUrl}" />
							<span class="font02">'http://','https://'등을 반드시 입력 하세요.</span>
						</td>
					</tr>
					</c:if>
					<tr id="tr_exprDiv" style="display:none">
						<th>유효구분 <span class="font_red">*</span></th>
						<td>
							<input type="radio" name="exprDaynumYn" id="exprDaynumYn1" value="${Constant.FLAG_N}" <c:if test="${spPrdtInf.exprDaynumYn eq Constant.FLAG_N}" >checked="checked"</c:if>> <label for="exprDaynumYn1">유효기간 : 유효기간 내에 사용</label></input><br />
							<input type="radio" name="exprDaynumYn" id="exprDaynumYn2" value="${Constant.FLAG_Y}" <c:if test="${spPrdtInf.exprDaynumYn eq Constant.FLAG_Y}" >checked="checked"</c:if>> <label for="exprDaynumYn2">유효일자 : 구매일로 부터 유효일자 내에 사용</label></input><br />
						</td>
						<th>이용가능시간<span class="font_red">*</span></th>
						<td>
							<form:input path="useAbleTm" id="useAbleTm"  class="input_text10" value="${spPrdtInf.useAbleTm}" placeholder="0~72"/> 시간
							<br /><span class="font_red">즉시이용 가능하면 0 / 구매후 3시간 이후 가능이면 3 (72까지 입력가능)</span>
						</td>
					</tr>
					<tr id="tr_exprDt" style="display:none">
						<th>유효기간<span class="font_red">*</span></th>
						<td colspan="3">
							<form:input path="exprStartDt" id="exprStartDt" class="input_text5" readonly="true" value="${fn:substring(spPrdtInf.exprStartDt, 0,4)}-${fn:substring(spPrdtInf.exprStartDt, 4,6)}-${fn:substring(spPrdtInf.exprStartDt, 6,8)}"/> ~
							<form:input path="exprEndDt" id="exprEndDt" class="input_text5" readonly="true" value="${fn:substring(spPrdtInf.exprEndDt,0,4)}-${fn:substring(spPrdtInf.exprEndDt,4,6)}-${fn:substring(spPrdtInf.exprEndDt,6,8)}"/>
							<form:errors path="exprStartDt"  cssClass="error_text" /><form:errors path="exprEndDt"  cssClass="error_text" />
						</td>
					</tr>
					<tr id="tr_exprDay" style="display:none">
						<th>유효일수 <span class="font_red">*</span></th>
						<td colspan="3">
							<form:input path="exprDaynum" id="exprDaynum" class="input_text10"  maxlength="40" value="${spPrdtInf.exprDaynum}"/> 일
						</td>
					</tr>
					<tr>
						<th>사전예약</th>
						<td  colspan="3">
							<input type="radio" name="advRvYn"  value="${Constant.FLAG_Y}" <c:if test='${spPrdtInf.advRvYn eq Constant.FLAG_Y}'>checked</c:if>>&nbsp;Y</input>&nbsp;
							<input type="radio" name="advRvYn"  value="${Constant.FLAG_N}" <c:if test='${spPrdtInf.advRvYn eq Constant.FLAG_N}'>checked</c:if>>&nbsp;N </input>&nbsp;
						</td>
					</tr>
					<tr id="tr_dicInf" style="display:none">
						<th>할인정보</th>
						<td colspan="3">
							<form:input path="disInf" id="disInf" class="input_text_full" maxlength="13" value="${spPrdtInf.disInf}"/>
							<form:errors path="disInf"  cssClass="error_text" />
						</td>
					</tr>

					<tr>
						<th>홍보영상</th>
						<td colspan="3">
							<input name="adMov" id="adMov" value="${spPrdtInf.adMov}" class="input_text_full" maxlength="300" />
							<br /><span class="font02">※ YouTube 동영상의 경로를 넣으시면 됩니다. ( https://www.youtube.com/embed/유튜브영상고유번호 )</span>
						</td>
					</tr>

					<%-- <tr>
						<th>상품상세이미지</th>
						<td colspan="3">
							<c:if test="${not empty spPrdtInf.prdtDtlImg }">
								<div id="d_prdtImgList">
								<c:out value="${spPrdtInf.prdtDtlImg}" />
								<div class="btn_sty06">
									<span><a href="javascript:fn_DelPrdtImg()">삭제</a></span>
								</div>
								<div class="btn_sty06">
									<span><a href="javascript:fn_SaleStartSocial('${spPrdtInfo.prdtNum}')">상세보기</a></span>
								</div>
								</div>
							</c:if>
							<input type="file" id="prdtDtlImgFile" name="prdtDtlImgFile" accept="image/*" style="width: 70%; <c:if test="${not empty spPrdtInf.prdtDtlImg}">display:none</c:if>" />
							<input type="hidden" id="prdtDtlImg"  name="prdtDtlImg" class="input_text5" value="${spPrdtInf.prdtDtlImg}" />
						</td>
					</tr> --%>
					<tr>
						<th>사용조건</th>
						<td colspan="3">
							<script type="text/javascript">
							 var editor1 = new Dext5editor('editor1');
							</script>
							<textarea name="useQlfct" id="useQlfct" cols="15" rows="10" style="display:none">${spPrdtInf.useQlfct}</textarea>
							<form:errors path="useQlfct"  cssClass="error_text" />
						</td>
					</tr>
					<tr id="tr_cancelGuide">
						<th>취소안내</th>
						<td colspan="3">
							<script type="text/javascript">
							 var editor2 = new Dext5editor('editor2');
							</script>
							<textarea name="cancelGuide" id="cancelGuide" cols="15" rows="10" style="display:none">${spPrdtInf.cancelGuide}</textarea>
							<form:errors path="cancelGuide"  cssClass="error_text" />
						</td>
					</tr>

					<tr>
						<th>지역<span class="font02"></span></th>
						<td colspan="3">
							<select name="area" >
								<option value="">-없음-</option>
								<c:forEach var="data" items="${cdAdar}" varStatus="status">
									<option value="${data.cdNum}" <c:if test="${data.cdNum==fn:trim(spPrdtInf.area)}">selected="selected"</c:if> >${data.cdNm}</option>
								</c:forEach>
							</select>
						</td>
					</tr>


					<tr>
						<th>등록시간</th>
						<td>${spPrdtInf.frstRegDttm} (${spPrdtInf.frstRegId})</td>
						<th>수정시간</th>
						<td>${spPrdtInf.lastModDttm} (${spPrdtInf.lastModId})</td>
					</tr>
				</table>
				<ul class="btn_rt01 align_ct">
					<c:if test="${Constant.TRADE_STATUS_APPR eq spPrdtInf.tradeStatus }">
					<li class="btn_sty04"><a href="javascript:fn_SaleStopSocial()">판매중지 요청</a></li>
					</c:if>
					<c:if test="${Constant.TRADE_STATUS_STOP eq spPrdtInf.tradeStatus }">
					<li class="btn_sty04 "><a href="javascript:fn_PrintN()">판매종료</a></li>
					<li class="btn_sty04"><a href="javascript:fn_SaleStartSocial()">판매전환</a></li>
					</c:if>
					<li class="btn_sty04">
						<a href="javascript:fn_UpdateSpPrdtInfo()">수정</a>
					</li>
					<li class="btn_sty01">
						<a href="javascript:fn_socialProductList()">목록</a>
					</li>
				</ul>
			</div>
			</form:form>
			<!--//상품등록-->
			<!--//본문-->
		</div>
	</div>
	<form name="tabForm">
		<input type="hidden" name="prdtNum"  value="${spPrdtInf.prdtNum }"/>
		<input type="hidden" name="sPrdtNm" value="${searchVO.sPrdtNm}" />
		<input type="hidden" name="sTradeStatus" value="${searchVO.sTradeStatus}" />
		<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}"/>
	</form>
	<!--//Contents 영역-->
</div>
</body>
</html>