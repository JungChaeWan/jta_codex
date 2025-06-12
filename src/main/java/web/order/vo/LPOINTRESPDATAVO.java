package web.order.vo;

import org.codehaus.jackson.annotate.JsonProperty;

public class LPOINTRESPDATAVO {
	@JsonProperty("control")
	public Control control = new Control();
	/*** 공통부분 ***/	
	public String msgCn1 ="";		// POS 단말용/상담용 메시지
    public String msgCn2 = "";		// 영수증 메시지
    public String filler = "";		// FILLER    
    
//	public int mbrInfCt = 0;		// 회원정보 건수 ( 사용여부 ? )	
//	public List<List<String>> mbrInfLst;	// 회원정보 목록 ( 사용여부 ? )
	
	/*** 개방형 회원인증 (serviceID => O100) ***/
	public String ctfCno ="";		// 인증고객번호 (해당 항목으로 기명/무기명 판단에 활용 - 기명 : 고개번호와 동일 - 무기명 : 인증고객번호 없음 )
    public String avlPt = "";		// 가용포인트 ( 롯데 포인트 - 기프트포인트 제외 )
    public String gftPt ="";		// 기프트포인트 ( 사용가능 기프트포인트 - 가용시작일자<인증날짜<가용종료일자 - 사용가능 제휴가맹점번호 )
    public String rspSgnC = "";		// 잔여포인트부호코드 ( + / - )
    public String resPt ="";		// 잔여포인트 ( 총 잔여 롯데포인트 - 기프트포인트 제외 )
    public String ptRvPsyn = "";	// 포인트적립가능여부 ( "1" : 포인트적립가능, "0" : 포인트적립불가 )
    public String ptUPsyn ="";		// 포인트사용가능여부 ( "1" : 포인트적립가능, "0" : 포인트적립불가 )
    public String ptAdpAplYn = "";	// 포인트합산 신청여부 ( 1':합산고객, '0':합산고객아님 - 기프트포인트는 합산에서 제외 )
    
	/*** 온라인 비밀번호 인증 (serviceID => O720) ***/
    public String rspC ="";			// 응답코드 ( 0:성공, 1:비밀번호오류, 2:비밀번호등록고객아님, 3:비밀번호오류횟수초과, 4:해당고객없음, 5:카드번호오류, 6:기타오류 ) 
    public String rspMsgCn = "";	// 응답 메시지내용
//  public String avlPt ="";		// 가용포인트
//  public String gftPt = "";		// 기프트포인트
//  public String rspSgnC ="";		// 잔여포인트부호코드
//  public String resPt = "";		// 잔여포인트
    public String pswdErrTms ="";	// POS 단말용/상담용 메시지
    	
	/*** 개방형 포인트 사용승인 (serviceID => O730) ***/
    public String cno ="";			// 고객번호
    public String aprno = "";		// 승인번호
    public String aprDt ="";		// 승인일자
    public String aprHr = "";		// 승인시간
    public String ttnUPt ="";		// 금회사용포인트
    public String evnPt = "";		// 이벤트포인트
//  public String rspSgnC ="";		// 잔여포인트부호코드
//  public String resPt = "";		// 잔여포인트
//  public String msgCn1 ="";		// 메시지내용1 ( 응답상세코드(3)+Space(1)+메시지내용(60) )
    public String slAm = "";		// 매출금액
    public String siDcam ="";		// 현장할인금액 ( 차감할인 사용 시 필수항목 )
    public String reRvPt = "";		// 재적립포인트 ( 부분차감 사용 시 필수항목 )
    public String mnsAftSttAm ="";	// 차감 후 결제금액 (차감할인,부분차감 사용 시 필수항목. [차감할인 결제금액] 매출금액-금회사용포인트-현장할인금액 [부분차감 결제금액] 매출금액-금회사용포인트)
    public String cshRctPsbPt = "";
    
	/*** 개방형 포인트 사용취소 (serviceID => O740) ***/
//  public String cno ="";			// 고객번호
//  public String aprno = "";		// 승인번호
//  public String aprDt ="";		// 승인일자
//  public String aprHr = "";		// 승인시간
    public String canPt ="";		// 취소포인트
//  public String evnPt = "";		// 이벤트포인트
//  public String avlPt ="";		// 가용포인트
//  public String gftPt = "";		// 기프트포인트
//  public String rspSgnC ="";		// 잔여포인트부호코드
//  public String resPt = "";		// 잔여포인트
//  public String msgCn1 ="";		// 메시지내용1 ( 응답상세코드(3)+Space(1)+메시지내용(60) )
//  public String slAm = "";		// 매출금액
//  public String siDcam ="";		// 현장할인금액
//  public String reRvPt = "";		// 재적립포인트
//  public String mnsAftSttAm ="";	// 차감 후 결제금액    
		
	public final class Control{
		public String flwNo; 	// 추적번호
		public String rspC;		// 응답코드		
	}
}
