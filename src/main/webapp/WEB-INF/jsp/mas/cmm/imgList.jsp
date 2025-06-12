<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript" src="<c:url value='/dext5upload/js/dext5upload.js'/>"></script>

<script type="text/javascript">

function fn_InsPrdtImg(){
	//if($("#egovComFileList>div").length == 0){
	//	alert("이미지를 선택해주세요");
	//	return;
	//}

	if (DEXT5UPLOAD.GetTotalFileCount("upload1") == 0) {
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
	document.prdtImg.action = "<c:url value='/mas/cmm/insertPrdtImg.do'/>";
	document.prdtImg.submit();
}

/**
 * 이미지 순번 변경
 */
function fn_snOnchange(obj, sn_old, imgNum){
	document.prdtImg.newSn.value      = obj.value;
	document.prdtImg.oldSn.value      = sn_old;
	document.prdtImg.imgNum.value     = imgNum;
	document.prdtImg.action = "<c:url value='/mas/cmm/updatePrdtImg.do'/>";
	document.prdtImg.submit();
}

/**
 * 이미지 삭제
 */
function fn_delPrdtImg(imgSn, imgNum){
	document.prdtImg.imgSn.value = imgSn;
	document.prdtImg.imgNum.value = imgNum;
	document.prdtImg.action = "<c:url value='/mas/cmm/deletePrdtImg.do'/>";
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
	 var maxFileNum = 1;
	 var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
	 multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
}

$(document).ready(function(){
	//makeFileAttachment();
});
</script>

<!--본문-->
<!--상품 등록-->
<form:form name="prdtImg" method="post">
	<div class="register_area">
	<!-- <h2 class="title02">상품 이미지 관리</h2> -->
		<input type="hidden" name="newSn" value="0"/>
		<input type="hidden" name="oldSn" value="0"/>
		<input type="hidden" name="linkNum" value="<c:out value='${CM_IMGVO.linkNum}'/>"/>
		<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
		<input type="hidden" name="imgNum" value=""/>
		<input type="hidden" name="imgSn" value=""/>
		<input type="hidden" name="fileList" id="fileList" />

		<ul class="gallery_list">
			<%-- 데이터를 없을때 화면에 메세지를 출력해준다 --%>
			<c:if test="${fn:length(resultList) == 0}">
				이미지가 없습니다.
			</c:if>

			<c:forEach var="result" items="${resultList}" varStatus="status">
				<li>
					<span class="photo"><img src="${result.savePath}thumb/${result.saveFileNm}" alt="" width="250" /></span>
					<ul class="info">
						<li>
							<strong>순번</strong>
							<input type="hidden" name="sn_old" value="${result.imgSn}" />
							<select style="width:70px" name="sn_new" onchange="fn_snOnchange(this, ${result.imgSn}, ${result.imgNum})">
							<c:forEach var="cnt" begin="1" end="${fn:length(resultList)}">
								<option value="${cnt}" <c:if test="${cnt == result.imgSn}">selected="selected"</c:if>>${cnt}</option>
							</c:forEach>
						</select>
						</li>
						<li class="btn button_rt03">
							<div class="btn_sty07">
								<span><a href="javascript:fn_delPrdtImg('${result.imgSn}', '${result.imgNum}')">삭제</a></span>
							</div>
						</li>
					</ul>
				</li>
			</c:forEach>
		</ul>
	</div>
	<div class="register_area">
		<h4 class="title02">상품목록 이미지 등록
			<span class="font02">
				(이미지 등록 사이즈 :
				<c:if test="${corpCd == 'ad' }">1200*1200</c:if>
				<c:if test="${corpCd == 'sp' or corpCd == 'sv' }">545*545</c:if>)
			</span>
		</h4>
		<table border="1" class="table02">
			<colgroup>
				<col/>
			</colgroup>
			<tbody>
				<tr>
					<td>
					<script type="text/javascript">
						DEXT5UPLOAD.config.HandlerUrl = "<c:url value='/mas/dext/uploadHandler.dext'/>";
						//DEXT5UPLOAD.config.Security.EncryptParam = '0';
						DEXT5UPLOAD.config.UseFileSort='1';
						DEXT5UPLOAD.config.ButtonBarEdit="add,remove,remove_all,move_first,move_forward,move_backward,move_end";

						var upload1 = new Dext5Upload("upload1");
					</script>
					</td>
				</tr>
			</tbody>
		</table>
		<ul class="btn_rt01">
			<li class="btn_sty04"><a href="javascript:fn_InsPrdtImg()">등록</a></li>
			<c:if test="${corpCd != 'gl' }">
				<li class="btn_sty02"><a href="javascript:fn_PrdtList()">목록</a></li>
			</c:if>
		</ul>
	</div>
</form:form>
<!--//상품등록-->
<!--//본문-->
