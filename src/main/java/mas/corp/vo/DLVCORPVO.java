package mas.corp.vo;

import java.util.List;

public class DLVCORPVO {

	/** 배송업체 코드 */
	private String dlvCorpCd;
	/** 배송업체 명 */
	private String dlvCorpNm;
	/** 실시간 여부 */
	private String rtmYn;
	/** 실시간 URL */
	private String rtmUrl;
	/** WEB URL */
	private String webUrl;
	/** MOBILE URL */
	private String mobileUrl;
	/** 배송사 체크여부 */
	private String checkYn;
	/** 배송사코드 배열*/
	private List<String> dlvCorpCds;
	/** 업체ID*/
	private String corpId;
	/** 에스크로 배송사 코드*/
	private String escrowDlvCd;
	/** 굿스플로우 배송사 코드*/
	private String goodsflowDlvCd;

	public String getDlvCorpCd() {
		return dlvCorpCd;
	}

	public void setDlvCorpCd(String dlvCorpCd) {
		this.dlvCorpCd = dlvCorpCd;
	}

	public String getDlvCorpNm() {
		return dlvCorpNm;
	}

	public void setDlvCorpNm(String dlvCorpNm) {
		this.dlvCorpNm = dlvCorpNm;
	}

	public String getRtmYn() {
		return rtmYn;
	}

	public void setRtmYn(String rtmYn) {
		this.rtmYn = rtmYn;
	}

	public String getRtmUrl() {
		return rtmUrl;
	}

	public void setRtmUrl(String rtmUrl) {
		this.rtmUrl = rtmUrl;
	}

	public String getWebUrl() {
		return webUrl;
	}

	public void setWebUrl(String webUrl) {
		this.webUrl = webUrl;
	}

	public String getMobileUrl() {
		return mobileUrl;
	}

	public void setMobileUrl(String mobileUrl) {
		this.mobileUrl = mobileUrl;
	}

	public String getCheckYn() {
		return checkYn;
	}

	public void setCheckYn(String checkYn) {
		this.checkYn = checkYn;
	}

	public List<String> getDlvCorpCds() {
		return dlvCorpCds;
	}

	public void setDlvCorpCds(List<String> dlvCorpCds) {
		this.dlvCorpCds = dlvCorpCds;
	}

	public String getCorpId()	{
		return corpId;
	}

	public void setCorpId(String corpId) {
		this.corpId = corpId;
	}

	public String getEscrowDlvCd() {
		return escrowDlvCd;
	}

	public void setEscrowDlvCd(String escrowDlvCd) {
		this.escrowDlvCd = escrowDlvCd;
	}

	public String getGoodsflowDlvCd() {
		return goodsflowDlvCd;
	}

	public void setGoodsflowDlvCd(String goodsflowDlvCd) {
		this.goodsflowDlvCd = goodsflowDlvCd;
	}
}
