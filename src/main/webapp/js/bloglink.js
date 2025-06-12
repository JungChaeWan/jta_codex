/****************************************************************
 * bloglink.js
 * js
 *
 */

//var g_bl_corpId;
var g_bl_prdtnum;
var g_bl_corpCd;
var g_bl_page=1;

var g_bl_getContextPath = "";


function fn_bloglistInitUI(Bl_prdtnum, Bl_corpCd){
	//var parameters = $("#bloglistFrm").serialize();

	//console.log("2:"+g_bl_prdtnum+" : " + g_bl_corpCd );

	//if (Bl_corpTel == 'undefinded')
	//	Bl_corpTel = '';

	var parameters = "prdtNum="+Bl_prdtnum
	               + "&corpCd="+Bl_corpCd;


	$.ajax({
		type:"post",
		// dataType:"json",
		async:false,
		url:g_bl_getContextPath+'/web/cmm/bloglistIntiUI.ajax',
		data:parameters ,
		success:function(data){
			//$("#tabs-5").html(data);
			if(data.Status == "success"){
				//alert("ok");
				fn_bloglistUIUpdate(data.BlCnt, data.authNm);
			}else{
				alert("Error");
			}
		},
		error:function(request,status,error){
	        alert("fn_bloglistInitUI - code:"+request.status+"\n"+"\n"+"error:"+error);
	        //alert("code:"+request.status+"\n"+"\n"+"error:"+error);
 	   }
	});

}


function fn_bloglistUIUpdate(BlCnt, authNm){
	//alert(GpaAvg+"-"+GpaCnt);
	//$("#useepil_uiTopHearts").html("<h1>asadasdas</h1>");
	//console.log("====" + BlCnt + "   " + authNm);


	if(BlCnt!=0 || authNm=='ADMIN'){
		$("#bloglist_uiTab").text("("+BlCnt+")");
		$("#bloglist_liTab").show();
	}else{
		$("#bloglist_liTab").hide();
	}
}


function fn_blogList(Bl_prdtnum, Bl_corpCd){
	//var parameters = $("#frm").serialize();

	//alert(g_Oto_getContextPath);

	//console.log("1:"+Oto_corpId+" : " + Oto_prdtnum +" : " + Oto_corpCd);

	var parameters = "prdtNum="+Bl_prdtnum
	               + "&corpCd="+Bl_corpCd
	               + "&pageIndex="+g_bl_page;

	$.ajax({
		type:"post",
		// dataType:"json",
		async:false,
		url:g_Oto_getContextPath+'/web/cmm/blogList.ajax',
		data:parameters ,
		success:function(data){
			$("#tabs-7").html(data);
		},
		error:function(request,status,error){
	        alert("fn_blogList - code:"+request.status+"\n"+"\n"+"error:"+error);
	        //alert("code:"+request.status+"\n"+"\n"+"error:"+error);
 	   }
	});
}

function fn_blogList1(){

	var parameters = "prdtNum="+g_bl_prdtnum
	               + "&corpCd="+g_bl_corpCd
	               + "&pageIndex="+g_bl_page;

	//console.log("1:"+ parameters);

	$.ajax({
		type:"post",
		// dataType:"json",
		async:false,
		url:g_Oto_getContextPath+'/web/cmm/blogList.ajax',
		data:parameters ,
		success:function(data){
			$("#tabs-7").html(data);
		},
		error:function(request,status,error){
	        alert("fn_blogList - code:"+request.status+"\n"+"\n"+"error:"+error);
	        //alert("code:"+request.status+"\n"+"\n"+"error:"+error);
 	   }
	});
}


function fn_blogSearch(pageIndex){
	g_bl_page = pageIndex;
	fn_blogList1();
}





function reloadBlogList(Bl_prdtnum, Bl_corpCd){
	fn_bloglistInitUI(Bl_prdtnum, Bl_corpCd);

	fn_blogList(Bl_prdtnum, Bl_corpCd);
}


function fn_blogLinkDel(blogLinkNum, prdtNum, corpCd){
	//var parameters = $("#bloglistFrm").serialize();

	//console.log("2:"+Bl_corpId+" : " + Bl_prdtnum +" : " + Bl_corpCd);

	//if (Bl_corpTel == 'undefinded')
	//	Bl_corpTel = '';

	if(confirm("삭제 하시겠습니까?") == true){

		var parameters = "blogLinkNum="+blogLinkNum
			+"&prdtNum=" + prdtNum
			+"&corpCd=" + corpCd;

		$.ajax({
			type:"post",
			// dataType:"json",
			async:false,
			url:g_bl_getContextPath+'/web/cmm/blogLinkDel.ajax',
			data:parameters ,
			success:function(data){
				//$("#tabs-5").html(data);
				if(data.Status == "success"){
					//alert("ok");
					reloadBlogList(data.prdtNum, data.corpCd);
				}else{
					alert("Error");
				}
			},
			error:function(request,status,error){
		        alert("fn_blogDel - code:"+request.status+"\n"+"\n"+"error:"+error);
		        //alert("code:"+request.status+"\n"+"\n"+"error:"+error);
	 	   }
		});
	}

}


