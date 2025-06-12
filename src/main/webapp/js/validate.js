
/**
 * @Param validJson : json형식의 검사 조건이 파라미터로 들어온다 . {필수여부,  byte체크 or length(min, max 값)체크}
 * @Param componentId : validation을 체크하기 위한 component의 id 값을 String 형식으로 넘겨준다.
 * @Param componentName
 * ex) validateor({required:true,byte:40},userNm, "이름")
 *     validateor({required:true,min:8, max:13},userNm, "전화번호")
 */

function validator(validJson, componentId, componentName) {
    const val = $("#" + componentId).val();

    //필수여부 체크
    if(validJson.required && val== "" ){
        alert(componentName + "은(는) 필수 입력값입니다.");
        $("#" + componentId).focus();
       return false;
    }

    //글자수 체크 length min-max
    if(typeof validJson.byte == "undefined"){

        let alertMsg = "";
        if (val.length < validJson.min) {alertMsg += validJson.min + "자 이상";}
        if (val.length > validJson.max) {alertMsg += validJson.max + "자 이하";}
        if (alertMsg != ""){
            alert(componentName + "은(는)" + alertMsg + " 입력해 주세요.");
            $("#" + componentId).focus();
            return false;
        }
    //글자수 체크 byte
    }else{
        if (strLengthCheck(val) > validJson.byte){
            alert(componentName + "은(는) "+ Math.floor(validJson.byte/3) +"자 이하로 입력해 주세요.");
            $("#" + componentId).focus();
            return false;
        }
    }

    return true;
}
