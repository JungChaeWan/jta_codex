package api.service.impl;

import api.service.APIAligoService;
import api.vo.APIAligoButtonVO;
import api.vo.APIAligoVO;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.vdurmont.emoji.EmojiParser;
import egovframework.cmmn.service.EgovProperties;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.apache.commons.lang.StringEscapeUtils;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.stereotype.Service;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("apiAligoService")
public class APIAligoServiceImpl extends EgovAbstractServiceImpl implements APIAligoService {
    String CST_PLATFORM = EgovProperties.getOptionalProp("CST_PLATFORM");
    private static final String SENDER_KEY = "b22bd4677d72ebbf1b6fa388cf9cbf4fa56a458c";    //발신프로파일 키
    private static final String SENDER = "1522-3454";                                       //발신자 연락처
    private final String TEST_MODE = "test".equals(CST_PLATFORM.trim()) ? "N" : "N";        //테스트모드 적용여부 (Y = 돈 안나가고 알림톡도 안나감)

    public void aligoKakaoSend(APIAligoVO aligoVO) {
        String API_KEY = "";                //인증용 API Key
        String USER_ID = "";                //사용자id
        //마케팅과 발송 정보
        if ("marketing".equals(aligoVO.getSendDept())) {
            API_KEY = "rr2y976io4pees7tvsl9ukvflg0b82o0";
            USER_ID = "jta8867";
        } else {
            API_KEY = "qjrwilixt7cydpmeq0migueleueqyf0l";
            USER_ID = "jta8866";
        }

        Map<String, String> formData = new HashMap<>();
        formData.put("apikey", API_KEY);
        formData.put("userid", USER_ID);
        formData.put("senderkey", SENDER_KEY);
        formData.put("tpl_code", aligoVO.getTplCode()); //템플릿 코드
        formData.put("sender", SENDER);

        for(int i = 0; i < aligoVO.getReceivers().length ; i++){
            formData.put("receiver_" + (i+1), aligoVO.getReceivers()[i]); //수신자 연락처(배열)
            formData.put("recvname_" + (i+1), aligoVO.getRecvNames()[i]); //수신자 이름(배열)
            formData.put("subject_" + (i+1), EmojiParser.removeAllEmojis(aligoVO.getSubject().replace("&","＆"))); //알림톡 제목
            formData.put("message_" + (i+1), EmojiParser.removeAllEmojis(aligoVO.getMsg().replace("&","＆"))); //알림톡 내용
            formData.put("fsubject_" + (i+1), aligoVO.getSubject()); //실패시 대체문자 제목

            // 실패시 대체문자 내용
            String failoverMessage = (aligoVO.getMsgSMS() != null && aligoVO.getMsgSMS().length() > 0) ? EmojiParser.removeAllEmojis(aligoVO.getMsgSMS().replace("&","＆")) : aligoVO.getMsg();
            formData.put("fmessage_" + (i + 1), failoverMessage);

            // 버튼 설정
            APIAligoButtonVO[] buttons = aligoVO.getButtons();
            if (buttons != null && buttons.length > 0) {
                StringBuilder buttonArrayJson = new StringBuilder("{\"button\": [");
                for (int j = 0; j < buttons.length; j++) {
                    APIAligoButtonVO button = buttons[j];
                    String buttonJson = null;
                    try {
                        buttonJson = String.format(
                            "{\"name\": \"%s\", \"linkType\": \"%s\", \"linkTypeName\": \"%s\", \"linkMo\": \"%s\", \"linkPc\": \"%s\"}",
                            button.getName(), button.getLinkType(), button.getLinkTypeName(), URLEncoder.encode(button.getLinkMo(),"UTF-8"), URLEncoder.encode(button.getLinkPc(),"UTF-8")
                        );
                    } catch (UnsupportedEncodingException e) {
                        e.printStackTrace();
                    }
                    buttonArrayJson.append(buttonJson);
                    if (j < buttons.length - 1) {
                        buttonArrayJson.append(", ");
                    }
                }
                buttonArrayJson.append("]}");
                formData.put("button_" + (i + 1), buttonArrayJson.toString());
            }
        }

        formData.put("failover", aligoVO.getFailover()); //실패시 대체문자 전송기능
        formData.put("testMode", TEST_MODE); // 테스트 모드 적용 여부

        boolean result = sendPostRequest("https://kakaoapi.aligo.in/akv10/alimtalk/send/", formData);

    }

    public void aligoMmsSend(APIAligoVO aligoVO) {
        String API_KEY = "";                //인증용 API Key
        String USER_ID = "";                //사용자id
        //마케팅과 발송 정보
        if ("marketing".equals(aligoVO.getSendDept())) {
            API_KEY = "rr2y976io4pees7tvsl9ukvflg0b82o0";
            USER_ID = "jta8867";
        } else {
            API_KEY = "qjrwilixt7cydpmeq0migueleueqyf0l";
            USER_ID = "jta8866";
        }
        Map<String, String> formData = new HashMap<>();
        formData.put("key", API_KEY);
        formData.put("user_id", USER_ID);
        formData.put("sender", SENDER); // 발신자 연락처
        formData.put("receiver", "수신자전화번호"); //수신자 전화번호 - 컴마(,)분기 입력으로 최대 1천명
        formData.put("msg", aligoVO.getMsg()); // 메시지 내용
        formData.put("msg_type", "SMS"); // SMS(단문) , LMS(장문), MMS(그림문자) 구분
        formData.put("testmode_yn", TEST_MODE); // 테스트 모드 적용 여부
        boolean result = sendPostRequest("https://apis.aligo.in/send/", formData);
    }

    public void authCodeSend(String receiver, String nansu){
        APIAligoVO aligoVO = new APIAligoVO();
        aligoVO.setTplCode("TT_6645");
        aligoVO.setReceivers(new String[]{receiver});
        aligoVO.setRecvNames(new String[]{""});
        aligoVO.setSubject("인증번호 발송");
        aligoVO.setMsg("[탐나오]\n" +
            "[인증번호:"+nansu+"] 입력시 정상처리 됩니다.");
        aligoVO.setFailover("Y"); //대체문자발송여부

        aligoKakaoSend(aligoVO);
    }

    private boolean sendPostRequest(String url, Map<String, String> formData) {

        boolean result = false;
        try (CloseableHttpClient client = HttpClients.createDefault()) {
            HttpPost httpPost = new HttpPost(url);
            httpPost.setHeader("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");

            String formDataEncoded = mapToFormUrlEncoded(formData);
            StringEntity entity = new StringEntity(formDataEncoded, ContentType.create("application/x-www-form-urlencoded", StandardCharsets.UTF_8));
            httpPost.setEntity(entity);

            try (CloseableHttpResponse response = client.execute(httpPost)) {
                String responseBody = EntityUtils.toString(response.getEntity());
                String responseBodyDecoded = decodeUnicode(responseBody);

                System.out.println("상태 코드: " + response.getStatusLine().getStatusCode());
                System.out.println("응답 본문: " + responseBodyDecoded);

                // JSON 응답 파싱
                ObjectMapper mapper = new ObjectMapper();
                JsonNode jsonResponse = mapper.readTree(responseBodyDecoded);
                int code = jsonResponse.get("code").asInt();

                if (response.getStatusLine().getStatusCode() == 200 && code == 0) {
                    result = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    private static String decodeUnicode(String unicodeString) {
        return StringEscapeUtils.unescapeJava(unicodeString);
    }

    private static String mapToFormUrlEncoded(Map<String, String> map) {
        StringBuilder form = new StringBuilder();
        for (Map.Entry<String, String> entry : map.entrySet()) {
            if (form.length() > 0) {
                form.append("&");
            }
            form.append(entry.getKey()).append("=").append(entry.getValue().replace(" ", "%20"));
        }
        return form.toString();
    }
}
