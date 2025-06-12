<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
<un:useConstants var="Constant" className="common.Constant" />
<span class="popup_close"><a href="javascript:void(0);" onclick="close_popup($('#createCouponPop'));" title="창닫기"><img src="<c:url value='/images/oss/btn/close_btn03.gif'/>" alt="" /></a></span>
<ul class="form_area">
    <li>
        <form name="frmPop" id="frmPop" method="post" enctype="multipart/form-data">
            <input type="hidden" name="editType" id="editType" />
            <h5 class="title06">쿠폰 생성</h5>
            <table border="1" cellpadding="0" cellspacing="0" class="table02" id="pointList">
                <colgroup>
                    <col width="150" />
                    <col width="*" />
                </colgroup>
                <tr>
                    <th>포인트 성격</th>
                    <td>
                        <input type="checkbox" disabled>자동적립쿠폰
                        <input type="checkbox" checked="checked" value="Y" disabled>전용포인트
                        <input type="hidden" name="directPointYn"  value="N">
                        <input type="hidden" name="privateYn" value="Y">
                    </td>
                </tr>
                <tr >
                    <th>정산타입</th>
                    <td>
                        <input id="ossd1" type="radio" name="outsideSupportDiv" value="Y" <c:if test="${pointCpDetail.outsideSupportDiv eq 'Y'  || pointCpLint.outsideSupportDiv eq null}"> checked="checked" </c:if>><label for="ossd1">외부정산</label>
                        <input id="ossd2" type="radio" name="outsideSupportDiv" value="N" <c:if test="${pointCpDetail.outsideSupportDiv eq 'N'}"> checked="checked"</c:if>><label for="ossd2">내부정산</label>
                    </td>
                </tr>
                <tr >
                    <th>*파트너 코드</th>
                    <td>
                        <c:if test="${pointCpDetail.partnerCode eq null}">
                            <input type="text" name="partnerCode" id="popPartnerCode" value="" onkeyup="chkCharCode(event)"><div class="btn_sty07"><span><a href="javascript:fn_DuplicationChk()">중복체크</a></span></div> <span style="color:red">* 영문, 숫자 입력 가능</span>
                        </c:if>
                        <c:if test="${pointCpDetail.partnerCode ne null}">
                            <input type="text" name="partnerCode" id="popPartnerCode" value="${pointCpDetail.partnerCode}" readonly="readonly">
                        </c:if>
                    </td>
                </tr>
                <tr >
                    <th>*파트너사 명칭</th>
                    <td><input type="text" name="partnerNm" id="partnerNm" value="${pointCpDetail.partnerNm}"></td>
                </tr>
                <tr >
                    <th>*쿠폰명</th>
                    <td><input type="text" name="cpNm" id="cpNm" class="input_text_full" value="${pointCpDetail.cpNm}"></td>
                </tr>
                <tr >
                    <th>*쿠폰사용기간</th>
                    <td><input type="text" name="aplStartDt" id="aplStartDt" class="input_text5" value="${pointCpDetail.aplStartDt}"> ~ <input type="text" name="aplEndDt" id="aplEndDt" class="input_text5" value="${pointCpDetail.aplEndDt}"></td>
                </tr>
                <tr>
                    <th rowspan="2">구매하기 제한</th>
                    <td>
                        예약가능일 <input type="text" name="useStartDt" id="useStartDt" class="input_text5" value="${pointCpDetail.useStartDt}"> ~ <input type="text" name="useEndDt" id="useEndDt" class="input_text5" value="${pointCpDetail.useEndDt}">
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="checkbox" id="chkCorpFilterYn" <c:if test="${pointCpDetail.corpFilterYn eq 'Y'}">checked="checked"</c:if>> <label for="chkCorpFilterYn"> 업체 제한</label>
                        <input type="checkbox" id="chkCorpPointLimitYn" <c:if test="${pointCpDetail.corpPointLimitYn eq 'Y'}">checked="checked"</c:if>><label for="chkCorpPointLimitYn"> 업체별 포인트사용한도설정</label>
                        <input type="hidden" name="corpFilterYn" id="corpFilterYn"  value="${pointCpDetail.corpFilterYn}">
                        <input type="hidden" name="corpPointLimitYn" id="corpPointLimitYn" value="${pointCpDetail.corpPointLimitYn}">
                    </td>
                </tr>
                <tr >
                    <th>예산액</th>
                    <td><input type="input" name="partnerBudget" id="partnerBudget" value="${pointCpDetail.partnerBudget}" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"></td>
                </tr>
                <tr >
                    <th>설명</th>
                    <td>
                        <textarea name="cpComments" cols="70" rows="3" >${pointCpDetail.cpComments}</textarea>
                    </td>
                </tr>
                <tr >
                    <th>이벤트쿠폰<br/>사용여부</th>
                    <td>
                        <input id="eventCoupon1" type="radio" name="eventCouponYn" value="Y" <c:if test="${pointCpDetail.eventCouponYn eq 'Y'}"> checked="checked"</c:if>><label for="eventCoupon1"> Y </label>
                        <input id="eventCoupon2" type="radio" name="eventCouponYn" value="N" <c:if test="${pointCpDetail.eventCouponYn eq 'N' || pointCpDetail.eventCouponYn eq null}"> checked="checked"</c:if>><label for="eventCoupon2"> N </label>
                    </td>
                </tr>
                <c:set var="acceptExt" value=".png,.jpg,.jpeg,.gif,.webp,.tif" />
                <tr>
                    <th rowspan="3">첨부이미지</th>
                    <td>
                        PC로고  : <input type="file" name="file_PartnerLogow" id="file_PartnerLogow" accept="${acceptExt}" onchange="checkFile(this, '${acceptExt}', 5)" />
                        <c:if test="${pointCpDetail.partnerLogow ne null}"><a href="/data/coupon/${pointCpDetail.partnerLogow}" target="_blank">${pointCpDetail.partnerLogow}</a></c:if>
                    </td>
                </tr>
                <tr>
                    <td>
                        모바일로고 : <input type="file" name="file_PartnerLogom" id="file_PartnerLogom" accept="${acceptExt}" onchange="checkFile(this, '${acceptExt}', 5)" />
                        <c:if test="${pointCpDetail.partnerLogom ne null}"><a href="/data/coupon/${pointCpDetail.partnerLogom}" target="_blank">${pointCpDetail.partnerLogom}</a></c:if>
                    </td>
                </tr>
                <tr>
                    <td>
                        배너썸네일 : <input type="file" name="file_BannerThumb" id="file_BannerThumb" accept="${acceptExt}" onchange="checkFile(this, '${acceptExt}', 5)" />
                        <c:if test="${pointCpDetail.bannerThumb ne null}"><a href="/data/coupon/${pointCpDetail.bannerThumb}" target="_blank">${pointCpDetail.bannerThumb}</a></c:if>
                    </td>
                </tr>
            </table>
        </form>
    </li>
</ul>

<div class="btn_ct01"><span class="btn_sty04"><a href="javascript:fn_CouponEdit('${pointCpDetail.partnerCode}');">저장</a></span></div>
<script type="text/javascript">
    let cp_duplChk = "N";
    $(document).ready (function () {
        $("#popPartnerCode").click(function (){
            cp_duplChk = "N"
        });

        $("#chkCorpFilterYn").click(function () {
            if ($('#chkCorpFilterYn').is(':checked')) {
                $('#corpFilterYn').val("Y");
            } else {
                $('#corpFilterYn').val("N");
            }
        });

        $("#chkCorpPointLimitYn").click(function () {
            if ($('#chkCorpPointLimitYn').is(':checked')) {
                $('#corpPointLimitYn').val("Y");
            } else {
                $('#corpPointLimitYn').val("N");
            }
        });

        $("#aplStartDt").datepicker({
            dateFormat : "yymmdd",
            onClose : function(selectedDate) {
                $("#aplEndDt").datepicker("option", "minDate", selectedDate);
            }
        });

        $("#aplEndDt").datepicker({
            dateFormat: "yymmdd",
            onClose : function(selectedDate) {
                $("#aplStartDt").datepicker("option", "maxDate", selectedDate);
            }
        });

        $("#useStartDt").datepicker({
            dateFormat : "yymmdd",
            onClose : function(selectedDate) {
                $("#useEndDt").datepicker("option", "minDate", selectedDate);
            }
        });

        $("#useEndDt").datepicker({
            dateFormat: "yymmdd",
            onClose : function(selectedDate) {
                $("#useStartDt").datepicker("option", "maxDate", selectedDate);
            }
        });

        if ('${partnerCode}' == ''){
            $("#partnerBudget").val(0);
        }
    });

    function fn_DuplicationChk(){
        const form = $('#frmPop')[0];
        const data = new FormData(form);
        $.ajax({
            type:"post",
            url:"/oss/point/pcDuplication.ajax",
            enctype: 'multipart/form-data',
            data: data,
            processData: false,
            contentType: false,
            dataType: "json",
            success:function(data){
                if(data.partnerCnt > 0){
                    alert("이미 사용 중 입니다.");
                }else{
                    cp_duplChk = "Y";
                    alert("사용 가능한 파트너코드 입니다.");
                }
                return;
            },
            error : fn_AjaxError
        });

    }
    function fn_CouponEdit(xPartnerCode){
        let editType = "I";
        let editText = "생성";
        if(xPartnerCode){
            editType = "U";
            editText = "수정";
        }

        if(isNull($("#popPartnerCode").val())) {
            alert("파트너코드를 입력해주세요.");
            $("#popPartnerCode").focus();
            return;
        }

        if(cp_duplChk == "N" && xPartnerCode == ""){
            alert("파트너 코드 중복 체크를 해주세요");
            return;
        }

        if(isNull($("#partnerNm").val())) {
            alert("파트너사 명칭을 입력해주세요.");
            $("#partnerNm").focus();
            return;
        }

        if(isNull($("#cpNm").val())) {
            alert("쿠폰명을 입력해주세요.");
            $("#cpNm").focus();
            return;
        }

        if(isNull($("#aplStartDt").val())) {
            alert("쿠폰사용 시작일을 입력해주세요.");
            $("#aplStartDt").focus();
            return;
        }
        if(isNull($("#aplEndDt").val())) {
            alert("쿠폰사용 종료일을 입력해주세요.");
            $("#aplEndDt").focus();
            return;
        }

        $("#editType").val(editType);
        const form = $('#frmPop')[0];
        const data = new FormData(form);

        $.ajax({
            type:"post",
            enctype: 'multipart/form-data',
            url:"/oss/point/couponEdit.ajax",
            data: data,
            dataType: "json",
            processData: false,
            contentType: false,
            success:function(data){
                if(data.success == "Y"){
                    alert('쿠폰 '+editText+'을 완료하였습니다.');
                    location.reload();
                    return;
                }else{
                    alert('쿠폰 '+editText+'을 실패 하였습니다.');
                    return;
                }
            },
            error : fn_AjaxError
        });
    }

    function chkCharCode(event) {
        const regExp = /[^0-9a-zA-Z]/g;
        const ele = event.target;
        if (regExp.test(ele.value)) {
            ele.value = ele.value.replace(regExp, '');
        }
    }

</script>