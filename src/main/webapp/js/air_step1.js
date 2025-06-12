//항공여정(RT:왕복, OW:편도)
var g_trip_type = "RT";
// 항공사 코드
var com_codes = new Array('KE', 'OZ', 'LJ', 'BX', 'ZE', 'TW', '7C', 'RS','4V','RF');
// 항공사명
var com_array = new Array('대한항공', '아시아나', '진에어', '에어부산', '이스타', '티웨이', '제주항공', '에어서울', '플라이강원', '에어로케이');

//항공유형클릭 이벤트
function airtype_click()
{
    //편도이면
    if($("input[name=trip_type]:checked").val() == "OW")
    {
        $("input[name=end_date]").hide();
        //$("input[name=end_date]").next().hide();
    }
    //왕복이면
    else
    {
        $("input[name=end_date]").show();
        //$("input[name=end_date]").next().show();
    }
}

//좌석등급클릭 이벤트
function seat_click(type)
{
    //전체를 클릭한 경우
    if(type == "ALL")
    {
        if($("#air_ratingALL").is(":checked"))
        {
            $("input[name^=seat_type]").not($("#air_ratingALL")).each(function(){
                this.checked = true;
            });
        }
        else
        {
            $("input[name^=seat_type]").not($("#air_ratingALL")).each(function(){
                this.checked = false;
            });
        }
    }
    else
    {
        var all_cnt = $("input[name^=seat_type]").not($("#air_ratingALL")).length;
        var check_cnt = $("input[name^=seat_type]:checked").not($("#air_ratingALL")).length;

        //모두 체크되어 있으면
        if(all_cnt == check_cnt)
        {
            $("#air_ratingALL").each(function(){
                this.checked = true;
            });
        }
        else
        {
            $("#air_ratingALL").each(function(){
                this.checked = false;
            });
        }
    }
}

//좌석 등급 및 승객 정보 수정
function modify_seat_person() {
    //var str = $("#seat_type option:selected").text();

    var str = " 성인 " + $('#adult_num').text();
    if (eval($('#child_num').text()) > 0) {
        str += ", 소아 " + $('#child_num').text();
    }
    if (eval($('#baby_num').text()) > 0) {
        str += ", 유아 " + $('#baby_num').text();
    }
    $('#seat_person_str').text(str);
}

// 인원수 변경 이벤트
function chg_person(type, gubun) {
    var num = 0;
    if (type == '+') {
        num = eval($('#' + gubun + '_num').text()) + 1;
    } else {
        num = eval($('#' + gubun + '_num').text()) - 1;
    }

    // 최저 인원 수 - 성인 : 1, 소아&유아 : 0
    if (gubun == 'adult') {
        if (num < 1) num = 1;
        else if (num > 9) num = 9;
    } else {
        if (num < 0) num = 0;
        else if (num > 8) num = 8;
    }

    $('#' + gubun + '_num').text(num);
    $('input[name=' + gubun + '_cnt]').val(num);

    modify_seat_person();
}

//검색폼 체크
function check_air_seach_form()
{
    //출발지, 도착지 동일 여부 체크(2016-01-05)
    var start_airport = $.trim($("input[name=start_region]:checked").val());
    var end_airport = $.trim($("input[name=end_region]:checked").val());

    if(start_airport == end_airport)
    {
        alert("출발지와 도착지가 동일합니다.");
        return false;
    }

    //출발일자 체크
    var start_date = $.trim($("input[name=start_date]").val());
    if(start_date.length < 1)
    {
        alert("가는날을 선택해주세요.");
        return false;
    }

    //도착일자 체크
    //항공유형이 왕복일 경우
    if($("input[name=trip_type]:checked").val() == "RT")
    {
        var end_date = $.trim($("input[name=end_date]").val());
        if(end_date.length < 1)
        {
            alert("오는날을 선택해주세요.");
            return false;
        }
    }
    //항공유형이 편도일 경우
    else
    {
        //출발일자를 셋팅한다.
        $("input[name=end_date]").val(start_date);
    }

    //인원수 체크
    if(!check_people_cnt())
    {
        return false;
    }

    // 검색 폼의 hidden
    optionClose($("#air_departure"));
    optionClose($("#air_arrival"));
    optionClose($("#air_count"));

    //실시간 항공 데이터 가져오기 (리스트 페이지인 경우)
    if ($('input[name=page_type]').val() == 'list') {
        load_air_list();
        return false;
    }

    ++prevIndex;
    history.replaceState($("#_wrap").html(), "title"+ prevIndex, "?prevIndex="+ prevIndex);
    currentState = history.state;
}


//인원수 체크
function check_people_cnt()
{
    //성인수
    var adult_cnt = $("input[name=adult_cnt]").val();
    adult_cnt = eval(adult_cnt) + 0;

    //소아수
    var child_cnt = $("input[name=child_cnt]").val();
    child_cnt = eval(child_cnt) + 0;

    //유아수
    var baby_cnt = $("input[name=baby_cnt]").val();
    baby_cnt = eval(baby_cnt) + 0;

    //1. 유아인원수는 성인인원수를 초과할 수 없다.
    if(adult_cnt < baby_cnt)
    {
        alert("성인 1명에 유아 1명만을 예약하실 수 있으며 나머지 유아는 소아로 예약하셔야 합니다.");
        $("select#child").val(adult_cnt);

        return false;
    }

    //2. 총 좌석점유 탑승객이 9명을 초과할 수 없다.
    if(adult_cnt + child_cnt > 9)
    {
        alert("총 좌석점유 탑승객이 9명을 넘을 수 없습니다.");
        $("select#adult").val("1");
        $("select#children").val("0");
        $("select#child").val("0");

        return false;
    }

    return true;
}

//실시간 항공 데이터 가져오기
function load_air_list()
{
    /** 검색조건 *********************************************/
    //항공유형
    var trip_type = $.trim($("input[name=trip_type]:checked").val());

    //전역변수에 셋팅
    g_trip_type = trip_type;

    //좌석등급
    var seat_types = "전체";

    //출발지역
    var start_area = $.trim($("input[name=start_region]:checked").val());

    //도착지역
    var end_area = $.trim($("input[name=end_region]:checked").val());

    //가는일자
    var start_date = $.trim($("input[name=start_date]").val());

    //오는일자
    var end_date = $.trim($("input[name=end_date]").val());

    //성인수
    var adult_cnt = $("input[name=adult_cnt]").val();

    //소아수
    var child_cnt = $("input[name=child_cnt]").val();

    //유아수
    var baby_cnt = $("input[name=baby_cnt]").val();

    //검색시 인원수 셋팅
    /* 제이엘 항공 인원수 */
    $("input[name=step2_adult_cnt]").val(adult_cnt);
    $("input[name=step2_child_cnt]").val(child_cnt);
    $("input[name=step2_baby_cnt]").val(baby_cnt);

    /* 제주닷컴 항공 인원수 */
    $("input[name=boarding_adult]").val(adult_cnt);
    $("input[name=boarding_junior]").val(child_cnt);
    $("input[name=boarding_baby]").val(baby_cnt);

    //가는항공편 정보 표시
    var start_air_info = "";
    start_air_info += "<img src='/images/web/air/go.png' alt='가는항공편'> ";
    start_air_info += '<div class="airGo_txt"> 가는편';
    start_air_info += '<div class="route"> [ ' + $("label[for=" + $("input[name=start_region]:checked").attr('id') + "]").text() + '<span><img src="/images/web/air/go_arrow.png" alt=""></span>';
    start_air_info += "<span>" + $("label[for=" + $("input[name=end_region]:checked").attr('id') + "]").text() + "</span> ]";

    $("div.lArea h5.date").html(start_air_info);

    //가는항공편 날짜 표시
    var start_date_info = "";
    start_date_info += start_date.replace(/-/g, ".");
    start_date_info += '<em class="week">' + get_yoil(start_date) + '</em>';

    $("div.lArea div.dm-list-head div.dm-date span.active").html(start_date_info);

    /* 제주닷컴 가는항공편 정보 셋팅 */
    $("input[name=flight_type]").val(1);
    $("input[name=flight_scity]").val($("input[name=start_region]:checked").val());
    $("input[name=flight_sdate]").val($("input[name=start_date]").val());
    $("input[name=flight_ecity]").val($("input[name=end_region]:checked").val());

    if ($("#airline_code").val() == 'ALL') {
        for (var i=0; i<com_codes.length; i++) {
            $("input[name='flight_com[]']").val(com_codes[i]);
        }
    } else {
        $("input[name='flight_com[]']").val($("#airline_code").val());
    }

    //왕복인 경우에는 보이게 한다.
    if(trip_type == "RT")
    {
        //오는항공편 정보 표시
        var end_air_info = "";
        end_air_info += "<img src='/images/web/air/go.png' alt='오는항공편'>  ";
        end_air_info += '<div class="airGo_txt"> 오는편';
        end_air_info += '<div class="route"> [ ' + $("label[for=" + $("input[name=end_region]:checked").attr('id') + "]").text();
        end_air_info += '<span><img src="/images/web/air/go_arrow.png" alt=""></span>';
        end_air_info += "<span>" + $("label[for=" + $("input[name=start_region]:checked").attr('id') + "]").text() + "</span> ]";

        $("div.rArea h5.date").html(end_air_info);

        //오는항공편 날짜 표시
        var end_date_info = "";
        end_date_info += end_date.replace(/-/g, ".");
        end_date_info += '<em class="week">' + get_yoil(end_date) + '</em>';

        $("div.rArea div.dm-list-head div.dm-date span.active").html(end_date_info);

        /* 제주닷컴 오는항공편 정보 셋팅 */
        $("input[name=flight_type]").val(2);
        $("input[name=flight_edate]").val($("input[name=end_date]").val());
    }

    //초기 검색요청 div 숨김///////////////////////////////
    $("#init_start_div").hide();
    $('#airLogoImg').addClass('hide');

    //편도인 경우에는 보이게 한다.
    if(trip_type == "OW"){
        $("#init_end_div").show();
    } else {
        $("#init_end_div").hide();
    }

    //선택한 항공 스케줄 초기화
    $(".go_tr").remove();
    $(".come_tr").remove();

    //항공검색목록 초기화
    var begin_info = "";
    begin_info += '<td id="choice_go" colspan="7">';
    begin_info += '<span>출발편을 선택해 주세요.</span>';
    begin_info += '</td>';
    $("div.journey table.commCol #choice_go_info").html(begin_info);

    begin_info = "";
    begin_info += '<td id="choice_come" colspan="7">';
    begin_info += '<span>도착편을 선택해 주세요.</span>';
    begin_info += '</td>';
    $("div.journey table.commCol #choice_come_info").html(begin_info);

    //선택항공권정보 초기화
    $("input[name=step2_go_air_info]").val("");
    $("input[name=step2_come_air_info]").val("");

    /** 선택한 여정 부분 *************************************/
    //선택한여정 부분 표시
    $("#choice_air_info").removeClass('hide');

    //가는항공편 보임.
    $("#choice_air_info div.go").show();

    //선택하신 여정 > 가는항공편 정보 초기화
    var childCnt = $("input[name=child_cnt]").val();

    if(childCnt >= 1){
        price_apply("go","1|1" ,"0|0","0|0","0|0","0|0"); //소아 1명 이상
    }else{
        price_apply("go","1|0" ,"0|0","0|0","0|0","0|0");
    }

    //왕복인 경우에는 오는항공편 부분도 보이게 한다.
    if(trip_type == "RT")
    {
        $("#choice_air_info div.come").show();
        $("div.journey table.commCol #choice_come_info").show();

        //선택하신 여정 > 오는항공편 정보 초기화
        if(childCnt >= 1){
            price_apply("come","1|1" ,"0|0","0|0","0|0","0|0"); //소아 1명 이상
        }else{
            price_apply("come","1|0" ,"0|0","0|0","0|0","0|0");
        }
    }
    else
    {
        $("#choice_air_info div.come").hide();
        $("div.journey table.commCol #choice_come_info").hide();

        //선택하신 여정 > 오는항공편 정보 초기화
        if(childCnt >= 1){
            price_apply("come","1|1" ,"0|0","0|0","0|0","0|0"); //소아 1명 이상
        }else{
            price_apply("come","1|0" ,"0|0","0|0","0|0","0|0");
        }
    }

    //로딩중에는 버튼 비활성
    $("#airline_code").attr("disabled", true);
    $("#btnSearch").attr("disabled", true);
    $(".lArea a").css("pointer-events","none");
    $(".rArea a").css("pointer-events","none");

    //스피너 로딩바 show
    $(".loadingAir-wrap").removeClass("hide");

    let promises = [];

    //선민투어
    promises.push(air_service_sunmin_call(trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt));

    //진에어
    if($("#airline_code").val() == "ALL" || $("#airline_code").val() == "LJ")
    {
        promises.push(air_service_lj_call(trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt));
    }

    //에어부산
    if($("#airline_code").val() == "ALL" || $("#airline_code").val() == "BX")
    {
        promises.push(air_service_bx_call(trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt));
    }

    //이스타항공
    if($("#airline_code").val() == "ALL" || $("#airline_code").val() == "ZE")
    {
        promises.push(air_service_ze_call(trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt));
    }

    //티웨이
    if($("#airline_code").val() == "ALL" || $("#airline_code").val() == "TW")
    {
        promises.push(air_service_tw_call(trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt));
    }

    //제주항공
    if($("#airline_code").val() == "ALL" || $("#airline_code").val() == "7C")
    {
        promises.push(air_service_7c_call(trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt));
    }

    //대한항공
    if($("#airline_code").val() == "ALL" || $("#airline_code").val() == "KE")
    {
        promises.push(air_service_ke_call(trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt));
    }

    //아시아나
    if($("#airline_code").val() == "ALL" || $("#airline_code").val() == "OZ")
    {
        promises.push(air_service_oz_call(trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt));
    }

    // 제주닷컴 항공
    //2024.12월 30일 주석 처리함
    //promises.push(air_service_jejucom_call(trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt));

    //ajax 통신 성공/실패에 관계 없이 모든 통신이 끝나면
    $.when.apply($, promises).always(function() {
        //로딩끝나면 버튼 활성
        $("#btnSearch").attr("disabled", false);
        $(".lArea a").css("pointer-events","");
        $(".rArea a").css("pointer-events","");
        $("#airline_code").attr("disabled", false);

        //스피너 로딩바 hide
        setTimeout(function() {
            $(".loadingAir-wrap").addClass("hide");
        }, 800);
    });
}

//대한항공 항공권 목록 요청
function air_service_ke_call(trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt)
{

}

//대한항공 항공권 목록 적용
function air_service_ke_call_after()
{

}

//아시아나 항공권 목록 요청
function air_service_oz_call(trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt)
{
    return $.ajax({
        type: "GET",
        url: "https://www.jlair.net/api/list.php",
        data: "jsonp=1&gubun=OZ&trip_type="+trip_type+"&seat_types="+seat_types+"&start_area="+start_area+"&end_area="+end_area+"&start_date="+start_date+"&end_date="+end_date+"&adult_cnt="+adult_cnt+"&child_cnt="+child_cnt+"&baby_cnt="+baby_cnt,
        jsonpCallback: 'itemsOZ',
        contentType: "application/json",
        dataType: "jsonp",
        crossDomain: true,
        success: function(data){
            // 통신이 성공적으로 이루어졌을 때 이 함수를 타게 된다.
            air_service_oz_call_after(data, trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt);
        },
        complete : function(data) {
        },
        error : function(xhr, status, error) {
            //alert("에러발생");
        }
    });
}

//아시아나 항공권 목록 적용
function air_service_oz_call_after(data, trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt)
{
    if($("#airline_code").val() == "ALL" || $("#airline_code").val() == "OZ")
    {
        append_jl_air_tr(2, 'go', adult_cnt, child_cnt, data.onword_flight);
        append_jl_air_tr(2, 'come', adult_cnt, child_cnt, data.return_flight);
    }
}

//진에어 항공권 목록 요청
function air_service_lj_call(trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt)
{
    return $.ajax({
        type: "GET",
        url: "https://www.jlair.net/api/list.php",
        data: "jsonp=1&gubun=LJ&trip_type="+trip_type+"&seat_types="+seat_types+"&start_area="+start_area+"&end_area="+end_area+"&start_date="+start_date+"&end_date="+end_date+"&adult_cnt="+adult_cnt+"&child_cnt="+child_cnt+"&baby_cnt="+baby_cnt,
        jsonpCallback: 'itemsLJ',
        contentType: "application/json",
        dataType: "jsonp",
        crossDomain: true,
        success: function(data){
            // 통신이 성공적으로 이루어졌을 때 이 함수를 타게 된다.
            air_service_lj_call_after(data, trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt);
        },
        complete : function(data) {
        },
        error : function(xhr, status, error) {
        }
    });
}

//진에어 항공권 목록 적용
function air_service_lj_call_after(data, trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt)
{
    if($("#airline_code").val() == "ALL" || $("#airline_code").val() == "LJ")
    {
        append_jl_air_tr(3, 'go', adult_cnt, child_cnt, data.onword_flight);
        append_jl_air_tr(3, 'come', adult_cnt, child_cnt, data.return_flight);
    }
}

//에어부산 항공권 목록 요청
function air_service_bx_call(trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt)
{

}

//에어부산 항공권 목록 적용
function air_service_bx_call_after()
{

}

//이스타항공 항공권 목록 요청
function air_service_ze_call(trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt)
{
    return $.ajax({
        type: "GET",
        url: "https://www.jlair.net/api/list.php",
        data: "jsonp=1&gubun=ZE&trip_type="+trip_type+"&seat_types="+seat_types+"&start_area="+start_area+"&end_area="+end_area+"&start_date="+start_date+"&end_date="+end_date+"&adult_cnt="+adult_cnt+"&child_cnt="+child_cnt+"&baby_cnt="+baby_cnt,
        jsonpCallback: 'itemsZE',
        contentType: "application/json",
        dataType: "jsonp",
        crossDomain: true,
        success: function(data){
            // 통신이 성공적으로 이루어졌을 때 이 함수를 타게 된다.
            air_service_ze_call_after(data, trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt);
        },
        complete : function(data) {
            // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
        },
        error : function(xhr, status, error) {
            //alert("에러발생");
        }
    });
}

//이스타항공 항공권 목록 적용
function air_service_ze_call_after(data, trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt)
{
    if($("#airline_code").val() == "ALL" || $("#airline_code").val() == "ZE")
    {
        append_jl_air_tr(5, 'go', adult_cnt, child_cnt, data.onword_flight);
        append_jl_air_tr(5, 'come', adult_cnt, child_cnt, data.return_flight);
    }
}

//티웨이 항공권 목록 요청
function air_service_tw_call(trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt)
{
    return $.ajax({
        type: "GET",
        url: "https://www.jlair.net/api/list.php",
        data: "jsonp=1&gubun=TW&trip_type="+trip_type+"&seat_types="+seat_types+"&start_area="+start_area+"&end_area="+end_area+"&start_date="+start_date+"&end_date="+end_date+"&adult_cnt="+adult_cnt+"&child_cnt="+child_cnt+"&baby_cnt="+baby_cnt,
        jsonpCallback: 'itemsTW',
        contentType: "application/json",
        dataType: "jsonp",
        crossDomain: true,
        success: function(data){
            // 통신이 성공적으로 이루어졌을 때 이 함수를 타게 된다.
            air_service_tw_call_after(data, trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt);
        },
        complete : function(data) {
        },
        error : function(xhr, status, error) {
            //alert("에러발생");
        }
    });
}

//티웨이 항공권 목록 적용
function air_service_tw_call_after(data, trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt)
{
    if($("#airline_code").val() == "ALL" || $("#airline_code").val() == "TW")
    {
        append_jl_air_tr(6, 'go', adult_cnt, child_cnt, data.onword_flight);
        append_jl_air_tr(6, 'come', adult_cnt, child_cnt, data.return_flight);
    }
}

//제주항공 항공권 목록 요청
function air_service_7c_call(trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt)
{
    return $.ajax({
        type: "GET",
        url: "https://www.jlair.net/api/list.php",
        data: "jsonp=1&gubun=7C&trip_type="+trip_type+"&seat_types="+seat_types+"&start_area="+start_area+"&end_area="+end_area+"&start_date="+start_date+"&end_date="+end_date+"&adult_cnt="+adult_cnt+"&child_cnt="+child_cnt+"&baby_cnt="+baby_cnt,
        jsonpCallback: 'items7C',
        contentType: "application/json",
        dataType: "jsonp",
        crossDomain: true,
        success: function(data){
            // 통신이 성공적으로 이루어졌을 때 이 함수를 타게 된다.
            air_service_7c_call_after(data, trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt);
        },
        complete : function(data) {
        },
        error : function(xhr, status, error) {
            //alert("에러발생");
        }
    });
}

//제주항공 항공권 목록 적용
function air_service_7c_call_after(data, trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt)
{
    if($("#airline_code").val() == "ALL" || $("#airline_code").val() == "7C")
    {
        append_jl_air_tr(7, 'go', adult_cnt, child_cnt, data.onword_flight);
        append_jl_air_tr(7, 'come', adult_cnt, child_cnt, data.return_flight);
    }
}

//제이엘항공의 tr 추가
function append_jl_air_tr(com, gubun, adult, child, air_data)
{
    $.each(air_data, function(i,item) {
        //항공편 예약정보
        var reserve_info = get_air_reserve_info(com_codes[com - 1],item);
        // 예약 여부
        var add_disabled = item.air_seat_cnt == '0' ? 'disabled' : '';

        var html = '<tr id="jl_' + com + '_' + gubun + '_' + i + '" class="' + gubun + '_tr jl_air ' + add_disabled + '">';	// disabled
        html += '	<td>';
        html += '	   	<div class="l-area"><p class="ci"><img src="/images/web/air/line' + com + '_big.png" alt="' + com_array[com - 1] + '"></p></div>';
        html += '	   	<div class="r-area">';
        html += '      		<p class="name">' + com_array[com - 1] + '</p>';
        if(item.adult_number) {
            html += '	       	<p class="emph">' + item.adult_number + '편</p>';
        }
        html += '   	</div>';
        html += '	</td>';
        html += '	<td class="time">';
        html += '		<p class="sTime">' + item.air_s_time_txt + '</p>';
        html += '	</td>';
        html += '	<td class="time">';
        html += '		<p class="eTime">' + item.air_e_time_txt + '</p>';
        html += '	</td>';
        html += '	<td>';
        if(item.adult_fare_type_txt == "특가석" || item.adult_fare_type_txt == "특별석"){
            html += '		<p class="rating Special">';
        }else if(item.adult_fare_type_txt == "할인석"){
            html += '		<p class="rating Sale">';
        }else if(item.adult_fare_type_txt == "이벤트석"){
            html += '		<p class="rating Event">';
        }else if(item.adult_fare_type_txt == "비즈니스석"){
            html += '		<p class="rating business">';
        }else{
            html += '		<p class="rating">';
        }
        html += item.adult_fare_type_txt + '</p>';
        // 2016-06-22 By jdongs@nextez.co.kr 아시아나 공동운항 추가
        if (com == 2 && $.inArray(item.air_joint, new Array('BX', 'RS')) != -1) {
            html += '	<div class="tooltip-btn">';
            html += '		<span>공동운항</span>';
            html += '		<p class="info-text seoul"></p>';
            if (item.air_joint == 'BX')
                html += '	    <p class="info-text busan"></p>';	// 에어부산
            else if (item.air_joint == 'RS')
                html += '	    <p class="info-text seoul"></p>';	// 에어서울
            html += '	</div>';
        }
        html += '	</td>';
        html += '	<td>';
        html += '		<p class="seat">' + item.air_seat_cnt + '석</p>';
        html += '	</td>';
        html += '	<td>';
        html += '		<p class="hide">$</p>';
        var total_pay = commaNum(item.adult_total_pay * adult + item.child_total_pay * child);
        html += '		<p class="money">' + total_pay + '</p>';
        html += '		<p class="unit">원</p>';
        html += '	</td>';
        html += '	<td class="condition">';
        html += '		<input id="air_' + com + gubun + i + '" class="airCH1" type="radio" name="air_' + gubun + '[]" onclick="apply_pay(\'' + gubun + '\', \'' + reserve_info + '\', \'' + com + '_' + gubun + '_' + i + '\', \'' + item.adult_fare_type_txt + '\', \'' + total_pay + '\', \'' + item.air_joint + '\');" ' + add_disabled + '>';
        html += '		<label for="air_' + com + gubun + i + '" class="a-cr">제이엘항공</label>';
        html += '	</td>';
        html += '</tr>';

        if ($.trim($("input[name=trip_type]:checked").val()) == 'RT' || ($.trim($("input[name=trip_type]:checked").val()) == 'OW' && gubun == 'go')){
            $("#" + gubun + "_flight").append(html);
        }
    });

    //항공편 정렬이벤트 갱신
    if ($('.' + gubun + '_tr').length != 0) {
        //var sorting = [[1,0]];
        $(".air-line").trigger("update");

        //리스트 소팅
        list_sorting();
    }
}

function air_service_sunmin_call(trip_type, seat_types, start_area, end_area, depDate, arrDate, adult_cnt, child_cnt, baby_cnt) {
    var seat_str = $('#air_ratingALL').prop('checked') ? '전체' : seat_types.toLowerCase().replace(/@/gi, '|').replace('s', 'd');

    if ($('#airline_code').val() === 'ALL') {
        // 전체 항공사 한 번만 호출
        setting_sunmin_tr('go',com_codes, seat_str, start_area, end_area, depDate, arrDate, adult_cnt, child_cnt, baby_cnt, trip_type);
    } else {
        // 단일 항공사만 호출
        const selected = $('#airline_code').val();
        if (com_codes.includes(selected)) {
            setting_sunmin_tr('go',[selected], seat_str, start_area, end_area, depDate, arrDate, adult_cnt, child_cnt, baby_cnt, trip_type);
        }
    }
}

function setting_sunmin_tr(gubun, search_coms, seat_str, start_area, end_area, depDate, arrDate, adult_cnt, child_cnt, baby_cnt, trip_type) {

    const query = {
        isRound: trip_type === "RT" ? "true" : "false",
        depCity: start_area,
        arrCity: end_area,
        depDate: depDate,
        arrDate: arrDate,
        adultCnt: adult_cnt,
        childCnt: child_cnt,
        infantCnt: baby_cnt
    };

    const carriers = $("#airline_code").val() === 'ALL' ? com_codes : [$("#airline_code").val()];
    carriers.forEach(function(code, i) {
        query["carriers[" + i + "]"] = code;
    });

    return $.ajax({
        url:  (location.hostname === 'localhost' || location.hostname === 'dev.tamnao.com') ? "https://testcore.dcjeju.net/air/direct/schedule" : "https://core.dcjeju.net/air/direct/schedule",
        type: "GET",
        headers: {
            "x-basic-auth": (location.hostname === 'localhost' || location.hostname === 'dev.tamnao.com') ? "3b/HTaQRXOE6mvHFzLsJfSwP5E2x9mFg+kytBjItXnvtnVbKns+weHy0sfA/wWubLNDoVPF2+jCIPjWKHhUum3lGYrrD/h1Lq0kOwzyDdBM2tCq8F5hwS6/aq4q565hK" : "3b/HTaQRXOE6mvHFzLsJfdN21z/FDMoW8H7uXdDdG89+XJCerEXV8S0Pj+4Rms8uwmGGv59hPIpXmKR9cNNc6Zld9Mid7w1JVx+u9hTTRIM=",
            "x-channel-code": "tamnao"
        },
        data: query,
        dataType: "json",
        success: function(data) {
            if (data.list && Array.isArray(data.list)) {
                // 가는편 초기화 및 렌더링
                $("#" + gubun + "_flight tr.sunmin_tour").remove();
                const seenFlights = new Set();

                data.list.forEach(function(item, i) {
                    if (!Array.isArray(item.airLine)) return;
                    item.airLine.forEach(function(flight, j) {
                        if (trip_type === 'RT' && flight.depCity !== start_area) return;
                        const uniqueKey = flight.flight + flight.flightNumber + flight.depDate + flight.bookingClass;
                        if (seenFlights.has(uniqueKey)) return;
                        seenFlights.add(uniqueKey);
                        renderSunminRow(flight, i, j, gubun, "#go_flight", adult_cnt, child_cnt, data.landingUrl);
                    });
                });

                // 오는편 처리
                if (trip_type === "RT") {
                    const seenFlightsReturn = new Set();
                    $("#come_flight tr.sunmin_tour").each(function () {
                        const key = $(this).attr("data-key");
                        if (key) seenFlightsReturn.add(key);
                    });

                    data.list.forEach(function(item, i) {
                        if (!Array.isArray(item.airLine)) return;
                        item.airLine.forEach(function(flight, j) {
                            if (flight.depCity !== end_area || flight.arrCity !== start_area) return;
                            const uniqueKey = flight.flight + flight.flightNumber + flight.depDate + flight.bookingClass;
                            if (seenFlightsReturn.has(uniqueKey)) return;
                            seenFlightsReturn.add(uniqueKey);
                            renderSunminRow(flight, i, j, "come", "#come_flight", adult_cnt, child_cnt, item.landingUrl);
                        });
                    });
                }
            }
        },
        complete: function() {
            if ($('.' + gubun + '_tr').length !== 0) {
                $(".air-line").trigger("update");
                list_sorting();
            }
        },
        error: function(xhr, status, error) {
            console.error("선민 항공 조회 에러:", error);
        }
    });
}

function renderSunminRow(flight, i, j, chg_gubun, containerId, adult_cnt, child_cnt, landingUrl) {
    const uniqueKey = flight.flight + flight.flightNumber + flight.depDate + flight.bookingClass;
    const com = $.inArray(flight.flight, com_codes);
    const depDate = flight.depDate?.split(' ')[0] || '';
    const depTime = flight.depDate?.split(' ')[1]?.substring(0, 5) || '';
    const arrDate = flight.arrDate?.split(' ')[0] || '';
    const arrTime = flight.arrDate?.split(' ')[1]?.substring(0, 5) || '';
    const daily_array = [
        depDate, // 출발일
        depTime, // 출발시간
        flight.depCity, //출발도시코드
        flight.depCityNm, //출발도시명
        arrDate, //도착일
        arrTime, //도착시간
        flight.arrCity, //도착도시코드
        flight.arrCityNm, //도착도시명
        flight.flight, // 항공사 코드
        flight.flightNumber, // 항공편 번호
        com
    ];

    const adult = Array.isArray(flight.fareInfo) ? flight.fareInfo.find(f => f.paxType === 'adult') : null;
    const child = Array.isArray(flight.fareInfo) ? flight.fareInfo.find(f => f.paxType === 'child') : null;

    const adult_prices = [
        parseInt(adult?.amount || 0),
        parseInt(adult?.fuel || 0),
        parseInt(adult?.tax || 0),
        parseInt(adult?.total || 0)
    ];

    const child_prices = [
        parseInt(child?.amount || 0),
        parseInt(child?.fuel || 0),
        parseInt(child?.tax || 0),
        parseInt(child?.total || 0)
    ];

    const reserve_info = daily_array.join('|') + '@' + adult_prices.join('|') + '@' + child_prices.join('|');

    const air_price = adult_prices[3] * adult_cnt + child_prices[3] * child_cnt;

    let html = '<tr id="sunmin_' + chg_gubun + '_' + i + '_' + j + '" class="' + chg_gubun + '_tr sunmin_tour" data-key="' + uniqueKey + '">';
    html += '<td><div class="l-area"><p class="ci"><img src="/images/web/air/line' + (com + 1) + '_big.png" alt="' + com_array[com] + '"></p></div>';
    html += '<div class="r-area"><p class="name">' + com_array[com] + '</p><p class="emph">' + flight.flight + flight.flightNumber + '편</p></div></td>';
    html += '<td class="time"><p class="sTime">' + depTime + '</p></td>';
    html += '<td class="time"><p class="eTime">' + arrTime + '</p></td>';
    html += '<td><p class="rating ' + (
            flight.classTypeNm.trim() === "특가석" ? "Special" :
            flight.classTypeNm.trim() === "할인석" ? "Sale" :
            flight.classTypeNm.trim() === "이벤트석" ? "Event" :
            flight.classTypeNm.trim() === "비즈니스석" ? "business" : ""
    ) + '">' + flight.classTypeNm + '</p></td>';
    html += '<td><p class="seat">' + flight.seatCount + '석</p></td>';
    html += '<td><p class="hide">$</p><p class="money">' + commaNum(air_price) + '</p><p class="unit">원</p></td>';
    html += '<td class="condition"><input id="air_' + chg_gubun + '_' + i + '_' + j + '" class="airCH1" type="radio" name="air_' + chg_gubun + '[]"';
    html += ' onclick="sunmin_apply_pay(\'' + chg_gubun + '\', \'' + reserve_info.replace(/'/g, "\\'") + '\', \'' + String(flight.q).replace(/'/g, "\\'") + '\', \'' + j + '\', \'' + flight.classTypeNm.replace(/'/g, "\\'") + '\', \'' + commaNum(air_price) + '\', \'' + (flight.isOpCar || '') + '\', \'' + (landingUrl || '') + '\');">';
    html += '<label for="air_' + chg_gubun + '_' + i + '_' + j + '">선민투어</label></td></tr>';

    $(containerId).append(html);
}

function sunmin_apply_pay(trip_type, reserve_info_str, rev_id, key, fare_type, total_pay, join_car_code, landing_url) {
    // 판매처 로고 노출
    $('#airLogoImg').removeClass('hide').attr("src", "/images/web/air/sunmin_tour_log.png");

    var air_bagic = "";
    var air_adult = "";
    var air_child = "";

    /** 1. 예약 정보 문자열을 '@' 기준으로 분리 */
    if (reserve_info_str) {
        var tmp_arr1 = reserve_info_str.split("@");
        air_bagic = tmp_arr1[0] || "";
        air_adult = tmp_arr1[1] || "0|0|0|0";
        air_child = tmp_arr1[2] || "0|0|0|0";
    }

    /** 2.기본정보 및 금액정보 '|' 기준으로 분리 */
    var air_bagic_info = air_bagic.split("|"); // 0. 출발일 /1.출발시간 /2. 출발도시코드 /3. 출발도시명/ 4.도착일 / 5. 도착시간 /6. 도착도시코드 / 7.도착도시명 / 8.항공사 코드 / 9.항공편 번호 / 10.com
    var air_adult_info = air_adult.split("|");
    var air_child_info = air_child.split("|");

    /** 3. 여정 출력용 HTML 구성 */
    var go_air_info = "<td>";
    go_air_info += '<span>[' + (trip_type === "go" ? '출발편' : '도착편') + ']</span>';
    go_air_info += '<span>' + air_bagic_info[3] + '</span>';
    go_air_info += '<span class="arrow add1">to</span>';
    go_air_info += '<span><strong>' + air_bagic_info[7] + '</strong></span>';
    go_air_info += '</td><td>';
    go_air_info += '<span>' + get_air_img(air_bagic_info[8]) + '</span> ';
    go_air_info += '<span>' + air_bagic_info[9] + '편</span>';

    /** 4. 공동운항 항공사 표시 */
    if (air_bagic_info[8] === "OZ" && join_car_code) {
        go_air_info += '<div class="tooltip-btn"><span>공동운항</span>';
        if (join_car_code === "BX") {
            go_air_info += '<p class="info-text busan"></p>';
        } else if (join_car_code === "RS") {
            go_air_info += '<p class="info-text seoul"></p>';
        }
        go_air_info += '</div>';
    }

    go_air_info += '</td>';
    go_air_info += '<td>' + air_bagic_info[0].replace(/-/g, '.') + ' ('+ get_yoil(air_bagic_info[0]) +') ' + air_bagic_info[1] + '</td>';
    go_air_info += '<td>' + air_bagic_info[4].replace(/-/g, '.') + ' ('+ get_yoil(air_bagic_info[4]) +') ' + air_bagic_info[5] + '</td>';
    go_air_info += '<td><p class="rating ' + (
        fare_type === "특가석" ? "Special" :
        fare_type === "할인석" ? "Sale" :
        fare_type === "이벤트석" ? "Event" :
        fare_type === "비즈니스석" ? "business" : ""
    ) + '">' + fare_type + '</p></td>';
    go_air_info += '<td><span>' + total_pay + '원</span></td>';

    var total_cnt = parseInt($("input[name=step2_adult_cnt]").val() || 0)
        + parseInt($("input[name=step2_child_cnt]").val() || 0)
        + parseInt($("input[name=step2_baby_cnt]").val() || 0);
    go_air_info += '<td><span>' + total_cnt + '석</span></td>';

    /** 5. 가격 정보 셋팅 */
    var applied_price = air_adult_info[0] + "|" + air_child_info[0];
    var add_price = air_adult_info[1] + "|" + air_child_info[1];
    var airport_price = air_adult_info[2] + "|" + air_child_info[2];
    var total_price = air_adult_info[3] + "|" + air_child_info[3];

    /** 6. 항공 정보 문자열 조합 (예약용) */
    var air_info_str = [
        air_bagic_info[8], //항공사 코드
        air_bagic_info[2], //출발도시코드
        air_bagic_info[6], //도착도시코드
        air_bagic_info[0].replace(/-/g, ''), //출발일
        air_bagic_info[1]?.replace(':', ''), //출발시간
        air_bagic_info[4].replace(/-/g, ''), //도착일
        air_bagic_info[5]?.replace(':', '')  //도착시간
    ];

    /** 7. 화면 적용 및 air_info_str 값 설정 */
    if (trip_type === "go") {
        $("div.journey table.commCol #choice_go_info").html(go_air_info);
        if ($("input[name=child_cnt]").val() >= 1) {
            price_apply("go", "1|1", applied_price, add_price, airport_price, total_price);
        } else {
            price_apply("go", "1|0", air_adult_info[0] + "|0", air_adult_info[1] + "|0", air_adult_info[2] + "|0", air_adult_info[3] + "|0");
        }
        $("input[name=landing_url]").val(landing_url);
        $("input[name=go_q]").val(rev_id);
        $("input[name=step2_go_air_info]").val(air_info_str.join("|"));

    } else if (trip_type === "come") {
        $("div.journey table.commCol #choice_come_info").html(go_air_info);
        if ($("input[name=child_cnt]").val() >= 1) {
            price_apply("come", "1|1", applied_price, add_price, airport_price, total_price);
        } else {
            price_apply("come", "1|0", air_adult_info[0] + "|0", air_adult_info[1] + "|0", air_adult_info[2] + "|0", air_adult_info[3] + "|0");
        }
        $("input[name=come_q]").val(rev_id);
        $("input[name=step2_come_air_info]").val(air_info_str.join("|"));
    }

    /** 8. 제이엘항공, 비활성화 처리 */
    if (g_trip_type !== "OW") {
        $('.sunmin_tour').removeClass('disabled').find('.airCH1').prop('disabled', false);
        $('.jl_air').addClass('disabled').find('.airCH1').prop('disabled', true).prop('checked', false);
        $('.come_tr.sunmin_tour').removeClass('hide');
        $('.come_tr.jl_air').addClass('hide');
    }

    /** 9. 선택 항공 음영 처리 */
    $('.' + trip_type + '_tr').removeClass("active");
    $('#sunmin_' + key).addClass("active");
}

// 제주닷컴 항공권 목록 요청
function air_service_jejucom_call(trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt)
{
	var search_coms = new Array();

    var seat_str = $('#air_ratingALL').prop('checked') ? '전체' : seat_types.toLowerCase().replace(/@/gi, '|').replace('s', 'd');

    // 제주닷컴 관련 항공사 이미지 로딩중 이미지로 변경
    for (var i=0, end=com_codes.length; i<end; i++){
        var search_coms = new Array();

        //if ($("#air_line" + com_codes[i]).is(":checked"))
        if ($('#airline_code').val() == 'ALL' || $('#airline_code').val() == com_codes[i])
        {
            search_coms = new Array();
            search_coms[search_coms.length] = com_codes[i];
            if (search_coms.length > 0)
                setting_air_tr("go", search_coms, seat_str, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt);
        }

        if ($('#airline_code').val() == 'ALL' || $('#airline_code').val() == com_codes[i])
        {
            search_coms = new Array();

            $(".rArea .jc_com li.air" + (i+1)).show();
            $(".rArea .jc_com li.air" + (i+1) + " img.load").attr("src","/images/web/air/loading.gif");

            search_coms[search_coms.length] = com_codes[i];
            /*// 각 항공사별 호출로 변경 (2017-07-31, By JDongS)
            if (search_coms.length > 0)
                setting_air_tr("come", search_coms, seat_str, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt);*/
        }
    }
//	setting_air_tr("go", search_coms, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt);
}

// 제주닷컴 항공권 추출
function setting_air_tr(gubun, search_coms, seat_str, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt)
{
    var air_com = search_coms.join('|');
    var params = "flight_com=" + air_com + "&flight_class=" + seat_str + "&flight_scity=" + start_area + "&flight_ecity=" + end_area + "&flight_adult=" + adult_cnt + "&flight_junior=" + child_cnt + "&flight_baby=" + baby_cnt + "&agt=tamnao&mode=json";
    params +="&flight_date=" + start_date
    if($("input[name=trip_type]:checked").val() == "RT"){
        params +="&flight_date2=" + end_date;
    }

    return $.ajax({
        type: "GET",
        url: "https://api.jeju.com/service/searchAirSingle.php",
        data: params,
        /*jsonpCallback: 'callback',*/
        contentType: "application/json",
        dataType: "jsonp",
        crossDomain: true,
        success: function(data){
            var seatArray = new Array($('#seat_type option:selected').text());
            /*$("input:checkbox[name='seat_type[]']:checked").each(function() {
                seatArray[seatArray.length] = $("label[for=air_rating" + $(this).val() + "]").text();
            });*/

            //var chg_gubun = data.params.flight_scity == $('#start_region').val() ? "go" : "come";

            var chg_gubun = "";

            chg_gubun = gubun;

            if(data.avail_list){
                $.each(data.avail_list, function(i,item){
                    i = i.replace(/ /g, '');

                    if (item.id == '' || item.is_rsv == '0' || ($.inArray('전체', seatArray) == -1 && $.inArray(item.class_desc, seatArray) == -1))
                        return true;

                    var com = $.inArray(item.car_code, com_codes);
                    var air_price = (parseInt(item.fare) + parseInt(item.fuel_tax) + parseInt(item.air_tax)) * adult_cnt + (parseInt(item.chd_fare) + parseInt(item.chd_fuel_tax) + parseInt(item.chd_air_tax)) * child_cnt;

                    /**  항공편 정보 { 항공 일정('|' 구분) @ 성인 요금 정보('|' 구분) @ 소아 요금 정보('|' 구분) } **/
                    var daily_array = new Array(item.dep_date, item.dep_day_desc, item.dep_desc, item.arr_desc, item.dep_time, item.car_code, item.main_flt, item.dep_city, item.arr_city, item.arr_date, item.arr_time);
                    var adult_prices = new Array(parseInt(item.fare), parseInt(item.fuel_tax), parseInt(item.air_tax), (parseInt(item.fare) + parseInt(item.fuel_tax) + parseInt(item.air_tax)));
                    var young_prices = new Array(parseInt(item.chd_fare), parseInt(item.chd_fuel_tax), parseInt(item.chd_air_tax), (parseInt(item.chd_fare) + parseInt(item.chd_fuel_tax) + parseInt(item.chd_air_tax)));
                    var reserve_info = daily_array.join('|') + "@" + adult_prices.join('|') + "@" + young_prices.join('|');

                    var html = '<tr id="jc_' + i + '" class="' + chg_gubun + '_tr jc_air">';
                    html += '	<td>';
                    html += '	   	<div class="l-area"><p class="ci"><img src="/images/web/air/line' + (com+1) + '_big.png" alt="' + com_array[com] + '"></p></div>';
                    html += '	   	<div class="r-area">';
                    html += '      		<p class="name">' + com_array[com] + '</p>';
                    if(item.main_flt) {
                        html += '	       	<p class="emph">' + item.main_flt + '편</p>';
                    }
                    html += '   	</div>';
                    html += '	</td>';
                    html += '	<td class="time">';
                    html += '		<p class="sTime">' + item.dep_time + '</p>';
                    html += '	</td>';
                    html += '	<td class="time">';
                    html += '		<p class="eTime">' + item.arr_time + '</p>';
                    html += '	</td>';
                    html += '	<td>';
                    if(item.class_desc == "특가석" || item.class_desc == "특별석"){
                        html += '		<p class="rating Special">';
                    }else if(item.class_desc == "할인석"){
                        html += '		<p class="rating Sale">';
                    }else if(item.class_desc == "이벤트석"){
                        html += '		<p class="rating Event">';
                    }else if(item.class_desc == "비즈니스석"){
                        html += '		<p class="rating business">';
                    }else{
                        html += '		<p class="rating">';
                    }
                    html += item.class_desc + '</p>';
                    // 2016-06-22 By jdongs@nextez.co.kr 아시아나 공동운항 추가
                    if (item.car_code == 'OZ' && $.inArray(item.join_car_code, new Array('BX', 'RS')) != -1) {
                        html += '	<div class="tooltip-btn">';
                        html += '		<span>공동운항</span>';
                        html += '		<p class="info-text seoul"></p>';
                        if (item.join_car_code == 'BX')
                            html += '	    <p class="info-text busan"></p>';	// 에어부산
                        else if (item.join_car_code == 'RS')
                            html += '	    <p class="info-text seoul"></p>';	// 에어서울
                        html += '	</div>';
                    }
                    html += '	</td>';
                    html += '	<td>';
                    html += '		<p class="seat">' + item.no_of_avail_seat + '석</p>';
                    html += '	</td>';
                    html += '	<td>';
                    html += '		<p class="hide">$</p>';
                    html += '		<p class="money">' + commaNum(air_price) + '</p>';
                    html += '		<p class="unit">원</p>';
                    html += '	</td>';
                    html += '	<td class="condition">';
                    html += '		<input id="air_' + chg_gubun + i + '" class="airCH1" type="radio" name="air_' + chg_gubun + '[]" onclick="jc_apply_pay(\'' + chg_gubun + '\', \'' + reserve_info + '\', \'' + item.id + '\', \'' + i + '\', \'' + item.class_desc + '\', \'' + commaNum(air_price) + '\', \'' + item.join_car_code + '\');">';
                    html += '		<label for="air_' + chg_gubun + i + '">제주닷컴</label>';
                    html += '	</td>';
                    html += '</tr>';

                    $("#" + chg_gubun + "_flight").append(html);
                });
            }

            chg_gubun = "come";

            if(data.avail_list2 && $("input[name=trip_type]:checked").val() == "RT"){
                $.each(data.avail_list2, function(i,item){
                    i = i.replace(/ /g, '');

                    if (item.id == '' || item.is_rsv == '0' || ($.inArray('전체', seatArray) == -1 && $.inArray(item.class_desc, seatArray) == -1))
                        return true;

                    var com = $.inArray(item.car_code, com_codes);
                    var air_price = (parseInt(item.fare) + parseInt(item.fuel_tax) + parseInt(item.air_tax)) * adult_cnt + (parseInt(item.chd_fare) + parseInt(item.chd_fuel_tax) + parseInt(item.chd_air_tax)) * child_cnt;

                    /**  항공편 정보 { 항공 일정('|' 구분) @ 성인 요금 정보('|' 구분) @ 소아 요금 정보('|' 구분) } **/
                    var daily_array = new Array(item.dep_date, item.dep_day_desc, item.dep_desc, item.arr_desc, item.dep_time, item.car_code, item.main_flt, item.dep_city, item.arr_city, item.arr_date, item.arr_time);
                    var adult_prices = new Array(parseInt(item.fare), parseInt(item.fuel_tax), parseInt(item.air_tax), (parseInt(item.fare) + parseInt(item.fuel_tax) + parseInt(item.air_tax)));
                    var young_prices = new Array(parseInt(item.chd_fare), parseInt(item.chd_fuel_tax), parseInt(item.chd_air_tax), (parseInt(item.chd_fare) + parseInt(item.chd_fuel_tax) + parseInt(item.chd_air_tax)));
                    var reserve_info = daily_array.join('|') + "@" + adult_prices.join('|') + "@" + young_prices.join('|');

                    var html = '<tr id="jc_' + i + '" class="' + chg_gubun + '_tr jc_air">';
                    html += '	<td>';
                    html += '	   	<div class="l-area"><p class="ci"><img src="/images/web/air/line' + (com+1) + '_big.png" alt="' + com_array[com] + '"></p></div>';
                    html += '	   	<div class="r-area">';
                    html += '      		<p class="name">' + com_array[com] + '</p>';
                    if(item.main_flt) {
                        html += '	       	<p class="emph">' + item.main_flt + '편</p>';
                    }
                    html += '   	</div>';
                    html += '	</td>';
                    html += '	<td class="time">';
                    html += '		<p class="sTime">' + item.dep_time + '</p>';
                    html += '	</td>';
                    html += '	<td class="time">';
                    html += '		<p class="eTime">' + item.arr_time + '</p>';
                    html += '	</td>';
                    html += '	<td>';
                    if(item.class_desc == "특가석" || item.class_desc == "특별석"){
                        html += '		<p class="rating Special">';
                    }else if(item.class_desc == "할인석"){
                        html += '		<p class="rating Sale">';
                    }else if(item.class_desc == "이벤트석"){
                        html += '		<p class="rating Event">';
                    }else if(item.class_desc == "비즈니스석"){
                        html += '		<p class="rating business">';
                    }else{
                        html += '		<p class="rating">';
                    }
                    html += item.class_desc + '</p>';
                    // 2016-06-22 By jdongs@nextez.co.kr 아시아나 공동운항 추가
                    if (item.car_code == 'OZ' && $.inArray(item.join_car_code, new Array('BX', 'RS')) != -1) {
                        html += '	<div class="tooltip-btn">';
                        html += '		<span>공동운항</span>';
                        html += '		<p class="info-text seoul"></p>';
                        if (item.join_car_code == 'BX')
                            html += '	    <p class="info-text busan"></p>';	// 에어부산
                        else if (item.join_car_code == 'RS')
                            html += '	    <p class="info-text seoul"></p>';	// 에어서울
                        html += '	</div>';
                    }
                    html += '	</td>';
                    html += '	<td>';
                    html += '		<p class="seat">' + item.no_of_avail_seat + '석</p>';
                    html += '	</td>';
                    html += '	<td>';
                    html += '		<p class="hide">$</p>';
                    html += '		<p class="money">' + commaNum(air_price) + '</p>';
                    html += '		<p class="unit">원</p>';
                    html += '	</td>';
                    html += '	<td class="condition">';

                    html += '		<input id="air_' + chg_gubun + i + '" class="airCH1" type="radio" name="air_' + chg_gubun + '[]" onclick="jc_apply_pay(\'' + chg_gubun + '\', \'' + reserve_info + '\', \'' + item.id + '\', \'' + i + '\', \'' + item.class_desc + '\', \'' + commaNum(air_price) + '\', \'' + item.join_car_code + '\');">';
                    html += '		<label for="air_' + chg_gubun + i + '">제주닷컴</label>';
                    html += '	</td>';
                    html += '</tr>';

                    $("#" + chg_gubun + "_flight").append(html);
                });
            }
        },
        complete : function(data) {
            // 이미지 로딩완료 이미지로 변경
            var loding_key = '';
            for (var i=0, end=com_codes.length; i<end; i++)
            {
                if (com_codes[i] == air_com) {
                    loding_key = i + 1;
                    break;
                }
            }

            //항공편 정렬이벤트 갱신
            if ($('.' + gubun + '_tr').length != 0) {
                //var sorting = [[1,0]];
                $(".air-line").trigger("update");

                //리스트 소팅
                list_sorting();
            }
        },
        error : function(xhr, status, error) {
            //alert("에러발생 : " + xhr.responseText + " ; " + status + " ; " + error);
            // 이미지 로딩완료 이미지로 변경
            var loding_key = '';
            for (var i=0, end=com_codes.length; i<end; i++)
            {
                if (com_codes[i] == air_com) {
                    loding_key = i + 1;
                    break;
                }
            }
        }
    });
}

//리스트 소팅
function list_sorting()
{
    //목록을 추가한 후 바로 소팅을 하게 되면 정상적으로 되지 않아서
    //1초의 시간을 두고 소팅을 시킨다.
    setTimeout(function(){
        $(".air-line").trigger("sorton",[ [[1,0], [5,0], [6,0]] ]);		// 탑승시간, 요금, 업체 정렬
    }, 300);
}

// 예약확인 바로가기
function goto_direct_confirm(o) {
    if (o.value != '')
    {
        window.open(o.value, '');
    }
}

//항공사별 정보 파싱
function get_air_reserve_info(airline, air_info)
{
    /* 최종형태
    * 항공사코드|출발지코드|도착지코드|출발일자|출발시간|도착일자|도착시간|요금타입|좌석수|항공기번호
    * |출발일자(UTC-협정세계시간)|항공편구분문자|운영캐리어 코드|출발협정시간|출발지시간대|도착협정시간|도착지시간대|여행시간|여행경유|도착/출발일자차이
    * |좌석클래스|비행상태|항공기종류|항공기버전|isThroughFlight|isDeiExists|isIropIndicator|isDisplayableDeiExists
    * @성인기본요금|성인적용요금|성인표시요금|성인재세공과금|성인유류|성인총요금|성인요금기본코드|성인요금클래스|성인요금트렌젝션아이디
    * @소아기본요금|소아적용요금|소아표시요금|소아재세공과금|소아유류|소아총요금|소아요금기본코드|소아요금클래스|소아요금트렌젝션아이디
    */

    var reserve_info = air_info.air_line;					//항공사코드
    reserve_info += "|" + air_info.air_s_region;		//출발지코드
    reserve_info += "|" + air_info.air_e_region;		//도착지코드
    reserve_info += "|" + air_info.air_s_date;			//출발일자
    reserve_info += "|" + air_info.air_s_time;			//출발시간
    reserve_info += "|" + air_info.air_e_date;			//도착일자
    reserve_info += "|" + air_info.air_e_time;			//도착시간
    reserve_info += "|" + air_info.adult_fare_type;		//요금타입(성인, 소아 같다)
    reserve_info += "|" + air_info.air_seat_cnt;		//좌석수
    reserve_info += "|" + air_info.adult_number;		//항공기번호(성인, 소아 같다)

    //티웨이항공이면, 진에어이면
    if(airline == "TW" || airline == "LJ")
    {
        //일반정보

        //티웨이 추가
        reserve_info += "|" + air_info.air_flightDate;		//출발일자(UTC-협정세계시간)
        reserve_info += "|" + air_info.air_fltSuffix;		//항공편구분하는데 사용
        reserve_info += "|" + air_info.air_carrierCode;		//운영캐리어 코드

        reserve_info += "|" + air_info.air_scheduledDepartureDateTime;		//출발협정시간
        reserve_info += "|" + air_info.air_DepartureTimeZone;				//출발지의 시간대
        reserve_info += "|" + air_info.air_scheduledArrivalTime;			//도착협정시간
        reserve_info += "|" + air_info.air_ArrivalTimeZone;					//도착지의 시간대
        reserve_info += "|" + air_info.air_journeyTime;						//여힝시간
        reserve_info += "|" + air_info.air_stops;							//여행중지(경유지 갯수?)
        reserve_info += "|" + air_info.air_arrivalDayChange;				//도착/출발 날짜의 차이
        reserve_info += "|" + air_info.air_CabinClass;						//좌석 클래스
        reserve_info += "|" + air_info.air_FlightStatus;					//비행상태
        reserve_info += "|" + air_info.air_AircraftType;					//항공기종류
        reserve_info += "|" + air_info.air_AircraftVersion;					//항공기버전
        reserve_info += "|" + air_info.air_isThroughFlight;						//isThroughFlight
        reserve_info += "|" + air_info.air_isDeiExists;							//isDeiExists
        reserve_info += "|" + air_info.air_isIropIndicator;						//isIropIndicator
        reserve_info += "|" + air_info.air_isDisplayableDeiExists;				//isDisplayableDeiExists

        //성인요금정보
        reserve_info += "@" + air_info.adult_base_fare;		//성인기본요금
        reserve_info += "|" + air_info.adult_applied_fare;	//성인적용요금
        reserve_info += "|" + air_info.adult_display_fare;	//성인표시요금
        reserve_info += "|" + air_info.adult_tax;			//성인재세공과금
        reserve_info += "|" + air_info.adult_sur_charge;	//성인유류
        reserve_info += "|" + air_info.adult_total_pay;		//성인총요금

        //티웨이 추가
        reserve_info += "|" + air_info.adult_bagic_code;	//성인요금기본코드
        reserve_info += "|" + air_info.adult_fare_class;	//성인요금클래스
        reserve_info += "|" + air_info.adult_transcition_id;//성인요금트렌젝션아이디


        //소아요금정보
        reserve_info += "@" + air_info.child_base_fare;		//소아기본요금
        reserve_info += "|" + air_info.child_applied_fare;	//소아적용요금
        reserve_info += "|" + air_info.child_display_fare;	//소아표시요금
        reserve_info += "|" + air_info.child_tax;			//소아재세공과금
        reserve_info += "|" + air_info.child_sur_charge;	//소아유류
        reserve_info += "|" + air_info.child_total_pay;		//소아총요금

        //티웨이 추가
        reserve_info += "|" + air_info.child_bagic_code;	//성인요금기본코드
        reserve_info += "|" + air_info.child_fare_class;	//성인요금클래스
        reserve_info += "|" + air_info.child_transcition_id;//소아요금트렌젝션아이

        //진에어이면
        if(airline == "LJ")	{
            reserve_info += '@' + air_info.air_TripIndex
                + "|" + air_info.air_SegmentIndex
                + "|" + air_info.air_FareId
                + "|" + air_info.air_SegmentRefIndex
                + "|" + air_info.air_PricingUnitID
                + "|" + air_info.air_PricingComponentIndex;
        }
    }
    //아시아나이면
    else if(airline == "OZ")
    {
        //일반정보
        reserve_info += "|" + air_info.air_joint;		//아시아나 공동운항(BX : 에어부산, RS : 에어서울)
        //성인요금정보
        reserve_info += "@" + air_info.adult_base_fare;		//성인기본요금
        reserve_info += "|" + air_info.adult_applied_fare;	//성인적용요금
        reserve_info += "|" + air_info.adult_display_fare;	//성인표시요금
        reserve_info += "|" + air_info.adult_tax;			//성인재세공과금
        reserve_info += "|" + air_info.adult_sur_charge;	//성인유류
        reserve_info += "|" + air_info.adult_total_pay;		//성인총요금

        //소아요금정보
        reserve_info += "@" + air_info.child_base_fare;		//소아기본요금
        reserve_info += "|" + air_info.child_applied_fare;	//소아적용요금
        reserve_info += "|" + air_info.child_display_fare;	//소아표시요금
        reserve_info += "|" + air_info.child_tax;			//소아재세공과금
        reserve_info += "|" + air_info.child_sur_charge;	//소아유류
        reserve_info += "|" + air_info.child_total_pay;		//소아총요금
    }
    //제주항공이면
    else if(airline == "7C")
    {
        //일반정보

        //제주항공 추가
        reserve_info += "|" + air_info.air_FareAvailabilityKey;
        reserve_info += "|" + air_info.air_journeyKey;
        reserve_info += "|" + air_info.adult_fare_class;	//성인요금클래스
        //성인요금정보
        reserve_info += "@" + air_info.adult_base_fare;		//성인기본요금
        reserve_info += "|" + air_info.adult_applied_fare;	//성인적용요금
        reserve_info += "|" + air_info.adult_display_fare;	//성인표시요금
        reserve_info += "|" + air_info.adult_tax;			//성인재세공과금
        reserve_info += "|" + air_info.adult_sur_charge;	//성인유류
        reserve_info += "|" + air_info.adult_total_pay;		//성인총요금

        //소아요금정보
        reserve_info += "@" + air_info.child_base_fare;		//소아기본요금
        reserve_info += "|" + air_info.child_applied_fare;	//소아적용요금
        reserve_info += "|" + air_info.child_display_fare;	//소아표시요금
        reserve_info += "|" + air_info.child_tax;			//소아재세공과금
        reserve_info += "|" + air_info.child_sur_charge;	//소아유류
        reserve_info += "|" + air_info.child_total_pay;		//소아총요금
    }
    //이스타항공이면
    else if (airline === "ZE")
    {
        reserve_info += "|" + air_info.air_JourneySellKey;
        reserve_info += "|" + air_info.air_FareSellKey;

        //성인요금정보
        reserve_info += "@" + air_info.adult_base_fare;		//성인기본요금
        reserve_info += "|" + air_info.adult_applied_fare;	//성인적용요금
        reserve_info += "|" + air_info.adult_display_fare;	//성인표시요금
        reserve_info += "|" + air_info.adult_tax;			//성인재세공과금
        reserve_info += "|" + air_info.adult_sur_charge;	//성인유류
        reserve_info += "|" + air_info.adult_total_pay;		//성인총요금

        //소아요금정보
        reserve_info += "@" + air_info.child_base_fare;		//소아기본요금
        reserve_info += "|" + air_info.child_applied_fare;	//소아적용요금
        reserve_info += "|" + air_info.child_display_fare;	//소아표시요금
        reserve_info += "|" + air_info.child_tax;			//소아재세공과금
        reserve_info += "|" + air_info.child_sur_charge;	//소아유류
        reserve_info += "|" + air_info.child_total_pay;		//소아총요금
    }

    return reserve_info;
}

//선택한 항공편 정보 셋팅
function apply_pay(trip_type, reserve_info_str, key, fare_type, total_pay, air_joint)
{
    /* 최종형태
    * 항공사코드|출발지코드|도착지코드|출발일자|출발시간|도착일자|도착시간|요금타입|좌석수|항공기번호
    * @성인기본요금|성인적용요금|성인표시요금|성인재세공과금|성인유류|성인총요금
    * @소아기본요금|소아적용요금|소아표시요금|소아재세공과금|소아유류|소아총요금
    */

    // 판매처 출력
    $('#airLogoImg').removeClass('hide').attr("src", "/images/web/air/jl2.png");

    var air_bagic = "";
    var air_adult = "";
    var air_child = "";

    //1. 기본정보, 성인가격, 소인가격 분리
    if(reserve_info_str)
    {
        var tmp_arr1 = reserve_info_str.split("@");

        air_bagic = tmp_arr1[0];
        air_adult = tmp_arr1[1];
        air_child = tmp_arr1[2];
    }

    //2. 기본정보 분리
    var air_bagic_info = air_bagic.split("|");

    //3. 성인가격정보 분리
    var air_adult_info = air_adult.split("|");

    //4. 소인가격정보 분리
    var air_child_info = air_child.split("|");

    //선택여정에 출력할 내용
    //2015-09-14(월) 김포 > 제주 06:15 <img src="/images/web/air/line2.gif" alt="아시아나"> 아시아나 8901편
    var go_air_info = "";
    go_air_info += '<td>';
    if(trip_type == "go"){
        go_air_info += '<span>[출발편]</span>';
    }else{
        go_air_info += '<span>[도착편]</span>';
    }
    go_air_info += '<span>' + get_airport_name(air_bagic_info[1]) + '</span>';
    go_air_info += '<span class="arrow add1">to</span>';
    go_air_info += '<span><strong>'+ get_airport_name(air_bagic_info[2]) +'</strong></span>';
    go_air_info += '</td>';
    go_air_info += '<td>';
    go_air_info += '<span>' + get_air_img(air_bagic_info[0]) + '</span>' + ' ';
    go_air_info += '<span>' + air_bagic_info[9] + '편 </span>';
    if( air_bagic_info[0] == "OZ" && !air_joint){
        go_air_info += '<div class="tooltip-btn">';
        go_air_info += '<span>공동운항</span>';
        if(air_joint == "BX"){
            go_air_info += '<p class="info-text busan"></p>'; // 에어부산
        }else if(air_joint == "RS"){
            go_air_info += '<p class="info-text seoul"></p>'; // 에어서울
        }
        go_air_info += '</div>';
    }
    go_air_info += '</td>';

    var sdate = air_bagic_info[3].substr(0, 4) + "." + air_bagic_info[3].substr(4, 2) + "." + air_bagic_info[3].substr(6, 2);
    go_air_info += '<td>' + sdate + " (" + get_yoil(sdate) + ") " +  air_bagic_info[4].substr(0, 2) + ":" + air_bagic_info[4].substr(2, 2) + '</td>';

    var cdate = air_bagic_info[5].substr(0, 4) + "." + air_bagic_info[5].substr(4, 2) + "." + air_bagic_info[5].substr(6, 2);
    go_air_info += '<td>' + cdate + " (" + get_yoil(cdate) + ") " +  air_bagic_info[6].substr(0, 2) + ":" + air_bagic_info[6].substr(2, 2) + '</td>';

    go_air_info += '<td>';
    if(fare_type == "특가석" || fare_type == "특별석"){
        go_air_info += '		<p class="rating Special">';
    }else if(fare_type == "할인석"){
        go_air_info += '		<p class="rating Sale">';
    }else if(fare_type == "이벤트석"){
        go_air_info += '		<p class="rating Event">';
    }else if(fare_type == "비즈니스석"){
        go_air_info += '		<p class="rating business">';
    }else{
        go_air_info += '		<p class="rating">';
    }
    go_air_info += fare_type + '</td>';

    go_air_info += '<td><span>' + total_pay + '원</span></td>';
    var total_cnt = eval($("input[name=step2_adult_cnt]").val()) + eval($("input[name=step2_child_cnt]").val()) + eval($("input[name=step2_baby_cnt]").val());
    go_air_info += '<td><span>'+ total_cnt +'석</span></td>';

    //가격정보 셋팅
    var applied_price = air_adult_info[1] + "|" + air_child_info[1];
    var add_price = air_adult_info[4] + "|" + air_child_info[4];
    var airport_price = air_adult_info[3] + "|" + air_child_info[3];
    var total_price = air_adult_info[5] + "|" + air_child_info[5];


    //가는편이면
    if(trip_type == "go")
    {
        $("div.journey table.commCol #choice_go_info").html(go_air_info);
        if($("input[name=child_cnt]").val() >= 1){
            price_apply("go","1|1", applied_price,add_price,airport_price,total_price);
        }else{
            price_apply("go","1|0", air_adult_info[1]+"|0",air_adult_info[4]+"|0",air_adult_info[3]+"|0",air_adult_info[5]+"|0");
        }

        $("input[name=step2_go_air_info]").val(reserve_info_str);
    }
    //오는편이면
    else if(trip_type == "come")
    {
        $("div.journey table.commCol #choice_come_info").html(go_air_info);
        if($("input[name=child_cnt]").val() >= 1){
            price_apply("come","1|1", applied_price,add_price,airport_price,total_price);
        }else{
            price_apply("come","1|0", air_adult_info[1]+"|0",air_adult_info[4]+"|0",air_adult_info[3]+"|0",air_adult_info[5]+"|0");
        }

        $("input[name=step2_come_air_info]").val(reserve_info_str);
    }

    // 제주닷컴, 선민투어 항공 비활성화 처리
    if(g_trip_type != "OW") {
        $('.jl_air').removeClass('disabled').find('.airCH1').prop('disabled', false);
        $('.jc_air').addClass('disabled').find('.airCH1').prop('disabled', true).prop('checked', false);
        $('.sunmin_tour').addClass('disabled').find('.airCH1').prop('disabled', true).prop('checked', false);
        $('.come_tr.jl_air').removeClass('hide');
        $('.come_tr.jc_air').addClass('hide');
        $('.come_tr.sunmin_tour').addClass('hide');
    }

    // 선택한 항공 음영 처리
    $('.' + trip_type + '_tr').removeClass("active");
    $('#jl_' + key).addClass("active");
}

//선택한 제주닷컴 항공편 정보 셋팅
function jc_apply_pay(trip_type, reserve_info_str, rev_id, key, fare_type, total_pay, join_car_code)
{
    /* 최종형태
    * 일자|요일|출발지|도착지|출발시간|항공사 코드|항공기번호
    * @성인적용요금|성인유류할증료|성인공항이용료|성인총요금
    * @소아적용요금|소아유류할증료|소아공항이용료|소아총요금
    */

    // 판매처 출력
    $('#airLogoImg').removeClass('hide').attr("src", "/images/web/air/jejucom.png");

    var air_bagic = "";
    var air_adult = "";
    var air_child = "";

    //1. 기본정보, 성인가격, 소인가격 분리
    if(reserve_info_str)
    {
        var tmp_arr1 = reserve_info_str.split("@");

        air_bagic = tmp_arr1[0];
        air_adult = tmp_arr1[1];
        air_child = tmp_arr1[2];
    }

    //2. 기본정보 분리
    var air_bagic_info = air_bagic.split("|");

    //3. 성인가격정보 분리
    var air_adult_info = air_adult.split("|");

    //4. 소인가격정보 분리
    var air_child_info = air_child.split("|");

    //선택여정에 출력할 내용
    //2015-09-14(월) 김포 > 제주 06:15 <img src="/images/web/air/line2.gif" alt="아시아나"> 아시아나 8901편
    var go_air_info = "";
    go_air_info += '<td>';
    if(trip_type == "go"){
        go_air_info += '<span>[출발편]</span>';
    }else{
        go_air_info += '<span>[도착편]</span>';
    }
    go_air_info += '<span>' + air_bagic_info[2] + '</span>';
    go_air_info += '<span class="arrow add1">to</span>';
    go_air_info += '<span><strong>'+ air_bagic_info[3] +'</strong></span>';
    go_air_info += '</td>';
    go_air_info += '<td>';
    go_air_info += '<span>' + get_air_img(air_bagic_info[5]) + '</span>' + ' ';
    go_air_info += '<span>' + air_bagic_info[6] + '편 </span>';
    if( air_bagic_info[5] == "OZ" && !join_car_code){
        go_air_info += '<div class="tooltip-btn">';
        go_air_info += '<span>공동운항</span>';
        if(join_car_code == "BX"){
            go_air_info += '<p class="info-text busan"></p>'; // 에어부산
        }else if(join_car_code == "RS"){
            go_air_info += '<p class="info-text seoul"></p>'; // 에어서울
        }
        go_air_info += '</div>';
    }

    go_air_info += '</td>';
    go_air_info += '<td>' + air_bagic_info[0].replace(/-/g,'.') + " (" + air_bagic_info[1] + ") " + air_bagic_info[4] + '</td>';
    go_air_info += '<td>' + air_bagic_info[9].replace(/-/g,'.') + " (" + air_bagic_info[1] + ") " + air_bagic_info[10] + '</td>';

    go_air_info += '<td>';
    if(fare_type == "특가석" || fare_type == "특별석"){
        go_air_info += '		<p class="rating Special">';
    }else if(fare_type == "할인석"){
        go_air_info += '		<p class="rating Sale">';
    }else if(fare_type == "이벤트석"){
        go_air_info += '		<p class="rating Event">';
    }else if(fare_type == "비즈니스석"){
        go_air_info += '		<p class="rating business">';
    }else{
        go_air_info += '		<p class="rating">';
    }
    go_air_info += fare_type + '</td>';

    go_air_info += '<td><span>' + total_pay + '원</span></td>';
    var total_cnt = eval($("input[name=step2_adult_cnt]").val()) + eval($("input[name=step2_child_cnt]").val()) + eval($("input[name=step2_baby_cnt]").val());
    go_air_info += '<td><span>'+ total_cnt +'석</span></td>';

    //가격정보 셋팅
    var applied_price = air_adult_info[0] + "|" + air_child_info[0];
    var add_price = air_adult_info[1] + "|" + air_child_info[1];
    var airport_price = air_adult_info[2] + "|" + air_child_info[2];
    var total_price = air_adult_info[3] + "|" + air_child_info[3];

    //TW|GMP|CJU|20151212|1025|20151212|1130
    var air_info_str = new Array(air_bagic_info[5], air_bagic_info[7], air_bagic_info[8], air_bagic_info[0].replace(/-/g,''), air_bagic_info[4].replace(':', ''), air_bagic_info[9].replace(/-/g,''), air_bagic_info[10].replace(':', ''));

    //가는편이면
    if(trip_type == "go")
    {
        $("div.journey table.commCol #choice_go_info").html(go_air_info);
        if($("input[name=child_cnt]").val() >= 1){
            price_apply("go","1|1",applied_price,add_price,airport_price,total_price);
        }else{
            price_apply("go","1|0",air_adult_info[0]+"|0",air_adult_info[1]+"|0",air_adult_info[2]+"|0",air_adult_info[3]+"|0");
        }

        $("input[name=id_1]").val(rev_id);
        $("input[name=step2_go_air_info]").val(air_info_str.join("|"));
    }
    //오는편이면
    else if(trip_type == "come")
    {
        $("div.journey table.commCol #choice_come_info").html(go_air_info);
        if($("input[name=child_cnt]").val() >= 1){
            price_apply("come","1|1",applied_price,add_price,airport_price,total_price);
        }else{
            price_apply("come","1|0",air_adult_info[0]+"|0",air_adult_info[1]+"|0",air_adult_info[2]+"|0",air_adult_info[3]+"|0");
        }

        $("input[name=id_2]").val(rev_id);
        $("input[name=step2_come_air_info]").val(air_info_str.join("|"));
    }
    // 제이엘 항공 비활성화 처리
    if(g_trip_type != "OW") {
        $('.jc_air').removeClass('disabled').find('.airCH1').prop('disabled', false);
        $('.jl_air').addClass('disabled').find('.airCH1').prop('disabled', true).prop('checked', false);
        $('.come_tr.jc_air').removeClass('hide');
        $('.come_tr.jl_air').addClass('hide');
    }

    // 선택한 항공 음영 처리
    $('.' + trip_type + '_tr').removeClass("active");
    $('#jc_' + key).addClass("active");
}

// 항공권 다시 선택
function air_choice_reset()
{
    $('#airLogoImg').addClass('hide');
    $('.airCH1').prop('checked', false);
    $('.jl_air').removeClass('disabled').find('.airCH1').prop('disabled', false);
    $('.jc_air').removeClass('disabled').find('.airCH1').prop('disabled', false);
    $('.sunmin_tour').removeClass('disabled').find('.airCH1').prop('disabled', false);

    $('.come_tr.jc_air').removeClass('hide');
    $('.come_tr.jl_air').removeClass('hide');
    $('.come_tr.sunmin_tour').removeClass('hide');

    //선택항공권정보 초기화
    $("input[name=step2_go_air_info]").val("");
    $("input[name=step2_come_air_info]").val("");
    $("#choice_air_info div.go h4 span:eq(0)").html('＊ 1인 기준 요금입니다.');
    $("#choice_air_info div.come h4 span:eq(0)").html('');

    // 값 정보 초기화
    if($("input[name=child_cnt]").val() >=1 ){
        price_apply("go","1|1","0|0","0|0","0|0","0|0");
        price_apply("come","1|1","0|0","0|0","0|0","0|0");
    }else{
        price_apply("go","1|0","0|0","0|0","0|0","0|0");
        price_apply("come","1|0","0|0","0|0","0|0","0|0");
    }

    //항공검색목록 초기화
    var begin_info = "";
    begin_info += '<td id="choice_go" colspan="7">';
    begin_info += '<span>출발편을 선택해 주세요.</span>';
    begin_info += '</td>';
    $("div.journey table.commCol #choice_go_info").html(begin_info);

    begin_info = "";
    begin_info += '<td id="choice_come" colspan="7">';
    begin_info += '<span>도착편을 선택해 주세요.</span>';
    begin_info += '</td>';
    $("div.journey table.commCol #choice_come_info").html(begin_info);

    // 선택한 항공 음영 해제
    $('.go_tr').removeClass("active");
    $('.come_tr').removeClass("active");
}


//날짜에서 요일정보 추출
function get_yoil(date_str)
{
    var yy = parseInt(date_str.substr(0, 4), 10);
    var mm = parseInt(date_str.substr(5, 2), 10);
    var dd = parseInt(date_str.substr(8), 10);

    var d = new Date(yy,mm - 1, dd);
    var weekday=new Array(7);
    weekday[0]="일";
    weekday[1]="월";
    weekday[2]="화";
    weekday[3]="수";
    weekday[4]="목";
    weekday[5]="금";
    weekday[6]="토";

    return weekday[d.getDay()];
}

//공항코드로 공항명칭 추출
function get_airport_name(airport)
{
    if(airport == "GMP")
    {
        return "김포";
    }
    else if(airport == "CJU")
    {
        return "제주";
    }
    else if(airport == "PUS")
    {
        return "부산";
    }
    else if(airport == "TAE")
    {
        return "대구";
    }
    else if(airport == "KWJ")
    {
        return "광주";
    }
    else if(airport == "CJJ")
    {
        return "청주";
    }
    else if(airport == "MWX")
    {
        return "무안";
    }
    else if(airport == "RSU")
    {
        return "여수";
    }
    else if(airport == "USN")
    {
        return "울산";
    }
    else if(airport == "HIN")
    {
        return "진주";
    }
    else if(airport == "KUV")
    {
        return "군산";
    }
    else if(airport == "KPO")
    {
        return "포항";
    }
    else if(airport == "WJU")
    {
        return "원주";
    }

    //2016-03-21 아시아나 추가 하면서 추가됨 (ksb1110@gmail.com)
    else if(airport == "ICN")
    {
        return "인천";
    }
}

//항공사코드로 이미지정보 추출
function get_air_img(airline)
{
    var img = "";

    //대한항공
    if(airline == "KE")
    {
        img = "<img src='/images/web/air/line1.gif' alt='대한항공'> 대한항공";
    }
    //아시아나
    else if(airline == "OZ")
    {
        img = "<img src='/images/web/air/line2.gif' alt='아시아나'> 아시아나";
    }
    //진에어
    else if(airline == "LJ")
    {
        img = "<img src='/images/web/air/line3.gif' alt='진에어'> 진에어";
    }
    //에어부산
    else if(airline == "BX")
    {
        img = "<img src='/images/web/air/line4.gif' alt='에어부산'> 에어부산";
    }
    //이스타항공
    else if(airline == "ZE")
    {
        img = "<img src='/images/web/air/line5.gif' alt='이스타항공'> 이스타항공";
    }
    //티웨이항공
    else if(airline == "TW")
    {
        img = "<img src='/images/web/air/line6.gif' alt='티웨이항공'> 티웨이항공";
    }
    //제주항공
    else if(airline == "7C")
    {
        img = "<img src='/images/web/air/line7.gif' alt='제주항공'> 제주항공";
    }
    //에어서울
    else if(airline == "RS")
    {
        img = "<img src='/images/web/air/line8.gif' class='airline' alt='에어서울'> 에어서울";
    }
    //플라이강원
    else if(airline == "4V")
    {
        img = "<img src='/images/web/air/line9.gif' class='airline' alt='플라이강원'> 플라이강원";
    }
    //에어로케이
    else if(airline == "RF") {
        img = "<img src='/images/web/air/line10.gif' class='airline' alt='에어로케이'> 에어로케이";
    }


    return img;
}

//선택한 항공편 가격정보 셋팅
//trip_type : 가는편, 오는편 구분 (go, come)
//people_cnt_arr : 성인수, 소아수 ("1|0")
//applied_price_arr : 성인항공적용운임, 소아항공적용운임 ("71000|6000")
//add_price_arr : 성인유류할증료, 소아유류할증료 ("2200|2200")
//airport_price_arr : 성인공항이용료, 소아공항이용료 ("4000|2000")
//total_price_arr : 성인총액, 소아총액 ("77200|66900")
function price_apply(trip_type, people_cnt_arr, applied_price_arr, add_price_arr, airport_price_arr, total_price_arr)
{
    //인원수 분리
    var tmp_people_cnt = people_cnt_arr.split("|");
    var adult_cnt = tmp_people_cnt[0];
    var child_cnt = tmp_people_cnt[1];

    //항공운임 분리
    var tmp_applied_price = applied_price_arr.split("|");
    var adult_applied_price = tmp_applied_price[0];
    var child_applied_price = tmp_applied_price[1];

    //유류할증료 분리
    var tmp_add_price = add_price_arr.split("|");
    var adult_add_price = tmp_add_price[0];
    var child_add_price = tmp_add_price[1];

    //공항이용료 분리
    var tmp_airport_price = airport_price_arr.split("|");
    var adult_airport_price = tmp_airport_price[0];
    var child_airport_price = tmp_airport_price[1];

    //총액 분리
    var tmp_total_price = total_price_arr.split("|");
    var adult_total_price = tmp_total_price[0];
    var child_total_price = tmp_total_price[1];

    //가는편인 경우
    if(trip_type == "go")
    {
        $("#choice_air_info div.go table tbody tr:eq(0) td:eq(0)").html("성인");
        $("#choice_air_info div.go table tbody tr:eq(0) td:eq(1)").html(formatNumber(adult_applied_price) + "원");
        $("#choice_air_info div.go table tbody tr:eq(0) td:eq(2)").html(formatNumber(adult_add_price) + "원");
        $("#choice_air_info div.go table tbody tr:eq(0) td:eq(3)").html(formatNumber(adult_airport_price) + "원");
        $("#choice_air_info div.go table tbody tr:eq(0) td:eq(4)").html("0원");
        $("#choice_air_info div.go table tbody tr:eq(0) td:eq(4)").addClass("tc");
        $("#choice_air_info div.go table tbody tr:eq(0) td:eq(5)").html("1명");
        $("#choice_air_info div.go table tbody tr:eq(0) td:eq(6)").html(formatNumber(adult_total_price) + "원");
        $("#choice_air_info div.go table tbody tr:eq(0) td:eq(6)").addClass("tc");


        $("#choice_air_info div.go table tbody tr:eq(1) td:eq(0)").html("소아");
        $("#choice_air_info div.go table tbody tr:eq(1) td:eq(1)").html(formatNumber(child_applied_price) + "원");
        $("#choice_air_info div.go table tbody tr:eq(1) td:eq(2)").html(formatNumber(child_add_price) + "원");
        $("#choice_air_info div.go table tbody tr:eq(1) td:eq(3)").html(formatNumber(child_airport_price) + "원");
        $("#choice_air_info div.go table tbody tr:eq(1) td:eq(4)").html("0원");
        $("#choice_air_info div.go table tbody tr:eq(1) td:eq(6)").html(formatNumber(child_total_price) + "원");
        if(child_cnt >= 1){
            $("#choice_air_info div.go table tbody tr:eq(1) td:eq(4)").addClass("tc");
            $("#choice_air_info div.go table tbody tr:eq(1) td:eq(5)").html("1명");
            $("#choice_air_info div.go table tbody tr:eq(1) td:eq(6)").addClass("tc");
        }else{
            $("#choice_air_info div.go table tbody tr:eq(1) td:eq(4)").removeClass("tc");
            $("#choice_air_info div.go table tbody tr:eq(1) td:eq(5)").html("0명");
            $("#choice_air_info div.go table tbody tr:eq(1) td:eq(6)").removeClass("tc");
        }

        //계산용 가격 input 셋팅
        $("input[name=go_adult_total_price]").val(adult_total_price);
        $("input[name=go_child_total_price]").val(child_total_price);
    }
    //오는편인 경우
    else if(trip_type == "come")
    {
        $("#choice_air_info div.come table tbody tr:eq(0) td:eq(0)").html("성인");
        $("#choice_air_info div.come table tbody tr:eq(0) td:eq(1)").html(formatNumber(adult_applied_price) + "원");
        $("#choice_air_info div.come table tbody tr:eq(0) td:eq(2)").html(formatNumber(adult_add_price) + "원");
        $("#choice_air_info div.come table tbody tr:eq(0) td:eq(3)").html(formatNumber(adult_airport_price) + "원");
        $("#choice_air_info div.come table tbody tr:eq(0) td:eq(4)").html("0원");
        $("#choice_air_info div.come table tbody tr:eq(0) td:eq(4)").addClass("tc");
        $("#choice_air_info div.come table tbody tr:eq(0) td:eq(5)").html("1명");
        $("#choice_air_info div.come table tbody tr:eq(0) td:eq(6)").html(formatNumber(adult_total_price) + "원");
        $("#choice_air_info div.come table tbody tr:eq(0) td:eq(6)").addClass("tc");

        $("#choice_air_info div.come table tbody tr:eq(1) td:eq(0)").html("소아");
        $("#choice_air_info div.come table tbody tr:eq(1) td:eq(1)").html(formatNumber(child_applied_price) + "원");
        $("#choice_air_info div.come table tbody tr:eq(1) td:eq(2)").html(formatNumber(child_add_price) + "원");
        $("#choice_air_info div.come table tbody tr:eq(1) td:eq(3)").html(formatNumber(child_airport_price) + "원");
        $("#choice_air_info div.come table tbody tr:eq(1) td:eq(4)").html("0원");
        $("#choice_air_info div.come table tbody tr:eq(1) td:eq(6)").html(formatNumber(child_total_price) + "원");
        if(child_cnt >= 1){
            $("#choice_air_info div.come table tbody tr:eq(1) td:eq(4)").addClass("tc");
            $("#choice_air_info div.come table tbody tr:eq(1) td:eq(5)").html("1명");
            $("#choice_air_info div.come table tbody tr:eq(1) td:eq(6)").addClass("tc");
        }else{
            $("#choice_air_info div.come table tbody tr:eq(1) td:eq(4)").removeClass("tc");
            $("#choice_air_info div.come table tbody tr:eq(1) td:eq(5)").html("0명");
            $("#choice_air_info div.come table tbody tr:eq(1) td:eq(6)").removeClass("tc");
        }

        //계산용 가격 input 셋팅
        $("input[name=come_adult_total_price]").val(adult_total_price);
        $("input[name=come_child_total_price]").val(child_total_price);
    }

    //총가격 셋팅
    total_price_cal();
}

//총 가격 셋팅
function total_price_cal()
{
    //가는 항공편 성인 가격
    var go_adult_total_price = $("input[name=go_adult_total_price]").val();
    go_adult_total_price = eval(go_adult_total_price) + 0;

    //가는 항공편 소아 가격
    var go_child_total_price = $("input[name=go_child_total_price]").val();
    go_child_total_price = eval(go_child_total_price) + 0;

    //오는 항공편 성인 가격
    var come_adult_total_price = $("input[name=come_adult_total_price]").val();
    come_adult_total_price = eval(come_adult_total_price) + 0;

    //오는 항공편 소아 가격
    var come_child_total_price = $("input[name=come_child_total_price]").val();
    come_child_total_price = eval(come_child_total_price) + 0;

    //성인수
    var adult_cnt = $("input[name=step2_adult_cnt]").val();
    adult_cnt = eval(adult_cnt) + 0;

    //소아수
    var child_cnt = $("input[name=step2_child_cnt]").val();
    child_cnt = eval(child_cnt) + 0;

    //유아수
    var baby_cnt = $("input[name=step2_baby_cnt]").val();
    baby_cnt = eval(baby_cnt) + 0;


    //인원수를 곱한 총 가격은
    var total_price = adult_cnt * (go_adult_total_price + come_adult_total_price) + child_cnt * (go_child_total_price + come_child_total_price);
    var total_price_commma = formatNumber(total_price);


    //인원수 셋팅
    //$(".selInfo").html("성인 " + adult_cnt + "명 ｜ 소아 " + child_cnt + "명 ｜ 유아 " + baby_cnt + "명");
    $(".air-price .person").html("성인 " + adult_cnt + "명 ｜ 소아 " + child_cnt + "명 ｜ 유아 " + baby_cnt + "명");

    //가격 셋팅
    //$(".info4").html("<span class='plus'>총합계</span> " + total_price_commma + "<span>원</span>");
    $(".air-price .total .price").text(total_price_commma);
}



//가격형태로 변경
function formatNumber(num) {

    var tmp_price = num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");

    if(!tmp_price) tmp_price = 0;

    return tmp_price;
}


//예약2단계로 이동
function go_reserve_step2()
{
    //가는항공권 선택여부 체크
    var go_air_info = $.trim($("input[name=step2_go_air_info]").val());
    if(go_air_info.length < 1)
    {
        alert("가는 항공편을 선택하세요.");
        return false;
    }

    //왕복이면
    if(g_trip_type == "RT")
    {
        //오는항공권 선택여부 체크
        var come_air_info = $.trim($("input[name=step2_come_air_info]").val());
        if(come_air_info.length < 1)
        {
            alert("오는 항공편을 선택하세요.");
            return false;
        }
        //가는항공편이 오는항공편보다 늦으면 안된다.
        //왕복여정 선택은 가는 여정의 도착시간으로부터 최소40분 이후로 가능합니다.(티웨이)
        //돌아오는 여정선택은 첫번째 여정의 도착 시간으로부터 최소 40분 이후로 가능합니다.(제주항공)
        //가는 여정의 도착시간과 오는 여정의 출발시간은 60분 이상 차이를 두어야 합니다. 다른 항공편을 선택하여 주시기 바랍니다.(대한항공)

        //TW|GMP|CJU|20151212|1025|20151212|1130|NormalFare|9|TW707@93000|93000|93000|4000|3000|100000@93000|88000|93000|2000|3000|93000

        //가는편 도착시간
        var go_air_info_arr = go_air_info.split("|");
        var go_arrive_yyyymmdd = go_air_info_arr[5];
        var go_arrive_Hi = go_air_info_arr[6];

        //오는편 출발시간
        var come_air_info_arr = come_air_info.split("|");
        var come_depart_yyyymmdd = come_air_info_arr[3];
        var come_depart_Hi = come_air_info_arr[4];

        //가는편 도착 일, 시, 분
        var sDate = go_arrive_yyyymmdd.substr(0,4) + "-" + go_arrive_yyyymmdd.substr(4,2) + "-" + go_arrive_yyyymmdd.substr(6,2);
        var shour = go_arrive_Hi.substr(0,2);
        var stime = go_arrive_Hi.substr(2,2);

        //오는편 출발 일, 시, 분
        var eDate = come_depart_yyyymmdd.substr(0,4) + "-" + come_depart_yyyymmdd.substr(4,2) + "-" + come_depart_yyyymmdd.substr(6,2);
        var ehour = come_depart_Hi.substr(0,2);
        var etime = come_depart_Hi.substr(2,2);
        
        var gab_min = calDateRange(sDate, shour, stime, eDate, ehour, etime);

        //40분 이내이면
        if(gab_min < 40)
        {
            alert("가는 여정의 도착시간과 오는 여정의 출발시간은 40분 이상 차이를 두어야 합니다. 다른 항공편을 선택하여 주시기 바랍니다.");
            return false;
        }
    }

    //ie8에서 form target='_blank' 작동 안함.
    //$("form[name=reserve_step1_form]").submit();
    if ($("label[for=" + $("input:radio[class=airCH1]:checked").attr("id") + "]").text() == '제주닷컴') {
        var form = $("form[name=jejucom_reserve]");
        url = $(form).attr("action") + '?' + $(form).serialize();
    } else if ($("label[for=" + $("input:radio[class=airCH1]:checked").attr("id") + "]").text() == '선민투어') {
        var go_q = $("input[name=go_q]").val();
        var come_q = $("input[name=come_q]").val();
        var landing_url = $("input[name=landing_url]").val();

        if (landing_url == "") {
            alert("landing_url 정보가 없습니다.");
            return false;
        }

        if (g_trip_type === "OW") {
            url = landing_url + '/iframe?trips=' + encodeURIComponent(go_q);
        } else {
            url = landing_url + '/iframe?trips=' + encodeURIComponent(go_q) + '&trips=' + encodeURIComponent(come_q);
        }

        // iframe으로 띄우기
        $("#main").hide();
        $("#_footer").hide();
        $("#widget-container").show();
        //$("#sunmin_iframe").attr("src", url);

        $("#widget-container script").remove(); // 기존 script제거
        $("<script>", {
            src: url,
            type: "text/javascript"
        }).appendTo("#widget-container");
        return false;

    } else {
        var form = $("form[name=reserve_step1_form]");
        url = $(form).attr("action") + '?' + $(form).serialize();
    }

    window.open(url, '');
    /*$("#main").hide();
    $('#iframe').attr('src',url);*/

    return false;
}

//두객체의 날수 차이를 리턴 할 경우 :   return (to_dt.getTime() - from_dt.getTime()) / 1000 / 60 / 60 / 24;
//두객체의 시간 차이를 리턴 할 경우 :   return (to_dt.getTime() - from_dt.getTime()) / 1000 / 60 / 60;
//두객체의 분 차이를 리턴 할 경우 :   return (to_dt.getTime() - from_dt.getTime()) / 1000 / 60;
//두객체의 초 차이를 리턴 할 경우 :   return (to_dt.getTime() - from_dt.getTime()) / 1000;

//시간계산
//sDate :시작일, shour:  시간, stime :분
//eDate :종료일, ehour:  시간, etime :분
//ex) calDateRange('2011-05-05','10','00', '2011-05-05','11','00');
function calDateRange(sDate, shour, stime, eDate, ehour, etime)
{
    var FORMAT = "-";

    // FORMAT을 포함한 길이 체크
    if (sDate.length != 10 || eDate.length != 10)
        return null;

    // FORMAT이 있는지 체크
    if (sDate.indexOf(FORMAT) < 0 || eDate.indexOf(FORMAT) < 0)
        return null;

    // 년도, 월, 일로 분리
    var start_dt = sDate.split(FORMAT);
    var end_dt = eDate.split(FORMAT);
    // 월 - 1(자바스크립트는 월이 0부터 시작하기 때문에...)
    // Number()를 이용하여 08, 09월을 10진수로 인식하게 함.
    start_dt[1] = (Number(start_dt[1]) - 1) + "";
    end_dt[1] = (Number(end_dt[1]) - 1) + "";

    var from_dt = new Date(start_dt[0], start_dt[1], start_dt[2], shour, stime);
    var to_dt = new Date(end_dt[0], end_dt[1], end_dt[2], ehour, etime);


    var chkDate = (to_dt.getTime() - from_dt.getTime());

    if(chkDate < 0 )
    {
        //alert("종료시간이 시작시간 이전이면 안됩니다. 다시 확인하세요.");
        //return false;
    }

    return (to_dt.getTime() - from_dt.getTime()) / 1000 / 60;
}