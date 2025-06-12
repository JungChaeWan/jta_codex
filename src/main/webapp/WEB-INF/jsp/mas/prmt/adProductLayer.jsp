<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>

	<ul class="form_area">
		<li>
		<h5 class="comm-title1">상품 선택</h5>
		<div class="auto-scroll">
		<table border="1" class="table01">
			<colgroup>
                <col width="*" />
                <col width="250" />
                <col width="50" />
            </colgroup>
			<tr>
				<th> 상품 번호</th>
				<th> 상품명 </th>
				<th> <input type="checkbox" id="prdtChkAll"> </th>
			</tr>
			<c:forEach var="product" items="${resultList}"	varStatus="status">
	         <tr>
	         	<td class="align_ct">${product.prdtNum }</td>
	         	<td class="align_ct prmtProductNm">${product.prdtNm}</td>
	         	<td class="align_ct"><input type="checkbox" name="prdt_check" value="${product.prdtNum}"/></td>
	         </tr>
	         </c:forEach>
		</table>
		</div>
		</li>
	</ul>
	<div class="btn_rt01"><span class="btn_sty04"><a href="javascript:fn_selectProduct();">선택</a></span></div>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#prdtChkAll").click(function() {
				if($("#prdtChkAll").is(":checked")) $("input[name=prdt_check]").prop("checked", true);
				else $("input[name=prdt_check]").prop("checked", false);
			});

			$("input[name=prdt_check]").click(function() {
				var total = $("input[name=prdt_check]").length;
				var checked = $("input[name=prdt_check]:checked").length;

				if(total != checked) $("#prdtChkAll").prop("checked", false);
				else $("#prdtChkAll").prop("checked", true);
			});
		});
	</script>