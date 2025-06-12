/* ====================================================================================================================
* Function common > html style
* ====================================================================================================================*/
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
	        }
	        else {
	        	$(select_obj).stop().animate({"top":total_position+currentPosition+"px"},ani_speed);
	        }
	    }	    
	    else {
	        $(select_obj).stop().animate({"top":"0px"},ani_speed);
	    }	    
	});
};

/* 상세보기 */
function layerP1() {
	$('.layer-1').click(function() {
		$(this).next('.layerP1').css('display', 'block');
	});
	$('.layerP1-close').click(function() {
		$('.layerP1').css('display', 'none');
	});
};
/* ====================================================================================================================
* Function common > mw_style (layer popup 등)
* ====================================================================================================================*/
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

//검색 옵션 팝업 오픈
function optionPopup(obj, select) {
	if($(obj).is(":hidden")) {
		$('.popup-typeA').hide();
		$(obj).show();
	} else {
		$(obj).hide();
	}
	
	//자동 닫기 추가
	$(obj+' .close').on('click', function() {
		$(obj).hide();
	});
}

//검색 옵션 팝업 닫기
function optionClose(obj) {
	$(obj).hide();
}

//Tab panel (detailTabMenu1)
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
		} else if (typeof params[def] === 'object') {
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

//Tab Menu (target scroll)
function targetTabMenu(obj) {
	$(obj + ' a').on('click', function(event) {
		event.preventDefault();
        $('html, body').animate({scrollTop:$(this.hash).offset().top}, 500);
        
        $(obj + ' li').removeClass('active');
        $(this).parents('li').addClass('active');
	});
}
/*
//layer popup (타켓지정)
function layer_popup(obj) {
    if($(obj).is(":hidden")) {
        $(obj).show();															//레이어팝업 show
        $('#wrap').append('<div class="lock-bg"></div>'); 						//검은 불투명 배경 show

        //position > absolute에 따른 높이 제어
        var winHeight = $(window).height()/2,
            objHeight = $(obj).height()/2,
            scrollHeight = $(document).scrollTop(),
            winHeight2 = $(window).height(),
            scrollHeight2 = $(window).scrollTop(),
            popupHeight = $('.comm-layer-popup').outerHeight(true);

        if(scrollHeight2 < 80) {													//스크롤 값이 없는경우
            $('.comm-layer-popup').animate( {'top' : '40px'}, 200);					//top이 0인경우
            
            $('#subContent').css('z-index', 'auto');
            $('#subContent, .reserve .bt-none').css('position', 'static');
        } else {
            $('.comm-layer-popup').animate( {'top' : scrollHeight+winHeight-objHeight}, 200);
            
            $('#subContent').css('z-index', 'auto');
            $('#subContent, .reserve .bt-none').css('position', 'static');
        }

        //배경클릭시 닫기
        $('.lock-bg').click(function(){
            $(obj).hide();
            $(this).remove();
            $('.comm-layer-popup').css('top', '0px');								//애니에 따른 추가
            
            $('#subContent, .reserve .bt-none').css('position', 'relative');
        });
    } else {
        $(obj).hide();
        $('.lock-bg').remove();
        $('.comm-layer-popup').css('top', '0px');									//애니에 따른 추가
        
        $('#subContent, .reserve .bt-none').css('position', 'relative');
    }

    //자동 닫기 추가
    $(obj+' .close').on('click', function() {
        $(obj).hide();
        $('.lock-bg').remove();
        $('.comm-layer-popup').css('top', '0px');									//애니에 따른 추가
        
        $('#subContent, .reserve .bt-none').css('position', 'relative');
    });
}
*/
//layer popup (타켓지정)
function layer_popup2(obj) {
    if($(obj).is(":hidden")){
        $(obj).show();															//레이어팝업 show

		$('.comm-layer-popup').animate( {'top' : '40px'}, 200);					//top이 0인경우
		$('body').addClass('not_scroll');
		$('body').after('<div class="lock-bg"></div>'); // 검은 불투명 배경
		$('#subContent').css('z-index', 'auto');
		$('#subContent, .reserve .bt-none').css('position', 'static');

        //배경클릭시 닫기
        $('.lock-bg').click(function(){
            $(obj).hide();
            $(this).remove();
            $('.comm-layer-popup').css('top', '0px');								//애니에 따른 추가
            $('#subContent, .reserve .bt-none').css('position', 'relative');
        });
    } else {
        $(obj).hide();
        $('.lock-bg').remove();
        $('.comm-layer-popup').css('top', '0px');									//애니에 따른 추가

        $('#subContent, .reserve .bt-none').css('position', 'relative');
    }

    //자동 닫기 추가
    $(obj+' .close').on('click', function() {
        $(obj).hide();
        $('.lock-bg').remove();
        $('.comm-layer-popup').css('top', '0px');									//애니에 따른 추가

        $('#subContent, .reserve .bt-none').css('position', 'relative');
    });
}

function layer_close(obj) {
    $(obj).hide();
    $('.lock-bg').remove();
    $('.comm-layer-popup').css('top', '0px');										//애니에 따른 추가
}

//Window popup
function win_popup(file, name, width, height) {
	var myWindow = window.open(file, name, "width="+width+", height="+height+", menubar=no, status=no, toolbar=no");
	return myWindow;
}
/* ====================================================================================================================
* 기존 작업자 script (3차년도 이전)
* ====================================================================================================================*/
(function($) {
	$(function() {

		/*�޴� start*/
		var allMenu = false;
		$('.gnb-view').click(function(){
			if(!allMenu){
				subNaviView();
			}else{
				subNaviHide();
			}
			allMenu = !allMenu;
		});
	
		$('#btnHideGnb').click(function(){
			subNaviHide();
			allMenu = false;
		});
	
		// #cover ���λ���� �°� ������¡
		fn_resizeHeight = function() {
			var sideHeight = $(document).height();
			$('#cover').css({'height':sideHeight});
		}
	
		var windowh = $(window).height(),
			bodyScoll = $(window).scrollTop();
	
		function subNaviView(){
			fn_resizeHeight();
			$('#cover').show();
			$('#btnHideGnb').removeClass('hide');
			$('#gnbnavi').removeClass('hide').animate({ 'margin-left' : '205px' }, 'fast', function() { });
	
			bodyScoll = $(window).scrollTop();                              //모바일 body overflow:hidden 안먹는 증상에 따른 해결방안
			$('#wrap').css('position', 'fixed');                 			//main header absolute에 따른 추가
			$('body').addClass('not-scroll');								//body scroll hidden
			$('html, body').css('top', '-'+bodyScoll+'px');                 //fixed에 따른 시작위치 추가
		}
		
		function subNaviHide(){
			$('#cover').hide();
			$('#btnHideGnb').addClass('hide');
			$('#wrap').unbind('touchmove');
			$('#gnbnavi').animate({ 'margin-left' : '0' }, 'fast', function() { }).queue(function(){
				$(this).addClass('hide');
				$(this).dequeue();
			});
	
			$('#wrap').css('position', 'static');							//main header absolute에 따른 추가
			$('body').removeClass('not-scroll');
	        $('html, body').css('top', 0+'px').scrollTop(bodyScoll);		//fixed에 따른 시작위치 추가
		}
	
		//�޴� ���ڵ��
		var accordion_tab = $('li.sub-menu > a'),
		accordion_content = $('ul.sub-menu');
		accordion_tab.on('click', function(e){
			e.preventDefault();
			accordion_content.slideUp('normal');
			if($(this).next().is(':hidden') == true) {
				$(this).next().slideDown('normal');
			}
		});
		/*�޴� end*/
	
		//�˻�
		$('.search-view, header .search .btn-close').click(function(){
			$('header .search').slideToggle(300);
		});
	
		//��Ŀ���� ���� ����
		$('.focus-value').focus(function(){
			$(this).val('');
		});
	
		//���� �󺧿�
		$('.form-value input').focus(function(){
			$(this).parent().find("label").hide();
		});
	
		//����������
		$('.menu-bar .btn-prev').click(function(){
			history.back();
		});
	
		//��ǰ�� ��������
		$('.view-seller, .pop-seller').click(function(){
			$('.pop-seller, #cover').fadeToggle();
		});
	
		//layer popup2
		$('.view-seller2, .btn-close2').click(function(){
			$('.pop-seller2, #cover').fadeToggle();
		});
	
		//��ǰ�� �ϴ� ��
		$(function () {
			$('.view-tab a').click(function () {
				$('.view-tab a').removeClass('active');
				$(this).addClass('active');
				$('.tab-con').addClass('hide');
				var activeTab = $(this).attr('href');
				$(activeTab).removeClass('hide');
				return false;
			});
		});
	
		//ȸ���� ��� ��
		$(function () {
			$('.agree-tab a').click(function () {
				$('.agree-tab a').removeClass('active');
				$(this).addClass('active');
				$('.agree-area > div').addClass('hide');
				var activeTab = $(this).attr('href');
				$(activeTab).removeClass('hide');
				return false;
			});
		});

		//����
		$('.btn-coupon, .pop-coupon .btn-close').click(function(){
			$('.pop-coupon, #cover').fadeToggle();
		});
		//������å
		$('.pop-view, .pop-info .btn-close').click(function(){
			$('.pop-info, #cover').fadeToggle();
		});
	
		$('.pop-tab a').click(function () {
			$('.pop-tab a').removeClass('active');
			$(this).addClass('active');
			$('.tab-con').addClass('hide');
			var activeTab = $(this).attr('href');
			$(activeTab).removeClass('hide');
			return false;
		});
		
		//장바구니 옵션변경
		//$('.option1, .option2, .option3, .option4').on('click', function() {
		$('.option2, .option3').on('click', function() {
			var obj = '.option-change';
			var target = true;
	
			if(target == true) {
				$('#cover').show();
				$(obj).show();
	
				setTimeout(function() {
					positionCheck(obj);
				}, 500);
	
				target = false;
			} else {
				target = true;
			}
		});
	
		//장바구니 팝업 위치
		function positionCheck(obj) {
			var winHeight = $(window).height()/2,
				objHeight = $(obj).height()/2,
				scrollHeight = $(document).scrollTop(),
				winHeight2 = $(window).height(),
				scrollHeight2 = $(window).scrollTop(),
				popupHeight = $(obj).outerHeight(true);
	
			if(scrollHeight2 < 100) {												//스크롤 값이 없는경우
				//$(obj).animate( {'top' : '40px'}, 200);
			} else if(winHeight2 < popupHeight) {										//팝업크기가 창보다 큰경우
				$(obj).animate( {'top' : scrollHeight+winHeight-objHeight}, 50);
			} else {
				$(obj).animate( {'top' : scrollHeight+winHeight-objHeight}, 50);
			}
		}
	});
}(jQuery));