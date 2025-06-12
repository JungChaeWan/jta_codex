<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
<un:useConstants var="Constant" className="common.Constant" />
<span class="popup_close"><a href="javascript:void(0);" onclick="close_popup($('#corpPartnerRegAllPop'));" title="창닫기"><img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a></span>
<ul class="form_area">
    <li>
        <form name="frmPop" id="frmPop" method="post">
            <h5 class="title06">판매업체 등록/해제 일괄 처리</h5>
            <table border="1" cellpadding="0" cellspacing="0" class="table02" id="pointList">
                <colgroup>
                    <col width="150" />
                    <col width="*" />
                </colgroup>
                <tr>
                    <th>카테고리</th>
                    <td>
                    <select name="corpCd">
                        <option value="">--선택--</option>
                        <option value="RC">렌터카</option>
                        <option value="AD">숙소</option>
                        <option value="SP">관광지/레저, 맛집, 여행사상품</option>
                        <option value="SV">특산/기념품</option>
                    </select>
                    </td>
                </tr>

            </table>
        </form>
    </li>
</ul>

<div class="btn_ct01">
    <span class="btn_sty04"><a href="javascript:fn_CorpRegAll('Y')">일괄 등록</a></span>
    <span class="btn_sty04"><a href="javascript:fn_CorpRegAll('N')">일괄 해제</a></span>
</div>
<script type="text/javascript">
    function fn_CorpRegAll(xRegYn){
        const parameters = $("#frmPop").serialize() + "&regYn="+xRegYn;
        $.ajax({
            type:"post",
            dataType: "json",
            url:"<c:url value='/oss/corpPartnerRegAll.ajax'/>",
            data:parameters,
            success:function(data){
                if(data.success == "Y"){
                    alert("상태 변경 완료 하였습니다.");
                    return;
                }else{
                    alert("오류가 발생 하였습니다." + data.success );
                    return;
                }
            }
        });
    }
</script>