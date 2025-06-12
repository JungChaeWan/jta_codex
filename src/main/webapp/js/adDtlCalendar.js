/****************************************************************
 * adDtlCalendar.js
 * 상품 상세 달력.js
 * 
 */


var g_AD_getContextPath = "";

function InitADCalendar(corpId, prdtNum, YYYYMMDD, iNight){
	
	
	var iYear	= parseInt(YYYYMMDD.substring(0,4), 10);
	var iMonth 	= parseInt(YYYYMMDD.substring(4,6), 10);
//	var iToDay	= parseInt(YYYYMMDD.substring(6,8), 10);
	
	var parameters = "corpId="+corpId;
	parameters+= "&prdtNum="+prdtNum;
	parameters+= "&iYear="+iYear;
	parameters+= "&iMonth="+iMonth;
	parameters+= "&iNight="+iNight;
	parameters+= "&sFromDt="+YYYYMMDD;
	
	$.ajax({
		type:"post", 
		// dataType:"json",
		// async:false,
		url:g_AD_getContextPath+'/web/ad/adDtlCalendar.ajax',
		data:parameters ,
		success:function(data){
			$("#adDtlCanendar").html(data);
			
			updateADCalendar_end();
		},
		error:function(request,status,error){
	        alert("code:"+request.status+"\n"+"\n"+"error:"+error);
	        //alert("code:"+request.status+"\n"+"\n"+"error:"+error);
 	   }
	});
}

function updateADCalendar(){
	var parameters = $("#adDtlCalendar").serialize();

	$.ajax({
		type:"post", 
		// dataType:"json",
		// async:false,
		url:g_AD_getContextPath+'/web/ad/adDtlCalendar.ajax',
		data:parameters ,
		success:function(data){
			$("#adDtlCanendar").html(data);
	
			updateADCalendar_end();
		},
		error:function(request,status,error){
	        alert("code:"+request.status+"\n"+"\n"+"error:"+error);
	        //alert("code:"+request.status+"\n"+"\n"+"error:"+error);
 	   }
	});
}

//다음달 이전달
function updateADCalendarPrevNext(sPrevNext){
	$("#adDtlCalendar").children('#sPrevNext').val(sPrevNext);
	updateADCalendar();
}

//방 변경
function changePrdtADCalendar(prdtNum){
	$("#adDtlCalendar").children('#prdtNum').val(prdtNum);
	$("#adDtlCalendar").children('#scriptVal').val("CR");
	updateADCalendar();
	//왼쪽 수정

}

function changePrdtADCalendarUpdate(maxiMem, roomTitle){
	var iMaxiMem =parseInt(maxiMem, 10);
	
	//인원 콤보 박스 변경
	var strSelHtml1 = "";
	var strSelHtml2 = "";
	var strSelHtml3 = "";
	for(var i=0; i<=iMaxiMem; i++){
		strSelHtml1 += '<option value="'+i+'">성인'+i+'인</option>';
		strSelHtml2 += '<option value="'+i+'">소아'+i+'인</option>';
		strSelHtml3 += '<option value="'+i+'">유아'+i+'인</option>';
	}
	$("#adDtlInput").find('#adCalMen1').html(strSelHtml1);
	$("#adDtlInput").find('#adCalMen2').html(strSelHtml2);
	$("#adDtlInput").find('#adCalMen3').html(strSelHtml3);
	
	$("#adDtlInput").find('#adCalRoomTitle').text(roomTitle);
	
}

//달력 날짜 선택
function selectADCalendar(YYYYMMDD){
	$("#adDtlCalendar").children('#sFromDt').val(YYYYMMDD);
	$("#adDtlCalendar").children('#scriptVal').val("SD");
	updateADCalendar();
	
	//날짜 수정
	$("#adDtlInput").find('#adCalDate').val(
			YYYYMMDD.substring(0,4) + "-" +
			YYYYMMDD.substring(4,6) + "-" +
			YYYYMMDD.substring(6,8) );
}

function selectADCalendarUpdate(price1, price2, price3, addamtYn){
	
	if(addamtYn == "Y"){
		$("#adDtlInput").find('#adCalPriceInfo').html(
				'<span class="line">성인 : <span class="money">'+price1+'</span>원 / </span>'+
				'<span class="line">소아 : <span class="money">'+price2+'</span>원 / </span>'+
				'<span class="line">유아 : <span class="money">'+price3+'</span>원 </span>');
	}else{
		$("#adDtlInput").find('#adCalPriceInfo').html(
				'<span class="line">성인 : <span class="money">'+'없음'+'</span> / </span>'+
				'<span class="line">소아 : <span class="money">'+'없음'+'</span> / </span>'+
				'<span class="line">유아 : <span class="money">'+'없음'+'</span> </span>');
	}
}

//n박 수정
function selectADCalendarNight(obj){
	$("#adDtlCalendar").children('#iNight').val(obj.value);
	updateADCalendar();
}

function updateADCalendar_end(){
	var endVal = $("#adDtlInput").children('#EndVal').val();
	
	var adCalMen1 = $("#adDtlInput").find('#adCalMen1').val();
	var adCalMen2 = $("#adDtlInput").find('#adCalMen2').val();
	var adCalMen3 = $("#adDtlInput").find('#adCalMen3').val();

	
	var parameters = "prdtNum="+$("#adDtlCalendar").children('#prdtNum').val();
	parameters += "&sFromDt="+$("#adDtlCalendar").children('#sFromDt').val();
	parameters += "&iNight="+$("#adDtlCalendar").children('#iNight').val();
	parameters += "&adCalMen1="+adCalMen1;
	parameters += "&adCalMen2="+adCalMen2;
	parameters += "&adCalMen3="+adCalMen3;	

	$.ajax({
		//type:"post", 
		dataType:"json",
		// async:false,
		url:g_AD_getContextPath+'/web/ad/adDtlAddPrdt.ajax',
		data:parameters ,
		success:function(data){
			var iNight  = $("#adDtlCalendar").children('#iNight').val();

			if (iNight < parseInt(data['minRsvNight'])) {
				iNight = parseInt(data['minRsvNight']);
				$("#adDtlCalendar").children('#iNight').val(data['minRsvNight']);
			}

			if(data["Status"] == 1){
				//alert("성공:"+ data["Price"]);
				var iPrice = parseInt(data["Price"], 10);
				$("#adDtlInput").find('#adNowPrice').text(iPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
				
				$("#adDtlInput").find('#adBtnErrInfo').text("");
				
				if( endVal == '' || endVal == null){
					//상세 페이지
					if($("#adDtlInput").find("#payinfo_plus p").length == 0){
						$("#adDtlInput").find('#adBtnPrdt1').show();
						$("#adDtlInput").find('#adBtnPrdt1A').hide();
					}else{
						$("#adDtlInput").find('#adBtnPrdt1').hide();
						$("#adDtlInput").find('#adBtnPrdt1A').show();
					}
					$("#adDtlInput").find('#adBtnPrdt2').hide();
					
				}else if(endVal == 'cart'){
					$("#adDtlInput").find('#adBtnPrdt1').show();
					$("#adDtlInput").find('#adBtnPrdt2').hide();
				}
								
			}else{
				var strMsg = "";
				if(data["Status"] == 0){
					strMsg = "투숙인원을 선택 하세요.";
				}else if(data["Status"] == -1){
					strMsg = "투숙 최대 인원을 넘었습니다.";
				}else if(data["Status"] == -2){
					strMsg = "투숙 날짜중에 마감/미정이 있습니다.";
				}else if(data["Status"] == -3){
					strMsg = "없는 객실 입니다.";
				}else{
					strMsg = "오류("+data["Status"]+")";
				}
				
				$("#adDtlInput").find('#adNowPrice').text("0");
				
				if( endVal == '' || endVal == null){
					
					if($("#adDtlInput").find("#payinfo_plus p").length == 0){
						$("#adDtlInput").find('#adBtnPrdt1').show();
						$("#adDtlInput").find('#adBtnPrdt1A').hide();
					}else{
						$("#adDtlInput").find('#adBtnPrdt1').hide();
						$("#adDtlInput").find('#adBtnPrdt1A').show();
					}
					$("#adDtlInput").find('#adBtnPrdt2').hide();

				}else if(endVal == 'cart'){
					$("#adDtlInput").find('#adBtnPrdt1').hide();
					$("#adDtlInput").find('#adBtnPrdt2').show();
				}
				
				$("#adDtlInput").find('#adBtnErrInfo').text(strMsg);

			}		
			// 박 select box 수정
			$('#adCalNight option').remove();	// 초기화
			for (var i=parseInt(data['minRsvNight']); i<=parseInt(data['maxRsvNight']); i++) {
				const selected_str = i == iNight ? ' selected="selected"' : '';
				const class_str = data["ctnAplYn"] == "Y" && data["ctnMap"][i] > 0 ? ' class="text-red"' : '';
				const dis_str = data["ctnAplYn"] == "Y" && data["ctnMap"][i] > 0 ? ' 할인' : '';
				$('#adCalNight').append('<option value="' + i + '"' + class_str + selected_str + ' >' + i + '박' + (eval(i)+1) + '일' + dis_str + '</option>');
			}

			// 최소 박 & 최대 박 text 수정			
			$('#minRsvNight').html(data['minRsvNight']);
			$('#maxRsvNight').html(data['maxRsvNight']);
			
			// select box style 변경
			if ($('#adCalNight option:selected').attr('class') != undefined) {
				 $('#adCalNight').addClass('text-red');
				 
				 $('#adCalNight option').each(function() {    			 
			    	if ($(this).attr('class') != 'text-red')    	    		
			    		$(this).attr("style", 'color:#000000');
			     });
			 }
			 else {
				 $('#adCalNight').removeClass('text-red');
			 }

			//캘린더예약 총합계 계산식
			if(data['Status'] == "1") {
				if (iNight >= 5 ) { iNight = 5; }
				$("#jBaseDay").text("("+$("#adDtlCalendar").children('#iNight').val()+"박)");
				$("#jBasePrice").text(  commaNum(data["basePrice"]) + "원");
				$("#jAdultAddAmt").text("+"+commaNum(data["adultAddAmt"])+ "원");
				$("#jChildAddAmt").text(commaNum("+"+data["childAddAmt"])+ "원");
				$("#jJuniorAddAmt").text(commaNum("+"+data["juniorAddAmt"])+ "원");
				if (data["ctnAplYn"] == "Y" && data["ctnMap"][iNight] > 0) {
				$("#jCtnAmt").text(commaNum("-"+data['ctnMap'][iNight])+ "원");
				}else{
					$("#jCtnAmt").text("-0원");
				}
			}else{
				$("#jBasePrice").text("0원");
				$("#jAdultAddAmt").text("+0원");
				$("#jChildAddAmt").text("+0원");
				$("#jJuniorAddAmt").text("+0원");
				$("#jCtnAmt").text("-0원");
			}
		},
		error:function(request,status,error){
	        alert("code:"+request.status+"\n"+"\n"+"error:"+error);
 	   }
	});
	
}


