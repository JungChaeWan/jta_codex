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
<%@ taglib prefix="un" uri="http://jakarta.apache.org/taglibs/unstandard-1.0"%>

<un:useConstants var="Constant" className="common.Constant" />
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>


<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css"href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">

var corpGubun = '';
function fn_viewSelectCorp(gubun) {
	corpGubun = gubun;
	var retVal = window.open("<c:url value='/oss/findCorp.do?sCorpCd=CSPT'/>","findCorp", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");
	// &sSpCtgr=" + gubun + "
}

function fn_SelectCorp(corpId, corpNm, corpCd){	
	var chkCorp = false;

	$('.selCorpNum').each(function() {
		if ($(this).val() == corpId) {
			chkCorp = true;
			return false;
		}
	});

	if (chkCorp == false) {
		var strHtml = "";
		var corpIndex = $('.selCorpNum').length;

		strHtml =	'<li>['+corpId+']['+corpNm+']'+
					' <a href="javascript:fn_Dummay();"><span class="del"><img src="<c:url value="/images/web/icon/close5.gif"/>" alt="삭제"></span></a>' +
					'<input type="hidden" class="corp' + corpGubun + 'List" name="corpRcmd[' + corpIndex + '].rcmdDiv" value="' + corpGubun + '"/>' +
					'<input type="hidden" class="selCorpNum" name="corpRcmd[' + corpIndex + '].corpId" value="' + corpId + '"/>' +
					'<input type="hidden" class="printSn" name="corpRcmd[' + corpIndex + '].printSn" value="' + (eval($('.corp' + corpGubun + 'List').length)+1) + '"/></li>';
	
		$("#select"+ corpGubun + " ul").append(strHtml);
	}

}

function fn_Dummay(){

}

$(document).ready(function(){
	$(".selectLiProduct").on("click", ".del", function(index) {
		$(this).parents("li").remove();
	});

	// 출력 순서의 자동 정렬
	$('.printSnC160').change(function() {
		$.selSort = eval($(this).val());
		$.selId = $(this).attr('id');
		$.curVal = eval($('#' + $.selId + '_sort').val());

		if ($.selSort > $.curVal) {
			$('.printSnC160').each(function() {
				if ($(this).attr('id') != $.selId && $(this).val() >= $.curVal && $(this).val() <= $.selSort) {
					$(this).val($(this).val() - 1);
					$('#' + $(this).attr('id') + '_sort').val($(this).val());
				}
			});
		} else if ($.selSort < $.curVal) {
			$('.printSnC160').each(function() {
				if ($(this).attr('id') != $.selId && ($(this).val() >= $.selSort && $(this).val() <= $.curVal)) {
					$(this).val(eval($(this).val()) + 1);
					$('#' + $(this).attr('id') + '_sort').val($(this).val());
				}
			});
		}
		$('#' + $.selId + '_sort').val($(this).val());
	});

	$('.printSnC170').change(function() {
		$.selSort = eval($(this).val());
		$.selId = $(this).attr('id');
		$.curVal = eval($('#' + $.selId + '_sort').val());

		if ($.selSort > $.curVal) {
			$('.printSnC170').each(function() {
				if ($(this).attr('id') != $.selId && $(this).val() >= $.curVal && $(this).val() <= $.selSort) {
					$(this).val($(this).val() - 1);
					$('#' + $(this).attr('id') + '_sort').val($(this).val());
				}
			});
		} else if ($.selSort < $.curVal) {
			$('.printSnC170').each(function() {
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
		<jsp:include page="/oss/head.do?menu=site" flush="false"></jsp:include>
		<!--Contents 영역-->
		<div id="contents_wrapper">
			<jsp:include page="/oss/left.do?menu=site&sub=corprcmd" flush="false"></jsp:include>
			<div id="contents_area">
				<div id="contents">
					<form:form commandName="frm"  name="corpRcmdFrm" method="post" action="/oss/actionCorpRcmd.do">
					<h4 class="title03 margin-top45">여행사상품 서브메인</h4>
					<table border="1" class="table02">
						<colgroup>
	                        <col width="200" />
                        	<col width="*" />
	                    </colgroup>
						<tr>
							<th scope="row" rowspan="2">단체관광</th>
							<td>
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewSelectCorp('C160');">업체 검색</a></span>
								</div>								
							</td>
						</tr>
						<tr>					
							<td>
								<div id="selectC160" class="selectLiProduct">
									<ul>
									  <c:forEach items="${corpRcmdList }" var="rcmd" varStatus="status">
									    <c:if test="${rcmd.rcmdDiv eq 'C160' }">
									  <li>										  									    
										  <input type="hidden" id="${rcmd.corpId}_sort" value="${rcmd.printSn }" />
								  	  	  <select class="printSnC160" id="${rcmd.corpId}" name="corpRcmd[${status.index }].printSn">
											<c:forEach var="cnt" begin="1" end="${fn:length(corpRcmdC160List) }">
												<option value="${cnt}" <c:if test="${cnt == rcmd.printSn}">selected="selected"</c:if>>${cnt}</option>
											</c:forEach>
										  </select>
										  [${rcmd.corpId}][${rcmd.corpNm}]
										<a href="javascript:fn_Dummay();"><span class="del"><img src="<c:url value="/images/web/icon/close5.gif"/>" alt="삭제"></span></a>
										<input type="hidden" class="corpC160List" name="corpRcmd[${status.index }].rcmdDiv" value="${rcmd.rcmdDiv }"/>
										<input type="hidden" class="selCorpNum" name="corpRcmd[${status.index }].corpId" value="${rcmd.corpId }"/>
									  </li>
									    </c:if>
									  </c:forEach>
									</ul>
								</div>
							</td>
						</tr>
						<tr>
							<th rowspan="2">골프패키지</th>
							<td>
								<div class="btn_sty04">
									<span><a href="javascript:fn_viewSelectCorp('C170');">업체 검색</a></span>
								</div>								
							</td>
						</tr>
						<tr>
							<td>
								<div id="selectC170" class="selectLiProduct">
									<ul>
									  <c:forEach items="${corpRcmdList }" var="rcmd" varStatus="status">
									    <c:if test="${rcmd.rcmdDiv eq 'C170' }">
									  <li>										  									    
										  <input type="hidden" id="${rcmd.corpId}_sort" value="${rcmd.printSn }" />
								  	  	  <select class="printSnC170" id="${rcmd.corpId}" name="corpRcmd[${status.index }].printSn">
											<c:forEach var="cnt" begin="1" end="${fn:length(corpRcmdC170List) }">
												<option value="${cnt}" <c:if test="${cnt == rcmd.printSn}">selected="selected"</c:if>>${cnt}</option>
											</c:forEach>
										  </select>
										  [${rcmd.corpId}][${rcmd.corpNm}]
											<a href="javascript:fn_Dummay();"><span class="del"><img src="<c:url value="/images/web/icon/close5.gif"/>" alt="삭제"></span></a>
											<input type="hidden" class="corpC170List" name="corpRcmd[${status.index }].rcmdDiv" value="${rcmd.rcmdDiv }"/>
											<input type="hidden" class="selCorpNum" name="corpRcmd[${status.index }].corpId" value="${rcmd.corpId }"/>
									  </li>		
									    </c:if>
									  </c:forEach>
									</ul>
								</div>
							</td>
						</tr>
					</table>
					<ul class="btn_rt01 align_ct">
						<li class="btn_sty04">
							<a href="#" onclick="document.corpRcmdFrm.submit();">적용</a>
						</li>
					</ul>
					</form:form>
			</div>
		</div>
	</div>
</div>
</body>
</html>