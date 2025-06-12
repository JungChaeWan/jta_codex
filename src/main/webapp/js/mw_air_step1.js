//항공여정(RT:왕복, OW:편도)
var g_trip_type = "RT";
//항공사 코드
var com_codes = new Array('KE', 'OZ', 'LJ', 'BX', 'ZE', 'TW', '7C','RS','4V','RF');
// 항공사명
var com_array = new Array('대한항공', '아시아나', '진에어', '에어부산', '이스타', '티웨이', '제주항공', '에어서울', '플라이강원', '에어로케이');

//항공유형클릭 이벤트
function airtype_click(v)
{
    $('input[name=trip_type]').val(v);

    if(v == 'OW') {     //편도이면
        $('#air_typeRT').removeClass('active');
        $('#air_typeOW').addClass('active');

        $('#start_date_tool').addClass('single');
        $('#end_date_tool').hide();
        $('#end_date_guide').hide();
    } else {            //왕복이면
        $('#air_typeOW').removeClass('active');
        $('#air_typeRT').addClass('active');

        $('#start_date_tool').removeClass('single');
        $('#end_date_tool').show();
        $('#end_date_guide').show();
    }
}

//좌석 등급 및 승객 정보 수정
function modify_seat_person()
{
    //var str = $("#seat_type option:selected").text();

    var str = "성인 " + $('#adult_num').text();
    if (eval($('#child_num').text()) > 0) {
        str += ", 소아 " + $('#child_num').text();
    }
    if (eval($('#baby_num').text()) > 0) {
        str += ", 유아 " + $('#baby_num').text();
    }
    $('#seat_person_str').text(str);
}

// 인원수 변경 이벤트
function chg_person(type, gubun)
{
    var num = 0;

    if (type == '+') {
        num = eval($('#' + gubun + '_num').text()) + 1;
    } else {
        num = eval($('#' + gubun + '_num').text()) - 1;
    }
    // 최저 인원 수 - 성인 : 1, 소아&유아 : 0
    if (gubun == 'adult') {
        if (num < 1) {
            num = 1;
        } else if (num > 9) {
            num = 9;
        }
    } else {
        if (num < 0) {
            num = 0;
        } else if (num > 8) {
            num = 8;
        }
    }
    $('#' + gubun + '_num').text(num);
    $('input[name=' + gubun + '_cnt]').val(num);

    modify_seat_person();
}

// 검색폼 체크
function check_air_seach_form()
{
    $('.popup-typeA').hide();

    //출발지, 도착지 동일 여부 체크(2016-01-05)
    var start_airport = $.trim($("input[name=start_region]:checked").val());
    var end_airport = $.trim($("input[name=end_region]:checked").val());

    if(start_airport == end_airport) {
        alert("출발지와 도착지가 동일합니다.");
        return false;
    }
    //출발일자 체크
    var start_date = $.trim($("input[name=start_date]").val());
    if(start_date.length < 1) {
        alert("가는날을 선택해주세요.");
        return false;
    }
    //도착일자 체크
    if($("input[name=trip_type]").val() == "RT") {          //항공유형이 왕복일 경우
        var end_date = $.trim($("input[name=end_date]").val());

        if(end_date.length < 1) {
            alert("오는날을 선택해주세요.");
            return false;
        }
    } else {                //항공유형이 편도일 경우
        //출발일자를 셋팅한다.
        $("input[name=end_date]").val(start_date);
    }
    //인원수 체크
    if ($('#seat_person_str').text() != '인원 선택') {
        if(!check_people_cnt()) {
            return false;
        }
    } else {
        alert('인원 및 좌석을 확인해 주세요.');
        return false;
    }
    optionClose($("#air_count"));

    document.location.hash = "start_date=" + $("input[name=start_date]").val() + "&end_date=" +  $("input[name=end_date]").val()
        + "&seat_type=" + $("select[name=seat_type]").val() + "&adult_cnt=" + $("#adult_cnt").val() + "&child_cnt=" + $("#child_cnt").val() + "&baby_cnt=" + $("#baby_cnt").val()
        + "&start_region=" + $("input:radio[name=start_region]:checked").val() + "&end_region=" + $("input:radio[name=end_region]:checked").val() +"&trip_type="+$("input[name=trip_type]").val();

    ++prevIndex;
    history.replaceState($("#main").html(), "title"+ prevIndex, "?prevIndex="+ prevIndex);
    currentState = history.state;
}

//인원수 체크
function check_people_cnt()
{
    //성인수
    var adult_cnt = $("select#adult").val();
    adult_cnt = eval(adult_cnt) + 0;
    //소아수
    var child_cnt = $("select#children").val();
    child_cnt = eval(child_cnt) + 0;
    //유아수
    var baby_cnt = $("select#child").val();
    baby_cnt = eval(baby_cnt) + 0;

    //1. 유아인원수는 성인인원수를 초과할 수 없다.
    if(adult_cnt < baby_cnt) {
        alert("성인 1명에 유아 1명만을 예약하실 수 있으며 나머지 유아는 소아로 예약하셔야 합니다.");

        $("select#child").val(adult_cnt);

        return false;
    }
    //2. 총 좌석점유 탑승객이 9명을 초과할 수 없다.
    if(adult_cnt + child_cnt > 9) {
        alert("총 좌석점유 탑승객이 9명을 넘을 수 없습니다.");

        $("select#adult").val("1");
        $("select#children").val("0");
        $("select#child").val("0");

        return false;
    }
    return true;
}

//실시간 항공 데이터 가져오기 (가는날)
function load_go_air_list()
{
    //스피너 로딩바 show
    $(".loadingAir-wrap").removeClass("hide");

    // 항공 데이터 초기화
    $("#flight_list").html('');
    $('#search_flag').val('go');
    // 가는 항공 선택 정보 숨김
    $('#goSelectSection').addClass('hide');

    /** 검색조건 */
    //항공유형
    var trip_type = $.trim($("#trip_type").val());
    //전역변수에 셋팅
    g_trip_type = trip_type;
    //좌석등급
    var seat_types = "전체";
    //출발지역
    var start_area = $.trim($("#start_region").val());
    //도착지역
    var end_area = $.trim($("#end_region").val());
    //가는일자
    var start_date = $.trim($("#start_date").val());
    //오는일자
    var end_date = $.trim($("#end_date").val());
    //성인수
    var adult_cnt = $("#adult_cnt").val();
    //소아수
    var child_cnt = $("#child_cnt").val();
    //유아수
    var baby_cnt = $("#baby_cnt").val();
    // 검색 항공사
    var search_com = $("select[name=airline_code]").val();

    //가는항공편 정보 표시
    var start_air_arr = start_date.split('-');
    var start_air_info = '<span class="info1">가는 항공편</span>';
    start_air_info += '<span class="info2">' + get_airport_name(start_area) + ' - ' + get_airport_name(end_area) + '</span>';
    start_air_info += '<span class="date">' + start_air_arr[1] + '.' + start_air_arr[2] + '('+ get_yoil(start_date) +')</span>';

    $("#airInfo").html(start_air_info);

    /* 제주닷컴 가는항공편 정보 셋팅 */
    $("input[name=flight_type]").val(1);

    if (search_com == 'ALL') {
        $("input[name='flight_com[]']").val('');
    } else {
        $("input[name='flight_com[]']").val(search_com);
    }
    //항공검색목록 초기화
    $(".go_tr").remove();
    //선택항공권정보 초기화
    $("input[name=step2_go_air_info]").val("");

    //가는항공편 보임.
    $("#choice_air_info div.go").show();

    //선택하신 여정 > 가는항공편 정보 초기화
    price_apply("go","1|1","0|0","0|0","0|0","0|0");

    let promises = [];

    //선민투어
    promises.push(air_service_sunmin_call('go', trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt));

    //제이엘항공
    for (var i = 0; i < com_codes.length; i++) {
        if (search_com == com_codes[i] || search_com == "ALL") {
            let fn = window['air_service_' + com_codes[i].toLowerCase() + '_call'];
            if (typeof fn === 'function') {
                promises.push(
                    fn('go', trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt)
                );
            }
        }
    }

    // 제주닷컴 항공
    //언젠가 주석 푸는 날 점검 필수
    //promises.push(air_service_jejucom_call('go', trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt));

    //ajax 통신 성공/실패에 관계 없이 모든 통신이 끝나면
    $.when.apply($, promises).always(function() {
        $("#airline_code").attr("disabled", false);

        // 모든 DOM 반영이 끝난 후 로딩바 제거
        setTimeout(function() {
            $(".loadingAir-wrap").addClass("hide");
        }, 800);
    });
}

//실시간 항공 데이터 가져오기 (오는날)
function load_come_air_list(gubun)
{

    //스피너 로딩바 show
    $(".loadingAir-wrap").removeClass("hide");

    //항공사 검색 비활성
    $("#airline_code").attr("disabled", true);

    // 항공 데이터 초기화
    $("#flight_list").html('');
    $('#search_flag').val('come');

    /** 검색조건 */
    // 가는 항공 선택 정보 출력
    $('#goSelectSection').removeClass('hide');
    //항공유형
    var trip_type = $.trim($("#trip_type").val());
    //전역변수에 셋팅
    g_trip_type = trip_type;
    //좌석등급
    var seat_types = "전체";
    //출발지역
    var start_area = $.trim($("#start_region").val());
    //도착지역
    var end_area = $.trim($("#end_region").val());
    //가는일자
    var start_date = $.trim($("#start_date").val());
    //오는일자
    var end_date = $.trim($("#end_date").val());
    //성인수
    var adult_cnt = $("#adult_cnt").val();
    //소아수
    var child_cnt = $("#child_cnt").val();
    //유아수
    var baby_cnt = $("#baby_cnt").val();
    // 검색 항공사
    var search_com = $("select[name=airline_code]").val();

    if (search_com == 'ALL') {
        $("input[name='flight_com[]']").val('');
    } else {
        $("input[name='flight_com[]']").val(search_com);
    }
    //오는항공편 정보 표시
    var end_air_arr = end_date.split('-');
    var end_air_info = '<span class="info1">오는 항공편</span>';
    end_air_info += '<span class="info2">' + get_airport_name(end_area) + ' - ' + get_airport_name(start_area) + '</span>';
    end_air_info += '<span class="date">' + end_air_arr[1] + '.' + end_air_arr[2] + '('+ get_yoil(end_date) +')</span>';
    $("#airInfo").html(end_air_info);

    /* 제주닷컴 오는항공편 정보 셋팅 */
    $("input[name=flight_type]").val(2);

    //선택항공권정보 초기화
    $("input[name=step2_come_air_info]").val("");

    //오는항공편 보임.
    $("#choice_air_info div.come-wrap").show();
    //선택하신 여정 > 오는항공편 정보 초기화
    price_apply("come","1|1","0|0","0|0","0|0","0|0");

    /** 데이터요청 */
    let promises = [];
    if (gubun == 'jl') {    // 제이엘

        for (var i = 0; i < com_codes.length; i++) {
            if (search_com == com_codes[i] || search_com == "ALL") {
                let fn = window['air_service_' + com_codes[i].toLowerCase() + '_call'];
                if (typeof fn === 'function') {
                    promises.push(
                        fn('come', trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt)
                    );
                }
            }
        }
    } else if (gubun == 'jc') { // 제주닷컴 항공

        $("#flight_list").remove();
        $("#flight_list2").css("display","block");
        $(".air-line").trigger("update");
        return;
        /*promises.push(air_service_jejucom_call('come', trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt));*/

    } else if (gubun == 'sunmin') { // 선민투어

        $("#flight_list").remove();
        $("#flight_list2").css("display","block");
        $(".air-line").trigger("update");
        promises.push(air_service_sunmin_call('come', trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt));
    }

    $.when.apply($, promises).always(function() {
        setTimeout(function() {
            $(".loadingAir-wrap").addClass("hide");
        }, 1000);
    });
}

//대한항공 항공권 목록 요청
function air_service_ke_call(gubun, trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt)
{

}

//대한항공 항공권 목록 적용
function air_service_ke_call_after()
{

}

//아시아나 항공권 목록 요청
function air_service_oz_call(gubun, trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt)
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
            air_service_oz_call_after(gubun, data, trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt);
        },
        complete: function(data) {
            // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
        },
        error: function(xhr, status, error) {
            //alert("에러발생");
        }
    });
}

//아시아나 항공권 목록 적용
function air_service_oz_call_after(gubun, data, trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt)
{
    var result_data = gubun == 'go' ? data.onword_flight : data.return_flight;

    if(result_data) {
        append_jl_air_tr(2, gubun, adult_cnt, child_cnt, result_data);
    }
    /*
    //항공편 정렬이벤트 갱신
    //var sorting = [[1,0]];
    $(".air-line").trigger("update");
    //리스트 소팅
    list_sorting();
    */
}

//진에어 항공권 목록 요청
function air_service_lj_call(gubun, trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt)
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
            air_service_lj_call_after(gubun, data, trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt);
        },
        complete: function(data) {
            // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
        },
        error: function(xhr, status, error) {
            //alert("에러발생");
        }
    });
}

//진에어 항공권 목록 적용
function air_service_lj_call_after(gubun, data, trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt)
{
    var result_data = gubun == 'go' ? data.onword_flight : data.return_flight;

    if(result_data) {
        append_jl_air_tr(3, gubun, adult_cnt, child_cnt, result_data);
    }
    /*
    //항공편 정렬이벤트 갱신
    //var sorting = [[1,0]];
    $(".air-line").trigger("update");
    //리스트 소팅
    list_sorting();
    */
}

//에이부산 항공권 목록 요청
function air_service_bx_call(gubun, trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt)
{

}

//에이부산 항공권 목록 적용
function air_service_bx_call_after()
{

}

//이스타항공 항공권 목록 요청
function air_service_ze_call(gubun, trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt)
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
            air_service_ze_call_after(gubun, data, trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt);
        },
        complete: function(data) {
            // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
        },
        error: function(xhr, status, error) {
            //alert("에러발생");
        }
    });
}

//이스타항공 항공권 목록 적용
function air_service_ze_call_after(gubun, data, trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt)
{
    var result_data = gubun == 'go' ? data.onword_flight : data.return_flight;

    if(result_data) {
        append_jl_air_tr(5, gubun, adult_cnt, child_cnt, result_data);
    }
    /*
    //항공편 정렬이벤트 갱신
    //var sorting = [[1,0]];
    $(".air-line").trigger("update");
    //리스트 소팅
    list_sorting();
    */
}

//티웨이 항공권 목록 요청
function air_service_tw_call(gubun, trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt)
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
            air_service_tw_call_after(gubun, data, trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt);
        },
        complete: function(data) {
            // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
        },
        error: function(xhr, status, error) {
            //alert("에러발생");
        }
    });
}

//티웨이 항공권 목록 적용
function air_service_tw_call_after(gubun, data, trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt)
{
    var result_data = gubun == 'go' ? data.onword_flight : data.return_flight;

    if(result_data) {
        append_jl_air_tr(6, gubun, adult_cnt, child_cnt, result_data);
    }
}

//제주항공 항공권 목록 요청
function air_service_7c_call(gubun, trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt)
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
            air_service_7c_call_after(gubun, data, trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt);
        },
        complete: function(data) {
            // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
        },
        error: function(xhr, status, error) {
            //alert("에러발생");
        }
    });
}

//제주항공 항공권 목록 적용
function air_service_7c_call_after(gubun, data, trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt)
{
    var result_data = gubun == 'go' ? data.onword_flight : data.return_flight;

    if(result_data) {
        append_jl_air_tr(7, gubun, adult_cnt, child_cnt, result_data);
    }
}

//에어서울
function air_service_rs_call(gubun, trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt)
{

}

//대한항공 항공권 목록 적용
function air_service_rs_call_after()
{

}

//플라이강원 항공권 목록 요청
function air_service_4v_call(gubun, trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt)
{

}

//에어로케이 항공권 목록 요청
function air_service_rf_call(gubun, trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt)
{

}

//제이엘항공의 tr 추가
function append_jl_air_tr(com, gubun, adult, child, air_data)
{
    $.each(air_data, function(i,item) {
        //항공편 예약정보
        var reserve_info = get_air_reserve_info(com_codes[com - 1],item);
        // 예약 여부
        var add_disabled = item.air_seat_cnt == '0' ? 'disabled' : '';

        var html = '<tr id="jl_' + com + '_' + gubun + '_' + i + '" class="' + gubun + '_tr jl_air ' + add_disabled + '">';
        html += '	<td>';
        html += '	    <p class="ci"><img src="/images/mw/air/line' + com + '_big.png" alt="' + com_array[com - 1] + '"></p>';
        html += '	    <p class="name">' + com_array[com - 1] + '</p>';

        if(item.adult_number) {
            html += '	    <p class="emph">' + item.adult_number + '편</p>';
        }
        // 2016-06-22 By jdongs@nextez.co.kr 아시아나 공동운항 추가
        if (com == 2 && $.inArray(item.air_joint, new Array('BX', 'RS')) != -1) {
            html += '	<div class="tooltip-btn">';
            if (item.air_joint == 'BX') {
                html += '		<span>에어부산 공동운항</span>';
            } else if (item.air_joint == 'RS') {
                html += '		<span>에어서울 공동운항</span>';
            }
            html += '	</div>';
        }
        html += '	</td>';
        html += '	<td class="time">';
        
        html += '	    <p class="sTime">출발 ' + item.air_s_time_txt + '</p>';
        html += '	    <p class="eTime">도착 ' + item.air_e_time_txt + '</p>';
        //html += '	    <p class="sTime">' + item.air_s_time_txt + '</p>';
        
        html += '	</td>';
        html += '	<td>';
        html += '	    <p class="seat">' + item.air_seat_cnt + '석</p>';
        html += '	    <p class="rating">' + item.adult_fare_type_txt + '</p>';
        html += '	</td>';
        html += '	<td>';
        html += '	    <p class="hide">$</p>';
        html += '	    <p class="money">' + commaNum(item.adult_total_pay * adult + item.child_total_pay * child) + '</p>';
        html += '	</td>';
        html += '	<td class="condition">';
        html += '	 	<input id="air_' + gubun + i + '" class="chk_jl" type="radio" name="air_' + gubun + '[]" onclick="apply_pay(\'' + gubun + '\', \'' + reserve_info + '\', \'' + com + '_' + gubun + '_' + i + '\', \'' + item.adult_fare_type_txt + '\');" ' + add_disabled + '>';
        html += '	   	<label for="air_' + gubun + i + '">제이엘항공</label>';
        html += '	</td>';
        html += '</tr>';

        $("#flight_list").append(html);
    });

    //항공편 정렬이벤트 갱신
    if ($('.' + gubun + '_tr').length != 0) {
        //var sorting = [[1,0]];
        $(".air-line").trigger("update");
        //리스트 소팅
        list_sorting();
    }
}

function air_service_sunmin_call(chg_gubun, trip_type, seat_types, start_area, end_area, depDate, arrDate, adult_cnt, child_cnt, baby_cnt) {
    var seat_str = $('#air_ratingALL').prop('checked') ? '전체' : seat_types.toLowerCase().replace(/@/gi, '|').replace('s', 'd');

    if ($('#airline_code').val() === 'ALL') {
        // 전체 항공사 한 번만 호출
        setting_sunmin_tr(chg_gubun,com_codes, seat_str, start_area, end_area, depDate, arrDate, adult_cnt, child_cnt, baby_cnt, trip_type);
    } else {
        // 단일 항공사만 호출
        const selected = $('#airline_code').val();
        if (com_codes.includes(selected)) {
            setting_sunmin_tr(chg_gubun,[selected], seat_str, start_area, end_area, depDate, arrDate, adult_cnt, child_cnt, baby_cnt, trip_type);
        }
    }
}

function setting_sunmin_tr(chg_gubun, search_coms, seat_str, start_area, end_area, depDate, arrDate, adult_cnt, child_cnt, baby_cnt, trip_type) {
    const isGo = chg_gubun === "go";

    const query = {
        isRound: "false",
        depCity: isGo ? start_area : end_area,
        arrCity: isGo ? end_area : start_area,
        depDate: isGo ? depDate : arrDate,
        arrDate: isGo ? depDate : arrDate,
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
            const targetTable = isGo ? "#go_flight" : "#come_flight";
            const renderTarget = isGo ? "#flight_list" : "#flight_list2";
            const seenFlights = new Set();

            $(targetTable + " tr.sunmin_tour").remove();

            if (data.list && Array.isArray(data.list)) {
                data.list.forEach(function(item, i) {
                    if (!Array.isArray(item.airLine)) return;
                    item.airLine.forEach(function(flight, j) {
                        const isValid = isGo
                            ? (flight.depCity === start_area && flight.arrCity === end_area)
                            : (flight.depCity === end_area && flight.arrCity === start_area);

                        if (!isValid) return;

                        const uniqueKey = flight.flight + flight.flightNumber + flight.depDate + flight.bookingClass;
                        if (seenFlights.has(uniqueKey)) return;
                        seenFlights.add(uniqueKey);

                        renderSunminRow(flight, i, j, chg_gubun, renderTarget, adult_cnt, child_cnt, item.landingUrl || data.landingUrl);
                    });
                });
            }
        },
        complete: function() {
            if ($("." + chg_gubun + "_tr").length !== 0) {
                $(".air-line").trigger("update");
                list_sorting();
            }
        },
        error: function(xhr, status, error) {
            console.error("선민 항공 조회 에러 (" + chg_gubun + "):", error);
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

    var html = '<tr id="sunmin_' + chg_gubun + '_'+ i + '_' + j +'" class="' + chg_gubun + '_tr sunmin_tour" data-key="' + uniqueKey + '">';
    html += '    <td>';
    html += '        <p class="ci"><img src="/images/mw/air/line' + (com + 1) + '_big.png" alt="' + com_array[com] + '"></p>';
    html += '        <p class="name">' + com_array[com] + '</p>';
    html += '        <p class="emph">' + flight.flight + flight.flightNumber + '편</p>';
    html += '    </td>';
    html += '    <td class="time">';
    html += '        <p class="sTime">출발 ' + depTime + '</p>';
    html += '        <p class="eTime">도착 ' + arrTime + '</p>';
    html += '    </td>';
    html += '    <td>';
    html += '        <p class="seat">' + flight.seatCount + '석</p>';
    html += '        <p class="rating ' + (
        flight.classTypeNm.trim() === "특가석" ? "Special" :
        flight.classTypeNm.trim() === "할인석" ? "Sale" :
        flight.classTypeNm.trim() === "이벤트석" ? "Event" :
        flight.classTypeNm.trim() === "비즈니스석" ? "business" : ""
    ) + '">' + flight.classTypeNm + '</p>';
    html += '    </td>';
    html += '    <td>';
    html += '        <p class="hide">$</p>';
    html += '        <p class="money">' + commaNum(air_price) + '</p>';
    html += '    </td>';
    html += '    <td class="condition">';
    html += '        <input id="air_' + chg_gubun + i + '" class="chk_jc" type="radio" name="air_' + chg_gubun + '[]" onclick="sunmin_apply_pay(\'' + chg_gubun + '\', \'' + reserve_info.replace(/'/g, "\\'") + '\', \'' + String(flight.q).replace(/'/g, "\\'") + '\', \'' + j + '\', \'' + flight.classTypeNm.replace(/'/g, "\\'") + '\', \'' + commaNum(air_price) + '\', \'' + (flight.isOpCar || '') + '\', \'' + (landingUrl || '') + '\');">';
    html += '        <label for="air_' + chg_gubun + i + '">선민투어</label>';
    html += '    </td>';
    html += '</tr>';

    $(containerId).append(html);
}

function sunmin_apply_pay(trip_type, reserve_info_str, rev_id, key, fare_type, total_pay, join_car_code, landing_url) {
    $('#search_com').val('sunmin');
    $('#airLogoTitle').text("");
    $('#airCompany').removeClass('hide');
    $('#airLogoImg').removeClass('hide').attr("src", "/images/web/air/sunmin_tour_log.png");

    var air_bagic = "";
    var air_adult = "";
    var air_child = "";
    var seat_type = fare_type;

    /** 1. 예약 정보 문자열을 '@' 기준으로 분리 */
    if (reserve_info_str) {
        var tmp_arr1 = reserve_info_str.split("@");
        air_bagic = tmp_arr1[0];
        air_adult = tmp_arr1[1] || "0|0|0|0";
        air_child = tmp_arr1[2] || "0|0|0|0";
    }

    /** 2.기본정보 및 금액정보 '|' 기준으로 분리 */
    var air_bagic_info = air_bagic.split("|"); // 0. 출발일 /1.출발시간 /2. 출발도시코드 /3. 출발도시명/ 4.도착일 / 5. 도착시간 /6. 도착도시코드 / 7.도착도시명 / 8.항공사 코드 / 9.항공편 번호 / 10.com
    var air_adult_info = air_adult.split("|");
    var air_child_info = air_child.split("|");

    /** 3. 여정 출력용 HTML 구성 */
    var go_air_info1 = '[' + air_bagic_info[3] + ' <img src="/images/mw/icon/arrow/air.png" class="airline" alt="오른쪽 방향 화살표"> ' + air_bagic_info[7] + '] ';
    go_air_info1 += get_air_img(air_bagic_info[8]) + ' ' + air_bagic_info[9] + '편';

    /** 4. 공동운항 항공사 표시 */
    if (air_bagic_info[8] === "OZ" && join_car_code) {
        go_air_info1 += ' <span class="tooltip-btn">공동운항';
        if (join_car_code === "BX") go_air_info1 += '<p class="info-text busan"></p>';
        else if (join_car_code === "RS") go_air_info1 += '<p class="info-text seoul"></p>';
        go_air_info1 += '</span>';
    }

    var go_air_info2 = '<span class="date">';
    go_air_info2 += air_bagic_info[0].substr(0, 4) + '년 ' + air_bagic_info[0].substr(5, 2) + '월 ' + air_bagic_info[0].substr(8, 2) + '일';
    go_air_info2 += ' (' + get_yoil(air_bagic_info[0]) + ') ';
    go_air_info2 += air_bagic_info[1].substr(0, 2) + '시 ' + air_bagic_info[1].substr(3, 2) + '분';
    go_air_info2 += '</span> | ';
    go_air_info2 += '<span class="seat">' + seat_type + '</span>';

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
        $('#jcAirList').removeClass('hide');
        $("input[name=step2_come_air_info]").val("");
        $("#choice_air_info div.come h4 span:eq(0)").html('');
        price_apply("come", "1|1", "0|0", "0|0", "0|0", "0|0");

        $('#avComSection').removeClass('hide');
        $('#avListSection').removeClass('hide');
        $('#avSelectSection').addClass('hide');
        $('#comeSelAirDiv').addClass('hide');

        $("#goSelAirInfo").html(go_air_info1);
        $("#goSelDatetimeInfo").html(go_air_info2);
        price_apply("go", "1|1", applied_price, add_price, airport_price, total_price);

        $("input[name=id_1]").val(rev_id);
        $("input[name=step2_go_air_info]").val(air_info_str.join("|"));
        $("input[name=landing_url]").val(landing_url);
        $("input[name=go_q]").val(rev_id);

        var goSelectInfo = '<div><span class="zone">' + go_air_info1 + '</span></div>';
        goSelectInfo += '<div>' + go_air_info2 + '</div>';
        $('#goSelectInfo').html(goSelectInfo);

        if (g_trip_type === "OW") {
            $('#avSelectSection').removeClass('hide');
            $("html body").animate({ scrollTop: 1 }, 1000);
            $('#avComSection').addClass('hide');
            $('#avListSection').addClass('hide');
        } else {
            load_come_air_list('sunmin');
            go_top();
            $("#gotoBackBtn").prop('href', 'javascript:location.reload();');
        }

    } else if (trip_type === "come") {
        $("#comeSelAirInfo").html(go_air_info1);
        $("#comeSelDatetimeInfo").html(go_air_info2);
        price_apply("come", "1|1", applied_price, add_price, airport_price, total_price);

        $("input[name=id_2]").val(rev_id);
        $("input[name=step2_come_air_info]").val(air_info_str.join("|"));
        $("input[name=come_q]").val(rev_id);

        $('#avSelectSection').removeClass('hide');
        $('#comeSelAirDiv').removeClass('hide');
        $("html body").animate({ scrollTop: 1 }, 1000);
        $('#goSelectSection').addClass('hide');
        $('#avComSection').addClass('hide');
        $('#avListSection').addClass('hide');
        $("#gotoBackBtn").prop('href', 'javascript:sunmin_apply_pay("' + trip_type + '", "' + reserve_info_str + '", "' + rev_id + '", "' + key + '", "' + fare_type + '", "' + total_pay + '", "' + join_car_code + '", "' + landing_url + '");');
    }

    list_sorting();
}


//제주닷컴 항공권 목록 요청
function air_service_jejucom_call(gubun, trip_type, seat_types, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt)
{
//	var search_coms = new Array();
    var seat_str = $('select[name=seat_type]').val() == 'ALL' ? '전체' : seat_types.toLowerCase().replace(/@/gi, '|').replace('s', 'd');

    // 제주닷컴 관련 항공사 이미지 로딩중 이미지로 변경
    for (var i=0, end=com_codes.length; i<end; i++) {
        var search_coms = new Array();

        var airInfo = $('select[name=airline_code]').val();
        if (airInfo != 'ALL' && airInfo != com_codes[i]) {
            continue;
        }
        search_coms[search_coms.length] = com_codes[i];

        // 각 항공사별 호출로 변경 (2017-07-31, By JDongS)
        if (search_coms.length > 0) {
            setting_air_tr(gubun, search_coms, seat_str, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt);
        }
    }
}

// 제주닷컴 항공권 추출
function setting_air_tr(gubun, search_coms, seat_str, start_area, end_area, start_date, end_date, adult_cnt, child_cnt, baby_cnt)
{
    var air_com = search_coms.join('|');
    var params = "flight_com=" + air_com+ "&flight_class=" + seat_str + "&flight_adult=" + adult_cnt + "&flight_junior=" + child_cnt + "&flight_baby=" + baby_cnt + "&agt=tamnao&mode=json";

    params += "&flight_date=" + start_date + "&flight_scity=" + start_area + "&flight_ecity=" + end_area;
    if(g_trip_type == "RT"){
        params += "&flight_date2=" + end_date;
    }
    return $.ajax({
        type: "GET",
        url: "https://api.jeju.com/service/searchAirSingle.php",
        data: params,
        /*jsonpCallback: "callback",*/
        contentType: "application/json",
        dataType: "jsonp",
        crossDomain: true,
        success: function(data){
            var seatInfo = get_seat_type($('#seat_type').val());
            // var chg_gubun = data.params.flight_scity == $('#start_region').val() ? "go" : "come";
            gubun = "go";
            if(data.avail_list) {
                $.each(data.avail_list, function (i, item) {
                    i = i.replace(/ /g, '');

                    if (item.id == '' || item.is_rsv == '0' || (seatInfo != '전체' && seatInfo != item.class_desc)) {
                        return true;
                    }
                    var com = $.inArray(item.car_code, com_codes);
                    var air_price = (parseInt(item.fare) + parseInt(item.fuel_tax) + parseInt(item.air_tax)) * adult_cnt + (parseInt(item.chd_fare) + parseInt(item.chd_fuel_tax) + parseInt(item.chd_air_tax)) * child_cnt;
                    /**  항공편 정보 { 항공 일정('|' 구분) @ 성인 요금 정보('|' 구분) @ 소아 요금 정보('|' 구분) } **/
                    var daily_array = new Array(item.dep_date, item.dep_day_desc, item.dep_desc, item.arr_desc, item.dep_time, item.car_code, item.main_flt, item.dep_city, item.arr_city, item.arr_date, item.arr_time, item.class_desc);
                    var adult_prices = new Array(parseInt(item.fare), parseInt(item.fuel_tax), parseInt(item.air_tax), (parseInt(item.fare) + parseInt(item.fuel_tax) + parseInt(item.air_tax)));
                    var young_prices = new Array(parseInt(item.chd_fare), parseInt(item.chd_fuel_tax), parseInt(item.chd_air_tax), (parseInt(item.chd_fare) + parseInt(item.chd_fuel_tax) + parseInt(item.chd_air_tax)));
                    var reserve_info = daily_array.join('|') + "@" + adult_prices.join('|') + "@" + young_prices.join('|');
                    //	var html = '<tr id="jc_' + i + '" class="' + gubun + '_tr jc_air">';
                    var html = '<tr id="jc_' + i + '" class="' + gubun + '_tr jc_air">';
                    html += '	 <td>';
                    html += '        <p class="ci"><img src="/images/mw/air/line' + (com + 1) + '_big.png" alt="' + com_array[com] + '"></p>';
                    html += '        <p class="name">' + com_array[com] + '</p>';

                    if (item.main_flt) {
                        html += '        <p class="emph">' + item.main_flt + '편</p>';
                    }
                    // 2016-06-22 By jdongs@nextez.co.kr 아시아나 공동운항 추가
                    if (item.car_code == 'OZ' && $.inArray(item.join_car_code, new Array('BX', 'RS')) != -1) {
                        html += '	<div class="tooltip-btn">';

                        if (item.join_car_code == 'BX') {
                            html += '		<span>에어부산 공동운항</span>';
                        } else if (item.join_car_code == 'RS') {
                            html += '		<span>에어서울 공동운항</span>';
                        }
                        html += '	</div>';
                    }
                    html += '    </td>';
                    html += '    <td class="time">';
                    html += '        <p class="sTime">출발 ' + item.dep_time + '</p>';
                    html += '        <p class="eTime">도착 ' + item.arr_time + '</p>';
                    //html += '        <p class="sTime">' + item.dep_time + '</p>';
                    
                    html += '    </td>';
                    html += '    <td>';
                    html += '        <p class="seat">' + item.no_of_avail_seat + '석</p>';
                    html += '        <p class="rating">' + item.class_desc + '</p>';
                    html += '    </td>';
                    html += '    <td>';
                    html += '        <p class="hide">$</p>';
                    html += '        <p class="money">' + commaNum(air_price) + '</p>';
                    html += '    </td>';
                    html += ' 	 <td class="condition">';
                    html += '    	<input id="air_' + gubun + i + '" class="chk_jc" type="radio" name="air_' + gubun + '[]" onclick="jc_apply_pay(\'' + gubun + '\', \'' + reserve_info + '\', \'' + item.id + '\', \'' + i + '\');">';
                    html += '    	<label for="air_' + gubun + i + '">제주닷컴</label>';
                    html += '	 </td>';
                    html += '</tr>';

                    $("#flight_list").append(html);
                });
            }
            gubun = "come";
            if(data.avail_list2 && g_trip_type == "RT"){
                $.each(data.avail_list2, function(i,item){
                    i = i.replace(/ /g, '');

                    if (item.id == '' || item.is_rsv == '0' || (seatInfo != '전체' && seatInfo != item.class_desc)) {
                        return true;
                    }
                    var com = $.inArray(item.car_code, com_codes);
                    var air_price = (parseInt(item.fare) + parseInt(item.fuel_tax) + parseInt(item.air_tax)) * adult_cnt + (parseInt(item.chd_fare) + parseInt(item.chd_fuel_tax) + parseInt(item.chd_air_tax)) * child_cnt;
                    /**  항공편 정보 { 항공 일정('|' 구분) @ 성인 요금 정보('|' 구분) @ 소아 요금 정보('|' 구분) } **/
                    var daily_array = new Array(item.dep_date, item.dep_day_desc, item.dep_desc, item.arr_desc, item.dep_time, item.car_code, item.main_flt, item.dep_city, item.arr_city, item.arr_date, item.arr_time, item.class_desc);
                    var adult_prices = new Array(parseInt(item.fare), parseInt(item.fuel_tax), parseInt(item.air_tax), (parseInt(item.fare) + parseInt(item.fuel_tax) + parseInt(item.air_tax)));
                    var young_prices = new Array(parseInt(item.chd_fare), parseInt(item.chd_fuel_tax), parseInt(item.chd_air_tax), (parseInt(item.chd_fare) + parseInt(item.chd_fuel_tax) + parseInt(item.chd_air_tax)));
                    var reserve_info = daily_array.join('|') + "@" + adult_prices.join('|') + "@" + young_prices.join('|');
                    //	var html = '<tr id="jc_' + i + '" class="' + gubun + '_tr jc_air">';
                    var html = '<tr id="jc_' + i + '" class="' + gubun + '_tr jc_air">';
                    html += '	 <td>';
                    html += '        <p class="ci"><img src="/images/mw/air/line' + (com + 1) + '_big.png" alt="' + com_array[com] + '"></p>';
                    html += '        <p class="name">' + com_array[com] + '</p>';

                    if(item.main_flt) {
                        html += '        <p class="emph">' + item.main_flt + '편</p>';
                    }
                    // 2016-06-22 By jdongs@nextez.co.kr 아시아나 공동운항 추가
                    if (item.car_code == 'OZ' && $.inArray(item.join_car_code, new Array('BX', 'RS')) != -1) {
                        html += '	<div class="tooltip-btn">';

                        if (item.join_car_code == 'BX') {
                            html += '		<span>에어부산 공동운항</span>';
                        } else if (item.join_car_code == 'RS') {
                            html += '		<span>에어서울 공동운항</span>';
                        }
                        html += '	</div>';
                    }
                    html += '    </td>';
                    html += '    <td class="time">';
                    html += '        <p class="sTime">출발 ' + item.dep_time + '</p>';
                    html += '        <p class="eTime">도착 ' + item.arr_time + '</p>';
                    //html += '        <p class="sTime">' + item.dep_time + '</p>';
                    
                    html += '    </td>';
                    html += '    <td>';
                    html += '        <p class="seat">' + item.no_of_avail_seat + '석</p>';
                    html += '        <p class="rating">' + item.class_desc + '</p>';
                    html += '    </td>';
                    html += '    <td>';
                    html += '        <p class="hide">$</p>';
                    html += '        <p class="money">' + commaNum(air_price) + '</p>';
                    html += '    </td>';
                    html += ' 	 <td class="condition">';
                    html += '    	<input id="air_' + gubun + i + '" class="chk_jc" type="radio" name="air_' + gubun + '[]" onclick="jc_apply_pay(\'' + gubun + '\', \'' + reserve_info + '\', \'' + item.id + '\', \'' + i + '\');">';
                    html += '    	<label for="air_' + gubun + i + '">제주닷컴</label>';
                    html += '	 </td>';
                    html += '</tr>';

                    $("#flight_list2").append(html);
                });
            }
        },
        complete: function(data) {
            // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
            //항공편 정렬이벤트 갱신
            $(".air-line").trigger("update");
            list_sorting();
        },
        error: function(xhr, status, error) {
            //alert("에러발생 : " + xhr.responseText + " ; " + status + " ; " + error);
        }
    });
}

//리스트 소팅
function list_sorting()
{
    //목록을 추가한 후 바로 소팅을 하게 되면 정상적으로 되지 않아서 0.1초의 시간을 두고 소팅을 시킨다.
    setTimeout(function(){
    	$(".air-line").trigger("sorton",[[[1,0]]]);     // 탑승시간 오름차순 정렬
    },300);
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

    if(airline == "TW" || airline == "LJ") {        //티웨이항공이면, 진에어이면
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
    } else if(airline == "OZ") {      //아시아나이면
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
    } else if(airline == "7C") {      //제주항공이면
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
    } else if (airline === "ZE") {        //이스타항공이면
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
var go_key_info = "";
var go_reserve_info = "";
var go_seat_type = "";

function apply_pay(trip_type, reserve_info_str, key, seat_type)
{
    /* 최종형태
    * 항공사코드|출발지코드|도착지코드|출발일자|출발시간|도착일자|도착시간|요금타입|좌석수|항공기번호
    * @성인기본요금|성인적용요금|성인표시요금|성인재세공과금|성인유류|성인총요금
    * @소아기본요금|소아적용요금|소아표시요금|소아재세공과금|소아유류|소아총요금
    */
    $('#search_com').val('jl');
    // 판매처 출력
    $('#airLogoTitle').text("제이엘항공");
    $('#airCompany').removeClass('hide');
    $('#airLogoImg').removeClass('hide').attr("src", "/images/mw/air/jl.jpg");

    var air_bagic = "";
    var air_adult = "";
    var air_child = "";

    //1. 기본정보, 성인가격, 소인가격 분리
    if(reserve_info_str) {
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
    var go_air_info1 = '[' + get_airport_name(air_bagic_info[1]) + ' <img src="/images/mw/icon/arrow/air.png" class="airline" alt="오른쪽 방향 화살표"> ' + get_airport_name(air_bagic_info[2]) + '] ';
    go_air_info1 += get_air_img(air_bagic_info[0]) + ' ' + air_bagic_info[9] + '편';

    var sdate = air_bagic_info[3].substr(0, 4) + "-" + air_bagic_info[3].substr(4, 2) + "-" + air_bagic_info[3].substr(6, 2);

    var go_air_info2 = '<span class="date">';
    go_air_info2 += air_bagic_info[3].substr(0, 4) + '년 ' + air_bagic_info[3].substr(4, 2) + '월 ' + air_bagic_info[3].substr(6, 2) + '일';
    go_air_info2 += '(' + get_yoil(sdate) + ') ';
    go_air_info2 += air_bagic_info[4].substr(0, 2) + "시 " + air_bagic_info[4].substr(2, 2) + "분";
    go_air_info2 += '</span>';
    go_air_info2 += ' | ';
    go_air_info2 += '<span class="seat">' + seat_type + '</span>';

    //가격정보 셋팅
    var applied_price = air_adult_info[1] + "|" + air_child_info[1];
    var add_price = air_adult_info[4] + "|" + air_child_info[4];
    var airport_price = air_adult_info[3] + "|" + air_child_info[3];
    var total_price = air_adult_info[5] + "|" + air_child_info[5];

    if(trip_type == "go") {     //가는편이면

        //선택항공권정보 초기화
        $("input[name=step2_come_air_info]").val("");
        $("#choice_air_info div.come h4 span:eq(0)").html('');
        // 값 정보 초기화
        price_apply("come","1|1","0|0","0|0","0|0","0|0");
        // 항공사 검색 출력
        $('#avComSection').removeClass('hide');
        // 항공 리스트 출력
        $('#avListSection').removeClass('hide');
        // 선택 정보 숨김
        $('#avSelectSection').addClass('hide');
        $('#comeSelAirDiv').addClass('hide');

        $("#goSelAirInfo").html(go_air_info1);
        $("#goSelDatetimeInfo").html(go_air_info2);

        price_apply("go","1|1",applied_price,add_price,airport_price,total_price);

        $("input[name=step2_go_air_info]").val(reserve_info_str);
        // back 버튼을 위한 정보 셋팅
        go_key_info = key;
        go_reserve_info = reserve_info_str;
        go_seat_type = seat_type;
        // 가는편 정보
        var goSelectInfo = '<div><span class="zone">' + go_air_info1 + '</span></div>';
        goSelectInfo += '<div>' + go_air_info2 + '</div>';

        $('#goSelectInfo').html(goSelectInfo);

        if (g_trip_type == "OW") {
            // 선택 정보 출력
            $('#avSelectSection').removeClass('hide');
            // 선택 정보 top 이동
            $("html body").animate({scrollTop:1},1000);
            // 항공사 검색 숨김
            $('#avComSection').addClass('hide');
            // 항공 리스트 숨김
            $('#avListSection').addClass('hide');
        } else {
            load_come_air_list('jl');
            // 제주닷컴 항공 비활성화 처리
            if(g_trip_type != "OW") {
                $('#jcAirList').addClass('hide');
            }
        }
        // 뒤로가기 href 변경
        $("#gotoBackBtn").prop('href', 'javascript:location.reload();');

    } else if(trip_type == "come") {      //오는편이면
        $("#comeSelAirInfo").html(go_air_info1);
        $("#comeSelDatetimeInfo").html(go_air_info2);

        price_apply("come","1|1",applied_price,add_price,airport_price,total_price);

        $("input[name=step2_come_air_info]").val(reserve_info_str);
        // 선택 정보 출력
        $('#avSelectSection').removeClass('hide');
        $('#comeSelAirDiv').removeClass('hide');
        // 선택 정보 top 이동
        $("html body").animate({scrollTop:1},1000);
        // 가능 항공편 검색 정보 숨김
        $('#goSelectSection').addClass('hide');
        // 항공사 검색 숨김
        $('#avComSection').addClass('hide');
        // 항공 리스트 숨김
        $('#avListSection').addClass('hide');
        // 뒤로가기 href 변경
        $("#gotoBackBtn").prop('href', 'javascript:apply_pay("go", "' + go_reserve_info + '", "' + go_key_info + '", "' + go_seat_type + '");');
    }
    // 선택한 항공 음영 처리
    //$('.' + trip_type + '_tr').removeClass("active");
    //$('#jl_' + key).addClass("active");
}

//선택한 제주닷컴 항공편 정보 셋팅
function jc_apply_pay(trip_type, reserve_info_str, rev_id, key)
{
    /* 최종형태
    * 일자|요일|출발지|도착지|출발시간|항공사 코드|항공기번호|좌석정보
    * @성인적용요금|성인유류할증료|성인공항이용료|성인총요금
    * @소아적용요금|소아유류할증료|소아공항이용료|소아총요금
    */
    $('#search_com').val('jc');
    // 판매처 출력
    $('#airLogoTitle').text("제주닷컴");
    $('#airCompany').removeClass('hide');
    $('#airLogoImg').removeClass('hide').attr("src", "/images/mw/air/jejucom.jpg");

    var air_bagic = "";
    var air_adult = "";
    var air_child = "";
    var seat_type = "";
    //1. 기본정보, 성인가격, 소인가격 분리
    if(reserve_info_str) {
        var tmp_arr1 = reserve_info_str.split("@");
        air_bagic = tmp_arr1[0];
        air_adult = tmp_arr1[1];
        air_child = tmp_arr1[2];
        seat_type = reserve_info_str.split("|")[11].split("@")[0];
    }
    //2. 기본정보 분리
    var air_bagic_info = air_bagic.split("|");
    //3. 성인가격정보 분리
    var air_adult_info = air_adult.split("|");
    //4. 소인가격정보 분리
    var air_child_info = air_child.split("|");

    //선택여정에 출력할 내용
    var go_air_info1 = '[' + air_bagic_info[2] + ' <img src="/images/mw/icon/arrow/air.png" class="airline" alt="오른쪽 방향 화살표"> ' + air_bagic_info[3] + '] ';
    go_air_info1 += get_air_img(air_bagic_info[5]) + ' ' + air_bagic_info[6] + '편';

    var go_air_info2 = '<span class="date">';
    go_air_info2 += air_bagic_info[0].substr(0, 4) + '년 ' + air_bagic_info[0].substr(5, 2) + '월 ' + air_bagic_info[0].substr(8, 2) + '일';
    go_air_info2 += '(' + air_bagic_info[1] + ') ';
    go_air_info2 += air_bagic_info[4].substr(0, 2) + '시 ' + air_bagic_info[4].substr(3, 2) + '분';
    go_air_info2 += '</span>';
    go_air_info2 += ' | ';
    go_air_info2 += '<span class="seat">' + seat_type + '</span>';

    //가격정보 셋팅
    var applied_price = air_adult_info[0] + "|" + air_child_info[0];
    var add_price = air_adult_info[1] + "|" + air_child_info[1];
    var airport_price = air_adult_info[2] + "|" + air_child_info[2];
    var total_price = air_adult_info[3] + "|" + air_child_info[3];

    //TW|GMP|CJU|20151212|1025|20151212|1130
    var air_info_str = new Array(air_bagic_info[5], air_bagic_info[7], air_bagic_info[8], air_bagic_info[0].replace(/-/g,''), air_bagic_info[4].replace(':', ''), air_bagic_info[9].replace(/-/g,''), air_bagic_info[10].replace(':', ''));

    if(trip_type == "go") {     //가는편이면
        $('#jcAirList').removeClass('hide');
        //선택항공권정보 초기화
        $("input[name=step2_come_air_info]").val("");
        $("#choice_air_info div.come h4 span:eq(0)").html('');
        // 값 정보 초기화
        price_apply("come","1|1","0|0","0|0","0|0","0|0");
        // 항공사 검색 출력
        $('#avComSection').removeClass('hide');
        // 항공 리스트 출력
        $('#avListSection').removeClass('hide');
        // 선택 정보 숨김
        $('#avSelectSection').addClass('hide');
        $('#comeSelAirDiv').addClass('hide');

        $("#goSelAirInfo").html(go_air_info1);
        $("#goSelDatetimeInfo").html(go_air_info2);

        price_apply("go","1|1",applied_price,add_price,airport_price,total_price);

        $("input[name=id_1]").val(rev_id);
        $("input[name=step2_go_air_info]").val(air_info_str.join("|"));

        // 가는편 정보
        var goSelectInfo = '<div><span class="zone">' + go_air_info1 + '</span></div>';
        goSelectInfo += '<div>' + go_air_info2 + '</div>';

        $('#goSelectInfo').html(goSelectInfo);

        if (g_trip_type == "OW") {
            // 선택 정보 출력
            $('#avSelectSection').removeClass('hide');
            // 선택 정보 top 이동
            $("html body").animate({scrollTop:1},1000);
            // 항공사 검색 숨김
            $('#avComSection').addClass('hide');
            // 항공 리스트 숨김
            $('#avListSection').addClass('hide');
        } else {
            load_come_air_list('jc');
            go_top();
            // 뒤로가기 href 변경
            $("#gotoBackBtn").prop('href', 'javascript:location.reload();');
        }
    } else if(trip_type == "come") {      //오는편이면
        $("#comeSelAirInfo").html(go_air_info1);
        $("#comeSelDatetimeInfo").html(go_air_info2);

        price_apply("come","1|1",applied_price,add_price,airport_price,total_price);

        $("input[name=id_2]").val(rev_id);
        $("input[name=step2_come_air_info]").val(air_info_str.join("|"));

        // 선택 정보 출력
        $('#avSelectSection').removeClass('hide');
        $('#comeSelAirDiv').removeClass('hide');
        // 선택 정보 top 이동
        $("html body").animate({scrollTop:1},1000);
        // 가능 항공편 검색 정보 숨김
        $('#goSelectSection').addClass('hide');
        // 항공사 검색 숨김
        $('#avComSection').addClass('hide');
        // 항공 리스트 숨김
        $('#avListSection').addClass('hide');
        // 뒤로가기 href 변경
        $("#gotoBackBtn").prop('href', 'javascript:jc_apply_pay("go", "' + reserve_info_str + '", "' + rev_id + '", "' + key + '");');
    }

    list_sorting();
}

//항공권 다시 선택
function air_choice_reset()
{
    if(g_trip_type == "RT"){
        $("#flight_list").remove();
        $("#goWrap tbody").before('<tbody id="flight_list"><div id="init_descr_div" class="no-item hide"></div></tbody>')
    }else{
        $('#flight_list').css("display","block");
    }
    $('#flight_list2').css("display","none");
    $('#search_com').val('');
    $('#search_flag').val('go');
    $('#airCompany').addClass('hide');
    $('#jcAirList').removeClass('hide');

    // JL항공 전역변수 초기화
    go_key_info = "";
    go_reserve_info = "";
    go_seat_type = "";

    //선택항공권정보 초기화
    $("input[name=step2_go_air_info]").val("");
    $("input[name=step2_come_air_info]").val("");
    $("#choice_air_info div.go h4 span:eq(0)").html('＊ 1인 기준 요금입니다.');
    $("#choice_air_info div.come h4 span:eq(0)").html('');
    // 가는편 항공 정보 초기화
    $('#goSelectInfo').html('');
    // 값 정보 초기화
    price_apply("go","1|1","0|0","0|0","0|0","0|0");
    price_apply("come","1|1","0|0","0|0","0|0","0|0");
    // 항공사 검색 출력
    $('#avComSection').removeClass('hide');
    // 항공 리스트 출력
    $('#avListSection').removeClass('hide');
    // 선택 정보 숨김
    $('#avSelectSection').addClass('hide');
    $('#comeSelAirDiv').addClass('hide');

    // 기존 go_tr, come_tr 완전 제거
    $('.go_tr').remove();
    $('.come_tr').remove();

    load_go_air_list();

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

//좌석코드로 좌석 class명칭 추출
function get_seat_type(seat_type)
{
    if(seat_type == "N@S@B") {
        return "전체";
    } else if(seat_type == "N") {
        return "일반석";
    } else if(seat_type == "S") {
        return "할인석";
    } else if(seat_type == "B") {
        return "비즈니스석";
    }
}

//공항코드로 공항명칭 추출
function get_airport_name(airport)
{
    if(airport == "GMP") {
        return "김포";
    } else if(airport == "CJU") {
        return "제주";
    } else if(airport == "PUS") {
        return "부산";
    } else if(airport == "TAE") {
        return "대구";
    } else if(airport == "KWJ") {
        return "광주";
    } else if(airport == "CJJ") {
        return "청주";
    } else if(airport == "MWX") {
        return "무안";
    } else if(airport == "RSU") {
        return "여수";
    } else if(airport == "USN") {
        return "울산";
    } else if(airport == "HIN") {
        return "진주";
    } else if(airport == "KUV") {
        return "군산";
    } else if(airport == "KPO") {
        return "포항";
    } else if(airport == "WJU") {
        return "원주";
    } else if(airport == "ICN") {     //2016-03-21 아시아나 추가 하면서 추가됨 (ksb1110@gmail.com)
        return "인천";
    }
}

//항공사코드로 이미지정보 추출
function get_air_img(airline)
{
    var img = "";

    if(airline == "KE") {       //대한항공
        img = "<img src='/images/mw/air/line1.gif' class='airline' alt='대한항공'> 대한항공";
    } else if(airline == "OZ") {      //아시아나
        img = "<img src='/images/mw/air/line2.gif' class='airline' alt='아시아나'> 아시아나";
    } else if(airline == "LJ") {      //진에어
        img = "<img src='/images/mw/air/line3.gif' class='airline' alt='진에어'> 진에어";
    } else if(airline == "BX") {      //에어부산
        img = "<img src='/images/mw/air/line4.gif' class='airline' alt='에어부산'> 에어부산";
    } else if(airline == "ZE") {      //이스타항공
        img = "<img src='/images/mw/air/line5.gif' class='airline' alt='이스타항공'> 이스타항공";
    } else if(airline == "TW") {      //티웨이항공
        img = "<img src='/images/mw/air/line6.gif' class='airline' alt='티웨이항공'> 티웨이항공";
    } else if(airline == "7C") {      //제주항공
        img = "<img src='/images/mw/air/line7.gif' class='airline' alt='제주항공'> 제주항공";
    } else if(airline == "RS") {      //에어서울
        img = "<img src='/images/mw/air/line8.gif' class='airline' alt='에어서울'> 에어서울";
    } else if(airline == "4V") {      //플라이강원
        img = "<img src='/images/mw/air/line9.gif' class='airline' alt='플라이강원'> 플라이강원";
    } else if(airline == "RF") {      //에어로케이
        img = "<img src='/images/mw/air/line10.gif' class='airline' alt='에어로케이'> 에어로케이";
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

    if(trip_type == "go") {             //가는편인 경우
        $("#choice_air_info div.go-wrap div.air-price table tbody tr:eq(0) td:eq(0)").html("성인 " + adult_cnt + "명");
        $("#choice_air_info div.go-wrap div.air-price table tbody tr:eq(1) td:eq(0)").html(formatNumber(adult_applied_price) + "원");
        $("#choice_air_info div.go-wrap div.air-price table tbody tr:eq(2) td:eq(0)").html(formatNumber(adult_add_price) + "원");
        $("#choice_air_info div.go-wrap div.air-price table tbody tr:eq(3) td:eq(0)").html(formatNumber(adult_airport_price) + "원");
        $("#choice_air_info div.go-wrap div.air-price table tbody tr:eq(4) td:eq(0)").html(formatNumber(adult_total_price) + "원");

        $("#choice_air_info div.go-wrap div.air-price table tbody tr:eq(0) td:eq(1)").html("소아 " + child_cnt + "명");
        $("#choice_air_info div.go-wrap div.air-price table tbody tr:eq(1) td:eq(1)").html(formatNumber(child_applied_price) + "원");
        $("#choice_air_info div.go-wrap div.air-price table tbody tr:eq(2) td:eq(1)").html(formatNumber(child_add_price) + "원");
        $("#choice_air_info div.go-wrap div.air-price table tbody tr:eq(3) td:eq(1)").html(formatNumber(child_airport_price) + "원");
        $("#choice_air_info div.go-wrap div.air-price table tbody tr:eq(4) td:eq(1)").html(formatNumber(child_total_price) + "원");
        //계산용 가격 input 셋팅
        $("input[name=go_adult_total_price]").val(adult_total_price);
        $("input[name=go_child_total_price]").val(child_total_price);

    } else if(trip_type == "come") {            //오는편인 경우
        $("#choice_air_info div.come-wrap div.air-price table tbody tr:eq(0) td:eq(0)").html("성인 " + adult_cnt + "명");
        $("#choice_air_info div.come-wrap div.air-price table tbody tr:eq(1) td:eq(0)").html(formatNumber(adult_applied_price) + "원");
        $("#choice_air_info div.come-wrap div.air-price table tbody tr:eq(2) td:eq(0)").html(formatNumber(adult_add_price) + "원");
        $("#choice_air_info div.come-wrap div.air-price table tbody tr:eq(3) td:eq(0)").html(formatNumber(adult_airport_price) + "원");
        $("#choice_air_info div.come-wrap div.air-price table tbody tr:eq(4) td:eq(0)").html(formatNumber(adult_total_price) + "원");

        $("#choice_air_info div.come-wrap div.air-price table tbody tr:eq(0) td:eq(1)").html("소아 " + child_cnt + "명");
        $("#choice_air_info div.come-wrap div.air-price table tbody tr:eq(1) td:eq(1)").html(formatNumber(child_applied_price) + "원");
        $("#choice_air_info div.come-wrap div.air-price table tbody tr:eq(2) td:eq(1)").html(formatNumber(child_add_price) + "원");
        $("#choice_air_info div.come-wrap div.air-price table tbody tr:eq(3) td:eq(1)").html(formatNumber(child_airport_price) + "원");
        $("#choice_air_info div.come-wrap div.air-price table tbody tr:eq(4) td:eq(1)").html(formatNumber(child_total_price) + "원");
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
    var adult_cnt = $("#adult_cnt").val();
    adult_cnt = eval(adult_cnt) + 0;
    //소아수
    var child_cnt = $("#child_cnt").val();
    child_cnt = eval(child_cnt) + 0;
    //유아수
    var baby_cnt = $("#baby_cnt").val();
    baby_cnt = eval(baby_cnt) + 0;
    //인원수를 곱한 총 가격은
    var total_price = adult_cnt * (go_adult_total_price + come_adult_total_price) + child_cnt * (go_child_total_price + come_child_total_price);
    var total_price_commma = formatNumber(total_price);
    //가격 셋팅
    $("#totalPrice").html(total_price_commma + "원");
}

//가격형태로 변경
function formatNumber(num)
{
    return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");
}

//예약2단계로 이동
function go_reserve_step2()
{
    //가는항공권 선택여부 체크
    var go_air_info = $.trim($("input[name=step2_go_air_info]").val());

    if(go_air_info.length < 1) {
        alert("가는 항공편을 선택하세요.");
        return false;
    }
    //왕복이면
    if(g_trip_type == "RT") {
        //오는항공권 선택여부 체크
        var come_air_info = $.trim($("input[name=step2_come_air_info]").val());

        if(come_air_info.length < 1) {
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
        if(gab_min < 40) {
            alert("가는 여정의 도착시간과 오는 여정의 출발시간은 40분 이상 차이를 두어야 합니다. 다른 항공편을 선택하여 주시기 바랍니다.");
            return false;
        }
    }

    if ($("label[for=" + $("input:radio[class=chk_jc]:checked").attr("id") + "]").text() == '제주닷컴') {
        $("form[name=jejucom_reserve]").submit();
    } else if ($("label[for=" + $("input:radio[class=chk_jc]:checked").attr("id") + "]").eq(0).text() == '선민투어') {
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
        //	document.write($("form[name=reserve_step1_form]").serialize());
        $("form[name=reserve_step1_form]").submit();
    }
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
    if (sDate.length != 10 || eDate.length != 10) {
        return null;
    }
    // FORMAT이 있는지 체크
    if (sDate.indexOf(FORMAT) < 0 || eDate.indexOf(FORMAT) < 0) {
        return null;
    }
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

    if(chkDate < 0 ) {
        //alert("종료시간이 시작시간 이전이면 안됩니다. 다시 확인하세요.");
        //return false;
    }
    return (to_dt.getTime() - from_dt.getTime()) / 1000 / 60;
}