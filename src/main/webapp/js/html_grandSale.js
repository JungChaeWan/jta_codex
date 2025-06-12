/* ====================================================================================================================
* Browser start
* ====================================================================================================================*/
//HTML5 표준이 정해져 있다.
var winWidth = window.innerWidth;
var winHeight = window.innerHeight;



//브라우저 버전 체크
var IEVersionCheck = function() {

    var word,
        version = "N/A",
        agent = navigator.userAgent.toLowerCase(),
        name = navigator.appName;

    // IE old version ( IE 10 or Lower )
    if ( name == "Microsoft Internet Explorer" ) word = "msie ";

    else {
        // IE 11
        if ( agent.search("trident") > -1 ) word = "trident/.*rv:";

        // IE 12  ( Microsoft Edge )
        else if ( agent.search("edge/") > -1 ) word = "edge/";
    }

    var reg = new RegExp( word + "([0-9]{1,})(\\.{0,}[0-9]{0,1})" );
    if (  reg.exec( agent ) != null  )
        version = RegExp.$1 + RegExp.$2;

    return version;
};





/* ====================================================================================================================
* Function
* ====================================================================================================================*/
//Tab Menu (Target scroll)
function targetTabMenu() {
	var obj = '#navi_tabMenu .tab-menu-wrapper';
	
	/*
	$(obj + ' a').on('click', function(event) {
		event.preventDefault();
        $('html, body').animate({scrollTop:$(this.hash).offset().top}, 500);
	});
	*/
	
	$('#tabs-2').hide();
	
	$(obj + ' a').on('click', function(event) {
		var target = $(this).attr('href');
		
		if($(target).is(":hidden")) {
			$('.tabPanel').hide();
			$(target).show();
			
			$('.tab-menu-wrapper .menu-list li').removeClass('active');
			$(this).parent('li').addClass('active');
		}
		
		$("html, body").scrollTop(0);
		
		return false;
	});
}


//할인업체 이동
function moveSale() {
	$('#tabs-1').hide();
	$('#tabs-2').show();
	
	$('.tab-menu-wrapper .menu-list li').removeClass('active');
	$('.tab-menu-wrapper .menu-list li.sale').addClass('active');
	
	$("html, body").scrollTop(0);
}





/* ====================================================================================================================
* Scroll event
* ====================================================================================================================*/
var didScroll;
var start = 200;																	//스크롤 시작 이벤트 위치

$(window).scroll(function(event) {
    didScroll = true;																//스크롤 이벤트 부하에 따른 setInterval 사용
});



//탭메뉴 초기 위치값
function tabMenuOffset() {
	var tabMenuTarget = $('.tab-menu-wrapper').offset().top;						//해당 Object > 탭메뉴 초기 위치값
	return tabMenuTarget;
}



//상단 검색바 고정
function scrollFixedItem() {
	var obj2 = '.tab-menu-wrapper';													//해당 Object > 탭메뉴
	var scltop = $(window).scrollTop();												//현재 스크롤 위치값
	
	//탭메뉴 있는 경우
	if($(obj2).length > 0) {
		var tabMenuTarget = $(obj2).offset().top;									//탭메뉴 위치값
		var defaultTabOffset = tabMenuOffset();										//해당 Object > 탭메뉴 초기 위치값
		
		//Tab Menu Scroll Fixed
		if(tabMenuTarget <= scltop) {			
			$(obj2).addClass('scrollTop');
		}
		if (!(defaultTabOffset <= scltop)) {			
			$(obj2).removeClass('scrollTop');
		}
		
		//Tab Menu Scroll Active
		/*
		$(obj2 + ' .menu-list li').each(function(index, item) {
			var aTarget = $('a', this).attr('href');
			var aTargetTop = $(aTarget).offset().top-110;
			
			if(aTargetTop <= scltop) {
				$(obj2 + ' .menu-list li').removeClass('active');
				$(this).addClass('active');
			}
        });
        */
	}
}



/* ====================================================================================================================
* SetInterval
* ====================================================================================================================*/
setInterval(function() {
    if (didScroll) {
        scrollFixedItem();														//탭메뉴 고정
        didScroll = false;
    }
}, 300);





/* ====================================================================================================================
* document ready
* ====================================================================================================================*/
$(document).ready(function() {
	
	//IE 하위 브라우저시 실행
    if(IEVersionCheck() == 9 || IEVersionCheck() == 8 || IEVersionCheck() == 7 || IEVersionCheck() == 5) {
        var error_browser = '';
        error_browser += '<div class="not-browser">';
        error_browser += '  <div class="warning"><span></span></div>';
        error_browser += '  <h1 class="error-title">현재 사용중인 브라우저는 지원되지 않습니다.<br><span class="sub">(In this broser isn&#39;t supported.)</span></h1>';
        error_browser += '  <p class="error-text">Microsoft의 지원 종료 된 브라우저를 사용하고 있습니다.</p>';
        error_browser += '  <p class="error-text">최신 버전의 Internet Explorer, Chroem, Safari, Firefox, Microsoft Edge<br>브라우저를 이용해 주세요.</p>';
        error_browser += '</div>';

        $('body').html(error_browser);
    }
    else {
    	targetTabMenu();
    }
    
});

















