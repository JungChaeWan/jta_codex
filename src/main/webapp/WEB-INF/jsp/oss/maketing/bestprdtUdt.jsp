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
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>


<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">

function fn_Udt() {

	if($('#prdtNum').val().length == 0){
		alert("상품을 선택 하세요.");
		$('#prdtNum').focus();
		return;
	}

	document.frm.action ="<c:url value='/oss/bestprdtUdt.do'/>";
	document.frm.submit();
}


function fn_Dummay(){

}

function fn_viewSelectProduct() {
	var strCd = '${searchVO.sCorpCd }';
	var strCdSub = '${searchVO.sCorpSubCd }';
	var retVal;

//	strCd = strCd.substring(1, 3);
	if('AD'==strCd || 'RC'==strCd || 'GL'==strCd){
		retVal = window.open("<c:url value='/oss/findPrdt.do'/>?sPrdtCd="+strCd,"findPrdt", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");
	}else if('SP'==strCd){

//		if(strCdSub == 'C200' ||  strCdSub == 'C300'){
			//서브카테고리 전체 검사
			retVal = window.open("<c:url value='/oss/findSpPrdt.do'/>?sCtgr="+strCdSub,"findPrdt", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");
//		}else{
			//서브카테고리만 검사
//			retVal = window.open("<c:url value='/oss/findSpPrdt.do'/>?sSubCtgr="+strCdSub,"findPrdt", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");
//		}
	}else if('SV'==strCd){
		retVal = window.open("<c:url value='/oss/findSvPrdt.do'/>","findPrdt", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");
	}else{
		alert("잘못된 접근 입니다.");
	}
}

function fn_selectProduct(prdtId, corpNm, prdtNm) {

	$("#prdtNum").val(prdtId);
	$("#corpNm").text(corpNm);
	$("#prdtNm").text(prdtNm);

}


$(document).ready(function(){

});


</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=site" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=site&sub=bestprdt" flush="false"></jsp:include>
		<div id="contents_area">
			<!--본문-->
			<!--상품 등록-->
			<form:form commandName="frm" name="frm" method="post" enctype="multipart/form-data">
				<input type="hidden" name="bestprdtNum" value="${BESTPRDTVO.bestprdtNum }" />
				<input type="hidden" name="sCorpCd" value="${searchVO.sCorpCd }" />
				<input type="hidden" name="sCorpSubCd" value="${searchVO.sCorpSubCd }" />
				<input type="hidden" name="corpCd" value="${searchVO.sCorpCd }" />
				<input type="hidden" name="corpSubCd" value="${searchVO.sCorpSubCd }" />


				<div id="contents">
					<h4 class="title03">베스트 상품 등록<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span></h4>

					<table border="1" class="table02">
						<colgroup>
	                        <col width="200" />
	                        <col width="*" />
	                        <col width="200" />
	                        <col width="*" />
	                    </colgroup>
	                    <tr>
	                    	<c:if test="${!(searchVO.sCorpCd eq 'SP')}">
	                    		<th>상품구분<span class="font_red"></span></th>
								<td colspan="3">
									<c:out value="${cdCorp.cdNm}"/>
								</td>
	                    	</c:if>
	                    	<c:if test="${searchVO.sCorpCd eq 'SP'}">
								<th>상품구분<span class="font_red"></span></th>
								<td colspan="1">
									<c:out value="${cdCorp.cdNm}"/>
								</td>
								<th>상품상세구분<span class="font_red"></span></th>
								<td colspan="1">
									<c:out value="${cdCorpSub.cdNm}"/>
								</td>
							</c:if>
						</tr>
						<tr>
							<th>상품<span class="font_red">*</span></th>
							<td colspan="3">
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewSelectProduct();">상품검색</a></span>
								</div>
								<input type="text" name="prdtNum" id="prdtNum" readonly="readonly" maxlength="30" value="${BESTPRDTVO.prdtNum}"/>
								[ <span id="corpNm"><c:out value="${BESTPRDTVO.prdtNm}"/></span> ]
								[ <span id="prdtNm"><c:out value="${BESTPRDTVO.corpNm}"/></span> ]
							</td>
						</tr>
						<tr>
							<th>프로모션 내용</th>
							<td colspan="3">
								<input type="text" name="prmtContents" id="prmtContents" class="input_text30" maxlength="50" value="${BESTPRDTVO.prmtContents}"/>
								50자 이내 작성. 예) 조식무료쿠폰, 무료와인증정, 셔틀버스운행
							</td>
						</tr>
						<tr>
							<th scope="row">순번</th>
							<td colspan="3">
								<select name="printSn" id="printSn">
									<c:forEach var="i" begin="1" end="${maxPos}">
										<option value="${i}" <c:if test="${i==BESTPRDTVO.printSn}">selected="selected"</c:if>>${i}</option>
									</c:forEach>
								</select>

							</td>
						</tr>

						<tr>
							<th scope="row">사용여부</th>
							<td colspan="3">
								<input type="radio" name="printYn" id="printYn1" value="Y" <c:if test="${BESTPRDTVO.printYn=='Y' or empty BESTPRDTVO.printYn}">checked="checked"</c:if> /> <label for="printYn1">사용</label>
								<input type="radio" name="printYn" id="printYn2" value="N" <c:if test="${BESTPRDTVO.printYn=='N'}">checked="checked"</c:if> /> <label for="printYn2">미사용</label>

							</td>
						</tr>

					</table>
					<ul class="btn_rt01 align_ct">
						<li class="btn_sty04">
							<a href="javascript:fn_Udt()">저장</a>
						</li>
						<li class="btn_sty01">
							<a href="javascript:history.back();">뒤로</a>
						</li>
					</ul>
				</div>
			</form:form>
			<!--//상품등록-->
			<!--//본문-->
		</div>

	</div>
</div>
</body>
</html>