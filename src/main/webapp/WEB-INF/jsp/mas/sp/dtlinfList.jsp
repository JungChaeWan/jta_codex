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
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>


<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />

<title>탐나오 관리자 시스템 > 상품관리</title>
<script type="text/javascript">

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


function fn_Ins() {
	document.frm.action = "<c:url value='/mas/sp/dtlinfInsView.do'/>";
	document.frm.submit();
}

function fn_Udt(spDtlinfNum) {
	document.frm.spDtlinfNum.value = spDtlinfNum;
	document.frm.action = "<c:url value='/mas/sp/dtlinfUdtView.do'/>";
	document.frm.submit();
}

function fn_Del(spDtlinfNum) {
	if(confirm("삭제 하시겠습까?")){
		document.frm.spDtlinfNum.value = spDtlinfNum;
		document.frm.action = "<c:url value='/mas/sp/dtlinfDel.do'/>";
		document.frm.submit();
	}
}

function fn_GuidinfUdt(){
	document.frm.action = "<c:url value='/mas/sp/guidinfUdtView.do'/>";
	document.frm.submit();

}

function fn_GuidinfUdtBgColor(){
	document.frm.action = "<c:url value='/mas/sp/guidinfUdtBgColorView.do'/>";
	document.frm.submit();

}

$(document).ready(function(){

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

				<h2 class="title08"><c:out value="${spPrdtInf.prdtNm}"/></h2>

				<div id="menu_depth3">
						<ul>
		                   <li><a class="menu_depth3" href="javascript:fn_goTap('PRODUCT');">상품정보</a></li>
		                   <li><a class="menu_depth3" href="javascript:fn_goTap('IMG');" >상품목록이미지</a></li>
		                    <li ><a class="menu_depth3" href="javascript:fn_goTap('IMG_DETAIL');" >상세이미지</a></li>
		                    <li class="on"><a class="menu_depth3" href="javascript:fn_goTap('DTLINF');" >상세정보</a></li>
		                    <c:if test="${prdtDiv ne Constant.SP_PRDT_DIV_FREE }">
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

	            <!--본문-->
	            <form:form commandName="frm" name="frm" method="post">
	            	<input type="hidden" name="prdtNum"  value="${spPrdtInf.prdtNum }"/>
	            	<input type="hidden" name="spDtlinfNum"  value=""/>
					<input type="hidden" name="pageIndex"  value="${searchVO.pageIndex}"/>
	            	
					<div id="contents">
						<div class="register_area">
							<h4 class="title02">선택 사항 / 가격 안내</h4>

							<table border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
				            	<colgroup>
									<col width="130" />
									<col width="*" />
		                            <%-- <col width="150" /> --%>
		                            <col width="150" />
		                            <col width="140" />
								</colgroup>
								<thead>
									<tr>
										<th>순번</th>
										<th>상품명</th>
										<!-- <th>타입</th> -->
										<th>표시여부</th>
										<th> </th>
									</tr>
								</thead>
								<tbody>
									<c:if test="${fn:length(dtlInfList) == 0}">
										<tr>
											<td colspan="5" class="align_ct">
												등록된 정보가 없습니다.
											</td>
										</tr>
									</c:if>

									<c:forEach var="data" items="${dtlInfList}" varStatus="status">
										<tr>
											<td class="align_ct">
												${data.printSn}
											</td>
											<td class="align_ct">
												<c:if test="${data.dtlinfType=='A'}">
													<c:out value="${data.selNm}"/> :
												</c:if>
												<c:out value="${data.subject}"/>
											</td>
											<%--
											<td class="align_ct">
												<c:if test="${data.dtlinfType=='A'}">선택사항</c:if>
												<c:if test="${data.dtlinfType=='B'}">가격안내</c:if>
											</td>
											 --%>
											<td class="align_ct">
												<c:out value="${data.printYn}"/>
											</td>
											<td class="align_ct">
												<div class="btn_sty06">
													<span><a href="javascript:fn_Udt('${data.spDtlinfNum}')">수정</a></span>
												</div>
												<div class="btn_sty09">
													<span><a href="javascript:fn_Del('${data.spDtlinfNum}')">삭제</a></span>
												</div>
											</td>
										</tr>
									</c:forEach>

								</tbody>
							</table>

							<ul class="btn_rt01">
								<li class="btn_sty04"><a href="javascript:fn_Ins()">등록</a></li>
							</ul>

						</div>

						<div class="register_area">
							<h4 class="title02">안내사항</h4>

							<table border="1" class="table02">
								<colgroup>
			                        <col width="200" />
			                        <col width="*" />
			                        <col width="200" />
			                        <col width="*" />
			                    </colgroup>
			                    <tr>
									<th>사용여부<span class="font_red"></span></th>
									<td colspan="3">
										<c:if test="${SP_GUIDINFOVO.printYn=='Y'}">사용</c:if>
										<c:if test="${SP_GUIDINFOVO.printYn=='N' || empty SP_GUIDINFOVO.printYn}">사용안함</c:if>
									</td>
								</tr>
								<tr>
									<th>전화번호<span class="font_red"></span></th>
									<td colspan="3">
										<c:out value="${SP_GUIDINFOVO.telnum}"/>
									</td>
								</tr>
								<tr>
									<th>주소<span class="font_red"></span></th>
									<td colspan="3">
										<c:out value="${SP_GUIDINFOVO.roadNmAddr}"/>
										<c:out value="${SP_GUIDINFOVO.dtlAddr}"/>
									</td>
								</tr>
								<tr>
									<th>상품설명<span class="font_red"></span></th>
									<td colspan="3">
										<c:out value="${SP_GUIDINFOVO.prdtExp}" escapeXml="false"/>
									</td>
								</tr>
								<%-- <tr>
									<th>사용조건<span class="font_red"></span></th>
									<td colspan="3">
										<c:out value="${SP_GUIDINFOVO.useQlfct}" escapeXml="false"/>
									</td>
								</tr> --%>
								<tr>
									<th>이용안내<span class="font_red"></span></th>
									<td colspan="3">
										<c:out value="${SP_GUIDINFOVO.useGuide}" escapeXml="false"/>
									</td>
								</tr>
								<%-- <tr>
									<th>취소/환불안내<span class="font_red"></span></th>
									<td colspan="3">
										<c:out value="${SP_GUIDINFOVO.cancelRefundGuide}" escapeXml="false"/>
									</td>
								</tr> --%>
							</table>

							<ul class="btn_rt01">
								<li class="btn_sty04"><a href="javascript:fn_GuidinfUdt()">수정</a></li>
							</ul>
						</div>


						<div class="register_area">
							<h4 class="title02">배경 색상</h4>

							<table border="1" class="table02">
								<colgroup>
			                        <col width="200" />
			                        <col width="*" />
			                        <col width="200" />
			                        <col width="*" />
			                    </colgroup>
			                    <tr>
									<th>배경색상<span class="font_red"></span></th>
									<td colspan="3">
										<c:if test="${empty SP_GUIDINFOVO.bgColor}">지정안됨(#2e4b55)</c:if>
										<c:if test="${!(empty SP_GUIDINFOVO.bgColor)}">#<c:out value="${SP_GUIDINFOVO.bgColor}" escapeXml="false"/></c:if>

										<%-- <input type="text" name="bgColor" id="bgColor"  class="input_text10" maxlength="6" value="${SP_GUIDINFOVO.bgColor}"/> --%>
										<!-- (지정을 안하면 #2e4b55 로 지정됩니다.) -->
									</td>
								</tr>
							</table>


							<ul class="btn_rt01">
								<li class="btn_sty04"><a href="javascript:fn_GuidinfUdtBgColor()">수정</a></li>
							</ul>
						</div>



					</div>
				</form:form>

	            <!--//본문-->
	        </div>
	     </div>
	</div>
	<form name="tabForm">
		<input type="hidden" name="prdtNum"  value="${spPrdtInf.prdtNum }"/>
		<input type="hidden" name="pageIndex"  value="${searchVO.pageIndex}"/>
	</form>
	<!--//Contents 영역-->
</div>
</body>
</html>