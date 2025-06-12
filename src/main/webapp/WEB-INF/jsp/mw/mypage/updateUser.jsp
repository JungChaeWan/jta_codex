<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 			uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
<%@ taglib prefix="validator" 	uri="http://www.springmodules.org/tags/commons-validator" %>

<un:useConstants var="Constant" className="common.Constant" />
<head>
<meta name="robots" content="noindex, nofollow">
<jsp:include page="/mw/includeJs.do"></jsp:include>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common2.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/style.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub_mypage.css'/>">

<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>

<validator:javascript formName="UPDATEUSERVO" staticJavascript="false" xhtml="true" cdata="true"/>
<script type="text/javascript">

$(document).ready(function(){
	
	/*
	// 휴대폰번호 변경 레이어팝업
	$(".comm-btn").click(function(){
		$('body').after('<div class="lock-bg"></div>'); // 검은 불투명 배경
		$('body').addClass('not_scroll');
	});
	*/
	
	$(".btn-close img").click(function(){
		$(".lock-bg").remove();
		$(".not_scroll").removeClass();
	});

	element_layer = document.getElementById("layer");

	if("${resultCd}" == "Y") {
		alert("<spring:message code='success.common.update' />");
	} else if("${resultCd}" == "N") {
		alert("<spring:message code='fail.common.update' />");
	}
});

//우편번호 찾기 화면을 넣을 element
var element_layer;

function closeDaumPostcode() {
    // iframe을 넣은 element를 안보이게 한다.
    element_layer.style.display = 'none';
}

function initLayerPosition(){
    var width = '100%'; //우편번호서비스가 들어갈 element의 width
    var height = '100%'; //우편번호서비스가 들어갈 element의 height
    var borderWidth = 5; //샘플에서 사용하는 border의 두께

    // 위에서 선언한 값들을 실제 element에 넣는다.
    // $("#layer").prop("width", width + 'px');
    // $("#layer").prop("height", height + 'px');
    // $("#layer").prop("border", borderWidth + 'px solid');
    // $("#layer").prop("left", (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px');
    // $("#layer").prop("top", (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px');
    element_layer.style.width = width;
    element_layer.style.height = height;
    element_layer.style.border = borderWidth + 'px solid';
    // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
    // element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
    // element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
}

function sample2_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var fullAddr = data.address; // 최종 주소 변수
            var extraAddr = ''; // 조합형 주소 변수

            // 기본 주소가 도로명 타입일때 조합한다.
            if(data.addressType === 'R'){
                //법정동명이 있을 경우 추가한다.
                if(data.bname !== ''){
                    extraAddr += data.bname;
                }
                // 건물명이 있을 경우 추가한다.
                if(data.buildingName !== ''){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postNum').value = data.zonecode; //5자리 새우편번호 사용
            document.getElementById('roadNmAddr').value = fullAddr;
            // document.getElementById('sample2_addressEnglish').value = data.addressEnglish;

            // iframe을 넣은 element를 안보이게 한다.
            // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
            element_layer.style.display = 'none';
        },
        width : '100%',
        height : '100%'
    }).embed(element_layer);

    // iframe을 넣은 element를 보이게 한다.
    // $("#layer").prop("display", "block");
    element_layer.style.display = 'block';

    // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
    initLayerPosition();
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
            document.getElementById('postNum').value = data.zonecode;
            document.getElementById('roadNmAddr').value = data.address;

            //전체 주소에서 연결 번지 및 ()로 묶여 있는 부가정보를 제거하고자 할 경우,
            //아래와 같은 정규식을 사용해도 된다. 정규식은 개발자의 목적에 맞게 수정해서 사용 가능하다.
            //var addr = data.address.replace(/(\s|^)\(.+\)$|\S+~\S+/g, '');
            //document.getElementById('addr').value = addr;

            document.getElementById('dtlAddr').focus();
        }
    }).open();
}

function openPhonePopup() {
	$(".modal").show();
	$('.pop-seller, #cover').fadeToggle();
}

function closePhonePopup() {
	$(".modal").removeAttr("style").hide();
	$('.pop-seller, #cover').fadeToggle();
}

var phoneNum;

function fn_SendSms() {
    var hp = $("#hp").val();

    if(hp == null || hp == "") {
        alert("<spring:message code='errors.required2' arguments='휴대폰번호' />");
        return;
    }
	if(checkIsHP(hp)) {
        var parameters = "telNum=" + hp;

        $.ajax({
            type:"post",
            dataType:"json",
            url:"<c:url value='/web/getAuthNum.ajax'/>",
            data:parameters,
            success:function(data){
                if(data.success == "Y") {
                    alert("<spring:message code='success.send.certNum'/>");

                    phoneNum = hp;
                    $("#hp").val(hp);
                    $(".msg").show();
                } else {
                    alert(data.failMsg);
                }
            }
        });
	} else {
        alert("<spring:message code='errors.phone'/>");
        $("#hp").focus();
	}
}

//인증번호 체크
function fn_Cert() {
	
    var certNum = $("#certNumber").val();
    if(certNum == null || certNum == "") {
        alert("<spring:message code='errors.required2' arguments='인증번호' />");
        return;
    }
    
    var parameters = "telNum=" + phoneNum;
    parameters += "&authNum=" + certNum;
	
    $.ajax({
        type:"post",
        dataType:"json",
        url:"<c:url value='/web/checkAuthNum.ajax'/>",
        data:parameters,
        success:function(data){
            if(data.success == "Y"){
                alert("<spring:message code='success.phone.cert' />");

                $("#telNum").val(phoneNum);
                $("#telNumView").html(phoneNum);
                /*
                $(".pop-seller").hide();
                $("#cover").hide();
                */
                $(".phoneCheckLayer").hide();
            }else{
                alert(data.failMsg);
            }
        }
    });
}

// SNS 연동해제
function fn_SnsUnlink(val) {
    if(confirm("<spring:message code='confirm.sns.unlink'/> ")) {
        $("#snsDiv").val(val);

        if(val == "N") {
            fn_NaverUnlink();
        } else {
            fn_KakaoUnlink();
        }
    }
}

// 네이버 로그인 연동해제
function fn_NaverUnlink() {
    document.UPDATEUSERVO.action = "<c:url value='/mw/naverUnlink.do'/>";
    document.UPDATEUSERVO.submit();
}

// 카카오 로그인 연동해제
function fn_KakaoUnlink() {
    document.UPDATEUSERVO.action = "<c:url value='/mw/kakaoUnlink.do'/>";
    document.UPDATEUSERVO.submit();
}

function fn_UdtUser() {
	// validation 체크
	if(!validateUPDATEUSERVO(document.UPDATEUSERVO)) {
		return;
	}
    if(confirm("<spring:message code='common.update.msg' />")) {
        if($("#marketingRcvAgrYnChk").is(":checked")) {
            $("#marketingRcvAgrYn").val("Y");
        } else {
            $("#marketingRcvAgrYn").val("N");
        }
        document.UPDATEUSERVO.action = "<c:url value='/mw/mypage/updateUser.do'/>";
        document.UPDATEUSERVO.submit();
    }
}
function fn_phoneCheckLayer(){
	$('.phoneCheckLayer').fadeToggle();
    $('body').addClass('not_scroll');
}

</script>
</head>
<body>
<div id="wrap">
<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do">
		<jsp:param name="headTitle" value="개인정보수정"/>
	</jsp:include>
</header>
<!-- 헤더 e -->

<!-- 콘텐츠 s -->
<h2 class="sr-only">서브콘텐츠</h2>
<section id="subContent">
	<div class="sub-content">
		<!-- <h2>개인정보수정</h2> -->
		<form:form commandName="UPDATEUSERVO" name="UPDATEUSERVO" method="post">
			<input type="hidden" name="userId" value="${user.userId}" />
			<input type="hidden" name="partnerCode" value="${user.partnerCode}" />
			<table class="join-form">
				<colgroup>
					<col width="23%">
					<col width="*">
				</colgroup>
				<tr>
					<th class="essential"><label for="email">아이디<br>(이메일)</label></th>
					<td class="email">
						<form:hidden path="email" value="${user.email}" />
						<c:out value="${user.email}" />
					</td>
				</tr>
				<tr>
					<th class="essential"><label for="userNm">이름*</label></th>
					<td class="full">
						<form:input path="userNm" id="userNm" class="mgR commWidth" value="${user.userNm}" />
						<form:errors path="userNm" cssClass="error_text" />
					</td>
				</tr>
				<tr>
					<th class="essential"><label for="telNum">휴대폰번호*</label></th>
					<td class="add">
						<form:hidden path="telNum" value="${user.telNum}" />
						<span id="telNumView">${user.telNum}</span>
						<a href="javascript:fn_phoneCheckLayer();" class="comm-btn">변경하기</a>
					</td>
				</tr>
				<c:if test="${!empty user.snsDiv}">
					<tr>
						<th>간편로그인</th>
						<td class="add">
							<form:hidden path="snsDiv" id="snsDiv" value="${user.snsDiv}" />
							<c:if test="${fn:contains(user.snsDiv, 'N')}">
								<img src="<c:url value='/images/web/sns/info/naver.png'/>" alt="네이버">
								<c:if test="${!empty user.pwd || fn:contains(user.snsDiv, ',')}">
									<a class="comm-btn" onclick="fn_SnsUnlink('N');">연동해제</a>
								</c:if>
							</c:if>
							<c:if test="${fn:contains(user.snsDiv, '::')}">
								<br>
							</c:if>
							<c:if test="${fn:contains(user.snsDiv, 'K')}">
								<img src="<c:url value='/images/web/sns/info/kakao.png'/>" alt="카카오">
								<c:if test="${!empty user.pwd || fn:contains(user.snsDiv, ',')}">
									<a class="comm-btn" onclick="fn_SnsUnlink('K');">연동해제</a>
								</c:if>
							</c:if>
						</td>
					</tr>
				</c:if>
				<tr>
					<th><label for="postNum">주소</label></th>
					<td class="add">
						<div>
							<form:input path="postNum" id="postNum" class="add-int" readonly="readonly" value="${user.postNum}" />
							<a class="comm-btn" href="javascript:sample2_execDaumPostcode();">주소검색</a><br>
						</div>
						<div>
							<form:input path="roadNmAddr" id="roadNmAddr" class="address1" readonly="readonly" value="${user.roadNmAddr}" />
                            <br>
							<form:input path="dtlAddr" id="dtlAddr" class="address2" value="${user.dtlAddr}" />
						</div>
					</td>
				</tr>
				<tr>
					<th>수신동의</th>
					<td class="agree">
						<input type="hidden" name="marketingRcvAgrYn" id="marketingRcvAgrYn" value="${user.marketingRcvAgrYn}" >
						<input type="checkbox" id="marketingRcvAgrYnChk" name="marketingRcvAgrYnChk" <c:if test="${user.marketingRcvAgrYn=='Y'}">checked="checked"</c:if>>
						<label for="marketingRcvAgrYnChk">마케팅활용정보 수신동의</label>
						<p>예약하신 내역과 이벤트, 특가 정보를 이메일 또는 휴대폰 문자메시지로 안내 받으실 수 있습니다.</p>
					</td>
				</tr>
				<tr>
					<th>가입일자</th>
					<td>
						${user.frstRegDttm}
					</td>
				</tr>
			</table>
		</form:form>

		<p class="btn-list">
			<a href="javascript:fn_UdtUser()" class="btn22" >수정하기</a>
		</p>
	</div>
</section>
<!-- 콘텐츠 e -->
<!--휴대폰인증-->
<div class="phoneCheckLayer">
	<a onclick="close_popup('.phoneCheckLayer');" class="btn-close"><img src="/images/mw/icon/close/dark-gray.png" width="10" alt="닫기"></a>
	<div class="phone-check">
		<h2>휴대폰 인증</h2>
		<br/>
		<table>
			<colgroup>
				<col width="25%">
				<col width="*">
			</colgroup>
			<tr>
				<th><label for="hp">휴대폰번호</label></th>
				<td class="number">
					<input type="text" name="hp" id="hp" onkeyup="addHyphenToPhone(this);">
					<a href="javascript:void(0);" onclick="javascript:fn_SendSms();" class="comm-btn">인증번호받기</a>
					<p class="msg" style="display:none;">인증번호가 오지 않으면 입력하신 정보가 정확한지 확인해주세요.</p>
				</td>
			</tr>
			<tr>
				<th><label for="certNumber">인증번호</label></th>
				<td class="number">
					<input type="text" name="certNumber" id="certNumber">
					<a href="javascript:void(0);" onclick="javascript:fn_Cert();" class="comm-btn">확인</a>
				</td>
			</tr>
		</table>
		<article class="info-wrap">
			<ul>
				<li>메시지 수신 가능한 휴대폰으로 인증번호를 받으실 수 있습니다.</li>
				<li>인증번호 전송비용은 탐나오에서 부담합니다.</li>
			</ul>
		</article>
	</div>
</div>
<!--휴대폰인증 e-->

<!-- 푸터 s -->
<jsp:include page="/mw/foot.do"></jsp:include>
</div>
<div id="layer" style="display:none; position:fixed; overflow:hidden; z-index:11; -webkit-overflow-scrolling: touch; left: 0; right: 0; top:0; bottom: 0; max-width: 320px; max-height: 460px; overflow-y: auto; margin: auto;">
<img src="<c:url value='/images/mw/icon/close.png'/>" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:12" onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>
</body>
</html>
