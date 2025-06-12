package oss.user.vo;

public class REFUNDACCINFVO {

	/** 사용자 아이디 */
	private String userId;
	/** 은행 명 */
	private String bankNm;
	/** 계좌 번호 */
	private String accNum;
	/** 예금주 명 */
	private String depositorNm;
	/** 등록 일시 */
	private String regDttm;
	/** 은행 코드*/
	private String bankCode;

	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getBankNm() {
		return bankNm;
	}
	public void setBankNm(String bankNm) {
		this.bankNm = bankNm;
	}
	public String getAccNum() {
		return accNum;
	}
	public void setAccNum(String accNum) {
		this.accNum = accNum;
	}
	public String getDepositorNm() {
		return depositorNm;
	}
	public void setDepositorNm(String depositorNm) {
		this.depositorNm = depositorNm;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}

	public String getBankCode() {
		return bankCode;
	}

	public void setBankCode(String bankCode) {
		this.bankCode = bankCode;
	}
}
