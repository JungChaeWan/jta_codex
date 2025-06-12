<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />
<head>
<c:set var="strServerName" value="${pageContext.request.serverName}"/>
<c:set var="strURL" value="${strServerName}${pageContext.request.contextPath}${requestScope['javax.servlet.forward.servlet_path']}?prmtDiv=${prmtVO.prmtDiv}&prmtNum=${prmtVO.prmtNum}&finishYn=${prmtVO.finishYn}&winsYn=${prmtVO.winsYn}"/>

<jsp:include page="/mw/includeJs.do">
	<jsp:param name="title" value="제주여행 ${prmtVO.prmtNm}, 탐나오"/>
	<jsp:param name="description" value="${prmtVO.prmtNm}"/>
</jsp:include>
<meta property="og:title" content="제주여행 ${prmtVO.prmtNm}, 탐나오" />
<meta property="og:url" content="https://${strURL}" />
<meta property="og:description" content="<c:out value='${prmtVO.prmtNm}'/>" />
<c:if test="${not empty prmtVO.listImg}">
<meta property="og:image" content="https://${strServerName}${prmtVO.listImg}" />
</c:if>
<meta property="fb:app_id" content="182637518742030" />

<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css?version=${nowDate}'/>">
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/style.css?version=${nowDate}'/>"> --%>
<link rel="stylesheet" href="../../css/web/number-ticker.css">
<script type="text/javascript">
let g_Cmt_page = "${prmtVO.pageIndex}";

function fn_Search(pageIndex) {
	g_Cmt_page = pageIndex;
	fn_prmtCmtList();
}

function fn_prmtCmtList() {
	$.ajax({
		type:"post",
		url:'<c:url value="/mw/evnt/prmtCmtList.ajax" />',
		data:"prmtNum=${prmtVO.prmtNum}&pageIndex=" + g_Cmt_page,
		success:function(data){
			$("#divComment").html(data);
		},
		error:fn_AjaxError
	});
}

function fn_prmtCmtInsert() {
	if($("#cmtContents").val().length == 0) {
		alert("<spring:message code="errors.required2" arguments="댓글" />");
		$("#cmtContents").focus();
		return;
	}
	if($("#cmtContents").val().length > 500) {
		alert("<spring:message code="errors.maxlength" arguments="댓글,500" />");
		$("#cmtContents").focus();
		return;
	}
	let parameters = $("#prmtCmtFrm").serialize();
	$.ajax({
		type:"post",
		url:'<c:url value="/web/evnt/prmtCmtInsert.ajax" />',
		data:parameters,
		success:function(data){
			//$("#tabs-5").html(data);
			if(data["Status"] == "success") {
				alert("<spring:message code="success.common.insert" />");
				$("#cmtContents").val("");

				fn_prmtCmtList();
			} else {
				alert("<spring:message code="fail.common.insert" />");
			}
		},
		error:fn_AjaxError
	});
}

function fn_prmtCmtDelete(cmtSn){
	$("#cmtSn").val(cmtSn);
	let parameters = $("#prmtCmtFrm").serialize();
	$.ajax({
		type:"post",
		url:'<c:url value="/web/evnt/prmtCmtDelete.ajax" />',
		data:parameters,
		success:function(data){
			//$("#tabs-5").html(data);
			if(data["Status"] == "success") {
				alert("<spring:message code="success.common.delete" />");

				fn_prmtCmtList();
			} else {
				alert("<spring:message code="fail.common.delete" />");
			}
		},
		error:fn_AjaxError
	});
}

function event2021Cnt(){
	var parameters = {"cpIds":["CP00000670","CP00000671","CP00000672","CP00000673","CP00000674"]};
	$.ajax({
		url : "<c:url value='/web/couponUseCnt.ajax'/>",
		data : parameters,
		dataType:"json",
		success: function(data) {
			if(data.success == "Y") {
				$(".number-ticker").attr("data-value",data.cnt*100);
			}
		},
		error : function(request, status, error) {
			fn_AjaxError(request, status, error);
		}
	});
}

function event2021Donation(){
	if("${isLogin}" != 'Y'){
		if(confirm('로그인 후 기부하실 수 있습니다.\n로그인 하시겠습니까?')) {
			fn_login();
		}
	}else if("${isLogin}" == 'Y'){
		let parameters = "userId=ALL";
		$.ajax({
			url : "<c:url value='/web/event2021Donation.ajax'/>",
			data : parameters,
			dataType:"json",
			success: function(data) {
				if(data.success == "Y") {
					$(".number-ticker").attr("data-value",Number($(".number-ticker").attr("data-value")) + 1);
					alert("기부 되었습니다.");
					/*location.href="/web/mypage/couponList.do";*/
				}else{
					alert("이미 기부 하셨습니다.");
					/*location.href="/web/mypage/couponList.do";*/
				}
			},
			error : function(request, status, error) {
				fn_AjaxError(request, status, error);
			}
		});
	}
}

$(document).ready(function(){
	<c:if test="${prmtVO.cmtYn eq 'Y'}">
	fn_prmtCmtList();
	</c:if>
	event2021Cnt();
});
</script>
</head>

<body>
<div id="wrap">

<header id="header">
	<jsp:include page="/mw/head.do"></jsp:include>
</header>

<h2 class="sr-only">서브콘텐츠</h2>
<section id="subContent">
	<!-- 다시ON, 고향사랑기부제 -->
	<c:if test="${prmtVO.prmtNum ne 'PM0000XXXX'}">

	<div class="menu-bar">
		<p class="btn-prev"><img src="/images/mw/common/btn_prev.png" width="20" alt="이전페이지"></p>
		<h2>기획전</h2>
	</div>

  	<c:if test="${prmtVO.winsYn eq 'N'}">
		<div class="sub-content mw-event">
			<div class="event">
				<ul class="event-list">
					<li>
						<div class="pr-img">
							<c:set var="dtlImgUrl" value="${prmtVO.dtlImg}" />

							<c:if test="${not empty prmtVO.mobileDtlImg}">
								<c:set var="dtlImgUrl" value="${prmtVO.mobileDtlImg}" />
							</c:if>
							<img src="${dtlImgUrl}" alt="${prmtVO.prmtNm}">

							<c:if test="${prmtVO.ddayViewYn eq 'Y'}">
								<!-- 디데이 추가 -->
								<jsp:useBean id="now" class="java.util.Date" />
								<fmt:parseDate var="endDt" value="${prmtVO.endDt}" pattern="yyyyMMdd" />
								<fmt:parseNumber var="nowTime" value="${now.time / (3600*24*1000)}" integerOnly="true" scope="request" />
								<fmt:parseNumber var="endTime" value="${endDt.time / (3600*24*1000)}" integerOnly="true" scope="request" />
								<fmt:formatNumber var="dayNum" >${endTime - nowTime + 1}</fmt:formatNumber>

								<c:if test="${(dayNum > 0) and (dayNum < 8)}">
									<div class="d-day">D-<fmt:formatNumber>${dayNum}</fmt:formatNumber></div>
								</c:if>
							</c:if>
						 </div>
					</li>
				</ul>

				<c:if test="${not empty prmtVO.dtlUrlMobile}">
					<p class="oss-quick">
						<a href="${prmtVO.dtlUrlMobile}" class="btn btn4 custom-btn" <c:if test="${prmtVO.dtlNwdYn eq 'Y'}">target="_blank"</c:if>>바로가기</a>
					</p>
				</c:if>
				<c:if test="${empty prmtVO.dtlUrlMobile}">
					<c:if test="${not empty prmtVO.dtlUrl}">
						<p class="oss-quick custom-btn">
							<a href="${prmtVO.dtlUrl}" class="btn btn4 custom-btn" <c:if test="${prmtVO.dtlNwdYn eq 'Y'}">target="_blank"</c:if>>바로가기</a>
						</p>
					</c:if>
				</c:if>

				<c:if test="${prdtSum != 0}">
					<section class="mw-event-list">
						<c:set var="dtlBgImgUrl" value="${prmtVO.dtlBgImg}" />

						<c:if test="${not empty prmtVO.mobileDtlBgImg}">
							<c:set var="dtlBgImgUrl" value="${prmtVO.mobileDtlBgImg}" />
						</c:if>

						<div class="prdtList" style="<c:if test="${not empty prmtVO.dtlBgColor}">background-color:#${prmtVO.dtlBgColor}; </c:if><c:if test="${not empty dtlBgImgUrl}">background-image:url(${dtlBgImgUrl});</c:if>">
							<c:forEach var="prdt" items="${prmtPrdtList}" varStatus="status">
								<c:set var="product" value="${prdt.data}" />

								<c:choose>
									<c:when test="${prdt.corpCd eq Constant.SOCIAL}">
										<c:set var="paramStr" value="prdtNum" />
                                        <c:set var="categoryNm" value="${categoryMap[product.ctgr]}" />
                                        <c:set var="productNm" value="${product.prdtNm}" />
                                        <c:set var="productImg" value="${product.saveFileNm}" />
									</c:when>
									<c:when test="${prdt.corpCd eq Constant.ACCOMMODATION}">
										<c:set var="paramStr" value="sPrdtNum" />
                                        <c:set var="categoryNm" value="숙박" />
                                        <c:set var="productNm" value="${product.adNm}<small> - ${product.roomNm}</small>" />
                                        <c:set var="productImg" value="${product.savePath}thumb/${product.saveFileNm}" />
									</c:when>
                                    <c:when test="${prdt.corpCd eq Constant.RENTCAR}">
                                        <c:set var="paramStr" value="sPrdtNum" />
                                        <c:set var="categoryNm" value="렌터카" />
                                        <c:set var="productNm" value="${product.prdtNm}" />
                                        <c:set var="productImg" value="${product.saveFileNm}" />
                                    </c:when>
									<c:otherwise>
										<c:set var="paramStr" value="prdtNum" />
                                        <c:set var="categoryNm" value="${categoryMap[product.ctgr]}" />
                                        <c:set var="productNm" value="${product.prdtNm}" />
                                        <c:set var="productImg" value="${product.savePath}thumb/${product.saveFileNm}" />
									</c:otherwise>
								</c:choose>

								<c:set var="addUrl" value="" />
								<c:if test="${(prdt.corpCd eq Constant.SOCIAL) and (product.prdtDiv eq Constant.SP_PRDT_DIV_FREE)}">
									<c:set var="addUrl" value="&prdtDiv=${product.prdtDiv}" />
								</c:if>

								<div class="event-group">
									<div class="product-area">
										<a href="<c:url value="/mw/${fn:toLowerCase(prdt.corpCd)}/detailPrdt.do?${paramStr}=${product.prdtNum}${addUrl}" />">
											<div class="social-photo">
												<div class="bxLabel">
													<c:if test="${not empty prmtPrdtMap[product.prdtNum].label2}">
														<span class="main_label yellow">${labelMap[prmtPrdtMap[product.prdtNum].label2]}</span>
													</c:if>
													<c:if test="${not empty prmtPrdtMap[product.prdtNum].label3}">
														<span class="main_label blue">${labelMap[prmtPrdtMap[product.prdtNum].label3]}</span>
													</c:if>
												</div>

                                                <img src="${productImg}" class="product" alt="${fn:escapeXml(productNm)}">
											</div>

											<div class="text">
												<c:set var="label1" value="${prmtPrdtMap[product.prdtNum].label1}" />

												<c:if test="${not empty label1}">
													<c:choose>
														<c:when test="${label1 eq 'LB01'}">
															<c:set var="cssLabel1" value="red" />
														</c:when>
														<c:when test="${label1 eq 'LB02'}">
															<c:set var="cssLabel1" value="hot" />
														</c:when>
														<c:when test="${label1 eq 'LB08'}">
															<c:set var="cssLabel1" value="only-nao" />
														</c:when>
														<c:otherwise>
															<c:set var="cssLabel1" value="" />
														</c:otherwise>
													</c:choose>

													<c:set var="label1" value="<span class='event-label ${cssLabel1}'>${labelMap[label1]}</span>" />
												</c:if>

                                                <h5>${categoryNm} ${label1}</h5>
                                                <h2>${productNm}</h2>
												<p>${prmtPrdtMap[product.prdtNum].note}</p>

												<div class="info">
													<dl>
														<dt>
															<dd>
																<div class="price">
																	<c:if test="${not ((prdt.corpCd eq Constant.SOCIAL) and (product.prdtDiv eq Constant.SP_PRDT_DIV_FREE))}">
																		<c:if test="${product.nmlAmt ne product.saleAmt}">
																			<b><fmt:formatNumber value="${1 - (product.saleAmt / product.nmlAmt)}" type="percent" /></b>
																		</c:if>
																		<strong><fmt:formatNumber value="${product.saleAmt}" /></strong>원~
																	</c:if>
																	<c:if test="${(prdt.corpCd eq Constant.SOCIAL) and (product.prdtDiv eq Constant.SP_PRDT_DIV_FREE)}">
																		<b>쿠폰상품</b>
																	</c:if>
																</div>
															</dd>
														</dt>
													</dl>
												</div>
											</div>
										</a>
									</div>
								</div>
							</c:forEach>
						</div>
					</section>
				</c:if>
			</div>

			<c:if test="${prmtVO.cmtYn eq 'Y'}">
				<!--이벤트댓글-->
				<div class="event-review">
					<form name="frm" id="prmtCmtFrm" method="post" onSubmit="return false;">
						<input type="hidden" name="cmtSn" id="cmtSn" value=""/>
						<input type="hidden" name="prmtNum" id="prmtNum" value="${prmtVO.prmtNum}"/>

						<div class="regi">
							<c:if test="${isLogin eq 'Y'}">
								<textarea class="review-t" name="contents" id="cmtContents" placeholder="최대 500자 까지 작성할 수 있습니다."></textarea>
								<a href="javascript:fn_prmtCmtInsert()" class="cm-btn">등록</a>
							</c:if>
							<c:if test="${isLogin eq 'N'}">
								<textarea class="review-t" name="contents" id="cmtContents" placeholder="로그인 시 댓글을 작성할 수 있습니다." onclick="javascript:fn_login();"></textarea>
								<a href="javascript:fn_login()" class="cm-btn">등록</a>
							</c:if>
						</div>
					</form>

					<div id="divComment">
					</div>
				</div>
			</c:if>
		</div>
	</c:if>

	<c:if test="${prmtVO.winsYn eq 'Y'}">
		<div class="tabs-left">
			<ul class="event-list">
				 <li><img src="${prmtVO.winsImg}" alt="당첨자 발표" class="width100"></li>
			 </ul>
		</div>
	</c:if>

	</c:if>

	<%--<c:if test="${prmtVO.prmtNum eq 'PM00001667'}">
		<!-- 0911 event-page -->
	    <div class="event-page">
	        <div class="event-mw">
	            <img src="../../images/mw/event/onjeju_event_01.jpg" class="event-img" alt="다시on제주 프로모션">
	            <div class="rolling-num">
	                <div class="container count">
	                    <div class="number-ticker" data-value="10000000"></div>
	                    <span class="unit">원</span>
	                </div>
	                <img src="../../images/mw/event/onjeju_event_02.jpg" class="event-img" alt="다시on제주 프로모션">
	            </div>
	            <img src="../../images/mw/event/onjeju_event_03.jpg" class="event-img" alt="다시on제주 프로모션">
	        </div>
	        <a href="https://www.tamnao.com/mw/mypage/couponList.do" class="event-btn-m">쿠폰받고 기부하기</a>
	    </div>
	    <!-- //event-page -->
	</c:if>--%>
	<!-- 고향사랑기부제 -->
	<c:set var="acceptExt" value="${Constant.FILE_CHECK_EXT}" />
	<%--<c:if test="${prmtVO.prmtNum eq 'PM00001750'}">
		<div class="sub-content mw-event">
			<div class="event">
				<ul class="event-list">
					<li>
						<div class="pr-img">
							<c:set var="dtlImgUrl" value="${prmtVO.dtlImg}" />

							<c:if test="${not empty prmtVO.mobileDtlImg}">
								<c:set var="dtlImgUrl" value="${prmtVO.mobileDtlImg}" />
							</c:if>
							<img src="${dtlImgUrl}" alt="${prmtVO.prmtNm}">
						</div>
					</li>
				</ul>
			</div>
		</div>
	    <div class="event-page">
	        <div class="event-mw">
	        </div>
	        <div class="file-upload-button">
	        	<c:if test="${isLogin eq 'Y' }">
			        <form name="frm${prmtVO.prmtNum}" id="frm${prmtVO.prmtNum}" method="post" onSubmit="return false;" enctype="multipart/form-data">
						<input type="hidden" name="userId" value="${userInfo.userId}"/>
						<input style="display: none;" type="file" id="uploadfileImg" name="file_${prmtVO.prmtNum}" onchange="fn_updateHometownFile('${prmtVO.prmtNum}',this)">
					</form>
				</c:if>
				<span onclick="javascript:fn_isLogin();" class="event-btn-m" style="cursor: pointer;">기부증 파일업로드</span>
			</div>
	    </div>
	</c:if>--%>
	<%-- 승선이벤트 --%>
	<%--<c:if test="${prmtVO.prmtNum eq 'PM00001849'}">
		<div class="sub-content mw-event">
			<div class="event">
				<ul class="event-list">
					<li>
						<div class="pr-img">
							<c:set var="dtlImgUrl" value="${prmtVO.dtlImg}" />

							<c:if test="${not empty prmtVO.mobileDtlImg}">
								<c:set var="dtlImgUrl" value="${prmtVO.mobileDtlImg}" />
							</c:if>
							<img src="${dtlImgUrl}" alt="${prmtVO.prmtNm}">
						</div>
					</li>
				</ul>
			</div>
		</div>
	    <div class="event-page">
	        <div class="event-mw">
	        </div>
	        <div class="file-upload-button">
	        	<c:if test="${isLogin eq 'Y' }">
			        <form name="frm${prmtVO.prmtNum}" id="frm${prmtVO.prmtNum}" method="post" onSubmit="return false;" enctype="multipart/form-data">
						<input type="hidden" name="userId" value="${userInfo.userId}"/>
						<input style="display: none;" type="file" id="uploadfileImg" name="file_${prmtVO.prmtNum}" onchange="fn_updatePrmtFile('${prmtVO.prmtNum}',this);">
					</form>
				</c:if>
				<span onclick="javascript:fn_isLogin();" class="event-btn-m" style="cursor: pointer;">이미지파일 업로드</span>
			</div>
	    </div>
	</c:if>--%>
	<%-- 혁신이벤트 --%>
	<c:if test="${prmtVO.prmtNum eq 'PM0000XXXX'}">
		<div class="event-page">
	        <div class="event-mw">
				<img src="/images/web/event/on_jeju_promotion_1.jpg" class="event-img" alt="렌트카 숙소 40% 할인">
	        </div>
	        <div>
				<a href="/mw/rentcar/jeju.do?sCouponCnt=1" class="event-btn-m">렌트카바로가기</a>
				<a href="https://www.tamnao.com/mw/evnt/detailPromotion.do?prmtDiv=PLAN&prmtNum=PM00002030" class="event-btn-m">숙소바로가기</a>
			</div>
	    </div>
		<div class="event-page">
	        <div class="event-mw">
				<img src="/images/web/event/on_jeju_promotion_2.jpg" class="event-img" alt="수능수험표인증 30% 할인">
	        </div>
	        <div <%--class="file-upload-button"--%>>
	        	<c:if test="${isLogin eq 'Y' }">
			        <form name="frm${prmtVO.prmtNum}" id="frm${prmtVO.prmtNum}" method="post" onSubmit="return false;" enctype="multipart/form-data">
						<input type="hidden" name="userId" value="${userInfo.userId}"/>
						<input style="display: none;" type="file" id="uploadfileImg" name="file_${prmtVO.prmtNum}" onchange="fn_updatePrmtFile('${prmtVO.prmtNum}',this);">
					</form>
				</c:if>
				<span onclick="javascript:fn_isLogin();" class="event-btn-m" style="cursor: pointer;">수능 수험표 인증하기 CLICK!</span>
			</div>
	    </div>
	    <div class="event-page">
	        <div class="event-mw event-mw_03">
	            <img src="/images/web/event/on_jeju_promotion_3.jpg" class="event-img" alt="쿠폰1개발급 100월 자동 기부">

	                <div class="container count">
	                    <div class="number-ticker" data-value="10000000"></div>
	                    <span class="unit">원</span>
	                </div>
	        </div>
	    </div>
	</c:if>
</section>
<script>
	var checkUpload = false;

	/** 파일 체크 */
	function checkPrmtFile(el, ext, size){
		var file = el.files;
		var fileName = file[0].name;
		var fileSize = file[0].size;
		// 파일 확장자 체크
		// var ext = ".png,.jpg,.jpeg,.gif,.pdf";
		var extList = ext.split(",");
		var extName = fileName.substring(fileName.lastIndexOf(".")).toLowerCase();

		var tfCheck;
		for(var i=0; i < extList.length; i++) {
			if(extName == $.trim(extList[i])) {
				tfCheck = true;
				break;
			} else {
				tfCheck = false;
			}
		}
		if(!tfCheck) {
			alert("업로드 불가능한 파일입니다.");
			checkUpload = false;
		} else {
			// 파일 용량 체크
			if(fileSize > (size * 1024 * 1024)) {
				alert("파일은 " + size + "MB 이하이어야 합니다.");
				checkUpload = false;
			} else {
				checkUpload = true;
				return;
			}
		}
		el.outerHTML = el.outerHTML;
	}

	function fn_isLogin(){
		<c:if test="${isLogin eq 'N' or isLogin eq 'G' }">
			if(confirm('로그인 후 수험생 이벤트에 참여할 수 있습니다.\n로그인 하시겠습니까?')) {
				fn_login();
			}
		</c:if>
		<c:if test="${isLogin eq 'Y' }">
			$("#uploadfileImg").click();
		</c:if>
	}
	
	function fn_updateHometownFile(prmtNum,obj){

		<c:if test="${isLogin eq 'Y' }">
			var file = $("input[name=file_"+prmtNum+"]").val();
			if(file == ""){
				alert("기부제 증명서 이미지파일을 선택해주세요.");
				return;
			}

			checkPrmtFile(obj, '${acceptExt}', 5);
			if(!checkUpload){
				return;
			}
			
		    var form = $('#frm'+ prmtNum)[0];
			var data = new FormData(form);
			data.append("prmtNum", prmtNum);
			$.ajax({
				type:"post",
				enctype: 'multipart/form-data',
				url:"<c:url value='/web/evnt/uploadHometownFile.ajax'/>",
				data: data,
				processData: false,
				contentType: false,
				success:function(data){
					if (data.Status == 'success') {
						alert('기부제 증명서가 등록 되었습니다.');
						location.reload();
					}
				},
				error : fn_AjaxError
			});
		</c:if>
	}
	
	function fn_updatePrmtFile(prmtNum,obj){

		<c:if test="${isLogin eq 'Y' }">
			var file = $("input[name=file_"+prmtNum+"]").val();
			if(file == ""){
				alert("이미지파일을 선택해주세요.");
				return;
			}

			checkPrmtFile(obj, '${acceptExt}', 5);
			if(!checkUpload){
				return;
			}
			
		    var form = $('#frm'+ prmtNum)[0];
			var data = new FormData(form);
			data.append("prmtNum", prmtNum);
			$.ajax({
				type:"post",
				enctype: 'multipart/form-data',
				url:"<c:url value='/web/evnt/uploadPrmtFile.ajax'/>",
				data: data,
				processData: false,
				contentType: false,
				success:function(data){
					if (data.Status == 'success') {
						alert('이미지가 등록 되었습니다.');
						location.reload();
					}
				},
				error : fn_AjaxError
			});
		</c:if>
	}
</script>
<!-- 콘텐츠 e -->
<!-- 푸터 s -->
<script src="<c:url value='/js/number-ticker.js'/>"></script>
<jsp:include page="/mw/foot.do"></jsp:include>

</div>
</body>
</html>
