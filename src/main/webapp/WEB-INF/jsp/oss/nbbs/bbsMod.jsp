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
<un:useConstants var="Constant" className="common.Constant" />
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
<c:if test="${bbs.edtYn eq 'Y'}" >
<script type="text/javascript" src="<c:url value='/dext5editor/js/dext5editor.js'/>"></script>
</c:if>

<validator:javascript formName="BBSGRPINFVO" staticJavascript="false" xhtml="true" cdata="true"/>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>

<script type="text/javascript">
function checkFile(fileSize){
	var file = fileSize.files;

	if(file[0].size > 1024 * 1024 * 10){
		alert('10MB 이하 파일만 등록할 수 있습니다.\n\n' + '현재파일 용량 : ' + (Math.round(file[0].size / 1024 / 1024 * 100) / 100) + 'MB');
	}
	
	else return;
	
	fileSize.outerHTML = fileSize.outerHTML;
}

function fn_Mod(){
	
	if(document.frm.subject.value.length==0){
		alert("제목을 입력 하세요.");
		document.frm.subject.focus();
		return;
	}
	
	if(document.frm.subject.value.length >= 50){
		alert("제목의 길이는 50자 이하 입니다.");
		document.frm.subject.focus();
		return;
	}
	
/* 	if(document.frm.writer.value.length==0){
		alert("작성자을 입력 하세요.");
		document.frm.writer.focus();
		return;
	}
	
	if(document.frm.writer.value.length >= 10){
		alert("작성자의 길이는 10자 이하 입니다.");
		document.frm.writer.focus();
		return;
	} */
	
	<c:if test="${bbs.edtYn eq 'Y'}" >
	document.frm.contents.value = DEXT5.getBodyValueExLikeDiv('editor1');
	</c:if>
	
	if(document.frm.contents.value.length==0){
		alert("내용을 입력 하세요.");
		document.frm.contents.focus();
		return;
	}
	
	/* if(document.frm.contents.value.length >= 10000){
		alert("내용의 길이는 10000자 이하 입니다.");
		document.frm.contents.focus();
		return;
	} */
	
	if(${bbs.anmUseYn == 'Y' && (userInfo.authNm == 'ADMIN')} == true){
		if(document.frm.anmYn_chk.checked  == true)
			document.frm.anmYn.value = "Y";
		else
			document.frm.anmYn.value = "N";
	}
	
	if("${bbs.bbsNum}" =='FNREQ') {
		if($("#statusDiv").val() == "${Constant.STATUS_DIV_02}") {
			if(isNull($("#cmplItdDt").val())) {
				alert("완료예정일을 입력해 주세요.");
				$("#cmplItdDt").focus();
				return ;
			}
			
		} else if($("#statusDiv").val() == "${Constant.STATUS_DIV_04}"){
			if(isNull($("#cmplDt").val())) {
				alert("완료일을 입력해 주세요.");
				$("#cmplDt").focus();
				return ;
			}
		}
		$("#cmplItdDt").val($('#cmplItdDt').val().replace(/-/g, ""));
		$("#cmplDt").val($('#cmplDt').val().replace(/-/g, ""));
	}
	
	document.frm.action = "<c:url value='/oss/nbbs/bbsMod.do'/>";
	document.frm.submit();
}

function fn_delFile(id){
	if(confirm("첨부파일은 바로 삭제 되어 복구 할수 없습니다.\n삭제 하시겠습니까?")){
		document.frm.fileNum.value = id;
		document.frm.action = "<c:url value='/oss/nbbs/bbsDelFile.do'/>";
		document.frm.submit();
	}
}

<c:if test="${bbs.edtYn eq 'Y'}" >
function dext_editor_loaded_event() {	
	//숨겨진 textarea에서 html 소스를 가져옵니다.
	var html_source1 = document.frm.contents.value; //에디터가 로드 되고 난 후 에디터에 내용을 입력합니다.	
	DEXT5.setBodyValueExLikeDiv(html_source1, 'editor1');
}
</c:if>

function displayStatusDiv(code) {
	$(".t_statusDiv").hide();
	$("." + code ).show();
}
$(document).ready(function(){

	if('${authModYn}'!='Y'){
		alert("권한이 없습니다.");
		location.href = "<c:url value='/oss/nbbs/bbsList.do'/>?bbsNum=${notice.bbsNum}&pageIndex=${searchVO.pageIndex}"
		return;
	}
	
	if("${bbs.bbsNum}" =='FNREQ') {
		$("#statusDiv").change(function (){
			displayStatusDiv($(this).val());
		});
		
		$("#cmplItdDt").datepicker({
		});
		$("#cmplDt").datepicker({
		});
		
		$("#statusDiv").val("${notice.statusDiv}");
		displayStatusDiv("${notice.statusDiv}");
	}
	
	if("${bbs.atcFileNum}" != "0"){
		//파일 올리기 관련
		if(${bbs.atcFileNum - fn:length(notiFileList)} > 0)
		{
			var maxFileNum = ${bbs.atcFileNum - fn:length(notiFileList)};
			var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
			multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
		}
	}

	
});


</script>
</head>
<body>
<div id="wrapper"> 
	<c:choose>
		<c:when test="${bbs.bbsNum=='MASNOTI' || bbs.bbsNum=='MASQA'}">
			<jsp:include page="/oss/head.do?menu=corp" flush="false"></jsp:include>
		</c:when>
		<c:when test="${bbs.bbsNum=='NOTICE' || bbs.bbsNum=='NEWS' || bbs.bbsNum=='GRACOM' || bbs.bbsNum=='DESIGN'}">
			<jsp:include page="/oss/head.do?menu=community" flush="false"></jsp:include>
		</c:when>
		<c:when test="${bbs.bbsNum=='FNREQ'}">
			<jsp:include page="/oss/head.do?menu=support" flush="false"></jsp:include>
		</c:when>
	</c:choose>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<c:choose>
			<c:when test="${bbs.bbsNum=='MASNOTI' || bbs.bbsNum=='MASQA'}">
				<jsp:include page="/oss/left.do?menu=corp&sub=bbs${bbs.bbsNum}" flush="false"></jsp:include>
			</c:when>
			<c:when test="${bbs.bbsNum=='NOTICE' || bbs.bbsNum=='NEWS' || bbs.bbsNum=='GRACOM' || bbs.bbsNum=='DESIGN'}">
				<jsp:include page="/oss/left.do?menu=community&sub=bbs${bbs.bbsNum}" flush="false"></jsp:include>
			</c:when>
			<c:when test="${bbs.bbsNum=='FNREQ'}">
				<jsp:include page="/oss/left.do?menu=support&sub=bbs${bbs.bbsNum}" flush="false"></jsp:include>
			</c:when>
		</c:choose>
		<div id="contents_area"> 
			<div id="contents">
			
				<!-- --------------------------------------------------- -->
		
				<form name="frm" id="frm" method="post" enctype="multipart/form-data" onSubmit="return false;" >
					<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
					<input name="sKey" type="hidden" value="<c:out value='${searchVO.sKey}'/>"/>
					<input name="sKeyOpt" type="hidden" value="<c:out value='${searchVO.sKeyOpt}'/>"/>
					
					<input type="hidden" id="bbsNum" name="bbsNum" value="${bbs.bbsNum}" />
					<input type="hidden" id="noticeNum" name="noticeNum" value="${notice.noticeNum}" />
					<input type="hidden" id="hrkNoticeNum" name="hrkNoticeNum" value="${notice.hrkNoticeNum}" />
					<input type="hidden" id="ansNum" name="ansNum" value="${notice.ansNum}" />
					<input type="hidden" id="ansSn" name="ansSn" value="${notice.ansSn}" />
					
					<input type="hidden" id="email" name="email" value="${userInfo.email}" />
					<input type="hidden" id="brtagYn" name="brtagYn" value="Y" />
					<input type="hidden" id="htmlYn" name="htmlYn" value="${notice.htmlYn}" />
					<input type="hidden" name="sStatusDiv" id="sStatusDiv" value="${searchVO.sStatusDiv}" />
					
					<input type="hidden" id="fileNum" name="fileNum" value="" />
											
					<div class="register_area">
						<h4 class="title03">
							수정
							<span style="float:right"><span class="font_red">*</span> 필수 입력 항목입니다.</span>
						</h4>
						
	
						<table border="1" class="table02">
							<colgroup>
		                        <col width="200" />
		                        <col width="*" />
		                    </colgroup>
		                    
		                    <tr>
		                    	<th>제목<span class="font_red">*</span></th>
		                    	<td colspan="3">
		                    		<input id="subject" name="subject" value="${notice.subject}" type="text" placeholder="최대 50자 까지 자유롭게 입력가능하십니다." class="input_text30">
		                    	</td>
		                    </tr>
		                    <tr>
		                    	<th>작성자<span class="font_red">*</span></th>
		                    	<td colspan="3">
		                    		<input id="writer" name="writer" value="${notice.writer}" type="text" class="input_text20"  readonly>
		                    		
		                    		<c:if test="${bbs.anmUseYn == 'Y' && (userInfo.authNm == 'ADMIN')}">
		                            	<lable><input type="checkbox" id="anmYn_chk" name="anmYn_chk" style="width: auto; margin-left: 5px;']" <c:if test="${notice.anmYn=='Y'}"> checked="checked" </c:if> >공지사항</lable>
		                            	<input type="hidden" id="anmYn" name="anmYn" value="" />
		                        	</c:if>
		                    	</td>
		                    </tr>
		                    <tr>
		                    	<th>내용<span class="font_red">*</span></th>
		                    	<td colspan="3">
		                    		<c:if test="${bbs.edtYn eq 'Y'}" >
			                    	<script type="text/javascript">
									 var editor1 = new Dext5editor('editor1');
									</script>
		                    		<textarea id="contents" name="contents" cols="70" rows="30" style="padding: 0;min-width: 500px; display:none;">${notice.contents}</textarea>
		                    		</c:if>
		                    		<c:if test="${bbs.edtYn eq 'N'}" >
		                    		<textarea placeholder="한글 10000자까지 자유롭게 입장가능하십니다." id="contents" name="contents" cols="70" rows="30" style="padding: 0;min-width: 500px">${notice.contents}</textarea>
		                    		</c:if>
		                    	</td>
		                    </tr>
		                    
		                    <c:if test="${bbs.atcFileNum!='0'}">
	                   	   		<tr>
	                            	<th>첨부파일</th>
	                            	<td>
		                            	<c:forEach var="data" items="${notiFileList}" varStatus="status">
	    	                        		<img class="fileIcon" src="<c:url value='/images/web/board/file.jpg'/>" alt="첨부파일">
	        	                            <span>${data.realFileNm }<a href="javascript:fn_delFile('${data.fileNum}')" title="${data.realFileNm }">[삭제]</a></span><br/>
	            	                	</c:forEach>
	                            	
	                	            	<c:if test="${(bbs.atcFileNum - fn:length(notiFileList)) > 0}"> 
	                                    	<div id="egovComFileList" class="text_input04"></div>
											<input type="file" id="egovComFileUploader" name="file" accept="*" class="full" onchange="checkFile(this)"/>
											<br /><c:if test="${not empty fileError}">Error:<c:out value="${fileError}"/></c:if>
										</c:if>
	                            	</td>
	                        	</tr>
	                      	</c:if>
		                    <c:if test="${bbs.bbsNum eq'FNREQ'}">
		                    <tr>
		                    	<th>완료 요청일</th>
		                    	<td>
		                    		<fmt:parseDate value="${notice.cmplRequestDt}" var="cmplRequestDt" pattern="yyyyMMdd"/>
		                    		<fmt:formatDate value="${cmplRequestDt}" pattern="yyyy-MM-dd"/>
		                    	</td>
		                    </tr>
		                    <tr>
		                    	<th>상태</th>
		                    	<td>
		                    		<select name="statusDiv" id="statusDiv">
		                    			<option value="${Constant.STATUS_DIV_02}">접수</option>
		                    			<option value="${Constant.STATUS_DIV_03}">기각</option>
		                    			<option value="${Constant.STATUS_DIV_04}">완료</option>
		                    		</select>
		                    	</td>
		                    </tr>
		                    <tr style="display:none" class="t_statusDiv SD02 SD01">
		                    	<th>완료 예정일</th>
		                    	<td>
		                    		<c:set var="cmplItdDt" value="" />
		                    		<c:if test="${not empty notice.cmplItdDt}">
		                    			<c:set var="cmplItdDt" value="${fn:substring(notice.cmplItdDt,0,4)}-${fn:substring(notice.cmplItdDt,4,6)}-${fn:substring(notice.cmplItdDt,6,8)}" />
		                    		</c:if>
		                    		<input type="text" name="cmplItdDt" id="cmplItdDt" class="input_text4 center" value="${cmplItdDt}" readonly="true"/>
		                    	</td>
		                    </tr>
		                     <tr style="display:none" class="t_statusDiv SD04">
		                    	<th>완료일</th>
		                    	<td>
		                    		<c:set var="cmplDt" value="" />
		                    		<c:if test="${not empty notice.cmplDt}">
		                    			<c:set var="cmplDt" value="${fn:substring(notice.cmplDt,0,4)}-${fn:substring(notice.cmplDt,4,6)}-${fn:substring(notice.cmplDt,6,8)}" />
		                    		</c:if>
		                    		<input type="text" name="cmplDt" id="cmplDt" class="input_text4 center" value="${cmplDt}" readonly="true"/>
		                    	</td>
		                    </tr>
		                    </c:if>
						</table>
						
					</div>
				</form>
					
				<ul class="btn_rt01">
					<li class="btn_sty04">
						<a href="javascript:fn_Mod()">수정</a>
					</li>
					<li class="btn_sty01">
						<a href="<c:url value='/oss/nbbs/bbsDtl.do'/>?bbsNum=${notice.bbsNum}&noticeNum=${notice.noticeNum}&pageIndex=${searchVO.pageIndex}&sKeyOpt=${searchVO.sKeyOpt}&sKey=${searchVO.sKey}">취소</a>
					</li>
				</ul>
					
				<!-- --------------------------------------------------- -->
					
			</div>
		</div>
	</div>
	<!--//Contents 영역--> 
</div>
</body>
</html>