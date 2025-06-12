package common;

public enum APITLMsg {
    AD_NONE("AD_NONE", "호텔 아이디 또는 비밀번호가 잘 못 되었습니다."),
    ROOM_NONE("ROOM_NONE", "객실 정보가 없습니다."),
    DATE_ERR("DATE_ERR", "날짜 형식이 올바르지 않습니다."),
    PLAN_NONE("PLAN_NONE", "플랜코드가 존재하지 않습니다."),
    STOCK_ERR("STOCK_ERR","객실 수를 0이상 입력 해 주세요."),
    PRICE_ERR("PRICE_ERR", "요금을 0이상 입력 해 주세요.");

    private String code;
    private String msg;

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    private APITLMsg( String code, String msg){
        this.code = code;
        this.msg = msg;
    }

}
