/* ====================================================================================================================
* browser start
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





/* -------------------- header -------------------- */
//쿠키 생성
function setCookie(cName, cValue, cDay){
    var expire = new Date();
    expire.setDate(expire.getDate() + cDay);
    cookies = cName + '=' + escape(cValue) + '; path=/ '; // 한글 깨짐을 막기위해 escape(cValue)를 합니다.
    if(typeof cDay != 'undefined') cookies += ';expires=' + expire.toGMTString() + ';';
    document.cookie = cookies;
}
//쿠키 가져오기
function getCookie(cName) {
    cName = cName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cName);
    var cValue = '';
    if(start != -1){
        start += cName.length;
        var end = cookieData.indexOf(';', start);
        if(end == -1)end = cookieData.length;
        cValue = cookieData.substring(start, end);
    }
    return unescape(cValue);
}



//상단 Top Banner slider
function topBannerSlider() {
    var bgColor,
        next = 1,
        obj = "#top_banner ul li",
        count = $(obj).size(),
        speed = 0;

    $(obj).eq(0).show();
    bgColor = $(obj).eq(0).attr('style');
    $('#top_banner').attr('style', bgColor).show();
    
    if(count > 1) {
	    start_slider();
    }
    function start_slider() {
        loop = setInterval(function(){
            if(next >= count) {
                next = 0;
            }
            
            $(obj).hide();
            $(obj).eq(next).show();
            
            bgColor = $(obj).eq(next).attr('style');
            $('#top_banner').attr('style', bgColor);
            
            next = next+1;
        }, 5000);
    }
}


//상단 Top Banner slider
function topBannerSlider2() {
	var swiper = new Swiper('#top_banner', {
	    paginationClickable: true,
	    direction: 'vertical',
	    autoplay: 5000,
	    loop: true
	});
	
}


//상단 Top Banner Close 
function topBannerClose() {
	var obj = '#top_banner',											//target
		cookieName = 'topBanner';										//쿠키이름
	
	if($.cookie(cookieName)) {
		$(obj).remove();
	}
	
	$("#top_close").click(function() {
		$(obj).remove();
		$.cookie(cookieName, 'value', {expires: 1, path: "/"});
		return false;
	});
}



//top menu
function topMenu() {
    /*var speed = 300;
    $('#topBanner').click(function() {
        $('#topBanner').slideUp(speed);
    });*/

    
    $('#topBanner .close').click(function() {
        $('#topBanner').remove();

        //right side menu
        //$('#rightAside').css('top', '140px');
    });
    
    
    
    // if(getCookie('test') == 'test10') {
    //     alert(1);
    // }
    // else {
    //     var speed = 300;
    //     $('#topBanner .close').click(function() {
    //         //쿠키로드
    //         setCookie("test", 'test10', 1);
    //         $('#topBanner').slideUp(speed);
    //     });
    // }

    
}

//main menu
function mainMenu() {
    var speed = 300;
    $('#menuBT').click(function() {
        if($('.subMenu').css('display')=='none'){
            $('.subMenu').slideDown(speed);
        }
        else {
            $('.subMenu').slideUp(speed);
        }
    });
};

//right aside
function rightAside() {
    $('#floatingBT').click(function() {
        $('#rightAside').toggleClass('rightAside-open');
    });

    //상단에 배너에 따른 시작위치 추가
    if(document.getElementById('topBanner')) {
        //$('#rightAside').css('top', '250px');
    }
    if($('#topBanner').css('display')=='none') {
        //$('#rightAside').css('top', '140px');
    }

};


/* top (상단으로 가기) */
function go_top() {
    $( '.go-top' ).click( function() {
        $( 'html, body' ).animate( { scrollTop : 0 }, 400 );
        return false;
    });
}






/* ====================================================================================================================
* scroll event
* ====================================================================================================================*/
var didScroll;
var start = 200;																//스크롤 시작 이벤트 위치

$(window).scroll(function(event) {
    didScroll = true;															//스크롤 이벤트 부하에 따른 setInterval 사용
});


//Top Button
function scroll_topBtn() {
	var scrollHeight = $(window).scrollTop();

    if(scrollHeight > 500){
        $(".go-top").fadeIn("slow");
    }
    else {
        $(".go-top").fadeOut("fast");
    }
}


//Side Banner
function asideBanner() {
	var scrollHeight = $(window).scrollTop();
	
	//leftAside (좌측 사이드 배너 고정) 
    if(scrollHeight > 300){
        $("#leftAside > ul").css({
            'position': 'fixed',
            'top': '20px'
        });

        //우측배너
        $("#rightAside > .fixed-wrap").css({
            'position': 'fixed',
            'top': '20px'
        });
    }
    else {
        $("#leftAside > ul").css({
            'position': 'static',
            'top': 'auto'
        });

        //우측배너
        $("#rightAside > .fixed-wrap").css({
            'position': 'static',
            'top': 'auto'
        });   
    }
}



//탭메뉴 초기 위치값
function tabMenuOffset() {
	var tabMenuTarget = $('.nav-tabs2').offset().top;								//탭메뉴 위치값
	return tabMenuTarget;
}


//상단 검색바 고정
function scrollFixedItem() {
	var obj = 'section.search-typeA';												//해당 Object > 검색바
	var obj2 = '.nav-tabs2';														//해당 Object > 탭메뉴
	var scltop = $(window).scrollTop();												//현재 스크롤 위치값
	
	//console.log('objHeight : ' + objHeight);
	//console.log('targetTop : ' + targetTop);
	//console.log('scltop : ' + scltop);
	
	
	if($(obj).length > 0) {															//클래스 존재시 실행
		var objHeight = $(obj).outerHeight();										//Object Height
		var targetTop = $(obj).offset().top;										//검색바 위치값
		
		if(targetTop <= scltop) {
			$('.mapLocation').css('margin-bottom', objHeight+'px');
			$(obj).show();
			$(obj).addClass('scrollTop');
		}
		if (!(350 <= scltop)) {
			$('.mapLocation').css('margin-bottom', '0');
			$(obj).removeClass('scrollTop');
		}
		
		//상품 상세 (탭메뉴 있는경우)
		if($(obj2).length > 0) {
			var tabMenuTarget = $(obj2).offset().top;								//탭메뉴 위치값
			var defaultTabOffset = tabMenuOffset();									//해당 Object > 탭메뉴 초기 위치값
			
			//Tab Menu Scroll Fixed
			if(tabMenuTarget <= scltop) {
				$(obj).hide();
				$(obj2).css('padding-top', '140px');
				$(obj2).addClass('scrollTop');
			}
			if (!(defaultTabOffset <= scltop)) {
				$(obj2).css('padding-top', '0');
				$(obj2).removeClass('scrollTop');
			}
			
			//Tab Menu Scroll Active
			$(obj2 + ' .menuList li').each(function(index, item) {
				var aTarget = $('a', this).attr('href');
				var aTargetTop = $(aTarget).offset().top-50;
				
				if(aTargetTop <= scltop) {
					$(obj2 + ' .menuList li').removeClass('active');
					$(this).addClass('active');
				}
	        });
		}
	}
	
	//상품 상세 (탭메뉴만 있는경우)
	if($(obj).length == 0 && $(obj2).length > 0) {
		var tabMenuTarget = $(obj2).offset().top;									//탭메뉴 위치값
		var defaultTabOffset = tabMenuOffset();										//해당 Object > 탭메뉴 초기 위치값
		
		//Tab Menu Scroll Fixed
		if(tabMenuTarget <= scltop) {
			$(obj2).css('padding-top', '140px');
			$(obj2).addClass('scrollTop');
		}
		if (!(defaultTabOffset <= scltop)) {
			$(obj2).css('padding-top', '0');
			$(obj2).removeClass('scrollTop');
		}
		
		//Tab Menu Scroll Active
		$(obj2 + ' .menuList li').each(function(index, item) {
			var aTarget = $('a', this).attr('href');
			var aTargetTop = $(aTarget).offset().top-50;
			
			if(aTargetTop <= scltop) {
				$(obj2 + ' .menuList li').removeClass('active');
				$(this).addClass('active');
			}
        });
	}
}




/* ====================================================================================================================
* setInterval
* ====================================================================================================================*/
setInterval(function() {
    if (didScroll) {
        scroll_topBtn();                                                		//상단으로 가기
        asideBanner();															//사이드 배너
        //mainTopFixedSearch();													//메인 상단 고정 검색바
        scrollFixedItem();														//검색바, 상세 탭메뉴 고정
        
        didScroll = false;
    }
}, 300);




/* ====================================================================================================================
* document ready
* ====================================================================================================================*/
$(document).ready(function() {
	
	//ie하위 브라우저시 실행
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
    	topMenu();
        mainMenu();
        rightAside();
        go_top();
        topBannerClose();
        
        //Frame Top Banner
        if($('#top_banner ul li').length > 1) {
        	topBannerSlider2();
        }
    }
    
});