/* Accordion */
function accordion() {
	var speed = 300;
	$('.accordion .a-title').click(function(event) {
		if ($(this).next('.a-text').css('display')=='none') {
			$('.accordion .a-text').slideUp(speed);
			$(this).next('.a-text').slideDown(speed);

			$('.accordion .a-title').removeClass('open');
			$(this).addClass('open');
		}
		else {
			$('.accordion .a-text').slideUp(speed);

			$('.accordion .a-title').removeClass('open');
		}
	});
};


/* layer popup */
function show_popup(obj){
	if($(obj).is(":hidden")){
		$(obj).show();
		$('body').after('<div class="lock-bg"></div>'); // 검은 불투명 배경

		//센터 정렬
		$(obj).css("top", Math.max(0, (($(window).height() - $(obj).outerHeight()) / 2) + $(window).scrollTop()) + "px");
    	$(obj).css("left", Math.max(0, (($(window).width() - $(obj).outerWidth()) / 2) + $(window).scrollLeft()) + "px");
	}else{
		$(obj).hide();
		$('.lock-bg').remove();
	}
}
function close_popup(obj){
	$(obj).hide();
	$('.lock-bg').remove();
}