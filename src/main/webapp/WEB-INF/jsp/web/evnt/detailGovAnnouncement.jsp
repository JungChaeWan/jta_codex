<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 			uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />
<head>
<c:set var="strServerName" value="${pageContext.request.serverName}"/>
<c:set var="strURL" value="${strServerName}${pageContext.request.contextPath}${requestScope['javax.servlet.forward.servlet_path']}?prmtDiv=${prmtVO.prmtDiv}&prmtNum=${prmtVO.prmtNum}"/>

<jsp:include page="/web/includeJs.do">
	<jsp:param name="title" value="제주여행 ${prmtVO.prmtNm}, 탐나오"/>
</jsp:include>
<meta property="og:title" content="제주여행 ${prmtVO.prmtNm}, 탐나오" />
<meta property="og:url" content="https://${strURL}" />
<meta property="og:description" content="<c:out value='${prmtVO.prmtNm}'/>" />
<c:if test="${not empty prmtVO.listImg}">
<meta property="og:image" content="https://${strServerName}${prmtVO.listImg}" />
</c:if>
<meta property="fb:app_id" content="182637518742030" />

<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css?version=${nowDate}'/>" />
<link rel="stylesheet" href="../../css/web/number-ticker.css">

<!-- SNS관련----------------------------------------- -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="<c:url value='/js/sns.js'/>"></script>
</head>
<body>
<header id="header">
	<jsp:include page="/web/head.do" />
</header>
<main id="main">
	<div class="mapLocation">
		<div class="inner">
			<span>홈</span> <span class="gt">&gt;</span>
			<span>공고 신청</span>
		</div>
	</div>
	<div class="subContainer">
	    <div class="subHead"></div>
	    <div class="subContents">
	        <div class="event2-wrap event-detail">
			    <div class="bgWrap2">
			        <div class="Fasten">
			            <div class="tabs-wrap">
							<div class="tabs-left">
								<div class="title-area">
									<h2 class="title">
										${prmtVO.prmtNm}
										<span class="date">
											<fmt:parseDate value="${prmtVO.startDt}" var="startDt" pattern="yyyyMMdd" />
											<fmt:parseDate value="${prmtVO.endDt}" var="endDt" pattern="yyyyMMdd" />
											<fmt:formatDate value="${startDt}" pattern="yyyy.MM.dd" /> ~ <fmt:formatDate value="${endDt}" pattern="yyyy.MM.dd" />
										</span>
									</h2>
									<!-- 0310 공유하기-모달팝업 -->
									<div class="icon-group">
										<button class="sns-share" type="button">
											<img src="<c:url value='/images/web/icon/sns.png' />" alt="sns">
										</button>
									</div>
									<div id="sns_popup" class="sns-popup">
										<ul class="sns-area">
											<li>
												<a href="javascript:shareStory('${strURL}'); snsCount('${prmtVO.prmtNum}', 'PC', 'KAKAO');">
													<img src="<c:url value='/images/web/icon/sns/kakaostory.png' />" alt="카카오스토리">
													<span>카카오톡</span>
												</a>
											</li>
											<li>
												<a href="javascript:shareFacebook('${strURL}'); snsCount('${prmtVO.prmtNum}', 'PC','FACEBOOK');">
													<img src="<c:url value='/images/web/icon/sns/facebook.png' />" alt="페이스북">
													<span>페이스북</span>
												</a>
											<li>
											<li>
												<a href="javascript:shareBand('${strURL}'); snsCount('${prmtVO.prmtNum}', 'PC', 'BAND' );">
													<img src="<c:url value='/images/web/icon/sns/band.png' />" alt="밴드">
													<span>네이버 밴드</span>
												</a>
											</li>
										</ul>
									</div><!-- //0310 공유하기-모달팝업 -->
								</div>
								<ul class="event-list">
									<li><img style="width:100%" src="${prmtVO.dtlImg}" alt="${prmtVO.prmtNm}"></li>
								</ul>
							</div>
							<input type="hidden" id="prmtNum" value="${prmtVO.prmtNum}" />

							<div class="fileArea-wrap">

								<div id="fileArea">
									<!-- 단체명 입력 -->
									<div class="area-txt">
										<label for="orgName">단체명 또는 신청업체</label>
										<input type="text" id="orgName" name="orgName" />
									</div>

									<!-- 공고구분 라디오 -->
									<div class="area-txt radio-button-group">
										<div class="title">공고구분</div>

										<div class="gova-type-options">
											<input id="opt1" type="radio" name="govaType" value="P" checked>
											<label for="opt1">사전</label>

											<input id="opt2" type="radio" name="govaType" value="R">
											<label for="opt2">결과</label>
										</div>
									</div> <!-- //공고구분 라디오 -->

									<div id="fileList">
										<!-- 기본 1개 파일 입력 -->
										<tr>
											<th class="title">첨부파일</th>
											<td colspan="3">
												<c:forEach var="data" items="${prmtFileList}" varStatus="status">
													<img class="fileIcon" src="/images/web/board/file_2.png" alt="첨부파일"/>
													<span><a href="javascript:fn_DownloadFile('${data.prmtFileNum}')" title="${data.realFileNm }">(붙임${status.index+1 }) <c:out value="${data.realFileNm }"/> </a></span><br/>
												</c:forEach>
											</td>
										</tr>

										<!-- 파일 선택 -->
										<div class="file-row">
											<input class="custom-file-btn" type="file" name="files" />
											<button type="button" onclick="removeFileInput(this)">삭 제</button>
										</div>
									</div>

									<button class="add-file-btn" onclick="addFileInput()">파일 추가 +</button>

                                    <!-- 업로드 button -->
                                    <button class="file-actions__upload" onclick="uploadFiles()">업로드</button>
								</div>
								<div id="result"></div>
								<div id="progressContainer" style="display:none; margin-top:10px;">
									<div style="width:100%; background:#eee;">
										<div id="progressBar" style="width:0%; height:20px; background:#28a745;"></div>
									</div>
									<div id="progressText" style="margin-top:5px;">0%</div>
								</div>
							</div>

							<div class="row-paging">
								<div class="row-area"></div>
								<div class="btn-wrap right">
									<span onclick="fn_list();" class="comm-btn black typeB" style="cursor: pointer;">목록</span>
								</div>
							</div>
			            </div>
			        </div>
			    </div>
			</div>
	    </div>
	</div>
	<form name="frmPrmt" method="post" onsubmit="return false;"></form>
	<iframe name="frmFileDown" style="display:none"></iframe>
</main>
<script>

	function fn_DownloadFile(Id){
		frmFileDown.location = "<c:url value='/web/evnt/DtlFileDown.do'/>" + "?prmtFileNum=" + Id;
	}

	$(document).ready(function () {
		bindExtensionCheckToFileInputs();

		$("input[type='file']:first, #orgName").on("click", function (e) {
			if ("${isLogin}" === "N") {
				alert("로그인 후 신청 가능합니다.");
				fn_login();
				e.preventDefault();
			}
		});

		//공유하기-모달팝업
		isShow = true;

		$('.sns-share').click(function () {
			if(isShow) {
				isShow = false;

				$('#sns_popup').show();
			}else {
				isShow = true;

				$('#sns_popup').hide();
			}
		})
	});

	let fileCount = 1;
	const MAX_FILES = 13;

	function addFileInput() {
		if ("${isLogin}" === "N") {
			alert("로그인 후 신청 가능합니다.")
			fn_login();
			return;
		}

		if (fileCount >= MAX_FILES) {
			alert("최대 13개 파일까지만 등록 가능합니다.");
			return;
		}

		const fileRow = $('<div class="file-row"></div>');
		const fileInput = $('<input type="file" name="files" />');
		const deleteBtn = $('<button type="button">삭제</button>');

		deleteBtn.on("click", function () {
			removeFileInput(this);
		});

		fileRow.append(fileInput).append(deleteBtn);
		$("#fileList").append(fileRow);
		fileCount++;

		bindExtensionCheckToFileInputs();
	}

	function removeFileInput(button) {
		$(button).parent().remove();
		fileCount--;
	}

	function uploadFiles() {

		const formData = new FormData();
		const orgName = $("#orgName").val().trim();
		const govaType = $("input[name='govaType']:checked").val();
		const prmtNum = $("#prmtNum").val();

		formData.append("orgName", orgName);
		formData.append("govaType", govaType);
		formData.append("prmtNum", prmtNum);

		if ( orgName == "" || orgName == null ){
			alert("단체명 또는 신청업체를 입력 해 주세요.");
			return;
		}

		const MAX_TOTAL_SIZE = 50 * 1024 * 1024; //총 용량이 50M가 이하만 업로드 가능
		let hasFile = false;
		let totalSize = 0;

		$("input[type='file']").each(function () {
			const file = this.files[0];
			if (file) {
				totalSize += file.size;
				formData.append("files", file);
				hasFile = true;
			}
		});

		if (!hasFile) {
			alert("업로드할 파일을 선택하세요.");
			return;
		}

		if (totalSize > MAX_TOTAL_SIZE) {
			alert("총 업로드 용량이 50MB를 초과했습니다. \n 50M까지만 업로드 하실 수 있습니다.\n현재 용량: " + (totalSize / (1024 * 1024)).toFixed(2) + "MB");
			return;
		}

		// 프로그레스바 초기화 및 표시
		$("#progressContainer").show();
		$("#progressBar").css("width", "0%");
		$("#progressText").text("0%");
		$("#result").empty();

		$.ajax({
			url: "/web/evnt/uploadGovAnnouncementFile.ajax",
			type: "POST",
			data: formData,
			processData: false,
			contentType: false,
			xhr: function () {
				const xhr = new window.XMLHttpRequest();
				xhr.upload.addEventListener("progress", function (e) {
					if (e.lengthComputable) {
						let percent = Math.round((e.loaded / e.total) * 100);
						$("#progressBar").css("width", percent + "%");
						$("#progressText").text(percent + "%");
					}
				}, false);
				return xhr;
			},
			success: function (res) {
				$("#progressContainer").hide();
				if (res.Status === "success") {
					let uploadedText = res.Uploaded ? res.Uploaded.replace(/\n/g, "<br>") : "";
					$("#result").html("<img src='/images/web/board/icon_success.png' alt='신청 성공'> 신청이 정상적으로 성공하였습니다.<br>" + uploadedText);
					$("#fileArea").hide();
				} else {
					let msg = res.Message || "알 수 없는 오류가 발생했습니다.";
					$("#result").html("<img src='/images/web/board/icon_error.png' alt='신청 실패'> 신청 실패 하였습니다.<br>오류가 반복 되면 고객센터(1522-3454)에 연락 부탁 드립니다.<br>" + msg);
				}
			},
			error: function () {
				$("#progressContainer").hide();
				$("#result").html("❌ 업로드 실패 (서버 오류)");
			}
		});
	}

	const blockedExtensions = ["exe", "jsp", "js", "bat", "sh", "php"];
	function bindExtensionCheckToFileInputs() {
		$("input[type='file']").off("change").on("change", function () {
			const file = this.files[0];
			if (!file) return;

			const fileName = file.name;
			const ext = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();

			if (blockedExtensions.includes(ext)) {
				alert("[" + ext + "] 확장자 파일은 업로드할 수 없습니다.");
				$(this).val(""); // 선택 초기화
			}
		});
	}

	function fn_list() {
		document.frmPrmt.action = "<c:url value='/web/evnt/prmtPlanList.do?sPrmtDiv=GOVA'/>";
		document.frmPrmt.submit();
	}

	function fn_Detail(prmtNum) {
		document.frmPrmt.prmtNum.value = prmtNum;
		document.frmPrmt.action = "<c:url value='/web/evnt/detailPromotion.do'/>";
		document.frmPrmt.submit();
	}

	function fn_confirmLogin() {
		if(confirm("<spring:message code="confirm.login" />")) {
			fn_login();
		}
	}
</script>
<jsp:include page="/web/right.do" />
<jsp:include page="/web/foot.do" />
</body>
</html>