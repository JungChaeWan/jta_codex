
<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 			uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />

<script type="text/javascript">

function fn_List(){	
	//document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/mas/${corpCd}/useepilList.do'/>";
	document.frm.submit();
}

function fn_useepilCmtAction(gubun){	

	if($("#cmtContents").val().length == 0){
		alert("댓글을 입력 하세요.");
		$("#cmtContents").focus();
		return;
	}
	if($("#cmtContents").val().length >= 800){
		alert("댓글의 길이는 800자 이하 입니다.");
		$("#cmtContents").focus();
		return;
	}
	
	var parameters = $("#useepilFrm").serialize();
	
	$.ajax({
		type:"post", 
		// dataType:"json",
		// async:false,
		url:'<c:url value="/mas/useepil/useepilCmt' + gubun + '.ajax" />',
		data:parameters ,
		success:function(data){
			//$("#tabs-5").html(data);
			if(data["Status"] == "success"){
				var actionStr = gubun == 'Insert' ? "등록" : "수정";
				alert("댓글이 " + actionStr + "되었습니다.");
				document.frm.action = "<c:url value='/mas/${corpCd}/detailUseepil.do'/>";
				document.frm.submit();
				//fn_useepilList1();
			}else{
				alert("Error");
			}
		},
		error:function(request,status,error){
	        alert("code:"+request.status+"\n"+"\n"+"error:"+error);
	        //alert("code:"+request.status+"\n"+"\n"+"error:"+error);
 	   }
	});
	
}

// 댓글 수정 폼
function fn_useepilCmtInfo(cmtSn){
	$('#cmtSn').val(cmtSn);
	$('#cmtContents').val($('#cmt_' + cmtSn).text());
	$("#btnCancel").show();
	$('#btnAction').html("<a href=\"javascript:fn_useepilCmtAction('Update')\">댓글수정</a>");
	
}

// 댓글 수정 취소
function fn_useepilCmtCancel() {
	$('#cmtSn').val('');
	$('#cmtContents').val('');
	$('#btnCancel').hide();
	$('#btnAction').html("<a href=\"javascript:fn_useepilCmtAction('Insert')\">댓글추가</a>");
}

// 댓글 삭제
function fn_useepilCmtDelete(cmtSn){	

	if(window.confirm("댓글을 삭제하겠습니까?")) {		
		document.frm.cmtSn.value = cmtSn;
		
		var parameters = $("#useepilFrm").serialize();
		
		$.ajax({
			type:"post", 
			// dataType:"json",
			// async:false,
			url:'<c:url value="/mas/useepil/useepilCmtDelete.ajax" />',
			data:parameters,
			success:function(data){
				//$("#tabs-5").html(data);
				if(data["Status"] == "success"){
					alert("댓글이 삭제되었습니다.");
					document.frm.action = "<c:url value='/mas/${corpCd}/detailUseepil.do'/>";
					document.frm.submit("");
					//fn_useepilList1();
				}else{
					alert("Error");
				}
			},
			error:function(request,status,error){
		        alert("code:"+request.status+"\n"+"\n"+"error:"+error);
		        //alert("code:"+request.status+"\n"+"\n"+"error:"+error);
	 	   }
		});
	}
}
</script>

			<form name="frm" id="useepilFrm" method="post" onSubmit="return false;">
			<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
			<input type="hidden" name="corpId" id="corpId" value="${USEEPILVO.corpId}" />
			<input type="hidden" id="useEpilNum" name="useEpilNum" value='<c:out value="${data.useEpilNum}" />' />
			<input type="hidden" name="corpCd" id="corpCd" value="${searchVO.corpCd}" />
			<input type="hidden" name="gpa" id="gpa" value="0" />
			<input type="hidden" id="printYn" name="printYn" value="0"/>
			<input type="hidden" id="cmtSn" name="cmtSn" value=""/>				
				
					<h4 class="title03">상품평 상세</h4>
					<table border="1" class="table02">
						<colgroup>
	                        <col width="200" />
	                        <col width="*" />
	                        <col width="200" />
	                        <col width="*" />
	                    </colgroup>
						<tr>
							<th scope="row">No.</th>
							<td colspan="3"><c:out value="${data.useEpilNum}" /></td>
						</tr>
						<c:if test="${!(corpCdUp == Constant.ACCOMMODATION || corpCdUp == Constant.GOLF) }">
							<tr>
								<th>상품</th>
								<td colspan="3"><c:out value='${data.prdtNm}'/>(<c:out value="${data.prdtnum}" />)</td>
							</tr>
						</c:if>
						<tr>
							<th>사용자아이디</th>
							<td><c:out value="${data.userId}" /></td>
							<th>E-Mail</th>
							<td><c:out value="${data.email}" /></td>
						</tr>
						<tr>
							<th>이름</th>
							<td><c:out value="${userVO.userNm}" /></td>
							<th>전화번호</th>
							<td><c:out value="${userVO.telNum}" /></td>
						</tr>
						<tr>
							<th>평점</th>
							<td><c:out value="${data.gpa}" /></td>
							<th>댓글 수</th>
							<td ><c:out value="${data.cmtCnt}" /></td>
						</tr>
						<tr>
							<th>시간</th>
							<td ><c:out value="${data.lastModDttm}" /></td>
							<th>표시여부</th>
							<td>
								<c:if test="${data.printYn=='Y'}">표시</c:if>
								<c:if test="${data.printYn=='N'}"><font color="#980000">차단</font></c:if>
							</td>
						</tr>
						<tr>
							<th >제목</th>
							<td colspan="3">
								<c:out value="${data.subject}"/>
							</td>
						</tr>
								
						
						<tr>
							<th>내용</th>
							<td colspan="3">
								<c:out value="${data.contents}" escapeXml="false"/>
							</td>
						</tr>
						
					</table>
					<br/>
					<h4 class="title03">댓글</h4>
					<table border="1" class="table02">
						<colgroup>
	                        <col width="200" />
	                        <col width="*" />
	                        <col width="200" />
	                        <col width="*" />
	                    </colgroup>
		                <c:if test="${fn:length(cmtlist) == 0}">
							<tr>
								<td colspan="10" class="align_ct">
									댓글이 없습니다.
								</td>
							</tr>
						</c:if>
						<c:forEach var="cmt" items="${cmtlist}" varStatus="status">
							<tr>
								<td colspan="4">
									<!-- No.${cmt.cmtSn} -->
									[ID: <c:out value="${cmt.userId}"/> ]
									[E-Mail: <c:out value="${cmt.email}"/> ]
									[시간: <c:out value="${cmt.lastModDttm}"/> ]
									[표시여부: 
										<c:if test="${cmt.printYn=='Y'}">표시</c:if>
										<c:if test="${cmt.printYn=='N'}"><font color="#980000">차단</font></c:if>
									]
									<c:if test="${cmt.userId eq userId }">
									<li class="btn_sty04">
										<a href="javascript:fn_useepilCmtInfo('${cmt.cmtSn}')">수정</a>
									</li>
									<li class="btn_sty03">
										<a href="javascript:fn_useepilCmtDelete('${cmt.cmtSn}')">삭제</a>
									</li>
									</c:if>
									<br/>
									<span id="cmt_${cmt.cmtSn}"><c:out value="${cmt.contents}" escapeXml="false"/></span>
								</td>
							</tr>
						</c:forEach>
							<tr>
								<td colspan="4"><textarea rows="14" name="contents" id="cmtContents"></textarea>
								</td>
							</tr>
					</table>					
					
					<ul class="btn_rt01">
						<li class="btn_sty02" id="btnAction">
							<a href="javascript:fn_useepilCmtAction('Insert')">댓글추가</a>
						</li>
						
						<li class="btn_sty02" id="btnCancel" style="display: none;">
							<a href="javascript:fn_useepilCmtCancel()">수정취소</a>
						</li>
						
						<li class="btn_sty01">
							<a href="javascript:fn_List()">목록</a>
						</li>
					</ul>
						
			</form>
