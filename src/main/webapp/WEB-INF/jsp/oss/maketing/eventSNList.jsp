<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="un"		uri="http://jakarta.apache.org/taglibs/unstandard-1.0"%>

<un:useConstants var="Constant" className="common.Constant" />

<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">
function fn_Select(prmtNum, prmtNm){
	//alert(prmtNum + ":" + prmtNm);
	$('#prmtNmT').val(prmtNm);
	$('#prmtNumT').val(prmtNum);
}

function fn_InsPrmt(){
	if($('#prmtNumT').val().length == 0){
		alert("프로모션을 검색하여 주세요.");
		return;
	}
	$('#prmtNum').val( $('#prmtNumT').val() )
	$('#printSn').val( $('#printSnT').val() )
	//alert($('#prmtNum').val() +" : "+ $('#printSn').val());
	document.frm.action = "<c:url value='/oss/mainPrmtReg.do'/>";
	document.frm.submit();
}

/**
 * 순번 변경
 */
function fn_snOnchange(obj, sn_old, prmtNum){
	document.frm.newSn.value = obj.value;
	document.frm.oldSn.value = sn_old;
	document.frm.prmtNum.value = prmtNum;
	document.frm.action = "<c:url value='/oss/mainPrmtMod.do'/>";
	document.frm.submit();
}

/**
 * 이미지 삭제
 */
function fn_delPrmt(printSn, prmtNum){
	if(confirm("삭제 하시겠습니까?") ){
		document.frm.printSn.value = printSn;
		document.frm.prmtNum.value = prmtNum;
		document.frm.action = "<c:url value='/oss/mainPrmtDel.do'/>";
		document.frm.submit();
	}
}

function fn_Find(){
	window.open("<c:url value='/oss/findPrmt.do'/>","findUser", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");
}

$(document).ready(function(){
	if('${MAINPRMTVO.err}' == '1'){
		alert("등록된 프로모션 중에 같은 것이 있습니다.");
	}

	$(".randomBtn").click(function(){
		let th = $(this);
		//randomYN값 toggle
		if(th.data("snrandomyn") == "Y"){
			th.data("snrandomyn", "N")
		}
		else if(th.data("snrandomyn") == "N"){
			th.data("snrandomyn", "Y")
		}
		var parameters = "prmtNum=" + th.data("prmtnum")  + "&snRandomYn=" +th.data("snrandomyn");
		$.ajax({
			type:"post",
			dataType:"json",
			async:false,
			url:"<c:url value='/oss/mainPrmtSnRandom.ajax'/>",
			data:parameters ,
			success:function(data){
				if(data.MAINPRMTVO.snRandomYn == "Y"){
					th.closest("div").attr("class","btn_sty06");
				}else {
					th.closest("div").attr("class","btn_sty08");
				}
			}
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
		<jsp:include page="/oss/left.do?menu=site&sub=event" flush="false"></jsp:include>
		<div id="contents_area">
			<div id="contents">
				<form name="frm" method="get" onSubmit="return false;">
					<input type="hidden" name="newSn" value="0"/>
					<input type="hidden" name="oldSn" value="0"/>	
					<input type="hidden" name="prmtNum" id="prmtNum" />
					<input type="hidden" name="printSn" id="printSn" />
										
					<div id="menu_depth3">
						<ul>
				            <li><a class="menu_depth3" href="<c:url value='/oss/eventList.do'/>">프로모션</a></li>
			              	<li class="on"><a class="menu_depth3" href="<c:url value='/oss/eventSNList.do'/>">메인 프로모션</a></li>
			              	<li><a class="menu_depth3" href="<c:url value='/oss/eventSvList.do'/>">제주특산/기념품 프로모션</a></li>
		                </ul>
		            </div>

					<p class="search_list_ps title03">메인 프로모션 [총 <strong>${totalCnt}</strong>건]</p> <!--리스트 검색 건수-->
					<div class="list">
						<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
							<thead>
								<tr>
									<th>프로모션번호</th>
									<th>프로모션명</th>
									<th>업체명</th>
									<th>적용기간</th>
									<th>거래상태</th>
									<th>상태</th>
									<th>등록일</th>
									<th>순번</th>
									<th>삭제</th>
								</tr>
							</thead>
							<tbody>
								<!-- 데이터 없음 -->
								<c:if test="${fn:length(resultList) == 0}">
									<tr>
										<td colspan="9" class="align_ct"><spring:message code="common.nodata.msg" /></td>
									</tr>
								</c:if>

								<c:forEach var="prmt" items="${resultList}" varStatus="status">
									<tr >
										<td class="align_ct"><c:out value="${prmt.prmtNum}" /></td>
										<td><c:out value="${prmt.prmtNm}"/></td>
										<td><c:out value="${prmt.corpNm}"/></td>
										<td class="align_ct">
											<fmt:parseDate value="${prmt.startDt}" var="startDt" pattern="yyyyMMdd" />
											<fmt:parseDate value="${prmt.endDt}" var="endDt" pattern="yyyyMMdd" />
											<fmt:formatDate value="${startDt}" pattern="yyyy-MM-dd" />~<fmt:formatDate value="${endDt}" pattern="yyyy-MM-dd" />
										</td>
										<td class="align_ct">
											<c:if test="${Constant.TRADE_STATUS_REG eq prmt.statusCd}">등록중</c:if>
											<c:if test="${Constant.TRADE_STATUS_APPR_REQ eq prmt.statusCd}">승인요청</c:if>
											<c:if test="${Constant.TRADE_STATUS_APPR eq prmt.statusCd}">승인</c:if>
											<c:if test="${Constant.TRADE_STATUS_APPR_REJECT eq prmt.statusCd}">승인거절</c:if>
											<c:if test="${Constant.TRADE_STATUS_STOP eq prmt.statusCd}">판매중지</c:if>
										</td>
										<td class="align_ct">
											<c:if test="${prmt.endEvent == 'Y'}">마감</c:if>
											<c:if test="${prmt.endEvent == 'N'}">진행</c:if>
										</td>
										<td class="align_ct">
											<fmt:parseDate value="${prmt.frstRegDttm}" var="frstRegDttm" pattern="yyyy-MM-dd" />
											<fmt:formatDate value="${frstRegDttm}" pattern="yyyy-MM-dd" />
										</td>
										<td class="align_ct">
											<select name="sn_new" onchange="fn_snOnchange(this, ${prmt.printSn}, '${prmt.prmtNum}')">
												<c:forEach var="cnt" begin="1" end="${totalCnt}">
													<option value="${cnt}" <c:if test="${cnt == prmt.printSn}">selected="selected"</c:if>>${cnt}</option>
												</c:forEach>
											</select>
											<div <c:if test="${prmt.snRandomYn == 'Y'}">class="btn_sty06"</c:if>
												 <c:if test="${prmt.snRandomYn == 'N'}">class="btn_sty08"</c:if>>
												<span><a href="javascript:void(0);" class="randomBtn" data-prmtnum="${prmt.prmtNum}" data-snrandomyn="${prmt.snRandomYn}">랜덤</a></span>
											</div>
										</td>
										<td class="align_ct">
											<div class="btn_sty09"><span><a href="javascript:fn_delPrmt('${prmt.printSn}', '${prmt.prmtNum}', 'Y')">삭제</a></span></div>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>

					<div class="register_area">
						<table border="1" class="table02">
							<colgroup>
								<col width="230" />
								<col width="*" />
							</colgroup>
							<tr>
								<th scope="row">프로모션 추가</th>
								<td>
									<input type="hidden" name='prmtNumT' id='prmtNumT' />
									<input type="hidden" name='printSnT' id='printSnT' value="${totalCnt+1}" />
									프로모션명:
									<li class="btn_sty02"><a href="javascript:fn_Find()">검색</a></li>
									<input type="text" name="prmtNmT" id="prmtNmT" class="input_text30" readonly="readonly" />
									<li class="btn_sty04"><a href="javascript:fn_InsPrmt()">등록</a></li>
								</td>
							</tr>
						</table>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
</body>
</html>