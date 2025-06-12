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
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />

<title></title>

<script type="text/javascript">


</script>
</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/mas/head.do?menu=corp" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area"> 
			<!--본문-->
			
			<!--업체 상세 정보-->			
			<div id="contents">
				<h4 class="title03">업체 기본정보</h4>
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
							<c:if test="${corpInfo.corpLinkYn=='Y'}"> <b>[실시간 연계]</b></c:if>
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
						<td><c:out value="${corpInfo.corpNm}" /></td>
						<th>협회소속분과</th>
						<td><c:out value="${corpInfo.branchNm}" /></td>
					</tr>
					<tr>
						<th>사업자등록번호</th>
						<td><c:out value="${corpInfo.coRegNum}" /></td>
						<th>회사유형</th>
						<td>
							<c:choose>
								<c:when test="${corpInfo.corpType eq Constant.CORP_TYPE_CORP}">법인</c:when>
								<c:when test="${corpInfo.corpType eq Constant.CORP_TYPE_INDI}">개인</c:when>
								<c:when test="${corpInfo.corpType eq Constant.CORP_TYPE_SIMP}">간이</c:when>
							</c:choose>							
						</td>
					</tr>										
					<tr>						
						<th>업종</th>
						<td><c:out value="${corpInfo.bsncon}" /></td>
						<th>업태</th>
						<td><c:out value="${corpInfo.bsntyp}" /></td>
					</tr>
					<tr>						
						<th>예약전화번호</th>
						<td><c:out value="${corpInfo.rsvTelNum}" /></td>
						<th>팩스번호</th>
						<td><c:out value="${corpInfo.faxNum}" /></td>
					</tr>
					<tr>						
						<th>홈페이지</th>
						<td colspan="3"><c:out value="${corpInfo.hmpgAddr}" /></td>
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
								<c:if test="${b2bCmss.cmssNum eq corpInfo.cmssNum}">${b2bCmss.cmssNm}(${b2bCmss.adjAplPct}%)</c:if>
							</c:forEach>
						</td>
						</c:if>
					</tr>
					<tr>
						<th>업체주소</th>
						<td colspan="3">
							<c:out value="${corpInfo.roadNmAddr}" />&nbsp;<c:out value="${corpInfo.dtlAddr}" />
						</td>
					</tr>
					<tr>
						<th>위도/경도</th>
						<td colspan="3">
							<c:out value="${corpInfo.lat}" /> / <c:out value="${corpInfo.lon}" /> 
						</td>
					</tr>										
					<tr>						
						<th>입금계좌정보</th>
						<td colspan="3"><c:out value="${corpInfo.bankNm}" /> <c:out value="${corpInfo.accNum}" />, <c:out value="${corpInfo.depositor}" /></td>						
					</tr>
				</table>
				
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
						<td colspan="3"><c:out value="${corpInfo.ceoNm}" /></td>
					</tr>
					<tr>
						<th>대표자 전화번호</th>
						<td><c:out value="${corpInfo.ceoTelNum}" /></td>
						<th>대표자 이메일</th>
						<td><c:out value="${corpInfo.corpEmail}" /></td>
					</tr>						
				</table>
				
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
						<td><c:out value="${corpInfo.admNm}" /></td>
						<th>일반전화</th>
						<td><c:out value="${corpInfo.admTelnum}" /></td>
					</tr>
                    <tr>
						<th>부서</th>
						<td><c:out value="${corpInfo.admDep}" /></td>
						<th>직위</th>
						<td><c:out value="${corpInfo.admOfcpos}" /></td>
					</tr>
					<tr>
						<th>담당자 휴대전화</th>
						<td><c:out value="${corpInfo.admMobile}" /></td>
						<th>담당자 이메일</th>
						<td><c:out value="${corpInfo.admEmail}" /></td>
					</tr>
					<tr>
						<th>담당자 휴대전화2</th>
						<td><c:out value="${corpInfo.admMobile2}" /></td>
						<th>담당자 이메일2</th>
						<td><c:out value="${corpInfo.admEmail2}" /></td>
					</tr>
					<tr>
						<th>담당자 휴대전화3</th>
						<td colspan="3"><c:out value="${corpInfo.admMobile3}" /></td>
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
				</table>
				
				<ul class="btn_rt01">
					<li class="btn_sty04"><a href="<c:url value='/mas/viewUpdateCorp.do'/>" >수정</a></li>
				</ul>
			</div>			
			<!--//업체 정보 상세-->
			<!--//본문-->
		</div>
	</div>
	<!--//Contents 영역--> 
</div>
</body>
</html>