package oss.corp.vo;

public class CORP_PNSREQVO extends CORP_PNSREQSVO{
	/** 요청번호 */
	private String requestNum;	
	/** 업체코드 */
	private String corpCd;
	/** 업체 수정 코드 */
	private String corpModCd;
	/** 업체 코드 명 */
	private String corpCdNm;
	/** 등록 일시 */
	private String frstRegDttm;
	/** 수정 일시 */
	private String lastModDttm;
	/** 사업자 등록번호 */
	private String coRegNum;
	/** 업체 이메일 */
	private String corpEmail;
	/** 상태 코드 */
	private String statusCd;
	/** 홉페이지 주소 */
	private String hmpgAddr;
	/** 대표자 전화번호*/
	private String ceoTelNum;
	/** 예약 전화번호*/
	private String rsvTelNum;
	/** 업체 명*/
	private String corpNm;
	/** 대표자 명*/
	private String ceoNm;
	/** 주소*/
	private String addr;
	/** 상세주소*/
	private String dtlAddr;
	/** 상호 명 */
	private String shopNm;
	/** 회사 유형 */
	private String corpType;
	/** 팩스 번호 */
	private String faxNum;
	/** 분과 명*/
	private String branchNm;
	/** 대표자 생년월일 */
	private String ceoBth;
	/** 업태 */
	private String bsncon;
	/** 업종 */
	private String bsntyp;
	/** 은행 명 */
	private String bankNm;
	/** 계좌 번호  */
	private String accNum;
	/** 예금 주 */
	private String depositor;
	/** 등록 IP */
	private String frstRegIp;
	/** 수정 IP  */
	private String lastModIp;
	/** 관리자 메모 */
	private String admMemo;
	/** 판매 상품 목록 */
	private String salePrdtList;
	/** 관리자 명 */
	private String admNm;
	/** 관리자 부서 */
	private String admDep;
	/** 관리자 직위 */
	private String admOfcpos;
	/** 관리자 모바일 */
	private String admMobile;
	/** 관리자 전화번호 */
	private String admTelnum;
	/** 관리자 이메일 */
	private String admEmail;
	/** 최초 등록 아이디 */
	private String frstRegId;
	/** 최종 수정 아이디 */
	private String lastModId;
	/**  승인 업체 아이디 */
	private String confCorpId;
	/** 탐나는전 예약가능 여부 **/
	private String tamnacardMngYn;

	public String getRequestNum() {
		return requestNum;
	}
	public void setRequestNum(String requestNum) {
		this.requestNum = requestNum;
	}
	public String getCorpCd() {
		return corpCd;
	}
	public void setCorpCd(String corpCd) {
		this.corpCd = corpCd;
	}
	public String getCorpModCd() {
		return corpModCd;
	}
	public void setCorpModCd(String corpModCd) {
		this.corpModCd = corpModCd;
	}
	public String getCorpCdNm() {
		return corpCdNm;
	}
	public void setCorpCdNm(String corpCdNm) {
		this.corpCdNm = corpCdNm;
	}
	public String getFrstRegDttm() {
		return frstRegDttm;
	}
	public void setFrstRegDttm(String frstRegDttm) {
		this.frstRegDttm = frstRegDttm;
	}
	public String getLastModDttm() {
		return lastModDttm;
	}
	public void setLastModDttm(String lastModDttm) {
		this.lastModDttm = lastModDttm;
	}
	public String getCoRegNum() {
		return coRegNum;
	}
	public void setCoRegNum(String coRegNum) {
		this.coRegNum = coRegNum;
	}
	public String getCorpEmail() {
		return corpEmail;
	}
	public void setCorpEmail(String corpEmail) {
		this.corpEmail = corpEmail;
	}
	public String getStatusCd() {
		return statusCd;
	}
	public void setStatusCd(String statusCd) {
		this.statusCd = statusCd;
	}
	public String getHmpgAddr() {
		return hmpgAddr;
	}
	public void setHmpgAddr(String hmpgAddr) {
		this.hmpgAddr = hmpgAddr;
	}
	public String getCeoTelNum() {
		return ceoTelNum;
	}
	public void setCeoTelNum(String ceoTelNum) {
		this.ceoTelNum = ceoTelNum;
	}
	public String getRsvTelNum() {
		return rsvTelNum;
	}
	public void setRsvTelNum(String rsvTelNum) {
		this.rsvTelNum = rsvTelNum;
	}
	public String getCorpNm() {
		return corpNm;
	}
	public void setCorpNm(String corpNm) {
		this.corpNm = corpNm;
	}
	public String getCeoNm() {
		return ceoNm;
	}
	public void setCeoNm(String ceoNm) {
		this.ceoNm = ceoNm;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getDtlAddr() {
		return dtlAddr;
	}
	public void setDtlAddr(String dtlAddr) {
		this.dtlAddr = dtlAddr;
	}
	public String getShopNm() {
		return shopNm;
	}
	public void setShopNm(String shopNm) {
		this.shopNm = shopNm;
	}
	public String getCorpType() {
		return corpType;
	}
	public void setCorpType(String corpType) {
		this.corpType = corpType;
	}
	public String getFaxNum() {
		return faxNum;
	}
	public void setFaxNum(String faxNum) {
		this.faxNum = faxNum;
	}
	public String getBranchNm() {
		return branchNm;
	}
	public void setBranchNm(String branchNm) {
		this.branchNm = branchNm;
	}
	public String getCeoBth() {
		return ceoBth;
	}
	public void setCeoBth(String ceoBth) {
		this.ceoBth = ceoBth;
	}
	public String getBsncon() {
		return bsncon;
	}
	public void setBsncon(String bsncon) {
		this.bsncon = bsncon;
	}
	public String getBsntyp() {
		return bsntyp;
	}
	public void setBsntyp(String bsntyp) {
		this.bsntyp = bsntyp;
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
	public String getDepositor() {
		return depositor;
	}
	public void setDepositor(String depositor) {
		this.depositor = depositor;
	}
	public String getFrstRegIp() {
		return frstRegIp;
	}
	public void setFrstRegIp(String frstRegIp) {
		this.frstRegIp = frstRegIp;
	}
	public String getLastModIp() {
		return lastModIp;
	}
	public void setLastModIp(String lastModIp) {
		this.lastModIp = lastModIp;
	}
	public String getAdmMemo() {
		return admMemo;
	}
	public void setAdmMemo(String admMemo) {
		this.admMemo = admMemo;
	}
	public String getSalePrdtList() {
		return salePrdtList;
	}
	public void setSalePrdtList(String salePrdtList) {
		this.salePrdtList = salePrdtList;
	}
	public String getAdmNm() {
		return admNm;
	}
	public void setAdmNm(String admNm) {
		this.admNm = admNm;
	}
	public String getAdmDep() {
		return admDep;
	}
	public void setAdmDep(String admDep) {
		this.admDep = admDep;
	}
	public String getAdmOfcpos() {
		return admOfcpos;
	}
	public void setAdmOfcpos(String admOfcpos) {
		this.admOfcpos = admOfcpos;
	}
	public String getAdmMobile() {
		return admMobile;
	}
	public void setAdmMobile(String admMobile) {
		this.admMobile = admMobile;
	}
	public String getAdmTelnum() {
		return admTelnum;
	}
	public void setAdmTelnum(String admTelnum) {
		this.admTelnum = admTelnum;
	}
	public String getAdmEmail() {
		return admEmail;
	}
	public void setAdmEmail(String admEmail) {
		this.admEmail = admEmail;
	}
	public String getFrstRegId() {
		return frstRegId;
	}
	public void setFrstRegId(String frstRegId) {
		this.frstRegId = frstRegId;
	}
	public String getLastModId() {
		return lastModId;
	}
	public void setLastModId(String lastModId) {
		this.lastModId = lastModId;
	}
	public String getConfCorpId() {
		return confCorpId;
	}
	public void setConfCorpId(String confCorpId) {
		this.confCorpId = confCorpId;
	}

	public String getTamnacardMngYn() {
		return tamnacardMngYn;
	}

	public void setTamnacardMngYn(String tamnacardMngYn) {
		this.tamnacardMngYn = tamnacardMngYn;
	}
}
