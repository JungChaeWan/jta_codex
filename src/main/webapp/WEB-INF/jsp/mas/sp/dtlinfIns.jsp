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
	if($("#subject").val() == ""){
		alert("상품명을 입력 하세요.");
		$("#subject").focus();
		return;
	}

	var nCnt = 0;
	for(var i=1; i<=8; i++){
		if($("#itemNm"+i).val() != ""){
			nCnt++;

			if((isNaN($("#itemAmt"+i).val()) == true) || ($("#itemAmt"+i).val() == "") ){
				alert("가격은 숫자만 입력 하세요.");
				$("#itemAmt"+i).focus();
				return;
			}

			if($("#dtlinfType").val() == 'B'){
				if((isNaN($("#itemDisAmt"+i).val()) == true) || ($("#itemDisAmt"+i).val() == "")){
					alert("탐나오 가격은 숫자만 입력 하세요.");
					$("#itemDisAmt"+i).focus();
					return;
				}

				if($("#itemEtc"+i).val().length > 600 ){
					alert("비고는 600글자 이하만 입력 하세요.");
					$("#itemEtc"+i).focus();
					return;
				}
			}
		}
	}

	//if(nCnt==0){
	//	alert("하나 이상의 항목을 입력 하세요.");
	//	$("#itemNm1").focus();
	//	return;
	//}


	document.frm.action = "<c:url value='/mas/sp/dtlinfIns.do'/>";
	document.frm.submit();
}


function fn_ChangeType(val) {
	//alert(val);
	if(val=='A'){
		$("#TR_selNm").show();
		$("#TR_subject").show();
		$("#TR_dtlinfExp").show();
		for(var i=1; i<=8; i++){
			$("#SPAN_itemDisAmt"+i).hide();
			$("#SPAN_itemEtc"+i).hide();
		}

	}else{
		$("#TR_selNm").hide();
		$("#TR_subject").show();
		$("#TR_dtlinfExp").show();
		for(var i=1; i<=8; i++){
			$("#SPAN_itemDisAmt"+i).show();
			$("#SPAN_itemEtc"+i).show();
		}
	}
}

function fn_DelItem(idx){
	$("#itemNm"+idx).val("");
	$("#itemAmt"+idx).val("");
	$("#itemDisAmt"+idx).val("");
	$("#itemEtc"+idx).val("");
}

$(document).ready(function(){
	fn_ChangeType('B');

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

				<%--
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
		          --%>

	            <!--본문-->
	            <form:form commandName="frm" name="frm" method="post">
	            	<input type="hidden" name="prdtNum"  value="${spPrdtInf.prdtNum }"/>
	            	<input type="hidden" name="dtlinfType"  value="B"/>
					<input type="hidden" name="pageIndex"  value="${searchVO.pageIndex}"/>

					<div id="contents">
						<div class="register_area">
							<h4 class="title02">선택 사항 / 가격 안내 등록</h4>

							<table border="1" class="table02">
								<colgroup>
			                        <col width="200" />
			                        <col width="*" />
			                        <col width="200" />
			                        <col width="*" />
			                    </colgroup>
			                    <%--
								<tr>
									<th>타입<span class="font_red">*</span></th>
									<td colspan="3">
										<select id=dtlinfType name="dtlinfType" onchange="fn_ChangeType(this.value);">
											<option value="A" <c:if test="${SP_DTLINFVO.dtlinfType == 'A'}">selected="selected"</c:if>>선택사항</option>
											<option value="B" <c:if test="${SP_DTLINFVO.dtlinfType == 'B' || empty SP_DTLINFVO.dtlinfType }">selected="selected"</c:if>>가격안내</option>
										</select>
									</td>
								</tr>
								 --%>
								<tr>
									<th scope="row">출력여부</th>
									<td colspan="3">
										<input type="radio" name="printYn" id="printYn1" value="Y" <c:if test="${SP_DTLINFVO.printYn=='Y' or empty SP_DTLINFVO.printYn}">checked="checked"</c:if> /> <label for="printYn1">사용</label>
										<input type="radio" name="printYn" id="printYn2" value="N" <c:if test="${SP_DTLINFVO.printYn=='N'}">checked="checked"</c:if> /> <label for="printYn2">미사용</label>

									</td>
								</tr>
								<tr id="TR_selNm">
									<th>선택 명<span class="font_red"></span></th>
									<td colspan="3">
										<input type="text" name="selNm" id="selNm"  class="input_text30" maxlength="60" value="${SP_DTLINFVO.selNm}"/>
									</td>
								</tr>
								<tr id="TR_subject">
									<th>상품명<span class="font_red">*</span></th>
									<td colspan="3">
										<input type="text" name="subject" id="subject"  class="input_text30" maxlength="60" value="${SP_DTLINFVO.subject}"/>
									</td>
								</tr>

								<tr>
									<th>옵션<span class="font_red"></span></th>
									<td colspan="3">
										<%--
										<c:forEach var="data" items="${dtlInfItemList}" varStatus="status">
											<p>
											옵션명: <input type="text" name="itemNm${status.count}" id="itemNm${status.count}"  class="input_text10" maxlength="60" value="${data.itemNm}"/>
											&nbsp;가격: <input type="text" name="itemAmt${status.count}" id="itemAmt${status.count}"  class="input_text10" maxlength="10" value="${data.itemAmt}"/>
											<span id="SPAN_itemDisAmt${status.count}">&nbsp;탐나오가격: <input type="text" name="itemDisAmt${status.count}" id="itemDisAmt${status.count}"  class="input_text10" maxlength="10" value="${data.itemDisAmt}"/></span>
											<span id="SPAN_itemEtc${status.count}">&nbsp;비고: <input type="text" name="itemEtc${status.count}" id="itemEtc${status.count}"  class="input_text10" maxlength="60" value="${data.itemDisAmt}"/></span>
											<span><a href="javascript:fn_DelItem(${status.count})">[지우기]</a></span>
											</p>
										</c:forEach>
										--%>
										<c:forEach var="i" begin="1" end="8" step="1">
											<p>
											옵션명: <input type="text" name="itemNm${i}" id="itemNm${i}"  class="input_text10" maxlength="60" value=""/>
											&nbsp;가격: <input type="text" name="itemAmt${i}" id="itemAmt${i}"  class="input_text10" maxlength="10" value=""/>
											<span id="SPAN_itemDisAmt${i}">&nbsp;탐나오가격: <input type="text" name="itemDisAmt${i}" id="itemDisAmt${i}"  class="input_text10" maxlength="10" value=""/></span>
											<span id="SPAN_itemEtc${i}">&nbsp;비고:<textarea name="itemEtc${i}" id="itemEtc${i}" cols="10" rows="2" style="width: 300px;"></textarea></span>
											<%-- <span id="SPAN_itemEtc${i}">&nbsp;비고: <input type="text" name="itemEtc${i}" id="itemEtc${i}"  class="input_text10" maxlength="60" value=""/></span> --%>
											<span><a href="javascript:fn_DelItem(${i})">[지우기]</a></span>
											</p>
										</c:forEach>
									</td>
								</tr>

								<tr id="TR_dtlinfExp">
									<th>설명<span class="font_red"></span></th>
									<td colspan="3">
										<textarea name="dtlinfExp" id="dtlinfExp" cols="15" rows="10">${SP_DTLINFVO.dtlinfExp}</textarea>
									</td>
								</tr>
							</table>

							<ul class="btn_rt01 align_ct">
								<li class="btn_sty04">
									<a href="javascript:fn_Ins()">저장</a>
								</li>
								<li class="btn_sty01">
									<a href="<c:url value='/mas/sp/dtlinfList.do'/>?prdtNum=${spPrdtInf.prdtNum }&pageIndex=${searchVO.pageIndex}">뒤로</a>
									<!-- <a href="javascript:history.back();">뒤로</a> -->
								</li>
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