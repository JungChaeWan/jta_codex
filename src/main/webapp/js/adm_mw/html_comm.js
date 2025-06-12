/* -------------------- window size -------------------- */
/* HTML5 표준이 정해져 있다. */
var winWidth = window.innerWidth,                                       //창가로 사이즈
    winHeight = window.innerHeight,                                     //창세로 사이즈
    bodyScoll = $(window).scrollTop();                                  //
    //window.outerWidth;
    //window.outerHeight;



/* ====================================================================================================================
* header
* ====================================================================================================================*/
function left_menu() {													//left menu
	var speed = 300;

	$('#left_btn').on("click", function test100() {								//open
        bodyScoll = $(window).scrollTop();                              //모바일 body overflow:hidden 안먹는 증상에 따른 해결방안
        
		$('#left_menu').addClass('active');
		$('body').addClass('not-scroll');								//body scroll hidden
		$('#left_close').show();										//position fixed에 따른 추가
        
        return false;
	});
	
	$('#left_close').on("click", function(){							//close
		$('#left_menu').removeClass('active');
		$('body').removeClass('not-scroll');
        $('html, body').scrollTop(bodyScoll);                           //fixed에 따른 시작위치 추가
		$('#left_close').hide();
        
		return false;
	});
	
	
	$('#main_menu > nav > a').on("click", function(e){					//sub menu
		if($(this).next('ul').css('display') == 'none') {				//open
			$("#main_menu > nav > ul").slideUp(speed);
			$(this).next('ul').slideDown(speed);
			
			$('#main_menu > nav > a').removeClass('active');
			$(this).addClass('active');
		}
		else {															//close
			$("#main_menu > nav > ul").slideUp(speed);
			$(this).next('ul').slideUp(speed);
			
			$('#main_menu > nav > a').removeClass('active');
		}
		
		return false;
	});
}


function right_menu() {													//right menu
	$('#right_btn').on("click", function(){
		if($('#right_menu').css('display') == 'none') {					//open
			$('#right_menu').addClass('active');
			$(this).addClass('active');
			$("body").css({overflow:'hidden'}).bind('touchmove', function(e){
				e.preventDefault();										//body scroll hidden
			});						
		}
		else {															//close
			$('#right_menu').removeClass('active');
			$(this).removeClass('active');
			$("body").css({overflow:'visible'}).unbind('touchmove');
		}
		return false;
	});
}




/* ====================================================================================================================
* scroll event
* ====================================================================================================================*/
var didScroll,
	lastScrollTop = 0,
	start = 100,														//스크롤 시작 위치
	delta = 20,															//동작시작위치
	navbarHeight = $('#header').outerHeight();							//동작요소

$(window).scroll(function(event){
	didScroll = true;													//스크롤 이벤트 부하에 따른 setInterval 사용
});

setInterval(function() {
	if (didScroll) {
		hasScrolled();													//스크롤 이벤트 실행
		didScroll = false;
	}
}, 250);	

function hasScrolled() {												//동작구현
	var st = $(this).scrollTop();										//현재 스크롤위치 저장

	if(Math.abs(lastScrollTop - st) <= delta) return;					//delta 값보다 더 스크롤 되었는지 확인
	
	
	if(start < st) {
		if (st > lastScrollTop && st > navbarHeight) {					//Scroll Down
			$('#header').addClass('head-hide');
		} else {
			if(st + $(window).height() < $(document).height()) {		//Scroll Up
				$('#header').removeClass('head-hide');
			}
		}

		lastScrollTop = st;
	} else {
		$('#header').removeClass('head-hide');
	}
}




/* ====================================================================================================================
* document ready
* ====================================================================================================================*/
$(document).ready(function(){
	left_menu();					//header left menu
	right_menu();					//header right menu
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
	}, 200);
})
$(window).on('resizeEnd', function() {
    
});