package web.mypage.vo;

public class USER_SURVEYVO {

	/** 설문ID */
	private String id;
	/** 설문명 */
	private String title;
	/** 설문설명 */
	private String description ;
	/** 설문토큰 */
	private String token ;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}
}
