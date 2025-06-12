<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>" />

<title></title>
<script type="text/javascript">
	
	/**
	 * 조회 & 페이징
	 */
	function fn_Search(pageIndex){
		document.frm.pageIndex.value = pageIndex;
		document.frm.action = "<c:url value='/mas/sp/mrtnUserList.do'/>";
		document.frm.target = "mrtnUser";
		window.name = "mrtnUser";
		document.frm.submit();
	}
	
	function fn_mrtnUserUpdate(index){
		
		let parameters = "mrtnNum=" + $("#mrtnNum_"+index).val();
		parameters += "&apctNm=" + $("#apctNm_"+index).val();
		parameters += "&apctTelnum=" + $("#apctTelnum_"+index).val();
		parameters += "&ageRange=" + $("#ageRange_"+index).val();
		parameters += "&gender=" + $("#gender_"+index).val();
		parameters += "&bloodType=" + $("#bloodType_"+index).val();
		parameters += "&apctEmail=" + $("#apctEmail_"+index).val();
		
	    $.ajax({
			type:"post",
			url:"<c:url value='/mas/sp/mrtnUserUpdate.ajax'/>",
			data:parameters,
			success:function(data){
				
				if(data.resultCode == "SUCCESS") {
					alert("신청자정보가 수정 되었습니다.");
					location.href = "/mas/sp/mrtnUserList.do" + "?corpId=" + ${corpId} + "&prdtNum=" + ${prdtNum};
				} else {
					alert("신청자정보가 수정이 실패 되었습니다.");
				}		
			},
			error:fn_AjaxError
		});
	}
	
	function fn_ExcelDown(){
		var parameters = $("#frm").serialize();
		frmFileDown.location = "<c:url value='/mas/sp/mrtnUserExcelDown.do?"+ parameters +"'/>";	
	}
	
	function fn_insertTshirts(){
		
		let parameters = "corpId=" + $("#corpId").val();
		parameters += "&prdtNum=" + $("#prdtNum").val();
		
	    $.ajax({
			type:"post",
			url:"<c:url value='/mas/sp/insertTshirts.ajax'/>",
			data:parameters,
			success:function(data){
				
				if(data.resultCode == "SUCCESS") {
					alert("티셔츠수량정보가 생성 되었습니다.");
					document.frm.pageIndex.value = $("#pageIndex").val();
					document.frm.action = "<c:url value='/mas/sp/mrtnUserList.do'/>";
					document.frm.target = "mrtnUser";
					window.name = "mrtnUser";
					document.frm.submit();
				} else {
					alert("티셔츠수량정보 생성이 실패 되었습니다.");
				}		
			},
			error:fn_AjaxError
		});
	}
	
	function fn_mrtnTshirtsUpdate(){
		
		let parameters = "corpId=" + $("#corpId").val();
		parameters += "&prdtNum=" + $("#prdtNum").val();
		parameters += "&txsCnt=" + $("#txsCnt").val();
		parameters += "&tsCnt=" + $("#tsCnt").val();
		parameters += "&tmCnt=" + $("#tmCnt").val();
		parameters += "&tlCnt=" + $("#tlCnt").val();
		parameters += "&txlCnt=" + $("#txlCnt").val();
		parameters += "&t2xlCnt=" + $("#t2xlCnt").val();
		parameters += "&t3xlCnt=" + $("#t3xlCnt").val();
		
	    $.ajax({
			type:"post",
			url:"<c:url value='/mas/sp/mrtnTshirtsUpdate.ajax'/>",
			data:parameters,
			success:function(data){
				
				if(data.resultCode == "SUCCESS") {
					alert("티셔츠수량정보가 수정 되었습니다.");
					document.frm.pageIndex.value = $("#pageIndex").val();
					document.frm.action = "<c:url value='/mas/sp/mrtnUserList.do'/>";
					document.frm.target = "mrtnUser";
					window.name = "mrtnUser";
					document.frm.submit();
				} else {
					alert("티셔츠수량정보 수정이 실패 되었습니다.");
				}		
			},
			error:fn_AjaxError
		});
	}
	
	function fn_detailRsv(rsvNum, spRsvNum){
		
		document.frm.pageIndex.value = 1;
		$("#rsvNum").val(rsvNum);
		$("#spRsvNum").val(spRsvNum);
		document.frm.target = "_blank";
		document.frm.action = "<c:url value='/mas/sp/detailRsv.do'/>";
		document.frm.submit();
	}
</script>

</head>
<body>
<div id="popup_wrapper">
    <div id="popup_contents">
        <!--컨텐츠-->
        <form name="frm" id="frm" method="post" onSubmit="return false;">
        	<input type="hidden" name="corpId" id="corpId" value="${corpId}"/>
        	<input type="hidden" name="prdtNum" id="prdtNum" value="${prdtNum}"/>
			<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}" />
			<input type="hidden" name="rsvNum" id="rsvNum" value=""/>
			<input type="hidden" name="spRsvNum" id="spRsvNum" value=""/>
			
			<!--검색폼-->
			<div class="search_area">
				<div class="search_form" style="padding:0 100px;">
					<table>
						<colgroup>
							<col class="width15" />
							<col class="width30" />
							<col class="width15" />
							<col />
						</colgroup>
						<tr>
							<th>신청자명</th>
							<td>
								<input type="text"name="sApctNm" id="sApctNm" value="${sApctNm}"/>
							</td>
							<th>전화번호</th>
							<td>
								<input type="text"name="sApctTelnum" id="sApctTelnum" value="${sApctTelnum}"/>
							</td>
						</tr>
					</table>
					<div class="text-center">
						<input type="image" src="/images/oss/btn/search_btn04.gif" alt="검색" onclick="javascript:fn_Search(1)" />
					</div>
				</div>
			</div>
		</form>
		
		<!--//검색폼-->
		<div style="border-bottom:1px solid #d3d2d1; padding-bottom:35px;">
			<ul class="btn_rt01">
				<c:if test="${mrtnTshirts eq null}">	
					<li class="btn_sty01">
						<a href="javascript:fn_insertTshirts();">티셔츠 수량생성</a>
					</li>
				</c:if>
				<li class="btn_sty04">
					<a href="javascript:fn_ExcelDown();">엑셀다운로드</a>
				</li>
			</ul>
			
			<c:if test="${mrtnTshirts ne null}">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-bottom:1px solid #d3d2d1; padding-bottom:35px;">
					<tbody>
						<tr>
							<td >
								<table class="table01 list_tb">
									<colgroup>
										<col style="width:5%;" />
										<col style="width:5%;" />
										<col style="width:5%;" />
										<col style="width:5%;" />
										<col style="width:5%;" />
										<col style="width:5%;" />
										<col style="width:5%;" />
										<col style="width:5%;" />
									</colgroup>
									<tr>
										<th>XS</th>
										<th>S</th>
										<th>M</th>
										<th>L</th>
										<th>XL</th>
										<th>2XL</th>
										<th>3XL</th>
										<th></th>
									</tr>
									<tr style="text-align:center;">
										<td><input type="text" name="txsCnt" id="txsCnt" value="${mrtnTshirts.txsCnt}" maxlength="4"/></td>
										<td><input type="text" name="tsCnt" id="tsCnt" value="${mrtnTshirts.tsCnt}" maxlength="4"/></td>
										<td><input type="text" name="tmCnt" id="tmCnt" value="${mrtnTshirts.tmCnt}" maxlength="4"/></td>
										<td><input type="text" name="tlCnt" id="tlCnt" value="${mrtnTshirts.tlCnt}" maxlength="4"/></td>
										<td><input type="text" name="txlCnt" id="txlCnt" value="${mrtnTshirts.txlCnt}" maxlength="4"/></td>
										<td><input type="text" name="t2xlCnt" id="t2xlCnt" value="${mrtnTshirts.t2xlCnt}" maxlength="4"/></td>
										<td><input type="text" name="t3xlCnt" id="t3xlCnt" value="${mrtnTshirts.t3xlCnt}" maxlength="4"/></td>
										<td><input type="image" src="/images/oss/btn/modify_btn03.gif" alt="수정" onclick="fn_mrtnTshirtsUpdate();" /></td>
									</tr>
								</table>
							</td>
						</tr>
					</tbody>
				</table>
			</c:if>
			
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tbody>
					<tr>
						<td valign="top"><h2 class="title02">검색결과(${resultCnt}명)</h2></td>
					</tr>
					<tr>
						<td valign="top" width="43%" style="background-color:#f9f9f9; border:solid 1px #ccc; text-align:center;">
							<div style="height:360px; overflow:auto;">
								<table class="table01 list_tb">
									<colgroup>
										<col style="width:5%;" />
										<col style="width:5%;" />
										<col style="width:5%;" />
										<col style="width:10%;" />
										<col style="width:4%;" />
										<col style="width:5%;" />
										<col style="width:5%;" />
										<col style="width:7%;" />
										<col style="width:21%;" />
										<col style="width:10%;" />
										<col style="width:5%;" />
										<col style="width:4%;" />
										<col style="width:6%;" />
									</colgroup>
									<tr>
										<th>신청자명</th>
										<th>생년월일</th>
										<th>주민등록번호 뒷7자리</th>
										<th>전화번호</th>
										<th>나이대</th>
										<th>성별</th>
										<th>혈액형</th>
										<th>거주지역</th>
										<th>전체주소</th>
										<th>이메일</th>
										<th>코스</th>
										<th>티셔츠</th>
										<th>예약상세/수정</th>
									</tr>
									<!-- 데이터 없음 -->
									<c:if test="${fn:length(resultList) == 0}">
										<tr>
											<td colspan="13"><spring:message code="common.nodata.msg" /></td>
										</tr>
									</c:if>

									<c:forEach var="data" items="${resultList}" varStatus="status">
										<tr>
											<input type="hidden" name="mrtnNum" id="mrtnNum_${status.index}" value="${data.mrtnNum}">
											<td>
												<input type="text" name="apctNm" id="apctNm_${status.index}" value="${data.apctNm}" maxlength="13">
											</td>
											<td><c:out value="${data.birth}" /></td>
											<td><c:out value="${data.lrrn}" /></td>
											<td>
												<input type="text" name="apctTelnum" id="apctTelnum_${status.index}" value="${data.apctTelnum}" autocomplete="new-password" onKeyup="addHyphenToPhone(this);" onkeydown="javascript:fn_checkNumber();" maxlength="13" >
											</td>
											<td>
												<select name="ageRange" id="ageRange_${status.index}">
													<option value="10D" <c:if test="${data.ageRange eq '10D'}">selected="selected"</c:if>>10대미만</option>
													<option value="10R" <c:if test="${data.ageRange eq '10R'}">selected="selected"</c:if>>10대</option>
													<option value="20R" <c:if test="${data.ageRange eq '20R'}">selected="selected"</c:if>>20대</option>
													<option value="30R" <c:if test="${data.ageRange eq '30R'}">selected="selected"</c:if>>30대</option>
													<option value="40R" <c:if test="${data.ageRange eq '40R'}">selected="selected"</c:if>>40대</option>
													<option value="50R" <c:if test="${data.ageRange eq '50R'}">selected="selected"</c:if>>50대</option>
													<option value="60R" <c:if test="${data.ageRange eq '60R'}">selected="selected"</c:if>>60대</option>
													<option value="70U" <c:if test="${data.ageRange eq '70U'}">selected="selected"</c:if>>70대이상</option>
												</select>	
											</td>
											<td>
												<select name="gender" id="gender_${status.index}">
													<option value="M" <c:if test="${data.gender eq 'M'}">selected="selected"</c:if>>남성</option>
													<option value="F" <c:if test="${data.gender eq 'F'}">selected="selected"</c:if>>여성</option>
												</select>	
											</td>
											<td>
												<select name="bloodType" id="bloodType_${status.index}">
													<option value="AP" <c:if test="${data.bloodType eq 'AP'}">selected="selected"</c:if>>A+</option>
													<option value="BP" <c:if test="${data.bloodType eq 'BP'}">selected="selected"</c:if>>B+</option>
													<option value="OP" <c:if test="${data.bloodType eq 'OP'}">selected="selected"</c:if>>O+</option>
													<option value="ABP" <c:if test="${data.bloodType eq 'ABP'}">selected="selected"</c:if>>AB+</option>
													<option value="AM" <c:if test="${data.bloodType eq 'AM'}">selected="selected"</c:if>>A-</option>
													<option value="BM" <c:if test="${data.bloodType eq 'BM'}">selected="selected"</c:if>>B-</option>
													<option value="OM" <c:if test="${data.bloodType eq 'OM'}">selected="selected"</c:if>>O-</option>
													<option value="ABM" <c:if test="${data.bloodType eq 'ABM'}">selected="selected"</c:if>>AB-</option>
												</select>
											</td>
											<td>
												<c:choose>
													<c:when test="${data.region eq 'GW'}">강원도</c:when>
													<c:when test="${data.region eq 'GG'}">경기도</c:when>
													<c:when test="${data.region eq 'GN'}">경상남도</c:when>
													<c:when test="${data.region eq 'GB'}">경상북도</c:when>
													<c:when test="${data.region eq 'GJ'}">광주광역시</c:when>
													<c:when test="${data.region eq 'DG'}">대구광역시</c:when>
													<c:when test="${data.region eq 'DJ'}">대전광역시</c:when>
													<c:when test="${data.region eq 'BS'}">부산광역시</c:when>
													<c:when test="${data.region eq 'SU'}">서울특별시</c:when>
													<c:when test="${data.region eq 'SJ'}">세종특별자치시</c:when>
													<c:when test="${data.region eq 'US'}">울산광역시</c:when>
													<c:when test="${data.region eq 'IC'}">인천광역시</c:when>
													<c:when test="${data.region eq 'JN'}">전라남도</c:when>
													<c:when test="${data.region eq 'JB'}">전라북도</c:when>
													<c:when test="${data.region eq 'JJ'}">제주특별자치도</c:when>
													<c:when test="${data.region eq 'CN'}">충청남도</c:when>
													<c:when test="${data.region eq 'CB'}">충청북도</c:when>
												</c:choose>
											</td>
											<td><c:out value="${data.fullAddr}" /></td>
											<td>
												<input type="text" name="apctEmail" id="apctEmail_${status.index}" value="${data.apctEmail}" maxlength="24">
											</td>
											<td>
												<c:choose>
													<c:when test="${data.course eq 'F'}">풀코스</c:when>
													<c:when test="${data.course eq 'H'}">하프코스</c:when>
													<c:when test="${data.course eq 'T'}">10km</c:when>
													<c:when test="${data.course eq 'W'}">5km</c:when>
												</c:choose>
											</td>
											<td><c:out value="${data.tshirts}" /></td>
											<td>
												<input type="image" src="/images/oss/btn/open_btn01.gif" alt="예약관리상세" onclick="fn_detailRsv('${data.rsvNum}', '${data.spRsvNum}');" />
												<input type="image" src="/images/oss/btn/modify_btn03.gif" alt="수정" onclick="fn_mrtnUserUpdate('${status.index}');" />
											</td>
										</tr>
									</c:forEach>
								</table>
							</div>
						</td>
					</tr>
				</tbody>
			</table>

		</div>
	</div>
</div>
<iframe name="frmFileDown" style="display:none"></iframe>
</body>
</html>