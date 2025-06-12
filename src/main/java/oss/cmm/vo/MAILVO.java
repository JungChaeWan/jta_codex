package oss.cmm.vo;

public class MAILVO {
	private String title;
	private String content;
	private String sender;
	private String senderAlias;
	private String email;
	private String receiverAlias;
	private String contentType = "text/html";
	private String eventId;
	private String userInfo;
	private String emailInsertType = "new";
	private String wasSended = "X";
	private String emailDataType = "string";
	private String userId;

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	public String getSenderAlias() {
		return senderAlias;
	}

	public void setSenderAlias(String senderAlias) {
		this.senderAlias = senderAlias;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getReceiverAlias() {
		return receiverAlias;
	}

	public void setReceiverAlias(String receiverAlias) {
		this.receiverAlias = receiverAlias;
	}

	public String getContentType() {
		return contentType;
	}

	public void setContentType(String contentType) {
		this.contentType = contentType;
	}

	public String getEventId() {
		return eventId;
	}

	public void setEventId(String eventId) {
		this.eventId = eventId;
	}

	public String getUserInfo() {
		return userInfo;
	}

	public void setUserInfo(String userInfo) {
		this.userInfo = userInfo;
	}

	public String getEmailInsertType() {
		return emailInsertType;
	}

	public void setEmailInsertType(String emailInsertType) {
		this.emailInsertType = emailInsertType;
	}

	public String getWasSended() {
		return wasSended;
	}

	public void setWasSended(String wasSended) {
		this.wasSended = wasSended;
	}

	public String getEmailDataType() {
		return emailDataType;
	}

	public void setEmailDataType(String emailDataType) {
		this.emailDataType = emailDataType;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
}