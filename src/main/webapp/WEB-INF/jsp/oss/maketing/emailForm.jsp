<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un"			uri="http://jakarta.apache.org/taglibs/unstandard-1.0"%>

<un:useConstants var="Constant" className="common.Constant" />

<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:url value='/dext5editor/js/dext5editor.js'/>"></script>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<title></title>
<script type="text/javascript">
//목록 추가
function fn_al_Add(name, tel){
	//같은 번호가 있는지 검사
	var bRtn = true;

	$("#payinfo_plus>p").each(function(index){
		if($('input[name=tl_Tel]').eq(index).val() == tel){
			//alert("이미 추가된 번호/그룹 입니다.");
			bRtn = false;
			return;
		}
	});

	if(bRtn == false){
		alert("이미 추가된 E-Mail/그룹 입니다.");
		return;
	}

	var strHtml = "";
	strHtml += '<p>';
	strHtml += '	' + name;
	strHtml += '	<span class="money">' + tel + '</span>';
	strHtml += '	<a class="del" onclick="fn_delPrdt(this);"><img src="' + '<c:url value='/images/web/icon/close5.gif'/>' + '" alt="삭제"></a>';
	strHtml += '	<input type="hidden" name="tl_Name" value="' + name + '"/>';
	strHtml += '	<input type="hidden" name="tl_Email" value="' + tel + '"/>';
	strHtml += '</p>';

	$("#payinfo_plus").append(strHtml);
}

function fn_al_AddGroup(name, tel){
	//같은 번호가 있는지 검사
	var bRtn = true;

	$("#payinfo_plus>p").each(function(index){
		if($('input[name=tl_Tel]').eq(index).val() == tel){
			//alert("이미 추가된 번호/그룹 입니다.");
			bRtn = false;
			return;
		}
	});

	if(bRtn == false){
		alert("이미 추가된 E-Mail/그룹 입니다.");
		return;
	}
	var strHtml = "";
	strHtml += '<p>';
	strHtml += '	[' + name + ']';
	strHtml += '	<span class="money"></span>';
	strHtml += '	<a class="del" onclick="fn_delPrdt(this);"><img src="' + '<c:url value='/images/web/icon/close5.gif'/>' + '" alt="삭제"></a>';
	strHtml += '	<input type="hidden" name="tl_Name" value="' + name + '"/>';
	strHtml += '	<input type="hidden" name="tl_Email" value="' + tel + '"/>';
	strHtml += '</p>';

	$("#payinfo_plus").append(strHtml);
}

//목록 삭제
function fn_delPrdt(obj){
	$(obj).parent().remove();
}

//직접 번호 추가
function fn_al_Direct(){
	if($('#al_directNm').val().length == 0){
		alert("이름을 입력하세요.");
		$('#al_directNm').focus();
		return;
	}

	if($('#al_directEmail').val().length == 0){
		alert("E-Mail을 입력하세요.");
		$('#al_directEmail').focus();
		return;
	}

	fn_al_Add($('#al_directNm').val(), $('#al_directEmail').val());
}

//전송
function fn_onSend(){
	//오류 검사
	if($("#payinfo_plus>p").length == 0){
		alert("전송할 E-Mail을 추가하세요.");
		return;
	}

	if($('#subject').val().length == 0){
		alert("제목을 입력하세요.");
		$('#subject').focus();
		return;
	}

	if($("#sPrmtDiv").val().trim() == '') {
		if($('#egovComFileUploader').val().length > 0){
			/* alert("이미지 파일을 선택 하세요.");
			$('#egovComFileUploader').focus();
			return; */
			var fileName = $('#egovComFileUploader').val().toLowerCase();	//파일명
			var str = fileName.lastIndexOf(".jpg");	//.xls위치 추출
			var strSub = fileName.substr(str, str + 4);	//.xls확장자 추출
			if(strSub != ".jpg"){
				alert("jpg파일만 등록이 가능합니다.");
				return;
			}
		}
	}

	if($('#callback').val().length == 0){
		alert("송신 E-Mail을 입력하세요.");
		$('#callback').focus();
		return;
	}

	//보낼 목록 조합
	var strSendNames = "";
	var strSendEmails = "";

	$("#payinfo_plus>p").each(function(index){
		strSendNames 	+= $('input[name=tl_Name]').eq(index).val() + ",";
		strSendEmails 	+= $('input[name=tl_Email]').eq(index).val() + ",";
	});

	$('#sendNames').val(strSendNames);
	$('#sendEmails').val(strSendEmails);
	$("#msg").val(DEXT5.getBodyValueExLikeDiv('editor1'));

	document.frm.action = "<c:url value='/oss/emailSend.do'/>";
	
	if($("#sPrmtDiv").val().trim() == '') {
		document.frm.submit();
	} else {
		if(confirm('이벤트/기획전 관련 이메일을 발송하겠습니까?')) {
			$('#prmtDiv').val($("#sPrmtDiv").val());
			$('#prmtNum').val($("#sel_" + $("#sPrmtDiv").val()).val());
			document.frm.submit();
		}
	}
}

function fn_FindUser(){
	window.open("<c:url value='/oss/findUserSMSMail.do'/>?type=MAIL","findUser", "width=700, height=650, scrollbars=yes, status=no, toolbar=no;");
}

function fn_FindCorp(){
	window.open("<c:url value='/oss/findCorpSMSMail.do'/>?type=MAIL","findUser", "width=800, height=650, scrollbars=yes, status=no, toolbar=no;");
}

function fn_SelectUer(userId, userNm, tel, mail){
	//alert(userNm + " : " + tel + " : " + mail);
	fn_al_Add(userNm, mail);
}

function dext_editor_loaded_event() {
	//숨겨진 textarea에서 html 소스를 가져옵니다.
	var html_source1 = document.getElementById('msg').value; //에디터가 로드 되고 난 후 에디터에 내용을 입력합니다.
	DEXT5.setBodyValueExLikeDiv(html_source1, 'editor1');
}

$(document).ready(function(){
	//fn_onSendType();
	//fn_onResSend();

	//파일 올리기 관련
	var maxFileNum = 1;
	var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
	multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );

	if("${USERCATEVO.sFindYn}" == "Y"){
		fn_al_AddGroup("사용자조건검색", "USERCATE");
	}
	
	$("#sPrmtDiv").change(function() {
		$(".prmtSelect").hide();
		$("#sel_" + $(this).val()).show();
	});
});

</script>
</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=maketing" />
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=maketing&sub=email" />

		<div id="contents_area">
			<div id="contents">
				<form name="frm" id="frm" method="post"	enctype="multipart/form-data" onSubmit="return false;">
					<!--검색-->
					<div class="search_box">
						<div class="search_form">
							<table class="sms-search" style="width: 100%">
								<colgroup>
									<col width="100px" />
									<col />
								</colgroup>

								<tr>
									<th>그룹 추가</th>
									<td>
										<li class="btn_sty02"><a href="javascript:fn_al_AddGroup('전체사용자','ALLUSER')">사용자</a></li>
										<li class="btn_sty02"><a href="javascript:fn_al_AddGroup('전체업체','ALLCORP')">업체</a></li>
										<li class="btn_sty02"><a href="javascript:fn_al_AddGroup('업체-숙소','CADOCORP')">업체-숙소</a></li>
										<li class="btn_sty02"><a href="javascript:fn_al_AddGroup('업체-렌터카','CRCOCORP')">업체-렌터카</a></li>
										<li class="btn_sty02"><a href="javascript:fn_al_AddGroup('업체-카시트','CSPCCORP')">업체-카시트</a></li>
										<li class="btn_sty02"><a href="javascript:fn_al_AddGroup('업체-여행사','CSPTCORP')">업체-여행사</a></li>
										<li class="btn_sty02"><a href="javascript:fn_al_AddGroup('업체-관광지','CSPUCORP')">업체-관광지</a></li>
										<li class="btn_sty02"><a href="javascript:fn_al_AddGroup('업체-레저','CSPLCORP')">업체-레저</a></li>
										<li class="btn_sty02"><a href="javascript:fn_al_AddGroup('업체-맛집','CSPFCORP')">업체-맛집</a></li>
										<li class="btn_sty02"><a href="javascript:fn_al_AddGroup('업체-뷰티','CSPBCORP')">업체-뷰티</a></li>
										<li class="btn_sty02"><a href="javascript:fn_al_AddGroup('업체-체험','CSPECORP')">업체-체험</a></li>
										<li class="btn_sty02"><a href="javascript:fn_al_AddGroup('업체-제주특산품','CSVSCORP')">업체-제주특산품</a></li>
										<li class="btn_sty02"><a href="javascript:fn_al_AddGroup('업체-제주기념품','CSVMCORP')">업체-제주기념품</a></li>
										<li class="btn_sty02"><a href="javascript:fn_al_AddGroup('업체-항공','CAVOCORP')">업체-항공</a></li>
										<li class="btn_sty02"><a href="javascript:fn_al_AddGroup('업체-골프','CGLOCORP')">업체-골프</a></li>
									</td>
								</tr>

								<tr>
									<th>업체 거래상태</th>
									<td>
										<select  name="sTradeStatusCd" id="sTradeStatusCd">
											<option value="">전 체</option>
											<c:forEach items="${tsCdList}" var="tsCd">
												<c:if test="${tsCd.cdNum ne Constant.TRADE_STATUS_REG}">
													<option value="${tsCd.cdNum}" <c:if test="${tsCd.cdNum eq 'TS03'}">selected="true"</c:if>>${tsCd.cdNm}</option>
												</c:if>
											</c:forEach>
										</select>
									</td>
								</tr>

								<tr>
									<th>이벤트/기획전</th>
									<td><select name="sPrmtDiv" id="sPrmtDiv">
											<option value="">= 선 택 =</option>
											<option value="${Constant.PRMT_DIV_EVNT }">이벤트</option>
											<option value="${Constant.PRMT_DIV_PLAN }">기획전</option>
										</select>
										<select name="sEvntNum" id="sel_${Constant.PRMT_DIV_EVNT }" class="prmtSelect" style="display: none;">
											<c:forEach items="${evntList}" var="evnt">
												<option value="${evnt.prmtNum}">${evnt.prmtNm}</option>
											</c:forEach>
										</select>
										<select name="sPlanNum" id="sel_${Constant.PRMT_DIV_PLAN }" class="prmtSelect" style="display: none;">
											<c:forEach items="${planList}" var="plan">
												<option value="${plan.prmtNum}">${plan.prmtNm}</option>
											</c:forEach>
										</select>
									</td>
								</tr>

								<tr>
									<th>검색 추가</th>
									<td>
										<li class="btn_sty01"><a href="javascript:fn_FindUser()">사용자 검색</a></li>
										<li class="btn_sty01"><a href="javascript:fn_FindCorp()">업체 검색</a></li>
									</td>
								</tr>

								<tr>
									<th>직접 추가</th>
									<td>
										이름 : <input type="text" name="al_directNm" id="al_directNm" value=""/>&nbsp;
										E-Mail : <input type="text" name="al_directEmail" id="al_directEmail" value=""/>
										<li class="btn_sty04"><a href="javascript:fn_al_Direct()">추가</a></li>
									</td>
								</tr>
							</table>
						</div>
					</div>

					<table width="100%" border="1" cellspacing="0" cellpadding="0" class="table01 list_tb smsTB">
						<colgroup>
							<col width="32%" />
							<col />
						</colgroup>
						<tr>
							<td>
								<b>전송 목록</b><br>
								<div class="pay-info">
									<div id="payinfo_plus">
									</div>
								</div>

								<input type="hidden" name="sendNames" id="sendNames" value=""/>
								<input type="hidden" name="sendEmails" id="sendEmails" value=""/>
								<input type="hidden" name="prmtDiv" id="prmtDiv" value=""/>
								<input type="hidden" name="prmtNum" id="prmtNum" value=""/>
							</td>
							<td>
								<b>내용</b>
								<div style="margin-top: 10px;">
									<span id="subjectInput">
										제 목
										<p>
											<input type="text" name="subject" id="subject" value="[탐나오]" style="width: 392px;" />
											<select id="wordsContentsId" onChange="DEXT5.setBodyValueExLikeDiv(this.value, 'editor1');">
												<option value="">= 문구 선택 =</option>
												<c:forEach items="${wordsList}" var="words">
													<option value="${words.wordsContents}"><c:out value="${words.wordsSubject}" escapeXml="false" /></option>
												</c:forEach>
											</select>
										</p>
									</span>
								</div>

								<script type="text/javascript">
									var editor1 = new Dext5editor('editor1');
								</script>

								<textarea rows="10" cols="30" name="msg" id="msg" style="display:none"></textarea>

								<div style="margin-top: 10px;">
									이미지
									<p>
										<input type="file" id="egovComFileUploader" name="file" accept="*" class="full" style="border: 1px solid #ccc; width: 280px;" /> <span class="font03">(가로 740px)</span>
										<c:if test="${not empty fileError}">Error:<c:out value="${fileError}"/></c:if>
									</p>
								</div>
								<div id="egovComFileList" class="text_input04"></div>

								<div style="margin-top: 10px;">
									송신 E-Mail
									<p>
										<input type="text" name="callback" id="callback" value="${fromEmail}" style="width: 200px;" /> (등록되지 않은 E-Mail 주소의 경우 전송되지 않을 수도 있습니다)
									</p>
								</div>
							</td>
						</tr>
					</table>

					<input type="hidden" name="sFindYn" id="sFindYn" value="${USERCATEVO.sFindYn}"/>
					<input type="hidden" name="sProcStdS" id="sProcStdS" value='${USERCATEVO.sProcStdS}'/>
					<input type="hidden" name="sProcStdE" id="sProcStdE" value='${USERCATEVO.sProcStdE}'/>
					<input type="hidden" name="sSex" id="sSex" value='${USERCATEVO.sSex}'/>
					<input type="hidden" name="sAge" id="sAge" value='${USERCATEVO.sAge}'/>
					<input type="hidden" name="sArea" id="sArea" value='${USERCATEVO.sArea}'/>
					<input type="hidden" name="sLoginCntS" id="sLoginCntS" value='${USERCATEVO.sLoginCntS}'/>
					<input type="hidden" name="sLoginCntE" id="sLoginCntE" value='${USERCATEVO.sLoginCntE}'/>
					<input type="hidden" name="sBuyCntS" id="sBuyCntS" value='${USERCATEVO.sBuyCntS}'/>
					<input type="hidden" name="sBuyCntE" id="sBuyCntE" value='${USERCATEVO.sBuyCntE}'/>
					<input type="hidden" name="sBuyAmtS" id="sBuyAmtS" value='${USERCATEVO.sBuyAmtS}'/>
					<input type="hidden" name="sBuyAmtE" id="sBuyAmtE" value='${USERCATEVO.sBuyAmtE}'/>
					<input type="hidden" name="sReBuy" id="sReBuy" value='${USERCATEVO.sReBuy}'/>
					<input type="hidden" name="sCate" id="sCate" value='${USERCATEVO.sCate}'/>
					<input type="hidden" name="sBuyDateS" id="sBuyDateS" value='${USERCATEVO.sBuyDateS}'/>
					<input type="hidden" name="sBuyDateE" id="sBuyDateE" value='${USERCATEVO.sBuyDateE}'/>
					<input type="hidden" name="sEvent" id="sEvent" value='${USERCATEVO.sEvent}'/>
					<input type="hidden" name="sUseepil" id="sUseepil" value='${USERCATEVO.sUseepil}'/>
					<input type="hidden" name="sPayDiv" id="sPayDiv" value='${USERCATEVO.sPayDiv}'/>
					<input type="hidden" name="sLPointYn" id="sLPointYn" value='${USERCATEVO.sLPointYn}'/>
					<input type="hidden" name="sCuponYn" id="sCuponYn" value='${USERCATEVO.sCuponYn}'/>
					<input type="hidden" name="sBlkList" id="sBlkList" value='${USERCATEVO.sBlkList}'/>
				</form>

				<ul class="btn_rt01">
					<li class="btn_sty03"><span><a href="javascript:fn_onSend()">보내기</a></span></li>
				</ul>
			</div>
		</div>
	</div>
</div>
</body>
</html>