//layer popup (타켓지정)
function layer_popup(obj) {
    if($(obj).is(":hidden")){
        $(obj).show();															//레이어팝업 show
     //   $('#wrap').append('<div class="lock-bg"></div>'); 						//검은 불투명 배경 show

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

(function($) {
	$(function(){

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
		//$('html,body').css({overflow:'hidden', height:windowh});
		//$('.side-menu').css({height:windowh});
		//$('#wrap').bind('touchmove', function(e){e.preventDefault()});
		$('#gnbnavi').removeClass('hide').animate({ 'margin-left' : '205px' }, 'fast', function() { });
		//menuScroll.refresh();

		//$('body').css({'height':'100%', 'overflow':'hidden'});
		bodyScoll = $(window).scrollTop();                              //모바일 body overflow:hidden 안먹는 증상에 따른 해결방안
		$('#wrap').css('position', 'fixed');                 			//main header absolute에 따른 추가
		$('body').addClass('not-scroll');								//body scroll hidden
		$('html, body').css('top', '-'+bodyScoll+'px');                 //fixed에 따른 시작위치 추가
	}
	
	function subNaviHide(){
		$('#cover').hide();
		$('#btnHideGnb').addClass('hide');
		//$('html,body').removeAttr('style');
		$('#wrap').unbind('touchmove');
		//accordion_content.slideUp('normal');
		$('#gnbnavi').animate({ 'margin-left' : '0' }, 'fast', function() { }).queue(function(){
			$(this).addClass('hide');
			$(this).dequeue();
		});

		//$('body').css({'height':'auto', 'overflow':'visible'});
		$('#wrap').css('position', 'static');							//main header absolute에 따른 추가
		$('body').removeClass('not-scroll');
        $('html, body').css('top', 0+'px').scrollTop(bodyScoll);		//fixed에 따른 시작위치 추가
	}

	/*var menuScroll;
	function loaded(){
		menuScroll = new iScroll('sideMenu', {
			hScroll:false,
			vScrollbar: false,
			useTransform:false,
			onBeforeScrollStart: function (e) {
				var target = e.target;
				while (target.nodeType != 1) target = target.parentNode;
				if (target.tagName != 'SELECT' && target.tagName != 'INPUT' && target.tagName     != 'TEXTAREA') e.preventDefault();
			}

		});
	}
	window.addEventListener('load', loaded);*/

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
	/* 두번 실행에 따른 주석처리
	$('.view-seller, .pop-seller .btn-close').click(function(){
		$('.pop-seller, #cover').fadeToggle();
	});
	*/

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

	//장바구니 옵션변경1
	/*
	$('.option1, .option-change1 .btn-close').click(function() {
		$('.option-change1, #cover').fadeToggle();
	});
	*/

	//장바구니 옵션변경2
	/*
	$('.option2, .option-change2 .btn-close').click(function() {
		$('.option-change2, #cover').fadeToggle();
	});
	*/

	//장바구니 옵션변경3
	/*
	$('.option3, .option-change3 .btn-close').click(function() {
		$('.option-change3, #cover').fadeToggle();
	});
	*/

	//장바구니 옵션변경4
	/*
	$('.option4, .option-change4 .btn-close').click(function() {
		$('.option-change4, #cover').fadeToggle();
	});
	*/

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