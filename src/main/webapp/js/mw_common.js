/* ====================================================================================================================
* browser start
* ====================================================================================================================*/
//HTML5 표준이 정해져 있다.
var winWidth = window.innerWidth,                                       //창가로 사이즈
    winHeight = window.innerHeight,                                     //창세로 사이즈
    bodyScoll = $(window).scrollTop();                                  //스크롤 위치

//쿠키 생성
/*function setCookie(cName, cValue, cDay){
	$.cookie(cName, escape(cValue), {expires: cDay, path: "/"});
}*/

//상단 Top Banner Close (앱설치 배너)
function appLinkClose() {
	var obj = '#app_link_banner';											//target
	var cookieName = 'appLink';									//쿠키이름
	
	if($.cookie(cookieName)) {
		$(obj).remove();
	}
	
	$("#app_link_close").click(function() {
		$(obj).remove();
		$.cookie(cookieName, 'close', {expires: 1, path: "/"});
		return false;
	});
}

//Frame Side Menu Event
function frameSideMenu() {
	var closeObj = '#frame_sideClose';
	var closeObj2 = '#frame_sideClose2';
	var TargetObj = '#side_menu';

	//하단 sideOpen 추가 chaewan.jung 2021.05.13
	$("#frame_sideOpen, #frame_sideOpen2").on('click', function() {
		$(TargetObj).show();
		$('.purchase-area').css('z-index', '1');						//구매하기 옵션 Swipe Up Header 메뉴 가려지는 현상에 따른 추가
	});

	$(closeObj).on('click', function() {
		$(TargetObj).hide();
		$('.purchase-area').css('z-index', '38');						//구매하기 옵션 Swipe Up Header 메뉴 가려지는 현상에 따른 추가
	});

	$(closeObj2).on('click', function() {
		$(TargetObj).hide();
		$('.purchase-area').css('z-index', '38');						//구매하기 옵션 Swipe Up Header 메뉴 가려지는 현상에 따른 추가
	});
	
	//Side Search
	$('#top_searchOpen').on('click', function() {
		$('#top_search').show();
	});
	
	$('#top_searchClose').on('click', function() {
		$('#top_search').hide();
	});
}

//Main Page Swipe Up Event
function hasScrolled() {												//동작구현
    var st = $(this).scrollTop();										//현재 스크롤위치 저장
    var obj = '#fixed_head';											//해당 Object

    if(Math.abs(lastScrollTop - st) <= delta) return;					//delta 값보다 더 스크롤 되었는지 확인
    if (st > lastScrollTop) {
        // Scroll Down
    	$(obj).removeClass('active');
    } else {
        if(st <= 480) {
        	$(obj).removeClass('active');
        } else {
        	// Scroll Up
            if(st + $(window).height() < $(document).height()) {
                $(obj).addClass('active');
            }
        }
    }
    lastScrollTop = st;
}

//Sub Page Swipe Up Event
/*function hasScrolled2() {												//동작구현
    var st = $(this).scrollTop();										//현재 스크롤위치 저장
    var obj = '#header';												//해당 Object

    if(Math.abs(lastScrollTop - st) <= delta) return;					//delta 값보다 더 스크롤 되었는지 확인
    if (st > lastScrollTop) {
        // Scroll Down
    	$(obj).removeClass('active');
    } else {
        if(st <= 100) {
        	$(obj).removeClass('active');
        } else {
        	// Scroll Up
            if(st + $(window).height() < $(document).height()) {
            	$(obj).addClass('active');
            }
        }
    }
    lastScrollTop = st;
}*/

//상단 프레임 체크
/*function frameCheck() {
	var detailPageCheck = $('.mw-detail-area').length;						//상세페이지 체크
	
	if(detailPageCheck == 1) {
		$('#header').addClass('transBG');
		$('#header .head-wrap .title').hide();
	}
}*/

//Nav Auto width Scroll Menu
function navMenuScroll() {
	var winWidth = $(window).width();
	var menuWidth = 0;
	var obj = '#scroll_menuA';
	
	$(obj + ' li').map(function(){
		menuWidth = menuWidth + $(this).outerWidth(true);
	});
	
	if(winWidth < menuWidth) {
		// + 15px to fix, this maybe vary in your project
		$(obj + ' ul').css('width', (menuWidth+35));
		$(obj).append('<span class="side-bg"></span>'); 					//우측 숨김처리
	}
}

/* 하단으로 이동
//상단으로 가기 (Top Button)
function topBTN_event() {
	var topScroll = $(this).scrollTop();

	if(topScroll > 400) {
		$('#go_top').fadeIn('500');
	}
	else {
		$('#go_top').fadeOut('100');
	}
}
*/
/* ====================================================================================================================
* scroll event
* ====================================================================================================================*/
var didScroll,
	start = 200;														//스크롤 시작 이벤트 위치

//Main Swipe Up Event
var lastScrollTop = 0,
	delta = 5; 															//동작시작위치
	navbarHeight = $('#fixed_head').outerHeight();						//동작요소
	
$(window).scroll(function(event) {
    didScroll = true;													//스크롤 이벤트 부하에 따른 setInterval 사용
});
/* ====================================================================================================================
* setInterval
* ====================================================================================================================*/
/*setInterval(function() {
    if (didScroll) {
    	
        //Main Or Sub Page Check
        var mainCheck = $('#main_area').size();
        if(mainCheck > 0) {												//메인페이지인 경우
            if($("#fixed_head").size() > 0) {hasScrolled();}			//상단메뉴바 고정
        }
        else {															//서브페이지인 경우
        	hasScrolled2();												//Header 고정
        }
        
        topBTN_event();													//Top Button(상단으로 이동)
        didScroll = false;
    }
}, 250);*/
/* ====================================================================================================================
* document ready
* ====================================================================================================================*/
$(document).ready(function() {
    
	//상단 Top Banner (App Link)
	if($("#app_link_banner ul li").length > 0) {
		appLinkClose();
	}

	//Frame Side Menu
	frameSideMenu();

	//상단 프레임 체크
	/*frameCheck();*/

	//Menu Auto Scroll X
	if($('#scroll_menuA').length > 0) {
		navMenuScroll();
	}

	//Top Button
	if($('#go_top').length > 0) {
		$('#go_top').on('click', function(){
			$('html, body').animate({scrollTop: 0}, 400);
			return false;
		});
	}
});
/* ====================================================================================================================
* window resize
* ====================================================================================================================*/
$(window).resize(function(){
	if(this.resizeTO) {
		clearTimeout(this.resizeTO);
	}
	this.resizeTO = setTimeout(function() {
		$(this).trigger('resizeEnd');
	}, 300);
});

$(window).on('resizeEnd', function() {
	//Menu Auto Scroll X
	if($('#scroll_menuA').length > 0) {navMenuScroll();}
});
/* ====================================================================================================================
* Phone 가로모드
* ====================================================================================================================*/
/*
$(window).on("orientationchange", function() {  
});
*/