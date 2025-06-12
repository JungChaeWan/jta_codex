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
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=71cf66fb54158dacb5fb5b656674ad70&libraries=services"></script>

<validator:javascript formName="MASCORPVO" staticJavascript="false" xhtml="true" cdata="true"/>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />

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
 * 수정 폼 validator 체크
 */
function fn_UdtCorp(){
	// validation 체크
	if(!validateMASCORPVO(document.MASCORPVO)){
		return;
	}
	document.MASCORPVO.action = "<c:url value='/mas/updateCorp.do' />";
	document.MASCORPVO.submit();
}

/**
 * 취소(이전 페이지로 이동)
 */
function fn_detailCorp(){
	history.back();
}

</script>
</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/mas/head.do?menu=corp" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">		
		<div id="contents_area"> 
			<!--본문-->
			<!--상품 등록-->
			<form:form commandName="MASCORPVO" name="MASCORPVO" method="post" enctype="multipart/form-data">
				<div id="contents">
					<!--업체 정보-->
					<h4 class="title03">업체 정보<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span></h4>
					<table border="1" class="table02">
						<colgroup>
							<col width="15%" />
							<col width="35%" />
							<col width="15%" />
							<col width="35%" />
						</colgroup>
						<tr>
							<th>업체아이디</th>
							<td>
								<c:out value="${corpInfo.corpId}" />
							</td>
							<th>거래상태</th>
							<td>
								<c:choose>
									<c:when test="${corpInfo.tradeStatusCd eq Constant.TRADE_STATUS_REG}"> 등록중</c:when>
									<c:when test="${corpInfo.tradeStatusCd eq Constant.TRADE_STATUS_APPR_REQ}"> 승인요청</c:when>
									<c:when test="${corpInfo.tradeStatusCd eq Constant.TRADE_STATUS_APPR}"> 승인</c:when>
									<c:when test="${corpInfo.tradeStatusCd eq Constant.TRADE_STATUS_APPR_REJECT}"> 승인거절</c:when>
									<c:when test="${corpInfo.tradeStatusCd eq Constant.TRADE_STATUS_STOP}"> 판매중지</c:when>
								</c:choose>
							</td>
						</tr>
						<tr>
							<th>업체명</th>
							<td>
								<c:out value="${corpInfo.corpNm}" />
								<form:hidden path="corpCd" value="${corpInfo.corpCd}" />
								<form:hidden path="corpNm" value="${corpInfo.corpNm}" />
							</td>
							<th>협회소속분과</th>
							<td>
								<input type="hidden" name="branchNm" id="branchNm" value="${corpInfo.branchNm}" />
								<c:out value="${corpInfo.branchNm}" />
							</td>
						</tr>
						<tr>
							<th>사업자등록번호</th>
							<td>
								<c:out value="${corpInfo.coRegNum}" />
								<form:hidden path="coRegNum" value="${corpInfo.coRegNum}" />
							</td>
							<th>회사유형<span class="font02">*</span></th>
							<td colspan="3">
								<c:if test="${corpInfo.corpType eq Constant.CORP_TYPE_CORP}">법인</c:if>
								<c:if test="${corpInfo.corpType eq Constant.CORP_TYPE_INDI}">개인</c:if>
								<c:if test="${corpInfo.corpType eq Constant.CORP_TYPE_SIMP}">간이</c:if>
								<form:hidden path="corpType" id="corpType" value="${corpInfo.corpType}" />
								<input type="hidden"name="shopNm" id="shopNm" class="input_text30" value="${corpInfo.shopNm}" maxlength="30" />
							</td>
						</tr>
						<tr>
							<th>업태</th>
							<td>
								<input type="hidden" name="bsncon" id="bsncon" value="${corpInfo.bsncon}" />
								<c:out value="${corpInfo.bsncon}" />
							</td>
							<th>업종</th>
							<td>
								<input type="hidden" name="bsntyp" id="bsntyp" value="${corpInfo.bsntyp}" />
								<c:out value="${corpInfo.bsntyp}" />
							</td>
						</tr>
						<tr>
							<th>예약전화번호<span class="font02">*</span></th>
							<td>
								<form:input path="rsvTelNum" id="rsvTelNum" class="input_text10" onkeyup="addHyphenToPhone(this);" value="${corpInfo.rsvTelNum}" maxlength="20" />
								<form:errors path="rsvTelNum" cssClass="error_text" />
							</td>
							<th>팩스번호</th>
							<td>
								<form:input path="faxNum" id="faxNum" class="input_text10" onkeyup="addHyphenToPhone(this);" value="${corpInfo.faxNum}" maxlength="20" />
								<form:errors path="faxNum" cssClass="error_text" />
							</td>
						</tr>
						<tr>
							<th>회사홈페이지</th>
							<td colspan="3">
								<form:input path="hmpgAddr" id="hmpgAddr" class="input_text30" value="${corpInfo.hmpgAddr}" maxlength="100" />
								<span class="font02">'http://','https://'등을 꼭 붙여주세요.</span>
								<form:errors path="hmpgAddr" cssClass="error_text" />
							</td>
						</tr>

						<tr>
							<th>업체주소</th>
							<td colspan="3">
								<div class="btn_sty07"><span><a href="javascript:openDaumPostcode()">주소검색</a></span></div>
								<form:input path="roadNmAddr" id="roadNmAddr" class="input_text30" readonly="readonly" value="${corpInfo.roadNmAddr}" />
								<form:input path="dtlAddr" id="dtlAddr" class="input_text15" value="${corpInfo.dtlAddr}" maxlength="100" />
								<form:errors path="roadNmAddr" cssClass="error_text" />
								<form:errors path="dtlAddr" cssClass="error_text" />
							</td>
						</tr>
						<tr>
							<th>위도/경도</th>
							<td colspan="3">
								<div class="btn_sty07"><span><a href="javascript:fn_FindLocation()">좌표찾기</a></span></div>
								위도 : <form:input path="lat" id="lat" value="${corpInfo.lat}" readonly="readonly" />
								경도 : <form:input path="lon" id="lon" value="${corpInfo.lon}" readonly="readonly" />
								<form:errors path="lat" cssClass="error_text" />
								<form:errors path="lon" cssClass="error_text" />
							</td>
						</tr>
						<tr>
							<th>계좌은행</th>
							<td>
								<input type="hidden" name="bankNm" id="bankNm" value="${corpInfo.bankNm}" />
								<c:out value="${corpInfo.bankNm}" />
							</td>
							<th>계좌번호</th>
							<td>
								<input type="hidden" name="accNum" id="accNum" value="${corpInfo.accNum}" />
								<c:out value="${corpInfo.accNum}" />
							</td>
						</tr>
						<tr>
							<th>예금주명</th>
							<td colspan="3">
								<input type="hidden" name="depositor" id="depositor" value="${corpInfo.depositor}" />
								<c:out value="${corpInfo.depositor}" />
							</td>
						</tr>
						<tr>
							<th>B2C 수수료율</th>
							<td <c:if test="${corpInfo.b2bUseYn eq 'N'}">colspan="3"</c:if>>
								<c:forEach items="${cmssList}" var="cmss" varStatus="status">
									<c:if test="${cmss.cmssNum eq corpInfo.cmssNum}">${cmss.cmssNm}(${cmss.adjAplPct}%)</c:if>
								</c:forEach>
							</td>
							<c:if test="${corpInfo.b2bUseYn eq 'Y'}">
								<th>B2B 수수료율</th>
								<td>
									<c:forEach items="${b2bCmssList}" var="b2bCmss" varStatus="status">
										<c:if test="${b2bCmss.cmssNum eq corpInfo.b2bCmssNum}">${b2bCmss.cmssNm}(${b2bCmss.adjAplPct}%)</c:if>
									</c:forEach>
								</td>
							</c:if>
						</tr>
					</table>
					<!--//업체정보-->
					<!-- 대표자 정보 -->
					<h4 class="title03 margin-top25">대표자 정보</h4>
					<table border="1" class="table02">
						<colgroup>
							<col width="15%" />
							<col width="35%" />
							<col width="15%" />
							<col width="35%" />
						</colgroup>
						<tr>
							<th>대표자명</th>
							<td colspan="3">
								<form:hidden path="ceoNm" id="ceoNm" value="${corpInfo.ceoNm}" />
								<c:out value="${corpInfo.ceoNm}" />
							</td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td>
								<form:input path="ceoTelNum" id="ceoTelNum" class="input_text20" value="${corpInfo.ceoTelNum}" maxlength="20" />
								<form:errors path="ceoTelNum" cssClass="error_text" />
							</td>
							<th>이메일</th>
							<td>
								<form:input path="corpEmail" id="corpEmail" class="input_text20" value="${corpInfo.corpEmail}" maxlength="50" />
								<form:errors path="corpEmail" cssClass="error_text" />
							</td>
						</tr>
					</table>
					<!-- //대표자 정보 -->
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
							<th>담당자명</th>
							<td>
								<form:input path="admNm" id="admNm"  class="input_text20" value="${corpInfo.admNm}" maxlength="20" />
								<form:errors path="admNm" cssClass="error_text" />
							</td>
							<th>일반전화</th>
							<td>
								<form:input path="admTelnum" id="admTelnum" class="input_text20" value="${corpInfo.admTelnum}" maxlength="13" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');addHyphenToPhone(this);"/>
								<form:errors path="admTelnum" cssClass="error_text" />
							</td>
						</tr>
						<tr>
							<th>부서</th>
							<td>
								<form:input path="admDep" id="admDep" class="input_text20" value="${corpInfo.admDep}" maxlength="30" />
								<form:errors path="admDep" cssClass="error_text" />
							</td>
							<th>직위</th>
							<td>
								<form:input path="admOfcpos" id="admOfcpos" class="input_text20" value="${corpInfo.admOfcpos}" maxlength="30" />
								<form:errors path="admOfcpos" cssClass="error_text" />
							</td>
						</tr>						
						<tr>
							<th>담당자 휴대전화</th>
							<td>
								<form:input path="admMobile" id="admMobile" class="input_text20" value="${corpInfo.admMobile}" maxlength="13" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');addHyphenToPhone(this);"/>
								<form:errors path="admMobile" cssClass="error_text" />
							</td>
							<th>담당자 이메일</th>
							<td>
								<form:input path="admEmail" id="admEmail"  class="input_text20" value="${corpInfo.admEmail}" maxlength="50" />
								<form:errors path="admEmail" cssClass="error_text" />
							</td>
						</tr>
						<tr>
							<th>담당자 휴대전화2</th>
							<td>
								<form:input path="admMobile2" id="admMobile2" class="input_text20" value="${corpInfo.admMobile2}" maxlength="13" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');addHyphenToPhone(this);" />
								<form:errors path="admMobile2" cssClass="error_text" />
							</td>
							<th>담당자 이메일2</th>
							<td>
								<form:input path="admEmail2" id="admEmail2"  class="input_text20" value="${corpInfo.admEmail2}" maxlength="50" />
								<form:errors path="admEmail2" cssClass="error_text" />
							</td>
						</tr>
						<tr>
							<th>담당자 휴대전화3</th>
							<td colspan="3">
								<form:input path="admMobile3" id="admMobile3" class="input_text20" value="${corpInfo.admMobile3}" maxlength="13" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');addHyphenToPhone(this);" />
								<form:errors path="admMobile3" cssClass="error_text" />
							</td>
						</tr>						
					</table>
					<!-- //담당자 정보 -->
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
								<div id="divFile1" <c:if test="${empty cprfMap['1']}">style="display:none;"</c:if>>
									${cprfMap['1'].realFileNm}
								</div>
								<div id="divInputFile1" <c:if test="${!empty cprfMap['1']}">style="display:none;"</c:if>>
									<input type="file" name="businessLicense" id="businessLicense" accept="${acceptExt}" class="full" onchange="checkFile(this, '${acceptExt}', 5)" />
								</div>
							</td>
							<th scope="row">통장<span class="font02">*</span></th>
							<td>
								<div id="divFile2" <c:if test="${empty cprfMap['2']}">style="display:none;"</c:if>>
									${cprfMap['2'].realFileNm}
								</div>
								<div id="divInputFile2" <c:if test="${!empty cprfMap['2']}">style="display:none;"</c:if>>
									<input type="file" name="passbook" id="passbook" accept="${acceptExt}" class="full" onchange="checkFile(this, '${acceptExt}', 5)" />
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">영업신고증 및 <br>각종 허가증<span class="font02">*</span></th>
							<td>
								<div id="divFile3" <c:if test="${empty cprfMap['3']}">style="display:none;"</c:if>>
									${cprfMap['3'].realFileNm}
								</div>
								<div id="divInputFile3" <c:if test="${!empty cprfMap['3']}">style="display:none;"</c:if>>
									<input type="file" name="businessCard" id="businessCard" accept="${acceptExt}" class="full" onchange="checkFile(this, '${acceptExt}', 5)" />
								</div>
							</td>
							<th scope="row">통신판매업신고증</th>
							<td>
								<div id="divFile4" <c:if test="${empty cprfMap['4']}">style="display:none;"</c:if>>
									${cprfMap['4'].realFileNm}
								</div>
								<div id="divInputFile4" <c:if test="${!empty cprfMap['4']}">style="display:none;"</c:if>>
									<input type="file" name="salesCard" id="salesCard" accept="${acceptExt}" class="full" onchange="checkFile(this, '${acceptExt}', 5)" />
								</div>
							</td>
						</tr>
					</table>
					<p class="text-right"><span class="font02">* 등록가능 파일: ${Constant.FILE_CHECK_SIZE}MB 이하의 ${fn:toUpperCase(fn:replace(acceptExt, ".", ""))} 파일</span></p>

					<ul class="btn_rt01">
						<li class="btn_sty04"><a href="javascript:fn_UdtCorp()">저장</a></li>
						<li class="btn_sty01"><a href="javascript:fn_detailCorp()">취소</a></li>
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