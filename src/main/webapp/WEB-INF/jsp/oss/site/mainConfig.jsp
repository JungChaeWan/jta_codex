<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0"%>

<un:useConstants var="Constant" className="common.Constant" />

<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://code.jquery.com/ui/1.12.1/jquery-ui.js" ></script>

<title></title>

<script type="text/javascript">
var urlPrdtIndex = "${fn:length(mainUrlList)}";
var areaPrdtIndex = "${fn:length(mainAreaList)}";
var ctgrRcmdndex = 0;
var brandSetIndex = "${fn:length(mainBrandSet)}";
var prdtGubun = '';
var ctgrFlag = false;
var selSortClass = '';
var prdtArray = Array('AD', 'RC', 'C200', 'C300', 'C100', 'SV');

function fn_viewSelectProduct(gubun, ctgr) {
	prdtGubun = gubun;
	ctgrFlag = ctgr;
	console.log(ctgrFlag);

	window.open("<c:url value='/oss/findPrdt.do?sPrdtCd=" + gubun + "'/>","findPrdt", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");
}

function fn_viewSelectSoProduct(gubun, ctgr) {
	prdtGubun = gubun;
	ctgrFlag = ctgr;

	window.open("<c:url value='/oss/findSpPrdt.do?sCtgr=" + gubun + "'/>","findPrdt", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");
}

function fn_viewSelectSvProduct(ctgr) {
	prdtGubun = 'SV';
	ctgrFlag = ctgr;

	window.open("<c:url value='/oss/findSvPrdt.do'/>","findPrdt", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");
}

function fn_viewSelectPrmtProduct() {
	window.open("<c:url value='/oss/findPrmt.do?prmtDiv=${Constant.PRMT_DIV_PLAN}'/>","findPrdt", "width=1000, height=650, scrollbars=yes, status=no, toolbar=no;");
}

function fn_viewSelectKwaProduct() {
	prdtGubun = "Url";

	window.open("<c:url value='/oss/findKwa.do'/>","findPrdt", "width=1000, height=650, scrollbars=yes, status=no, toolbar=no;");
}

function fn_viewSelectMdsProduct() {
	prdtGubun = "Url";

	window.open("<c:url value='/oss/mdsPickListFind.do'/>","findPrdt", "width=1000, height=650, scrollbars=yes, status=no, toolbar=no;");
}

function fn_viewAdSelectProduct(area) {
	prdtGubun = area;

	window.open("<c:url value='/oss/findPrdt.do?sPrdtCd=AD&sAreaCd=" + area + "'/>","findPrdt", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");
}

function fn_viewSelectSpProduct(area, ctgr) {
	prdtGubun = area;

	window.open("<c:url value='/oss/findSpPrdt.do?sCtgr=" + ctgr + "&sAreaCd=" + area + "'/>","findPrdt", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");
}

function fn_viewSelectCorp() {
	window.open("<c:url value='/oss/findCorp.do?sCorpCd2=SV'/>","findCorp", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");
}

function fn_selectProduct(prdtId, corpNm, prdtNm, corpId) {
	if (prdtGubun == 'AD' || prdtGubun == 'RC' || prdtGubun == 'SV' || prdtGubun.indexOf('C') != -1) {
		fn_selectHotProduct(prdtId, corpNm, prdtNm);
	} else {
		fn_selectAreaProduct(prdtId, corpNm, prdtNm);
	}
}

function fn_selectHotProduct(prdtId, corpNm, prdtNm) {

	var strHtml = "";

	if (ctgrFlag == false) {
		console.log("false");
		var chkPrdtFlag = false;

		$('.selMainPrdtNum').each(function() {
			if ($(this).val() == prdtId) {
				console.log("1 in")
				chkPrdtFlag = true;
				return false;
			}
		});
		console.log("1 run");
		if (chkPrdtFlag == false) {
			strHtml = '<li>';
			strHtml += '[' + prdtId + '] [' + corpNm + '] [' + prdtNm + '] ';
			strHtml += '<a href="javascript:fn_Dummay();"><span class="del"><img src="/images/web/icon/close5.gif" alt="삭제"></span></a>';
			strHtml += '<input type="hidden" name="mainHotPrdt[' + ctgrRcmdndex + '].prdtDiv" value="' + prdtGubun + '"/>';
			strHtml += '<input type="hidden" class="selMainPrdtNum" name="mainHotPrdt[' + ctgrRcmdndex + '].prdtNum" value="' + prdtId + '"/>';
			strHtml += '<input type="hidden" class="selPrintSn" name="mainHotPrdt[' + ctgrRcmdndex + '].printSn" value="' + 0 + '"/>';
			strHtml += '</li>';

			$("#select" + "AD" + "Product ul").append(strHtml);
			ctgrRcmdndex++;
		}
	} else {
		console.log("true");
		var chkPrdtFlag = false;
		// var ctgrSort = $('.ctgr' + prdtGubun + 'Sort').length + 1;

		$('.selCtgrPrdtNum').each(function() {
			if ($(this).val() == prdtId) {
				console.log("2 in")
				chkPrdtFlag = true;
				return false;
			}
		});
		console.log("2 run")
		if (chkPrdtFlag == false) {
			strHtml = '<li>';
			strHtml += '[' + prdtId + '] [' + corpNm + '] [' + prdtNm + '] ';
			strHtml += '<a href="javascript:fn_Dummay();"><span class="del"><img src="/images/web/icon/close5.gif" alt="삭제"></span></a>';
			strHtml += '<input type="hidden" name="mainCtgrRcmd[' + ctgrRcmdndex + '].prdtDiv" value="' + prdtGubun + '"/>';
			strHtml += '<input type="hidden" name="mainCtgrRcmd[' + ctgrRcmdndex + '].prdtNum" class="selCtgrPrdtNum" value="' + prdtId + '"/>';
			strHtml += '</li>';

			$("#selectC"+ prdtGubun + "Product ul").append(strHtml);
			ctgrRcmdndex++;
		}
	}

}

function fn_selectAreaProduct(prdtId, corpNm, prdtNm) {
	var chkPrdt = false;

	$('.selAreaPrdtNum').each(function() {
		if ($(this).val() == prdtId) {
			chkPrdt = true;
			return false;
		}
	});

	if (chkPrdt == false) {
		var strHtml = '<li>';
		strHtml += '[' + prdtId + '] [' + corpNm + '] [' + prdtNm + '] ';
		strHtml += '<a href="javascript:fn_Dummay();"><span class="del"><img src="/images/web/icon/close5.gif" alt="삭제"></span></a>';
		strHtml += '<input type="hidden" name="mainAreaPrdt[' + areaPrdtIndex + '].prdtDiv" class="areaPrdt" value="' + prdtId.substring(0, 2) + '"/>';
		strHtml += '<input type="hidden" name="mainAreaPrdt[' + areaPrdtIndex + '].areaDiv" value="' + prdtGubun + '"/>';
		strHtml += '<input type="hidden" name="mainAreaPrdt[' + areaPrdtIndex + '].prdtNum" class="selAreaPrdtNum" value="' + prdtId + '"/>';
		strHtml += '</li>';

		$("#select"+ prdtGubun + "Product ul").append(strHtml);
		areaPrdtIndex++;
	}

}

function fn_Select(prmtNum, prmtNm){
	var chkPrdt = false;

	$('.selHotPrdtNum').each(function() {
		if ($(this).val() == prmtNum) {
			chkPrdt = true;
			return false;
		}
	});

	if (chkPrdt == false) {
		var strHtml = '<li>';
		strHtml += '[' + prmtNum + '] [' + prmtNm + '] ';
		strHtml += '<a href="javascript:fn_Dummay();"><span class="del"><img src="/images/web/icon/close5.gif" alt="삭제"></span></a>';
		strHtml += '<input type="hidden" name="mainHotPrdt[' + urlPrdtIndex + '].prdtDiv" value="PL"/>';
		strHtml += '<input type="hidden" name="mainHotPrdt[' + urlPrdtIndex + '].prdtNum" class="selHotPrdtNum" value="' + prmtNum + '"/>';
		strHtml += '</li>';

		$("#selectUrlProduct ul").append(strHtml);
		urlPrdtIndex++;
	}
}

function fn_SelectKw(num, location, nm) {
	var chkPrdt = false;

	$('.selHotPrdtNum').each(function() {
		if ($(this).val() == num) {
			chkPrdt = true;
			return false;
		}
	});

	if (chkPrdt == false) {
		var strHtml = '<li>';
		strHtml += '[' + num + '] [' + location + '] [' + nm + '] ';
		strHtml += '<a href="javascript:fn_Dummay();"><span class="del"><img src="/images/web/icon/close5.gif" alt="삭제"></span></a>';
		strHtml += '<input type="hidden" name="mainHotPrdt[' + urlPrdtIndex + '].prdtDiv" value="KW"/>';
		strHtml += '<input type="hidden" name="mainHotPrdt[' + urlPrdtIndex + '].prdtNum" class="selHotPrdtNum" value="' + num + '"/>';
		strHtml += '</li>';

		$("#selectUrlProduct ul").append(strHtml);
		urlPrdtIndex++;
	}
}

function fn_SelectMd(num, location, nm) {
	var chkPrdt = false;

	$('.selHotPrdtNum').each(function() {
		if ($(this).val() == num) {
			chkPrdt = true;
			return false;
		}
	});

	if (chkPrdt == false) {
		var strHtml = '<li>';
		strHtml += '[' + num + '] [' + location + '] [' + nm + '] ';
		strHtml += '<a href="javascript:fn_Dummay();"><span class="del"><img src="/images/web/icon/close5.gif" alt="삭제"></span></a>';
		strHtml += '<input type="hidden" name="mainHotPrdt[' + urlPrdtIndex + '].prdtDiv" value="MD"/>';
		strHtml += '<input type="hidden" name="mainHotPrdt[' + urlPrdtIndex + '].prdtNum" class="selHotPrdtNum" value="' + num + '"/>';
		strHtml += '</li>';

		$("#selectUrlProduct ul").append(strHtml);
		urlPrdtIndex++;
	}
}

function fn_Dummay(sortClass, curSort){
 	if (sortClass != 'undefined') {
 		$('.' + sortClass).each(function(index) {
 			if ($(this).attr('id') != $.selId) {
				$(this).val(index+1);
				$('#' + $(this).attr('id') + '_sort').val($(this).val());
			}
		});
	}
}

function fn_selSortClass(classNm) {
	selSortClass = classNm;
}


function fn_selectCorp(corpId, corpNm, corpCd, corpAliasNm) {
	var chckFlag = false;

	$('.selBrandCorpNm').each(function() {
		if ($(this).val() == corpId) {
			chckFlag = true;
			return false;
		}
	});
	
	if(corpAliasNm == null || corpAliasNm == ""){
		corpAliasNm = corpNm;
	}

	if (chckFlag == false) {
		strHtml = '<li>';
		strHtml += '[' + corpId + '] [' + corpNm + '] ';
		strHtml += '<input type="text" name="mainBrandSet[' + brandSetIndex + '].corpAliasNm" value="' + corpAliasNm + '"/>';
		strHtml += '<a href="javascript:fn_Dummay();"><span class="del"><img src="/images/web/icon/close5.gif" alt="삭제"></span></a>';
		strHtml += '<input type="hidden" name="mainBrandSet[' + brandSetIndex + '].corpId" class="selBrandCorpNm"  value="' + corpId + '"/>';
		strHtml += '<input type="hidden" name="mainBrandSet[' + brandSetIndex + '].corpCd" value="' + corpCd + '"/>';
		strHtml += '</li>';

		$("#selectBrandProduct ul").append(strHtml);
		brandSetIndex++;
	} 
}

function sortHot(){
	let hotArr = ["#hotUl1"];
	for(let i = 0; i < hotArr.length; i++){
		$(hotArr[i] + " .selPrintSn").each(function(index) {
		$(this).val(index)
	});
	}
}

$(document).ready(function(){
	$("#hotUl1").sortable({
		/*stop: function(event, ui) {
			$(this).attr("id");
			let hotUl = "#"+$(this).attr("id");
	    	$(hotUl + " .selPrintSn").each(function(index) {
				console.log($(this).val(index))
			});
		}*/
	});

	$("#sortable").disableSelection();

	ctgrRcmdndex = $('.selCtgrPrdtNum').length;
	brandSetIndex = $('.selBrandCorpNm').length;
	
	$(".selectProduct").on("click", ".del", function(index) {
		$(this).parents("li").remove();
	});

	$(".selectLiProduct").on("click", ".del", function(index) {
		$(this).parents("li").remove();
	});

	// 출력 순서의 자동 정렬
	$('.printSn').change(function() {
		$.selSort = eval($(this).val());
		$.selId = $(this).attr('id');
		$.curVal = eval($('#' + $.selId + '_sort').val());

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
	});

	$('.printSnUrl').change(function() {
		$.selSort = eval($(this).val());
		$.selId = $(this).attr('id');
		$.curVal = eval($('#' + $.selId + '_sort').val());

		if ($.selSort > $.curVal) {
			$('.printSnUrl').each(function() {
				if ($(this).attr('id') != $.selId && $(this).val() >= $.curVal && $(this).val() <= $.selSort) {
					$(this).val($(this).val() - 1);
					$('#' + $(this).attr('id') + '_sort').val($(this).val());
				}
			});
		} else if ($.selSort < $.curVal) {
			$('.printSnUrl').each(function() {
				if ($(this).attr('id') != $.selId && ($(this).val() >= $.selSort && $(this).val() <= $.curVal)) {
					$(this).val(eval($(this).val()) + 1);
					$('#' + $(this).attr('id') + '_sort').val($(this).val());
				}
			});
		}
		$('#' + $.selId + '_sort').val($(this).val());
	});

	$('.printADCtgr').change(function() {
		$.selSort = eval($(this).val());
		$.selId = $(this).attr('id');
		$.curVal = eval($('#' + $.selId + '_sort').val());

		if ($.selSort > $.curVal) {
			$('.printADCtgr').each(function() {
				if ($(this).attr('id') != $.selId && $(this).val() >= $.curVal && $(this).val() <= $.selSort) {
					$(this).val($(this).val() - 1);
					$('#' + $(this).attr('id') + '_sort').val($(this).val());
				}
			});
		} else if ($.selSort < $.curVal) {
			$('.printADCtgr').each(function() {
				if ($(this).attr('id') != $.selId && ($(this).val() >= $.selSort && $(this).val() <= $.curVal)) {
					$(this).val(eval($(this).val()) + 1);
					$('#' + $(this).attr('id') + '_sort').val($(this).val());
				}
			});
		}
		$('#' + $.selId + '_sort').val($(this).val());
	});

	$('.printRCCtgr').change(function() {
		$.selSort = eval($(this).val());
		$.selId = $(this).attr('id');
		$.curVal = eval($('#' + $.selId + '_sort').val());

		if ($.selSort > $.curVal) {
			$('.printRCCtgr').each(function() {
				if ($(this).attr('id') != $.selId && $(this).val() >= $.curVal && $(this).val() <= $.selSort) {
					$(this).val($(this).val() - 1);
					$('#' + $(this).attr('id') + '_sort').val($(this).val());
				}
			});
		} else if ($.selSort < $.curVal) {
			$('.printRCCtgr').each(function() {
				if ($(this).attr('id') != $.selId && ($(this).val() >= $.selSort && $(this).val() <= $.curVal)) {
					$(this).val(eval($(this).val()) + 1);
					$('#' + $(this).attr('id') + '_sort').val($(this).val());
				}
			});
		}
		$('#' + $.selId + '_sort').val($(this).val());
	});

	$('.printC200Ctgr').change(function() {
		$.selSort = eval($(this).val());
		$.selId = $(this).attr('id');
		$.curVal = eval($('#' + $.selId + '_sort').val());

		if ($.selSort > $.curVal) {
			$('.printC200Ctgr').each(function() {
				if ($(this).attr('id') != $.selId && $(this).val() >= $.curVal && $(this).val() <= $.selSort) {
					$(this).val($(this).val() - 1);
					$('#' + $(this).attr('id') + '_sort').val($(this).val());
				}
			});
		} else if ($.selSort < $.curVal) {
			$('.printC200Ctgr').each(function() {
				if ($(this).attr('id') != $.selId && ($(this).val() >= $.selSort && $(this).val() <= $.curVal)) {
					$(this).val(eval($(this).val()) + 1);
					$('#' + $(this).attr('id') + '_sort').val($(this).val());
				}
			});
		}
		$('#' + $.selId + '_sort').val($(this).val());
	});


	$('.printC300Ctgr').change(function() {
		$.selSort = eval($(this).val());
		$.selId = $(this).attr('id');
		$.curVal = eval($('#' + $.selId + '_sort').val());

		if ($.selSort > $.curVal) {
			$('.printC300Ctgr').each(function() {
				if ($(this).attr('id') != $.selId && $(this).val() >= $.curVal && $(this).val() <= $.selSort) {
					$(this).val($(this).val() - 1);
					$('#' + $(this).attr('id') + '_sort').val($(this).val());
				}
			});
		} else if ($.selSort < $.curVal) {
			$('.printC300Ctgr').each(function() {
				if ($(this).attr('id') != $.selId && ($(this).val() >= $.selSort && $(this).val() <= $.curVal)) {
					$(this).val(eval($(this).val()) + 1);
					$('#' + $(this).attr('id') + '_sort').val($(this).val());
				}
			});
		}
		$('#' + $.selId + '_sort').val($(this).val());
	});

	$('.printC100Ctgr').change(function() {
		$.selSort = eval($(this).val());
		$.selId = $(this).attr('id');
		$.curVal = eval($('#' + $.selId + '_sort').val());

		if ($.selSort > $.curVal) {
			$('.printC100Ctgr').each(function() {
				if ($(this).attr('id') != $.selId && $(this).val() >= $.curVal && $(this).val() <= $.selSort) {
					$(this).val($(this).val() - 1);
					$('#' + $(this).attr('id') + '_sort').val($(this).val());
				}
			});
		} else if ($.selSort < $.curVal) {
			$('.printC100Ctgr').each(function() {
				if ($(this).attr('id') != $.selId && ($(this).val() >= $.selSort && $(this).val() <= $.curVal)) {
					$(this).val(eval($(this).val()) + 1);
					$('#' + $(this).attr('id') + '_sort').val($(this).val());
				}
			});
		}
		$('#' + $.selId + '_sort').val($(this).val());
	});

	$('.printSVCtgr').change(function() {
		$.selSort = eval($(this).val());
		$.selId = $(this).attr('id');
		$.curVal = eval($('#' + $.selId + '_sort').val());

		if ($.selSort > $.curVal) {
			$('.printSVCtgr').each(function() {
				if ($(this).attr('id') != $.selId && $(this).val() >= $.curVal && $(this).val() <= $.selSort) {
					$(this).val($(this).val() - 1);
					$('#' + $(this).attr('id') + '_sort').val($(this).val());
				}
			});
		} else if ($.selSort < $.curVal) {
			$('.printSVCtgr').each(function() {
				if ($(this).attr('id') != $.selId && ($(this).val() >= $.selSort && $(this).val() <= $.curVal)) {
					$(this).val(eval($(this).val()) + 1);
					$('#' + $(this).attr('id') + '_sort').val($(this).val());
				}
			});
		}
		$('#' + $.selId + '_sort').val($(this).val());
	});
	
	$('.printBrandtgr').change(function() {
		$.selSort = eval($(this).val());
		$.selId = $(this).attr('id');
		$.curVal = eval($('#' + $.selId + '_sort').val());

		if ($.selSort > $.curVal) {
			$('.printBrandtgr').each(function() {
				if ($(this).attr('id') != $.selId && $(this).val() >= $.curVal && $(this).val() <= $.selSort) {
					$(this).val($(this).val() - 1);
					$('#' + $(this).attr('id') + '_sort').val($(this).val());
				}
			});
		} else if ($.selSort < $.curVal) {
			$('.printBrandtgr').each(function() {
				if ($(this).attr('id') != $.selId && ($(this).val() >= $.selSort && $(this).val() <= $.curVal)) {
					$(this).val(eval($(this).val()) + 1);
					$('#' + $(this).attr('id') + '_sort').val($(this).val());
				}
			});
		}
		$('#' + $.selId + '_sort').val($(this).val());
	});

});
</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=site" />
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=site&sub=main" />

		<div id="contents_area">
			<div id="contents">
				<h4 class="title03">지금 제일 잘나가는 상품 설정</h4>

				<form:form commandName="mainHotList" name="hotFrm" method="post" action="/oss/actionMainHot.do">
					<input type="hidden" name="printDiv" value="HOT" />

					<table border="1" class="table02">
						<colgroup>
							<col width="200" />
							<col width="*" />
						</colgroup>
						<tr>
							<th scope="row">상품선택</th>
							<td>
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewSelectProduct('AD', false);">숙소검색</a></span>
								</div>
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewSelectSoProduct('C100', false);">여행사검색</a></span>
								</div>
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewSelectSoProduct('C200', false);">관광지/레저검색</a></span>
								</div>
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewSelectSoProduct('C300', false);">맛집검색</a></span>
								</div>
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewSelectSvProduct(false);">특산기념품검색</a></span>
								</div>
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewSelectProduct('RC', false);">렌터카검색</a></span>
								</div>
								<br/>
								<input type="hidden" id="AD_sort" value="${sort }" />
								<br/>
								<span id="selectADProduct" class="selectProduct" style="cursor:pointer">
									<ul id="hotUl1">
										<c:forEach items="${mainHotList }" var="mainHotList" varStatus="status">
											<%--<c:if test="${mainHotList.prdtDiv eq 'AD' }">--%>
												<li>
													[${mainHotList.prdtNum}] [${mainHotList.corpNm}] [${mainHotList.prdtNm}]
													<a href="javascript:fn_Dummay();"><span class="del"><img src="/images/web/icon/close5.gif" alt="삭제"></span></a>
													<input type="hidden" name="mainHotPrdt[${status.index }].prdtDiv" value="${mainHotList.prdtDiv}"/>
													<input type="hidden" name="mainHotPrdt[${status.index }].prdtNum" class="selMainPrdtNum" value="${mainHotList.prdtNum }"/>
													<input type="hidden" name="mainHotPrdt[${status.index }].printSn" class="selPrintSn" value="${mainHotList.printSn}"/>
												</li>
											<%--</c:if>--%>
										</c:forEach>
									</ul>
								</span>
							</td>
						</tr>
						<%--<tr>
							<th>렌터카</th>
							<td>
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewSelectProduct('RC', false);">상품검색</a></span>
								</div>
								<input type="hidden" id="RC_sort" value="${sort }" />

								<span id="selectRCProduct" class="selectProduct">
									<ul id="hotUl2">
										<c:forEach items="${mainHotList }" var="mainHotList" varStatus="status">
											<c:if test="${mainHotList.prdtDiv eq 'RC' }">
												<li>
													[${mainHotList.prdtNum}] [${mainHotList.corpNm}] [${mainHotList.prdtNm}]
													<a href="javascript:fn_Dummay();"><span class="del"><img src="/images/web/icon/close5.gif" alt="삭제"></span></a>
													<input type="hidden" name="mainHotPrdt[${status.index }].prdtDiv" value="${mainHotList.prdtDiv}"/>
													<input type="hidden" name="mainHotPrdt[${status.index }].prdtNum" class="selMainPrdtNum" value="${mainHotList.prdtNum }"/>
													<input type="hidden" name="mainHotPrdt[${status.index }].printSn" class="selPrintSn" value="${mainHotList.printSn}"/>
												</li>
											</c:if>
										</c:forEach>
									</ul>
								</span>
							</td>
						</tr>
						<tr>
							<th scope="row">여행사 상품</th>
							<td>
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewSelectSoProduct('C100', false);">상품검색</a></span>
								</div>
								<input type="hidden" id="C100_sort" value="${sort }" />

								<span id="selectC100Product" class="selectProduct">
									<ul id="hotUl3">
										<c:forEach items="${mainHotList }" var="mainHotList" varStatus="status">
											<c:if test="${mainHotList.prdtDiv eq 'C100' }">
												<li>
													[${mainHotList.prdtNum}] [${mainHotList.corpNm}] [${mainHotList.prdtNm}]
													<a href="javascript:fn_Dummay();"><span class="del"><img src="/images/web/icon/close5.gif" alt="삭제"></span></a>
													<input type="hidden" name="mainHotPrdt[${status.index }].prdtDiv" value="${mainHotList.prdtDiv}"/>
													<input type="hidden" name="mainHotPrdt[${status.index }].prdtNum" class="selMainPrdtNum" value="${mainHotList.prdtNum }"/>
													<input type="hidden" name="mainHotPrdt[${status.index }].printSn" class="selPrintSn" value="${mainHotList.printSn}"/>
												</li>
											</c:if>
										</c:forEach>
									</ul>
								</span>
							</td>
						</tr>
						<tr>
							<th scope="row">관광지/레저</th>
							<td>
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewSelectSoProduct('C200', false);">상품검색</a></span>
								</div>
								<input type="hidden" id="C200_sort" value="${sort }" />

								<span id="selectC200Product" class="selectProduct">
									<ul id="hotUl4">
										<c:forEach items="${mainHotList }" var="mainHotList" varStatus="status">
											<c:if test="${mainHotList.prdtDiv eq 'C200' }">
												<li>
													[${mainHotList.prdtNum}] [${mainHotList.corpNm}] [${mainHotList.prdtNm}]
													<a href="javascript:fn_Dummay();"><span class="del"><img src="/images/web/icon/close5.gif" alt="삭제"></span></a>
													<input type="hidden" name="mainHotPrdt[${status.index }].prdtDiv" value="${mainHotList.prdtDiv}"/>
													<input type="hidden" name="mainHotPrdt[${status.index }].prdtNum" class="selMainPrdtNum" value="${mainHotList.prdtNum }"/>
													<input type="hidden" name="mainHotPrdt[${status.index }].printSn" class="selPrintSn" value="${mainHotList.printSn}"/>

												</li>
											</c:if>
										</c:forEach>
									</ul>
								</span>
							</td>
						</tr>
						<tr>
							<th>맛집</th>
							<td>
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewSelectSoProduct('C300', false);">상품검색</a></span>
								</div>
								<input type="hidden" id="C300_sort" value="${sort }" />

								<span id="selectC300Product" class="selectProduct">
									<ul id="hotUl5">
										<c:forEach items="${mainHotList }" var="mainHotList" varStatus="status">
											<c:if test="${mainHotList.prdtDiv eq 'C300' }">
												<li>
													[${mainHotList.prdtNum}] [${mainHotList.corpNm}] [${mainHotList.prdtNm}]
													<a href="javascript:fn_Dummay();"><span class="del"><img src="/images/web/icon/close5.gif" alt="삭제"></span></a>
													<input type="hidden" name="mainHotPrdt[${status.index }].prdtDiv" value="${mainHotList.prdtDiv}"/>
													<input type="hidden" name="mainHotPrdt[${status.index }].prdtNum" class="selMainPrdtNum" value="${mainHotList.prdtNum }"/>
													<input type="hidden" name="mainHotPrdt[${status.index }].printSn" class="selPrintSn" value="${mainHotList.printSn}"/>
												</li>
											</c:if>
										</c:forEach>
									</ul>
								</span>
							</td>
						</tr>
						<tr>
							<th>제주특산/기념품</th>
							<td>
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewSelectSvProduct(false);">상품검색</a></span>
								</div>
								<input type="hidden" id="SV_sort" value="${sort }" />

								<span id="selectSVProduct" class="selectProduct">
									<ul id="hotUl6">
										<c:forEach items="${mainHotList }" var="mainHotList" varStatus="status">
											<c:if test="${mainHotList.prdtDiv eq 'SV' }">
												<li>
													[${mainHotList.prdtNum}] [${mainHotList.corpNm}] [${mainHotList.prdtNm}]
													<a href="javascript:fn_Dummay();"><span class="del"><img src="/images/web/icon/close5.gif" alt="삭제"></span></a>
													<input type="hidden" name="mainHotPrdt[${status.index }].prdtDiv" value="${mainHotList.prdtDiv}"/>
													<input type="hidden" name="mainHotPrdt[${status.index }].prdtNum" class="selMainPrdtNum" value="${mainHotList.prdtNum }"/>
													<input type="hidden" name="mainHotPrdt[${status.index }].printSn" class="selPrintSn" value="${mainHotList.printSn}"/>
												</li>
											</c:if>
										</c:forEach>
									</ul>
								</span>
							</td>
						</tr>--%>
					</table>
				</form:form>

				<ul class="btn_rt01 align_ct">
					<li class="btn_sty04"><a href="javascript:sortHot();document.hotFrm.submit();">적용</a></li>
				</ul>

				<%--<h4 class="title03 margin-top45">즐거움 폭발 설정</h4>

								<form:form commandName="mainUrlList" name="prmtFrm" method="post" action="/oss/actionMainHot.do" >
									<input type="hidden" name="printDiv" value="URL" />

									<table border="1" class="table02">
										<colgroup>
											<col width="200" />
											<col width="*" />
										</colgroup>
										<tr>
											<th>관련분류</th>
											<td>
												<div class="btn_sty04">
													<span><a href="javascript:fn_viewSelectPrmtProduct();">기획전 검색</a></span>
												</div>
												<div class="btn_sty04">
													<span><a href="javascript:fn_viewSelectKwaProduct();">해시태그 검색</a></span>
												</div>
												<div class="btn_sty04">
													<span><a href="javascript:fn_viewSelectMdsProduct();">MD's Pick 검색</a></span>
												</div>
											</td>
										</tr>
										<tr>
											<th>선택</th>
											<td>
												<div id="selectUrlProduct" class="selectLiProduct">
													<ul>
														<c:forEach items="${mainUrlList }" var="url" varStatus="status">
															<input type="hidden" id="${url.prdtNum}_sort" value="${url.printSn }" />

															<li>
																<select class="printSnUrl" id="${url.prdtNum}" name="mainHotPrdt[${status.index }].printSn">
																	<c:forEach var="cnt" begin="1" end="${fn:length(mainUrlList) }">
																		<option value="${cnt}" <c:if test="${cnt == url.printSn}">selected="selected"</c:if>>${cnt}</option>
																	</c:forEach>
																</select>
																[${url.prdtNum }] <c:if test="${not empty url.corpNm }">[${url.corpNm }]</c:if> [${url.prdtNm }]
																<a href="javascript:fn_Sort('printSnUrl', '${url.printSn }');"><span class="del"><img src="/images/web/icon/close5.gif" alt="삭제"></span></a>
																<input type="hidden" name="mainHotPrdt[${status.index }].prdtDiv" value="${url.prdtDiv }"/>
																<input type="hidden" name="mainHotPrdt[${status.index }].prdtNum" class="selHotPrdtNum" value="${url.prdtNum }"/>
															</li>
														</c:forEach>
													</ul>
												</div>
											</td>
										</tr>
									</table>
								</form:form>

								<ul class="btn_rt01 align_ct">
									<li class="btn_sty04"><a href="javascript:document.prmtFrm.submit();">적용</a></li>
								</ul>--%>

				<%--<h4 class="title03 margin-top45">지역별 핫 플레이스 설정</h4>

				<form:form commandName="mainAreaList" name="areaFrm" method="post" action="/oss/actionMainArea.do">
					<table border="1" class="table02">
						<colgroup>
							<col width="200" />
							<col width="*" />
						</colgroup>
						<tr>
							<th scope="row" rowspan="2">제주시</th>
							<td>
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewAdSelectProduct('JE');">숙소 검색</a></span>
								</div>
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewSelectSpProduct('JE', 'C200');">관광지/레저 검색</a></span>
								</div>
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewSelectSpProduct('JE', 'C300');">맛집 검색</a></span>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div id="selectJEProduct" class="selectLiProduct">
									<ul>
										<c:forEach items="${mainAreaList }" var="area" varStatus="status">
											<c:if test="${area.areaDiv eq 'JE' }">
												<li>
													[${area.prdtNum}] [${area.corpNm}] [${area.prdtNm}]
													<a href="javascript:fn_Dummay();"><span class="del"><img src="/images/web/icon/close5.gif" alt="삭제"></span></a>
													<input type="hidden" name="mainAreaPrdt[${status.index }].prdtDiv" class="areaPrdt" value="${area.prdtDiv }"/>
													<input type="hidden" name="mainAreaPrdt[${status.index }].areaDiv" value="${area.areaDiv }"/>
													<input type="hidden" name="mainAreaPrdt[${status.index }].prdtNum" class="selAreaPrdtNum" value="${area.prdtNum }"/>
												</li>
											</c:if>
										</c:forEach>
									</ul>
								</div>
							</td>
						</tr>
						<tr>
							<th rowspan="2">동부권</th>
							<td>
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewAdSelectProduct('EA');">숙소 검색</a></span>
								</div>
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewSelectSpProduct('EA', 'C200');">관광지/레저 검색</a></span>
								</div>
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewSelectSpProduct('EA', 'C300');">맛집 검색</a></span>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div id="selectEAProduct" class="selectLiProduct">
									<ul>
										<c:forEach items="${mainAreaList }" var="area" varStatus="status">
											<c:if test="${area.areaDiv eq 'EA' }">
												<li>
													[${area.prdtNum}] [${area.corpNm}] [${area.prdtNm}]
													<a href="javascript:fn_Dummay();"><span class="del"><img src="/images/web/icon/close5.gif" alt="삭제"></span></a>
													<input type="hidden" name="mainAreaPrdt[${status.index }].prdtDiv" class="areaPrdt" value="${area.prdtDiv }"/>
													<input type="hidden" name="mainAreaPrdt[${status.index }].areaDiv" value="${area.areaDiv }"/>
													<input type="hidden" name="mainAreaPrdt[${status.index }].prdtNum" class="selAreaPrdtNum" value="${area.prdtNum }"/>
												</li>
											</c:if>
										</c:forEach>
									</ul>
								</div>
							</td>
						</tr>
						<tr>
							<th rowspan="2">서부권</th>
							<td>
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewAdSelectProduct('WE');">숙소 검색</a></span>
								</div>
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewSelectSpProduct('WE', 'C200');">관광지/레저 검색</a></span>
								</div>
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewSelectSpProduct('WE', 'C300');">맛집 검색</a></span>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div id="selectWEProduct" class="selectLiProduct">
									<ul>
										<c:forEach items="${mainAreaList }" var="area" varStatus="status">
											<c:if test="${area.areaDiv eq 'WE' }">
												<li>
													[${area.prdtNum}] [${area.corpNm}] [${area.prdtNm}]
													<a href="javascript:fn_Dummay();"><span class="del"><img src="/images/web/icon/close5.gif" alt="삭제"></span></a>
													<input type="hidden" name="mainAreaPrdt[${status.index }].prdtDiv" class="areaPrdt" value="${area.prdtDiv }"/>
													<input type="hidden" name="mainAreaPrdt[${status.index }].areaDiv" value="${area.areaDiv }"/>
													<input type="hidden" name="mainAreaPrdt[${status.index }].prdtNum" class="selAreaPrdtNum" value="${area.prdtNum }"/>
												</li>
											</c:if>
										</c:forEach>
									</ul>
								</div>
							</td>
						</tr>
						<tr>
							<th rowspan="2">중문/서귀포</th>
							<td>
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewAdSelectProduct('SE');">숙소 검색</a></span>
								</div>
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewSelectSpProduct('SE', 'C200');">관광지/레저 검색</a></span>
								</div>
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewSelectSpProduct('SE', 'C300');">맛집 검색</a></span>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div id="selectSEProduct" class="selectLiProduct">
									<ul>
										<c:forEach items="${mainAreaList }" var="area" varStatus="status">
											<c:if test="${area.areaDiv eq 'SE' }">
												<li>
													[${area.prdtNum}] [${area.corpNm}] [${area.prdtNm}]
													<a href="javascript:fn_Dummay();"><span class="del"><img src="/images/web/icon/close5.gif" alt="삭제"></span></a>
													<input type="hidden" name="mainAreaPrdt[${status.index }].prdtDiv" class="areaPrdt" value="${area.prdtDiv }"/>
													<input type="hidden" name="mainAreaPrdt[${status.index }].areaDiv" value="${area.areaDiv }"/>
													<input type="hidden" name="mainAreaPrdt[${status.index }].prdtNum" class="selAreaPrdtNum" value="${area.prdtNum }"/>
												</li>
											</c:if>
										</c:forEach>
									</ul>
								</div>
							</td>
						</tr>
					</table>
				</form:form>

				<ul class="btn_rt01 align_ct">
					<li class="btn_sty04"><a href="javascript:document.areaFrm.submit();">적용</a></li>
				</ul>--%>

				<h4 class="title03 margin-top45">카테고리 추천 상품 설정</h4>

				<form:form commandName="mainCtgrRcmdList" name="ctgrRcmdFrm" method="post" action="/oss/actionCtgrRcmd.do">
					<table border="1" class="table02">
						<colgroup>
							<col width="200" />
							<col width="*" />
						</colgroup>
						<tr>
							<th scope="row" rowspan="2">숙소</th>
							<td>
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewSelectProduct('AD', true);">상품 검색</a></span>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div id="selectCADProduct" class="selectLiProduct">
									<ul>
										<c:forEach items="${mainCtgrRcmdList.AD }" var="rcmd" varStatus="status">
											<input type="hidden" id="AD_${rcmd.prdtNum}_sort" class="ctgrADSort" value="${rcmd.printSn }" />

											<li>
												<select class="printADCtgr" id="AD_${rcmd.prdtNum}" name="mainCtgrRcmd[${status.index }].printSn">
													<c:forEach var="cnt" begin="1" end="${fn:length(mainCtgrRcmdList.AD) }">
														<option value="${cnt}" <c:if test="${cnt == rcmd.printSn}">selected="selected"</c:if>>${cnt}</option>
													</c:forEach>
												</select>
												[${rcmd.prdtNum}] [${rcmd.corpNm}] [${rcmd.prdtNm}]
												<a href="javascript:fn_Dummay('printADCtgr', '${rcmd.printSn }');"><span class="del"><img src="/images/web/icon/close5.gif" alt="삭제"></span></a>
												<c:if test="${rcmd.tradeStatus ne Constant.TRADE_STATUS_APPR}">
													<span class="font_red"> - 승인 상품 아님!!! - </span>
												</c:if>
												<input type="hidden" name="mainCtgrRcmd[${status.index }].prdtDiv" value="${rcmd.prdtDiv }"/>
												<input type="hidden" name="mainCtgrRcmd[${status.index }].prdtNum" class="selCtgrPrdtNum" value="${rcmd.prdtNum }"/>
											</li>
										</c:forEach>
									</ul>
								</div>
							</td>
						</tr>
						<c:set var="ctgrLength" value="${fn:length(mainCtgrRcmdList.AD) }" />
						<tr>
							<th scope="row" rowspan="2">렌터카</th>
							<td>
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewSelectProduct('RC', true);">상품 검색</a></span>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div id="selectCRCProduct" class="selectLiProduct">
									<ul>
										<c:forEach items="${mainCtgrRcmdList.RC }" var="rcmd" varStatus="status">
											<input type="hidden" id="RC_${rcmd.prdtNum}_sort" class="ctgrRCSort" value="${rcmd.printSn }" />

											<li>
												<select class="printRCCtgr" id="RC_${rcmd.prdtNum}" name="mainCtgrRcmd[${ctgrLength + status.index }].printSn">
													<c:forEach var="cnt" begin="1" end="${fn:length(mainCtgrRcmdList.RC) }">
														<option value="${cnt}" <c:if test="${cnt == rcmd.printSn}">selected="selected"</c:if>>${cnt}</option>
													</c:forEach>
												</select>
												[${rcmd.prdtNum}] [${rcmd.corpNm}] [${rcmd.prdtNm}]
												<a href="javascript:fn_Dummay('printRCCtgr', '${rcmd.printSn }');"><span class="del"><img src="/images/web/icon/close5.gif" alt="삭제"></span></a>
												<c:if test="${rcmd.tradeStatus ne Constant.TRADE_STATUS_APPR}">
													<span class="font_red"> - 승인 상품 아님!!! - </span>
												</c:if>
												<input type="hidden" name="mainCtgrRcmd[${ctgrLength + status.index }].prdtDiv" value="${rcmd.prdtDiv }"/>
												<input type="hidden" name="mainCtgrRcmd[${ctgrLength + status.index }].prdtNum" class="selCtgrPrdtNum" value="${rcmd.prdtNum }"/>
											</li>
										</c:forEach>
									</ul>
								</div>
							</td>
						</tr>
						<c:set var="ctgrLength" value="${ctgrLength + fn:length(mainCtgrRcmdList.RC) }" />
						<tr>
							<th scope="row" rowspan="2">여행사상품</th>
							<td>
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewSelectSoProduct('C100', true);">상품 검색</a></span>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div id="selectCC100Product" class="selectLiProduct">
									<ul>
										<c:forEach items="${mainCtgrRcmdList.C100 }" var="rcmd" varStatus="status">
											<input type="hidden" id="C100_${rcmd.prdtNum}_sort" class="ctgrC100Sort" value="${rcmd.printSn }" />

											<li>
												<select class="printC100Ctgr" id="C100_${rcmd.prdtNum}" name="mainCtgrRcmd[${ctgrLength + status.index }].printSn">
													<c:forEach var="cnt" begin="1" end="${fn:length(mainCtgrRcmdList.C100) }">
														<option value="${cnt}" <c:if test="${cnt == rcmd.printSn}">selected="selected"</c:if>>${cnt}</option>
													</c:forEach>
												</select>
												[${rcmd.prdtNum}] [${rcmd.corpNm}] [${rcmd.prdtNm}]
												<a href="javascript:fn_Dummay('printC100Ctgr', '${rcmd.printSn }');"><span class="del"><img src="/images/web/icon/close5.gif" alt="삭제"></span></a>
												<c:if test="${rcmd.tradeStatus ne Constant.TRADE_STATUS_APPR}">
													<span class="font_red"> - 승인 상품 아님!!! - </span>
												</c:if>
												<input type="hidden" name="mainCtgrRcmd[${ctgrLength + status.index }].prdtDiv" value="${rcmd.prdtDiv }"/>
												<input type="hidden" name="mainCtgrRcmd[${ctgrLength + status.index }].prdtNum" class="selCtgrPrdtNum" value="${rcmd.prdtNum }"/>
											</li>
										</c:forEach>
									</ul>
								</div>
							</td>
						</tr>
						<c:set var="ctgrLength" value="${ctgrLength + fn:length(mainCtgrRcmdList.C100) }" />
						<tr>
							<th scope="row" rowspan="2">관광지/레저</th>
							<td>
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewSelectSoProduct('C200', true);">상품 검색</a></span>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div id="selectCC200Product" class="selectLiProduct">
									<ul>
										<c:forEach items="${mainCtgrRcmdList.C200 }" var="rcmd" varStatus="status">
											<input type="hidden" id="C200_${rcmd.prdtNum}_sort" class="ctgrC200Sort" value="${rcmd.printSn }" />

											<li>
												<select class="printC200Ctgr" id="C200_${rcmd.prdtNum}" name="mainCtgrRcmd[${ctgrLength + status.index }].printSn">
													<c:forEach var="cnt" begin="1" end="${fn:length(mainCtgrRcmdList.C200) }">
														<option value="${cnt}" <c:if test="${cnt == rcmd.printSn}">selected="selected"</c:if>>${cnt}</option>
													</c:forEach>
												</select>
												[${rcmd.prdtNum}] [${rcmd.corpNm}] [${rcmd.prdtNm}]
												<a href="javascript:fn_Dummay('printC200Ctgr', '${rcmd.printSn }');"><span class="del"><img src="/images/web/icon/close5.gif" alt="삭제"></span></a>
												<c:if test="${rcmd.tradeStatus ne Constant.TRADE_STATUS_APPR}">
													<span class="font_red"> - 승인 상품 아님!!! - </span>
												</c:if>
												<input type="hidden" name="mainCtgrRcmd[${ctgrLength + status.index }].prdtDiv" value="${rcmd.prdtDiv }"/>
												<input type="hidden" name="mainCtgrRcmd[${ctgrLength + status.index }].prdtNum" class="selCtgrPrdtNum" value="${rcmd.prdtNum }"/>
											</li>
										</c:forEach>
									</ul>
								</div>
							</td>
						</tr>
						<c:set var="ctgrLength" value="${ctgrLength + fn:length(mainCtgrRcmdList.C200) }" />
						<tr>
							<th scope="row" rowspan="2">맛집</th>
							<td>
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewSelectSoProduct('C300', true);">상품 검색</a></span>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div id="selectCC300Product" class="selectLiProduct">
									<ul>
										<c:forEach items="${mainCtgrRcmdList.C300 }" var="rcmd" varStatus="status">
											<input type="hidden" id="C300_${rcmd.prdtNum}_sort" class="ctgrC300Sort" value="${rcmd.printSn }" />

											<li>
												<select class="printC300Ctgr" id="C300_${rcmd.prdtNum}" name="mainCtgrRcmd[${ctgrLength + status.index }].printSn">
													<c:forEach var="cnt" begin="1" end="${fn:length(mainCtgrRcmdList.C300) }">
														<option value="${cnt}" <c:if test="${cnt == rcmd.printSn}">selected="selected"</c:if>>${cnt}</option>
													</c:forEach>
												</select>
												[${rcmd.prdtNum}] [${rcmd.corpNm}] [${rcmd.prdtNm}]
												<a href="javascript:fn_Dummay('printC300Ctgr', '${rcmd.printSn }');"><span class="del"><img src="/images/web/icon/close5.gif" alt="삭제"></span></a>
												<c:if test="${rcmd.tradeStatus ne Constant.TRADE_STATUS_APPR}">
													<span class="font_red"> - 승인 상품 아님!!! - </span>
												</c:if>
												<input type="hidden" name="mainCtgrRcmd[${ctgrLength + status.index }].prdtDiv" value="${rcmd.prdtDiv }"/>
												<input type="hidden" name="mainCtgrRcmd[${ctgrLength + status.index }].prdtNum" class="selCtgrPrdtNum" value="${rcmd.prdtNum }"/>
											</li>
										</c:forEach>
									</ul>
								</div>
							</td>
						</tr>
						<c:set var="ctgrLength" value="${ctgrLength + fn:length(mainCtgrRcmdList.C300) }" />
						<tr>
							<th scope="row" rowspan="2">제주특산/기념품</th>
							<td>
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewSelectSvProduct(true);">상품 검색</a></span>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div id="selectCSVProduct" class="selectLiProduct">
									<ul>
										<c:forEach items="${mainCtgrRcmdList.SV }" var="rcmd" varStatus="status">
											<input type="hidden" id="SV_${rcmd.prdtNum}_sort" class="ctgrSVSort" value="${rcmd.printSn }" />

											<li>
												<select class="printSVCtgr" id="SV_${rcmd.prdtNum}" name="mainCtgrRcmd[${ctgrLength + status.index }].printSn">
													<c:forEach var="cnt" begin="1" end="${fn:length(mainCtgrRcmdList.SV) }">
														<option value="${cnt}" <c:if test="${cnt == rcmd.printSn}">selected="selected"</c:if>>${cnt}</option>
													</c:forEach>
												</select>
												[${rcmd.prdtNum}] [${rcmd.corpNm}] [${rcmd.prdtNm}]
												<a href="javascript:fn_Dummay('printSVCtgr', '${rcmd.printSn }');"><span class="del"><img src="/images/web/icon/close5.gif" alt="삭제"></span></a>
												<c:if test="${rcmd.tradeStatus ne Constant.TRADE_STATUS_APPR}">
													<span class="font_red"> - 승인 상품 아님!!! - </span>
												</c:if>
												<input type="hidden" name="mainCtgrRcmd[${ctgrLength + status.index }].prdtDiv" value="${rcmd.prdtDiv }"/>
												<input type="hidden" name="mainCtgrRcmd[${ctgrLength + status.index }].prdtNum" class="selCtgrPrdtNum" value="${rcmd.prdtNum }"/>
											</li>
										</c:forEach>
									</ul>
								</div>
							</td>
						</tr>	
					</table>
				</form:form>

				<ul class="btn_rt01 align_ct">
					<li class="btn_sty04"><a href="javascript:document.ctgrRcmdFrm.submit();">적용</a></li>
				</ul>
			</div>
		</div>
	</div>
</div>
</body>
</html>