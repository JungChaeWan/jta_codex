<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />

<span class="popup_close"><a href="javascript:void(0);" onclick="close_popup($('#selfPublishingPop'));" title="창닫기"><img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a></span>
<ul class="form_area">
    <li>
        <form name="frmPop" id="frmPop" method="post">
            <input type="hidden" name="partnerCode" value="${partnerCode}" >
            <h5 class="title06">${partnerCode} 자체 쿠폰 발급</h5>
            <table border="1" cellpadding="0" cellspacing="0" class="table02" id="pointList">
                <colgroup>
                    <col width="100" />
                    <col width="100" />
                    <col width="100" />
                </colgroup>
                <tr>
                    <th>포인트</th>
                    <th>수량</th>
                    <th>추가/삭제</th>
                </tr>
                <tr >
                    <td><input type="text" name="cpPointList"></td>
                    <td><input type="text" name="cpCntList"></td>
                    <td> <span class="btn_sty04"><a href="#" id ="btnAdd">추가</a></span></td>
                </tr>

            </table>
        </form>
    </li>
</ul>


<div class="btn_ct01"><span class="btn_sty03"><a href="javascript:fn_CouponRandomCreate();">적용</a></span></div>
<script type="text/javascript">
    $(document).ready (function () {
        $('#btnAdd').click (function () {
            $('#pointList').append (
                '<tr>' +
                    '<td><input type="text" name="cpPointList"></td>' +
                    '<td><input type="text" name="cpCntList"></td>' +
                    '<td> <span class="btn_sty02"><a href="#" class ="btnRemove">삭제</a></span></td></td>' +
                '</tr>'
            ); // end append

            $('.btnRemove').on('click', function () {
                $(this).closest("tr").remove ();
            });
        });
    });

    function fn_CouponRandomCreate(){

        let pointValidate = true;
        let cntValidate = true;
        $("input[name=cpPointList]").each(function(idx, item){
            if (item.value == ''){
                pointValidate = false;
            }
        });

        if (!pointValidate){
            alert('포인트를 모두 입력 해 주세요.');
            return;
        }


        $("input[name=cpCntList]").each(function(idx, item){
            if (item.value == ''){
                cntValidate = false;

            }
        });

        if (!cntValidate){
            alert('수량을 모두 입력 해 주세요.');
            return;
        }



        //포인트, 수량 number 체크
        $.ajax({
            type:"post",
            url:"/oss/point/couponRandomCreate.ajax",
            data: $("#frmPop").serialize(),
            dataType: "json",
            success:function(data){
                alert("정상적으로 등록 되었습니다.");
                location.reload();
            },
            error : fn_AjaxError
        });
    }

</script>