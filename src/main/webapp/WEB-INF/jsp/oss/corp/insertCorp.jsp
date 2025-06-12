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
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=71cf66fb54158dacb5fb5b656674ad70&libraries=services"></script>

<validator:javascript formName="CORPVO" staticJavascript="false" xhtml="true" cdata="true"/>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
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
function fn_FindLocation() {
	var addr = $("#roadNmAddr").val();
	
	if(isNull(addr)) {
		alert("주소를 입력해주세요.");
		$("#dtlAddr").focus();
		return;
	}
	var geocoder = new daum.maps.services.Geocoder();

    var callback = function(result, status) {
	    if(status == daum.maps.services.Status.OK) {
            var lat = result[0].y
            var lng = result[0].x
	    	
	    	$("#lon").val(lng);
			$("#lat").val(lat);
	    }else{
	    	if(status == daum.maps.services.Status.ZERO_RESULT){
	    		alert("해당 주소에 대한 결과값이 없습니다.");
				return;
	    	}else if(status == daum.maps.services.Status.RESULT_NOT_FOUND){
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

function fn_InsCorp() {
	// validation 체크
	if(!validateCORPVO(document.CORPVO)) {
		return;
	}
	if($("#corpLinkYn_chk").is(":checked")) {
		$("#corpLinkYn").val("Y");
	} else {
		$("#corpLinkYn").val("N");
	}
	if($("#corpLinkIsrYn_chk").is(":checked")) {
		$("#corpLinkIsrYn").val("Y");
	} else {
		$("#corpLinkIsrYn").val("N");
	}
	if($("#superbCorpYn_chk").is(":checked")) {
		$("#superbCorpYn").val("Y");
	} else {
		$("#superbCorpYn").val("N");
	}
	document.CORPVO.action = "<c:url value='/oss/insertCorp.do' />";
	document.CORPVO.submit();
}

function fn_FindUser(){
	window.open("<c:url value='/oss/findUser.do'/>","findUser", "width=580, height=600, scrollbars=yes, status=no, toolbar=no;");
}

function fn_SelectUer(userId, userNm, telNum){
	$("#managerId").val(userId);
	$("#managerNm").val(userNm);
}

$(document).ready(function(){
	$("#corpModCd").change(function(){
		$("#corpCd").val($(this).val().substring(1, 3));
	
		if($("#corpCd").val() == '${Constant.SOCIAL}') {
			$("#corpSubCd").css('display', 'inline-block');
			$("#posUseYn").css('display', 'inline-block');
		} else  {
			$("#corpSubCd").css('display', 'none');
			$("#posUseYn").css('display', 'none');
		}
	});	
	
	$("#visitNm").bind("keydown", function(event) {
		if(event.keyCode == $.ui.keyCode.TAB && $(this).data("ui-autocomplete").menu.active) {
			event.preventDefault();
		}      
	}).autocomplete({
		minLength: 1,
		source: function( request, response ) {
			var parameters = "title=" + $('#visitNm').val();
			var visitJEJU = [];
			$.ajax({
				type:"post", 
				dataType:"json",
				async:false,
				url:"<c:url value='/oss/getVisitJeju.ajax'/>",
				data:parameters ,
				success:function(data){
					// 코드 배열
					var arrayItem = [];
					jQuery.each(data.visitJejuList, function(index, onerow) {
						if (onerow["contentsid"] != null && onerow["contentsid"] != '') {
							var subStr = onerow["title"] + " [" + onerow["address"] + "]"
							visitJEJU[index] = {label:subStr, value:onerow["contentsid"]};
						}
					});
				
					if(visitJEJU.length == 0) {
						visitJEJU[0] = {label:'데이터가 없습니다.', value:'0000'};
					}
					response(visitJEJU);
				}
			});
		},        
		focus: function() {
			return false;        
		},        
		select: function(event, ui) {
			if(ui.item.value != "0000") {
				this.value = ui.item.label.substring(0, ui.item.label.indexOf("[", 0)).trim();
				$("#visitMappingId").val(ui.item.value);
				$("#visitMappingNm").val(this.value);
			}
			return false;
		}      
	}).blur(function(){			
		var strVal = this.value;
		if(strVal.substr(strVal.length - 1, strVal.length) == ",") {
			strVal = strVal.substr(0, strVal.length - 1);
			this.value = strVal;
		} 
	});
});
</script>
</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/oss/head.do?menu=corp" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=corp&sub=corp" flush="false"></jsp:include>
		<div id="contents_area"> 
			<!--본문-->
			<div id="contents">
			
			<!--업체 등록-->
			<form:form commandName="CORPVO" name="CORPVO" method="post" enctype="multipart/form-data">
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
				<input type="hidden" id="sCorpNm" name="sCorpNm" value="${searchVO.sCorpNm}"/>
			
				<h4 class="title03">입점업체 등록</h4>	
				<!-- 업체 일반정보 -->		
				<table border="1" class="table02">
					<colgroup>
                        <col width="15%" />
                        <col width="35%" />
                        <col width="15%" />
                        <col width="35%" />
                    </colgroup>
					<tr>
						<th scope="row">업체아이디<span class="font02">*</span></th>
						<td colspan="3">자동으로 입력됩니다.</td>
					</tr>
					<tr>
						<th>업체명<span class="font02">*</span></th>
						<td>
							<form:input path="corpNm" id="corpNm" class="input_text10" maxlength="20" value="${corpInfo.corpNm}" />
							<form:errors path="corpNm" cssClass="error_text" />
						</td>
						<th>회사유형<span class="font02">*</span></th>
						<td>
							<input type="radio" name="corpType"  id="corpType1" value="${Constant.CORP_TYPE_CORP }" /><label for="corpType1">법인</label>
							<input type="radio" name="corpType" id="corpType2" value="${Constant.CORP_TYPE_INDI }" /><label for="corpType2">개인</label>
							<input type="radio" name="corpType" id="corpType3" value="${Constant.CORP_TYPE_SIMP }" /><label for="corpType3">간이</label>
						</td>
					</tr>
					<tr>
						<th>사업자등록번호<span class="font02">*</span></th>
						<td>
							<form:input path="coRegNum" id="coRegNum" class="input_text10"  maxlength="20" />
							<form:errors path="coRegNum" cssClass="error_text" />
						</td>
						<th>업체구분<span class="font02">*</span></th>
						<td>
							<form:select path="corpModCd">
								<form:option value="">선택</form:option>
								<c:forEach var="code" items="${corpModCd}" varStatus="status">
									<form:option value="${code.cdNum}">${code.cdNm}</form:option>
								</c:forEach>
							</form:select>
							<form:hidden path="corpCd" />
							<form:select path="posUseYn" style="display:none">
								<option value="${Constant.FLAG_Y}">POS 사용</option>
								<option value="${Constant.FLAG_N}" selected>POS 미사용</option>
							</form:select>
							<form:errors path="corpCd" cssClass="error_text" />
						</td>
					</tr>
					<tr>
						<th>예약전화번호<span class="font02">*</span></th>
						<td>
							<form:input path="rsvTelNum" id="rsvTelNum" class="input_text10" onkeyup="addHyphenToPhone(this);" />
							<form:errors path="rsvTelNum" cssClass="error_text" />
						</td>
						<th>팩스번호</th>
						<td>
							<form:input path="faxNum" id="faxNum" class="input_text10" onkeyup="addHyphenToPhone(this);" />
							<form:errors path="faxNum" cssClass="error_text" />
						</td>
					</tr>
					<tr>						
						<th>홈페이지주소</th>
						<td>
							<form:input path="hmpgAddr" id="hmpgAddr" class="input_text20" maxlength="100" />
							<form:errors path="hmpgAddr" cssClass="error_text" />
						</td>
						<th>협회소속분과</th>
						<td>
							<form:input path="branchNm" id="branchNm" class="input_text20" maxlength="30" />
							<form:errors path="branchNm" cssClass="error_text" />
						</td>
					</tr>
					<tr>						
						<th>업태</th>
						<td>
							<form:input path="bsncon" id="bsncon" class="input_text20" maxlength="20" />
							<form:errors path="bsncon" cssClass="error_text" />
						</td>
						<th>업종</th>
						<td>
							<form:input path="bsntyp" id="bsntyp" class="input_text20" maxlength="20" />
							<form:errors path="bsntyp" cssClass="error_text" />
						</td>
					</tr>
					<tr>
						<th>업체이메일</th>
						<td>
							<form:input path="corpEmail" id="corpEmail" class="input_text20" maxlength="50" />
							<form:errors path="corpEmail" cssClass="error_text" />
						</td>
						<th>우수관광사업체</th>
						<td>
							<input type="hidden" id="superbCorpYn" name="superbCorpYn" />
							<input type="checkbox" id="superbCorpYn_chk" name="superbCorpYn_chk" />
						</td>
					</tr>
					<tr>
						<th>계좌정보</th>
						<td>
							<form:input path="bankNm" id="bankNm" class="input_text5" maxlength="10" placeholder="계좌은행" />							
							<form:input path="accNum" id="accNum" class="input_text10" maxlength="30" placeholder="계좌번호"  />
							<form:errors path="bankNm" cssClass="error_text" />
							<form:errors path="accNum" cssClass="error_text" />
						</td>
						<th>예금주</th>
						<td>
							<form:input path="depositor" id="depositor" class="input_text20" maxlength="30" />
							<form:errors path="depositor" cssClass="error_text" />
						</td>						
					</tr>
					<tr>
						<th>B2C 수수료율</th>
						<td>
							<select id="cmssNum" name="cmssNum">
								<c:forEach var="cmss" items="${cmssList}" varStatus="status">
									<option value="${cmss.cmssNum}">${cmss.cmssNm}(${cmss.adjAplPct}%)</option>
								</c:forEach>
							</select>
						</td>
						<th>B2B 수수료율</th>
						<td>
							<select id="b2bCmssNum" name="b2bCmssNum">
								<c:forEach var="b2bCmss" items="${b2bCmssList}" varStatus="status">
									<option value="${b2bCmss.cmssNum}">${b2bCmss.cmssNm}(${b2bCmss.adjAplPct}%)</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th>렌터카 실시간 연계 여부</th>
						<td>
							<input type="hidden" id="corpLinkYn" name="corpLinkYn" />
							<input type="checkbox" id="corpLinkYn_chk" name="corpLinkYn_chk" />수량연동<label for="corpLinkYn_chk">수량연동</label>
							<input type="hidden" id="corpLinkIsrYn" name="corpLinkIsrYn" />
							<input type="checkbox" id="corpLinkIsrYn_chk" name="corpLinkIsrYn_chk"/> <label for="corpLinkIsrYn_chk">금액보험연동</label>
						</td>
						<th>LINK상품 사용 여부</th>
						<td colspan="3">
							<select name="linkPrdtUseYn" id="linkPrdtUseYn">
								<option value="${Constant.FLAG_N}">사용안함</option>
								<option value="${Constant.FLAG_Y}">사용</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>숙박 API 연동</th>
						<td colspan="3">
							<input type="radio" name="adApiLinkNm"  id="adApiN" value="" checked="checked" /><label for="adApiN">없음</label>
							<input type="radio" name="adApiLinkNm" id="adApiTLL" value="TLL" /><label for="adApiTLL">TL 린칸</label>
						</td>
					</tr>
					<tr>
						<th>업체주소</th>
						<td colspan="3">
							<div class="btn_sty07"><span><a href="javascript:openDaumPostcode()">주소검색</a></span></div>
							<form:input path="roadNmAddr" id="roadNmAddr" class="input_text15" readonly="readonly" />
							<form:input path="dtlAddr" id="dtlAddr" class="input_text15" maxlength="100" />
							<form:errors path="roadNmAddr" cssClass="error_text" />
							<form:errors path="dtlAddr" cssClass="error_text" />
						</td>
					</tr>
					<tr>
						<th>위도/경도</th>
						<td colspan="3">
							<div class="btn_sty07"><span><a href="javascript:fn_FindLocation()">좌표찾기</a></span></div>
							위도 : <form:input path="lat" id="lat" readonly="readonly" />
							경도 : <form:input path="lon" id="lon" readonly="readonly" />
							<form:errors path="lat" cssClass="error_text" />
							<form:errors path="lon" cssClass="error_text" />
						</td>
					</tr>
				</table>
				<!--// 업체 일반 정보 -->
				<!--대표자 정보-->
				<h4 class="title03 margin-top25">대표자 정보</h4>				
				<table border="1" class="table02">
					<colgroup>
                        <col width="15%" />
                        <col width="35%" />
                        <col width="15%" />
                        <col width="35%" />
                    </colgroup>
                    <tr>
                    	<th>대표자 성명</th>
                    	<td colspan="3">
                    		<form:input path="ceoNm" id="ceoNm" class="input_text10" maxlength="30" />
							<form:errors path="ceoNm" cssClass="error_text" />
                    	</td>
                    </tr>
					<tr>
						<th>전화번호</th>
						<td>
							<form:input path="ceoTelNum" id="ceoTelNum" class="input_text10" onkeyup="addHyphenToPhone(this);" />
							<form:errors path="ceoTelNum" cssClass="error_text" />
						</td>
						<th>생년월일</th>
						<td>
							<form:input path="ceoBth" id="ceoBth" class="input_text10" maxlength="30" /> ex) 19770417
							<form:errors path="ceoBth" cssClass="error_text" />
						</td>
					</tr>
				</table>
				<!--//대표자 정보-->
				<!-- 담당자 정보 -->
				<h4 class="title03 margin-top25">담당자 정보</h4>				
				<table border="1" class="table02">
					<colgroup>
                        <col width="15%" />
                        <col width="35%" />
                        <col width="15%" />
                        <col width="35%" />
                    </colgroup>
                    <tr>
						<th>담당자 성명</th>
						<td>
							<form:input path="admNm" id="admNm" class="input_text10" maxlength="30" />
							<form:errors path="admNm" cssClass="error_text" />
						</td>
						<th>이메일</th>
						<td>
							<form:input path="admEmail" id="admEmail" class="input_text20" maxlength="50" />
							<form:errors path="admEmail" cssClass="error_text" />
						</td>
					</tr>
					<tr>
						<th>휴대전화</th>
						<td>
							<form:input path="admMobile" id="admMobile" class="input_text10" onkeyup="addHyphenToPhone(this);" />
							<form:errors path="admMobile" cssClass="error_text" />
						</td>
						<th>일반전화</th>
						<td>
							<form:input path="admTelnum" id="admTelnum" class="input_text10" onkeyup="addHyphenToPhone(this);" />
							<form:errors path="admTelnum" cssClass="error_text" />
						</td>
					</tr>
					<tr>
						<th>부서</th>
						<td>
							<form:input path="admDep" id="admDep" class="input_text10" maxlength="30" />
							<form:errors path="admDep" cssClass="error_text" />
						</td>
						<th>직위</th>
						<td>
							<form:input path="admOfcpos" id="admOfcpos" class="input_text10" maxlength="30" />
							<form:errors path="admOfcpos" cssClass="error_text" />
						</td>
					</tr>
                </table>
                <!-- //담당자 정보 -->
				<!-- 관리자 설정 -->
				<h4 class="title03 margin-top25">관리자 설정</h4>				
				<table border="1" class="table02">
					<colgroup>
                        <col width="15%" />
                        <col width="35%" />
                        <col width="15%" />
                        <col width="35%" />
                    </colgroup>
					<tr>
						<th>관리자</th>
						<td colspan="3">
							<div class="btn_sty07"><span><a href="javascript:fn_FindUser()">담당자검색</a></span></div>
							<input type="text" name="managerId" id="managerId" readonly="readonly" />
							<input type="text" name="managerNm" id="managerNm" readonly="readonly" />
						</td>
					</tr>
				</table>
				<!-- VISIT제주 연계 -->
				<h4 class="title03 margin-top25">VISIT제주연계</h4>
				<table border="1" class="table02">
					<colgroup>
                        <col width="15%" />
                        <col width="35%" />
                        <col width="15%" />
                        <col width="35%" />
                    </colgroup>
					<tr>
						<th>연계</th>
						<td colspan="3">
							<input type="text" name="visitNm" id="visitNm"/>
		         			<input type="hidden" name="visitMappingId" id="visitMappingId"/>
		         			<input type="hidden" name="visitMappingNm" id="visitMappingNm"/>
						</td>
					</tr>
				</table>

				<h4 class="title03 margin-top25">입점 서류</h4>
				<table border="1" class="table02">
					<colgroup>
						<col width="15%" />
						<col width="35%" />
						<col width="15%" />
						<col width="35%" />
					</colgroup>
					<c:set var="acceptExt" value="${Constant.FILE_CHECK_EXT}" />
					<tr>
						<th scope="row">사업자등록증<span class="font02">*</span></th>
						<td>
							<input type="file" name="businessLicense" id="businessLicense" accept="${acceptExt}" class="full" onchange="checkFile(this, '${acceptExt}', 5)" />
						</td>
						<th scope="row">통장<span class="font02">*</span></th>
						<td>
							<input type="file" name="passbook" id="passbook" accept="${acceptExt}" class="full" onchange="checkFile(this, '${acceptExt}', 5)" />
						</td>
					</tr>
					<tr>
						<th scope="row">영업신고증 및 <br>각종 허가증<span class="font02">*</span></th>
						<td>
							<input type="file" name="businessCard" id="businessCard" accept="${acceptExt}" class="full" onchange="checkFile(this, '${acceptExt}', 5)" />
						</td>
						<th scope="row">통신판매업신고증</th>
						<td>
							<input type="file" name="salesCard" id="salesCard" accept="${acceptExt}" class="full" onchange="checkFile(this, '${acceptExt}', 5)" />
						</td>
					</tr>
					<tr>
						<th scope="row">계약서1</th>
						<td>
							<input type="file" name="contract1" id="contract1" accept="${acceptExt}" class="full" onchange="checkFile(this, '${acceptExt}', 5)" />
						</td>
						<th scope="row">계약서2</th>
						<td>
							<input type="file" name="contract2" id="contract2" accept="${acceptExt}" class="full" onchange="checkFile(this, '${acceptExt}', 5)" />
						</td>

					</tr>
				</table>
				<p class="text-right"><span class="font02">* 등록가능 파일: ${Constant.FILE_CHECK_SIZE}MB 이하의 ${fn:toUpperCase(fn:replace(acceptExt, ".", ""))} 파일</span></p>
				<!-- 업체 comment -->
				<h4 class="title03 margin-top25">업체 comment</h4>
				<table border="1" class="table02">
					<colgroup>
						<col width="15%" />
						<col width="85%" />
					</colgroup>
					<tr>
						<th>내용</th>
						<td colspan="3">
							<textarea name="corpComment" id="corpComment" rows="10"  style="width:97%" placeholder="ex) 김00 / 2022-06-10 / 6월19일에 요금 등록 해준다고 함"></textarea>
						</td>
					</tr>
				</table>
				<ul class="btn_rt01">
					<li class="btn_sty04"><a href="javascript:fn_InsCorp()">저장</a></li>
					<li class="btn_sty01"><a href="javascript:history.back()">목록</a></li>
				</ul>			
			</form:form>
			<!--//업체등록-->
			</div> 
			<!--//본문--> 
		</div>
	</div>
	<!--//Contents 영역--> 
</div>
</body>
</html>