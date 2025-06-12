/****************************************************************
 * otoinq.js
 * 1:1문의.js
 * 
 */

var g_Oto_corpId;
var g_Oto_prdtnum;
var g_Oto_corpCd;
var g_Oto_page=1;

var g_Oto_getContextPath = "";


function fn_otoinqList(){
	//var parameters = $("#frm").serialize();
	
	//alert(g_Oto_g_Oto_getContextPath);
	
	$("#otoPageIndex").val(g_Oto_page);
	$("#otoCurPage").text(g_Oto_page);
	
	var parameters = "corpId="+g_Oto_corpId;
	parameters+= "&prdtNum="+g_Oto_prdtnum;
	parameters+= "&corpCd="+g_Oto_corpCd;
	parameters+= "&pageIndex="+g_Oto_page;

	$.ajax({
		type:"post", 
		// dataType:"json",
		async:false,
		url:g_Oto_getContextPath+'/mw/cmm/otpinqList.ajax',
		data:parameters ,
		success:function(data){
			if (g_Oto_page == 1)
				$("#counsel").html(data);
			else {
				$("#otoinqListWrap").append(data);
			}
			
			$("#otoTotAdCnt").text($("input[name=otoTotalCnt]").val());
			$("#otoTotPage").text($("input[name=otoTotalPageCnt]").val());
			
			if (g_Oto_page == $("input[name=otoTotalPageCnt]").val() || $("input[name=otoTotalCnt]").val() == 0)
				$('#otoMoreBtn').hide();
			else
				$('#otoMoreBtn').show();
		},
		error:function(request,status,error){
	        alert("fn_otoinqList - code:"+request.status+"\n"+"\n"+"error:"+error);
	        //alert("code:"+request.status+"\n"+"\n"+"error:"+error);
 	   }
	});
}

function fn_otoinqSearch(){
	g_Oto_page = eval($("#otoPageIndex").val()) + 1;
	fn_otoinqList();	
}



function fn_otoinqInsert(){
	//입력 검사
	
	document.otoinqFrm.subject.value = $("#oto_subject").val();
	//if($("#subject").val().length == 0){
	if(document.otoinqFrm.subject.value.length==0){
		alert("제목을 입력 하세요.");
		$("#oto_subject").focus();
		return;
	}
	//if($("#subject").val().length >= 255){
	if(document.otoinqFrm.subject.value.length >= 255){
		alert("제목의 길이는 255자 이하 입니다.");
		$("#oto_subject").focus();;
		return;
	}
	
	document.otoinqFrm.contents.value = $("#oto_contents").val();
	//if($("#contents").val().length == 0){
	if(document.otoinqFrm.contents.value.length==0){
		alert("내용을 입력 하세요.");
		$("#oto_contents").focus();
		return;
	}
	//if($("#contents").val().length >= 500){
	if(document.otoinqFrm.contents.value.length >= 500){
		alert("내용의 길이는 500자 이하 입니다.");
		$("#oto_contents").focus();
		return;
	}
		
	var parameters = $("#otoinqFrm").serialize();
	//alert(parameters);

	$.ajax({
		type:"post", 
		// dataType:"json",
		// async:false,
		url:g_Oto_getContextPath+'/mw/cmm/otoinqInsert.ajax',
		data:parameters ,
		success:function(data){
			//$("#tabs-5").html(data);
			if(data["Status"] == "success"){
				//alert("ok");
				fn_otoinqUIUpdate(data["OtoCnt"]);
				g_Oto_page=1;
				fn_otoinqList();
			}else{
				alert("Error");
			}
		},
		error:function(request,status,error){
	        alert("code:"+request.status+"\n"+"\n"+"error:"+error);
	        //alert("code:"+request.status+"\n"+"\n"+"error:"+error);
 	   }
	});
	
}

	
function fn_otoinqUpdate(otoinqNum){
	//입력 검사
	document.otoinqFrm.subject.value = $("#oto_SubjectEdit"+otoinqNum).val();
	//if($("#subject").val().length == 0){
	if(document.otoinqFrm.subject.value.length==0){
		alert("제목을 입력 하세요.");
		$("#oto_subjectEdit"+otoinqNum).focus();
		return;
	}
	//if($("#subject").val().length >= 255){
	if(document.otoinqFrm.subject.value.length >= 255){
		alert("제목의 길이는 255자 이하 입니다.");
		$("#oto_subjectEdit"+otoinqNum).focus();;
		return;
	}
	
	document.otoinqFrm.contents.value = $("#oto_contentsEdit"+otoinqNum).val();
	//if($("#contents").val().length == 0){
	if(document.otoinqFrm.contents.value.length==0){
		alert("이용 후기를 입력 하세요.");
		$("#oto_contentsEdit"+otoinqNum).focus();
		return;
	}
	//if($("#contents").val().length >= 500){
	if(document.otoinqFrm.contents.value.length >= 500){
		alert("이용 후기의 길이는 500자 이하 입니다.");
		$("#oto_contentsEdit"+otoinqNum).focus();
		return;
	}
	
	
	document.otoinqFrm.otoinqNum.value = otoinqNum;
		
	var parameters = $("#otoinqFrm").serialize();

	$.ajax({
		type:"post", 
		// dataType:"json",
		// async:false,
		//url:"<c:url value='/web/cmm/useepilUpdate.ajax'/>",
		url:g_Oto_getContextPath+'/mw/cmm/otoinqUpdate.ajax',
		data:parameters ,
		success:function(data){
			//$("#tabs-5").html(data);
			if(data["Status"] == "success"){
				//fn_otoinqUIUpdate(data["OtoCnt"]);
				fn_otoinqList();
			}else{
				alert("Error");
			}
		},
		error:function(request,status,error){
	        alert("code:"+request.status+"\n"+"\n"+"error:"+error);
	        //alert("code:"+request.status+"\n"+"\n"+"error:"+error);
 	   }
	});

}


function fn_otoinqDelete(otoinqNum){
	if(!confirm("삭제 하시겠습니까?")){
		return;
	}
	
	document.otoinqFrm.otoinqNum.value = otoinqNum;
	
	var parameters = $("#otoinqFrm").serialize();
	
	$.ajax({
		type:"post", 
		// dataType:"json",
		// async:false,
		//url:"<c:url value='/web/cmm/useepilCmtDelete.ajax'/>",
		url:g_Oto_getContextPath+'/mw/cmm/otoinqDelete.ajax',
		data:parameters ,
		success:function(data){
			//$("#tabs-5").html(data);
			if(data["Status"] == "success"){
				//alert("ok");
				fn_otoinqUIUpdate(data["OtoCnt"]);
				fn_otoinqList();
			}else{
				alert("Error");
			}
		},
		error:function(request,status,error){
	        alert("code:"+request.status+"\n"+"\n"+"error:"+error);
	        //alert("code:"+request.status+"\n"+"\n"+"error:"+error);
 	   }
	});
}


function fn_otoinqInitUI(useEpilNum){
	
	/*
	//var parameters = $("#otoinqFrm").serialize();
	
	var parameters = "corpId="+g_Oto_corpId;
	parameters+= "&prdtNum="+g_Oto_prdtnum;
	parameters+= "&corpCd="+g_Oto_corpCd;
	//parameters+= "&pageIndex="+g_Oto_page;
	
	$.ajax({
		type:"post", 
		// dataType:"json",
		// async:false,
		//url:"<c:url value='/web/cmm/useepilCmtDelete.ajax'/>",
		url:g_Oto_getContextPath+'/web/cmm/otoinqIntiUI.ajax',
		data:parameters ,
		success:function(data){
			//$("#tabs-5").html(data);
			if(data["Status"] == "success"){
				//alert("ok");
				fn_otoinqUIUpdate(data["OtoCnt"]);
			}else{
				alert("Error");
			}
		},
		error:function(request,status,error){
	        alert("code:"+request.status+"\n"+"\n"+"error:"+error);
	        //alert("code:"+request.status+"\n"+"\n"+"error:"+error);
 	   }
	});
	*/
	
}


function fn_otoinqUIUpdate(OtoCnt){
	//alert(GpaAvg+"-"+GpaCnt);
	//$("#useepil_uiTopHearts").html("<h1>asadasdas</h1>");

	//$("#otoinq_uiTab").text("("+OtoCnt+")");
}

function fn_otoinqEditSH(otoinqNum){
	$("#otoContEditDiv"+otoinqNum).toggle();
}
