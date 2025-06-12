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
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<meta name="robots" content="noindex, nofollow">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
.dim-layer {
  display: none;
  position: fixed;
  _position: absolute;
  top: 5%;
  left: 48%;
  width: 50%;
  height: 80%;
  z-index: 100;
}
</style>
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui-1.11.4.js'/>" ></script>
<script type="text/javascript">

	$(function () {
		let currentButton = null;

		$(".openMemoBtn").on("click", function () {
			const seq = $(this).data("seq");
			const memo = $(this).data("memo");

			currentButton = $(this);  // 나중에 색상 변경용

			$("#memoSeq").val(seq);
			$("#memoText").val(memo);

			$("#memoLayer").show();
		});

		$("#saveMemoBtn").on("click", function () {
			const seq = $("#memoSeq").val();
			const memo = $("#memoText").val();

			$.ajax({
				url    : "/wmn/updateGovaMemo.ajax",
				type   : "POST",
				data   : {
					seq: seq,
					memo   : memo
				},
				success: function (response) {
					$("#memoLayer").hide();
					currentButton
							.removeClass("btn-secondary").addClass("btn-success")
							.data("memo", memo);
				},
				error  : function () {
					alert("메모 저장에 실패했습니다.");
				}
			});
		});

		$(".checkBtn").on("click", function () {
			const $btn = $(this);
			const seq = $btn.data("seq");
			const currentStatus = $btn.data("status"); // Y 또는 N
			const newStatus = currentStatus === "Y" ? "N" : "Y";

			$.ajax({
				url: "/wmn/updateGovaConfirmed.ajax",
				type: "POST",
				data: {
					seq: seq,
					isConfirmed: newStatus
				},
				success: function () {
					// 버튼 상태 갱신
					$btn
							.text(newStatus)
							.data("status", newStatus)
							.removeClass("btn-success btn-secondary")
							.addClass(newStatus === "Y" ? "btn-success" : "btn-secondary");
				},
				error: function () {
					alert("확인여부 변경 실패");
				}
			});
		});

		let fullList = [];

		// 최초 로딩 시 전체 데이터 받아오기
		$.ajax({
			url: "/wmn/getPrmtAutoList.ajax",
			type: "GET",
			dataType: "json",
			success: function (data) {
				fullList = data.list;
			}
		});

		// input 클릭 시 전체 드롭다운 보여주기
		$("#prmtSearch").on("focus click", function () {
			renderDropdown("");
		});

		// input 입력 시 필터링
		$("#prmtSearch").on("input", function () {
			const keyword = $(this).val().toLowerCase();
			renderDropdown(keyword);
		});

		// 드롭다운 렌더링 함수
		function renderDropdown(keyword) {
			const $dropdown = $("#prmtDropdown");
			$dropdown.empty();

			const filtered = fullList.filter(item => item.prmtNm.toLowerCase().includes(keyword));

			if (filtered.length === 0) {
				$dropdown.hide();
				return;
			}

			$.each(filtered, function (i, item) {
				const $li = $("<li>")
						.addClass("list-group-item list-group-item-action")
						.text(item.prmtNm)
						.attr("data-value", item.prmtNum)
						.on("click", function () {
							const prmtNm = item.prmtNm;
							const prmtNum = item.prmtNum;

							$("#prmtSearch").val(prmtNm);
							$("#hiddenPrmtNum").val(prmtNum);

							$dropdown.hide();

							// 직접 URL로 이동
							const baseUrl = "/wmn/govAnnouncementList.do";
							let query = "?prmtNum=" + encodeURIComponent(prmtNum) + "&prmtNm=" + encodeURIComponent(prmtNm);

							window.location.href = baseUrl + query;
						});

				$dropdown.append($li);
			});

			$dropdown.show();
		}

		// 바깥 클릭 시 닫기
		$(document).on("click", function (e) {
			if (!$(e.target).closest("#prmtSearch, #prmtDropdown").length) {
				$("#prmtDropdown").hide();
			}
		});

	});

	</script>
</head>
<body>

	<div class="row mt-4 mb-2">
		<div class="col-md-6 offset-md-3">
			<div class="position-relative">
				<input type="text" id="prmtSearch" class="form-control shadow-sm rounded-pill px-4 py-2" placeholder="공고명을 입력하세요" autocomplete="off" value="${param.prmtNm}">
				<ul id="prmtDropdown" class="list-group position-absolute w-100 mt-1 shadow-sm rounded" style="z-index:1000; display:none; max-height:200px; overflow-y:auto;"></ul>
			</div>
			<input type="hidden" name="prmtNum" id="hiddenPrmtNum">
		</div>
	</div>

	<div class="row">
		<div class="col-12">
			<form method="get" action="/wmn/govAnnouncementList.do" class="row g-2 m-3">
				<input type="hidden" name="prmtNum" value="${param.prmtNum}"/>
				<input type="hidden" name="isConfirmed" value="${param.isConfirmed}"/>

				<div class="col-auto">
					<input type="text" class="form-control" name="userNm" placeholder="이름" value="${param.userNm}">
				</div>
				<div class="col-auto">
					<input type="text" class="form-control" name="telNum" placeholder="연락처" value="${param.telNum}">
				</div>
				<div class="col-auto">
					<input type="text" class="form-control" name="orgName" placeholder="단체명" value="${param.orgName}">
				</div>
				<div class="col-auto">
					<select class="form-select" name="govaType">
						<option value="">사전/결과</option>
						<option value="P" ${param.govaType eq 'P' ? 'selected' : ''}>사전</option>
						<option value="R" ${param.govaType eq 'R' ? 'selected' : ''}>결과</option>
					</select>
				</div>
				<div class="col-auto">
					<button type="submit" class="btn btn-primary">검색</button>
				</div>
				<div class="col-auto">
					<a href="?prmtNum=${param.prmtNum}&userNm=${param.userNm}&telNum=${param.telNum}&govaType=${param.govaType}&isConfirmed=${param.isConfirmed == 'N' ? '' : 'N'}"
					   class="btn btn-outline-secondary">
							${param.isConfirmed == 'N' ? '전체 보기' : '미확인 리스트 보기'}
					</a>
				</div>
			</form>

			<table class="table table-bordered table-striped">
				<thead>
				<tr>
					<th class="w-5">일시</th>
					<th class="w-5">이름</th>
					<th class="w-15">전화번호</th>
					<th class="w-35">단체명(신청업체).zip</th>
					<th class="w-10">공고구분</th>
					<th class="w-10">확인여부</th>
					<th class="w-10">메모</th>
				</tr>
				</thead>
				<tbody>
				<c:choose>
				<c:when test="${empty resultList}">
					<tr>
						<td colspan="7" class="text-center text-muted">데이터가 없습니다.</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="list" items="${resultList}">
						<tr>
							<td>${list.regDttm}</td>
							<td>${list.userNm}</td>
							<td>${list.telNum}</td>
							<td><a href="/wmn/govAnnouncementDownload.do?folderName=${list.folderName}&orgName=${list.orgName}" class="btn btn-link">${list.orgName}.zip</a></td>
							<td>${list.govaType}</td>
							<td>
								<button type="button"
										  class="btn btn-sm checkBtn ${list.isConfirmed eq 'Y' ? 'btn-success' : 'btn-secondary'}"
										  data-seq="${list.seq}"
										  data-status="${list.isConfirmed}">
									${list.isConfirmed}
								</button>
							</td>
							<td>
								<button type="button"
										class="btn btn-sm ${not empty list.memo ? 'btn-success' : 'btn-secondary'} openMemoBtn"
										data-seq="${list.seq}"
										data-memo="${fn:escapeXml(list.memo)}">
									메모
								</button>
							</td>
						</tr>
					</c:forEach>
				</c:otherwise>
				</c:choose>
				</tbody>
			</table>
		</div>
		<div class="col-12">
			<div id="imgDiv" class="dim-layer border border-dark"></div>
		</div>
	</div>
</div>


<div id="memoLayer" class="position-fixed top-50 start-50 translate-middle bg-white border p-3 shadow"
	 style="display:none; z-index:9999; width:300px;">
	<input type="hidden" id="memoSeq">
	<div class="mb-2">
		<textarea id="memoText" class="form-control" rows="5" placeholder="메모를 입력하세요"></textarea>
	</div>
	<div class="d-flex justify-content-end">
		<button type="button" class="btn btn-sm btn-primary me-2" id="saveMemoBtn">저장</button>
		<button type="button" class="btn btn-sm btn-secondary" onclick="$('#memoLayer').hide();">닫기</button>
	</div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>