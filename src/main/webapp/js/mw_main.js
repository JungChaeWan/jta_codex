(function($) {
	$(function(){

	// ���θ޴� �ڵ鸵

	$.fn.disableBtn = function() {
		$(this).prop('disabled', true).css('color', 'rgba(255,255,255,.2)');
	};
	$.fn.enableBtn = function() {
		$(this).prop('disabled', false).css('color', 'rgba(255,255,255,1)');
	};

	var $scrollContainer = $('#subMenuContainer'), containerWidth = $scrollContainer.innerWidth(), fullWidth = $scrollContainer[0].scrollWidth ,$btnScrollPrev = $('#btnSubMenusPrev'),$btnScrollNext = $('#btnSubMenusNext');
	//var activeLeft = $('li.active', $scrollContainer).position().left;
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

	//if(activeLeft > 20) $scrollContainer.scrollLeft(activeLeft);
	$btnScrollPrev.click(function(){
		$scrollContainer.scrollLeft($scrollContainer.scrollLeft() - 50);
	});
	$btnScrollNext.click(function(){
		$scrollContainer.scrollLeft($scrollContainer.scrollLeft() + 50);
	});


	//���� �����̵�
	$('.hotdeal ul').bxSlider({
		auto: false,
		controls: false
	});
	$('.rentcar ul').bxSlider({
		auto: false,
		controls: false,
		slideWidth: 1000,
		minSlides: 2,
		maxSlides: 2,
		slideMargin: 20
	});
	$('.coupon ul').bxSlider({
		auto: false,
		controls: false,
		slideWidth: 1000,
		minSlides: 2,
		maxSlides: 2,
		slideMargin: 20
	});
	$('.event-wrap ul').bxSlider({
		auto: false,
		controls: false
	});

	//���� ���� ���� ��ũ��
	var mainSideScroll;
	var _innerHeight = 0;

	function CheckBrowserHeight() {
		if (_innerHeight == window.innerHeight)
			return;
		SetSideScrollHeight();
		//mainSideScroll.refresh();
		_innerHeight = window.innerHeight;
	}
	function SetSideScrollHeight() {
		var h_conts = window.innerHeight - 110;
		$('.main-today').css("height", h_conts + "px");
	}

	SetSideScrollHeight();
	setInterval(CheckBrowserHeight, 500);

	function loaded2(){
		mainSideScroll = new iScroll('sideScroll', {
			hScroll:false,
			vScrollbar: false
		});
	}
	window.addEventListener('load', loaded2);

























	});
}(jQuery));

