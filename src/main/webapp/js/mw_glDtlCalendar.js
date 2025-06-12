/****************************************************************
 * adDtlCalendar.js
 * 상품 상세 달력.js
 * 
 */


var g_GL_getContextPath = "";

function InitGLCalendar(prdtNum, YYYYMMDD){
	
	var iYear	= parseInt(YYYYMMDD.substring(0,4), 10);
	var iMonth 	= parseInt(YYYYMMDD.substring(4,6), 10);
	//var iToDay	= parseInt(YYYYMMDD.substring(6,8), 10);
	
	var parameters = "prdtNum="+prdtNum;
	parameters+= "&iYear="+iYear;
	parameters+= "&iMonth="+iMonth;
	parameters+= "&sFromDt="+YYYYMMDD;
	
	$.ajax({
		type:"post", 
		// dataType:"json",
		// async:false,
		url:g_GL_getContextPath+'/mw/gl/glDtlCalendar.ajax',
		data:parameters ,
		success:function(data){
			$("#glDtlCanendar").html(data);
			
			updateGLCalendar_end(); // TOOD::
		},
		error:function(request,status,error){
	        alert("code:"+request.status+"\n"+"\n"+"error:"+error);
	        //alert("code:"+request.status+"\n"+"\n"+"error:"+error);
 	   }
	});
	
}

function updateGLCalendar(){
	var parameters = $("#glDtlCalendar").serialize();
	
	$.ajax({
		type:"post", 
		// dataType:"json",
		// async:false,
		url:g_GL_getContextPath+'/mw/gl/glDtlCalendar.ajax',
		data:parameters ,
		success:function(data){
			$("#glDtlCanendar").html(data);
			
			updateGLCalendar_end();
		},
		error:function(request,status,error){
	        alert("code:"+request.status+"\n"+"\n"+"error:"+error);
	        //alert("code:"+request.status+"\n"+"\n"+"error:"+error);
 	   }
	});
}

//다음달 이전달
function updateGLCalendarPrevNext(sPrevNext){
	//alert(sPrevNext);
	$("#glDtlCalendar").children('#sPrevNext').val(sPrevNext);
	$('#sPrevNext').val(sPrevNext);
	updateGLCalendar();
}

function setGLCalendarTmData(cnt, ddlYn, rsvAbleGrp, rsvCmplGrp){
	var nRsv;
	
	if(ddlYn=='Y'){
		$("#glDtlInput").find('#cntDay'+cnt).val('0');	
	}else{
		nRsv = rsvAbleGrp - rsvCmplGrp;
		if(nRsv >= 0){
			$("#glDtlInput").find('#cntDay'+cnt).val(''+nRsv);
		}else{
			$("#glDtlInput").find('#cntDay'+cnt).val('0');
		}
	}
}

function changeGLCalendarTmHalfSel(obj){
	var sHalf = obj.value;
	var sHtml ="";
	var i;
	
	if(sHalf=='am'){
		for(i=6; i<=12; i++){
			if(i<10){
				sHtml += '<option value="0'+i+'">0'+i+':00';
			}else{
				sHtml += '<option value="'+i+'">'+i+':00';
			}
			
			if($("#glDtlInput").find('#cntDay'+i).val() == '0'){
				sHtml += '(마감)';
			}else{
				sHtml += '('+$("#glDtlInput").find('#cntDay'+i).val()+'개조)';			
			}
			sHtml += '</option>';
		}
	}else{
		for(i=13; i<=15; i++){
			sHtml += '<option value="'+i+'">0'+(i-12)+':00';
			
			if($("#glDtlInput").find('#cntDay'+i).val() == '0'){
				sHtml += '(마감)';
			}else{
				sHtml += '('+$("#glDtlInput").find('#cntDay'+i).val()+'개조)';			
			}
			sHtml += '</option>';
		}
		
	}
	
	$("#glDtlInput").find('#hour').html(sHtml);
	
	updateGLCalendar_end();
}


function changeGLCalendarTmHalf_tm(sTime){
	var sHtml ="";
	var i;
	//var sTime = $("#glDtlInput").find('#hour').val();
	var iTime = 6; 
	
	if(sTime != ""){
		iTime = parseInt(sTime, 10);
	}
	
	if(iTime <= 12){
		sHalf = "am";
		$("#glDtlInput").find('#half').val('am');
	}else{
		sHalf = "pm";
		$("#glDtlInput").find('#half').val('pm');
	}

	if(sHalf=='am'){
		for(i=6; i<=12; i++){
			//console.log(">>>>"+iTime+ ":" + i);
			if(i<10){
				if(iTime!=i){
					sHtml += '<option value="0'+i+'">0'+i+':00';
				}else{
					sHtml += '<option value="0'+i+'" selected="selected">0'+i+':00';
				}
			}else{
				if(iTime!=i){
					sHtml += '<option value="'+i+'">'+i+':00';
				}else{
					sHtml += '<option value="'+i+'" selected="selected">'+i+':00';
				}
			}
			
			if($("#glDtlInput").find('#cntDay'+i).val() == '0'){
				sHtml += '(마감)';
			}else{
				sHtml += '('+$("#glDtlInput").find('#cntDay'+i).val()+'개조)';			
			}
			sHtml += '</option>';
		}
	}else{
		for(i=13; i<=15; i++){
			if(iTime!=i){
				sHtml += '<option value="'+i+'">0'+(i-12)+':00';
			}else{
				sHtml += '<option value="'+i+'" selected="selected">0'+(i-12)+':00';
			}
			
			if($("#glDtlInput").find('#cntDay'+i).val() == '0'){
				sHtml += '(마감)';
			}else{
				sHtml += '('+$("#glDtlInput").find('#cntDay'+i).val()+'개조)';			
			}
			sHtml += '</option>';
		}
		
	}
	
	$("#glDtlInput").find('#hour').html(sHtml);
}


function changeGLCalendarTmHalf(){
	var sTime = $("#glDtlInput").find('#hour').val();
	changeGLCalendarTmHalf_tm(sTime);	
}



//달력 날짜 선택
function selectGLCalendar(YYYYMMDD){
	$("#glDtlCalendar").children('#sFromDt').val(YYYYMMDD);
	$("#glDtlCalendar").children('#scriptVal').val("SD");
	updateGLCalendar();
	
	//날짜 수정
	$("#glDtlInput").find('#glCalDate').val(
			YYYYMMDD.substring(0,4) + "-" +
			YYYYMMDD.substring(4,6) + "-" +
			YYYYMMDD.substring(6,8) );

}

function changTimeGLCalendar(){
	alert("정확한 티업시간은 별도 안내해드립니다.");
	updateGLCalendar_end();
}

function updateGLCalendar_end(){
	
	var endVal = $("#glDtlInput").children('#EndVal').val();
		
	var parameters = "prdtNum="+$("#glDtlCalendar").children('#prdtNum').val();
	parameters += "&sFromDt="+$("#glDtlCalendar").children('#sFromDt').val();
	parameters += "&tm="+$("#glDtlInput").find('#hour').val();
	parameters += "&Rsv="+$("#glDtlInput").find('#personnel').val();
	
	$.ajax({
		//type:"post", 
		dataType:"json",
		// async:false,
		url:g_GL_getContextPath+'/web/gl/glDtlAddPrdt.ajax',
		data:parameters ,
		success:function(data){
			//alert(data["Status"]);
			
			var YYYYMMDD = data["sFromDt"];
			var tm = data["tm"];
			var Rsv = data["Rsv"];
			// var itm = parseInt(tm, 10);
			var Year	= YYYYMMDD.substring(0,4);
			var Month 	= YYYYMMDD.substring(4,6);
			var ToDay	= YYYYMMDD.substring(6,8);
			var strText = "";
			
			strText = Year +"-"+Month+"-"+ToDay+ " " + tm + ":00 " +  Rsv + "인 1조";
			$("#glDtlInput").find('#glPrdtText').text(strText);
						
			if(data["Status"] == 1){
				//alert("성공:"+ data["Price"]);
								
				
				var iPrice = parseInt(data["Price"], 10);
				$("#glDtlInput").find('#glNowPrice').text(iPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
				
				$("#glDtlInput").find('#glBtnErrInfo').text("");
				
				if( endVal == '' || endVal == null){
					//상세 페이지
					if($("#glDtlInput").find("#payinfo_plus p").length == 0){
						$("#glDtlInput").find('#glBtnPrdt1').show();
						$("#glDtlInput").find('#glBtnPrdt1A').hide();
					}else{
						$("#glDtlInput").find('#glBtnPrdt1').hide();
						$("#glDtlInput").find('#glBtnPrdt1A').show();
					}
					$("#glDtlInput").find('#glBtnPrdt2').hide();
				}else if(endVal == 'cart'){
					//카트
					$("#glDtlInput").find('#glPrdtBtn1').show();
					$("#glDtlInput").find('#glPrdtBtn2').hide();
				}
				
			}else{
				
				var strMsg = "";
				if(data["Status"] == 0){
					strMsg = "예약인원을 입력 하세요.";
				}else if(data["Status"] == -1){
					strMsg = "예약 최대 인원을 넘었습니다.";
				}else if(data["Status"] == -2){
					strMsg = "마감되 었습니다.";
				}else if(data["Status"] == -3){
					strMsg = "없는 상품 입니다.";
				}else if(data["Status"] == -4){
					strMsg = "최소인원 미달입니다.";
				}else if(data["Status"] == -5){
					strMsg = "가격/수량이 미정입니다.";
				}else{
					
					strMsg = "오류("+data["Status"]+")";
				}
				
				$("#glDtlInput").find('#glNowPrice').text("0");
				
				if( endVal == '' || endVal == null){
					//상세 페이지
					if($("#glDtlInput").find("#payinfo_plus p").length == 0){
						$("#glDtlInput").find('#glBtnPrdt1').show();
						$("#glDtlInput").find('#glBtnPrdt1A').hide();
					}else{
						$("#glDtlInput").find('#glBtnPrdt1').hide();
						$("#glDtlInput").find('#glBtnPrdt1A').show();
					}
					$("#glDtlInput").find('#glBtnPrdt2').hide();
				}else if(endVal == 'cart'){
					//카트
					$("#glDtlInput").find('#glPrdtBtn1').hide();
					$("#glDtlInput").find('#glPrdtBtn2').show();
				}
				
				$("#glDtlInput").find('#glBtnErrInfo').text(strMsg);
			}
			
		},
		error:function(request,status,error){
	        alert("code:"+request.status+"\n"+"\n"+"error:"+error);
	        //alert("code:"+request.status+"\n"+"\n"+"error:"+error);
 	   }
	});


}
