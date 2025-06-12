package web.etc.vo;

public class SCCVO extends SCCSVO{

	/** 게시물 번호 */
	private String noticeNum;
	/** 제목 */
	private String subject;
	/** 간략 설명 */
	private String simpleExp;
	/** 내용 */
	private String contents;
	/** 조회 건수 */
	private String inqCnt;
	/** 노출 여부 */
	private String viewYn;
	/** 유투브 아이디 */
	private String youtubeId;
	/** 최종 수정 일시 */
	private String lastModDttm;
	/** 최초 등록 일시 */
	private String frstRegDttm;
	/** 최종 수정 아이디 */
	private String lastModId;
	/** 최초 등록 아이디 */
	private String frstRegId;
	
	public String getNoticeNum() {
		return noticeNum;
	}
	public void setNoticeNum(String noticeNum) {
		this.noticeNum = noticeNum;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getSimpleExp() {
		return simpleExp;
	}
	public void setSimpleExp(String simpleExp) {
		this.simpleExp = simpleExp;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getInqCnt() {
		return inqCnt;
	}
	public void setInqCnt(String inqCnt) {
		this.inqCnt = inqCnt;
	}
	public String getViewYn() {
		return viewYn;
	}
	public void setViewYn(String viewYn) {
		this.viewYn = viewYn;
	}
	public String getYoutubeId() {
		return youtubeId;
	}
	public void setYoutubeId(String youtubeId) {
		this.youtubeId = youtubeId;
	}
	public String getLastModDttm() {
		return lastModDttm;
	}
	public void setLastModDttm(String lastModDttm) {
		this.lastModDttm = lastModDttm;
	}
	public String getFrstRegDttm() {
		return frstRegDttm;
	}
	public void setFrstRegDttm(String frstRegDttm) {
		this.frstRegDttm = frstRegDttm;
	}
	public String getLastModId() {
		return lastModId;
	}
	public void setLastModId(String lastModId) {
		this.lastModId = lastModId;
	}
	public String getFrstRegId() {
		return frstRegId;
	}
	public void setFrstRegId(String frstRegId) {
		this.frstRegId = frstRegId;
	}

}
