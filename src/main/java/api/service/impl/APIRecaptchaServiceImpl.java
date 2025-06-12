package api.service.impl;

import api.service.APIRecaptchaService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.*;
import java.util.*;

@Service("apiRecaptchaService")
public class APIRecaptchaServiceImpl extends EgovAbstractServiceImpl implements APIRecaptchaService {

    private final String RECAPTCHA_SECRET_KEY = "6LdLftQqAAAAAG4hHMXcLOudPBEioFonTZvP2X3-";
    private final String RECAPTCHA_VERIFY_URL = "https://www.google.com/recaptcha/api/siteverify";

    public double verifyRecaptcha(String token){
        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
        body.add("secret", RECAPTCHA_SECRET_KEY);
        body.add("response", token);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(body, headers);

        try {
            ResponseEntity<Map> response = restTemplate.postForEntity(RECAPTCHA_VERIFY_URL, request, Map.class);
            Map<String, Object> responseBody = response.getBody();
            if (responseBody == null) {
                System.out.println("❌ Google API 응답 없음, 기본적으로 0.6 부여");
                return 0.6;
            }

            double score = responseBody.containsKey("score") ? (Double) responseBody.get("score") : 0.6;
            return score;

        } catch (Exception e) {
            System.err.println("❌ Google reCAPTCHA API 호출 오류: " + e.getMessage());
            return 0.6;
        }
    }

}
