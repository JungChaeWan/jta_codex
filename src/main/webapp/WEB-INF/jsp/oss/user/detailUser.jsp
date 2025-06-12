<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="validator" 	uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="un" 			uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />

<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui-1.11.4.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>

<validator:javascript formName="USERVO" staticJavascript="false" xhtml="true" cdata="true"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />

<title></title>

<script type="text/javascript">
function fn_ListUser() {
	document.USERVO.action = "<c:url value='/oss/userList.do' />";
	document.USERVO.submit();
}

function fn_UpdateUser() {
	document.USERVO.action = "<c:url value='/oss/viewInsertUser.do' />";
	document.USERVO.submit();
}

function fn_DelUser() {
	if(confirm("<spring:message code='common.confirm.drop2'/>")){
		document.USERVO.action = "<c:url value='/oss/dropUser.do' />";
		document.USERVO.submit();
	}
}

function fn_DetailRsv(rsvNum) {
	document.location = "<c:url value='/oss/detailRsv.do'/>?rsvNum=" + rsvNum;
}

var isMore = false;
function fn_MoreRsvList() {
	isMore = !isMore;

	if(isMore) {
		$(".more").show();
		$("#btnMore").html("감추기");
	} else {
		$(".more").hide();
		$("#btnMore").html("펼처보기");
	}
}

function fn_PopupCall(subject, noticeNum) {
	// 상위 이벤트 방지
	event.stopPropagation();

	var parameters = "bbsNum=CALL&userId=" + $("#userId").val() + "&subject=" + subject;

	$.ajax({
		type:"post",
		url:"<c:url value='/oss/noticeDetail.ajax'/>",
		data:parameters,
		success:function(data){
			var call = data.result;

			$("#noticeNum").val("");
			$("#hrkNoticeNum").val("");
			$("#ansSn").val("");
			$("#callContents").val("");

			if(call.length > 0) {
				$.each(call, function(i){
					if(i == 0) {
						$("#hrkNoticeNum").val(this.noticeNum);
					}
					if(this.noticeNum == noticeNum) {
						$("#noticeNum").val(this.noticeNum);
						$("#hrkNoticeNum").val(this.hrkNoticeNum);
						$("#ansSn").val(this.ansSn);
						$("#callContents").val(this.contents);
					}
				});
			}
			$("#callSubject").val(subject);
			$("#popupCall").show();
		},
		error:fn_AjaxError
	});
}

function fn_SaveCall() {
	if($("#callContents").val().trim() == "") {
		alert("<spring:message code="errors.required2" arguments="내용" />");
		return false;
	}
	var parameters = $("#frm").serialize();

	$.ajax({
		type:"post",
		url:"<c:url value='/oss/saveCall.ajax'/>",
		data:parameters,
		success:function(data){
			$("#popupCall").hide();
			alert(data.resultMsg);

			fn_CallList();
		},
		error:fn_AjaxError
	});
}

function fn_CallList() {
	var parameters = "bbsNum=CALL&userId=" + $("#userId").val();

	$.ajax({
		type:"post",
		url:"<c:url value='/oss/noticeList.ajax'/>",
		data:parameters,
		success:function(data){
			var addHtml = "";

			$.each(data.result, function(){
				addHtml += "<tr>";
				addHtml += "<td class=\"align_ct\">" + this.subject + "</td>";
				addHtml += "<td>";
				addHtml += "<table class=\"table_noline\">";
				addHtml += "<tr>";
				addHtml += "<td>";
				for(var i=1; i <= this.ansSn; i++) {
					addHtml += "&nbsp;&nbsp;";
					if(this.ansSn == i) {
						addHtml += "└&nbsp;";
					}
				}
				addHtml += "</td>";
				addHtml += "<td style=\"white-space:pre-wrap;\">" + this.contents + "</td>";
				addHtml += "</tr>";
				addHtml += "</table>";
				addHtml += "</td>";
				addHtml += "<td class=\"align_ct\">" + this.writer + "</td>";
				addHtml += "<td class=\"align_ct\">" + this.frstRegDttm + "</td>";
				addHtml += "<td class=\"align_ct\">" + this.frstRegId + "</td>";
				addHtml += "<td class=\"align_ct\">" + this.lastModDttm + "</td>";
				addHtml += "<td class=\"align_ct\">" + this.lastModId + "</td>";
				addHtml += "<td class=\"align_ct\"><div class=\"btn_sty09\"><span><a href=\"javascript:void(0)\" onclick=\"fn_PopupCall('" + this.subject + "', '" + this.noticeNum + "');\">수정</a></span></div></td>";
				addHtml += "</tr>";
			});

			$("#callCount").html(data.result.length);
			$("#tbCall").html(addHtml);
		},
		error:fn_AjaxError
	});
}

function fn_UpdateRestUserCancel(){
	$.ajax({
		type:"post",
		dataType:"json",
		url:"<c:url value='/oss/adminRestUserCancel.ajax'/>",
		data:"userId=${user.userId}" ,
		success:function(data){
			if(data.success == "Y"){
				alert(data.msg);
				location.reload();
			}else{
				alert(data.msg);
			}
		}
	});
}

function fn_InsertPoint(partnerCode, userId) {
	$.ajax({
		type:"post",
		data:"partnerCode=" + partnerCode + "&userId=" + userId,
		url:"<c:url value='/oss/point/userPointCreatePop.ajax'/>",
		success:function(data){
			$("#userPointCreatePop").html(data);
			show_popup($("#userPointCreatePop"));
		},
		error : fn_AjaxError
	});
}

$(document).ready(function(){
	// 팝업 이동
	$("#popupCall").draggable();

});

function fn_PointHistoryPop(partnerCode, userId) {
	$.ajax({
		type   : "post",
		data   : "partnerCode=" + partnerCode + "&userId=" + userId + "&cssView=oss",
		url    : "<c:url value='/web/point/pointHistoryPop.do'/>",
		success: function (data) {
			$(".couponRegPop_1").html(data);
			show_popup($(".couponRegPop_1"));
		},
		error  : fn_AjaxError
	});
}

const winOpts="scrollbars=yes,toolbar=no,location=no,directories=no,width=3200,height=800,resizable=yes,status=no, menubar=no,left=0,top=50";
function fn_ViewRsvList(){
	window.open('/oss/rsvList.do?userId=${user.userId}&sAutoCancelViewYn=Y','예약정보',winOpts);
}
function fn_ViewRsvSvList(){
	window.open('/oss/rsvSvList.do?userId=${user.userId}&sAutoCancelViewYn=Y','특산기념품 예약정보',winOpts);
}
</script>
</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=user" />
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=user&sub=user" />
		<div id="contents_area">
			<div id="contents">
			<!--본문-->
			<!--상품 등록-->
				<div class="register_area">
					<form:form commandName="USERVO" name="USERVO" method="post">
						<input type="hidden" name="sUserId" value="${searchVO.sUserId}" />
						<input type="hidden" name="sUserNm" value="${searchVO.sUserNm}" />
						<input type="hidden" name="sEmail" value="${searchVO.sEmail}" />
						<input type="hidden" name="sTelNum" value="${searchVO.sTelNum}" />
						<input type="hidden" name="sCorpAdminDiv" value="${searchVO.sCorpAdminDiv}" />
						<input type="hidden" name="sBadUserYn" value="${searchVO.sBadUserYn}" />
						<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}" />
						<input type="hidden" name="userId" id="userId" value="${user.userId}" />

						<h4 class="title03">사용자 상세정보</h4>
						<table class="table02" border="1">
							<colgroup>
								<col width="160" />
								<col width="500" />
								<col width="160" />
								<col width="*" />
							</colgroup>
							<tr>
								<th>사용자 아이디</th>
								<td><c:out value="${user.userId}" /></td>
								<th>사용자 등급</th>
								<td>
									<c:if test="${user.authNm == 'USER'}">일반사용자</c:if>
									<c:if test="${user.partnerCode != null &&  user.partnerCode != 'tamnao' }">파트너(${user.partnerCode})</c:if>
									<c:if test="${user.authNm == 'ADMIN'}">관리자</c:if>

									<c:if test="${user.corpAdmYn == 'Y'}"><img src="/images/oss/icon/icon_admin.png" alt="입점업체관리자" /></c:if>
								</td>
							</tr>
							<tr>
								<th>사용자명</th>
								<td><c:out value="${user.userNm}" /></td>
								<th>연락처</th>
								<td><c:out value="${user.telNum}" /></td>
							</tr>
							<%--<tr>
								<th scope="row">성별</th>
								<td>
									<c:if test="${user.sex == 'M'}">남</c:if>
									<c:if test="${user.sex == 'F'}">여</c:if>
								</td>
								<th>생년월일</th>
								<td><c:out value="${user.bth}" /></td>
							</tr>--%>
							<tr>
								<th>이메일</th>
								<td><c:out value="${user.email}" /></td>
								<th>주소</th>
								<td>
									<c:if test="${not empty user.postNum}">
										(우)<c:out value="${user.postNum}" /><br>
									</c:if>
									<c:out value="${user.roadNmAddr}" /><br>
									<c:out value="${user.dtlAddr}" />
								</td>
							</tr>
							<tr>
								<th>마케팅 수신여부</th>
								<td>
									<c:if test="${user.marketingRcvAgrYn == 'Y'}">동의</c:if>
									<c:if test="${user.marketingRcvAgrYn == 'N'}">미동의</c:if>
								</td>
								<th>휴면계정 여부</th>
								<td>
									${user.restYn}
									<c:if test="${user.restYn == 'Y'}">
								    	<div class="btn_sty04"><a href="javascript:fn_UpdateRestUserCancel()">휴면계정 해제</a></div>
									</c:if>
								</td>
							</tr>
							<tr>
								<th>블랙리스트 여부</th>
								<td colspan="3">
									${user.badUserYn}
									<c:if test="${user.badUserYn == 'Y'}">
										(<c:out value="${user.badUserRsn}" escapeXml="false"/>)
									</c:if>
								</td>
							</tr>
							<tr>
								<th>포인트</th>
								<td colspan="3">
									<c:if test="${partnerCode ne 'tamnao'}"> 잔여
										<a href="javascript:void(0)" onclick="fn_PointHistoryPop('${partnerCode}','${user.userId}');"><fmt:formatNumber>${partnerPoint.ablePoint}</fmt:formatNumber> Point</a>
									</c:if>
									<c:if test="${partnerCode eq 'tamnao'}">
										<c:forEach var="data" items="${partnerPointList}" varStatus="status">
											<a href="javascript:void(0)" onclick="fn_PointHistoryPop('${data.partnerCode}','${user.userId}');"> ${data.partnerNm}(${data.partnerCode}) 잔여 <fmt:formatNumber>${data.ablePoint}</fmt:formatNumber> Point</a>
											<div class="btn_sty06">
												<span><a href="javascript:void(0)" onclick="fn_InsertPoint('${data.partnerCode}','${user.userId}');">포인트 발급 / 사용처리 하기</a></span>
											</div>
											<br/>
										</c:forEach>
									</c:if>
								</td>
							</tr>
						</table>
					</form:form>
				</div>
				<!--//상품등록-->
				<!--//본문-->
				<ul class="btn_rt01">
					<c:if test="${partnerCode eq 'tamnao'}">
					<li class="btn_sty04"><a href="javascript:fn_UpdateUser()">수정</a></li>
					<li class="btn_sty03"><a href="javascript:fn_DelUser()">탈퇴</a></li>
					</c:if>
					<li class="btn_sty01"><a href="javascript:history.back()">목록</a></li>
				</ul>
				<h4 class="title03">
					예약 정보
				</h4>
				<ul class="btn_lt01">
					<li class="btn_sty04"><a href="javascript:fn_ViewRsvList()">예약정보</a></li>
					<li class="btn_sty04"><a href="javascript:fn_ViewRsvSvList()">특산/기념품 예약정보</a></li>
				</ul>
				<div class="title01"></div>
				<c:if test="${partnerCode eq 'tamnao'}">
				<h4 class="title03">상담 정보 <span class="search_list_ps">[총 <strong id="callCount">${fn:length(callList)}</strong>건]</span></h4>
				<div class="list">
					<table class="table01">
						<colgroup>
							<col width="120" />
							<col />
							<col width="120" />
							<col width="100" />
							<col width="100" />
							<col width="100" />
							<col width="100" />
							<col width="100" />
						</colgroup>
						<thead>
							<tr>
								<th>예약번호</th>
								<th>내용</th>
								<th>작성자</th>
								<th>등록일시</th>
								<th>등록ID</th>
								<th>수정일시</th>
								<th>수정ID</th>
								<th>기능툴</th>
							</tr>
						</thead>
						<tbody id="tbCall">
							<!-- 데이터 없음 -->
							<c:if test="${fn:length(callList) == 0}">
								<tr>
									<td colspan="8" class="align_ct"><spring:message code="info.nodata.msg" /></td>
								</tr>
							</c:if>
							<c:forEach var="call" items="${callList}" varStatus="stauts">
								<tr>
									<td class="align_ct"><a href="/oss/detailRsv.do?rsvNum=${call.subject}" target="_blank">${call.subject}</a></td>
									<td>
										<table class="table_noline">
											<tr>
												<td>
													<c:forEach var="i" begin="1" end="${call.ansSn}">
														&nbsp;&nbsp;<c:if test="${call.ansSn == i}">└&nbsp;</c:if>
													</c:forEach>
												</td>
												<td style="white-space:pre-wrap;"><c:out value="${call.contents}" escapeXml="false" /></td>
											</tr>
										</table>
									</td>
									<td class="align_ct">${call.writer}</td>
									<td class="align_ct">${call.frstRegDttm}</td>
									<td class="align_ct">${call.frstRegId}</td>
									<td class="align_ct">${call.lastModDttm}</td>
									<td class="align_ct">${call.lastModId}</td>
									<td class="align_ct">
										<div class="btn_sty09"><span><a href="javascript:void(0)" onclick="fn_PopupCall('${call.subject}', '${call.noticeNum}');">수정</a></span></div>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				</c:if>
			</div>
		</div>
	</div>
	<!--//Contents 영역-->
	<div id="popupCall" class="lay_popup lay_ct" style="display:none;">
		<span class="popup_close"><a href="javascript:void(0);" onclick="close_popup($('#popupCall'));" title="창닫기"><img src="/images/oss/btn/close_btn03.gif" alt="닫기" /></a></span>
		<ul class="form_area">
			<li>
				<h5 class="title06">상담 정보</h5>
				<form name="frm" id="frm" method="post" onSubmit="return false;">
					<input type="hidden" name="noticeNum" id="noticeNum">
					<input type="hidden" name="hrkNoticeNum" id="hrkNoticeNum">
					<input type="hidden" name="ansSn" id="ansSn">
					<input type="hidden" name="userId" value="${user.userId}">

					<table class="table02" border="1" cellpadding="0" cellspacing="0">
						<colgroup>
							<col width="110" />
							<col width="*" />
						</colgroup>
						<tr>
							<th>예약번호</th>
							<td><input type="text" name="subject" id="callSubject" readonly="readonly"></td>
						</tr>
						<tr>
							<th>내용</th>
							<td><textarea name="contents" id="callContents" rows="10" cols="100"></textarea></td>
						</tr>
					</table>
				</form>
			</li>
		</ul>
		<div class="btn_ct01"><span class="btn_sty04"><a href="javascript:void(0)" onclick="fn_SaveCall();">저장</a></span></div>
	</div>
</div>
<div class="blackBg"></div>
<!-- 포인트 발급/사용처리 팝업-->
<div id="userPointCreatePop" class="lay_popup lay_ct"  style="display:none;"></div>
<!-- 포인트 내역 팝업 -->
<div class="couponRegPop_1 lay_popup lay_ct" style="display:none;"></div>
</body>
</html>