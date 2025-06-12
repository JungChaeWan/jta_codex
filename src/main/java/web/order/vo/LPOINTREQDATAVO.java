package web.order.vo;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.codehaus.jackson.annotate.JsonProperty;

import egovframework.cmmn.EgovWebUtil;
import egovframework.cmmn.service.EgovProperties;

public class LPOINTREQDATAVO {
	Logger log = (Logger) LogManager.getLogger(this.getClass());
	
	@JsonProperty("control")
	public Control control = new Control();
	/*** 공통부분 ***/
	public String serviceID = "";	// 서비스ID
	public String cdno = "";		// 카드번호 ( '-' 제외 )
	public String copMcno = EgovProperties.getProperty("L.POINT.copMcno");	// 개방형 제휴가맹점번호
	public String filler = "";		// FILLER
	// '온라인 비밀번호 인증 요청' 시 미사용
	public String wcc = "3";		// WCC ("1" : MSR, "2" : IC, "3" : Key In)
	// '온라인 비밀번호 인증 요청' 시 미사용
	public String aprAkMdDc = "3";	// 승인요청방식구분코드 ("1" : POS, "2" : 단말, "3" :온라인, "4" :모바일)
		
	/*** 개방형 회원인증 (serviceID => O100) ***/	
	public String cstDrmDc = "1";	// 승인요청방식구분코드 (1:카드번호, 2:고객번호)
	
	/*** 온라인 비밀번호 인증 (serviceID => O720) ***/
	public String pswd = "";	// 비밀번호 (MD5로 암호화 된 값)
	
	/*** 개방형 포인트 사용승인 (serviceID => O730) ***/
	public String mbPtUPswd = "";	// 멤버스포인트사용비밀번호 (MD5로 암호화 된 값)	
	public String ccoAprno = "";	// 제휴사승인번호 (탐나오 예약 번호)
	public String deDt = "";		// 거래일자 (yyyyMMdd)
	public String deHr = "";		// 거래시간 (HHmmss)
	public String deDc = "";		// 거래구분코드 ("20" : 포인트사용, "30" : 포인트조정)
	public String deRsc = "";		// 거래사유코드 (거래구분 = 20 ->"200":대금결제, "212":차감할인, "213":부분차감)
	public String uDc = "";			// 사용구분코드 ("1" : 정상, "2" : 취소)
	public String ptUDc = "";		// 포인트사용구분코드 ("1":일반거래, "2":요청포인트 이내 가용포인트 전부사용, 3:포인트 차감할인 매출금액으로 사용포인트 결정, 4:포인트 부분차감  매출금액으로 재적립 요청)
	public String ttnUPt = "";		// 금회사용포인트 (금회사용포인트= 물품구매 사용포인트 ==> 1)포인트사용구분코드가 "1","2" 이면 필수항목. 2)포인트사용구분코드="3","4"이면 0으로 세팅)
	public String slAm = "";		// 매출금액 (포인트사용구분코드 - "3","4" 이면 필수항목)
//	public String cstDrmDc = "1";	// 고객식별구분코드 (1:카드번호, 2:고객번호)
	public String cstDrmV = "";		// 고객식별값 (고객식별구분코드 - 2.고객번호인 경우 필수)
	
	/*** 개방형 포인트 사용취소 (serviceID => O740) ***/
//	public String ccoAprno = "";	// 제휴사승인번호
//	public String deDt = "";		// 거래일자
//	public String deHr = "";		// 거래시간
//	public String deDc = "";		// 거래구분코드 
//	public String deRsc = "";		// 거래사유코드 (거래구분 = 20 -> "200":대금결제, "212":차감할인, "213":부분차감 ; 거래구분 = 30 -> "220":원거래없는 포인트 사용취소)
//	public String uDc = "";			// 사용구분코드 ("2" : 취소)
//	public String ptUDc = "";		// 포인트사용구분코드
//	public String ttnUPt = "";		// 금회사용포인트 (원거래정보유무 ==> "0"이면 필수)
	public String otInfYnDc = "";	// 원거래정보유무구분코드 ("1" : 원거래정보있음, "0" : 원거래정보없음)
	public String otInfDc = "";		// 원거래정보구분코드 ("1" : 운영사 원승인정보, "2" : 제휴사 원승인정보)
	public String otAprno = "";		// 원거래승인번호 (원거래정보구분 ==> "1"이면 운영사 원승인번호 <필수> , "2"이면 원제휴사승인번호 )
	public String otDt = "";		// 원거래일자 (원거래정보구분 ==> "1"이면 운영사 원승인일자 <필수>, "2"이면 제휴사 원거래일자)
	
	
	public class Control{
		public String flwNo; 		// 추적번호
		public String rspC = " ";	// 응답코드 ("  " : 요청, "00" : 정상, "60" : 망취소)
		
	
		public Control()
		{
			/*
			 * 오늘 날짜 정보
			 */
	        Date dt = new Date();
	        SimpleDateFormat dtFmt = new SimpleDateFormat("yyyyMMdd");
	        
			/*
			 * 추적 번호 생성 
			 *  - 서비스ID(전문ID) + 기관코드 + 요청일(yyyyMMdd) + 일련번호(6자리)
			 */	        
	        // "O100"
	    log.info("serviceID 1 : " + serviceID); 
	       
	        this.flwNo = serviceID + EgovProperties.getProperty("L.POINT.corpCode") + dtFmt.format(dt) + EgovWebUtil.generateRandomNumber(6);	        
		}	
	}
	
	public void setRspC(String rspC) {
		this.control.rspC = rspC;
	}	
	
	public void setServiceID(String serviceID) {	
		this.serviceID = serviceID;
	log.info("serviceID 2 : " + serviceID); 	
		this.control = new Control();
	}

	public void setAprAkMdDc(String aprAkMdDc) {
		this.aprAkMdDc = aprAkMdDc;
	}

	public void setCdno(String cdno) {
		this.cdno = cdno;
	}
	
	public void setPswd(String pswd) {
		this.pswd = pswd;
	}

	public void setMbPtUPswd(String mbPtUPswd) {
		this.mbPtUPswd = mbPtUPswd;
	}

	public void setCcoAprno(String ccoAprno) {
		this.ccoAprno = ccoAprno;
	}

	public void setOtAprno(String otAprno) {
		this.otAprno = otAprno;
	}
	
	public void setOtDt(String otDt) {
		this.otDt = otDt;
	}

	public void setTtnUPt(String ttnUPt) {
		this.ttnUPt = ttnUPt;
	}

	public void setPtUDc(String ptUDc) {
		this.ptUDc = ptUDc;
	}

	public void setDeDc(String deDc) {
		this.deDc = deDc;
	}

	public void setSlAm(String slAm) {
		this.slAm = slAm;
	}	
}
