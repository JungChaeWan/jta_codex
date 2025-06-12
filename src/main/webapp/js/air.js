/* tab panel (detailTabMenu1) */
// head.jsp 출력시 삭제
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


/* default Accordion */
function air_accordion(obj) {
	var speed = 300;
	$(obj + ' dt').click(function(event) {
		if ($(this).next('dd').css('display')=='none') {
			$(obj + ' dd').slideUp(speed);
			$(this).next('dd').slideDown(speed);

			//add class (icon)
			$(obj + ' dt').removeClass('open')
			$(this).addClass('open');
		}
		else {
			$(obj + ' dd').slideUp(speed);

			//add class (icon)
			$(obj + ' dt').removeClass('open')
		}
	});
};


/* layer popup */
// head.jsp 출력시 삭제
function show_popup(obj){
	if($(obj).is(":hidden")){
		$(obj).show();
		$('body').after('<div class="lock-bg"></div>'); // 검은 불투명 배경
	}else{
		$(obj).hide();
		$('.lock-bg').remove();
	}
}
function close_popup(obj){
	$(obj).hide();
	$('.lock-bg').remove();
}