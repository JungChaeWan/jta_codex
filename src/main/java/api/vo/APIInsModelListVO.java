package api.vo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
@JsonIgnoreProperties(ignoreUnknown = true)
public class APIInsModelListVO {

	private String L모델번호;
	private String L모델명;
	private String L모델코드;
	private String L분류;
	private String L렌트회사코드;
	private String R렌트회사;

	public String getL모델번호() {
		return L모델번호;
	}

	public void setL모델번호(String l모델번호) {
		L모델번호 = l모델번호;
	}

	public String getL모델명() {
		return L모델명;
	}

	public void setL모델명(String l모델명) {
		L모델명 = l모델명;
	}

	public String getL모델코드() {
		return L모델코드;
	}

	public void setL모델코드(String l모델코드) {
		L모델코드 = l모델코드;
	}

	public String getL분류() {
		return L분류;
	}

	public void setL분류(String l분류) {
		L분류 = l분류;
	}

	public String getL렌트회사코드() {
		return L렌트회사코드;
	}

	public void setL렌트회사코드(String l렌트회사코드) {
		L렌트회사코드 = l렌트회사코드;
	}

	public String getR렌트회사() {
		return R렌트회사;
	}

	public void setR렌트회사(String r렌트회사) {
		R렌트회사 = r렌트회사;
	}
}
