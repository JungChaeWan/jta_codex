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

<un:useConstants var="Constant" className="common.Constant" />
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>

	<meta charset="utf-8">
	<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

	<title></title>
	<script type="text/javascript">
		$(document).ready(function () {

			// 상품번호 입력 감지
			$("#oPrdtNum, #cPrdtNum").on("keyup", function () {

				var inputVal = $(this).val();
				var element = $(this);

				if(element.is("#oPrdtNum")){
					$("#oPrdtNumSend").val('');
				}else if (element.is("#cPrdtNum")) {
					$("#cPrdtNumSend").val('');
				}

				if (inputVal.length === 10) {
					$.ajax({
						url     : "<c:url value='/web/cmm/getPrdtInfo.ajax'/>",
						data    : "prdtNum=" + inputVal,
						dataType: "json",
						success : function (data) {

							const autocompleteSource = [{
								label		: data.prdtNum + " (" + data.prdtNm + " " + data.confDttm + ")",
								value		: data.prdtNum,
								prdtNum		: data.prdtNum
							}];

							element.autocomplete({
								source  : autocompleteSource,
								minLength : 0,
								appendTo: "body",
								select: function (event, ui){
									// 선택된 항목의 prdtNum값을 hidden input에 설정
									if (element.is("#oPrdtNum")) {
										$("#oPrdtNumSend").val(ui.item.prdtNum);

										// 추가된 상품평 가져오기
										getUseepilAddList(ui.item.prdtNum);

									} else if (element.is("#cPrdtNum")) {
										$("#cPrdtNumSend").val(ui.item.prdtNum);
									}
									return false;
								}
							});

							//팝업 강제 표시
							element.autocomplete("search", "");
						},
						error   : function (xhr, status, error) {
							console.log("AJAX Error: " + error);
						}
					})
				}
			});
		});

		// 상품번호로 해당 후기추가리스트 get
		function getUseepilAddList(prdtNum) {
			$.ajax({
				url: "<c:url value='/web/cmm/getUseepilAddList.ajax'/>",
				data: { prdtNum: prdtNum },
				dataType: "json",
				success: function(data) {

					var reviewsHtml = '';

					// 상품평 리스트 동적으로 생성
					if (data.useepilAddList.length > 0) {
						reviewsHtml = '<ul>';
						$.each(data.useepilAddList, function(index, list) {
							reviewsHtml += '<li data-seq="' + list.seq + '">' + list.cPrdtNum + ' (' + list.cPrdtNm + ' ' + list.cConfDttm +')';
							reviewsHtml += '<div class="btn_sty03">';
							reviewsHtml += '<a href="javascript:fn_UseepilAddDel('+ list.seq +');">삭제</a> ';
							reviewsHtml += '</li></div>';
						});
						reviewsHtml += '</ul>';
					} else {
						reviewsHtml = '<p>추가된 후기가 없습니다. </p>';
					}

					// "추가된 상품평" 영역에 표시
					$('#productReviewList').html(reviewsHtml);
				},
				error: function(xhr, status, error) {
					console.log("AJAX Error: " + error);
				}
			});
		}

		//상품평 추가
		function fn_UseepilAdd(){

			if ($("#oPrdtNumSend").val() == "" ){
				alert("기존 상품평 상품번호를 선택해 주세요.");
				return;
			}

			if ($("#cPrdtNumSend").val() == "" ){
				alert("추가 할 상품평 상품번호를 선택해 주세요");
				return;
			}

			$.ajax({
				url: "<c:url value='/web/cmm/insertUseepilAdd.ajax'/>",
				data:  $("#frm").serialize(),
				dataType: "json",
				success: function(data) {
					if (data.success == "OX"){
						alert("기존 상품평 상품번호가 없거나 잘못 되었습니다.");
						return;
					}

					if (data.success == "CX"){
						alert("추가 할 상품평 상품번호가 없거나 잘못 되었습니다.");
						return;
					}
					console.log($("#oPrdtNum").val());
					// 추가된 상품평 가져오기
					getUseepilAddList($("#oPrdtNum").val());
				},
				error: function(xhr, status, error) {
					console.log("AJAX Error: " + error);
				}
			});

		}

		// 상품평 삭제
		function fn_UseepilAddDel(seq) {
			if (confirm("정말 삭제하시겠습니까?")) {
				$.ajax({
					url    : "<c:url value='/web/cmm/deleteUseepilAdd.ajax'/>",
					data   : {seq: seq},  // 삭제할 항목의 seq 값 전달
					type   : "POST",
					success: function (data) {
						if (data.success === 'Y') {
							// 해당 seq 값을 가진 li 요소를 삭제
							$('li[data-seq="' + seq + '"]').remove();
							console.log('삭제 성공');
						}
					},
					error  : function (xhr, status, error) {
						console.log("AJAX Error: " + error);
					}
				});
			}
		}

	</script>

</head>
<body>
<div id="wrapper">
	<jsp:include page="/oss/head.do?menu=community" flush="false"></jsp:include>
	<!--Contents 영역-->
	<div id="contents_wrapper">
		<jsp:include page="/oss/left.do?menu=community&sub=useepilAdd" flush="false"></jsp:include>
		<div id="contents_area">
				<form id="frm" name="frm" onSubmit="return false;" method="post">
				<input type="hidden" name="oPrdtNumSend" id="oPrdtNumSend" value="" />
				<input type="hidden" name="cPrdtNumSend" id="cPrdtNumSend" value="" />
				</form>
				<div id="contents">
					<h4 class="title03">기존 상품평</h4>
					<table border="1" class="table02">
						<colgroup>
							<col width="200" />
							<col width="*" />
						</colgroup>
						<tr>
							<th scope="row">상품 번호</th>
							<td>
								<input type="text" name="oPrdtNum" id="oPrdtNum" value="" class="input_text50" placeholder="상품번호를 입력해 주세요.">
							</td>
						</tr>
						<tr>
							<th>추가된 상품평</th>
							<td>
								<div id="productReviewList">
									상품번호를 선택하면 해당 상품의 추가 된 상품번호가 표시 됩니다.
								</div>
							</td>
						</tr>
					</table>

					<h4 class="title03 margin-top45">추가 할 상품평</h4>
					<table border="1" class="table02">
						<colgroup>
							<col width="200" />
							<col width="*" />
						</colgroup>
						<tr>
							<th scope="row">상품번호</th>
							<td>
								<input type="text" name="cPrdtNum" id="cPrdtNum" value="" class="input_text50" placeholder="상품번호를 입력해 주세요.">
							</td>
						</tr>

					</table>


					<br>
					<div class="btn_sty03">
						<a href="javascript:fn_UseepilAdd();">기존 상품평에 추가하기</a>
					</div>

				</div>

		</div>
	</div>
</div>
</body>
</html>