(function($) {
	$(function(){

	//상품이미지 슬라이드
	$(function () {
		/*$('.goods-image1 ul').bxSlider({
			pager: false,
			nextSelector: '.goods-image1 .btn-next',
			prevSelector: '.goods-image1 .btn-prev'
			//nextText:'<img src="images/mw/sub_common/next.png" width="16" alt="이전">',
			//prevText:'<img src="images/mw/sub_common/prev.png" width="16" alt="다음">',
		});*/
		$('.goods-image2 ul').bxSlider({
			pager: false,
			nextSelector: '.goods-image2 .btn-next',
			prevSelector: '.goods-image2 .btn-prev'
			//nextText:'<img src="images/mw/sub_common/next.png" width="16" alt="이전">',
			//prevText:'<img src="images/mw/sub_common/prev.png" width="16" alt="다음">',
		});
		$('.goods-image3 ul').bxSlider({
			pager: false,
			nextSelector: '.goods-image3 .btn-next',
			prevSelector: '.goods-image3 .btn-prev'
			//nextText:'<img src="images/mw/sub_common/next.png" width="16" alt="이전">',
			//prevText:'<img src="images/mw/sub_common/prev.png" width="16" alt="다음">',
		});
		$('.goods-image4 ul').bxSlider({
			pager: false,
			nextSelector: '.goods-image4 .btn-next',
			prevSelector: '.goods-image4 .btn-prev'
			//nextText:'<img src="images/mw/sub_common/next.png" width="16" alt="이전">',
			//prevText:'<img src="images/mw/sub_common/prev.png" width="16" alt="다음">',
		});
		$('.view-img ul').bxSlider({
			pager: false,
			nextSelector: '.view-img .btn-next',
			prevSelector: '.view-img .btn-prev'
			//nextText:'<img src="images/mw/sub_common/next.png" width="16" alt="이전">',
			//prevText:'<img src="images/mw/sub_common/prev.png" width="16" alt="다음">',
		});
		$('.goods-slide > ul').bxSlider({
			auto: false,
			nextSelector: '.goods-slide .btn-next',
			prevSelector: '.goods-slide .btn-prev'
			//nextText:'<img src="images/mw/sub_common/next.png" width="16" alt="이전">',
			//prevText:'<img src="images/mw/sub_common/prev.png" width="16" alt="다음">',
		});
	});

	});
}(jQuery));