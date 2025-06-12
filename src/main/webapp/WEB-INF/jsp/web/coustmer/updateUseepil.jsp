<!DOCTYPE html>
<html lang="ko">
<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
           
 <un:useConstants var="Constant" className="common.Constant" />
<head>

<jsp:include page="/web/includeJs.do" flush="false"></jsp:include>
 


<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/sub.css'/>" />
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" /> --%>


<script type="text/javascript">


function fn_useepilChageLike(nGpa){
	var i=0;
	for(i=1; i<=5 ;i++){
		if(i <= nGpa){
			$("#ue_like"+i).attr("src", "<c:url value='/images/web/icon/star_on.png'/>" );
		}else{
			//console.log("#ue_like"+i +"<="+ nGpa + ":x");
			$("#ue_like"+i).attr("src", "<c:url value='/images/web/icon/star_off.png'/>" );
		}
	}
	$("#gpa").val(nGpa);
}


function fn_Mod(){
	//입력 검사
	if(document.frm.gpa.value==0){
		alert("평점을 선택 하세요.");
		return;
	}

    if(document.frm.reviewType.value.length==0){
        alert("유형을 선택 하세요.");
        document.frm.reviewType.focus();
        return;
    }


    if(document.frm.subject.value.length==0){
		alert("제목을 입력 하세요.");
		document.frm.subject.focus();
		return;
	}
	
	if(document.frm.subject.value.length >= 255){
		alert("제목의 길이는 255자 이하 입니다.");
		document.frm.subject.focus();
		return;
	}
	
	//if($("#contents").val().length == 0){
	if(document.frm.contents.value.length==0){
		alert("이용 후기를 입력 하세요.");
		document.frm.contents.focus();
		return;
	}
	//if($("#contents").val().length >= 500){
	if(document.frm.contents.value.length >= 500){
		alert("이용 후기의 길이는 500자 이하 입니다.");
		document.frm.contents.focus();
		return;
	}
	
	document.frm.action = "<c:url value='/web/coustmer/udateUseepil.do'/>";
	document.frm.submit();
		
}
	
function fn_useepilImgDelete(pos, useEpilNum, imgNum) {
	if (confirm('첨부 이미지를 삭제하겠습니까?')) {
		$.ajax({
			type:"post", 
			url:"<c:url value='/web/cmm/useepilImgDelete.ajax'/>",
			data:"useEpilNum=" + useEpilNum + "&imgNum=" + imgNum ,
			success:function(data){
				if (data.Status == 'success') {
					alert('파일을 삭제 했습니다.');
					$('#imgTool_' + pos).html('<input type="file" name="img' + (pos+1) + '" accept="image/*">');
				}
			},
			error : fn_AjaxError
		});
	}
}


$(document).ready(function(){
	fn_useepilChageLike(${useepil.gpa});
});

</script>

</head>
<body>
<header id="header">
	<jsp:include page="/web/head.do" flush="false"></jsp:include>
</header>
<main id="main">
        <div class="mapLocation"> <!--index page에서는 삭제-->
            <div class="inner">
                <span>홈</span> <span class="gt">&gt;</span>
                <span>고객센터</span> <span class="gt">&gt;</span>
                <span>이용후기</span>
            </div>
        </div>
        <!-- quick banner -->
   		<jsp:include page="/web/left.do" flush="false"></jsp:include>
        <!-- //quick banner -->
        <div class="subContainer">
            <div class="subHead"></div>
            <div class="subContents">
                <!-- new contents -->
                <div class="service-center sideON">
                    <div class="bgWrap2">
                        <div class="inner">

                                <div class="tbWrap">
                                    <jsp:include page="/web/coustmer/left.do?menu=otoinq" flush="false"></jsp:include>

                                    <div class="rContents smON">
                                        <h3 class="mainTitle">이용후기</h3>

                                        <!--<form:form commandName="frm" name="frm" method="post" enctype="multipart/form-data" onSubmit="return false;">-->
                                        <form name="frm" method="post" onSubmit="return false;" enctype="multipart/form-data">
                                        <input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
                                        <input type="hidden" id="useEpilNum" name="useEpilNum" value="${useepil.useEpilNum}"/>
                                        <input type="hidden" id="corpId" name="corpId" value="${useepil.corpId}"/>
                                        <input type="hidden" id="prdtnum" name="prdtnum" value="${useepil.prdtnum}"/>

                                        <div class="commBoard-wrap">
                                            <p class="cmTitle">주제에 맞지않거나 음란/홍보/비방 등의 글은 사전 동의없이 삭제 가능합니다.</p>
                                            <div class="board-write">
                                                <table class="commRow">
                                                    <tbody>
                                                        <tr>
                                                            <th>상품</th>
                                                            <td class="category">
                                                                <ul class="ctOption">
                                                                    <!--불필요한 카테고리는 삭제-->
                                                                    <li>
                                                                        <c:out value="${useepil.subjectHeder}"/>
                                                                        <%--
                                                                        <!-- 나중에 DB에서 읽어오게 수정 -->
                                                                        <select id="prdtInf" name="prdtInf">
                                                                            <option value="">-선택하세요-</option>
                                                                            <option value="C000000025,AD00000050" <c:if test="${USEEPILVO.corpId=='C000000025' &&  USEEPILVO.prdtnum=='AD00000050'}">selected="selected"</c:if> >휴양팬션</option>
                                                                            <option value="C000000043,SP00000049" <c:if test="${USEEPILVO.corpId=='C000000043' &&  USEEPILVO.prdtnum=='SP00000049'}">selected="selected"</c:if> >감귤체험</option>
                                                                            <option value="C000000037,GL00000014" <c:if test="${USEEPILVO.corpId=='C000000037' &&  USEEPILVO.prdtnum=='GL00000014'}">selected="selected"</c:if> >라헨느C.C</option>
                                                                            <option value="C000000027,RC00000015" <c:if test="${USEEPILVO.corpId=='C000000027' &&  USEEPILVO.prdtnum=='RC00000015'}">selected="selected"</c:if> >서귀포렌트카-뉴아반떼MD</option>
                                                                        </select>
                                                                         --%>
                                                                    </li>
                                                                </ul>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>좋아요</th>
                                                            <td>
                                                                <div class="like">
                                                                    <a href="javascript:fn_useepilChageLike(1)"><img id="ue_like1" src="<c:url value='/images/web/icon/star_off.png'/>" alt="좋아요"></a>
                                                                    <a href="javascript:fn_useepilChageLike(2)"><img id="ue_like2" src="<c:url value='/images/web/icon/star_off.png'/>" alt="좋아요"></a>
                                                                    <a href="javascript:fn_useepilChageLike(3)"><img id="ue_like3" src="<c:url value='/images/web/icon/star_off.png'/>" alt="좋아요"></a>
                                                                    <a href="javascript:fn_useepilChageLike(4)"><img id="ue_like4" src="<c:url value='/images/web/icon/star_off.png'/>" alt="좋아요"></a>
                                                                    <a href="javascript:fn_useepilChageLike(5)"><img id="ue_like5" src="<c:url value='/images/web/icon/star_off.png'/>" alt="좋아요"></a>
                                                                    <input type="hidden" name="gpa" id="gpa" value="0" />
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>유형</th>
                                                            <td class="category">
                                                                <ul class="ctOption">
                                                                    <li>
                                                                        <select id="reviewType" name="reviewType">
                                                                            <option value="">-선택하세요-</option>
                                                                            <c:forEach items="${cdRvtp}" var="rvtp" varStatus="status">
                                                                                <option value="${rvtp.cdNum}"  <c:if test="${rvtp.cdNum eq useepil.reviewType}">selected="selected"</c:if>>${rvtp.cdNm }</option>
                                                                            </c:forEach>
                                                                        </select>
                                                                    </li>
                                                                </ul>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>제목</th>
                                                            <td class="title">
                                                                <input type="text" id="subject" name="subject" placeholder="최대 50자 까지 자유롭게 입력가능하십니다." maxlength="50" value="${useepil.subject}">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>내용</th>
                                                            <td class="memo">
                                                                <textarea placeholder="한글 500자까지 자유롭게 입력가능하십니다." id="contents" name="contents" maxlength="500">${useepil.contents}</textarea>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>이미지</th>
                                                            <td class="attachments">
                                                                <c:forEach items="${imgList }" var="img" varStatus="stat">
                                                                <p class="file" id="imgTool_${stat.index }">${img.realFileNm } <a href="javascript:fn_useepilImgDelete('${stat.index }', '${img.useEpilNum}', '${img.imgNum}')">[삭제]</a></p>
                                                                </c:forEach>
                                                                <c:forEach var="i" begin="${fn:length(imgList)+1 }" end="5">
                                                                <p class="file"><input type="file" name="img${i}" accept="image/*"></p>
                                                                </c:forEach>
                                                                <p class="label">* 이미지는 5개까지 첨부 가능 합니다.</p>
                                                            </td>
                                                        </tr>
                                                        <%--
                                                        <tr>
                                                            <th>답변수단선택</th>
                                                            <td>
                                                                <input id="re_email" type="radio" name="answer"><label for="re_email">E-mail로 답변받기</label>
                                                                <input id="re_sms" type="radio" name="answer"><label for="re_sms">E-mail+SMS 알림수신 받기</label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>답변 받으실 E-mail</th>
                                                            <td class="email">
                                                                <input id="member_email" type="text">
                                                                <span>@</span>
                                                                <select id="mail_option">
                                                                    <option value="">선택하세요</option>
                                                                    <option value="">네이트</option>
                                                                </select>
                                                                <!--직접입력시-->
                                                                <!--<input id="member_email_last" class="mgL commWidth" type="text">-->
                                                                <input id="directly" class="mgL" type="checkbox"><label for="directly">직접입력</label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>연락 받으실 휴대폰</th>
                                                            <td class="phone-number">
                                                                <select id="phone" class="phone">
                                                                    <option value="">010</option>
                                                                </select>
                                                                <input class="phone" type="text">
                                                                <input class="phone" type="text">
                                                            </td>
                                                        </tr>
                                                         --%>
                                                    </tbody>
                                                </table>
                                                <div class="comm-button2">
                                                    <a class="color1" href="javascript:fn_Mod()">수정</a>
                                                    <a class="color0" href="javascript:history.back();">취소</a>
                                                </div>
                                                <%--
                                                <div class="boardBT2">
                                                    <input type="image" src="<c:url value='/images/web/board/enrollment.gif'/>" alt="등록" onclick="fn_Ins()">
                                                    <a href="javascript:history.back();"><img src="<c:url value='/images/web/board/cancel.gif'/>" alt="취소"></a>
                                                </div>
                                                 --%>
                                            </div> <!--//board-write-->
                                        </div> <!--//commBoard-wrap-->
                                        </form:form>

                                    </div> <!--//rContents-->






                                </div> <!--//tbWrap-->
                        </div>
                    </div> <!--//bgWrap2-->
                </div> <!-- //mypage2_2 -->
                <!-- //new contents -->
            </div> <!-- //subContents -->
        </div> <!-- //subContainer -->
	</main>
	
<jsp:include page="/web/right.do" flush="false"></jsp:include>
<jsp:include page="/web/foot.do" flush="false"></jsp:include>
</body>
</html>