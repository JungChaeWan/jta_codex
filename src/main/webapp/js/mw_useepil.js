/****************************************************************
 * eusepil.js
 * 상품평.js
 * 
 */

var g_UE_corpId;
var g_UE_prdtnum;
var g_UE_corpCd;
var g_UE_page=1;

var g_UE_getContextPath = "";


function fn_useepilList(){
	$("#usePageIndex").val(g_UE_page);
	$("#useCurPage").text(g_UE_page);
	
	var parameters = "corpId="+g_UE_corpId;
	parameters+= "&prdtnum="+g_UE_prdtnum;
	parameters+= "&corpCd="+g_UE_corpCd;
	parameters+= "&pageIndex="+g_UE_page;
	
	$.ajax({
		type:"post", 
		// dataType:"json",
		async:false,
		//url:"<c:url value='/web/cmm/useepilList.ajax'/>",
		url:g_UE_getContextPath+'/mw/cmm/useepilList.ajax',
		data:parameters,
		success:function(data){
			if (g_UE_page == 1) {
				$("#review").html(data);
			} else {			
				$("#reviewListWrap").append(data);
			}

			$("#useTotAdCnt").text($("input[name=useTotalCnt]").val());			
			$("#useTotPage").text($("input[name=useTotalPageCnt]").val());
			
			if (g_UE_page == $("input[name=useTotalPageCnt]").val() || $("input[name=useTotalCnt]").val() == 0)
				$('#useMoreBtn').hide();
			else
				$('#useMoreBtn').show();
		},
		error:fn_AjaxError
	});
}


function fn_useepilSearch(){
	g_UE_page = eval($("#usePageIndex").val()) + 1;

	fn_useepilList();	
}


function fn_useepilChageLike(nGpa){
	for(var i=1; i<=5 ; i++){
		if(i <= nGpa){
			$("#ue_like"+i).attr("src", g_UE_getContextPath+'/images/mw/icon/star_on.png' );
		}else{
			//console.log("#ue_like"+i +"<="+ nGpa + ":x");
			$("#ue_like"+i).attr("src", g_UE_getContextPath+'/images/mw/icon/star_off.png' );
		}
	}
	$("#gpa").val(nGpa);
}


function fn_useepilInsert(){
	//입력 검사
	//if( $("#gpa").val() == 0){
	if(document.useepilFrm.gpa.value==0){
		alert("평점을 선택하세요.");
		return;
	}
	
	document.useepilFrm.subject.value = document.useepilFrm.subjectUE.value;
	//if($("#subject").val().length == 0){
	if(document.useepilFrm.subject.value.length==0){
		alert("제목을 입력하세요.");
		document.useepilFrm.subjectUE.focus();
		return;
	}
	//if($("#subject").val().length >= 255){
	if(document.useepilFrm.subject.value.length >= 255){
		alert("제목의 길이는 255자 이하입니다.");
		document.useepilFrm.subjectUE.focus();
		return;
	}
	
	document.useepilFrm.contents.value = document.useepilFrm.contentsUE.value;
	//if($("#contents").val().length == 0){
	if(document.useepilFrm.contents.value.length==0){
		alert("이용 후기를 입력하세요.");
		document.useepilFrm.contentsUE.focus();
		return;
	}
	//if($("#contents").val().length >= 500){
	if(document.useepilFrm.contents.value.length >= 500){
		alert("이용 후기의 길이는 500자 이하입니다.");
		document.useepilFrm.contentsUE.focus();
		return;
	}
		
	var parameters = $("#useepilFrm").serialize();
	//alert(parameters);
	
	$.ajax({
		type:"post", 
		// dataType:"json",
		// async:false,
		//url:"<c:url value='/web/cmm/useepilInsert.ajax'/>",
		url:g_UE_getContextPath+'/mw/cmm/useepilInsert.ajax',
		data:parameters,
		success:function(data){
			//$("#tabs-5").html(data);
			if(data["Status"] == "success"){
				//alert("ok");
				fn_useepilUIUpdate(data["GpaAvg"],data["GpaCnt"]);

				g_UE_page=1;

				fn_useepilList();
			}else{
				alert("Error");
			}
		},
		error:fn_AjaxError
	});
}
	

function fn_useepilChageLikeEdit(useEpilNum, nGpa){
	for(var i=1; i<=5 ; i++){
		if(i <= nGpa){
			//console.log("#ue_likeEdit"+i +"<="+ nGpa + ":o");
			$("#ue_likeEdit"+i+"_"+useEpilNum).attr("src", g_UE_getContextPath+'/images/mw/icon/star_on.gif' );
		}else{
			//console.log("#ue_like"+i +"<="+ nGpa + ":x");
			$("#ue_likeEdit"+i+"_"+useEpilNum).attr("src", g_UE_getContextPath+'/images/mw/icon/star_off.gif' );
		}
	}
	$("#ueGpaEdit"+useEpilNum).val(nGpa);
}	
	

function fn_useepilUpdate(useEpilNum){
	//입력 검사
	//if( $("#gpa").val() == 0){
	document.useepilFrm.gpa.value = $("#ueGpaEdit"+useEpilNum).val();
	if(document.useepilFrm.gpa.value == 0){
		alert("평점을 선택하세요.");
		return;
	}
	
	document.useepilFrm.subject.value = $("#ueSubjectEdit"+useEpilNum).val();
	//if($("#subject").val().length == 0){
	if(document.useepilFrm.subject.value.length == 0){
		alert("제목을 입력하세요.");
		$("#ueSubjectEdit"+useEpilNum).focus();
		return;
	}
	//if($("#subject").val().length >= 255){
	if(document.useepilFrm.subject.value.length >= 255){
		alert("제목의 길이는 255자 이하입니다.");
		$("#ueSubjectEdit"+useEpilNum).focus();
		return;
	}
	
	document.useepilFrm.contents.value = $("#ueContEdit"+useEpilNum).val();
	//if($("#contents").val().length == 0){
	if(document.useepilFrm.contents.value.length == 0){
		alert("이용 후기를 입력하세요.");
		$("#ueContEdit"+useEpilNum).focus();
		return;
	}
	//if($("#contents").val().length >= 500){
	if(document.useepilFrm.contents.value.length >= 500){
		alert("이용 후기의 길이는 500자 이하입니다.");
		$("#ueContEdit"+useEpilNum).focus();
		return;
	}
	
	document.useepilFrm.useEpilNum.value = useEpilNum;
		
	var parameters = $("#useepilFrm").serialize();
	//alert(parameters);
	
	$.ajax({
		type:"post", 
		// dataType:"json",
		// async:false,
		//url:"<c:url value='/web/cmm/useepilUpdate.ajax'/>",
		url:g_UE_getContextPath+'/mw/cmm/useepilUpdate.ajax',
		data:parameters,
		success:function(data){
			//$("#tabs-5").html(data);
			if(data["Status"] == "success"){
				fn_useepilList();			
				//TODO::평점, 상품평 수 업데이트
				//alert("["+data["GpaAvg"] + "][" +data["GpaCnt"] +"]");
				fn_useepilUIUpdate(data["GpaAvg"],data["GpaCnt"]);
			}else{
				alert("Error");
			}
		},
		error:fn_AjaxError
	});
}
		

function fn_useepilCmtInsert(useEpilNum){
	//alert($("#useepilCmtFrm"+useEpilNum).children("#contents").val());

	if($("#ueContCmt"+useEpilNum).val().length == 0){
		alert("답글을 입력하세요.");
		$("#ueContCmt"+useEpilNum).focus();
		return;
	}
	if($("#ueContCmt"+useEpilNum).val().length >= 500){
		alert("답글의 길이는 500자 이하 입니다.");
		$("#ueContCmt"+useEpilNum).focus();
		return;
	}
	
	document.useepilFrm.contents.value = $("#ueContCmt"+useEpilNum).val();
	document.useepilFrm.useEpilNum.value = useEpilNum;
	
	var parameters = $("#useepilFrm").serialize();
	
	$.ajax({
		type:"post", 
		// dataType:"json",
		// async:false,
		//url:"<c:url value='/web/cmm/useepilCmtInsert.ajax'/>",
		url:g_UE_getContextPath+'/mw/cmm/useepilCmtInsert.ajax',
		data:parameters,
		success:function(data){
			//$("#tabs-5").html(data);
			if(data["Status"] == "success"){
				//alert("ok");
				fn_useepilList();
			}else{
				alert("Error");
			}
		},
		error:fn_AjaxError
	});
}


function fn_useepilCmtUpdate(cmtSn, useEpilNum){
	//alert($("#useepilCmtFrm"+useEpilNum).children("#contents").val());

	if($("#ueContCmtEdit"+cmtSn+"_"+useEpilNum).val().length == 0){
		alert("답글을 입력하세요.");
		$("#ueContCmtEdit"+cmtSn+"_"+useEpilNum).focus();
		return;
	}
	if($("#ueContCmtEdit"+cmtSn+"_"+useEpilNum).val().length >= 500){
		alert("답글의 길이는 500자 이하입니다.");
		$("#ueContCmtEdit"+cmtSn+"_"+useEpilNum).focus();
		return;
	}
	
	document.useepilFrm.contents.value = $("#ueContCmtEdit"+cmtSn+"_"+useEpilNum).val();
	document.useepilFrm.cmtSn.value = cmtSn;
	
	var parameters = $("#useepilFrm").serialize();
	
	$.ajax({
		type:"post", 
		// dataType:"json",
		// async:false,
		//url:"<c:url value='/web/cmm/useepilCmtUpdate.ajax'/>",
		url:g_UE_getContextPath+'/mw/cmm/useepilCmtUpdate.ajax',
		data:parameters,
		success:function(data){
			//$("#tabs-5").html(data);
			if(data["Status"] == "success"){
				//alert("ok");
				fn_useepilList();
			}else{
				alert("Error");
			}
		},
		error:fn_AjaxError
	});
}


function fn_useepilCmtDelete(cmtSn, useEpilNum){
	if(!confirm("삭제 하시겠습니까?")){
		return;
	}
	
	document.useepilFrm.cmtSn.value = cmtSn;
	document.useepilFrm.useEpilNum.value = useEpilNum;
	
	var parameters = $("#useepilFrm").serialize();
	
	$.ajax({
		type:"post", 
		// dataType:"json",
		// async:false,
		//url:"<c:url value='/web/cmm/useepilCmtDelete.ajax'/>",
		url:g_UE_getContextPath+'/mw/cmm/useepilCmtDelete.ajax',
		data:parameters,
		success:function(data){
			//$("#tabs-5").html(data);
			if(data["Status"] == "success"){
				//alert("ok");
				fn_useepilList();
			}else{
				alert("Error");
			}
		},
		error:fn_AjaxError
	});
}


function fn_useepilUIUpdate(GpaAvg, GpaCnt){
	//alert(GpaAvg+"-"+GpaCnt);
	//$("#useepil_uiTopHearts").html("<h1>asadasdas</h1>");
	var nLike = 0;

	if(0 < GpaAvg && GpaAvg < 1.5){
		nLike = 1;
	}else if(1.5 <= GpaAvg && GpaAvg < 2.5){
		nLike = 2;
	}else if(2.5 <= GpaAvg && GpaAvg < 3.5){
		nLike = 3;
	}else if(3.5 <= GpaAvg && GpaAvg < 4.5){
		nLike = 4;
	}else if(4.5 <= GpaAvg && GpaAvg < 5.5){
		nLike = 5;
	}

	var strLikeHTML = "";
	strLikeHTML += '<span class="score">평점 <strong class="text-red">' + GpaAvg + '</strong>/5</span>';
	strLikeHTML += '<span class="icon">';

	for (var i=1; i<=nLike; i++) {
		strLikeHTML += '	<img src="/images/mw/icon/star_on.png" alt="좋아요">';
	}
	for (var i=nLike; i<5; i++) {
		strLikeHTML += '	<img src="/images/mw/icon/star_off.png" alt="좋아요">';
	}
	strLikeHTML += '</span>';

	$(".score-area").html(strLikeHTML);	
}

function fn_useepilCmtSH(useEpilNum){
	$("#ueContCmtDiv"+useEpilNum).toggle();
}

function fn_useepilEditSH(useEpilNum){
	$("#ueContEditDiv"+useEpilNum).toggle();
}

function fn_useepilCmtEditSH(cmtSn, useEpilNum){
	$("#ueContCmtEditDiv"+cmtSn+"_"+useEpilNum).toggle();
}


function fn_useepilInitUI(){
	var parameters = "corpId="+g_UE_corpId;
	parameters+= "&prdtnum="+g_UE_prdtnum;
	parameters+= "&corpCd="+g_UE_corpCd;
	parameters+= "&pageIndex="+g_UE_page;
	
	$.ajax({
		type:"post", 
		// dataType:"json",
		// async:false,
		//url:"<c:url value='/web/cmm/useepilInsert.ajax'/>",
		url:g_UE_getContextPath+'/mw/cmm/useepilInitUI.ajax',
		data:parameters,
		success:function(data){
			//$("#tabs-5").html(data);
			if(data["Status"] == "success"){
				//alert("ok");
				fn_useepilUIUpdate(data["GpaAvg"],data["GpaCnt"]);
				//g_UE_page=1;
				//fn_useepilList();
			}else{
				alert("Error");
			}
		},
		error:fn_AjaxError
	});
}

// 이용후기 사진 슬라이드
function fn_useepilImgList(id, totalCnt){
	$("body").bind('touchmove', function(e){e.preventDefault()});
	$("body").css('overflow','hidden');

	$(".detail-slider.reviewPhoto").addClass("active");

	for(var i = 1; i <= totalCnt; i++) {
		$("#useepil_detail_slider" + i).hide();
	}
	$("#useepil_detail_slider" + id).show();

	new Swiper("#useepil_detail_slider" + id, {
		pagination: "#useepil_detail_paging" + id,
		paginationType: "fraction",
		nextButton: "#useepil_detail_next" + id,
		prevButton: "#useepil_detail_prev" + id,
		loop: true
	});
}

// 이용후기 사진 슬라이드 닫기
function useepilSlideClose(id){
	$("body").unbind('touchmove');
	$("body").css('overflow','visible');

	$("#useepil_detail_slider" + id).hide();
}