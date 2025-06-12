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
<% pageContext.setAttribute("replaceChar", "\n"); %>
<un:useConstants var="Constant" className="common.Constant" />
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />

<title></title>

<script type="text/javascript">
function fn_ListCorp() {
	document.frm.action = "<c:url value='/oss/corpList.do'/>";
	document.frm.submit();
}

function fn_UdtCorp(){
	document.frm.action = "<c:url value='/oss/viewUpdateCorp.do'/>";
	document.frm.submit();
}

function fn_NonVisitMapping(){
	if(confirm("Visit 제주 연계를 해제하시겠습니까?")) {
		var parameters = "corpId=" + $("#corpId").val();
		
		$.ajax({
			type:"post", 
			dataType:"json",
			// async:false,
			url:"<c:url value='/oss/visitjejuNonMapping.ajax'/>",
			data:parameters,
			success:function(data){
				alert("Visit 제주 연계가 해제됐습니다.");
				document.frm.action = "<c:url value='/oss/detailCorp.do'/>";
				document.frm.submit();
			}
		});
	}
}

function fn_LoginMas(corpId){
	var parameters = "corpId=" + corpId;
	
	$.ajax({
		type:"post", 
		dataType:"json",
		// async:false,
		url:"<c:url value='/oss/masLogin.ajax'/>",
		data:parameters,
		success:function(data){
			if(data.success == "Y") {
				window.open("<c:url value='/mas/home.do'/>", '_blank');
			} else {
				alert("업체 로그인에 실패했습니다.");
			}
		}
	});
}

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
			<!--업체정보상세-->
			<div id="contents">
				<form name="frm" method="post">
					<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}"/>
					<input type="hidden" name="sCorpCd" id="sCorpCd" value="${searchVO.sCorpCd}"/>
					<input type="hidden" name="sTradeStatusCd" id="sTradeStatusCd" value="${searchVO.sTradeStatusCd}"/>
					<input type="hidden" name="sCorpNm" id="sCorpNm" value="${searchVO.sCorpNm}"/>
					<input type="hidden" name="sCorpId" id="sCorpId" value="${searchVO.sCorpId}"/>
					<input type="hidden" name="sAsctMemYn" id="sAsctMemYn" value="${searchVO.sAsctMemYn}"/>
					<input type="hidden" name="sSuperbCorpYn" id="sSuperbCorpYn" value="${searchVO.sSuperbCorpYn}"/>
					<input type="hidden" name="sCorpLinkYn" id="sCorpLinkYn" value="${searchVO.sCorpLinkYn}"/>
					<input type="hidden" name="corpId" id="corpId" value='<c:out value="${corpInfo.corpId}" />' />
				</form>
				<!--계약현황-->
				<h4 class="title03">업체 거래현황</h4>				
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
							<c:if test="${corpInfo.corpLinkYn == 'Y'}"> <b>[실시간 연계]</b></c:if>
						</td>
						<th>계약상태</th>
						<td>
							<c:forEach var="code" items="${tradeStateCd}" varStatus="status">
								<c:if test="${corpInfo.tradeStatusCd eq code.cdNum}">${code.cdNm}</c:if>
							</c:forEach>
						</td>
					</tr>
					<tr>
						<th>B2C 수수료율</th>
						<td>
							<c:forEach items="${cmssList}" var="cmss" varStatus="status">
								<c:if test="${cmss.cmssNum eq corpInfo.cmssNum}">${cmss.cmssNm}(${cmss.adjAplPct}%)</c:if>
							</c:forEach>
						</td>
						<th>B2B 수수료율</th>
						<td>
							<c:forEach items="${b2bCmssList}" var="b2bCmss" varStatus="status">
								<c:if test="${b2bCmss.cmssNum eq corpInfo.b2bCmssNum}">${b2bCmss.cmssNm}(${b2bCmss.adjAplPct}%)</c:if>
							</c:forEach>
						</td>
					</tr>
					<tr>
						<th>등록일</th>
						<td><c:out value="${corpInfo.frstRegDttm}" /></td>
						<th>수정일</th>
						<td><c:out value="${corpInfo.lastModDttm}" /></td>
					</tr>
				</table>
				<!--//계약현황-->				
					
				<!--업체 기본 정보-->
				<h4 class="title03 margin-top25">업체 기본정보</h4>				
				<table border="1" class="table02">
					<colgroup>
                        <col width="15%" />
                        <col width="35%" />
                        <col width="15%" />
                        <col width="35%" />
                    </colgroup>
					<tr>
						<th>업체명</th>
						<td><c:out value="${corpInfo.corpNm}" /></td>
						<th>업체구분</th>
						<td>
							<c:forEach var="code" items="${corpModCd}" varStatus="status">
								<c:if test="${corpInfo.corpModCd eq code.cdNum}">${code.cdNm}</c:if>
							</c:forEach>
							<c:if test="${corpInfo.corpCd eq Constant.SOCIAL}">
								<c:if test="${corpInfo.corpSubCd eq Constant.SOCIAL_TOUR }">(여행사)</c:if>
								<c:if test="${corpInfo.corpSubCd eq Constant.SOCIAL_TICK }">(관광지 - POS
									<c:if test="${corpInfo.posUseYn eq Constant.FLAG_Y }">사용</c:if>
								  	<c:if test="${corpInfo.posUseYn eq Constant.FLAG_N }">미사용</c:if>)
								</c:if>
								<c:if test="${corpInfo.corpSubCd eq Constant.SOCIAL_FOOD }">(음식/뷰티 - POS
								   <c:if test="${corpInfo.posUseYn eq Constant.FLAG_Y }">사용</c:if>
								  	<c:if test="${corpInfo.posUseYn eq Constant.FLAG_N }">미사용</c:if>)
								</c:if>
							</c:if>
						</td>
					</tr>
					<tr>
						<th>사업자등록번호</th>
						<td><c:out value="${corpInfo.coRegNum}" /></td>
						<th>회사유형</th>
						<td>
							<c:if test="${corpInfo.corpType eq Constant.CORP_TYPE_CORP}">법인</c:if>
							<c:if test="${corpInfo.corpType eq Constant.CORP_TYPE_INDI}">개인</c:if>
							<c:if test="${corpInfo.corpType eq Constant.CORP_TYPE_SIMP}">간이</c:if>
						</td>						
					</tr>
					<tr>						
						<th>예약전화번호</th>
						<td><c:out value="${corpInfo.rsvTelNum}" /></td>
						<th>팩스번호</th>
						<td><c:out value="${corpInfo.faxNum}" /></td>
					</tr>
					<tr>						
						<th>업체홈페이지</th>
						<td><a href="<c:out value='${corpInfo.hmpgAddr}' />" target="_blank"><c:out value='${corpInfo.hmpgAddr}' /></a></td>
						<th>협회소속분과</th>
						<td><c:out value="${corpInfo.branchNm}" /></td>
					</tr>
					<tr>						
						<th>업태</th>
						<td><c:out value="${corpInfo.bsncon}" /></td>
						<th>업종</th>
						<td><c:out value="${corpInfo.bsntyp}" /></td>
					</tr>
					<tr>
						<th>업체이메일</th>
						<td><c:out value="${corpInfo.corpEmail}" /></td>
						<th>우수관광사업체</th>
						<td><c:out value="${corpInfo.superbCorpYn}" /></td>
					</tr>
					<tr>
						<th>계좌정보</th>
						<td>
							<c:out value="${corpInfo.bankNm}" /> / <c:out value="${corpInfo.accNum}" /> / <c:out value="${corpInfo.depositor}" />
						</td>
						<th>LINK 상품 사용 여부</th>
						<td>
							<c:if test="${corpInfo.linkPrdtUseYn eq Constant.FLAG_Y}">사용</c:if>
							<c:if test="${corpInfo.linkPrdtUseYn eq Constant.FLAG_N}">사용안함</c:if>
						</td>
					</tr>
					<tr>
						<th>업체주소</th>
						<td colspan="3">
							<c:out value="${corpInfo.roadNmAddr}" /> <c:out value="${corpInfo.dtlAddr}" />
						</td>
					</tr>
					<tr>
						<th>위도/경도</th>
						<td colspan="3">
							<strong>위도</strong> <c:out value="${corpInfo.lat}" /> / <strong>경도</strong> <c:out value="${corpInfo.lon}" />
						</td>
					</tr>
				</table>
				<!--//업체 기본 정보-->
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
                    	<td><c:out value="${corpInfo.ceoNm}" /></td>
                    	<th>생년월일</th>
                    	<td><c:out value="${corpInfo.ceoBth}" /></td>
                    </tr>
					<tr>
						<th>전화번호</th>
						<td><c:out value="${corpInfo.ceoTelNum}" /></td>
					</tr>
				</table>
				<!--//대표자 정보-->
				<!--담당자 정보-->
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
						<td><c:out value="${corpInfo.admNm}" /></td>
						<th>이메일</th>
						<td><c:out value="${corpInfo.admEmail}" /></td>
					</tr>
					<tr>
						<th>휴대전화</th>
						<td><c:out value="${corpInfo.admMobile}" /></td>
						<th>일반전화</th>
						<td><c:out value="${corpInfo.admTelnum}" /></td>
					</tr>
					<tr>
						<th>부서</th>
						<td><c:out value="${corpInfo.admDep}" /></td>
						<th>직위</th>
						<td><c:out value="${corpInfo.admOfcpos}" /></td>
					</tr>
				</table>
				<!--담당자 정보-->
				<!--관리자 계정 설정-->
				<h4 class="title03 margin-top25">관리자 계정 설정</h4>				
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
							<c:if test="${not empty corpInfo.managerId}">
								<p><span style="display:inline-block;width:40px;">아이디 </span>: <c:out value="${corpInfo.managerId}" /></p>
								<p><span style="display:inline-block;width:40px;">Email </span>: <c:out value="${corpInfo.managerEmail}" /></p>
								<p><span style="display:inline-block;width:40px;">이&nbsp;&nbsp;름 </span>: <c:out value="${corpInfo.managerNm}" /></p>
							</c:if>
						</td>
					</tr>
				</table>
				<!--//관리자 계정 설정-->
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
							<c:if test="${not empty corpInfo.visitMappingId}">
								연계중 (<c:out value="${corpInfo.visitMappingId}"/>)
								<div class="btn_sty09"><span><a href="javascript:fn_NonVisitMapping();">연계해제</a></span></div>
							</c:if>
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
						<th scope="row">계약서1</th>
						<td>
							<c:if test="${!empty cprfMap['5']}">
								${cprfMap['5'].realFileNm}
								<button type="button" class="btn sm" onclick="window.open('${cprfMap['5'].savePath}${cprfMap['5'].saveFileNm}')">보기</button>
							</c:if>
						</td>
						<th scope="row">계약서2</th>
						<td>
							<c:if test="${!empty cprfMap['6']}">
								${cprfMap['6'].realFileNm}
								<button type="button" class="btn sm" onclick="window.open('${cprfMap['6'].savePath}${cprfMap['6'].saveFileNm}')">보기</button>
							</c:if>
						</td>
					</tr>
				</table>
				<h4 class="title03 margin-top25">업체 comment</h4>
				<table border="1" class="table02">
					<colgroup>
						<col width="15%" />
						<col width="35%" />
						<col width="15%" />
						<col width="35%" />
					</colgroup>
					<tr>
						<td colspan="4">
							<c:if test="${not empty corpInfo.corpComment}">
							${fn:replace(corpInfo.corpComment, replaceChar,"<br/>")}
							</c:if>
							<c:if test="${empty corpInfo.corpComment}">
								없음
							</c:if>
						</td>
					</tr>
				</table>
				<ul class="btn_rt01">
					<li class="btn_sty04"><a href="javascript:fn_UdtCorp()">수정</a></li>
					<li class="btn_sty01"><a href="javascript:fn_ListCorp()">목록</a></li>
					<li class="btn_sty03"><a href="javascript:fn_LoginMas('${corpInfo.corpId}');">업체관리자</a></li>
				</ul>
			</div>
			<!--//업체정보상세-->
			<!--//본문-->
		</div>
	</div>
	<!--//Contents 영역--> 
</div>
</body>
</html>