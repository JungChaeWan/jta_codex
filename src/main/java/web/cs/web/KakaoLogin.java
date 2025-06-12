package web.cs.web;

import common.Constant;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.map.ObjectMapper;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class KakaoLogin {

    static Logger log = LogManager.getLogger(KakaoLogin.class);

    public static JsonNode getAccessToken(String autorizeCode, String redirectUri) {
        final String requestUrl = "https://kauth.kakao.com/oauth/token";

        final List<NameValuePair> postParams = new ArrayList<NameValuePair>();

        postParams.add(new BasicNameValuePair("grant_type", "authorization_code"));
        postParams.add(new BasicNameValuePair("client_id", Constant.KAKAO_REST_API_KEY)); // REST API KEY
        postParams.add(new BasicNameValuePair("redirect_uri", redirectUri)); // 리다이렉트 URI
        postParams.add(new BasicNameValuePair("code", autorizeCode)); // 로그인 과정중 얻은 code 값

        final HttpClient client = HttpClientBuilder.create().build();
        final HttpPost post = new HttpPost(requestUrl);

        JsonNode returnNode = null;

        try {
            post.setEntity(new UrlEncodedFormEntity(postParams));

            final HttpResponse response = client.execute(post);
            final int responseCode = response.getStatusLine().getStatusCode();

            log.info("Sending 'POST' request to URL", requestUrl);
            log.info("Post parameters", postParams);
            log.info("Response Code", responseCode);

            // JSON 형태 반환값 처리
            ObjectMapper mapper = new ObjectMapper();

            returnNode = mapper.readTree(response.getEntity().getContent());

        } catch (UnsupportedEncodingException e) {
            log.error("getAccessToken UnsupportedEncodingException", e);
        } catch (ClientProtocolException e) {
            log.error("getAccessToken UnsupportedEncodingException", e);
        } catch (IOException e) {
            log.error("getAccessToken UnsupportedEncodingException", e);
        } finally {
            // clear resources
        }
        return returnNode;
    }

    public static JsonNode getKakaoUserInfo(String accessToken) {
        final String requestUrl = "https://kapi.kakao.com/v2/user/me";

        final HttpClient client = HttpClientBuilder.create().build();
        final HttpPost post = new HttpPost(requestUrl);

        // add header
        post.addHeader("Authorization", "Bearer " + accessToken);

        JsonNode returnNode = null;

        try {
            final HttpResponse response = client.execute(post);
            final int responseCode = response.getStatusLine().getStatusCode();

            log.info("Sending 'POST' request to URL", requestUrl);
            log.info("Response Code", responseCode);

            // JSON 형태 반환값 처리
            ObjectMapper mapper = new ObjectMapper();

            returnNode = mapper.readTree(response.getEntity().getContent());

        } catch (ClientProtocolException e) {
            log.error("getKakaoUserInfo UnsupportedEncodingException", e);
        } catch (IOException e) {
            log.error("getKakaoUserInfo UnsupportedEncodingException", e);
        } finally {
            // clear resources
        }
        return returnNode;
    }

    public static Map changeData(JsonNode userInfo) {
        Map<String, Object> map = new HashMap<String, Object>();

        map.put("loginKey", userInfo.path("id").asText());

        JsonNode properties = userInfo.path("properties"); // 추가정보 받아오기
        if(properties.has("nickname")) {
            map.put("userNm", properties.path("nickname").asText());
        }
        JsonNode kakao_account = userInfo.path("kakao_account"); // 추가정보 받아오기
        if(kakao_account.has("email")) {
            map.put("email", kakao_account.path("email").asText());
        }
        return map;
    }

    public static JsonNode getKakaoUnlink(String targetId) {
        final String requestUrl = "https://kapi.kakao.com/v1/user/unlink";

        final List<NameValuePair> postParams = new ArrayList<NameValuePair>();

        postParams.add(new BasicNameValuePair("target_id_type", "user_id"));
        postParams.add(new BasicNameValuePair("target_id", targetId)); // 사용자 ID

        final HttpClient client = HttpClientBuilder.create().build();
        final HttpPost post = new HttpPost(requestUrl);

        // add header
        post.addHeader("Authorization", "KakaoAK " + Constant.KAKAO_ADMIN_KEY);

        JsonNode returnNode = null;

        try {
            post.setEntity(new UrlEncodedFormEntity(postParams));

            final HttpResponse response = client.execute(post);
            final int responseCode = response.getStatusLine().getStatusCode();

            log.info("Sending 'POST' request to URL", requestUrl);
            log.info("Post parameters", postParams);
            log.info("Response Code", responseCode);

            // JSON 형태 반환값 처리
            ObjectMapper mapper = new ObjectMapper();

            returnNode = mapper.readTree(response.getEntity().getContent());

        } catch (UnsupportedEncodingException e) {
            log.error("getKakaoUnlink UnsupportedEncodingException", e);
        } catch (ClientProtocolException e) {
            log.error("getKakaoUnlink ClientProtocolException", e);
        } catch (IOException e) {
            log.error("getKakaoUnlink IOException", e);
        } finally {
            // clear resources
        }
        return returnNode;
    }
}
