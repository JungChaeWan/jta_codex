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
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/dext5editor/js/dext5editor.js'/>"></script>

<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=71cf66fb54158dacb5fb5b656674ad70&libraries=services"></script>

<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mas/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>

<script type="text/javascript">
/**
 * 상품 기본 정보 수정
 */
function fn_Udt(){

	document.frm.action = "<c:url value='/mas/sv/updateSvDftinf.do' />";
	document.frm.submit();
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
            document.getElementById('directrecvRoadNmAddr').value = data.address;

            //전체 주소에서 연결 번지 및 ()로 묶여 있는 부가정보를 제거하고자 할 경우,
            //아래와 같은 정규식을 사용해도 된다. 정규식은 개발자의 목적에 맞게 수정해서 사용 가능하다.
            //var addr = data.address.replace(/(\s|^)\(.+\)$|\S+~\S+/g, '');
            //document.getElementById('addr').value = addr;

            document.getElementById('directrecvDtlAddr').focus();
        }
    }).open();
}

/**
 * 주소에 따른 경도 위도 구하기
 */
function fn_FindLocation(){
	var addr = $("#directrecvRoadNmAddr").val();

	if(isNull(addr)){
		alert("주소를 입력해주세요.");
		$("#directrecvRoadNmAddr").focus();
		return;
	}
	var geocoder = new daum.maps.services.Geocoder();

    var callback = function(result, status) {
	    if(status === daum.maps.services.Status.OK){
            var lat = result[0].y
            var lng = result[0].x

	    	$("#directrecvLon").val(lng);
			$("#directrecvLat").val(lat);
	    }else{
	    	if(status === daum.maps.services.Status.ZERO_RESULT){
	    		alert("해당 주소에 대한 결과값이 없습니다.");
				return;
	    	}else if(status === daum.maps.services.Status.RESULT_NOT_FOUND){
	    		alert("해당 주소에 대한 결과값이 없습니다.");
				return;
	    	}else{
	    		alert("API 응답불가, 관리자에게 문의하세요.");
				return;
	    	}
	    }
	};
    geocoder.addressSearch(addr, callback);
}


function openDaumPostcode1() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            // 우편번호와 주소 정보를 해당 필드에 넣고, 커서를 상세주소 필드로 이동한다.
            // document.getElementById('post1').value = data.postcode1;
            // document.getElementById('post2').value = data.postcode2;
            // 2015.08.01 부터 우편번호 5자리 실행
            // document.getElementById('postNum').value = data.zonecode;
            document.getElementById('tkovRoadNmAddr1').value = data.address;

            //전체 주소에서 연결 번지 및 ()로 묶여 있는 부가정보를 제거하고자 할 경우,
            //아래와 같은 정규식을 사용해도 된다. 정규식은 개발자의 목적에 맞게 수정해서 사용 가능하다.
            //var addr = data.address.replace(/(\s|^)\(.+\)$|\S+~\S+/g, '');
            //document.getElementById('addr').value = addr;

            document.getElementById('tkovDtlAddr1').focus();
        }
    }).open();
}



$(function() {

});

</script>
</head>
<body>
<div id="wrapper">
	<jsp:include page="/mas/head.do?menu=corp" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<div id="contents_area">
			<!--본문-->
			<!--상품 수정-->
			<form  name="frm" method="post" >

			<div id="contents">

				<h4 class="title03">직접수령위치</h4>
				<table border="1" class="table02">
					<colgroup>
                        <col width="200" />
                        <col width="*" />
                        <col width="200" />
                        <col width="*" />
                    </colgroup>

					<tr>
						<th scope="row">직접수령위치<span class="font_red"></span></th>
						<td colspan="3">
							주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소:
							<div class="btn_sty07"><span><a href="javascript:openDaumPostcode()">주소검색</a></span></div>
							<input name="directrecvRoadNmAddr" id="directrecvRoadNmAddr"  class="input_text30" readonly="readonly" value="${svDftinfo.directrecvRoadNmAddr}" />
							<input name="directrecvDtlAddr" id="directrecvDtlAddr"  class="input_text15" value="${svDftinfo.directrecvDtlAddr}" maxlength="100" />
							<br/>
							위도/경도:
							<div class="btn_sty07"><span><a href="javascript:fn_FindLocation()">좌표찾기</a></span></div>
							위도 : <input name="directrecvLon" id="directrecvLon" value="${svDftinfo.directrecvLon}" readonly="readonly" />
							경도 : <input name="directrecvLat" id="directrecvLat" value="${svDftinfo.directrecvLat}" readonly="readonly" />
						</td>


					</tr>
				</table>

				<ul class="btn_rt01 align_ct">
					<li class="btn_sty04">
						<a href="javascript:fn_Udt()">수정</a>
					</li>
				</ul>
			</div>
			</form>
			<!--//상품등록-->
			<!--//본문-->
		</div>
	</div>
	<!--//Contents 영역-->
</div>
</body>
</html>