<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
<un:useConstants var="Constant" className="common.Constant" />
<span class="popup_close"><a href="javascript:void(0);" onclick="close_popup($('#userPointCreatePop'));" title="창닫기"><img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a></span>
<ul class="form_area">
    <li>
        <form name="frmPop" id="frmPop" method="post">
            <h5 class="title06"> ${pointCpDetail.partnerNm} 포인트 발급/사용처리</h5>
            <table border="1" cellpadding="0" cellspacing="0" class="table02" id="pointList">
                <colgroup>
                    <col width="150" />
                    <col width="*" />
                </colgroup>
                <tr >
                    <th>유형</th>
                    <td>
                        <input id="ipm1" type="radio" name="plusMinus" value="P" checked="checked"><label for="ipm1">포인트 발급</label>
                        <input id="ipm2" type="radio" name="plusMinus" value="M" ><label for="ipm2">포인트 사용처리</label>
                    </td>
                </tr>
                <tr >
                    <th>*포인트</th>
                    <td><input type="text" name="point" id="point" onkeydown="javascript:fn_checkNumber();" placeholder="포인트를 입력해주세요"></td>
                </tr>
                <tr >
                    <th>발급/사용처리 이유</th>
                    <td>
                        <textarea name="contents" cols="70" rows="3" placeholder="1000자 이내로 작성 해 주세요."></textarea>
                    </td>
                </tr>
            </table>
            <input type="hidden" name="types" value="ADMIN_REG">
            <input type="hidden" name="partnerCode" value="${pointCpDetail.partnerCode}">
            <input type="hidden" name="userId" value="${userId}">
        </form>
    </li>
</ul>
<div class="btn_ct01"><span class="btn_sty04"><a href="javascript:fn_InsertUserPoint();">저장</a></span></div>
<script type="text/javascript">
    function fn_InsertUserPoint() {
        $.ajax({
            type    : "post",
            url     : "/oss/point/insertUserPoint.ajax",
            data    : $("#frmPop").serialize(),
            dataType: "json",
            success : function (data) {
                if (data.success == "Y") {
                    close_popup($('#userPointCreatePop'));
                    alert('포인트 발급 또는 사용처리를 완료하였습니다.');
                    location.reload();
                    return;
                } else if(data.success == "X"){
                    alert('회수 포인트가 사용가능한 포인트 보다 많아 포인트 사용처리에 실패 하였습니다.');
                    return;
                } else {
                    alert('포인트 발급 또는 사용처리를 실패 하였습니다.');
                    return;
                }
            },
            error   : fn_AjaxError
        });
    }
</script>