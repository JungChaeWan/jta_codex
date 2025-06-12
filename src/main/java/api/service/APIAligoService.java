package api.service;

import api.vo.APIAligoVO;

public interface APIAligoService {
    /**
    * 설명 : 알리고 카카오톡 전송 -> (구분값이 Y이면) 실패시 대체 문자 발송
    * 파일명 :
    * 작성일 : 2024-07-02 오전 10:12
    * 작성자 : chaewan.jung
    * @param :
    * @return :
    * @throws Exception
    */
    void aligoKakaoSend(APIAligoVO aligoVO);

    /**
    * 설명 : 알리고 문자 발송 ( 현재 사용하지 않음 )
    * 파일명 :
    * 작성일 : 2024-07-02 오전 10:12
    * 작성자 : chaewan.jung
    * @param :
    * @return :
    * @throws Exception
    */
    void aligoMmsSend(APIAligoVO aligoVO);

    /**
    * 설명 : 인증번호 전송
    * 파일명 :
    * 작성일 : 2024-07-02 오후 4:08
    * 작성자 : chaewan.jung
    * @param :
    * @return :
    * @throws Exception
    */
    void authCodeSend(String receiver, String nansu);
}
