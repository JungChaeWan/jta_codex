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
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/dext5upload/js/dext5upload.js'/>"></script>


<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />

<title></title>
<script type="text/javascript">

function fn_InsPrdtImg(){
	/*if($("#egovComFileList>div").length == 0){
		alert("이미지를 선택해주세요");
		return;
	}*/
	
	if(DEXT5UPLOAD.GetTotalFileCount("upload1") == 0) {
		alert("이미지를 선택해주세요");
		return;
	} else {
		DEXT5UPLOAD.Transfer("upload1");
	}
}

function DEXT5UPLOAD_OnTransfer_Complete() {
	if (DEXT5UPLOAD.GetNewUploadListForText()) {
		 var jsonFileList = DEXT5UPLOAD.GetNewUploadListForJson("upload1");
		 document.getElementById("fileList").value = jsonFileList.uploadPath;
	 }
	//DB 처리를 하는 페이지로 전송합니다.
	document.prdtImg.action = "<c:url value='/mas/ad/insertAdInfoImg.do'/>";
	document.prdtImg.submit();
}

/**
 * 이미지 순번 변경
 */
function fn_snOnchange(obj, sn_old, imgNum){
	document.prdtImg.newSn.value      = obj.value;
	document.prdtImg.oldSn.value      = sn_old;
	document.prdtImg.imgNum.value     = imgNum;
	document.prdtImg.action = "<c:url value='/mas/ad/updateAdInfoImg.do'/>";
	document.prdtImg.submit();
}

/**
 * 이미지 삭제
 */
function fn_delPrdtImg(imgSn, imgNum){
	document.prdtImg.imgSn.value = imgSn;
	document.prdtImg.imgNum.value = imgNum;
	document.prdtImg.action = "<c:url value='/mas/ad/deleteAdInfoImg.do'/>";
	document.prdtImg.submit();
}

/**
 * file init
 */
function makeFileAttachment(){
	 var maxFileNum = 1;
	 var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
	 multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
}


$(document).ready(function(){
	//makeFileAttachment();
	
	if('${errorCode}' == '1'){
		alert("숙소 정보 먼저 등록 하세요.");
		//history.back();
		document.frm.action = "<c:url value='/mas/ad/adInfo.do' />";
		document.frm.submit();
		
	}
});
</script>
</head>
<body>
<div id="wrapper"> 
	<jsp:include page="/mas/head.do?menu=corp" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area">
			<div id="contents"> 
				<h4 class="title03">이미지등록(외관/부대시설위주)</h4>
	            <!--본문-->
	            <!--상품 등록-->
	            <form:form commandName="prdtImg" name="prdtImg" method="post">
	            <div class="register_area">
	                <!-- <h2 class="title02">상품 이미지 관리</h2> -->                	
						<input type="hidden" name="newSn" value="0"/>
						<input type="hidden" name="oldSn" value="0"/>
						<input type="hidden" name="linkNum" value="${linkNum}"/>
						<!-- <input type="hidden" name="linkNum" value="<c:out value='${CM_IMGVO.linkNum}'/>"/> -->
						<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
						<input type="hidden" name="imgNum" value="" />
						<input type="hidden" name="imgSn" value=""/>
						<input type="hidden" name="fileList" id="fileList" />
	                <ul class="gallery_list">
	                    <%-- 데이터를 없을때 화면에 메세지를 출력해준다 --%>
						<c:if test="${fn:length(resultList) == 0}">
							<!--<spring:message code="common.nodata.msg" />-->
							이미지가 없습니다.
						</c:if>
						<c:forEach var="result" items="${resultList}" varStatus="status">
	          				<li><span class="photo"><img src="${result.savePath}thumb/${result.saveFileNm}" alt="" width="250" /></span>
		            			<ul class="info">
			              			<li><strong>순번</strong>
			              				<input type="hidden" name="sn_old" value="${result.imgSn}" />
			              				<select style="width:70px" name="sn_new" onchange="fn_snOnchange(this, ${result.imgSn}, ${result.imgNum})">
										<c:forEach var="cnt" begin="1" end="${fn:length(resultList)}">
											<option value="${cnt}" <c:if test="${cnt == result.imgSn}">selected="selected"</c:if>>${cnt}</option>
										</c:forEach>
									</select>
			              			</li>
			              			<li class="btn button_rt03"><div class="btn_sty07"><span> <a href="javascript:fn_delPrdtImg(${result.imgSn}, '${result.imgNum}')">삭제</a></span></div></li>
		            			</ul>
	         				</li>
	       				</c:forEach>
						
	                </ul>
	             </div>
	             <div class="register_area">
					<h4 class="title02">상품 이미지 등록 <span class="font02">(이미지 등록 사이즈 : 1200*1200)</span></h4>
					<table border="1" class="table02">
						<tr>
							<td>
								<script type="text/javascript">
								DEXT5UPLOAD.config.HandlerUrl = "<c:url value='/mas/dext/uploadHandler.dext'/>";
								//DEXT5UPLOAD.config.Security.EncryptParam = '0';
								DEXT5UPLOAD.config.UseFileSort='1';
								
								var upload1 = new Dext5Upload("upload1");
								</script>
								<br /><c:if test="${not empty fileError}">Error:<c:out value="${fileError}"/></c:if>
							</td>
						</tr>
					</table>
	                <ul class="btn_rt01">
	                    <li class="btn_sty04"><a href="javascript:fn_InsPrdtImg()">등록</a></li>
	                </ul>
	            </div>
	            </form:form>
	            <!--//상품등록--> 
	            <!--//본문--> 
	        </div>
        </div>
	</div>
	<!--//Contents 영역--> 
</div>
</body>
</html>