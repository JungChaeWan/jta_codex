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

	if($('#kwaNm').val().length == 0) {
		alert("해시태그 명을 입력하세요.");
		$('#kwaNm').focus();
		return;
	}

	if($('#startDttm').val().length == 0) {
		alert("시작일을 입력하세요.");
		$('#startDttm').focus();
		return;
	}

	if($('#endDttm').val().length == 0) {
		alert("종료을 입력하세요.");
		$('#endDttm').focus();
		return;
	}

	/*
	var arrAD = new Array();

	$( "#selectProductAD li" ).each(function( index ) {
		console.log( index+" - "+  $(this).find(".printSnAD").val() + "   " +
	  	$(this).find("input[name=prdtNumAD]").attr("value") )

	  	var prdtNum = $(this).find("input[name=prdtNumAD]").attr("value");
	  	var printSn = $(this).find(".printSnAD").val();

	  	arrAD[i] = {pn:"aa", sn:"bb" };
	  	//arrAD[i].pn = prdtNum;
	  	//arrAD[i].sn = printSn;
	});
	*/
	$("#startDttm").val($('#startDttm').val().replace(/-/g, ""));
	$("#endDttm").val($('#endDttm').val().replace(/-/g, ""));

	document.frm.action ="<c:url value='/oss/kwaUdt.do'/>";
	document.frm.submit();
}

function fn_setLastTmEnd(){
	$("#endDttm").val("2200-12-31");
}

var g_strCd = "";
var g_strCdSub = "";

function fn_viewSelectProduct(strCd, strCdSub) {
	g_strCd = strCd;
	g_strCdSub = strCdSub;
	var retVal;

	if('AD' == strCd || 'RC' == strCd || 'GL' == strCd) {
		retVal = window.open("<c:url value='/oss/findPrdt.do'/>?sPrdtCd=" + strCd,"findPrdt", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");
	} else if('SP' == strCd) {
		if(strCdSub == 'C100' || strCdSub == 'C200' || strCdSub == 'C300' || strCdSub == 'C500') {
			//서브카테고리 전체 검사
			retVal = window.open("<c:url value='/oss/findSpPrdt.do'/>?sCtgr=" + strCdSub,"findPrdt", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");
		} else {
			//서브카테고리만 검사
			retVal = window.open("<c:url value='/oss/findSpPrdt.do'/>?sSubCtgr=" + strCdSub,"findPrdt", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");
		}
	} else if('SV' == strCd) {
		retVal = window.open("<c:url value='/oss/findSvPrdt.do'/>","findPrdt", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");
	} else {
		alert("잘못된 접근입니다.");
	}
}

function fn_selectProduct(prdtId, corpNm, prdtNm) {
	var chkNum = 0;
	$('input[name=prdtNum'+g_strCd+g_strCdSub+']').each(function() {
		if ($(this).val() == prdtId) {
			chkNum++;
			return false;
		}	
	});
	
	if (chkNum == 0) {
		var strHtml = '<li>' + '[' + prdtId + '][' + corpNm + '][' + prdtNm + ']' +
					' <a href="javascript:fn_Dummay();"><span class="del"><img src="<c:url value="/images/web/icon/close5.gif"/>" alt="삭제"></span></a>' +
					'<input type="hidden" name="prdtNum' + g_strCd+g_strCdSub + '" value="'+ prdtId + '"/>' +
					'</li>';
	
		$("#selectProduct"+g_strCd+g_strCdSub+" ul").append(strHtml);
	}
}

function fn_Dummay(){

}


function fn_ChangePrintSn(){

}

$(document).ready(function(){

	var dt = new Date();
	$("#startDttm").datepicker({
		dateFormat: "yy-mm-dd",
		minDate : "${SVR_TODAY}",
		changeYear: true,
		yearRange: "c-100:c+200",
		onClose : function(selectedDate) {
			$("#endDttm").datepicker("option", "minDate", selectedDate);
		}
	});
	$("#endDttm").datepicker({
		dateFormat: "yy-mm-dd",
		minDate : "${SVR_TODAY}",
		changeYear: true,
		yearRange: "c-100:c+200",
		onClose : function(selectedDate) {
			$("#startDttm").datepicker("option", "maxDate", selectedDate);
		}
	});

	var arrPrt = ["AD", "RC", "SPC100", "SPC200", "SPC300","SPC500", "SV"];
	//var arrPrt = ["AD", "RC"];
	var i;
	for(i=0; i<arrPrt.length; i++){

		$("#selectProduct"+arrPrt[i]).on("click", ".del", function(index) {
			$(this).parents("li").remove();
			var prdtNumList = [];
			$("input[name='prdtNum"+arrPrt[i]+"']").each(function () {
				prdtNumList.push($(this).val());
			});
			$("#prdtNumList").val(prdtNumList.toString());
		});

	}


	// 출력 순서의 자동 정렬
	$('.printSnAD').change(function() {

		//var cpcate = 'AD';
		$.selSort = $(this).val();
		$.selId = $(this).attr('id');
		$.curVal = $('#' + $.selId + '_sort').val();

		/*
		if ($.selSort > $.curVal) {
			$('.printSn'+cpcate).each(function() {
				if ($(this).attr('id') != $.selId && $(this).val() >= $.curVal && $(this).val() <= $.selSort) {
					$(this).val($(this).val() - 1);
					$('#' + $(this).attr('id') + '_sort').val($(this).val());
				}
			});
		} else if ($.selSort < $.curVal) {
			$('.printSn'+cpcate).each(function() {
				if ($(this).attr('id') != $.selId && ($(this).val() >= $.selSort && $(this).val() <= $.curVal)) {
					$(this).val(eval($(this).val()) + 1);
					$('#' + $(this).attr('id') + '_sort').val($(this).val());
				}
			});
		}
		$('#' + $.selId + '_sort').val($(this).val());
		*/

		// DB 값 수정
		$.ajax({
			type:"post",
			dataType:"json",
			// async:false,
			url:"<c:url value='/oss/kwaUdtSort.ajax'/>",
			data:"kwaNum=${KWAVO.kwaNum}&prdtNum=" + $.selId + "&newSn=" + $.selSort + "&oldSn=" + $.curVal + "&corpCd=AD&ctgr=",
			success:function(data){
				//alert('정렬 수정')
				location.reload();
			},
			error:fn_AjaxError
		});
	});

	$('.printSnRC').change(function() {
		//var cpcate = 'RC';
		$.selSort = $(this).val();
		$.selId = $(this).attr('id');
		$.curVal = $('#' + $.selId + '_sort').val();

		/*
		if ($.selSort > $.curVal) {
			$('.printSn'+cpcate).each(function() {
				if ($(this).attr('id') != $.selId && $(this).val() >= $.curVal && $(this).val() <= $.selSort) {
					$(this).val($(this).val() - 1);
					$('#' + $(this).attr('id') + '_sort').val($(this).val());
				}
			});
		} else if ($.selSort < $.curVal) {
			$('.printSn'+cpcate).each(function() {
				if ($(this).attr('id') != $.selId && ($(this).val() >= $.selSort && $(this).val() <= $.curVal)) {
					$(this).val(eval($(this).val()) + 1);
					$('#' + $(this).attr('id') + '_sort').val($(this).val());
				}
			});
		}
		$('#' + $.selId + '_sort').val($(this).val());
		*/
		// DB 값 수정
		$.ajax({
			type:"post",
			dataType:"json",
			// async:false,
			url:"<c:url value='/oss/kwaUdtSort.ajax'/>",
			data:"kwaNum=${KWAVO.kwaNum}&prdtNum=" + $.selId + "&newSn=" + $.selSort + "&oldSn=" + $.curVal + "&corpCd=RC&ctgr=",
			success:function(data){
				//alert('정렬 수정')
				location.reload();
			},
			error:fn_AjaxError
		});
	});

	$('.printSnSPC100').change(function() {
		//var cpcate = 'SPC100';
		$.selSort = $(this).val();
		$.selId = $(this).attr('id');
		$.curVal = $('#' + $.selId + '_sort').val();

		/*
		if ($.selSort > $.curVal) {
			$('.printSn'+cpcate).each(function() {
				if ($(this).attr('id') != $.selId && $(this).val() >= $.curVal && $(this).val() <= $.selSort) {
					$(this).val($(this).val() - 1);
					$('#' + $(this).attr('id') + '_sort').val($(this).val());
				}
			});
		} else if ($.selSort < $.curVal) {
			$('.printSn'+cpcate).each(function() {
				if ($(this).attr('id') != $.selId && ($(this).val() >= $.selSort && $(this).val() <= $.curVal)) {
					$(this).val(eval($(this).val()) + 1);
					$('#' + $(this).attr('id') + '_sort').val($(this).val());
				}
			});
		}
		$('#' + $.selId + '_sort').val($(this).val());
		*/

		// DB 값 수정
		$.ajax({
			type:"post",
			dataType:"json",
			// async:false,
			url:"<c:url value='/oss/kwaUdtSort.ajax'/>",
			data:"kwaNum=${KWAVO.kwaNum}&prdtNum=" + $.selId + "&newSn=" + $.selSort + "&oldSn=" + $.curVal + "&corpCd=SP&ctgr=C100",
			success:function(data){
				//alert('정렬 수정')
				location.reload();
			},
			error:fn_AjaxError
		});
	});

	$('.printSnSPC200').change(function() {
		//var cpcate = 'SPC200';
		$.selSort = $(this).val();
		$.selId = $(this).attr('id');
		$.curVal = $('#' + $.selId + '_sort').val();

		/*
		if ($.selSort > $.curVal) {
			$('.printSn'+cpcate).each(function() {
				if ($(this).attr('id') != $.selId && $(this).val() >= $.curVal && $(this).val() <= $.selSort) {
					$(this).val($(this).val() - 1);
					$('#' + $(this).attr('id') + '_sort').val($(this).val());
				}
			});
		} else if ($.selSort < $.curVal) {
			$('.printSn'+cpcate).each(function() {
				if ($(this).attr('id') != $.selId && ($(this).val() >= $.selSort && $(this).val() <= $.curVal)) {
					$(this).val(eval($(this).val()) + 1);
					$('#' + $(this).attr('id') + '_sort').val($(this).val());
				}
			});
		}
		$('#' + $.selId + '_sort').val($(this).val());
		*/

		// DB 값 수정
		$.ajax({
			type:"post",
			dataType:"json",
			// async:false,
			url:"<c:url value='/oss/kwaUdtSort.ajax'/>",
			data:"kwaNum=${KWAVO.kwaNum}&prdtNum=" + $.selId + "&newSn=" + $.selSort + "&oldSn=" + $.curVal + "&corpCd=SP&ctgr=C200",
			success:function(data){
				//alert('정렬 수정')
				location.reload();
			},
			error:fn_AjaxError
		});
	});

	$('.printSnSPC300').change(function() {
		//var cpcate = 'SPC300';
		$.selSort = $(this).val();
		$.selId = $(this).attr('id');
		$.curVal = $('#' + $.selId + '_sort').val();

		/*
		if ($.selSort > $.curVal) {
			$('.printSn'+cpcate).each(function() {
				if ($(this).attr('id') != $.selId && $(this).val() >= $.curVal && $(this).val() <= $.selSort) {
					$(this).val($(this).val() - 1);
					$('#' + $(this).attr('id') + '_sort').val($(this).val());
				}
			});
		} else if ($.selSort < $.curVal) {
			$('.printSn'+cpcate).each(function() {
				if ($(this).attr('id') != $.selId && ($(this).val() >= $.selSort && $(this).val() <= $.curVal)) {
					$(this).val(eval($(this).val()) + 1);
					$('#' + $(this).attr('id') + '_sort').val($(this).val());
				}
			});
		}
		$('#' + $.selId + '_sort').val($(this).val());
		*/
		// DB 값 수정
		$.ajax({
			type:"post",
			dataType:"json",
			// async:false,
			url:"<c:url value='/oss/kwaUdtSort.ajax'/>",
			data:"kwaNum=${KWAVO.kwaNum}&prdtNum=" + $.selId + "&newSn=" + $.selSort + "&oldSn=" + $.curVal + "&corpCd=SP&ctgr=C300",
			success:function(data){
				//alert('정렬 수정')
				location.reload();
			},
			error:fn_AjaxError
		});
	});

	$('.printSnSV').change(function() {
		//var cpcate = 'SV';
		$.selSort = $(this).val();
		$.selId = $(this).attr('id');
		$.curVal = $('#' + $.selId + '_sort').val();

		/*
		if ($.selSort > $.curVal) {
			$('.printSn'+cpcate).each(function() {
				if ($(this).attr('id') != $.selId && $(this).val() >= $.curVal && $(this).val() <= $.selSort) {
					$(this).val($(this).val() - 1);
					$('#' + $(this).attr('id') + '_sort').val($(this).val());
				}
			});
		} else if ($.selSort < $.curVal) {
			$('.printSn'+cpcate).each(function() {
				if ($(this).attr('id') != $.selId && ($(this).val() >= $.selSort && $(this).val() <= $.curVal)) {
					$(this).val(eval($(this).val()) + 1);
					$('#' + $(this).attr('id') + '_sort').val($(this).val());
				}
			});
		}
		$('#' + $.selId + '_sort').val($(this).val());
		*/

		// DB 값 수정
		$.ajax({
			type:"post",
			dataType:"json",
			// async:false,
			url:"<c:url value='/oss/kwaUdtSort.ajax'/>",
			data:"kwaNum=${KWAVO.kwaNum}&prdtNum=" + $.selId + "&newSn=" + $.selSort + "&oldSn=" + $.curVal + "&corpCd=SV&ctgr=",
			success:function(data){
				//alert('정렬 수정')
				location.reload();
			},
			error:fn_AjaxError
		});
	});

});

</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=site" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=site&sub=kwa" flush="false"></jsp:include>
		<div id="contents_area">
			<!--본문-->
			<!--상품 등록-->
			<form:form name="frm" method="post" enctype="multipart/form-data">
				<input type="hidden" name="kwaNum" value="${KWAVO.kwaNum }" />
				<input type="hidden" id="location" name="location" value="${KWAVO.location}"/>
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}" />

				<div id="contents">
					<h4 class="title03">해시태그 광고 수정<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span></h4>

					<table border="1" class="table02">
						<colgroup>
	                        <col width="200" />
	                        <col width="*" />
	                        <col width="200" />
	                        <col width="*" />
	                    </colgroup>

						<tr>
							<th>해시태그 명<span class="font_red">*</span></th>
							<td colspan="3">
								<input type="text" name="kwaNm" id="kwaNm"  class="input_text_full" maxlength="30" value="${KWAVO.kwaNm}"/>
							</td>
						</tr>
						<tr>
							<th>시작일<span class="font_red">*</span></th>
							<td>
								<input type="text" name="startDttm" id="startDttm"  class="input_text5" readonly="true"  value="${fn:substring(KWAVO.startDttm,0,4)}-${fn:substring(KWAVO.startDttm,4,6)}-${fn:substring(KWAVO.startDttm,6,8)}" />
							</td>
							<th>종료일<span class="font_red">*</span></th>
							<td>
								<input type="text" name="endDttm" id="endDttm"  class="input_text5" readonly="true" value="${fn:substring(KWAVO.endDttm,0,4)}-${fn:substring(KWAVO.endDttm,4,6)}-${fn:substring(KWAVO.endDttm,6,8)}" />
								<div class="btn_sty04">
									<span><a href="javascript:fn_setLastTmEnd();">2200년까지</a></span>
								</div>
							</td>
						</tr>
						<tr>
							<th> <span class="font_red"></span></th>
							<td colspan="3">
								※ URL, 관련상품 둘 다 있을 때는 URL이 표시됩니다.<br/>
								※ URL, 관련상품 둘 다 없을 때는 해시태그 명으로 통합 검색합니다.
							</td>
						</tr>
						<tr>
							<th>연결URL<span class="font_red"></span></th>
							<td colspan="3">
								PC:<input type="text" name="pcUrl" id="pcUrl"  class="input_text_full" maxlength="100" value="${KWAVO.pcUrl}"/>
								<br/>
								Mobile:<input type="text" name="mobileUrl" id="mobileUrl"  class="input_text_full" maxlength="100" value="${KWAVO.mobileUrl}"/>
								<br/>

							</td>
						</tr>
						<tr>
							<th >관련상품<span class="font_red"></span></th>
							<td colspan="3">
								숙소
								<div class="btn_sty04">
									 <span><a href="javascript:fn_viewSelectProduct('AD','');">상품검색</a></span>
								</div><br/>
								<div id="selectProductAD" style="border: 1px solid">
									<ul>
										<c:forEach  items="${kwaprdtListAD}" var="product">
											<input type="hidden" id="${product.prdtNum}_sort" value="${product.printSn }" />
											<li>
												<select class="printSnAD" id="${product.prdtNum}">
													<c:forEach var="cnt" begin="1" end="${fn:length(kwaprdtListAD)}">
														<option value="${cnt}" <c:if test="${cnt == product.printSn}">selected="selected"</c:if>>${cnt}</option>
													</c:forEach>
												</select>
												 [<c:out value="${product.prdtNum}"/>][<c:out value="${product.corpNm}"/>][<c:out value="${product.prdtNm}"/>]
												 <a href="javascript:fn_Dummay();"><span class="del"><img src="<c:url value="/images/web/icon/close5.gif"/>" alt="삭제"></span></a>
												<input type="hidden" name="prdtNumAD" value="${product.prdtNum}"/>
											</li>
										</c:forEach>
									</ul>
								</div>
								<br/>
								렌터카
								<div class="btn_sty04">
									 <span><a href="javascript:fn_viewSelectProduct('RC','');">상품검색</a></span>
								</div><br/>
								<div id="selectProductRC" style="border: 1px solid">
									<ul>
										<c:forEach  items="${kwaprdtListRC}" var="product">
											<input type="hidden" id="${product.prdtNum}_sort" value="${product.printSn }" />
											<li>
												<select class="printSnRC" id="${product.prdtNum}">
													<c:forEach var="cnt" begin="1" end="${fn:length(kwaprdtListRC)}">
														<option value="${cnt}" <c:if test="${cnt == product.printSn}">selected="selected"</c:if>>${cnt}</option>
													</c:forEach>
												</select>
												 [<c:out value="${product.prdtNum}"/>][<c:out value="${product.corpNm}"/>][<c:out value="${product.prdtNm}"/>]
												 <a href="javascript:fn_Dummay();"><span class="del"><img src="<c:url value="/images/web/icon/close5.gif"/>" alt="삭제"></span></a>
												<input type="hidden" name="prdtNumRC" value="${product.prdtNum}"/>
											</li>
										</c:forEach>
									</ul>
								</div>
								<br/>
								관광지/레저
								<div class="btn_sty04">
									 <span><a href="javascript:fn_viewSelectProduct('SP','C200');">상품검색</a></span>
								</div><br/>
								<div id="selectProductSPC200" style="border: 1px solid">
									<ul>
										<c:forEach  items="${kwaprdtListSPC200}" var="product">
											<input type="hidden" id="${product.prdtNum}_sort" value="${product.printSn }" />
											<li>
												<select class="printSnSPC200" id="${product.prdtNum}">
													<c:forEach var="cnt" begin="1" end="${fn:length(kwaprdtListSPC200)}">
														<option value="${cnt}" <c:if test="${cnt == product.printSn}">selected="selected"</c:if>>${cnt}</option>
													</c:forEach>
												</select>
												 [<c:out value="${product.prdtNum}"/>][<c:out value="${product.corpNm}"/>][<c:out value="${product.prdtNm}"/>]
												 <a href="javascript:fn_Dummay();"><span class="del"><img src="<c:url value="/images/web/icon/close5.gif"/>" alt="삭제"></span></a>
												<input type="hidden" name="prdtNumSPC200" value="${product.prdtNum}"/>
											</li>
										</c:forEach>
									</ul>
								</div>
								<br/>
								맛집
								<div class="btn_sty04">
									 <span><a href="javascript:fn_viewSelectProduct('SP','C300');">상품검색</a></span>
								</div><br/>
								<div id="selectProductSPC300" style="border: 1px solid">
									<ul>
										<c:forEach  items="${kwaprdtListSPC300}" var="product">
											<input type="hidden" id="${product.prdtNum}_sort" value="${product.printSn }" />
											<li>
												<select class="printSnSPC300" id="${product.prdtNum}">
													<c:forEach var="cnt" begin="1" end="${fn:length(kwaprdtListSPC300)}">
														<option value="${cnt}" <c:if test="${cnt == product.printSn}">selected="selected"</c:if>>${cnt}</option>
													</c:forEach>
												</select>
												 [<c:out value="${product.prdtNum}"/>][<c:out value="${product.corpNm}"/>][<c:out value="${product.prdtNm}"/>]
												 <a href="javascript:fn_Dummay();"><span class="del"><img src="<c:url value="/images/web/icon/close5.gif"/>" alt="삭제"></span></a>
												<input type="hidden" name="prdtNumSPC300" value="${product.prdtNum}"/>
											</li>
										</c:forEach>
									</ul>
								</div>
								<br/>
								여행사 상품
								<div class="btn_sty04">
									 <span><a href="javascript:fn_viewSelectProduct('SP','C100');">상품검색</a></span>
								</div><br/>
								<div id="selectProductSPC100" style="border: 1px solid">
									<ul>
										<c:forEach  items="${kwaprdtListSPC100}" var="product">
											<input type="hidden" id="${product.prdtNum}_sort" value="${product.printSn }" />
											<li>
												<select class="printSnSPC100" id="${product.prdtNum}">
													<c:forEach var="cnt" begin="1" end="${fn:length(kwaprdtListSPC100)}">
														<option value="${cnt}" <c:if test="${cnt == product.printSn}">selected="selected"</c:if>>${cnt}</option>
													</c:forEach>
												</select>
												 [<c:out value="${product.prdtNum}"/>][<c:out value="${product.corpNm}"/>][<c:out value="${product.prdtNm}"/>]
												 <a href="javascript:fn_Dummay();"><span class="del"><img src="<c:url value="/images/web/icon/close5.gif"/>" alt="삭제"></span></a>
												<input type="hidden" name="prdtNumSPC100" value="${product.prdtNum}"/>
											</li>
										</c:forEach>
									</ul>
								</div>
								<br/>
								유모차/카시트
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewSelectProduct('SP','C500');">상품검색</a></span>
								</div><br/>
								<div id="selectProductSPC500" style="border: 1px solid">
									<ul>
										<c:forEach  items="${kwaprdtListSPC500}" var="product">
											<input type="hidden" id="${product.prdtNum}_sort" value="${product.printSn }" />
											<li>
												<select class="printSnSPC500" id="${product.prdtNum}">
													<c:forEach var="cnt" begin="1" end="${fn:length(kwaprdtListSPC500)}">
														<option value="${cnt}" <c:if test="${cnt == product.printSn}">selected="selected"</c:if>>${cnt}</option>
													</c:forEach>
												</select>
												[<c:out value="${product.prdtNum}"/>][<c:out value="${product.corpNm}"/>][<c:out value="${product.prdtNm}"/>]
												<a href="javascript:fn_Dummay();"><span class="del"><img src="<c:url value="/images/web/icon/close5.gif"/>" alt="삭제"></span></a>
												<input type="hidden" name="prdtNumSPC500" value="${product.prdtNum}"/>
											</li>
										</c:forEach>
									</ul>
								</div>
								<br/>
								제주특산/기념품
								<div class="btn_sty04">
									 <span><a href="javascript:fn_viewSelectProduct('SV','');">상품검색</a></span>
								</div><br/>
								<div id="selectProductSV" style="border: 1px solid">
									<ul>
										<c:forEach  items="${kwaprdtListSV}" var="product">
											<input type="hidden" id="${product.prdtNum}_sort" value="${product.printSn }" />
											<li>
												<select class="printSnSV" id="${product.prdtNum}">
													<c:forEach var="cnt" begin="1" end="${fn:length(kwaprdtListSV)}">
														<option value="${cnt}" <c:if test="${cnt == product.printSn}">selected="selected"</c:if>>${cnt}</option>
													</c:forEach>
												</select>
												 [<c:out value="${product.prdtNum}"/>][<c:out value="${product.corpNm}"/>][<c:out value="${product.prdtNm}"/>]
												 <a href="javascript:fn_Dummay();"><span class="del"><img src="<c:url value="/images/web/icon/close5.gif"/>" alt="삭제"></span></a>
												<input type="hidden" name="prdtNumSV" value="${product.prdtNum}"/>
											</li>
										</c:forEach>
									</ul>
								</div>
								<br/>
							</td>
						</tr>
					</table>

					<ul class="btn_rt01 align_ct">
						<li class="btn_sty04"><a href="javascript:fn_Udt()">저장</a></li>
						<li class="btn_sty01"><a href="javascript:history.back();">뒤로</a></li>
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