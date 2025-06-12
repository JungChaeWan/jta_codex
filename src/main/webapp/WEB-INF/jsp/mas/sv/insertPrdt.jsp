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

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/dext5editor/js/dext5editor.js'/>"></script>
<script type="text/javascript" src="<c:url value='/dext5upload/js/dext5upload.js'/>"></script>

<validator:javascript formName="SV_PRDTINFVO" staticJavascript="false" xhtml="true" cdata="true"/>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title>탐나오 관리자 시스템 > 상품관리 > 상품등록</title>

<script type="text/javascript">
/**
 * 상품 기본 정보 수정
 */
function fn_InsertSvPrdtInfo(){
	// validation 체크
	if($("#ctgr").val() == '') {
		alert("카테고리를 선택해 주세요.");
		return ;
	}
	// validation 체크
	if(!validateSV_PRDTINFVO(document.SV_PRDTINFVO)){
		return;
	}

	if($('#org').val() === null || $('#org').val().trim() === ''){
		alert('원산지를 입력해 주세요.');
		$('#org').focus();
		return;
	}

	$("#saleStartDt").val($('#saleStartDt').val().replace(/-/g, ""));
	$("#saleEndDt").val($('#saleEndDt').val().replace(/-/g, ""));

	$("#prdtExp").val(DEXT5.getBodyValueExLikeDiv('editor1'));

	DEXT5UPLOAD.Transfer("upload1");
}

function DEXT5UPLOAD_OnTransfer_Complete() {
	if(DEXT5UPLOAD.GetNewUploadListForText()) {
		var jsonFileList = DEXT5UPLOAD.GetNewUploadListForJson("upload1");
		document.getElementById("fileList").value = jsonFileList.uploadPath;
	}
   	document.SV_PRDTINFVO.action = "<c:url value='/mas/sv/insertProductInfo.do' />";
	document.SV_PRDTINFVO.submit();
}

// 상품 리스트
function fn_svProductList() {
	document.SV_PRDTINFVO.action = "<c:url value='/mas/sv/productList.do' />";
	document.SV_PRDTINFVO.submit();
}

// 대분류 선택 시 중분류 setting
function loadSubCategory(cdNum) {
	$("#subCtgr option:eq(0)").nextAll().remove();

	$.ajax({
		url: "<c:url value='/getCodeList.ajax'/>",
		data: "cdNum="+cdNum,
		success:function(data) {
			var cdList = data.cdList;
			var dataArr = [];
			var inx = 0;

			$(cdList).each( function() {
				dataArr[inx++] = "<option value=" + this.cdNum + ">" + this.cdNm + "</option> ";
			});

			$("#subCtgr").append(dataArr);
		},
		error: fn_AjaxError
	})
}

$(function() {
	$("#saleStartDt").datepicker({
		dateFormat: "yy-mm-dd",
		minDate : "${SVR_TODAY}",
		maxDate : "+1y",
		onClose : function(selectedDate) {
			if($('#saleEndDt').val() != "9999-01-01") {
				$("#saleEndDt").datepicker("option", "minDate", selectedDate);
			}
		}
	});
	$("#saleEndDt").datepicker({
		dateFormat: "yy-mm-dd",
		minDate : "${SVR_TODAY}",
		maxDate : "+1y",
		onClose : function(selectedDate) {
			$("#saleStartDt").datepicker("option", "maxDate", selectedDate);
			if($('#saleEndDt').val() == "9999-01-01"){
				$("#saleStartDt").datepicker("option", "maxDate", "9999-01-01");
			}
		},
		beforeShow : function() {
			$('#saleEndDt').css('color','');
			$('#saleEndDt').css('background-color','');
			$('#saleEndDt').val($("#saleStartDt").val());

		}
	});

	$("#directRecvYn").change(function () {
		if($(this).val() == "Y") {
			$("#spanDelivery").show();
		} else {
			$("#spanDelivery").hide();
		}
	});

	let currentOrgText = $('#org').val();
	$("#detailReference").change(function(){
		if($(this).is(':checked')){
			currentOrgText = $('#org').val();
			$('#org').val('상세페이지를 참고해 주세요.');
		}else{
			$('#org').val(currentOrgText);
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
			<!--상품 등록-->
			<form:form commandName="SV_PRDTINFVO" name="SV_PRDTINFVO" method="post">
				<input type="hidden" name="prdtNum" value="${SV_PRDTINFVO.prdtNum}" />
				<input type="hidden" name="sPrdtNm" value="${searchVO.sPrdtNm}" />
				<input type="hidden" name="sTradeStatus" value="${searchVO.sTradeStatus}" />
				<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}"/>

				<div id="contents">
					<h4 class="title03">상품 등록<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span></h4>

					<table class="table02" border="1">
						<colgroup>
							<col width="200" />
							<col width="*" />
							<col width="200" />
							<col width="*" />
						</colgroup>
						<tr>
							<th scope="row">상품카테고리<span class="font_red">*</span></th>
							<td colspan="3">
								<select id="ctgr" name="ctgr" onchange="loadSubCategory(this.value);">
									<option value="">대분류 선택</option>
									<c:forEach var="categoryList" items="${categoryList}">
										<option value="${categoryList.cdNum}">${categoryList.cdNm}</option>
									</c:forEach>
								</select>
								<form:errors path="ctgr" cssClass="error_text" />
								 -
								<select id="subCtgr" name="subCtgr">
									<option value="">중분류 선택</option>
								</select>
								<form:errors path="subCtgr" cssClass="error_text" />
							</td>
						</tr>
						<tr>
							<th>상품명<span class="font_red">*</span></th>
							<td colspan="3">
								<form:input path="prdtNm" id="prdtNm" value="${svPrdtInf.prdtNm}" class="input_text50" maxlength="30" />
								<form:errors path="prdtNm" cssClass="error_text" />
							</td>
						</tr>
						<tr>
							<th>상품정보</th>
							<td colspan="3">
								<form:input path="prdtInf" id="prdtInf" value="${svPrdtInf.prdtInf}" class="input_text_full" maxlength="66" />
								<form:errors path="prdtInf" cssClass="error_text" />
							</td>
						</tr>
						<tr>
							<th>직접수령가능여부</th>
							<td colspan="3">
								<select id="directRecvYn" name="directRecvYn">
									<option value="N">직접수령 불가</option>
									<option value="Y">직접수령 가능</option>
								</select>
								&nbsp;
								<span id="spanDelivery" style="display: none;">
									<select name="deliveryYn" id="deliveryYn">
										<option value="Y">배송 가능</option>
										<option value="N">배송 불가</option>
									</select>
									<span class="font02">(※ 직접수령만 가능한 경우 배송불가를 선택해주세요.)</span>
								</span>
							</td>
						</tr>
						<tr>
							<th>검색어</th>
							<td colspan="3">
								<p>
									<input type="text" name="srchWord1" id="srchWord1" maxlength="30" value="${svPrdtInf.srchWord1}" />
									<input type="text" name="srchWord2" id="srchWord2" maxlength="30" value="${svPrdtInf.srchWord2}" />
									<input type="text" name="srchWord3" id="srchWord3" maxlength="30" value="${svPrdtInf.srchWord3}" />
									<input type="text" name="srchWord4" id="srchWord4" maxlength="30" value="${svPrdtInf.srchWord4}" />
									<input type="text" name="srchWord5" id="srchWord5" maxlength="30" value="${svPrdtInf.srchWord5}" />
								</p>
								<p>
									<input type="text" name="srchWord6" id="srchWord6" maxlength="30" value="${svPrdtInf.srchWord6}" />
									<input type="text" name="srchWord7" id="srchWord7" maxlength="30" value="${svPrdtInf.srchWord7}" />
									<input type="text" name="srchWord8" id="srchWord8" maxlength="30" value="${svPrdtInf.srchWord8}" />
									<input type="text" name="srchWord9" id="srchWord9" maxlength="30" value="${svPrdtInf.srchWord9}" />
									<input type="text" name="srchWord10" id="srchWord10" maxlength="30" value="${svPrdtInf.srchWord10}" />
								</p>
								<span class="font02">※ 상품의 주요 특징을 적어주세요.(사용자의 통합검색시 검색되는 검색어입니다)</span>
							</td>
						</tr>
						<tr>
							<th>생산자<span class="font_red">*</span></th>
							<td colspan="3">
								<form:input path="prdc" id="prdc" value="${svPrdtInf.prdc}" class="input_text50" maxlength="30" />
								<form:errors path="prdc" cssClass="error_text" />
							</td>
						</tr>
						<tr>
							<th>판매시작일<span class="font_red">*</span></th>
							<td>
								<form:input path="saleStartDt" id="saleStartDt"  class="input_text5" readonly="true" />
								<form:errors path="saleStartDt" cssClass="error_text" />
							</td>
							<th>판매종료일<span class="font_red">*</span></th>
							<td>
								<form:input path="saleEndDt" id="saleEndDt"  class="input_text5" readonly="true"/>
								<form:errors path="saleEndDt" cssClass="error_text" />
								<div class="btn_sty07" style="margin-left:5px;"><span><a href="javascript:$('#saleEndDt').val('9999-01-01');$('#saleEndDt').css('color','#eeeeee');$('#saleEndDt').css('background-color','#eeeeee');$('#saleStartDt').datepicker('option', 'maxDate', '9999-01-01');">종료일없음</a></span></div>
							</td>
						</tr>
						<tr>
							<th>상품이미지<br><span class="font02">(등록 사이즈 : 600*400)</span></th>
							<td colspan="3">
								<script type="text/javascript">
									DEXT5UPLOAD.config.HandlerUrl = "<c:url value='/mas/dext/uploadHandler.dext'/>";
									//DEXT5UPLOAD.config.Security.EncryptParam = '0';
									DEXT5UPLOAD.config.Views = 'thumbs';
									var upload1 = new Dext5Upload("upload1");
								</script>
								<input type="hidden" id="fileList" name="fileList" />
							</td>
						</tr>
						<tr>
							<th>상품 설명</th>
							<td colspan="3">
								<script type="text/javascript">
									DEXT5.config.InitXml="dext_editor_image.xml";
									DEXT5.config.HandlerUrl = "<c:url value='/mas/dext/ImageUploadHandler.dext'/>";
									var editor1 = new Dext5editor("editor1");
								</script>
								<input type="hidden" name="prdtExp" id="prdtExp" />
							</td>
						</tr>
						<tr>
							<th>홍보영상</th>
							<td colspan="3">
								<input name="adMov" id="adMov" class="input_text_full" maxlength="200" />

								<p class="font02">※ YouTube 동영상의 경로를 넣으시면 됩니다. ( https://www.youtube.com/embed/유튜브영상고유번호 )</p>
							</td>
						</tr>
						<tr>
							<th>원산지<span class="font_red">*</span></th>
							<td colspan="3">
								<input type="checkbox" id="detailReference"> <label for="detailReference"><b>상세페이지참고</b>(상세페이지 이미지에 내용이 있을 경우 체크)</label>
								<textarea name="org" id="org" cols="15" rows="10" placeholder="농산물
｢농수산물 품질관리법｣에 따른 유전자변형농수산물 표시, 지리적 표시(시.군.구 단위 표시)
예시) 고사리(국산), 고사리(충청북도), 고사리(보은군)

가공품
배합비율/원료 함량이 높은 순위에 따라 국가명 표시
➀ 1순위 원료가 98% 이상인 경우: 1순위 원료의 원산지만 표시
예시) 미국 밀가루 98%, 국산 소금 2% 혼합
▶ 밀가루 (미국)

➁ 1순위, 2순위 원료 합이 98% 이상인 경우: 1, 2순위 원료의 원산지만 표시
예시) 국산 찹쌀가루 76%, 중국산 팥 22%, 중국산 참기름 1%, 국산 소금 1% 혼합
▶ 찹쌀가루(찹쌀:국산), 팥(중국)

➂ 그 외의 경우: 1, 2, 3순위까지 원료의 원산지 표시
예시) 호주 밀가루 60%, 국산 팥 20%, 중국산 동부 10%, 국산 소금 5% 설탕 5% 혼합
▶ 밀가루(호주), 팥(국산), 동부(중국)

축산물
축산법에 따른 등급 표시
1) 등급 (1++ 국내산 쇠고기의 경우 ｢소·돼지 식육의 표시방법 및 부위 구분기준｣에 따라 근내지방도 정보를 포함하여 표시)
2) ｢가축 및 축산물 이력관리에 관한 법률｣에 따른 이력관리대상축산물 유무 표시"></textarea>
							</td>
						</tr>
						<tr>
							<th>취급주의사항</th>
							<td colspan="3">
								<textarea name="hdlPrct" id="hdlPrct" cols="15" rows="10"></textarea>
								<form:errors path="hdlPrct" cssClass="error_text" />
							</td>
						</tr>
						<tr>
							<th>배송안내</th>
							<td colspan="3">
								<textarea name="dlvGuide" id="dlvGuide" cols="15" rows="10"></textarea>
								<form:errors path="dlvGuide" cssClass="error_text" />
							</td>
						</tr>
						<tr>
							<th>취소안내</th>
							<td colspan="3">
								<textarea name="cancelGuide" id="cancelGuide" cols="15" rows="10"></textarea>
								<form:errors path="cancelGuide" cssClass="error_text" />
							</td>
						</tr>
						<tr>
							<th>교환/반품안내</th>
							<td colspan="3">
								<textarea name="tkbkGuide" id="tkbkGuide" cols="15" rows="10"></textarea>
								<form:errors path="tkbkGuide" cssClass="error_text" />
							</td>
						</tr>
					</table>

					<ul class="btn_rt01 align_ct">
						<li class="btn_sty04"><a href="javascript:fn_InsertSvPrdtInfo()">저장</a></li>
						<li class="btn_sty01"><a href="javascript:fn_svProductList()">목록</a></li>
					</ul>
				</div>
			</form:form>
			<!--//상품등록-->
			<!--//본문-->
		</div>
	</div>
	<!--//Contents 영역-->
</div>
</body>
</html>