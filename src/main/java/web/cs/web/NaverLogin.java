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


public class NaverLogin {

    static Logger log = LogManager.getLogger(NaverLogin.class);

    public static JsonNode getAccessToken(String state, String code) {
        final String requestUrl = "https://nid.naver.com/oauth2.0/token";

        final List<NameValuePair> postParams = new ArrayList<NameValuePair>();

        postParams.add(new BasicNameValuePair("client_id", Constant.NAVER_CLIENT_ID));
        postParams.add(new BasicNameValuePair("client_secret", Constant.NAVER_CLIENT_SECRET));
        postParams.add(new BasicNameValuePair("grant_type", "authorization_code"));
        postParams.add(new BasicNameValuePair("state", state));
        postParams.add(new BasicNameValuePair("code", code));

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
            log.error("getAccessToken ClientProtocolException", e);
        } catch (IOException e) {
            log.error("getAccessToken IOException", e);
        } finally {
            // clear resources
        }
        return returnNode;
    }

    public static JsonNode getNaverUserInfo(String accessToken) {
        final String requestUrl = "https://openapi.naver.com/v1/nid/me";

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
            log.error("getNaverUserInfo ClientProtocolException", e);
        } catch (IOException e) {
            log.error("getNaverUserInfo IOException", e);
        } finally {
            // clear resources
        }
        return returnNode;
    }

    public static Map changeData(JsonNode userInfo) {
        Map<String, Object> map = new HashMap<String, Object>();

        JsonNode response = userInfo.path("response");

        map.put("loginKey", response.path("id").asText());
        if(response.has("name")) {
            map.put("userNm", response.path("name").asText());
        }
        if(response.has("email")) {
            map.put("email", response.path("email").asText());
        }
        return map;
    }

    public static JsonNode getRefreshToken(String refreshToken) {
        final String requestUrl = "https://nid.naver.com/oauth2.0/token";

        final List<NameValuePair> postParams = new ArrayList<NameValuePair>();

        postParams.add(new BasicNameValuePair("grant_type", "refresh_token"));
        postParams.add(new BasicNameValuePair("client_id", Constant.NAVER_CLIENT_ID));
        postParams.add(new BasicNameValuePair("client_secret", Constant.NAVER_CLIENT_SECRET));
        postParams.add(new BasicNameValuePair("refresh_token", refreshToken));

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
            log.error("getRefreshToken UnsupportedEncodingException", e);
        } catch (ClientProtocolException e) {
            log.error("getRefreshToken ClientProtocolException", e);
        } catch (IOException e) {
            log.error("getRefreshToken IOException", e);
        } finally {
            // clear resources
        }
        return returnNode;
    }

    public static JsonNode getNaverUnlink(String accessToken) {
        final String requestUrl = "https://nid.naver.com/oauth2.0/token";

        final List<NameValuePair> postParams = new ArrayList<NameValuePair>();

        postParams.add(new BasicNameValuePair("grant_type", "delete"));
        postParams.add(new BasicNameValuePair("client_id", Constant.NAVER_CLIENT_ID));
        postParams.add(new BasicNameValuePair("client_secret", Constant.NAVER_CLIENT_SECRET));
        postParams.add(new BasicNameValuePair("access_token", accessToken));
        postParams.add(new BasicNameValuePair("service_provider", "NAVER"));

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
            log.error("getNaverUnlink UnsupportedEncodingException", e);
        } catch (ClientProtocolException e) {
            log.error("getNaverUnlink ClientProtocolException", e);
        } catch (IOException e) {
            log.error("getNaverUnlink IOException", e);
        } finally {
            // clear resources
        }
        return returnNode;
    }

}
