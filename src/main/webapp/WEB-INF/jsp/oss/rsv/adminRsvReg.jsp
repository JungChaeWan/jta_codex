<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="un" uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant"/>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta http-equiv="Content-Type" content="text/html" charset="utf-8"/>
    <meta http-equiv="Cache-Control" content="no-cache; no-store; no-save"/>

    <script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery-ui-1.11.4.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
    <script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>

    <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>"/>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/page_style.css'/>"/>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/oss/layout.css'/>"/>

    <title></title>
</head>
<body>
<div id="wrapper">
    <jsp:include page="/oss/head.do?menu=rsv"/>
    <!--Contents 영역-->
    <div id="contents_wrapper">
        <jsp:include page="/oss/left.do?menu=rsv&sub=rsvSv"/>
        <div id="contents_area">
            <form name="rsvInfo" id="rsvInfo" onSubmit="return false;">
                <div id="contents">
                    <!--본문-->
                    <!--상품 등록-->
                    <ul class="form_area">
                        <li>
                            <div class="line2">
                                <article class="payArea userWrap1">
                                    <h5 class="title">구매 정보</h5>
                                    <table class="commRow">
                                        <tbody>
                                        <tr>
                                            <th>구매자명</th>
                                            <td><input type="text" name="rsvNm" id="rsvNm"></td>
                                        </tr>
                                        <tr>
                                            <th>이메일</th>
                                            <td><input type="text" name="rsvEmail" id="rsvEmail" style="width: 250px">
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>연락처</th>
                                            <td><input type="text" name="rsvTelnum" id="rsvTelnum" maxlength="14"></td>
                                        </tr>
                                        <tr>
                                            <th>결제방법</th>
                                            <td>
                                                <select name="payDiv" class="payDiv">
                                                    <option value="N200">스마트스토어</option>
                                                    <option value="N210">라이브커머스</option>
                                                    <option value="L100">신용카드</option>
                                                    <option value="L200">휴대폰결제</option>
                                                    <option value="L300">계좌이체</option>
                                                    <option value="L700">무통장입금</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>배송방법</th>
                                            <td>
                                                <select name="directRecvYn">
                                                    <option value="N" checked="checked">일반택배</option>
                                                    <option value="Y">직접수령</option>

                                                </select>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </article>
                                <article class="payArea userWrap2">
                                    <h5 class="title">배송지 정보</h5>
                                    <input id="chk" type="checkbox"><label for="chk">구매정보와 동일한 경우 체크해주세요</label>
                                    <table class="commRow">
                                        <tbody>
                                        <tr>
                                            <th>이름</th>
                                            <td><input type="text" name="useNm" id="useNm"></td>
                                        </tr>
                                        <tr>
                                            <th>휴대폰</th>
                                            <td><input type="text" name="useTelnum" id="useTelnum" maxlength="14"></td>
                                        </tr>
                                        <tr>
                                            <th>배송지 주소</th>
                                            <td>
                                                <div class="btn_sty07">
                                                    <span><a href="javascript:openDaumPostcode()">주소검색</a></span></div>
                                                <input id="postNum" name="postNum" readonly="readonly" class="input_text5"/>
                                                <br/> <input id="roadNmAddr" name="roadNmAddr" class="input_text15"/>
                                                <input id="dtlAddr" name="dtlAddr" class="input_text15"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>배송시 요청사항</th>
                                            <td>
                                                <textarea name="dlvRequestInf" cols="50" rows="5" placeholder="배송 요청사항 입력"></textarea>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </article>
                            </div>
                        </li>
                        <li>
                            <table border="1" cellpadding="0" cellspacing="0" class="table03">
                                <caption class="tb02_title">구매 상품 정보
                                    <ul class="btn_rt01">
                                        <li class="btn_sty04">
                                            <a href="javascript:void(0)" onclick="fn_prdt_reg();">상품 등록</a></li>
                                    </ul>
                                </caption>
                            </table>
                            <p></p>
                            <div id="prdtRegList">
                                <table border="1" cellpadding="0" cellspacing="0" class="table03" id="regInfo">
                                    <tr>
                                        <td colspan="4">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_noline">
                                                 <th scope="col">상품 등록 버튼을 클릭 하여 구매 상품을 등록 하세요.</th>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </li>

                    </ul>
                    <!--//상품등록-->
                    <!--//본문-->
                    <ul class="btn_rt01">
                        <li class="btn_sty01"><a href="javascript:void(0)" onclick="fn_ListRsv();">목록</a></li>
                        <li class="btn_rt01 btn_sty04"><a href="javascript:fn_RsvConfirmSV();" onclick="">예약하기</a></li>
                    </ul>
                </div>
            </form>
        </div>
    </div>
    <!--//Contents 영역-->
</div>
<script type="text/javascript">
    /**
     * DAUM 연동 주소찾기
     */
    function openDaumPostcode() {
        new daum.Postcode({
            oncomplete: function (data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
                // 우편번호와 주소 정보를 해당 필드에 넣고, 커서를 상세주소 필드로 이동한다.
                // document.getElementById('post1').value = data.postcode1;
                // document.getElementById('post2').value = data.postcode2;
                // 2015.08.01 부터 우편번호 5자리 실행
                document.getElementById('postNum').value = data.zonecode;
                document.getElementById('roadNmAddr').value = data.address;

                //전체 주소에서 연결 번지 및 ()로 묶여 있는 부가정보를 제거하고자 할 경우,
                //아래와 같은 정규식을 사용해도 된다. 정규식은 개발자의 목적에 맞게 수정해서 사용 가능하다.
                //var addr = data.address.replace(/(\s|^)\(.+\)$|\S+~\S+/g, '');
                //document.getElementById('addr').value = addr;

                document.getElementById('dtlAddr').focus();
            }
        }).open();
    }

    function fn_prdt_reg() {
        const win = window.open("/oss/svPrdtList.do", "_blank", "toolbar=no,scrollbars=yes,resizable=yes,top=20,left=20,width=1400,height=900");
    }

    function fn_get_prdt(prdtNum) {
        $.ajax({
            type:"post",
            dataType:"html",
            async:false,
            url:"<c:url value='/oss/adminRsvReg.ajax'/>",
            data:"prdtNum="+prdtNum ,
            success:function(data){
                //console.log(data);
                $("#regInfo").hide();
                $("#prdtRegList").append(data).find("table").trigger("create");
            },
            error:fn_AjaxError
        });

    }
    $(document).on("click",".closePrdt",function(){
        $(this).closest("table").remove();
    });

    //옵션 선택 계산
    $(document).on("change",".selOptList",function(){
        $(this).closest("td").find(".svDivSn").val($(this).children("option:selected").data("divsn"));
        fn_total_price($(this),"selOpt");
    });

    //추가 옵션 선택 계산
    $(document).on("change",".selAddOptList",function(){
        $(this).closest("td").find(".svOptDivSn").val($(this).children("option:selected").data("optdivsn"));
        fn_total_price($(this),"selAddOpt");
    });

    //수량 입력 계산
    $(document).on("blur",".cnt",function(){
        fn_total_price($(this),"inpCnt");
    });


    //택배비 입력 계산
    $(document).on("blur",".dlvAmt",function(){
        fn_total_price($(this),"inpDlvAmt");
    });


    function fn_total_price(th, type){
        let saleAmt;
        let addSaleAmt;
        let rCnt;
        let dlvAmt;
        let stockNum;

        if (type == "selOpt"){ //옵션 selectbox 선택
            saleAmt = th.children("option:selected").data("amt");
            stockNum = th.children("option:selected").data("stocknum");
            addSaleAmt = th.closest("td").find(".selAddOptList").children("option:selected").data("addamt");
        } else if (type == "selAddOpt"){ //추가 옵션 sleectbox 선택
            saleAmt = th.closest("td").find(".selOptList").children("option:selected").data("amt");
            stockNum = th.closest("td").find(".selOptList").children("option:selected").data("stocknum");
            addSaleAmt = th.children("option:selected").data("addamt");
        } else{
            saleAmt = th.closest("td").find(".selOptList").children("option:selected").data("amt");
            stockNum = th.closest("td").find(".selOptList").children("option:selected").data("stocknum");
            addSaleAmt = th.closest("td").find(".selAddOptList").children("option:selected").data("addamt");
        }

        //수량
        if (type == "inpCnt"){
            rCnt = th.val();
            if (rCnt  > stockNum){
                alert("판매 할 수 있는 최대 수량을 넘었습니다.\n 가능 수량으로 설정 합니다.");
                th.val(stockNum);
                rCnt = stockNum;
            }
        } else {
            rCnt = th.closest("td").find(".cnt").val();
            if (rCnt  > stockNum){
                alert("판매 할 수 있는 최대 수량을 넘었습니다.\n 가능 수량으로 설정 합니다.");
                th.closest("td").find(".cnt").val(stockNum);
                rCnt = stockNum;
            }
        }

        //택배비
        if (type == "inpDlvAmt"){
            dlvAmt = th.val();
        } else {
            dlvAmt = th.closest("td").find(".dlvAmt").val();
        }

        if(saleAmt == "" || !saleAmt) {saleAmt = 0};
        if(addSaleAmt == "" || !addSaleAmt) {addSaleAmt = 0};
        if(rCnt == "" || !rCnt) {rCnt = 0};
        if(dlvAmt == "" || !dlvAmt) {dlvAmt = 0};

        // console.log(saleAmt);
        // console.log(addSaleAmt);

        //옵션 + 추가옵션 금액
        saleAmt = saleAmt + addSaleAmt;
        th.closest(".table_noline").find(".totalPrice").text(numberWithCommas(parseInt(saleAmt) * parseInt(rCnt) + parseInt(dlvAmt)));
    }

    function numberWithCommas(x) {
        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

    $(document).ready(function(){
        $("#chk").click(function(){
           $("#useNm").val($("#rsvNm").val());
           $("#useTelnum").val($("#rsvTelnum").val());
        });
    });

    //예약하기
    function fn_RsvConfirmSV() {
        if(isNull($("#rsvNm").val())) {
            alert("구매자 이름을 입력해주세요.");
            $("#rsvNm").focus();
            return;
        }
        // if(isNull($("#rsvEmail").val())) {
        //     alert("구매자 이메일을 입력해주세요.");
        //     $("#rsvEmail").focus();
        //     return;
        // }
        if(isNull($("#rsvTelnum").val())) {
            alert("구매자 전화번호를 입력해주세요.");
            $("#rsvTelnum").focus();
            return;
        }
        // 휴대폰번호 체크
        // if(!checkIsHP($("#rsvTelnum").val())) {
        //     alert("유효하지 않은 전화번호입니다. 예)010-1234-5678");
        //     $("#rsvTelnum").focus();
        //     return;
        // }

        if(isNull($("#useNm").val())) {
            alert("수령인 이름을 입력해주세요.");
            $("#useNm").focus();
            return;
        }
        if(isNull($("#useTelnum").val())) {
            alert("수령인 전화번호를 입력해주세요.");
            $("#useTelnum").focus();
            return;
        }


        if(isNull($("#postNum").val()) || isNull($("#roadNmAddr").val())) {
            alert("배송지 주소를 입력해주세요.");
            $("#roadNmAddr").focus();
            return ;
        }
        if(isNull($("#dtlAddr").val())) {
            alert("상세 주소를 입력해주세요.");
            $("#dtlAddr").focus();
            return ;
        }

        if(!checkInputCnt()){
            return false;
        }

        if(!checkSelOptList()){
            return false;
        }

        document.rsvInfo.action = "<c:url value='/oss/adminRsvRegOrder.do'/>";
        document.rsvInfo.submit();
    }

    //옵션 값 선택 체크
    const checkSelOptList = function () {
        let isValid = true;
        $("select[name=selOptList] option:selected").each(function () {
            if ($(this).val() == "") {
                alert("옵션을 선택 해 주세요.");
                isValid = false;
                return false;
            }
        });
        return isValid;
    };

    //수량 값 입력 체크
    const checkInputCnt = function () {
        let isValid = true;
        if ($("input[name=cnt]").length == "0"){
            alert("구매 상품을 등록 해 주세요.");
            isValid = false;
            return false;
        }

        $("input[name=cnt]").each(function () {
            if ($(this).val() == "") {
                alert("수량을 선택 해 주세요.");
                $(this).focus();
                isValid = false;
                return false;
            }
        });
        return isValid;
    };

    function fn_ListRsv() {
        document.rsvInfo.action = "<c:url value='/oss/rsvSvList.do'/>";
        document.rsvInfo.submit();
    }

    function fn_LoginMas(corpId) {
        const parameters = "corpId=" + corpId;

        $.ajax({
            type:"post",
            dataType:"json",
            url:"<c:url value='/oss/masLogin.ajax'/>",
            data:parameters,
            success:function(data){
                if(data.success == "Y") {
                    window.open("<c:url value='/mas/home.do'/>", '_blank');
                } else {
                    alert("업체 로그인에 실패하였습니다.");
                }
            }
        });
    }
</script>
</body>
</html>