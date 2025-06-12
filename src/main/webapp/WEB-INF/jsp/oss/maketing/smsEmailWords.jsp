<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 			uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
           
<un:useConstants var="Constant" className="common.Constant" />
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />

<title></title>
<script type="text/javascript">
/**
 * 조회 & 페이징
 */
function fn_Search(pageIndex){
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/oss/smsEmailWords.do'/>";
	document.frm.submit();
}

function fn_WordsLay(smsEmailNum){
	if(isNull(smsEmailNum)) {
		show_popup($("#lay_popup"));
	} else {
		var parameters = "smsEmailNum=" + smsEmailNum;

		$.ajax({
			type:"post",
			dataType:"json",
			async:false,
			url:"<c:url value='/oss/selectByWords.ajax'/>",
			data:parameters,
			success:function(data){
				$("#smsEmailNum").val(data.smsEmailWordsVO.smsEmailNum);
				$("#wordsDiv").val(data.smsEmailWordsVO.wordsDiv);
				$("#wordsSubject").val(data.smsEmailWordsVO.wordsSubject);
				$("#wordsContents").val(data.smsEmailWordsVO.wordsContents);
				$("#aplStartDt").val(fn_addDate(data.smsEmailWordsVO.aplStartDt));
				$("#aplEndDt").val(fn_addDate(data.smsEmailWordsVO.aplEndDt));

				show_popup($("#lay_popup"));
			}
		});
	}

}

function fn_SaveWords(){
	if(isNull($("#wordsSubject").val())){
		alert("<spring:message code="common.required.msg" arguments="제목" />");
		$("#wordsSubject").focus();
		return;
	}
	
	if(isNull($("#wordsContents").val())){
		alert("<spring:message code="common.required.msg" arguments="문구 내용" />");
		$("#wordsContents").focus();
		return;
	}

	$("#aplStartDt").val(fn_replaceAll($("#aplStartDt").val(), "-", ""));
	$("#aplEndDt").val(fn_replaceAll($("#aplEndDt").val(), "-", ""));
	
	var parameters = $("#wordsFrm").serialize();
	var myUrl = "";
	var msg = "";

	if(isNull($("#smsEmailNum").val())) {
		myUrl = "<c:url value='/oss/insertWords.ajax'/>";
		msg = "<spring:message code="success.common.insert" />";
	} else {
		myUrl = "<c:url value='/oss/updateWords.ajax'/>";
		msg = "<spring:message code="success.common.update" />";
	}
	
	$.ajax({
		type:"post", 
		dataType:"json",
		async:false,
		url:myUrl,
		data:parameters,
		success:function(data){
			alert(msg);

			document.frm.action = "<c:url value='/oss/smsEmailWords.do'/>";
			document.frm.submit();
		}
	});
}

function fn_DelWords(smsEmailNum){
	if(confirm("<spring:message code="common.delete.msg" />")) {
		var parameters = "smsEmailNum=" + smsEmailNum;
		
		$.ajax({
			type:"post", 
			dataType:"json",
			async:false,
			url:"<c:url value='/oss/deleteWords.ajax'/>",
			data:parameters,
			success:function(data){
				alert("<spring:message code="success.common.delete" />");
				document.frm.action = "<c:url value='/oss/smsEmailWords.do'/>";
				document.frm.submit();
			}
		});
	}
}

function fn_LastDay() {
	$("#aplEndDt").val("2099-12-31");
}

$(function() {
	$("#aplStartDt").datepicker({
		minDate: "today",
		onClose: function(selectedDate) {
			$("#aplEndDt").datepicker("option", "minDate", selectedDate);
		}
	});

	$("#aplEndDt").datepicker({
		minDate: "today",
		onClose : function(selectedDate) {
			$("#aplStartDt").datepicker("option", "maxDate", selectedDate);
		}
	});

});
</script>
</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=maketing" />
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=maketing&sub=smsEmailWords" />

		<div id="contents_area">
			<div id="contents">
				<h4 class="title03">문자/이메일 문구 관리</h4>
				<form name="frm" method="post" onSubmit="return false;">
					<input type="hidden" name="pageIndex" id="pageIndex" value="${SMSEMAILWORDSVO.pageIndex}"/>

					<div class="search_box">
						<div class="search_form">
							<div class="tb_form">
								<table width="100%" border="0">
									<colgroup>
										<col width="150" />
										<col width="*" />
									</colgroup>
									<tbody>
										<tr>
											<th scope="row">문자/이메일 구분</th>
											<td colspan="5">
												<select name="wordsDiv">
													<option value="">전체</option>
													<option value="SMS" <c:if test="${SMSEMAILWORDSVO.wordsDiv eq 'SMS'}">selected="selected"</c:if>>문자</option>
													<option value="EMAL" <c:if test="${SMSEMAILWORDSVO.wordsDiv eq 'EMAL'}">selected="selected"</c:if>>이메일</option>
												</select>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<span class="btn">
								<input type="image" src="<c:url value="/images/oss/btn/search_btn01.gif"/>" alt="검색" onclick="fn_Search('1');" />
							</span>
						</div>
                    </div>
                    <p style="position:relative; top:-36px; clear:both;">※ 예약완료 문자에 문구 추가 방법 : 문구 등록 시 <span class="font_blue">제목에 '이벤트'를 포함하고, 발송시작일/종료일을 등록하면</span> 해당 기간에 문구 내용이 예약완료 문자에 추가되어 발송됨.</p>
                    <!--검색-->
					<p class="search_list_ps">[총 <strong>${totalCnt}</strong>건]</p>
					<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
						<colgroup>
							<col width="50" />
							<col width="70" />
							<col width="200" />
							<col width="*" />
							<col width="120" />
							<col width="120" />
							<col width="120" />
						</colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th>구분</th>
								<th>제목</th>
								<th>문구 내용</th>
								<th>발송시작일</th>
								<th>발송종료일</th>
								<th>기능툴</th>
							</tr>
						</thead>
						<tbody>
							<!-- 데이터 없음 -->
							<c:if test="${fn:length(resultList) == 0}">
								<tr>
									<td colspan="7" class="align_ct"><spring:message code="common.nodata.msg" /></td>
								</tr>
							</c:if>
							<c:forEach var="result" items="${resultList}" varStatus="status">
								<tr>
									<td class="align_ct"><c:out value="${(SMSEMAILWORDSVO.pageIndex-1) * SMSEMAILWORDSVO.pageSize + status.count}"/></td>
									<td class="align_ct">
										<c:if test="${'SMS' eq result.wordsDiv}">문자</c:if>
										<c:if test="${'EMAL' eq result.wordsDiv}">이메일</c:if>
									</td>
									<td>${result.wordsSubject}</td>
									<td style="white-space:pre-wrap;"><c:out value="${result.wordsContents}" escapeXml="false" /></td>
									<fmt:parseDate var="aplStartDt" value="${result.aplStartDt}" pattern="yyyyMMdd"/>
									<fmt:parseDate var="aplEndDt" value="${result.aplEndDt}" pattern="yyyyMMdd"/>
									<td class="align_ct"><fmt:formatDate value="${aplStartDt}" pattern="yyyy-MM-dd"/></td>
									<td class="align_ct"><fmt:formatDate value="${aplEndDt}" pattern="yyyy-MM-dd"/></td>
									<td class="align_ct">
										<div class="btn_sty06"><span><a href="javascript:void(0)" onclick="fn_WordsLay('${result.smsEmailNum}');">수정</a></span></div>
										<div class="btn_sty09"><span><a href="javascript:void(0)" onclick="fn_DelWords('${result.smsEmailNum}');">삭제</a></span></div>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<p class="list_pageing">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_Search" />
					</p>
				</form>
				<ul class="btn_rt01">
					<li class="btn_sty01"><a href="javascript:void(0)" onclick="fn_WordsLay(null);">등록</a></li>
				</ul>
			</div>
		</div>
	</div>
</div>

<div class="blackBg"></div>

<div id="lay_popup" class="lay_popup lay_ct" style="display:none;"> <!--왼쪽정렬:lay_lt, 오른쪽정렬:lay_rt, 가운데정렬:lay_ct--> 
	<span class="popup_close">
		<a href="javascript:void(0)" onclick="close_popup($('#lay_popup'));" title="창닫기"><img src="<c:url value="/images/oss/btn/close_btn03.gif"/>" alt="닫기" /></a>
	</span>
	<form name="wordsFrm" id="wordsFrm">
		<input type="hidden" name="smsEmailNum" id="smsEmailNum" value="" />

		<ul class="form_area">
			<li>
				<table class="table02" border="1">
  					<caption class="tb01_title">문자/이메일 문구 관리<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span></caption>
					<colgroup>
						<col width="130" />
						<col width="*" />
					</colgroup>
					<tr>
						<th>구분<span class="font02">*</span></th>
						<td>
							<select name="wordsDiv" id="wordsDiv">
   								<option value="SMS">문자</option>
   								<option value="EMAL">이메일</option>
   							</select>
						</td>
					</tr>
					<tr>
						<th>제목<span class="font02">*</span></th>
						<td>
							<input type="text" name="wordsSubject" id="wordsSubject" class="input_text30" maxlength="30" />
						</td>
					</tr>
					<tr>
						<th>발송시작일</th>
						<td>
							<input type="text" name="aplStartDt" id="aplStartDt" class="input_text4 center"  title="발송시작일" readonly="true" />
						</td>
					</tr>
					<tr>
						<th>발송종료일</th>
						<td>
							<input type="text" name="aplEndDt" id="aplEndDt" class="input_text4 center"  title="발송종료일" readonly="true" />
							&nbsp;<div class="btn_sty07"><span><a href="javascript:void(0)" onclick="fn_LastDay();">2099년</a></span></div>
						</td>
					</tr>
					<tr>
						<th>문구 내용<span class="font02">*</span></th>
						<td>
							<textarea name="wordsContents" id="wordsContents" rows="10" cols="30"></textarea>
						</td>
					</tr>
				</table>
       		</li>
       </ul>
    </form>
    <div class="btn_rt01">
    	<span class="btn_sty04"><a href="javascript:void(0)" onclick="fn_SaveWords();">저장</a></span>
    </div>
</div>

</body>
</html>