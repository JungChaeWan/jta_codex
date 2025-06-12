package oss.site.vo;

import java.util.List;

import oss.cmm.vo.pageDefaultVO;

public class SVCRTNVO extends pageDefaultVO {
	private String crtnNum;		/* 큐레이션 번호 */
	private String crtnNm;		/* 큐레이션 명 */
	private String simpleExp;	/* 간략 설명 */
	private String listImgPath;	/* 목록 이미지 경로 */
	private int sort;			/* 정렬 */
	private String printYn;		/* 출력 여부 */
	private String frstRegDttm;	/* 최초 등록 일시 */
	private String frstRegId;	/* 최초 등록 아이디 */
	private String lastModDttm;	/* 최종 수정 일시 */
	private String lastModId;	/* 최종 수정 아이디 */
	
	private int oldSort;		/* 이전 정렬 */
	private List<String> prdtNum;	/* 특산품 상품 리스트 */
	private String prdtNumOne;
	private String maxSort;
	private String prdtCnt;
	
	private String sCtgrDiv; 
	
	public String getCrtnNum() {
		return crtnNum;
	}
	public void setCrtnNum(String crtnNum) {
		this.crtnNum = crtnNum;
	}
	public String getPrintYn() {
		return printYn;
	}
	public void setPrintYn(String printYn) {
		this.printYn = printYn;
	}
	public String getCrtnNm() {
		return crtnNm;
	}
	public void setCrtnNm(String crtnNm) {
		this.crtnNm = crtnNm;
	}
	public String getSimpleExp() {
		return simpleExp;
	}
	public void setSimpleExp(String simpleExp) {
		this.simpleExp = simpleExp;
	}
	public String getListImgPath() {
		return listImgPath;
	}
	public void setListImgPath(String listImgPath) {
		this.listImgPath = listImgPath;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public String getFrstRegDttm() {
		return frstRegDttm;
	}
	public void setFrstRegDttm(String frstRegDttm) {
		this.frstRegDttm = frstRegDttm;
	}
	public String getFrstRegId() {
		return frstRegId;
	}
	public void setFrstRegId(String frstRegId) {
		this.frstRegId = frstRegId;
	}
	public String getLastModDttm() {
		return lastModDttm;
	}
	public void setLastModDttm(String lastModDttm) {
		this.lastModDttm = lastModDttm;
	}
	public String getLastModId() {
		return lastModId;
	}
	public void setLastModId(String lastModId) {
		this.lastModId = lastModId;
	}
	public int getOldSort() {
		return oldSort;
	}
	public void setOldSort(int oldSort) {
		this.oldSort = oldSort;
	}
	public List<String> getPrdtNum() {
		return prdtNum;
	}
	public void setPrdtNum(List<String> prdtNum) {
		this.prdtNum = prdtNum;
	}
	public String getPrdtNumOne() {
		return prdtNumOne;
	}
	public void setPrdtNumOne(String prdtNumOne) {
		this.prdtNumOne = prdtNumOne;
	}
	public String getMaxSort() {
		return maxSort;
	}
	public void setMaxSort(String maxSort) {
		this.maxSort = maxSort;
	}
	public String getPrdtCnt() {
		return prdtCnt;
	}
	public void setPrdtCnt(String prdtCnt) {
		this.prdtCnt = prdtCnt;
	}
	public String getsCtgrDiv() {
		return sCtgrDiv;
	}
	public void setsCtgrDiv(String sCtgrDiv) {
		this.sCtgrDiv = sCtgrDiv;
	}
}
