/****************************************************************
 * common.js
 * 공통 js
 * 
 * 		설명							함수명
 * 1.  날짜 하이픈자동 삽입				adddash
 * 2.  Month형식 체크					CheckMonth
 * 3.  day형식 체크						CheckDay
 * 4.  수치형 자료인가 검사				isNumber
 * 5.  Date Type 검사					CheckDate
 * 6.  한글체크							hanCheck
 * 7.  숫자만 입력 가능					fn_checkNumber
 * 8.  숫자 형식 체크					fn_checkNumerBlur
 * 9.  존재하는 코드인지 확인			fn_validateCode
 * 10. 두개의 코드배열의 중복 코드 확인	fn_compareToArrange
 * 11. 메뉴 주소에 따른 분기			fn_linkedMenu
 * 12. 이메일 형식 체크					fn_is_email
 * 13. replaceALL						fn_replaceAll
 * 14. 하이라이트 처리					fn_highLightReplace
 * 14. 하이라이트 처리					fn_Highlight
 * 15. 한글여부체크						isKorean
 * 16. byte수계산						strLengthCheck
 * 17. 날짜 년월일 형식으로 리턴		fn_addDate
 * 18. 단위환산							fn_changeMoney
 * 19. 현재일보다 이후 날짜인지 체크	checkByToday
 * 20. 숫자형 콤마붙이기				commaNum
 * 21. 시간형식 체크        			checkIsTime
 * 22. 핸드폰형식 체크					checkIsHP
 * 23. 전화번호형식 체크				checkIsPhoneNum
 * 24. null 체크						isNull
 * 25. 현재날짜 리턴					currentDay
 * 26. 영문 or 숫자 입력인지 체크		checkEngAndNum
 * 27. 패스워드 영문,숫자,특수문자 조합 체크	checkIsPwMix
 * 28. 0-100 사이의 숫자인지 체크		checkPercentNum
 * 29. AJAX 에러 공통 처리				fn_AjaxError
 * 30. 기간 차이 날짜 리턴				getDiffDate
 * 31. Date 형변환						getDateString
 * 32. 날짜 포맷변환.				getDayFormat
 * 33. Email 형식의 스트링 중 도메인 부분만 추출 getEmailDomain
 * 34. Email 형식의 스트링 중 이메일 아이디 부분만 추출 getEmailId
 * 파일 체크 (확장자, 용량)             checkFile
 */


/* 날짜 하이픈 자동 삽입 */
function adddash(gap, a1, a2) {
	if ( event.keyCode != 8 ) {
		if ( gap.value.length==a1 ) gap.value=gap.value+"-";
		if ( gap.value.length==a2 ) gap.value=gap.value+"-";
	}
}

/* Month형식 체크 */
function CheckMonth(str){
    if (isNumber(str)==false) return false;
    if (str.length != 2) return false;
	if(Number(str)<0||Number(str)>12) return false;
    return true;
}

/* day형식 체크 */
function CheckDay(year,month,day){
	var startDate = new Date( year, month-1 );	//'월'은 0~11 까지임.
	var endDate = new Date( year, month );
	var strGapDt = (endDate.getTime()-startDate.getTime())/(1000*60*60*24);

   // if (isNumber(str)==false) return false;
 //   if (str.length != 2) return false;
	if ( day < 1 || day > strGapDt )return false;
	

    return true;
}

/* 수치형 자료인가 검사 */
function isNumber(str){        
    var i;
    if (str.length == 0) return true;
    for (i = 0; i < str.length; i++) {
        if (str.charAt(i) < '0' || str.charAt(i) > '9') return false;
        }
         
    return true;
} 

/**
 *  Date Type 검사 
 */
function CheckDate(str){
    var year;
    var month;
    var day;
    
	if (str.length == 8) {
		year = str.substring(0,4);
		month = str.substring(4,6);
		day = str.substring(6,8);
//		alert("year : " + year + "|| month : " + month + "|| day : " + day);

	//	if(isNumber)
	//	alert(str.charAt(4));
		if( year < 1900|| year > 2100 ) return false;
		if (isNumber(year)==false) return false;
		if (CheckMonth(month)==false) return false;    
		if (CheckDay(year,month,day)==false) return false;    
	} 
	/** 년도, 년월 DATE 타입 쓰지 않음*/
	/*else if (str.length==6) {
		year = str.substring(0,4);
		month = str.substring(4,6);
		if (isNumber(year)==false) return false;
		if (CheckMonth(month)==false) return false;    
	} else if (str.length==4) {
		year = str.substring(0,4);		
		if (isNumber(year)==false) return false;		
	} else if (str.length==0) return true;*/
	else return false;
    return true;
}

function checkType(obj)
{
	
	var strDate = obj.value.replace(/-/g,"");
	if (CheckDate(strDate)==false) {
		alert('날짜를 잘못 입력하셨습니다!\n예) 2015-01-01 or 20150101');
		obj.focus();
		return false;
	}else{
		if(strDate.length==8){
			obj.value = strDate.substring(0,4) + "-" + strDate.substring(4,6) + "-" + strDate.substring(6,8);
		}else if(strDate.length==6){
			obj.value = strDate.substring(0,4) + "-" + strDate.substring(4,6);
		}
	}
	return true;
}

/**
 * 숫자만 입력 가능
 */
function fn_checkNumber() {
	
	 //좌우 방향키, 백스페이스, 딜리트, 탭키에 대한 예외
    if(event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 || event.keyCode == 39|| event.keyCode == 46 ) return;
    
	if( (event.keyCode < 48 ) || ((event.keyCode > 57) && (event.keyCode < 96)) || (event.keyCode > 105 )) {
		event.returnValue = false;
	}
}

/**
 * 숫자, 콤마만 입력 가능
 */
function fn_checkNumber2() {
	var charCode = (event.which) ? event.which : event.keyCode;
	
	//좌우 방향키, 백스페이스, 딜리트, 탭키에 대한 예외
    if(event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 || event.keyCode == 39|| event.keyCode == 46 ) return;
    
	if( event.keyCode != 110 && event.keyCode != 190 && ((event.keyCode < 48 ) || ((event.keyCode > 57) && (event.keyCode < 96)) || (event.keyCode > 105 ))) {
		event.returnValue = false;
	}
	
	var eventVal = event.srcElement.value;
	
	var pattern1 = /^\d*[.]\d*$/;
	
	if(pattern1.test(eventVal)){
		if( event.keyCode == 110 || event.keyCode == 190) event.returnValue = false;
	}
	
	var pattern2 = /^\d{2}$/;
	
	if(pattern2.test(eventVal)){
		if(!(charCode == 110 || charCode == 190)){
			alert("100 이하의 숫자만 입력 가능합니다.");
			event.returnValue = false;
		}
	}
	var pattern = /^\d*[.]\d{2}$/;
	
	if(pattern.test(eventVal)){
		alert("소수점 둘째자리까지만 입력 가능합니다.");
		event.returnValue = false;
	}
	return true;
}

function fn_checkNumber3(event) {	
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	
	 //좌우 방향키, 백스페이스, 딜리트, 탭키에 대한 예외
    if(keyID == 8 || keyID == 9 || keyID == 37 || keyID == 39|| keyID == 46 ) return;
	 
	if( ( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 ) )
		return;
	else
		return false;
}

/**
 * 존재하는 코드인지 확인
 * @param obj
 * @param codeStr
 * @param DivInfoItem
 * @returns {Boolean}
 */
function fn_validateCode(obj, codeStr, DivInfoItem){
	if(codeStr == "" || codeStr == null) return false;
	var code = codeStr.split(";");
	for(var i = 0;i<code.length;i++){
		var chkCode = code[i];
		var chkYn = false;
		
		for(var xi = 0;xi<code.length;xi++){
			if(chkCode == code[xi] && i != xi){
				alert("중복된 코드가 있습니다.");
				obj.focus();
				return false;
			}
		}
		for(var j=0;j<DivInfoItem.length;j++){
			if(chkCode == DivInfoItem[j].value){
				chkYn = true;
			}
			
		}
		if(!chkYn){
			obj.focus();
			alert("입력하신 코드는 존재하지 않는 코드입니다.");
			return false;
		}
	}
}

function fn_is_email(s) {
	if (s.replace(/\s/g, '')=='') {
		return true;
	}
	
	// 2015.11.17 정규식으로 변경
	var regExp = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	return regExp.test(s);
}

//생년월일 8자리 ex)19821011
function fn_is_birth(sBrith) {
	var regExp = /^(19[0-9][0-9]|20\d{2})(0[0-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/;
	return regExp.test(sBrith);
}

//주민번호 뒷 7자리
function fn_is_lrrn(sLrrn) {
	var regExp = /\b[1-4][0-9]{6}\b/g;
	return regExp.test(sLrrn);
}

function fn_replaceAll(str1, str2, str3){
	var oridata = str1;
	while(oridata.indexOf(str2) > -1){
		oridata = oridata.replace(str2,str3);
	}
	return oridata;
}


/**
 * 한글여부체크
 */
function isKorean(value) {//한글체크
	var numUnicode = value.charCodeAt(0);
	if(44031 <= numUnicode && numUnicode <= 55203 || 12593 <= numUnicode && numUnicode <= 12643) return true;
	else return false;
}
/**
 * byte수 계산
 * @param value
 * @returns {Number}
 */
function strLengthCheck(value) {//한글or영문byte체크
	var strlen = 0;
	var str;
	var len = value.length;
	var i;
	for(i=0; i<len; i++) {
		str = value.substr(i, 1);
		if(isKorean(str)) {
			strlen = strlen + 3;
		}
		else {
			strlen = strlen + 1;
		}
	}
	return strlen;
}

/**
 * 날짜 YYYY-MM-DD으로 리턴
 * @param day
 * @returns {String}
 */
function fn_addDate(day){
	if(day == null){
		return "";
	}
	day = day.replace(/-/g,"");
	if(day == ""){
		return "";
	}else if(day.length == 4){
		return day.substr(0,4);
	}else if(day.length == 6){
		if(day.substr(4,2) == '00'){
			return day.substr(0,4);
		}else{
			return day.substr(0,4) + "-" + day.substr(4,2);
		}
	}else{
		if(day.substr(6,2) == '00'){
			if(day.substr(4,2) == '00'){
				return day.substr(0,4);
			}else{
				return day.substr(0,4) + "-" + day.substr(4,2);
			}
		}else{
			return day.substr(0,4) + "-" + day.substr(4,2) + "-" + day.substr(6,2);
		}
		
	}
}

/**
 * 숫자형 콤마 붙이기
 */
function commaNum(num) {  
    var len, point, str;
    var prefix = "";

	num = num.toString().replace(/,/gi,"");
    if(num.toString().substring(0, 1)=="-"||num.toString().substring(0, 1)=="+"){
    	prefix = num.toString().substring(0, 1);
    	num = num.toString().substring(1);
    }
    num = num + "";
    point = num.length % 3;
    len = num.length;

    str = num.substring(0, point);  
    while (point < len) {  
        if (str != "") str += ",";  
        str += num.substring(point, point + 3);  
        point += 3;  
    }  
    return prefix + str;
}

/**
 * 시작일자가 종료일자보다 미래날짜인지 체크
 * @param fromDate	시작일자
 * @param toDate	종료일자
 * @param todayYn	날짜가 같은경우 허용 여부
 * @returns {Boolean}
 */
function checkByFromTo(fromDate1, toDate1, todayYn){
	var fromDate = fromDate1.replace(/-/g,"");
	var toDate   = toDate1.replace(/-/g,"");
	
	if(!CheckDate(fromDate)){
		return false;
	}
	if(!CheckDate(toDate)){
		return false;
	}
	var fDate = new Date(fromDate.substring(0,4), (fromDate.substring(4,6)-1), fromDate.substring(6,8));
	var tDate = new Date(toDate.substring(0,4), (toDate.substring(4,6)-1), toDate.substring(6,8));
	
	if("Y" == todayYn){
		if(fDate == tDate){
			return true;
		}
	}
	if(fDate > tDate){
		return false;
	}else{
		return true;
	}
}

/**
 * 핸드폰 형식 체크
 * @param phoneNum
 * @returns
 */
function checkIsHP(phoneNum){
	var regExp = /(01[0|1|6|7|8|9])[-](\d{4}|\d{3})[-]\d{4}$/g;
	
	return regExp.test(phoneNum);
}

/**
 * 전화번호 형식 체크
 * @param phoneNum
 * @returns
 */
function checkIsPhoneNum(phoneNum){
	var regExp = /^\d{2,3}-\d{3,4}-\d{4}$/;
	
	return regExp.test(phoneNum);
}

/**
 * 전국 대표 전화번호(1544-, 1644-, 1688- 등) 형식 체크
 * @param phoneNum
 * @returns
 */
function checkIsBizPhoneNum(phoneNum){
	var regExp = /^\d{4}-\d{4,5}$/;
	
	return regExp.test(phoneNum);
}

/**
 * 이메일 패턴 체크
 * @param email
 * @returns
 */
function chekIsEmail2(email){
	var regExp=/^[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[@]{1}[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[.]{1}[A-Za-z]{2,5}$/;
	
	return regExp.test(email);
}

/**
 * NULL 체크
 * @param obj
 * @returns {Boolean}
 */
function isNull(val){
	if(val == "" || val == null){
		return true;
	}else{
		return false;
	}
}

/**
 * 현재 날짜 리턴
 * @returns
 */
function currentDay(){
	var nowDate = new Date();
	var cDate = nowDate.getFullYear().toString() + "-";
	cDate += ((nowDate.getMonth()+1).toString().length==1?"0" + (nowDate.getMonth()+1).toString():(nowDate.getMonth()+1).toString()) + "-";
	cDate += nowDate.getDate().toString().length==1?"0" + nowDate.getDate().toString():nowDate.getDate().toString();
	return cDate;
}

/**
 * 현재 시간 리턴
 * @returns
 */
function currentTime(){
	const today = new Date();

	const hours = ('0' + today.getHours()).slice(-2);
	const minutes = ('0' + today.getMinutes()).slice(-2);
	const seconds = ('0' + today.getSeconds()).slice(-2);

	const timeFormat = hours + ':' + minutes  + ':' + seconds;
	return timeFormat;
}

/**
 * 패스워드 영문,숫자,특수문자 조합 체크
 * @param pw
 * @returns
 */
function checkIsPwMix(pw){
	//var regExp =  /^(?=.*\d)(?=.*[~`!@#$\\^&*\\(\\)-_+])(?=.*[a-zA-Z]).{8,20}$/g;
	var regExp =  /^(?=.*\d)(?=.*[~`!@#$%\\^&*\\+=-_\\(\\)])(?=.*[a-zA-Z]).{8,20}$/g;
	//var regExp =  /^(?=.*\d)(?=.*[~`!@#$^&*-_+])(?=.*[a-zA-Z]).{8,20}$/g;
	 
	return regExp.test(pw);
}

function checkURL(str) {
	if(isNull(str)) return true;
	var regExp = /^(((http(s?))\:\/\/)?)([0-9a-zA-Z\-]+\.)+[a-zA-Z]{2,6}(\:[0-9]+)?(\/\S*)?$/;
	return regExp.test(str);
}
/**
 * Ajax 에러 처리
 * @param request
 * @param status
 * @param error
 */
function fn_AjaxError(request, status, error){
	if(request.status == "500"){
		alert("로그인 정보가 없습니다. 로그인 후 진행하시기 바랍니다.");
		location.reload(true);
	}else{
		console.log("에러가 발생했습니다!");
		console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	}
}

/**
 * Ajax 에러 처리
 * 로그인 정보가 없는경우 로그인 페이지로 이동(head.jsp 필수)
 * @param request
 * @param status
 * @param error
 */
function fn_AjaxError2(request, status, error){
	if(request.status == "500"){
		alert("로그인 정보가 없습니다. 로그인 후 진행하시기 바랍니다.");
		fn_loginUser();
	}else{
		console.log("에러가 발생했습니다!");
		console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	}
}

/** 날짜 문자열로 요일 구하기 **/
function getDate(dayVal) {
	const week = ['일', '월', '화', '수', '목', '금', '토'];
	const dayOfWeek = week[new Date(dayVal).getDay()];
	return dayOfWeek;
}

/**
 * 입력된 날짜 다음날 날짜 리턴
 * @param day
 * @returns {String}
 */
function fn_NexDay(day){
	day = day.replace(/-/g,"");
	
	var nowDate = new Date(day.substr(0,4), day.substr(4,2)-1, day.substr(6,2));
	nowDate.setDate(nowDate.getDate()+1);
	
	var cDate = nowDate.getFullYear().toString() + "-";
	cDate += ((nowDate.getMonth()+1).toString().length==1?"0" + (nowDate.getMonth()+1).toString():(nowDate.getMonth()+1).toString()) + "-";
	cDate += nowDate.getDate().toString().length==1?"0" + nowDate.getDate().toString():nowDate.getDate().toString();
	return cDate;
}

/**
 * 날짜 차이 계산
 * @param term
 * @returns {Date}
 */
Date.prototype.getDiffDate = function(term) {
	var time = this.getTime() + (parseInt(term, 10) * 24 * 60 * 60 * 1000 );
	var date = new Date();
	date.setTime(time);
	return date;
};


Number.prototype.to2 = function() { return (this > 9 ? "" : "0")+this; };
Date.MONTHS = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
Date.DAYS   = ["Sun", "Mon", "Tue", "Wed", "Tur", "Fri", "Sat"];
Date.prototype.getDateString = function(dateFormat) {
  var result = "";
  
  dateFormat = dateFormat == 8 && "YYYY.MM.DD" ||
               dateFormat == 6 && "hh:mm:ss" ||
               dateFormat ||
               "YYYY.MM.DD hh:mm:ss";
  for (var i = 0; i < dateFormat.length; i++) {
    result += dateFormat.indexOf("YYYY", i) == i ? (i+=3, this.getFullYear()                     ) :
              dateFormat.indexOf("YY",   i) == i ? (i+=1, String(this.getFullYear()).substring(2)) :
              dateFormat.indexOf("MMM",  i) == i ? (i+=2, Date.MONTHS[this.getMonth()]           ) :
              dateFormat.indexOf("MM",   i) == i ? (i+=1, (this.getMonth()+1).to2()              ) :
              dateFormat.indexOf("M",    i) == i ? (      this.getMonth()+1                      ) :
              dateFormat.indexOf("DDD",  i) == i ? (i+=2, Date.DAYS[this.getDay()]               ) :
              dateFormat.indexOf("DD",   i) == i ? (i+=1, this.getDate().to2()                   ) :
              dateFormat.indexOf("D"   , i) == i ? (      this.getDate()                         ) :
              dateFormat.indexOf("hh",   i) == i ? (i+=1, this.getHours().to2()                  ) :
              dateFormat.indexOf("h",    i) == i ? (      this.getHours()                        ) :
              dateFormat.indexOf("mm",   i) == i ? (i+=1, this.getMinutes().to2()                ) :
              dateFormat.indexOf("m",    i) == i ? (      this.getMinutes()                      ) :
              dateFormat.indexOf("ss",   i) == i ? (i+=1, this.getSeconds().to2()                ) :
              dateFormat.indexOf("s",    i) == i ? (      this.getSeconds()                      ) :
                                                   (dateFormat.charAt(i)                         ) ;
  }
  return result;
};

JSON.stringify = JSON.stringify || function (obj) {
    var t = typeof (obj);
    if (t != "object" || obj === null) {
        // simple data type
        if (t == "string") obj = '"'+obj+'"';
        return String(obj);
    }
    else {
        // recurse array or object
        var n, v, json = [], arr = (obj && obj.constructor == Array);
        for (n in obj) {
            v = obj[n]; t = typeof(v);
            if (t == "string") v = '"'+v+'"';
            else if (t == "object" && v !== null) v = JSON.stringify(v);
            json.push((arr ? "" : '"' + n + '":') + String(v));
        }
        return (arr ? "[" : "{") + String(json) + (arr ? "]" : "}");
    }
};

function fn_ValidateCart(param){
	var rtnMsg = "";
	var rtnBoolean = true;
	var prdtValidator = {};
	
	// 장바구니 공통 파라미터
	var defaultValidator = {
		prdtNum 	: "상품번호",
		prdtNm  	: "상품명",
		prdtDivNm 	: "상품구분명",
		totalAmt	: "총주문금액",
		nmlAmt		: "정상금액",
		corpId		: "업체아이디",
		corpNm		: "업체명"
	};
	
	var rcValidator = {
		fromDt 	: 	"대여시작일",
		toDt	:	"반납일",
		fromTm	:	"대여시간",
		toTm	:	"반납시간"
	};
	
	var adValidator = {
			
	};
	
	var spValidator = {
			qty : "수량",
			spOptSn : "옵션키",
			spDivSn : "구분자키"
	};
	
	if(param == undefined || param.length == 0){
		return false;
	}else{
		for(var idx=0;idx < param.length; idx++){
			var parameter = param[idx];
			
			// 공통 파라미터 체크
			Object.getOwnPropertyNames(defaultValidator).forEach(function(val, idx, obj){
				var isExist = false;
				// alert(val + "||" + parameters.val);
				Object.getOwnPropertyNames(parameter).forEach(function(pVal, pIdx, pObj){
					if(val == pVal){
						isExist = true;
						if(parameter[pVal] == undefined || parameter[pVal] == ""){
							rtnMsg = "필수 파라미터가 입력되지 않았습니다.(" + defaultValidator[val] + ")";
							rtnBoolean = false;
							return;
						}
					}
				});
				if(!isExist){
					rtnMsg = "필수 파라미터가 입력되지 않았습니다.(" + defaultValidator[val] + ")";
					rtnBoolean = false;
					return false;
				}
				// alert(val + "||" + defaultValidator[val]);
			});
			
			var prdtDiv = parameter.prdtNum.substr(0, 2).toLowerCase();
			
			switch(prdtDiv){
				case "rc" : prdtValidator = rcValidator; break;
				case "ad" : prdtValidator = adValidator; break;
				case "sp" : prdtValidator = spValidator; break;
			}
			
			Object.getOwnPropertyNames(prdtValidator).forEach(function(val, idx, obj){
				var isExist = false;
				
				Object.getOwnPropertyNames(parameter).forEach(function(pVal, pIdx, pObj){
					if(val == pVal){
						isExist = true;
						if(parameter[pVal] == undefined || parameter[pVal] == ""){
							rtnMsg = "필수 파라미터가 입력되지 않았습니다.(" + prdtValidator[val] + ")";
							rtnBoolean = false;
							return false;
						}
					}
				});
				if(!isExist){
					rtnMsg = "필수 파라미터가 입력되지 않았습니다.(" + prdtValidator[val] + ")";
					rtnBoolean = false;
					return;
				}
			});
		}
		return rtnBoolean;
	}
}

function getDayFormat(day, format) {
	if(day.length == 8)
		return day.substring(0,4) + format + day.substring(4,6) + format + day.substring(6,8);
	else 
		return "";
}

var CmObect = new Object();

/**
 * Email 형식의 스트링 중 도메인 부분만 추출
 */
CmObect.getEmailDomain = function(sEmail){
	if(!fn_is_email(sEmail)){
		console.log("Error : 이메일 형식이 아닙니다.");
		return "";
	}else{
		if(sEmail.indexOf("@") != -1){
			return sEmail.substring(sEmail.indexOf("@") + 1, sEmail.length);
		}else{
			return "";
		}
	}
};

/**
 * Email 형식의 스트링 중 이메일 아이디 부분만 추출
 */
CmObect.getEmailId = function(sEmail){
	if(!fn_is_email(sEmail)){
		console.log("Error : 이메일 형식이 아닙니다.");
		return "";
	}else{
		if(sEmail.indexOf("@") != -1){
			return sEmail.substring(0, sEmail.indexOf("@"));
		}else{
			return "";
		}
	}
};

function checkBizID(bizID)  //사업자등록번호 체크 
{ 
    // bizID는 숫자만 10자리로 해서 문자열로 넘긴다. 
    var checkID = new Array(1, 3, 7, 1, 3, 7, 1, 3, 5, 1); 
    var tmpBizID, i, chkSum=0, c2, remander; 
     bizID = bizID.replace(/-/g,""); 

     for (i=0; i<=7; i++) chkSum += checkID[i] * bizID.charAt(i); 
     c2 = "0" + (checkID[8] * bizID.charAt(8)); 
     c2 = c2.substring(c2.length - 2, c2.length); 
     chkSum += Math.floor(c2.charAt(0)) + Math.floor(c2.charAt(1)); 
     remander = (10 - (chkSum % 10)) % 10 ; 

    if (Math.floor(bizID.charAt(9)) == remander) return true ; // OK! 
      return false; 
}

/**휴대폰번호 하이픈 넣기*/
function addHyphenToPhone(obj) {
    var number = obj.value.replace(/[^0-9]/g, "");
    var phone = "";

    if(number.length < 4) {
        return number;
    } else if(number.length < 7) {
        phone += number.substr(0, 3);
        phone += "-";
        phone += number.substr(3);
    } else if(number.length < 11) {
        phone += number.substr(0, 3);
        phone += "-";
        phone += number.substr(3, 3);
        phone += "-";
        phone += number.substr(6);
    } else {
        phone += number.substr(0, 3);
        phone += "-";
        phone += number.substr(3, 4);
        phone += "-";
        phone += number.substr(7);
    }
    obj.value = phone;
}

/**브라우저 종류 및 IE 버전 체크*/
function browserVersionCheck() {
	var agent = navigator.userAgent.toLowerCase();
	var browser;

	if(agent.indexOf('msie') > -1) {
		browser = 'IE' + agent.match(/msie (\d+)/)[1]
	} else if(agent.indexOf('trident') > -1) {
		browser = 'IE11'
	} else if(agent.indexOf('edge') > -1) {
		browser = 'Edge'
	} else if(agent.indexOf('firefox') > -1) {
		browser = 'FireFox'
	} else if(agent.indexOf('opr') > -1) {
		browser = 'Opera'
	} else if(agent.indexOf('chrome') > -1) {
		browser = 'Chrome'
	} else if(agent.indexOf('safari') > -1) {
		browser = 'Safari'
	}
	return browser;
}

/** 화면 하단에 가까워지면 다음페이지 이동 */
var resizeTime = true;
setInterval(function(){
    resizeTime = true;
}, 1000);

/** 파일 체크 */
function checkFile(el, ext, size){
    var file = el.files;
    var fileName = file[0].name;
    var fileSize = file[0].size;
    // 파일 확장자 체크
    // var ext = ".png,.jpg,.jpeg,.gif,.pdf";
    var extList = ext.split(",");
    var extName = fileName.substring(fileName.lastIndexOf(".")).toLowerCase();

    var tfCheck;
    for(var i=0; i < extList.length; i++) {
        if(extName == $.trim(extList[i])) {
            tfCheck = true;
            break;
        } else {
            tfCheck = false;
        }
    }
    if(!tfCheck) {
        alert("업로드 불가능한 파일입니다.");
    } else {
        // 파일 용량 체크
        if(fileSize > (size * 1024 * 1024)) {
            alert("파일은 " + size + "MB 이하이어야 합니다.");
        } else {
            return;
        }
    }
    el.outerHTML = el.outerHTML;
}

$(document).ready(function() {
    $(window).scroll(function () {
        var scrollHeight = $(document).height();
        var scrollPosition = $(window).height() + $(window).scrollTop();
        if ((scrollHeight - scrollPosition) / scrollHeight <= 0.1) {
            if ($("#moreBtn").css("display") != "none") {
                if (resizeTime) {
                    $("#moreBtnLink").click();
                    resizeTime = false;
                }
            }
        }
    });
});

