/* -------------------- window size -------------------- */
/* HTML5 표준이 정해져 있다. */
// 가로 길이
var winWidth = window.innerWidth;
//window.outerWidth;
//세로길이
var winHeight = window.innerHeight;
//window.outerHeight;

/* ---------------------------------------- style common ---------------------------------------- */
/* input calendar */
/*$(function() {
	$( ".datepicker" ).datepicker({
		dateFormat: 'yy-mm-dd', //날짜 구분
		monthNames: ['1','2','3','4','5','6','7','8','9','10','11','12'],
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNamesMin: ['일','월','화','수','목','금','토'],
		changeMonth: false, //월변경가능
		changeYear: false, //년변경가능
		showMonthAfterYear: true, //년 뒤에 월 표시
		yearSuffix: '.',
		// 달력 아이콘
        showOn: "button",
		buttonImage: "../images/web/icon/calendar_icon01.gif",
        buttonImageOnly: true
	});
});*/

//Tab Menu (target scroll)
function targetTabMenu(obj) {
	$(obj + ' a').on('click', function(event) {
		event.preventDefault();
        $('html, body').animate({scrollTop:$(this.hash).offset().top}, 500);
	});
}

//Item Show
function itemSingleShow(obj) {
	$(obj).show();
}

//Item Hide
function itemSingleHide(obj) {
	$(obj).hide();
	$('.lock-bg').remove();
	$("html, body").removeClass("not_scroll");
}

//layer popup (타켓지정)
function layer_popup(obj) {
    if($(obj).is(":hidden")) {
        $(obj).show();															//레이어팝업 show
        $('body').append('<div class="lock-bg"></div>'); 						//검은 불투명 배경 show

        //position > absolute에 따른 높이 제어
        var winHeight = $(window).height()/2,
            objHeight = $(obj).height()/2,
            scrollHeight = $(document).scrollTop(),
            winHeight2 = $(window).height(),
            scrollHeight2 = $(window).scrollTop(),
            popupHeight = $('.comm-layer-popup').outerHeight(true);

        if(scrollHeight2 < 100 || winHeight2 < popupHeight) {						//스크롤 값이 없는경우 혹은 팝업크기보다 작은경우 실행
			$('.comm-layer-popup').animate( {'top' : '50px'}, 200);					//top이 0인경우
          	//position relative에 따른 추가 스타일
            $('.subContainer, .Fasten, .static, .subContents .detail').css('position', 'static');
        }
        else {
            $('.comm-layer-popup').animate( {'top' : scrollHeight + winHeight - objHeight - 10}, 200);
          	//position relative에 따른 추가 스타일
            $('.subContainer, .Fasten, .static, .subContents .detail, .inner').css('position', 'static');
        }

        //배경클릭시 닫기
        $('.lock-bg').click(function(){
            $(obj).hide();
            $(this).remove();
            $('.comm-layer-popup').css('top', '0px');								//애니에 따른 추가
            
          //position relative에 따른 추가 스타일
            $('.subContainer, .Fasten, .static, .subContents .detail, .inner').css('position', 'relative');
        });
    }
    else {
        $(obj).hide();
        $('.lock-bg').remove();
        $('.comm-layer-popup').css('top', '0px');									//애니에 따른 추가
        
      //position relative에 따른 추가 스타일
        $('.subContainer, .Fasten, .static, .subContents .detail').css('position', 'relative');
    }

    //자동 닫기 추가
    $(obj+' .close').on('click', function() {
        $(obj).hide();
        $('.lock-bg').remove();
        $('.comm-layer-popup').css('top', '0px');									//애니에 따른 추가
        
      //position relative에 따른 추가 스타일
        $('.subContainer, .Fasten, .static, .subContents .detail').css('position', 'relative');
    });
}

function layer_close(obj) {
    $(obj).hide();
    $('.lock-bg').remove();
    $('.comm-layer-popup').css('top', '0px');										//애니에 따른 추가
}

/* payAccordion */
function payAccordion() {
	var speed = 300;
	$('.payAccordion .downBT').click(function(event) {
		if ($(this).parent().next('dd').css('display')=='none') {
			$('.payAccordion dd').slideUp(speed);
			$(this).parent().next('dd').slideDown(speed);
		}
		else {
			$(this).parent().next('dd').slideUp(speed);
		}		
	});
};

/* default Accordion */
function accordion() {
	var speed = 300;
	$('.default-accordion dt').click(function(event) {
		if ($(this).next('dd').css('display')=='none') {
			$('.default-accordion dd').slideUp(speed);
			$(this).next('dd').slideDown(speed);
		} else {
			$('.default-accordion dd').slideUp(speed);
            $(".memoWrap").removeClass("open");
		}
	});
};

/* tab panel (detailTabMenu1) */
function tabPanel(params) {
	var defaults = {
		container:"#tabs", //item wrap id
		firstItem:"#tabs-1" //first show item
	};
	for (var def in defaults) { //array object 확인
		if (typeof params[def] === 'undefined') {
			params[def] = defaults[def];
		}
		else if (typeof params[def] === 'object') {
			for (var deepDef in defaults[def]) {
				if (typeof params[def][deepDef] === 'undefined') {
					params[def][deepDef] = defaults[def][deepDef];
				}
			}
		}
	};
	
	//변수선언
	var item = params.container+' ';
	var firstItem = params.firstItem;
	
	$(item + ' .tabPanel').css('display','none');
	$(firstItem).css('display', 'block');
	
	$(item+'.menuList a').click(function() {
		var show = $(this).attr('href');
		//메뉴 css 추가
		$(item+'.menuList a').removeClass('select');
		$(this).addClass('select');
		//tab panel show, hide
		$(item+' .tabPanel').css('display', 'none');
		$(show).css('display', 'block');
		
		return false;
	});
};

//tab panel (detailTabMenu1)
function tabPanel2(params) {
	var defaults = {
		container: "#tabs", 	//item wrap id
		firstItem: "#tabs-1", 	//first show item
		active: 0, 				//ul li > menu on
		allHide: 0 				//tabPanel All Hide (0: default, 1: all hide)
	};
	for (var def in defaults) { //array object 확인
		if (typeof params[def] === 'undefined') {
			params[def] = defaults[def];
		}
		else if (typeof params[def] === 'object') {
			for (var deepDef in defaults[def]) {
				if (typeof params[def][deepDef] === 'undefined') {
					params[def][deepDef] = defaults[def][deepDef];
				}
			}
		}
	};

	//변수선언
	var item = params.container+' ';
	var firstItem = params.firstItem;
	var active = params.active;
	var allHide = params.allHide;
	
    $(item+'.nav-menu li').removeClass('active');
	$(item + '.tabPanel').css('display', 'none');								//전체 콘텐츠 hide
	$(firstItem).css('display', 'block');										//해당 콘텐츠 show
	$(item + '.nav-menu li').eq(active).addClass('active');						//해당 메뉴 active

	$(item+'.nav-menu li a').click(function() {
		var show = $(this).attr('href');
		//메뉴 css 추가
		$(item+'.nav-menu li').removeClass('active');
		$(this).parent().addClass('active');
		//tab panel show, hide
		$(item+' .tabPanel').css('display', 'none');
		$(show).css('display', 'block');

		return false;
	});
	
	//콘텐츠 전체 Hide
	if(allHide == 1) {
		$(item+'.nav-menu li').removeClass('active');
		$(item + '.tabPanel').css('display', 'none');
	}
}

/* 서브 메인 slide (관광지, 레저) */
function carousel() {
	$(".default .carousel").jCarouselLite({
		btnNext: ".default .next",
		btnPrev: ".default .prev",
		visible: 4,
		auto: 5000
	});
};

/* lock bg (클릭못하게 막기) */
function lockBG_open() {
	$('body').after('<div class="lock-bg"></div>');
};
function lockBG_close() {
	$('.lock-bg').remove();
};

/* 여행경비산출 스크롤 애니메이션 top banner */
function scrollTop(id, st_top) {
	var select_obj = id; //선택대상
	var currentPosition = parseInt($(select_obj).css("top"));
	var ani_speed = 500; //애니메이션 속도

	$(window).scroll(function() {
	    var position = $(window).scrollTop();
	    var top_scroll = st_top; //언제부터 실행할것인지
	    var total_position = position-top_scroll;

	    if (position > top_scroll) {
	        //하단으로 넘어가는 오류에 따른 추가
	        if ( $(window).scrollTop() == $(document).height() - $(window).height() ) {
	        	$(select_obj).stop();
	        } else {
	        	$(select_obj).stop().animate({"top":total_position+currentPosition+"px"},ani_speed);
	        }
	    } else {
	        $(select_obj).stop().animate({"top":"0px"},ani_speed);
	    }	    
	});
};

//팝업 닫기
/* window.close 오류에 따른 주석처리 2017-09-20
function close(id) {
    $('#'+id).hide();
}*/

//실시간 검색 옵션 팝업 오픈
function optionPopup(obj, select) {
	if($(obj).is(":hidden")) {
		$('.popup-typeA').hide();
		$('.value-text .active').removeClass('active');
		$(obj).show();
		$(select).addClass('active');
	} else {
		$('.value-text .active').removeClass('active');
		$(obj).hide();
	}
	
	//자동 닫기 추가
	$(obj+' .close').on('click', function() {
		$(obj).hide();
	});
	
	/*
	var focus = 0,
		blur = 0;
	$( ".area" ).focusout(function() {
	    focus++;
	    $('.popup-typeA').hide();
		$('.value-text .active').removeClass('active');
	}).blur(function() {
	    blur++;
	    $('.popup-typeA').hide();
		$('.value-text .active').removeClass('active');
	});
	*/
}

//실시간 검색 옵션 팝업 닫기
function optionClose(obj) {
	$('.value-text .active').removeClass('active');
	$(obj).hide();
}

//2Depth Menu
function depth2Nav() {
	var obj = '#depth2_menu .depth1 > li';
	var target = '.depth2';
	
	$(obj).each(function( index ) {
		var menuWidth = 0;
		
		//하위메뉴 Box Size
		$(this).children(target).children('li').map(function( index2 ) {
			menuWidth = menuWidth + $(this).outerWidth(true) + 10;
		});
		$(this).children(target).css('width', menuWidth);
		
		
		//하위메뉴 Position
		var boxSize = $(this).children(target).outerWidth(true) / 2;
		var titleSize = $(this).children('a').outerWidth(true) / 2;
		var boxPosition = -(boxSize - titleSize);
		
		$(this).children(target).css('left', boxPosition);
		
		//console.log('box:' + boxSize);
		//console.log('title:' + titleSize);
		//console.log(boxPosition);
	});
	
	//값 적용후 숨김처리
	$(obj).find(target).css('display', 'none');
	//$(obj).find(target).addClass('test');
	
	$(obj).hover(
        function() {
            $(this).find('.depth2').show();
            if($(this).find('.on').length == 1) {
            	
            } else {
            	$(obj + ' .on').addClass('other');
            }
        }, function() {
        	$(this).find('.depth2').hide();
        	$(obj + ' .on').removeClass('other');
        }
    );
}
/* ---------------------------------------- //style common ----------------------------------------
/* ---------------------------------------- sub01(항공) ---------------------------------------- */
//가는항공편
function airCheck1() { //선택클릭시
	$('.airCH1').click(function(){
		$('#goWrap tr').removeClass('select');
		$(this).parent().parent().addClass('select');
	});
};
//오는항공편
function airCheck2() { //선택클릭시
	$('.airCH2').click(function(){
		$('#comeWrap tr').removeClass('select');
		$(this).parent().parent().addClass('select');
	});
};
/* ---------------------------------------- //sub01(항공) ---------------------------------------- */
/* ---------------------------------------- sub02(숙박) ---------------------------------------- */
/* 갤러리 (객실 상세보기) */
function galleryView() {
	$('.viewBT').click(function(){
		$('.detail-gallery').css('display', 'none');
		$(this).next('.detail-gallery').css('display', 'block');
	});
	$('.photo_close').click(function(){
		$(this).parent().parent('.detail-gallery').css('display', 'none');
	});
};
/* ---------------------------------------- //sub02(숙박) ---------------------------------------- */
/* ---------------------------------------- sub03(렌터카) ---------------------------------------- */
/* 상세보기 */
function layerP1() {
	$('.layer-1').click(function() {
		$(this).next('.layerP1').css('display', 'block');
	});
	$('.layerP1-close').click(function() {
		$('.layerP1').css('display', 'none');
	});
};
/* ---------------------------------------- //sub03(렌터카) ---------------------------------------- */
/* ---------------------------------------- sub11(마이페이지) ---------------------------------------- */
/* side menu */
function subLeftMenu() {
	$('#sub-leftMenu .depth1 li').click(function(){
		var speed = 300;
		if($(this).children('.depth2').css('display')=='none') {
			/* content slide */
			$('#sub-leftMenu .depth1 li .depth2').slideUp(speed);
			$(this).children('.depth2').slideDown(speed);
			/* arrow */
			$('#sub-leftMenu .depth1 li').removeClass('open');
			$(this).addClass('open');
		} else {
			/*$('#sub-leftMenu .depth1 li .depth2').slideUp(speed);
			$('#sub-leftMenu .depth1 li').removeClass('open');*/
		}
	});
};
/* ---------------------------------------- //sub11(마이페이지) ---------------------------------------- */

//서브 리스트 탭 메뉴 처리
function menu_slider() {
	
	//auto width
	//var winWidth = $(window).width(),
	var winWidth = $('.top-menu-slider > .pd-wrap').width(),
		menuWidth = 0;
	
	$('#top_menu_list > li').map(function(){
		menuWidth = menuWidth + $(this).outerWidth(true);								//전체 메뉴 길이 체크
	});

	if(winWidth < menuWidth) {															//윈도우 창 크기보다 큰경우 실행
		$('#top_menu_list').css('width', (menuWidth+30));								//메뉴 가로 사이즈 입력 (+는 아이폰용)
	}
    else {
        $('#top_menu_list').css('width', 'auto');										//창크기가 클경우 가로 오토
    }
	
	// 메뉴 핸들링
	$.fn.disableBtn = function() {
		$(this).prop('disabled', true).css('opacity', '0.4');
	};
	$.fn.enableBtn = function() {
		$(this).prop('disabled', false).css('opacity', '1');
	};

	var $scrollContainer = $('#subMenuContainer'),
		containerWidth = $scrollContainer.innerWidth(),
		fullWidth = $scrollContainer[0].scrollWidth,
		$btnScrollPrev = $('#btnSubMenusPrev'),
		$btnScrollNext = $('#btnSubMenusNext');
	
	var ldown = false, rdown = false;

	$btnScrollPrev.disableBtn();
	$btnScrollNext.disableBtn();

	if(fullWidth > containerWidth) $btnScrollNext.enableBtn();
	$scrollContainer.scroll(function() {
		if($(this).scrollLeft() > 0) {
			$btnScrollPrev.enableBtn();
		} else {
			$btnScrollPrev.disableBtn();
		}

		if($(this).scrollLeft() < (fullWidth - containerWidth) ) {
			$btnScrollNext.enableBtn();
		} else {
			$btnScrollNext.disableBtn();
		}
	});
	
	$btnScrollPrev.click(function(){
		$scrollContainer.scrollLeft($scrollContainer.scrollLeft() - 50);
	});
	$btnScrollNext.click(function(){
		$scrollContainer.scrollLeft($scrollContainer.scrollLeft() + 50);
	});
	
	//2Depth menu 추가 2017-03-16
	$('.depth2-nav > li > a').on('click', function() {
		if($(this).next('.depth2').css('display')=='none') {
			$('.depth2-nav .depth2').hide();
			$(this).next('.depth2').show();
			
			//safari 2Depth menu 안보이는 현상에 따른 브라우저 공통 수정
			$('#subContent').append( "<div class='cover-bg'>Hello</div>" );
			$('#subMenuContainer').css('overflow-x', 'visible');
			$('#btnSubMenusNext').hide();
		} else {
			$('.depth2-nav .depth2').hide();
			
			//safari 2Depth menu 안보이는 현상에 따른 브라우저 공통 수정
			$('#subMenuContainer').css('overflow-x', 'auto');
			$('.cover-bg').remove();
			$('#btnSubMenusNext').show();
		}
		
		$('.depth2-nav li').removeClass('active');
		$(this).parent('li').addClass('active');
		
		return false;
	});
	
	$('.depth2-nav .depth2 .close-x').on('click', function() {
		$('.depth2-nav .depth2').hide();
		
		//safari 2Depth menu 안보이는 현상에 따른 브라우저 공통 수정
		$('#subMenuContainer').css('overflow-x', 'auto');
		$('.cover-bg').remove();
		$('#btnSubMenusNext').show();
		
		return false;
	});
	
	$('.top-menu-slider .depth2 ul li a').on('click', function() {
		$('#subMenuContainer').css('overflow-x', 'auto');
		$('.depth2-nav .depth2').hide();
		$('.cover-bg').remove();
		$('#btnSubMenusNext').show();
	});
	
}

/*$(document).ready(function() {
	//gallery view
	if($(".detail-gallery").size() > 0) {galleryView();}
	
	//payAccordion
	if($(".payAccordion").size() > 0) {payAccordion();}
	//default accordion
	//if($(".default-accordion").size() > 0) {accordion();}
	
	//렌터카 상세보기
	if($(".layerP1").size() > 0) {layerP1();}
	
	//mypage side menu
	if($("#sub-leftMenu").size() > 0) {subLeftMenu();}
	
	//2Depth Menu
	if($("#depth2_menu").size() > 0) {depth2Nav();}
		
	//Tab Menu Click Event
	if($('.nav-tabs2').size() > 0) {
		targetTabMenu('.nav-tabs2 .menuList');
	}
});*/