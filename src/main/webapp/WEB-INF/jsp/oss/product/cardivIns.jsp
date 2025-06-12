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
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">
function fn_Ins() {
	/* $('#rcCardivNum').val( $('#rcCardivNum').val().toUpperCase() );

	if($('#rcCardivNum').val().length == 0){
		alert("차량코드를 입력 하세요.");
		$('#rcCardivNum').focus();
		return;
	}

	var patt =  /^[_A-Za-z0-9+]*$/;
	if( patt.test($('#rcCardivNum').val()) == false ){
		alert("차량코드는 영문/숫자/하이픈(-)/밑줄(_) 만 사용가능 합니다.");
		$('#rcCardivNum').focus();
		return;
	} */

	if($('#prdtNm').val().length == 0){
		alert("차량명을 입력하세요.");
		$('#prdtNm').focus();
		return;
	}
	if($('#maxiNum').val().length == 0){
		alert("정원을 입력하세요.");
		$('#maxiNum').focus();
		return;
	}
	if(isNaN($('#maxiNum').val()) == true){
		alert("정원은 숫자만 입력하세요.");
		$('#maxiNum').focus();
		return;
	}
	if($('#carImgFile').val().length == 0){
		alert("차량 이미지를 등록하세요.");
		$('#carImgFile').focus();
		return;
	}

	var fileName = $('#carImgFile').val().toLowerCase();//파일명
	var _fileLen = fileName.length;
	var _lastDot = fileName.lastIndexOf('.');
	var strSub = fileName.substring(_lastDot, _fileLen).toLowerCase();

	if(!(strSub.toLowerCase() == ".jpg" || strSub.toLowerCase() == ".gif" || strSub.toLowerCase() == ".png" || strSub.toLowerCase() == ".webp")){
		alert("차량 이미지는 이미지(jpg, gif, png, webp)파일만 등록이 가능합니다.");
		return false;
	}
	// 중복 체크
	/*var carDivCnt = 0;
	var parameters = $("#frm").serialize();

	$.ajax({
		type:"post", 
		dataType:"json",
		async:false,
		url:"<c:url value='/oss/checkCardiv.ajax'/>",
		data:parameters ,
		success:function(data){
			carDivCnt = data.carDivCnt;			
		}
	});

	if (carDivCnt > 0) {
		alert("이미 등록된 차종입니다.");
		return false;
	}*/
	document.frm.action ="<c:url value='/oss/cardivIns.do'/>";
	document.frm.submit();
}


$(document).ready(function(){

});


</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=product" />
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=product&sub=cardiv" />

		<div id="contents_area">
			<!--본문-->
			<!--상품 등록-->
			<div id="contents">
				<h4 class="title03">차종 등록<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span></h4>

				<form name="frm" id="frm" method="post" enctype="multipart/form-data">
					<table class="table02">
						<colgroup>
	                        <col class="width15" />
	                        <col />
	                    </colgroup>
						<tr>
							<th>차량명<span class="font_red">*</span></th>
							<td>
								<input type="text" name="prdtNm" id="prdtNm" class="input_text20" maxlength="30" /><br>
								※차량의 세부 모델까지 입력해야합니다. (예: 아반떼 AD, 그랜져 IG, K5 2세대)
							</td>
						</tr>
						<tr>
							<th>차량설명</th>
							<td>
								<input type="text" name="cardivExp" id="cardivExp" class="input_text50" maxlength="100" /><br>
								※차량의 부연 설명 (예: 2015~18년형, 2016년~현재)
							</td>
						</tr>
						<tr>
							<th>제조사<span class="font02">*</span></th>
							<td>
								<select name="makerDiv" id="makerDiv">
									<c:forEach var="maker" items="${makerDivCd}" varStatus="status">
										<option value="${maker.cdNum}" <c:if test="${maker.cdNum == RC_CARDIVVO.makerDiv}">selected="selected"</c:if>>${maker.cdNm}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th>차종구분<span class="font02">*</span></th>
							<td>
								<select name="carDiv" id="carDiv">
									<c:forEach var="car" items="${carDivCd}" varStatus="status">
										<option value="${car.cdNum}" <c:if test="${car.cdNum == RC_CARDIVVO.carDiv}">selected="selected"</c:if>>${car.cdNm}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th>연료구분<span class="font02">*</span></th>
							<td>
								<select name="useFuelDiv" id="useFuelDiv">
									<c:forEach var="fuel" items="${fuelCd}" varStatus="status">
										<option value="${fuel.cdNum}" <c:if test="${fuel.cdNum == RC_CARDIVVO.useFuelDiv}">selected="selected"</c:if>>${fuel.cdNm}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th>정원<span class="font_red">*</span></th>
							<td>
								<input type="text" name="maxiNum" id="maxiNum" class="input_text2" maxlength="2" value="${RC_CARDIVVO.maxiNum}"/>명
							</td>
						</tr>
						<tr>
							<th>이미지<span class="font02">*</span></th>
							<td>
								<input type="file" name="carImgFile" id="carImgFile" accept="image/*" style="width: 70%" /><span class="font_red">사이즈 : 640px*460px</span><br>
								<c:if test="${not empty fileError}">Error:<c:out value="${fileError}"/></c:if>
							</td>
						</tr>
						<tr>
							<th>검색어</th>
							<td>
								<p>
									<input type="text" name="srchWord1" id="srchWord1" maxlength="30" value="${prdtInf.srchWord1}" />
									<input type="text" name="srchWord2" id="srchWord2" maxlength="30" value="${prdtInf.srchWord2}" />
									<input type="text" name="srchWord3" id="srchWord3" maxlength="30" value="${prdtInf.srchWord3}" />
									<input type="text" name="srchWord4" id="srchWord4" maxlength="30" value="${prdtInf.srchWord4}" />
									<input type="text" name="srchWord5" id="srchWord5" maxlength="30" value="${prdtInf.srchWord5}" />
								</p>
								<p>
									<input type="text" name="srchWord6" id="srchWord6" maxlength="30" value="${prdtInf.srchWord6}" />
									<input type="text" name="srchWord7" id="srchWord7" maxlength="30" value="${prdtInf.srchWord7}" />
									<input type="text" name="srchWord8" id="srchWord8" maxlength="30" value="${prdtInf.srchWord8}" />
									<input type="text" name="srchWord9" id="srchWord9" maxlength="30" value="${prdtInf.srchWord9}" />
									<input type="text" name="srchWord10" id="srchWord10" maxlength="30" value="${prdtInf.srchWord10}" />
								</p>
							</td>
						</tr>
						<tr>
							<th>사용여부<span class="font02">*</span></th>
							<td>
								<select id=useYn" name="useYn">
									<option value="Y" <c:if test="${RC_CARDIVVO.useYn=='Y'}">selected="selected"</c:if> >사용</option>
									<option value="N" <c:if test="${RC_CARDIVVO.useYn=='N'}">selected="selected"</c:if> >미사용</option>
								</select>
							</td>
						</tr>
					</table>
				</form>

				<ul class="btn_rt01 align_ct">
					<li class="btn_sty04"><a href="javascript:fn_Ins()">저장</a></li>
					<li class="btn_sty01"><a href="javascript:history.back();">뒤로</a></li>
				</ul>
			</div>
			<!--//상품등록-->
			<!--//본문-->
		</div>
	</div>
</div>
</body>
</html>