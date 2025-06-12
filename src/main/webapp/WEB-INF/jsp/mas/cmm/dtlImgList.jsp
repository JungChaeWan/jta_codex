
<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">

function fn_InsPrdtImg(pcYN){
	
	if(pcYN=='Y'){
		if($("#dtlImgPC").val() == ""){
			alert("이미지를 선택해주세요");
			return;
		}
		document.prdtImg.imgSn.value = document.prdtImg.imgSnPC.value;
		
	}else{
		if($("#dtlImgM").val() == ""){
			alert("이미지를 선택해주세요");
			return;
		}
		document.prdtImg.imgSn.value = document.prdtImg.imgSnM.value;
	
	}
	
	document.prdtImg.pcImgYn.value     = pcYN;	
	document.prdtImg.action = "<c:url value='/mas/cmm/insertPrdtDtlImg.do'/>";
	document.prdtImg.submit();
}

/**
 * 이미지 순번 변경
 */
function fn_snOnchange(obj, sn_old, imgNum, pcYN){
	
	document.prdtImg.newSn.value      = obj.value;
	document.prdtImg.oldSn.value      = sn_old;
	document.prdtImg.imgNum.value     = imgNum;
	document.prdtImg.pcImgYn.value    = pcYN;
	document.prdtImg.action = "<c:url value='/mas/cmm/updatePrdtDtlImg.do'/>";
	document.prdtImg.submit();
}

/**
 * 이미지 삭제
 */
function fn_delPrdtImg(imgSn, imgNum, pcYN){
	document.prdtImg.imgSn.value = imgSn;
	document.prdtImg.imgNum.value = imgNum;
	document.prdtImg.pcImgYn.value    = pcYN;
	document.prdtImg.action = "<c:url value='/mas/cmm/deletePrdtDtlImg.do'/>";
	document.prdtImg.submit();
}

/**
 * 목록
 */
 function fn_PrdtList(){
	document.prdtImg.action = "<c:url value='/mas/${corpCd}/productList.do'/>";
	document.prdtImg.submit();
}

/**
 * file init
 */
function makeFileAttachment(){

	 //var maxFileNum = 1;
	 //var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList1' ), maxFileNum );
	 //multi_selector.addElement( document.getElementById( 'dtlImgPC' ) );
	 
	 //var maxFileNum = 1;
	 //var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList2' ), maxFileNum );
	 //multi_selector.addElement( document.getElementById( 'dtlImgM' ) );
}

$(document).ready(function(){
	makeFileAttachment();
});

function checkFile(fileSize){
	var file = fileSize.files;
	
	if(file[0].size > 1024 * 1024 * 5){
		alert('5MB 이하 파일만 등록할 수 있습니다.\n\n' + '현재파일 용량 : ' + (Math.round(file[0].size / 1024 / 1024 * 100) / 100) + 'MB');
	}
	
	else return;
	
	fileSize.outerHTML = fileSize.outerHTML;
}
</script>
            <!--본문-->
            <!--상품 등록-->
            <form:form commandName="prdtImg" name="prdtImg" method="post" enctype="multipart/form-data">
	            <div class="register_area">
	                <!-- <h2 class="title02">상품 이미지 관리</h2> -->
						<input type="hidden" name="newSn" value="0"/>
						<input type="hidden" name="oldSn" value="0"/>
						<input type="hidden" name="linkNum" value="<c:out value='${CM_DTLIMGVO.linkNum}'/>"/>
						<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
						<input type="hidden" name="imgNum" />
						<input type="hidden" name="pcImgYn" value=""/>
						<input type="hidden" name="imgSn" value=""/>
	             </div>
	             <div class="register_area">
	             	
	             	<h4 class="title02">PC용 이미지</h4>
		            <table border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
		            	<colgroup>
							<col width="230" />
							<col width="*" />
                            <col width="170" />
                            <col width="170" />
						</colgroup>
						<thead>
							<tr>
								<th>파일순번</th>
								<th>파일명</th>
								<th></th>
								<th>순번변경</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${fn:length(imgListPC) == 0}">
								<tr>
									<td colspan="4" class="align_ct">
										이미지를 등록 하세요.
									</td>
								</tr>
							</c:if>
							<c:forEach var="result" items="${imgListPC}" varStatus="status">
								<tr>
								
									<td class="align_ct">
										${result.imgSn}
									</td>
									<td class="align_ct">
										<c:out value="${result.realFileNm}"/> 
									</td>
									<td class="align_ct">
										<div class="btn_sty06"><span><a href="${result.savePath}${result.saveFileNm}" target="_blank">보기</a></span></div>
										<div class="btn_sty09"><span><a href="javascript:fn_delPrdtImg(${result.imgSn}, '${result.imgNum}', 'Y')">삭제</a></span></div>
									</td>
									<td class="align_ct">
			              				<input type="hidden" name="sn_old" value="${result.imgSn}" />
			              				<select style="width:70px" name="sn_new" onchange="fn_snOnchange(this, ${result.imgSn}, ${result.imgNum}, 'Y')">
										<c:forEach var="cnt" begin="1" end="${fn:length(imgListPC)}">
											<option value="${cnt}" <c:if test="${cnt == result.imgSn}">selected="selected"</c:if>>${cnt}</option>
										</c:forEach>
										</select>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
	             </div>
	             <br/>
	             <div class="register_area">
					<table border="1" class="table02">
						<colgroup>
							<col width="230" />
							<col width="*" />
                            <col width="170" />
                            <col width="170" />
						</colgroup>
						<tr>
							<th scope="row">PC용 이미지 등록</th>
								<c:if test="${fn:length(imgListPC) >= 5}">
									<td colspan="3">
										PC용 이미지는 5개까지 등록 할 수 있습니다.
									</td>
								</c:if>
								<c:if test="${fn:length(imgListPC) < 5}">
									<td>
										<div id="egovComFileList2"></div>
									<input type="file" id="dtlImgPC" name="dtlImgPC" accept="image/*" onchange="checkFile(this);" style="width: 70%" /><span class="font02">사이즈 : 가로 700px</span>
										<br /><c:if test="${not empty fileErrorPC}">Error:<c:out value="${fileErrorPC}"/></c:if>
									</td>
									<td class="align_ct">
										<label for="">순번</label>
										<select style="width:70px" name="imgSnPC">
											<c:forEach var="cnt" begin="1" end="${fn:length(imgListPC)+1}">
												<option value="${cnt}" <c:if test="${cnt == fn:length(imgListPC)+1}">selected="selected"</c:if>>${cnt}</option>
											</c:forEach>
										</select>
									</td>
									<td>
										<li class="btn_sty04"><a href="javascript:fn_InsPrdtImg('Y')">등록</a></li>
									</td>
								</c:if>
						</tr>
					</table>
	            </div>
	            <div class="register_area">
	             	<h4 class="title02">모바일용 이미지</h4>
		            <table border="1" cellspacing="0" cellpadding="0" class="table01 list_tb">
		            	<colgroup>
							<col width="230" />
							<col width="*" />
                            <col width="170" />
                            <col width="170" />
						</colgroup>
						<thead>
							<tr>
								<th>파일순번</th>
								<th>파일명</th>
								<th></th>
								<th>순번변경</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${fn:length(imgListM) == 0}">
								<tr>
									<td colspan="4" class="align_ct">
										이미지를 등록 하세요.
									</td>
								</tr>
							</c:if>
							<c:forEach var="result" items="${imgListM}" varStatus="status">
								<tr>
									<td class="align_ct">
										${result.imgSn}
									</td>
									<td class="align_ct">
										<c:out value="${result.realFileNm}"/>
									</td>
									<td class="align_ct">
										<div class="btn_sty06"><span><a href="${result.savePath}${result.saveFileNm}" target="_blank">보기</a></span></div>
										<div class="btn_sty09"><span><a href="javascript:fn_delPrdtImg(${result.imgSn}, '${result.imgNum}', 'N')">삭제</a></span></div>
									</td>
									<td class="align_ct">
			              				<input type="hidden" name="sn_old" value="${result.imgSn}" />
			              				<select style="width:70px" name="sn_new" onchange="fn_snOnchange(this, ${result.imgSn}, ${result.imgNum}, 'N')">
										<c:forEach var="cnt" begin="1" end="${fn:length(imgListM)}">
											<option value="${cnt}" <c:if test="${cnt == result.imgSn}">selected="selected"</c:if>>${cnt}</option>
										</c:forEach>
										</select>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
	             </div>
	             <br/>
	             <div class="register_area">
					<table border="1" class="table02">
						<colgroup>
							<col width="230" />
							<col width="*" />
                            <col width="170" />
                            <col width="170" />
						</colgroup>
						<tr>
							<th scope="row">모바일용 이미지 등록</th>
								<c:if test="${fn:length(imgListM) >= 5}">
									<td colspan="3">
										모바일용 이미지는 5개까지 등록 할 수 있습니다.
									</td>
								</c:if>
								<c:if test="${fn:length(imgListM) < 5}">
									<td>
										<div id="egovComFileList2"></div>
										<input type="file" id="dtlImgM" name="dtlImgM" accept="image/*" onchange="checkFile(this);" style="width: 70%" /><span class="font02">사이즈 : 가로 700px</span>
										<br /><c:if test="${not empty fileErrorM}">Error:<c:out value="${fileErrorM}"/></c:if>
									</td>
									<td class="align_ct">
										<label for="">순번</label>
										<select style="width:70px" name="imgSnM">
											<c:forEach var="cnt" begin="1" end="${fn:length(imgListM)+1}">
												<option value="${cnt}" <c:if test="${cnt == fn:length(imgListM)+1}">selected="selected"</c:if>>${cnt}</option>
											</c:forEach>
										</select>
									</td>
									<td>
										<li class="btn_sty04"><a href="javascript:fn_InsPrdtImg('N')">등록</a></li>
									</td>
								</c:if>
						</tr>
					</table>
	            </div>
            	<div class="register_area">
	                <ul class="btn_rt01">
		                    <li class="btn_sty02"><a href="javascript:fn_PrdtList()">목록</a></li>
	                </ul>
	            </div>
            </form:form>
            <!--//상품등록--> 
            <!--//본문-->