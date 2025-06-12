package api.web;

import api.service.APIRecaptchaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Controller
public class APIRecaptchaController {

    @Autowired
    private APIRecaptchaService apiRecaptchaService;
    private static final ConcurrentHashMap<String, Boolean> tamnaoKeys = new ConcurrentHashMap<>();

    /**
     * 설명 : reCAPTCHA v3 인증
     * 파일명 : verifyRecaptcha
     * 작성일 : 25. 2. 12. 오전 10:01
     * 작성자 : chaewan.jung
     * @param : [requestBody, session]
     * @return : java.util.Map<java.lang.String,java.lang.Object>
     * @throws Exception
     */
    @RequestMapping(value = "/api/recaptcha/verify.ajax", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> verifyRecaptcha(@RequestBody Map<String, String> requestBody, HttpServletRequest request) {
        String token = requestBody.get("recaptchaToken");
        double scoreThreshold = Double.parseDouble(requestBody.getOrDefault("scoreThreshold", "0.3"));

        Map<String, Object> response = new HashMap<>();

        double score = apiRecaptchaService.verifyRecaptcha(token);
        boolean isValid = score >= scoreThreshold;

        response.put("success", isValid);
        response.put("score", score);
        response.put("message", isValid ? "인증 성공" : "인증 실패");

        // tamnaoKey 저장
        String tamnaoKey = generateRandomKey();
        request.getSession().setAttribute("tamnaoKey", tamnaoKey);
        response.put("tamnaoKey", tamnaoKey);

        return response;
    }

    /**
     * 설명 : reCAPTCHA 오류 발생 시에도 자체 랜덤 키 요청
     * 파일명 : generateFallbackKey
     * 작성일 : 25. 2. 12. 오전 10:01
     * 작성자 : chaewan.jung
     * @param : []
     * @return : java.util.Map<java.lang.String,java.lang.Object>
     * @throws Exception
     */
    @RequestMapping(value = "/api/recaptcha/fallbackKey.ajax", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> generateFallbackKey(HttpServletRequest request) {
        Map<String, Object> response = new HashMap<>();

        // tamnaoKey 저장
        String tamnaoKey = generateRandomKey();
        request.getSession().setAttribute("tamnaoKey", tamnaoKey);
        response.put("tamnaoKey", tamnaoKey);

        return response;
    }

    /**
    * 설명 : 세션 기반으로 tamnaoKey 검증
    * 파일명 : validateTamnaoKey
    * 작성일 : 25. 2. 12. 오후 3:49
    * 작성자 : chaewan.jung
    * @param : 
    * @return : 
    * @throws Exception
    */
    public static boolean validateTamnaoKey(HttpServletRequest request, String clientKey) {
        HttpSession session = request.getSession();
        String storedKey = (String) session.getAttribute("tamnaoKey");

        // tamnaoKey 비교 검증
        return storedKey != null && storedKey.equals(clientKey);
    }

    private String generateRandomKey() {
        return java.util.UUID.randomUUID().toString();
    }
}