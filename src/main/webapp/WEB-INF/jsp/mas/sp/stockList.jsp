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
 <head><meta http-equiv="X-UA-Compatible" content="IE=edge" />
 
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<link rel="stylesheet" type="text/css"href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<title>탐나오 관리자 시스템 > 상품관리 > 재고관리</title>

<script type="text/javascript">
function fn_Search() {
	document.frm.action="<c:url value='/mas/sp/stockList.do'/>";
	document.frm.submit();
}

function stockValidator(prdtNum, spDivSn, spOptSn) {
	if(isNull(prdtNum)) {
		alert("<spring:message code='fail.common.msg'/>");
		return false;
	}
	if(isNull(spDivSn)) {
		alert("<spring:message code='fail.common.msg'/>");
		return false;
	}
	if(isNull(spOptSn)) {
		alert("<spring:message code='fail.common.msg'/>");
		return false;
	}
	
	return true;
}


function fn_calStockNum(prdtNum, spDivSn, spOptSn, stockNum) {
	if(!stockValidator(prdtNum, spDivSn, spOptSn) ) {
		return ;
	}
	if(isNull(stockNum)) {
		alert("<spring:message code='fail.common.msg'/>");
		return ;
	}
	if(isNull($("#stockNum_" +spDivSn+"_"+ spOptSn).val())) {
		alert("수량을 입력해 주세요.");
		$("#stockNum_" +spDivSn+"_"+ spOptSn).focus();
		return ;
	}
	
	var regExp = /^[+|-]?[0-9]+$/i;
	if(!regExp.test($("#stockNum_" +spDivSn+"_"+ spOptSn).val())) {
		alert(" 수량은 1, +1, -1 형식이어야 합니다.");
		$("#stockNum_" +spDivSn+"_"+ spOptSn).focus();
		return ;
	}
	
	var num =parseInt( $("#stockNum_" +spDivSn+"_"+ spOptSn).val()) + parseInt(stockNum);
	if( num < 0) {
		alert("수량감소는 잔여수량만큼 할 수 있습니다.");
		$("#stockNum_" +spDivSn+"_"+ spOptSn).focus();
		return ;
	}
	$.ajax({
		url : "<c:url value='/mas/sp/updateOptStock.ajax'/>",
		data :"prdtNum="+ prdtNum + "&spDivSn="+ spDivSn + "&spOptSn="+spOptSn +"&optPrdtNum=" + $("#stockNum_" +spDivSn+"_"+ spOptSn).val() ,
		dataType:"json",
		success: function(data) {
			fn_Search();
		},
		error :fn_AjaxError
	});
}

function fn_optSoldOut(prdtNum, spDivSn, spOptSn) {
	if(!stockValidator(prdtNum, spDivSn, spOptSn) ) {
		return ;
	}
	$.ajax({
		url : "<c:url value='/mas/sp/updateOptSoldOut.ajax'/>",
		data :"prdtNum="+ prdtNum + "&spDivSn="+ spDivSn + "&spOptSn="+spOptSn ,
		dataType:"json",
		success: function(data) {
			fn_Search();
		},
		error :fn_AjaxError
	});
}

function fn_optSale(prdtNum, spDivSn, spOptSn) {
	if(!stockValidator(prdtNum, spDivSn, spOptSn) ) {
		return ;
	}
	$.ajax({
		url : "<c:url value='/mas/sp/updateOptSale.ajax'/>",
		data :"prdtNum="+ prdtNum + "&spDivSn="+ spDivSn + "&spOptSn="+spOptSn ,
		dataType:"json",
		success: function(data) {
			fn_Search();
		},
		error :fn_AjaxError
	})
}

$(document).ready(function() {
	$('#searchBox').on('keyup', function() {
		const searchTerm = $(this).val().toLowerCase();
		$('#sPrdtNum option').each(function() {
			const optionText = $(this).text().toLowerCase();
			if (optionText.indexOf(searchTerm) > -1 || $(this).val() === "") {
				$(this).show(); // 검색어와 일치하면 표시
			} else {
				$(this).hide();
			}
		});
	});
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
					<form name="frm" method="get" onSubmit="return false;">
						<!--검색-->
						<div class="search_box">
							<div class="search_form">
								<div class="tb_form">
									<table width="100%" border="0">
										<colgroup>
											<col width="100" />
                               				<col width="*" />
										</colgroup>
										<tbody>
											<tr>
												<th scope="row"><span class="tb_search_title">상품</span></th>
												<td>
													<select name="sPrdtNum" id="sPrdtNum" style="width: 300px;">
														<c:if test="${fn:length(sPrdtList) == 0}">
															<option value="">선택 해 주세요</option>
														</c:if>
														<c:forEach items="${sPrdtList}" var="prdtInfo">
															<option value="${prdtInfo.prdtNum}" <c:if test="${searchVO.sPrdtNum eq prdtInfo.prdtNum}">selected="selected"</c:if>>
																<c:out value="${prdtInfo.prdtNm}"/>
															</option>
														</c:forEach>
													</select><br/>
													<input type="text" id="searchBox" placeholder="상품명 검색..." style="width: 300px; margin-bottom: 10px;" />
												</td>
												<th scope="row"><span class="tb_search_title">정렬순서</span></th>
												<td>
													<select name="sOrderCd" id="sOrderCd">
														<option value="VIEWSN" <c:if test="${searchVO.sOrderCd eq 'VIEWSN'}">selected="selected"</c:if>>정렬순서</option>
														<option value="APLDT" <c:if test="${searchVO.sOrderCd eq 'APLDT'}">selected="selected"</c:if>>날짜순서</option>
													</select>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
								<c:if test="${fn:length(sPrdtList) > 0}">
								<span class="btn"> <input type="image" src="<c:url value='/images/oss/btn/search_btn01.gif'/>" alt="검색" onclick="javascript:fn_Search('1')" />
								</c:if>
								</span>
							</div>
						</div>
					</form>
						<table width="100%" border="1" cellspacing="0" cellpadding="0"
							class="table01 list_tb">
							<thead>
								<tr>
									<th>상품구분</th>
									<th>옵션명</th>
									<th>판매금액</th>
									<th>최대수량</th>
									<th>판매수량</th>
									<th>잔여수량</th>
									<th>수량추가</th>
									<th>품절처리</th>
								</tr>
							</thead>
							<tbody>
								<!-- 데이터 없음 -->
								<c:if test="${fn:length(stockList) == 0}">
									<tr>
										<td colspan="8" class="align_ct"><spring:message
												code="info.nodata.msg" /></td>
									</tr>
								</c:if>
								<c:forEach var="optInf" items="${stockList}"	varStatus="status">
									<tr style="cursor: pointer;">
										<td class="align_ct"><c:out value="${optInf.prdtDivNm }"/></td>
										<td class="align_lt"><c:out value="${optInf.optNm}"/>
										<c:if test="${not empty optInf.aplDt }">
										| <fmt:parseDate value="${optInf.aplDt }" var="aplDt" pattern="yyyyMMdd" />
										<fmt:formatDate value="${aplDt}" pattern="yyyy-MM-dd" />
										</c:if>
										</td>
										<td class="align_rt"><fmt:formatNumber value="${optInf.saleAmt}" type="number" /></td>
										<td class="align_ct"><fmt:formatNumber value="${optInf.optPrdtNum}" type="number" /></td>
										<td class="align_ct"><fmt:formatNumber value="${optInf.saleNum }" type="number"/></td>
										<td class="align_ct"><fmt:formatNumber value="${optInf.optPrdtNum - optInf.saleNum}" type="number" /></td>
										<td class="align_ct">
											<c:if test="${optInf.ddlYn eq Constant.FLAG_N}">
											<input type="text" class="input_text3" id="stockNum_${optInf.spDivSn}_${optInf.spOptSn}"/><div class="btn_sty06"><span><a href="javascript:fn_calStockNum('${optInf.prdtNum}','${optInf.spDivSn}', '${optInf.spOptSn}', '${optInf.optPrdtNum- optInf.saleNum}');">추가</a></span></div>
											</c:if>
											<c:if test="${optInf.ddlYn eq Constant.FLAG_Y}">
											품절상태
											</c:if>
										</td>
										<td class="align_ct">
											<c:if test="${optInf.ddlYn eq Constant.FLAG_N}">
											<div class="btn_sty06"><span><a href="javascript:fn_optSoldOut('${optInf.prdtNum}','${optInf.spDivSn}', '${optInf.spOptSn}')">품절</a></span></div>
											</c:if>
											<c:if test="${optInf.ddlYn eq Constant.FLAG_Y}">
											<div class="btn_sty06"><span><a href="javascript:fn_optSale('${optInf.prdtNum}','${optInf.spDivSn}', '${optInf.spOptSn}')">판매</a></span></div>
											</c:if>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
			</div>
		</div>
	</div>
</body>
</html>