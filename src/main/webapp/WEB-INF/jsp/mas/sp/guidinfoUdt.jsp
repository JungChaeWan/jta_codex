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
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=71cf66fb54158dacb5fb5b656674ad70&libraries=services"></script>


<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />

<title>탐나오 관리자 시스템 > 상품관리</title>
<script type="text/javascript">

//탭 이동
function fn_goTap(menu) {
	if(menu == "PRODUCT") {
		document.tabForm.action="<c:url value='/mas/sp/viewUpdateSocial.do' />";
	} else if( menu == "IMG") {
		document.tabForm.action="<c:url value='/mas/sp/imgList.do' />";
	} else if(menu == "IMG_DETAIL") {
		document.tabForm.action="<c:url value='/mas/sp/dtlImgList.do' />";
	} else if(menu == "OPTION") {
		document.tabForm.action="<c:url value='/mas/sp/viewOption.do' />";
	} else if(menu == "ADD_OPTION") {
		document.tabForm.action="<c:url value='/mas/sp/viewAddOption.do' />";
	} else if(menu == "DTLINF") {
		document.tabForm.action="<c:url value='/mas/sp/dtlinfList.do' />";
	}

	document.tabForm.submit();
}


/**
 * DAUM 연동 주소찾기
 */
function openDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            // 우편번호와 주소 정보를 해당 필드에 넣고, 커서를 상세주소 필드로 이동한다.
            // document.getElementById('post1').value = data.postcode1;
            // document.getElementById('post2').value = data.postcode2;
            // 2015.08.01 부터 우편번호 5자리 실행
            // document.getElementById('postNum').value = data.zonecode;
            document.getElementById('roadNmAddr').value = data.address;

            //전체 주소에서 연결 번지 및 ()로 묶여 있는 부가정보를 제거하고자 할 경우,
            //아래와 같은 정규식을 사용해도 된다. 정규식은 개발자의 목적에 맞게 수정해서 사용 가능하다.
            //var addr = data.address.replace(/(\s|^)\(.+\)$|\S+~\S+/g, '');
            //document.getElementById('addr').value = addr;

            document.getElementById('dtlAddr').focus();
        }
    }).open();
}



function fn_Udt() {

	if($("#telnum").val() == ""){
		alert("전화번호를 입력하세요.");
		$("#telnum").focus();
		return;
	}

	if($("#roadNmAddr").val() == ""){
		alert("주소를 입력하세요.");
		$("#roadNmAddr").focus();
		return;
	}


	document.frm.action = "<c:url value='/mas/sp/guidinfUdt.do'/>";
	document.frm.submit();
}


$(document).ready(function(){
	//fn_ChangeType('${SP_DTLINFVO.dtlinfType}');

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

				<h2 class="title08"><c:out value="${spPrdtInf.prdtNm}"/></h2>

				<%--
				<div id="menu_depth3">
						<ul>
		                   <li><a class="menu_depth3" href="javascript:fn_goTap('PRODUCT');">상품정보</a></li>
		                   <li><a class="menu_depth3" href="javascript:fn_goTap('IMG');" >상품목록이미지</a></li>
		                    <li ><a class="menu_depth3" href="javascript:fn_goTap('IMG_DETAIL');" >상세이미지</a></li>
		                    <li class="on"><a class="menu_depth3" href="javascript:fn_goTap('DTLINF');" >상세정보</a></li>
		                    <c:if test="${prdtDiv ne Constant.SP_PRDT_DIV_FREE }">
		                   <li><a class="menu_depth3" href="javascript:fn_goTap('OPTION');" >옵션설정</a></li>
		                   <li><a class="menu_depth3" href="javascript:fn_goTap('ADD_OPTION');" >추가옵션설정</a></li>
		                   </c:if>
		               </ul>
		               <div class="btn_rt01">
		              	 	<c:if test="${Constant.TRADE_STATUS_REG eq btnApproval}">
		               		<div class="btn_sty01"><a href="javascript:fn_approvalReqSocial();">승인요청</a></div>
		              		</c:if>
		               		<c:if test="${Constant.TRADE_STATUS_APPR_REQ eq btnApproval }">
		               		<div class="btn_sty01"><a href="javascript:fn_approvalCancelSocial();">승인취소</a></div>
		               		</c:if>
		               </div>
		         </div>
		          --%>

	            <!--본문-->
	            <form:form commandName="frm" name="frm" method="post">
	            	<input type="hidden" name="prdtNum"  value="${spPrdtInf.prdtNum }"/>
	            	<input type="hidden" name="subject"  value=""/>
					<input type="hidden" name="pageIndex"  value="${searchVO.pageIndex}"/>

					<div id="contents">
						<div class="register_area">
							<h4 class="title02">안내사항</h4>

							<table border="1" class="table02">
								<colgroup>
			                        <col width="200" />
			                        <col width="*" />
			                        <col width="200" />
			                        <col width="*" />
			                    </colgroup>

								<tr>
									<th scope="row">출력여부</th>
									<td colspan="3">
										<input type="radio" name="printYn" id="printYn1" value="Y" <c:if test="${SP_GUIDINFO.printYn=='Y' or empty SP_GUIDINFO.printYn}">checked="checked"</c:if> /> <label for="printYn1">사용</label>
										<input type="radio" name="printYn" id="printYn2" value="N" <c:if test="${SP_GUIDINFO.printYn=='N'}">checked="checked"</c:if> /> <label for="printYn2">미사용</label>

									</td>
								</tr>
								<tr>
									<th>전화번호<span class="font_red">*</span></th>
									<td colspan="3">
										<input type="text" name="telnum" id="telnum"  class="input_text30" maxlength="60" value="${SP_GUIDINFO.telnum}"/>
									</td>
								</tr>
								<tr>
									<th>주소<span class="font_red">*</span></th>
									<td colspan="3">
										<div class="btn_sty07"><span><a href="javascript:openDaumPostcode()">주소검색</a></span></div>
										<input type="text" name="roadNmAddr" id="roadNmAddr"  class="input_text30" maxlength="60" value="${SP_GUIDINFO.roadNmAddr}"/>
										<input type="text" name="dtlAddr" id="dtlAddr"  class="input_text15" maxlength="60" value="${SP_GUIDINFO.dtlAddr}"/>
									</td>
								</tr>

								<tr>
									<th>상품설명<span class="font_red"></span></th>
									<td colspan="3">
										<textarea name="prdtExp" id="prdtExp" cols="15" rows="10">${SP_GUIDINFO.prdtExp}</textarea>
									</td>
								</tr>

								<%-- <tr>
									<th>사용조건<span class="font_red"></span></th>
									<td colspan="3">
										<textarea name="useQlfct" id="useQlfct" cols="15" rows="10">${SP_GUIDINFO.useQlfct}</textarea>
									</td>
								</tr> --%>

								<tr>
									<th>이용안내<span class="font_red"></span></th>
									<td colspan="3">
										<textarea name="useGuide" id="useGuide" cols="15" rows="10">${SP_GUIDINFO.useGuide}</textarea>
									</td>
								</tr>

								<%-- <tr>
									<th>취소/환불안내<span class="font_red"></span></th>
									<td colspan="3">
										<textarea name="cancelRefundGuide" id="cancelRefundGuide" cols="15" rows="10">${SP_GUIDINFO.cancelRefundGuide}</textarea>
									</td>
								</tr> --%>

							</table>

							<ul class="btn_rt01 align_ct">
								<li class="btn_sty04">
									<a href="javascript:fn_Udt()">저장</a>
								</li>
								<li class="btn_sty01">
									<a href="<c:url value='/mas/sp/dtlinfList.do'/>?prdtNum=${spPrdtInf.prdtNum }&pageIndex=${searchVO.pageIndex}">뒤로</a>
									<!-- <a href="javascript:history.back();">뒤로</a> -->
								</li>
							</ul>

						</div>

					</div>
				</form:form>

	            <!--//본문-->
	        </div>
	     </div>
	</div>
	<form name="tabForm">
		<input type="hidden" name="prdtNum"  value="${spPrdtInf.prdtNum }"/>
	</form>
	<!--//Contents 영역-->
</div>
</body>
</html>