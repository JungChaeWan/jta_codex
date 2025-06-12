<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 			uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />
 
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>

<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=71cf66fb54158dacb5fb5b656674ad70&libraries=services"></script>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title>탐나오</title>
<style>
.ui-autocomplete {
	max-height: 100px;
	overflow-y: auto; /* prevent horizontal scrollbar */
	overflow-x: hidden;
	position: absolute;
	cursor: default;
	z-index: 4000 !important
}
</style>
<script type="text/javascript">
function fn_ListCorpPnsReq() {
	document.frm.action= "<c:url value='/oss/corpPnsReqList.do'/>";
	document.frm.submit();
}

function fn_viewCorpPnsReq() {
	show_popup($("#div_corpPnsReq"));
}

function fn_saveCorpPnsReq() {
	document.CORP_PNSREQVO.action="<c:url value='/oss/apprCorpPnsReq.do'/>";
	document.CORP_PNSREQVO.submit();
}

function fn_viewCorpAccount() {
	show_popup($("#div_corpAccount"));
}

function fn_saveCorpAccount() {
	if(isNull($("#corpModCd").val())) {
		alert("업체분류를 선택해 주세요.");
		return ;
	} else if(isNull($("#lat").val())) {
		alert("좌표찾기 버튼을 클릭해 주세요.");
		$("#lot").focus();
		return ;
	} else if(isNull($("#lon").val())) {
		alert("좌표찾기 버튼을 클릭해 주세요.");
		$("#lon").focus();
		return ;
	} else if(!isNull($("#visitNm").val()) && isNull($("#visitMappingId").val())) {
		alert("VISIT제주 연계 값을 확인해 주세요.");
		$("#visitNm").focus();
		return ;
	}
	if($("#superbCorpYn_chk").is(":checked")){
		$("#superbCorpYn").val("Y");
	}else{
		$("#superbCorpYn").val("N");
	}
	document.CORPVO.action="<c:url value='/oss/saveCorpAccount.do'/>";
	document.CORPVO.submit();
}

/**
 * DAUM 연동 주소찾기
 */
function openDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            document.getElementById('roadNmAddr').value = data.address;
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
	
	var callback = function(result, status){
	    if(status == daum.maps.services.Status.OK) {
	    	var lat = result[0].y
	    	var lng = result[0].x

	    	$("#lon").val(lng);
			$("#lat").val(lat);
	    } else {
	    	if(status == daum.maps.services.Status.ZERO_RESULT) {
	    		alert("해당 주소에 대한 결과값이 없습니다.");
				return;
	    	} else if (status == daum.maps.services.Status.RESULT_NOT_FOUND) {
	    		alert("해당 주소에 대한 결과값이 없습니다.");
				return;
	    	} else {
	    		alert("API 응답불가, 관리자에게 문의하세요.");
				return;
	    	}
	    }
	};
	geocoder.addressSearch(addr, callback);
}

function fn_viewUpdateCorpOnsReq() {
	document.frm.action = "<c:url value='/oss/viewUpdateCorpPnsRequest.do'/>";
	document.frm.submit();
}

$(document).ready(function(){
	$("#corpModCd").change(function() {		
		$("#corpCd").val($(this).val().substring(1, 3));
	});
	
	$("#visitNm").bind("keydown", function(event) {
		if(event.keyCode == $.ui.keyCode.TAB && $(this).data("ui-autocomplete").menu.active) {
			event.preventDefault();
		}      
	}).autocomplete({
		minLength: 1,
		source: function(request, response) {
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
				
					if (visitJEJU.length == 0) {
						visitJEJU[0] = {label:'데이터가 없습니다.', value:'0000'};
					}
					
					response( visitJEJU );
				}
			});
		},        
		focus: function() {
			return false;        
		},        
		select: function(event, ui) {
			if (ui.item.value != "0000") {
				this.value = ui.item.label.substring(0, ui.item.label.indexOf("[", 0)).trim();
				$("#visitMappingId").val(ui.item.value);
				$("#visitMappingNm").val(this.value);
			}
			return false;
		}      
	}).blur(function(){			
		var strVal = this.value;
		if(strVal.substr(strVal.length-1, strVal.length) == ","){
			strVal = strVal.substr(0, strVal.length-1);
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
		<jsp:include page="/oss/left.do?menu=corp&sub=corpapp" flush="false"></jsp:include>
		<div id="contents_area"> 
			<!--본문-->
			<div id="contents">
				<form name="frm" method="post">
					<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}"/>
					<input type="hidden" name="sCorpCd" id="sCorpCd" value="${searchVO.sCorpCd}"/>
					<input type="hidden" name="sStatusCd" id="sStatusCd" value="${searchVO.sStatusCd}"/>
					<input type="hidden" name="sStartDt" id="sStartDt" value="${searchVO.sStartDt}"/>
					<input type="hidden" name="sEndDt" id="sEndDt" value="${searchVO.sEndDt}"/>
					<input type="hidden" name="sCorpNm" id="sCorpNm" value="${searchVO.sCorpNm}"/>
					<input type="hidden" name="requestNum" id="requestNum" value="${result.requestNum}">
					<!-- 신청 처리 현황 -->
					<h4 class="title03">신청 처리 현황</h4>
					<table border="1" class="table02">
						<colgroup>
							<col width="15%" />
							<col width="35%" />
							<col width="15%" />
							<col width="35%" />
						</colgroup>
						<tr>
							<th scope="row"> 접수번호</th>
							<td><c:out value="${result.requestNum}" /></td>
							<th scope="row">처리상태</th>
							<td>
								<c:choose>
									<c:when test="${result.statusCd eq Constant.CORP_STATUS_CD_01}"> 신청중</c:when>
									<c:when test="${result.statusCd eq Constant.CORP_STATUS_CD_02}"> 승인검토중</c:when>
									<c:when test="${result.statusCd eq Constant.CORP_STATUS_CD_03}"> 승인완료</c:when>
									<c:when test="${result.statusCd eq Constant.CORP_STATUS_CD_04}"> 입점불가</c:when>
									<c:when test="${result.statusCd eq Constant.CORP_STATUS_CD_05}"> 입점취소</c:when>
								</c:choose>
								<c:choose>
									<c:when test="${empty result.confCorpId}">
										<div class="btn_sty06"><span><a href="javascript:fn_viewCorpPnsReq()">승인관리</a></span></div>
										<c:if test="${result.statusCd eq Constant.CORP_STATUS_CD_03}">
											<div class="btn_sty06"><span><a href="javascript:fn_viewCorpAccount()">계정발급</a></span></div>
										</c:if>
									</c:when>
									<c:otherwise>
										/ 발행완료 (<c:out value="${result.confCorpId}" />)
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<th scope="row">접수이력</th>
							<td>${result.frstRegDttm}</td>
							<th scope="row">처리이력</th>
							<td>${result.lastModDttm}</td>
						</tr>
						<tr>
							<th scope="row">관리자 메모</th>
							<td colspan="3"><c:out value="${result.admMemo}" /></td>
						</tr>
					</table>
					<!--// 신청 처리 현황 -->
					<!-- 업체 기본 정보 -->
					<h4 class="title03 margin-top25">업체 기본정보</h4>
					<table border="1" class="table02">
						<colgroup>
							<col width="15%" />
							<col width="35%" />
							<col width="15%" />
							<col width="35%" />
						</colgroup>
						<tr>
							<th scope="row">업체명</th>
							<td colspan="3"><c:out value="${result.corpNm}" /></td>
						</tr>
						<tr>
							<th scope="row">사업자등록번호</th>
							<td><c:out value="${result.coRegNum}" /></td>
							<th scope="row">회사유형</th>
							<td>
								<c:choose>
									<c:when test="${result.corpType eq Constant.CORP_TYPE_CORP}">법인</c:when>
									<c:when test="${result.corpType eq Constant.CORP_TYPE_INDI}">개인</c:when>
									<c:when test="${result.corpType eq Constant.CORP_TYPE_SIMP}">간이</c:when>
								</c:choose>
							</td>
						</tr>
						<tr>
							<th scope="row">전화번호</th>
							<td><c:out value="${result.rsvTelNum}" /></td>
							<th scope="row">팩스번호</th>
							<td><c:out value="${result.faxNum}" /></td>
						</tr>
						<tr>
							<th scope="row">업체홈페이지</th>
							<td>
								<a href="<c:out value='${result.hmpgAddr}' />" target="_blank"><c:out value='${result.hmpgAddr}' /></a>
							</td>
							<th scope="row">협회소속분과</th>
							<td><c:out value="${result.branchNm}" /></td>
						</tr>
						<tr>
							<th scope="row">업체주소</th>
							<td colspan="3"><c:out value="${result.addr}" /> <c:out value="${result.dtlAddr}" /></td>
						</tr>
						<tr>
							<th scope="row">대표자 성명</th>
							<td><c:out value="${result.ceoNm}" /></td>
							<th scope="row">탐나는전</th>
							<td>
								<c:choose>
									<c:when test="${result.tamnacardMngYn eq 'C'}">가맹점</c:when>
									<c:when test="${result.tamnacardMngYn eq 'N'}">비가맹점</c:when>
								</c:choose>
							</td>
						</tr>
						<tr>
							<th scope="row">업태</th>
							<td><c:out value="${result.bsncon}" /></td>
							<th scope="row">업종</th>
							<td><c:out value="${result.bsntyp}" /></td>
						</tr>
						<tr>
							<th scope="row">판매예정상품</th>
							<td colspan="3"><c:out value="${result.salePrdtList}" /></td>
						</tr>
						<tr>
							<th scope="row">예금주명</th>
							<td><c:out value="${result.depositor}" /></td>
							<th scope="row">계좌은행</th>
							<td><c:out value="${result.bankNm}" /></td>
						</tr>
						<tr>
							<th scope="row">계좌번호</th>
							<td colspan="3"><c:out value="${result.accNum}" /></td>
						</tr>
					</table>
					<!--// 업체 기본 정보 -->

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
							<th scope="row">담당자 성명</th>
							<td><c:out value="${result.admNm}" /></td>
							<th scope="row">담당자 email</th>
							<td><c:out value="${result.admEmail}" /></td>
						</tr>
						<tr>
							<th scope="row">담당자 휴대전화</th>
							<td><c:out value="${result.admMobile}" /></td>
							<th scope="row">직통전화</th>
							<td><c:out value="${result.admTelnum}" /></td>
						</tr>
						<tr>
							<th scope="row">소속부서</th>
							<td><c:out value="${result.admDep}" /></td>
							<th scope="row">직위</th>
							<td><c:out value="${result.admOfcpos}" /></td>
						</tr>
					</table>
					<!--// 담당자 정보 -->

					<h4 class="title03 margin-top25">입점 서류</h4>
					<table border="1" class="table02">
						<colgroup>
							<col width="15%" />
							<col width="35%" />
							<col width="15%" />
							<col width="35%" />
						</colgroup>
						<tr>
							<th scope="row">사업자등록증</th>
							<td>
								<c:if test="${!empty cprfMap['1']}">
									${cprfMap['1'].realFileNm}
									<button type="button" class="btn sm" onclick="window.open('${cprfMap['1'].savePath}${cprfMap['1'].saveFileNm}')">보기</button>
								</c:if>
							</td>
							<th scope="row">통장</th>
							<td>
								<c:if test="${!empty cprfMap['2']}">
									${cprfMap['2'].realFileNm}
									<button type="button" class="btn sm" onclick="window.open('${cprfMap['2'].savePath}${cprfMap['2'].saveFileNm}')">보기</button>
								</c:if>
							</td>
						</tr>
						<tr>
							<th scope="row">영업신고증 및 <br>각종 허가증</th>
							<td>
								<c:if test="${!empty cprfMap['3']}">
									${cprfMap['3'].realFileNm}
									<button type="button" class="btn sm" onclick="window.open('${cprfMap['3'].savePath}${cprfMap['3'].saveFileNm}')">보기</button>
								</c:if>
							</td>
							<th scope="row">통신판매업신고증</th>
							<td>
								<c:if test="${!empty cprfMap['4']}">
									${cprfMap['4'].realFileNm}
									<button type="button" class="btn sm" onclick="window.open('${cprfMap['4'].savePath}${cprfMap['4'].saveFileNm}')">보기</button>
								</c:if>
							</td>
						</tr>
						<tr>
							<th scope="row">계약서</th>
							<td colspan="3">
								<c:if test="${!empty cprfMap['5']}">
									${cprfMap['5'].realFileNm}
									<button type="button" class="btn sm" onclick="window.open('${cprfMap['5'].savePath}${cprfMap['5'].saveFileNm}')">보기</button>
								</c:if>
							</td>
						</tr>
					</table>

					<ul class="btn_rt01">
						<c:if test="${result.statusCd eq Constant.CORP_STATUS_CD_01}">
							<li class="btn_sty03"><a href="javascript:fn_viewUpdateCorpOnsReq()">수정</a></li>
						</c:if>
						<li class="btn_sty01"><a href="javascript:fn_ListCorpPnsReq()">목록</a></li>
					</ul>
				</form>
			</div>
		</div>
	</div>
</div>

<div class="blackBg"></div>

<div id="div_corpPnsReq" class="lay_popup lay_ct"  style="display:none;">
	<span class="popup_close"><a href="javascript:void(0);" onclick="close_popup($('#div_corpPnsReq'));" title="창닫기"><img src="/images/oss/btn/close_btn03.gif" alt="닫기" /></a></span>
	<form:form commandName="CORP_PNSREQVO" name="CORP_PNSREQVO" method="post">
		<input type="hidden" name="requestNum" value="${result.requestNum}" />

		<ul class="form_area">
			<li>
				<table border="1" cellpadding="0" cellspacing="0" class="table02">
				   	<caption class="tb02_title">승인 관리</caption>
					<colgroup>
						<col width="33%" />
						<col width="65%" />
					</colgroup>
					<tr>
						<th>업체명</th>
						<td><c:out value="${result.corpNm}"/></td>
					</tr>
					<tr>
						<th>상태</th>
						<td>
							<form:select path="statusCd">
								<option value="${Constant.CORP_STATUS_CD_02}" <c:if test="${Constant.CORP_STATUS_CD_02 eq result.statusCd}">selected="true"</c:if>>승인검토중</option>
								<option value="${Constant.CORP_STATUS_CD_03}" <c:if test="${Constant.CORP_STATUS_CD_03 eq result.statusCd}">selected="true"</c:if>>승인완료</option>
								<option value="${Constant.CORP_STATUS_CD_04}" <c:if test="${Constant.CORP_STATUS_CD_04 eq result.statusCd}">selected="true"</c:if>>입점불가</option>
								<option value="${Constant.CORP_STATUS_CD_05}" <c:if test="${Constant.CORP_STATUS_CD_05 eq result.statusCd}">selected="true"</c:if>>입점취소</option>
							</form:select>
						</td>
					</tr>
					<tr>
						<th>관리자 메모</th>
						<td><textarea name="admMemo" id="admMemo" rows="10" style="width:97%">${result.admMemo}</textarea></td>
					</tr>
				</table>
			</li>
		</ul>
	</form:form>
	<div class="btn_ct01"><span class="btn_sty03"><a href="javascript:fn_saveCorpPnsReq();">적용</a></span></div>
</div>

<div id="div_corpAccount" class="lay_popup lay_ct" style="display:none;">
	<span class="popup_close"><a href="javascript:void(0);" onclick="close_popup($('#div_corpAccount'));" title="창닫기"><img src="/images/oss/btn/close_btn03.gif" alt="닫기" /></a></span>
	<form:form commandName="CORPVO" name="CORPVO" method="post">
		<input type="hidden" name="requestNum" value="${result.requestNum}"/>

		<ul class="form_area">
			<li>
				<table border="1" cellpadding="0" cellspacing="0" class="table02">
				   <caption class="tb02_title">승인 관리</caption>
					<colgroup>
						 <col width="33%" />
						 <col width="65%" />
				 	</colgroup>
					<tr>
						<th>업체명</th>
						<td><c:out value="${result.corpNm}"/></td>
					</tr>
					<tr>
						<th>업체 분류</th>
						<td>
							<form:select path="corpModCd">
								<option value="">선 택</option>
								<c:forEach items="${corpModCd}" var="corpCd">
									<option value="${corpCd.cdNum}" ><c:out value="${corpCd.cdNm}" /></option>
								</c:forEach>
							</form:select>
							<form:hidden path="corpCd" />
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
					</tr>
					<tr>
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
						<th>VISIT제주연계</th>
						<td>
							<input type="text" name="visitNm" id="visitNm"/>
							<input type="hidden" name="visitMappingId" id="visitMappingId" />
							<input type="hidden" name="visitMappingNm" id="visitMappingNm" />
						</td>
					</tr>
					<tr>
						<th>주소</th>
						<td>
							<div class="btn_sty07"><span><a href="javascript:openDaumPostcode();">주소검색</a></span></div><br />
							<input type="text" name="roadNmAddr" id="roadNmAddr" class="input_text_full" readonly="readonly" value="${result.addr}"/>
							<input type="text" name="dtlAddr" id="dtlAddr" class="input_text_full" value="${result.dtlAddr}"/>
						</td>
					</tr>
					<tr>
						<th>위도/경도</th>
						<td>
							<div class="btn_sty07"><span><a href="javascript:fn_FindLocation()">좌표찾기</a></span></div><br />
							위도 : <form:input path="lat" id="lat" readonly="readonly" class="input_text20"/><br />
							경도 : <form:input path="lon" id="lon" readonly="readonly" class="input_text20"/>
						</td>
					</tr>
					<tr>
						<th>우수관광사업체</th>
						<td>
							<input type="hidden" name="superbCorpYn" id="superbCorpYn" />
							<input type="checkbox" name="superbCorpYn_chk" id="superbCorpYn_chk" />
						</td>
					</tr>
				</table>
			</li>
		</ul>
	</form:form>
	<div class="btn_ct01"><span class="btn_sty03"><a href="javascript:fn_saveCorpAccount();">발급</a></span></div>
</div>
</body>
</html>