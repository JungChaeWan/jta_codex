<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<ul class="form_area">
		<li>
			<table border="1" class="table02">
				<colgroup>
                       <col width="115" />
                       <col width="*" />
                       <col width="105" />
                       <col width="*" />
                   </colgroup>
				<tr>
					<th scope="row" class="align_lt01">업체아이디</th>
					<td>
						<input type="hidden" id="corpId" name="corpId" value='<c:out value="${corpInfo.corpId}" />' />
						<c:out value="${corpInfo.corpId}" />
					</td>
					<th class="align_lt01">연계여부</th>
					<td>
						<c:if test="${corpInfo.corpLinkYn=='Y'}">연계</c:if>
					</td>
				</tr>
				<tr>
					<th class="align_lt01">업체명</th>
					<td><c:out value="${corpInfo.corpNm}" /></td>
					<th class="align_lt01">업체구분</th>
					<td>
						<c:if test="${corpInfo.corpCd=='AD'}">숙박</c:if>
						<c:if test="${corpInfo.corpCd=='RC'}">렌트카</c:if>
						<c:if test="${corpInfo.corpCd=='GL'}">골프</c:if>
						<c:if test="${corpInfo.corpCd=='SP'}">소셜상품</c:if>
					</td>
				</tr>
				<tr>
					<th class="align_lt01">사업자등록번호</th>
					<td><c:out value="${corpInfo.coRegNum}" /></td>
					<th class="align_lt01">대표자명</th>
					<td><c:out value="${corpInfo.ceoNm}" /></td>
				</tr>
				<tr>
					<th class="align_lt01">대표전화번호</th>
					<td><c:out value="${corpInfo.ceoTelNum}" /></td>
					<th class="align_lt01">예약전화번호</th>
					<td><c:out value="${corpInfo.rsvTelNum}" /></td>
				</tr>
				<tr>
					<th class="align_lt01">업체이메일</th>
					<td><c:out value="${corpInfo.corpEmail}" /></td>
					<th class="align_lt01">홈페이지주소</th>
					<td><c:out value="${corpInfo.hmpgAddr}" /></td>
				</tr>
				<tr>
					<th class="align_lt01">업체주소</th>
					<td colspan="3">
						<c:out value="${corpInfo.roadNmAddr}" /><br />
						<c:out value="${corpInfo.dtlAddr}" />
					</td>
				</tr>
				<tr>
					<th class="align_lt01">위도/경도</th>
					<td colspan="3">
						<c:out value="${corpInfo.lat}" /> / <c:out value="${corpInfo.lon}" /> 
					</td>
				</tr>
				<tr>
					<th class="align_lt01">관리자</th>
					<td colspan="3">
						<c:if test="${not empty corpInfo.managerId}">
							<c:out value="${corpInfo.managerId}" />/<c:out value="${corpInfo.managerNm}" />
						</c:if>
					</td>
				</tr>
			</table>
		</li>
	</ul>