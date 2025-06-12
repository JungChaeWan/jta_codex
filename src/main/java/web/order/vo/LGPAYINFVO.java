package web.order.vo;

public class LGPAYINFVO {

	/** 상점거래번호 */
	private String LGD_OID;
	/** 거래순번 */
	private String paySn;
	/** 응답코드 */
	private String LGD_RESPCODE;
	/** 응답메세지 */
	private String LGD_RESPMSG;
	/** 결제금액 */
	private String LGD_AMOUNT;
	/** 거래번호 */
	private String LGD_TID;
	/** 결제수단코드 */
	private String LGD_PAYTYPE;
	/** 결제일시 */
	private String LGD_PAYDATE;
	/** 결제기관코드 */
	private String LGD_FINANCECODE;
	/** 결제기관명 */
	private String LGD_FINANCENAME;
	/** 에스크로적용여부 */
	private String LGD_ESCROWYN;
	/** 구매자명 */
	private String LGD_BUYER;
	/** 구매자아이디 */
	private String LGD_BUYERID;
	/** 고객휴대폰번호 */
	private String LGD_BUYERPHONE;
	/** 구매자이메일 */
	private String LGD_BUYEREMAIL;
	/** 구매내역 */
	private String LGD_PRODUCTINFO;
	/** 신용카드번호 */
	private String LGD_CARDNUM;
	/** 신용카드할부개월 */
	private String LGD_CARDINSTALLMONTH;
	/** 신용카드무이자여부 */
	private String LGD_CARDNOINTYN;
	/** 결제기관승인번호 */
	private String LGD_FINANCEAUTHNUM;
	/** 현금영수증승인번호 */
	private String LGD_CASHRECEIPTNUM;
	/** 현금영수증자진발급여부 */
	private String LGD_CASHRECEIPTSELFYN;
	/** 현금영수증종류 */
	private String LGD_CASHRECEIPTKIND;
	/** 결제 구분 */
	private String LGD_CUSTOM_USABLEPAY;
	/** 등록일시 */
	private String regDttm;

	/** 무통장 입금 플래그*/
	private String LGD_CASFLAGY;
	/** 무통장 입금 계좌번호*/
	private String LGD_ACCOUNTNUM;
	/** 무통장 입금 입금자명*/
	private String LGD_PAYER;

	/** 간편결제*/
	private String LGD_EASYPAY_TRANTYPE;

	public String getLGD_OID() {
		return LGD_OID;
	}
	public void setLGD_OID(String lGD_OID) {
		LGD_OID = lGD_OID;
	}
	public String getPaySn() {
		return paySn;
	}
	public void setPaySn(String paySn) {
		this.paySn = paySn;
	}
	public String getLGD_RESPCODE() {
		return LGD_RESPCODE;
	}
	public void setLGD_RESPCODE(String lGD_RESPCODE) {
		LGD_RESPCODE = lGD_RESPCODE;
	}
	public String getLGD_RESPMSG() {
		return LGD_RESPMSG;
	}
	public void setLGD_RESPMSG(String lGD_RESPMSG) {
		LGD_RESPMSG = lGD_RESPMSG;
	}
	public String getLGD_AMOUNT() {
		return LGD_AMOUNT;
	}
	public void setLGD_AMOUNT(String lGD_AMOUNT) {
		LGD_AMOUNT = lGD_AMOUNT;
	}
	public String getLGD_TID() {
		return LGD_TID;
	}
	public void setLGD_TID(String lGD_TID) {
		LGD_TID = lGD_TID;
	}
	public String getLGD_PAYTYPE() {
		return LGD_PAYTYPE;
	}
	public void setLGD_PAYTYPE(String lGD_PAYTYPE) {
		LGD_PAYTYPE = lGD_PAYTYPE;
	}
	public String getLGD_PAYDATE() {
		return LGD_PAYDATE;
	}
	public void setLGD_PAYDATE(String lGD_PAYDATE) {
		LGD_PAYDATE = lGD_PAYDATE;
	}
	public String getLGD_FINANCECODE() {
		return LGD_FINANCECODE;
	}
	public void setLGD_FINANCECODE(String lGD_FINANCECODE) {
		LGD_FINANCECODE = lGD_FINANCECODE;
	}
	public String getLGD_FINANCENAME() {
		return LGD_FINANCENAME;
	}
	public void setLGD_FINANCENAME(String lGD_FINANCENAME) {
		LGD_FINANCENAME = lGD_FINANCENAME;
	}
	public String getLGD_ESCROWYN() {
		return LGD_ESCROWYN;
	}
	public void setLGD_ESCROWYN(String lGD_ESCROWYN) {
		LGD_ESCROWYN = lGD_ESCROWYN;
	}
	public String getLGD_BUYER() {
		return LGD_BUYER;
	}
	public void setLGD_BUYER(String lGD_BUYER) {
		LGD_BUYER = lGD_BUYER;
	}
	public String getLGD_BUYERID() {
		return LGD_BUYERID;
	}
	public void setLGD_BUYERID(String lGD_BUYERID) {
		LGD_BUYERID = lGD_BUYERID;
	}
	public String getLGD_BUYERPHONE() {
		return LGD_BUYERPHONE;
	}
	public void setLGD_BUYERPHONE(String lGD_BUYERPHONE) {
		LGD_BUYERPHONE = lGD_BUYERPHONE;
	}
	public String getLGD_BUYEREMAIL() {
		return LGD_BUYEREMAIL;
	}
	public void setLGD_BUYEREMAIL(String lGD_BUYEREMAIL) {
		LGD_BUYEREMAIL = lGD_BUYEREMAIL;
	}
	public String getLGD_PRODUCTINFO() {
		return LGD_PRODUCTINFO;
	}
	public void setLGD_PRODUCTINFO(String lGD_PRODUCTINFO) {
		LGD_PRODUCTINFO = lGD_PRODUCTINFO;
	}
	public String getLGD_CARDNUM() {
		return LGD_CARDNUM;
	}
	public void setLGD_CARDNUM(String lGD_CARDNUM) {
		LGD_CARDNUM = lGD_CARDNUM;
	}
	public String getLGD_CARDINSTALLMONTH() {
		return LGD_CARDINSTALLMONTH;
	}
	public void setLGD_CARDINSTALLMONTH(String lGD_CARDINSTALLMONTH) {
		LGD_CARDINSTALLMONTH = lGD_CARDINSTALLMONTH;
	}
	public String getLGD_CARDNOINTYN() {
		return LGD_CARDNOINTYN;
	}
	public void setLGD_CARDNOINTYN(String lGD_CARDNOINTYN) {
		LGD_CARDNOINTYN = lGD_CARDNOINTYN;
	}
	public String getLGD_FINANCEAUTHNUM() {
		return LGD_FINANCEAUTHNUM;
	}
	public void setLGD_FINANCEAUTHNUM(String lGD_FINANCEAUTHNUM) {
		LGD_FINANCEAUTHNUM = lGD_FINANCEAUTHNUM;
	}
	public String getLGD_CASHRECEIPTNUM() {
		return LGD_CASHRECEIPTNUM;
	}
	public void setLGD_CASHRECEIPTNUM(String lGD_CASHRECEIPTNUM) {
		LGD_CASHRECEIPTNUM = lGD_CASHRECEIPTNUM;
	}
	public String getLGD_CASHRECEIPTSELFYN() {
		return LGD_CASHRECEIPTSELFYN;
	}
	public void setLGD_CASHRECEIPTSELFYN(String lGD_CASHRECEIPTSELFYN) {
		LGD_CASHRECEIPTSELFYN = lGD_CASHRECEIPTSELFYN;
	}
	public String getLGD_CASHRECEIPTKIND() {
		return LGD_CASHRECEIPTKIND;
	}
	public void setLGD_CASHRECEIPTKIND(String lGD_CASHRECEIPTKIND) {
		LGD_CASHRECEIPTKIND = lGD_CASHRECEIPTKIND;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	public String getLGD_CUSTOM_USABLEPAY() {
		return LGD_CUSTOM_USABLEPAY;
	}
	public void setLGD_CUSTOM_USABLEPAY(String lGD_CUSTOM_USABLEPAY) {
		LGD_CUSTOM_USABLEPAY = lGD_CUSTOM_USABLEPAY;
	}
	public String getLGD_CASFLAGY() {
		return LGD_CASFLAGY;
	}
	public void setLGD_CASFLAGY(String LGD_CASFLAGY) {
		this.LGD_CASFLAGY = LGD_CASFLAGY;
	}

	public String getLGD_ACCOUNTNUM() {
		return LGD_ACCOUNTNUM;
	}

	public void setLGD_ACCOUNTNUM(String LGD_ACCOUNTNUM) {
		this.LGD_ACCOUNTNUM = LGD_ACCOUNTNUM;
	}

	public String getLGD_PAYER() {
		return LGD_PAYER;
	}

	public void setLGD_PAYER(String LGD_PAYER) {
		this.LGD_PAYER = LGD_PAYER;
	}

	public String getLGD_EASYPAY_TRANTYPE() {
		return LGD_EASYPAY_TRANTYPE;
	}

	public void setLGD_EASYPAY_TRANTYPE(String LGD_EASYPAY_TRANTYPE) {
		this.LGD_EASYPAY_TRANTYPE = LGD_EASYPAY_TRANTYPE;
	}
}
