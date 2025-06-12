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
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>

<validator:javascript formName="SVCRTNVO" staticJavascript="false" xhtml="true" cdata="true"/>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">

function fn_Reg() {
 	if($("#crtnNm").val() == null || $("#crtnNm").val() == ""){
		alert("큐레이션명은 필수 입력 입니다.");
		return;
	}
 
	/*	if(!validateSVCRTNVO(document.SVCRTNVO)) {
		return ;
	}
 	if($("#listImgFile").val() == "" && $("#listImg").val() == "") {
		alert("목록이미지를 선택해 주세요.");
		return ;
	}
	if($("#listImg").val() == ""){
		var fileName = $('#listImgFile').val().toLowerCase();//파일명
		var _fileLen = fileName.length;
		var _lastDot = fileName.lastIndexOf('.');
		var strSub = fileName.substring(_lastDot, _fileLen).toLowerCase();

		if(!(strSub.toLowerCase() == ".jpg" || strSub.toLowerCase() == ".gif" || strSub.toLowerCase() == ".png")){
			alert("목록이미지는 이미지파일(jpg, gif, png) 파일만 등록이 가능합니다.");
			return false;
		}
	}else if($("#prdtNumList").val() == "") {
		alert("상품을 선택해 주세요.")
		return ;
	} */
	document.SVCRTNVO.action ="<c:url value='/oss/svCrtnMod.do'/>";
	document.SVCRTNVO.submit();
}

function fn_List() {
	document.SVCRTNVO.action ="<c:url value='/oss/svCrtnList.do'/>";
	document.SVCRTNVO.submit();
}

//이미지 삭제.
function fn_DelImg(type) {
	$("#d_"+type + "Img").hide();
	$("#"+type +"ImgFile").show();
	$("#"+type+"Img").val('');
}

var prdtPopup;

function fn_viewSelectSvProduct() {
	prdtPopup = window.open("<c:url value='/oss/findSvPrdt.do'/>","findPrdt", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");
}

function fn_selectProduct(prdtId, corpNm, prdtNm) {
	var isA = true;

	$("input[name='prdtNum']").each(function(){
		if($(this).val() == prdtId) {
			isA = false;
			return;
		}
	});

	if(isA == false) {
		prdtPopup.alert("<spring:message code='errors.common.exist' />");
		return;
	}
	var strHtml = "<li>";
	strHtml += "<input type='hidden' name='prdtNum' value='" + prdtId + "'/>";
	strHtml += "[" + prdtId + "][" + corpNm + "][" + prdtNm + "] ";
	strHtml += "<a href='javascript:void(0)'><span class='del'><img src='/images/web/icon/close5.gif' alt='삭제'></span></a>";
	strHtml += "</li>";

	$("#selectProduct ul").append(strHtml);
	
	var prdtNumList = [];
	$("input[name='prdtNum']").each(function () {
		prdtNumList.push($(this).val());
	});

	$("#prdtNumList").val(prdtNumList.toString());
}

$(document).ready(function(){

	$("#selectProduct").on("click", ".del", function(index) {
		$(this).parents("li").remove();
		var prdtNumList = [];
		$("input[name='prdtNum']").each(function () {
			prdtNumList.push($(this).val());
		});
		$("#prdtNumList").val(prdtNumList.toString());
	});

	// 출력 순서의 자동 정렬
	$('.printSn').change(function() {
		$.selSort = $(this).val();
		$.selId = $(this).attr('id');
		$.curVal = $('#' + $.selId + '_sort').val();

		if ($.selSort > $.curVal) {
			$('.printSn').each(function() {
				if ($(this).attr('id') != $.selId && $(this).val() >= $.curVal && $(this).val() <= $.selSort) {
					$(this).val($(this).val() - 1);
					$('#' + $(this).attr('id') + '_sort').val($(this).val());
				}
			});
		} else if ($.selSort < $.curVal) {
			$('.printSn').each(function() {
				if ($(this).attr('id') != $.selId && ($(this).val() >= $.selSort && $(this).val() <= $.curVal)) {
					$(this).val(eval($(this).val()) + 1);
					$('#' + $(this).attr('id') + '_sort').val($(this).val());
				}
			});
		}
		$('#' + $.selId + '_sort').val($(this).val());

		// DB 값 수정
		$.ajax({
			type:"post",
			dataType:"json",
			// async:false,
			url:"<c:url value='/oss/svCrtnPrdtSortMod.ajax'/>",
			data:"crtnNum=${crtnVO.crtnNum}&prdtNum=" + $.selId + "&newSn=" + $.selSort + "&oldSn=" + $.curVal,
			success:function(data){
				//alert('정렬 수정')
				location.reload();
			},
			error:fn_AjaxError
		});
	});
	
	var prdtNumList = [];
	$("input[name='prdtNum']").each(function () {
		prdtNumList.push($(this).val());
	});
	$("#prdtNumList").val(prdtNumList.toString());
});

</script>
</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=site" />
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=site&sub=curation" />
		<div id="contents_area">
			<!--본문-->
			<!--상품 등록-->
			<div id="contents">
				<form:form commandName="SVCRTNVO" name="SVCRTNVO" method="post" enctype="multipart/form-data">
					<input type="hidden" name="crtnNum" value="${crtnVO.crtnNum }" />
					<input type="hidden" id="pageIndex" name="pageIndex" value="${SVCRTNVO.pageIndex}" />

					<h4 class="title03">큐레이션 수정<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span></h4>

					<table border="1" class="table02">
						<colgroup>
							<col width="200" />
							<col width="*" />
							<col width="200" />
							<col width="*" />
						</colgroup>
						<tr>
							<th scope="row">큐레이션번호</th>
							<td colspan="3">
								<c:out value="${crtnVO.crtnNum}"/>
							</td>
						</tr>
						<tr>
							<th>큐레이션명<span class="font_red">*</span></th>
							<td colspan="3">
								<form:input path="crtnNm" id="crtnNm"  class="input_text_full" maxlength="20" value="${crtnVO.crtnNm}" />
								<form:errors path="crtnNm"  cssClass="error_text" />
							</td>
						</tr>
<%-- 						<tr>
							<th>간략설명<span class="font_red">*</span></th>
							<td colspan="3">
								<form:input path="simpleExp" id="simpleExp"  class="input_text_full" value="${crtnVO.simpleExp}"/>
								<form:errors path="simpleExp"  cssClass="error_text" />
							</td>
						</tr>
						<tr>
							<th>목록이미지<span class="font_red">*</span></th>
							<td colspan="3">
								<c:if test="${not empty crtnVO.listImgPath }">
									<div id="d_listImg">
										<c:out value="${crtnVO.listImgPath}" />
										<div class="btn_sty09">
											<span><a href="javascript:fn_DelImg('list')">삭제</a></span>
										</div>
										<div class="btn_sty06">
											<span><a href="${crtnVO.listImgPath}" target="_blank">상세보기</a></span>
										</div>
									</div>
								</c:if>
								<input type="file" id="listImgFile" name="listImgFile" accept="image/*" style="width: 70%;<c:if test="${not empty crtnVO.listImgPath}">display:none</c:if>" />
								<input type="hidden" id="listImg"  name="listImgPath" value="${crtnVO.listImgPath}" />
								<br /><c:if test="${not empty fileError}">Error:<c:out value="${fileError}"/></c:if>
							</td>
						</tr> --%>
						<tr>
							<th>출력 순서</th>
							<td colspan="3">
								<form:hidden path="oldSort" id="oldSort" value="${crtnVO.sort}"/>
								<select name="sort" id="sort">
									<c:forEach var="sort" begin="1" end="${crtnVO.maxSort }">
									<option value="${sort}" <c:if test="${crtnVO.sort eq sort}">selected="selected"</c:if>>${sort }</option>
									</c:forEach>
								</select>
								<!-- <br /><span class="font_red">출력 순서 '7' 이상부터는 랜덤으로 출력됩니다. </span> -->
							</td>
						</tr>
						<tr>
							<th>출력 여부</th>
							<td colspan="3">
								<select name="printYn" id="printYn">
									<option value="${Constant.FLAG_Y}" <c:if test="${crtnVO.printYn == Constant.FLAG_Y}">selected="selected"</c:if>>출력</option>
									<option value="${Constant.FLAG_N}" <c:if test="${crtnVO.printYn == Constant.FLAG_N}">selected="selected"</c:if>>미출력</option>
								</select>
							</td>
						</tr>
						<tr>
							<th rowspan="2">관련상품<span class="font_red"></span></th>
							<td colspan="3">
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewSelectSvProduct();">상품검색</a></span>
								</div>
								<input type="hidden" name="prdtNumList" id="prdtNumList"/>
							</td>
						</tr>
						<tr>
							<td colspan="3">
							<div id="selectProduct">
								<ul>
									<c:forEach  items="${crtnPrdtList}" var="product">
										<input type="hidden" id="${product.prdtNum}_sort" value="${product.printSn }" />
										<li>
											<select class="printSn" id="${product.prdtNum}">
												<c:forEach var="cnt" begin="1" end="${maxSortSn }">
													<option value="${cnt}" <c:if test="${cnt == product.printSn}">selected="selected"</c:if>>${cnt}</option>
												</c:forEach>
											</select>
											[<c:out value="${product.prdtNum}"/>][<c:out value="${product.corpNm}"/>][<c:out value="${product.prdtNm}"/>] <a href="javascript:void(0)"><span class="del"><img src="/images/web/icon/close5.gif" alt="삭제"></span></a>
											<input type="hidden" name="prdtNum" value="${product.prdtNum}"/>
										</li>
									</c:forEach>
								</ul>
							</div>
							</td>
						</tr>
					</table>
				</form:form>

				<ul class="btn_rt01 align_ct">
					<li class="btn_sty04"><a href="javascript:fn_Reg()">저장</a></li>
					<li class="btn_sty01"><a href="javascript:fn_List()">목록</a></li>
				</ul>
			</div>
			<!--//상품등록-->
			<!--//본문-->
		</div>
	</div>
</div>
</body>
</html>