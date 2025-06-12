<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="un"	uri="http://jakarta.apache.org/taglibs/unstandard-1.0"%>

<un:useConstants var="Constant" className="common.Constant" />

<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />

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

/**
 * 조회 & 페이징
 */
function fn_Search(pageIndex) {
	document.frm.pageIndex.value = pageIndex;
	//$("#sYYYYMM").val( $("#sYYYY").val() + $("#sMM").val()  );

	$('#sFindYn').val("Y");

	$('#sProcStdS').val($('#sProcStdS').val().replace(/-/g, ''));
	$('#sProcStdE').val($('#sProcStdE').val().replace(/-/g, ''));
	$('#sBuyDateS').val($('#sBuyDateS').val().replace(/-/g, ''));
	$('#sBuyDateE').val($('#sBuyDateE').val().replace(/-/g, ''));


	document.frm.action = "<c:url value='/oss/userCate.do'/>";
	document.frm.submit();
}


function fn_CateAll(bFlas){
	$("input[name=sCate]:checkbox").each(function() {
		$(this).prop("checked", bFlas);
	});

}

function fn_BuyDateReset(){
	$("#sBuyDateS").val("");
	$("#sBuyDateE").val("");
}


function fn_SendSMS(){

	$('#sFindYn').val("Y");

	$('#sProcStdS').val($('#sProcStdS').val().replace(/-/g, ''));
	$('#sProcStdE').val($('#sProcStdE').val().replace(/-/g, ''));
	$('#sBuyDateS').val($('#sBuyDateS').val().replace(/-/g, ''));
	$('#sBuyDateE').val($('#sBuyDateE').val().replace(/-/g, ''));


	document.frm.action = "<c:url value='/oss/smsForm.do'/>";
	document.frm.submit();

}

function fn_SendMail(){

	$('#sFindYn').val("Y");

	$('#sProcStdS').val($('#sProcStdS').val().replace(/-/g, ''));
	$('#sProcStdE').val($('#sProcStdE').val().replace(/-/g, ''));
	$('#sBuyDateS').val($('#sBuyDateS').val().replace(/-/g, ''));
	$('#sBuyDateE').val($('#sBuyDateE').val().replace(/-/g, ''));


	document.frm.action = "<c:url value='/oss/emailForm.do'/>";
	document.frm.submit();

}



$(document).ready(function(){

	$("#sProcStdS").datepicker({
		onClose : function(selectedDate) {
			$("#sProcStdE").datepicker("option", "minDate", selectedDate);
		}
	});
	$("#sProcStdE").datepicker({
		onClose : function(selectedDate) {
			$("#sProcStdS").datepicker("option", "maxDate", selectedDate);
		}
	});

	$("#sBuyDateS").datepicker({
		onClose : function(selectedDate) {
			$("#sBuyDateE").datepicker("option", "minDate", selectedDate);
		}
	});
	$("#sBuyDateE").datepicker({
		onClose : function(selectedDate) {
			$("#sBuyDateS").datepicker("option", "maxDate", selectedDate);
		}
	});

});

</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=maketing" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=maketing&sub=userCate" flush="false"></jsp:include>
		<div id="contents_area">
			<div id="contents_area">
				<div id="contents">
					<form name="frm" method="get" onSubmit="return false;">
						<input type="hidden" id="sFindYn" name="sFindYn" value="${USERCATEVO.sFindYn}"/>
						<input type="hidden" id="pageIndex" name="pageIndex" value="${USERCATEVO.pageIndex}" />

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
			               						<th scope="row">분석기준</th>
			               						<td colspan="1">
			               							<fmt:parseDate value='${USERCATEVO.sProcStdS}' var='sProcStdS'	pattern="yyyymmdd" scope="page" />
													<input type="text" id="sProcStdS" class="input_text5" name="sProcStdS" value="<fmt:formatDate value="${sProcStdS}" pattern="yyyy-mm-dd"/>" title="" readonly="readonly" />
													~
													<fmt:parseDate value='${USERCATEVO.sProcStdE}' var='sProcStdE'	pattern="yyyymmdd" scope="page" />
													<input type="text" id="sProcStdE" class="input_text5" name="sProcStdE" value="<fmt:formatDate value="${sProcStdE}" pattern="yyyy-mm-dd"/>" title="" readonly="readonly"/>
			               						</td>

			               						<th scope="row">성별</th>
			               						<td colspan="1">

													<select id="sSex" name="sSex">
														<option value="">전체</option>
														<option value="M" <c:if test="${USERCATEVO.sSex=='M' }">selected="selected"</c:if> >남</option>
														<option value="F" <c:if test="${USERCATEVO.sSex=='F' }">selected="selected"</c:if> >여</option>
													</select>
			               						</td>

			               						<th scope="row">연령</th>
			               						<td colspan="1" >
													<select id="sAge" name="sAge">
														<option value="">전체</option>
														<option value="10" <c:if test="${USERCATEVO.sAge=='10' }">selected="selected"</c:if> >10대</option>
														<option value="20" <c:if test="${USERCATEVO.sAge=='20' }">selected="selected"</c:if> >20대</option>
														<option value="30" <c:if test="${USERCATEVO.sAge=='30' }">selected="selected"</c:if> >30대</option>
														<option value="40" <c:if test="${USERCATEVO.sAge=='40' }">selected="selected"</c:if> >40대</option>
														<option value="50" <c:if test="${USERCATEVO.sAge=='50' }">selected="selected"</c:if> >50대 이상</option>
													</select>
			               						</td>
			               						<th cope="row">지역</th>
			               						<td colspan="1" >
													<select id="sArea" name="sArea">
														<option value="">전체</option>
														<option value="1" <c:if test="${USERCATEVO.sArea=='1' }">selected="selected"</c:if> >서울</option>
														<option value="2" <c:if test="${USERCATEVO.sArea=='2' }">selected="selected"</c:if> >경기</option>
														<option value="3" <c:if test="${USERCATEVO.sArea=='3' }">selected="selected"</c:if> >인천</option>
														<option value="4" <c:if test="${USERCATEVO.sArea=='4' }">selected="selected"</c:if> >부산</option>
														<option value="5" <c:if test="${USERCATEVO.sArea=='5' }">selected="selected"</c:if> >대구</option>
														<option value="6" <c:if test="${USERCATEVO.sArea=='6' }">selected="selected"</c:if> >대전</option>
														<option value="7" <c:if test="${USERCATEVO.sArea=='7' }">selected="selected"</c:if> >광주</option>
														<option value="8" <c:if test="${USERCATEVO.sArea=='8' }">selected="selected"</c:if> >울산</option>
														<option value="9" <c:if test="${USERCATEVO.sArea=='9' }">selected="selected"</c:if> >강원</option>
														<option value="10" <c:if test="${USERCATEVO.sArea=='10' }">selected="selected"</c:if> >경남</option>
														<option value="11" <c:if test="${USERCATEVO.sArea=='11' }">selected="selected"</c:if> >경북</option>
														<option value="12" <c:if test="${USERCATEVO.sArea=='12' }">selected="selected"</c:if> >전남</option>
														<option value="13" <c:if test="${USERCATEVO.sArea=='13' }">selected="selected"</c:if> >전북</option>
														<option value="14" <c:if test="${USERCATEVO.sArea=='14' }">selected="selected"</c:if> >충남</option>
														<option value="15" <c:if test="${USERCATEVO.sArea=='15' }">selected="selected"</c:if> >충북</option>
														<option value="16" <c:if test="${USERCATEVO.sArea=='16' }">selected="selected"</c:if> >제주</option>
														<option value="17" <c:if test="${USERCATEVO.sArea=='17' }">selected="selected"</c:if> >세종</option>
													</select>
			               						</td>
			               					</tr>
			               					<tr>
			               						<th scope="row">로그인횟수</th>
			               						<td colspan="3">
													<input type="text" id="sLoginCntS" name="sLoginCntS" class="input_text5" value="${USERCATEVO.sLoginCntS}" title="" />
													~
													<input type="text" id="sLoginCntE" name="sLoginCntE" class="input_text5" value="${USERCATEVO.sLoginCntE}" title="" />회
			               						</td>
			               						<th scope="row">구매횟수</th>
			               						<td colspan="3">
													<input type="text" id="sBuyCntS" class="input_text5" name="sBuyCntS" value="${USERCATEVO.sBuyCntS}" title="" />
													~
													<input type="text" id="sBuyCntE" class="input_text5" name="sBuyCntE" value="${USERCATEVO.sBuyCntE}" title="" />회
			               						</td>
			               					</tr>
			               					<tr>
			               						<th scope="row">구매금액</th>
			               						<td colspan="3" >
													<input type="text" id="sBuyAmtS" class="input_text5" name="sBuyAmtS" value="${USERCATEVO.sBuyAmtS}" title="" />
													~
													<input type="text" id="sBuyAmtE" class="input_text5" name="sBuyAmtE" value="${USERCATEVO.sBuyAmtE}" title="" />원
			               						</td>
			               						<th scope="row">재구매주기</th>
			               						<td colspan="1">
													<input type="text" id="sReBuy" class="input_text5" name="sReBuy" value="${USERCATEVO.sReBuy}" title="" />주
			               						</td>
			               					</tr>
			               					<tr>
			               						<th scope="row">구매상품</th>
			               						<td colspan="7">
													<%-- ${USERCATEVO.sCate}<br> --%>
													<label><input type="checkbox" <c:if test="${ (fn:indexOf(USERCATEVO.sCate, 'AD')>=0) }">checked="checked"</c:if> id="sCate" name="sCate" value="AD"/> 숙박</label>
													<label><input type="checkbox" <c:if test="${ (fn:indexOf(USERCATEVO.sCate, 'RC')>=0) }">checked="checked"</c:if> id="sCate" name="sCate" value="RC"/> 렌트카</label>
													<label><input type="checkbox" <c:if test="${ (fn:indexOf(USERCATEVO.sCate, 'SPC200')>=0) }">checked="checked"</c:if> id="sCate" name="sCate" value="SPC200"/> 관광지/레저/마사지</label>
													<label><input type="checkbox" <c:if test="${ (fn:indexOf(USERCATEVO.sCate, 'SPC300')>=0) }">checked="checked"</c:if> id="sCate" name="sCate" value="SPC300"/> 맛집</label>
													<label><input type="checkbox" <c:if test="${ (fn:indexOf(USERCATEVO.sCate, 'SPC500')>=0) }">checked="checked"</c:if> id="sCate" name="sCate" value="SPC500"/> 유모차/카시트</label>
													<label><input type="checkbox" <c:if test="${ (fn:indexOf(USERCATEVO.sCate, 'SPC130')>=0) }">checked="checked"</c:if> id="sCate" name="sCate" value="SPC130"/> 카텔</label>
													<label><input type="checkbox" <c:if test="${ (fn:indexOf(USERCATEVO.sCate, 'SPC170')>=0) }">checked="checked"</c:if> id="sCate" name="sCate" value="SPC170"/> 골프패키지</label>
													<label><input type="checkbox" <c:if test="${ (fn:indexOf(USERCATEVO.sCate, 'SPC160')>=0) }">checked="checked"</c:if> id="sCate" name="sCate" value="SPC160"/> 버스/택시관광</label>
													<label><input type="checkbox" <c:if test="${ (fn:indexOf(USERCATEVO.sCate, 'SV')>=0) }">checked="checked"</c:if> id="sCate" name="sCate" value="SV"/> 특산기념품</label>
													<li class="btn_sty04"><a href="javascript:fn_CateAll(true)">전체선택</a></li>
													<li class="btn_sty04"><a href="javascript:fn_CateAll(false)">전체해제</a></li>
			               						</td>
			               					</tr>
			               					<tr>
			               						<th scope="row">구매시기</th>
			               						<td colspan="3">
			               							<fmt:parseDate value='${USERCATEVO.sBuyDateS}' var='sBuyDateS'	pattern="yyyymmdd" scope="page" />
			               							<input type="text" id="sBuyDateS" class="input_text5" name="sBuyDateS" value="<fmt:formatDate value="${sBuyDateS}" pattern="yyyy-mm-dd"/>" title="" />
													~
													<fmt:parseDate value='${USERCATEVO.sBuyDateE}' var='sBuyDateE'	pattern="yyyymmdd" scope="page" />
													<input type="text" id="sBuyDateE" class="input_text5" name="sBuyDateE" value="<fmt:formatDate value="${sBuyDateE}" pattern="yyyy-mm-dd"/>" title="" />
													<li class="btn_sty04"><a href="javascript:fn_BuyDateReset()">지우기</a></li>
												</td>
												<th scope="row">이벤트</th>
			               						<td colspan="1">
													<select id="sEvent" name="sEvent">
														<option value="">전체</option>
														<option value="Y" <c:if test="${USERCATEVO.sEvent=='Y' }">selected="selected"</c:if> >응모</option>
														<option value="N" <c:if test="${USERCATEVO.sEvent=='N' }">selected="selected"</c:if> >미응모</option>
													</select>
			               						</td>
			               						<th scope="row">상품평</th>
			               						<td colspan="1">
													<select id="sUseepil" name="sUseepil">
														<option value="">전체</option>
														<option value="Y" <c:if test="${USERCATEVO.sUseepil=='Y' }">selected="selected"</c:if> >등록</option>
														<option value="N" <c:if test="${USERCATEVO.sUseepil=='N' }">selected="selected"</c:if> >미등록</option>
													</select>
			               						</td>
			               					</tr>
			               					<tr>
			               						<th scope="row">결제방식</th>
			               						<td colspan="1">
			               							<select id="sPayDiv" name="sPayDiv">
														<option value="">전체</option>
														<option value="L100" <c:if test="${USERCATEVO.sPayDiv=='L100' }">selected="selected"</c:if> >신용카드</option>
														<option value="L200" <c:if test="${USERCATEVO.sPayDiv=='L200' }">selected="selected"</c:if> >휴대폰</option>
														<option value="L300" <c:if test="${USERCATEVO.sPayDiv=='L300' }">selected="selected"</c:if> >계좌이체</option>
														<option value="L700" <c:if test="${USERCATEVO.sPayDiv=='L700' }">selected="selected"</c:if> >계좌이체(에스크로)</option>
														<option value="L400" <c:if test="${USERCATEVO.sPayDiv=='L400' }">selected="selected"</c:if> >카카오페이</option>

													</select>
			               						</td>
			               						<th scope="row">할인</th>
			               						<td colspan="1" >
			               							L-Point
			               							<select id="sLPointYn" name="sLPointYn">
														<option value="">전체</option>
														<option value="Y" <c:if test="${USERCATEVO.sLPointYn=='Y' }">selected="selected"</c:if> >사용</option>
														<option value="N" <c:if test="${USERCATEVO.sLPointYn=='N' }">selected="selected"</c:if> >미사용</option>
													</select>

													쿠폰
													<select id="sCuponYn" name="sCuponYn">
														<option value="">전체</option>
														<option value="Y" <c:if test="${USERCATEVO.sCuponYn=='Y' }">selected="selected"</c:if> >사용</option>
														<option value="N" <c:if test="${USERCATEVO.sCuponYn=='N' }">selected="selected"</c:if> >미사용</option>
													</select>


			               						</td>
			               						<th scope="row">블랙리스트</th>
			               						<td colspan="1" >
													<select id="sBlkList" name="sBlkList">
														<option value="">전체</option>														
														<option value="N" <c:if test="${USERCATEVO.sBlkList=='N' }">selected="selected"</c:if> >일반고객</option>
														<option value="Y" <c:if test="${USERCATEVO.sBlkList=='Y' }">selected="selected"</c:if> >블랙리스트</option>
													</select>
			               						</td>
			               					</tr>

			     						</tbody>
			               			</table>
			               		</div>
								<span class="btn">
									<input type="image" src="<c:url value='/images/oss/btn/search_btn01.gif'/>" alt="검색" onclick="javascript:fn_Search('1')" />
								</span>

			              	</div>
			            </div>

			            <c:if test="${USERCATEVO.sFindYn == 'Y'}">

				            <p class="search_list_ps title03">[총 <strong>${totalCnt}</strong>건]</p> <!--리스트 검색 건수-->

							<div class="list">

								<table width="100%" border="1" cellspacing="0" cellpadding="0"
									class="table01 list_tb">
									<thead>
										<tr>
											<!-- <th>번호</th> -->
											<th>사용자아이디</th>
											<th>고객명</th>
											<th>권한</th>
											<th>업체관리자</th>
											<th>이메일(수신여부)</th>
											<th>전화번호(수신여부)</th>
											<th>최종 로그인 일시</th>
											<th>가입 일시</th>
											<th>불량고객</th>
										</tr>
									</thead>

									<tbody>

										<!-- 데이터 없음 -->
										<c:if test="${fn:length(resultList) == 0}">
											<tr>
												<td colspan="15" class="align_ct"><spring:message code="common.nodata.msg" /></td>
											</tr>
										</c:if>

										<c:forEach var="userInfo" items="${resultList}" varStatus="status">
											<tr <%-- style="cursor:pointer;" onclick="fn_DetailUser('${userInfo.userId}')" --%>>
												<%-- <td class="align_ct"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td> --%>
												<td class="align_ct"><c:out value="${userInfo.userId}" /></td>
												<td class="align_ct"><c:out value="${userInfo.userNm}" /></td>
												<td class="align_ct">
													<c:if test="${userInfo.authNm=='USER'}">일반사용자</c:if>
													<c:if test="${userInfo.authNm=='ADMIN'}">관리자</c:if>
												</td>
												<td class="align_ct">
													<c:if test="${userInfo.corpAdmYn=='Y'}"><img src="<c:url value='/images/oss/icon/icon_admin.png'/>" alt="입점업체관리자" /></c:if>
												</td>
												<td class="align_ct"><c:out value="${userInfo.email}" /> (${userInfo.emailRcvAgrYn})</td>
												<td class="align_ct"><c:out value="${userInfo.telNum}" /> (${userInfo.smsRcvAgrYn})</td>
												<td class="align_ct"><c:out value="${userInfo.lastLoginDttm}" /></td>
												<td class="align_ct"><c:out value="${userInfo.frstRegDttm}" /></td>
												<td class="align_ct">
													<c:if test="${userInfo.badUserYn=='Y'}">불량</c:if>
												</td>
											</tr>
										</c:forEach>

									</tbody>

								</table>

							</div>


							<p class="list_pageing">
								<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
							</p>

							<ul class="btn_rt01">
								<li class="btn_sty02"><a href="javascript:fn_SendSMS()">문자전송</a></li>
								<li class="btn_sty02"><a href="javascript:fn_SendMail()">메일전송</a></li>

								<!-- <li class="btn_sty04"><a href="javascript:fn_Ins()">등록</a></li> -->
							</ul>

						</c:if>


					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<iframe name="frmFileDown" style="display:none"></iframe>
</body>
</html>