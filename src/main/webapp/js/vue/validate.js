const CommonPlugin = {}
let validation_errors =[]
CommonPlugin.install = function (Vue) {
    /*
    User: 정채완
    Date: 2021-02-10

    Vue.validEmail("검증할 이메일")
    */
    Vue.validEmail = function(email) {
        if (validation_errors.length) {
            return 0
        }

        const re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        if(!re.test(email)){
            validation_errors.push("e");
            alert("이메일 형식을 확인 해 주세요.")
        }
    },

    /*
    User: 정채완
    Date: 2021-02-10

    마지막 max 글자수에 파라미터값을 전달하지 않으면 글자 수 제한 없음.
    Vue.validate("v-model명", "max 글자수")
    ex) Vue.validate(this.name, "이름을", 3) => 이름을 입력 하세요. / 이름을 3글자 보다 작게 작성 해 주세요.
    */
    Vue.validate = function(key, id, message, maxLength) {
        if(maxLength == undefined ) maxLength = 9999

        if (validation_errors.length) {
            return 0
        }

        if (!key) {
            validation_errors.push("e");
            alert(message+" 입력 하세요.")
            $("#"+id).focus()
        }else{
            if (key.length > maxLength) {
                validation_errors.push("e");
                alert(message+" "+maxLength+"글자 보다 작게 작성 해 주세요.")
                $("#"+id).focus()
            }
        }
    }

    /*
    User: 정채완
    Date: 2021-02-10

    전화번호 '-' 처리
    Vue.getPhoneMask('id명', v-model명)
    ex) @keyup="Vue.getPhoneMask('telNum',telNum)"
    */
    Vue.getPhoneMask = function(id, val) {

        let res = this.getMask(val)
        $("#"+id).val(res)
        //서버 전송 값에는 '-' 를 제외하고 숫자만 저장
        //$("#"+id).val($("#"+id).replace(/[^0-9]/g, ''))
    }

    Vue.getMask = function ( phoneNumber ) {

        if(!phoneNumber) return phoneNumber
        phoneNumber = phoneNumber.replace(/[^0-9]/g, '')

        let res = ''
        if(phoneNumber.length < 3) {
            res = phoneNumber
        }
        else {
            if(phoneNumber.substr(0, 2) =='02') {

                if(phoneNumber.length <= 5) {//02-123-5678
                    res = phoneNumber.substr(0, 2) + '-' + phoneNumber.substr(2, 3)
                }
                else if(phoneNumber.length > 5 && phoneNumber.length <= 9) {//02-123-5678
                    res = phoneNumber.substr(0, 2) + '-' + phoneNumber.substr(2, 3) + '-' + phoneNumber.substr(5)
                }
                else if(phoneNumber.length > 9) {//02-1234-5678
                    res = phoneNumber.substr(0, 2) + '-' + phoneNumber.substr(2, 4) + '-' + phoneNumber.substr(6)
                }

            } else {
                if(phoneNumber.length < 8) {
                    res = phoneNumber
                }
                else if(phoneNumber.length == 8)
                {
                    res = phoneNumber.substr(0, 4) + '-' + phoneNumber.substr(4)
                }
                else if(phoneNumber.length == 9)
                {
                    res = phoneNumber.substr(0, 3) + '-' + phoneNumber.substr(3, 3) + '-' + phoneNumber.substr(6)
                }
                else if(phoneNumber.length == 10)
                {
                    res = phoneNumber.substr(0, 3) + '-' + phoneNumber.substr(3, 3) + '-' + phoneNumber.substr(6)
                }
                else if(phoneNumber.length > 10) { //010-1234-5678
                    res = phoneNumber.substr(0, 3) + '-' + phoneNumber.substr(3, 4) + '-' + phoneNumber.substr(7)
                }
            }
        }
        return res
    }
}