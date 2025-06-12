/****************************************************************
 * sns.js
 * sns관련 js
 * 
 */
//var getContextPath = "${pageContext.request.contextPath}";

function shareFacebook(strUrl) {
    var body = strUrl.replace(location.protocol + "//", "");

	var strCl = fn_AppCheck();

	if("AA" == strCl || "IA" == strCl) {
		window.open('http://www.facebook.com/sharer/sharer.php?u=' + body + '&newopen=yes', '', 'width=600px,height=600px;');
	} else {
		window.open('http://www.facebook.com/sharer/sharer.php?u=' + body, '', 'width=600px,height=600px;');
	}
}

function shareBand(strUrl) {
    var body = strUrl.replace(location.protocol + "//", "");
	body = encodeURIComponent(body);

	var strCl = fn_AppCheck();

	if("AA" == strCl || "IA" == strCl){
		window.open('http://band.us/plugin/share?body=' + body + '&route=' + strUrl + '&newopen=yes', '', 'width=600px,height=600px;');
	}else{
		window.open('http://band.us/plugin/share?body=' + body + '&route=' + strUrl, '', 'width=600px,height=600px;');
	}
}

function shareLine(strUrl){
    var body = strUrl.replace(location.protocol + "//", "");
    body = encodeURIComponent(body);

	window.open('http://line.me/R/msg/text/?탐나오가 추천하는 제주여행! -' + body, '', 'width=600px,height=600px;');
}

// 카카오 링크
Kakao.init('71cf66fb54158dacb5fb5b656674ad70');
// 카카오톡 링크
function shareKakao(adNm, imgUrl, strUrl) {
    Kakao.Link.sendDefault({
        objectType: 'feed',
        content: {
            title: '탐나오가 추천하는 제주여행! - ' + adNm,
            imageUrl: imgUrl,
            link: {
                mobileWebUrl: strUrl,
                webUrl: strUrl
            }
        },
        buttons: [
            {
                title: '탐나오 바로가기',
                link: {
                    mobileWebUrl: strUrl,
                    webUrl: strUrl
                }
            }
        ]
    });
}
// 카카오스토리 공유 팝업창
function shareStory(strUrl) {
    var body = strUrl.replace(location.protocol + "//", "");
    body = encodeURIComponent(body);

    var strCl = fn_AppCheck();

    if(strCl == "AA" || strCl == "IA") {
        window.open('https://story.kakao.com/share?url=' + body + '&newopen=yes', '', 'width=600px,height=600px;');
    } else {
        window.open('https://story.kakao.com/share?url=' + body, '', 'width=600px,height=600px;');
    }
}

function snsCount(prdtNum, inqDiv, snsDiv) {
    var parameters = "linkNum=" + prdtNum;
    parameters += "&inqDiv=" + inqDiv;
    parameters += "&snsDiv=" + snsDiv;

	$.ajax({
		type:"post", 
		dataType:"json",
		async:false,
		url:"/web/snsCount.ajax",
		data:parameters,
		success:function(data){			
		},
		error : function(request, status, error) {
			if(request.status == "500") {
				alert("로그인 정보가 없습니다. 로그인 후 진행하시기 바랍니다.");
				location.reload(true);
			} else {
				alert("에러가 발생했습니다!");
                console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
			}
		}
	});
}
