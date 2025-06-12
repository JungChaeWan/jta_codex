package common;


public class Constant {

	public static final String FLAG_INIT = "DEV";
	/*public static final String FLAG_INIT = "local";*/

	public static final String FLAG_Y = "Y";
	public static final String FLAG_N = "N";

	public static final String JSON_SUCCESS = "SUCCESS";
	public static final String JSON_FAIL = "FAIL";

	public static final String CORP_CD = "CORP";
	public static final String CORP_MOD_CD = "COMP";
	// 업체코드 - 항공
	public static final String AVIATION = "AV";
	// 업체코드 - 숙박
	public static final String ACCOMMODATION = "AD";
	// 업체코드 - 렌트카
	public static final String RENTCAR = "RC";
	// 업체코드 - 골프
	public static final String GOLF = "GL";
	// 업체코드 - 소셜상품
	public static final String SOCIAL = "SP";
	//업체코드 - 관광기념품
	public static final String SV = "SV";

	// 업체 서브 코드 - 소셜
	public static final String SOCIAL_TOUR = "TOUR";	//여행사
	public static final String SOCIAL_TICK = "TICK";	//관광지입장권
	public static final String SOCIAL_FOOD = "FOOD";	// 레져/음식/뷰티

	/* 거래상태코드 */
	public static final String TRADE_STATUS = "TS";

	public static final String TRADE_STATUS_REG = "TS01"; 				/* 등록중 */
	public static final String TRADE_STATUS_APPR_REQ = "TS02"; 			/* 승인요청 */
	public static final String TRADE_STATUS_APPR = "TS03";				/* 승인 */
	public static final String TRADE_STATUS_APPR_REJECT = "TS04";		/* 승인거절 */
	public static final String TRADE_STATUS_STOP = "TS05";				/* 판매중지 */
	public static final String TRADE_STATUS_EDIT = "TS06";				/* 수정요청 */
	public static final String TRADE_STATUS_REJECT = "TS07";				/* 거래중지 */
	public static final String TRADE_STATUS_STOP_REQ = "TS08";				/* 판매중지요청 */

	/* 소셜상품 상품 구분 */
	public static final String SP_PRDT_DIV_TOUR = "TOUR";
	public static final String SP_PRDT_DIV_COUP = "COUP";
	public static final String SP_PRDT_DIV_SHOP = "SHOP";
	public static final String SP_PRDT_DIV_FREE = "FREE";

	// 차량연료코드
	public static final String RC_CARFUEL_DIV = "CFCD";
	// 차량구분코드
	public static final String RC_CAR_DIV = "CDIV";
	// 변속기구분코드
	public static final String RC_TRANS_DIV = "TRAN";
	// 제조사 구분
	public static final String RC_MAKER_DIV = "MDIV";
	// 차량 코드
	public static final String RC_CAR_CD = "CACD";
	// 보험여부 코드
	public static final String RC_ISR_DIV_CD = "IDCD";

	// 보험구분 코드
	public static final String RC_ISR_TYPE_GEN = "GENL";	// 일반자차
	public static final String RC_ISR_TYPE_LUX = "LUXY";	// 고급자차

	public static final String RC_RENTCAR_COMPANY_GRI = "G"; //그림 
	public static final String RC_RENTCAR_COMPANY_INS = "I"; //인스
	public static final String RC_RENTCAR_COMPANY_RIB = "R"; //리본
	public static final String RC_RENTCAR_COMPANY_ORC = "O"; //오르카

	// 카테고리 대분류 상위코드값
	public static final String CATEGORY_CD = "C000";
	public static final String CATEGORY_PACKAGE = "C100";
	public static final String CATEGORY_TOUR = "C200";
	public static final String CATEGORY_ETC = "C300";
	public static final String CATEGORY_ADRC = "C400";
	public static final String CATEGORY_BACS = "C500";

	public static final String CATEGORY_PACKAGE_VESSEL = "C190";

	public static final String CATEGORY_ETC_FOOD = "C310";	//웰빙/음식
	public static final String CATEGORY_ETC_SPORT = "C250";	// 스포츠/레저
	public static final String CATEGORY_ETC_SHIP = "C260";	// 잠수함/유람선/요트
	public static final String CATEGORY_ETC_VILLAGE = "C270";	// 체험
	public static final String CATEGORY_ETC_HORSE = "C340";	// 승마
	public static final String CATEGORY_ETC_BEAUTY = "C350";	//뷰티/기타
	public static final String CATEGORY_ETC_MASSAGE = "C280";	//마사지


	public static final String CATEGORY_PACK_AD = "C410";	// 특가상품 숙박
	public static final String CATEGORY_PACK_RC = "C420";	// 특가상품 렌터카

	public static final String CATEGORY_BABY_SHEET = "C510";	//유모차/카시트

	// 발행상태코드
	public static final String STATUS_CD_READY = "ST01";		// 발행 대기
	public static final String STATUS_CD_COMPLETE = "ST02";	// 발행완료
	public static final String STATUS_CD_CANCEL = "ST03";		// 발행취소

	// 정렬
	public static final String ORDER_SALE = "SALE";
	public static final String ORDER_PRICE = "PRICE";
	public static final String ORDER_PRICE_DESC = "PRICE_DESC";
	public static final String ORDER_NEW = "NEW";
	public static final String ORDER_GPA = "GPA";
	public static final String ORDER_DIST = "DIST";
	public static final String ORDER_DISPER = "DISPER";
	public static final String ORDER_RANDOM = "RANDOM";
	public static final String ORDER_DESC = "DESC";
	public static final String ORDER_ASC = "ASC";

	// 탐나오 프로모션 구분
	public static final String PRMT_DIV_PLAN = "PLAN";	//
	public static final String PRMT_DIV_EVNT = "EVNT";	//이벤트
	public static final String PRMT_DIV_FROM = "FROM";	//
	public static final String PRMT_DIV_NOTI = "NOTI";	//공지사항
	public static final String PRMT_DIV_GOVA = "GOVA";	//공고 신청

	public static final String DFT_INF_TAMNAO = "TAMNAO";

	// 예약상태코드 - 각 상품별 예약상태코드임
	public static final String RSV_STATUS_CD_READY = "RS00";	// 예약대기
	public static final String RSV_STATUS_CD_EXP = "RS01"; 	// 예약불가
	public static final String RSV_STATUS_CD_COM = "RS02"; 	// 예약
	public static final String RSV_STATUS_CD_DLV = "RS03"; 	// 배송 중
	public static final String RSV_STATUS_CD_CREQ = "RS10"; 	// 고객취소요청
	public static final String RSV_STATUS_CD_CREQ2 = "RS11"; 	// 환불요청
	public static final String RSV_STATUS_CD_SREQ = "RS12"; 	// 부분환불요청
	public static final String RSV_STATUS_CD_CCOM2 = "RS13"; 	// 환불완료
	public static final String RSV_STATUS_CD_CCOM = "RS20"; 	// 취소
	public static final String RSV_STATUS_CD_UCOM = "RS30"; 	// 사용완료
	public static final String RSV_STATUS_CD_ECOM = "RS31"; 	// 기간만료
	public static final String RSV_STATUS_CD_SCOM = "RS32"; 	// 부분환불완료
	public static final String RSV_STATUS_CD_DLVE = "RS33"; 	// 배송완료
	public static final String RSV_STATUS_CD_ACC = "RS99"; 	// 자동취소

	// 결제구분
	public static final String PAY_DIV_LG_CI = "L100";		// LG U+ 카드결제
	public static final String PAY_DIV_LG_CC = "L101";		// LG U+ 카드결제취소
	public static final String PAY_DIV_LG_HI = "L200";		// LG U+ 휴대폰결제
	public static final String PAY_DIV_LG_HC = "L201";		// LG U+ 휴대폰결제취소
	public static final String PAY_DIV_LG_TI = "L300";		// LG U+ 계좌이체
	public static final String PAY_DIV_LG_TC = "L301";		// LG U+ 계좌이체취소
	public static final String PAY_DIV_LG_ETI = "L310";		// LG U+ 계좌이체(에스크로)
	public static final String PAY_DIV_LG_ETC = "L311";		// LG U+ 계좌이체(에스크로)취소
	public static final String PAY_DIV_LG_MI = "L700";		// LG U+ 무통장입금
	public static final String PAY_DIV_LG_MC = "L701";		// LG U+ 무통장입금취소
	public static final String PAY_DIV_LG_EMI = "L710";		// LG U+ 무통장이체(에스크로)f
	public static final String PAY_DIV_LG_EMC = "L711";		// LG U+ 무통장취소(에스크로)취소
	public static final String PAY_DIV_LG_KI = "L400";		// 카카오페이 결제
	public static final String PAY_DIV_LG_KC = "L401";		// 카카오페이 결제취소
	public static final String PAY_DIV_LG_FI = "L500";		// 무료쿠폰 결제
	public static final String PAY_DIV_LG_FC = "L501";		// 무료쿠폰 결제취소
	public static final String PAY_DIV_LG_LI = "L600";		// L.Point 결제
	public static final String PAY_DIV_LG_LC = "L601";		// L.Point 결제취소
	public static final String PAY_DIV_TA_PI = "L610";		// 탐나오 포인트 결제
	public static final String PAY_DIV_TA_PC = "L611";		// 탐나오 포인트 취소
	public static final String PAY_DIV_TC_WI = "L800";		// 탐나는전 PC결제
	public static final String PAY_DIV_TC_WC = "L801";		// 탐나는전 PC결제취소
	public static final String PAY_DIV_TC_MI = "L810";		// 탐나는전 모바일결제
	public static final String PAY_DIV_TC_MC = "L811";		// 탐나는전 모바일결제취소
	public static final String PAY_DIV_LG_NP = "S100";		// 네이버페이
	public static final String PAY_DIV_LG_KP = "S200";		// 카카오페이
	public static final String PAY_DIV_LG_AP = "S300";		// 애플페이
	public static final String PAY_DIV_LG_TP = "S400";		// 토스페이
	public static final String PAY_DIV_NV_SI = "N200";		// 네이버 스마트스토어결제
	public static final String PAY_DIV_NV_SC = "N201";		// 네이버 스마트스토어취소
	public static final String PAY_DIV_NV_LI = "N210";		// 네이버 라이브커머스 결제
	public static final String PAY_DIV_NV_LC = "N211";		// 네이버 라이브커머스 취소
	public static final String PAY_DIV_LG_MN = "M999";		// 네이버 라이브커머스 취소



	// 결제구분
	public enum PAY_DIV {
		PAY_DIV_LG_CI("L100","카드결제"),
		PAY_DIV_LG_CC("L101","카드결제취소"),
		PAY_DIV_LG_HI("L200","휴대폰결제"),
		PAY_DIV_LG_HC("L201","휴대폰결제취소"),
		PAY_DIV_LG_TI("L300","계좌이체"),
		PAY_DIV_LG_TC("L301","계좌이체취소"),
		PAY_DIV_LG_ETI("L310","계좌이체(에스크로)"),
		PAY_DIV_LG_ETC("L311","계좌이체(에스크로)취소"),
		PAY_DIV_LG_MI("L700","무통장입금"),
		PAY_DIV_LG_MC("L701","무통장입금취소"),
		PAY_DIV_LG_EMI("L710","무통장입금(에스크로)"),
		PAY_DIV_LG_EMC("L711","무통장입금(에스크로)취소"),
		PAY_DIV_LG_KI("L400","카카오페이 결제"),
		PAY_DIV_LG_KC("L401","카카오페이 결제취소"),
		PAY_DIV_LG_FI("L500","무료쿠폰 결제"),
		PAY_DIV_LG_FC("L501","무료쿠폰 결제취소"),
		PAY_DIV_LG_LI("L600","L.Point 결제"),
		PAY_DIV_LG_LC("L601","L.Point 결제취소"),
		PAY_DIV_TA_PI("L610","탐나오 포인트 결제"),
		PAY_DIV_TA_PC("L611","탐나오 포인트 취소"),
		PAY_DIV_TC_WI("L800","탐나는전 PC결제"),
		PAY_DIV_TC_WC("L801","탐나는전 PC결제취소"),
		PAY_DIV_TC_MI("L810","탐나는전 모바일결제"),
		PAY_DIV_TC_MC("L811","탐나는전 모바일결제취소"),
		PAY_DIV_NV_SI("N200","스마트스토어결제"),
		PAY_DIV_NV_SC("N201","스마트스토어취소"),
		PAY_DIV_NV_LI("N210","라이브커머스결제"),
		PAY_DIV_NV_LC("N211","라이브커머스취소"),
		PAY_DIV_LG_NP("S100","네이버페이"),
		PAY_DIV_LG_KP("S200","카카오페이"),
		PAY_DIV_LG_AP("S300","애플페이"),
		PAY_DIV_LG_TP("S400","토스페이"),
		PAY_DIV_LG_MN("M999","관리자");

		private String code;
		private String name;

		PAY_DIV(String code, String name) {
			this.code = code;
			this.name = name;
		}

		public String getCode() {
			return this.code;
		}
		public String getName() {
			return this.name; }
	}

	public static final String RSV_DIV_C = "c";	// 장바구니 예약하기
	public static final String RSV_DIV_I = "i";	// 즉시 예약하기

	// 사용자쿠폰 구분
	public static final String USER_CP_DIV_EPIL = "EPIL";	// 회원가입
	public static final String USER_CP_DIV_UEPI = "UEPI";	// 이용후기
	public static final String USER_CP_DIV_UAPP = "UAPP";	// 앱다운로드
	public static final String USER_CP_DIV_VIMO = "VIMO";	// 재방문 10개월
	public static final String USER_CP_DIV_ACNR = "ACNR";	// 실시간상품 자동 취소
	public static final String USER_CP_DIV_ACNV = "ACNV";	// 제주특산/기념품 자동 취소
	public static final String USER_CP_DIV_AEVT = "AEVT";	// 이벤트 쿠폰 - 관리자가 직접 생성한 쿠폰
	public static final String USER_CP_DIV_BAAP = "BAAP";	// 구매자동발급쿠폰

	// 업체 승인 처리상태.
	public static final String CORP_STATUS_CD_01 = "ST01"; 	//신청중
	public static final String CORP_STATUS_CD_02 = "ST02"; 	// 승인검토중
	public static final String CORP_STATUS_CD_03 = "ST03"; 	// 승인완료
	public static final String CORP_STATUS_CD_04 = "ST04";	// 입점불가
	public static final String CORP_STATUS_CD_05 = "ST05";	// 입점취소

	// 회사유형
	public static final String CORP_TYPE_CORP = "CORP"; 	//법인
	public static final String CORP_TYPE_INDI = "INDI";		//개인
	public static final String CORP_TYPE_SIMP = "SIMP";		//간이

	//API호출 관련
	public static final String SUKSO_DOMAIN = "pension.tamnao.com";  //운용서버
	//public static final String SUKSO_DOMAIN = "pension.todayjeju.net"; //테스트서버
	//public static final String SUKSO_DOMAIN = "localhost:8080/pension/";  //로컬 서버
	public static final String SUKSO_OK = "OK!";
	public static final String SUKSO_AUTH_KEY = "1";

	// 정산상태
	public static final String ADJ_STATUS_CD_READY = "AJ10";	// 정산대기
	public static final String ADJ_STATUS_CD_COM = "AJ80";	// 정산완료

	public static final String RSV_GUSET_NAME = "GUEST";

	// 주요정보
	public static final String ICON_CD_RCAT = "RCAT"; // 렌트카 주요정보
	public static final String ICON_CD_ADAT = "ADAT";	//숙박

	// 수수료 구분
	public static final String CMSS_BTC = "C";	// 고객판매 수수료
	public static final String CMSS_BTB = "B";	// B2B 판매 수수료

	// 항공 판매 코드
	public static final String AIR_SALE_CORP_DC = "DC";	// 제주닷컴
	public static final String AIR_SALE_CORP_JL = "JL";	// 제이엘 항공

	// B2B 계약 상태 코드
	public static final String CTRT_STATUS_CD_ABLE 	= "CT01";	// 계약 가능
	public static final String CTRT_STATUS_CD_REQ 	= "CT02";	// 계약 요청
	public static final String CTRT_STATUS_CD_APPR 	= "CT03";	// 계약 승인
	public static final String CTRT_STATUS_CD_REJECT 	= "CT04";	// 계약 반려
	public static final String CTRT_STATUS_CD_CANCEL_REQ 	= "CT05";	// 계약 취소 요청
	public static final String CTRT_STATUS_CD_CANCEL 	= "CT06";	// 계약 취소

	// 기념품 구분코드
	public static final String SV_DIV = "SVDV";

	// 배송 금액 구분
	public static final String DLV_AMT_DIV_DLV = "DA01";		// 기본배송비
	public static final String DLV_AMT_DIV_APL = "DA02";		// 조건부무료
	public static final String DLV_AMT_DIV_MAXI = "DA03";		// 개별배송비
	public static final String DLV_AMT_DIV_FREE = "DA04";		// 무료

	// 기능개선게시판 상태 구분
	public static final String STATUS_DIV_01 = "SD01"; // 요청
	public static final String STATUS_DIV_02 = "SD02"; // 접수
	public static final String STATUS_DIV_03 = "SD03";	// 기각
	public static final String STATUS_DIV_04 = "SD04"; 	// 완료

	//배너 상위 코드
	public static final String BN_CD = "BN";

	// L.Point service 구분
	public static final String LPOINT_SAVE_PERCENT= "0.5";	// 적립 퍼센트
	public static final String LPOINT_SERVICE_100 = "O100";	// 회원인증
	public static final String LPOINT_SERVICE_720 = "O720";	// 비밀번호 인증
	public static final String LPOINT_SERVICE_730 = "O730";	// 포인트 사용승인
	public static final String LPOINT_SERVICE_740 = "O740";	// 포인트 사용취소
	public static final String LPOINT_SERVICE_920 = "O920";	// 포인트 적립 배치
	public static final String LPOINT_SERVICE_921 = "O921";	// 포인트 취소 배치

	// 쿠폰 할인방식
	public static final String CP_DIS_DIV_PRICE = "CP01";	// 금액 할인
	public static final String CP_DIS_DIV_RATE = "CP02";	// 할인율 적용 할인
	public static final String CP_DIS_DIV_FREE = "CP03";	// 무료 쿠폰
	// 쿠폰 적용상품 구분
	public static final String CP_APLPRDT_DIV_TYPE = "AP01";	// 유형 지정
	public static final String CP_APLPRDT_DIV_PRDT = "AP02";	// 상품 지정
	public static final String CP_APLPRDT_DIV_CORP = "AP03";	// 상품 지정
	// 쿠폰 수량 제한 타입
	public static final String CP_LIMIT_TYPE = "CPLI";

	//간편로그인 정보
	public static final String NAVER_CLIENT_ID = "iiDeDZg0EEcD33toerNR";
	public static final String NAVER_CLIENT_SECRET = "Wml6q9KosA";
    public static final String NAVER_REDIRECT_PATH = "/naverLogin.do";
    public static final String KAKAO_JAVASCRIPT_KEY = "71cf66fb54158dacb5fb5b656674ad70";
	public static final String KAKAO_REST_API_KEY = "aa5f76abb51cce81b27f9fe5eedd5393";
    public static final String KAKAO_ADMIN_KEY = "dfe460d30934cefc665c7004c207484f";
    public static final String KAKAO_REDIRECT_PATH = "/kakaoLogin.do";
    public static final String APPLE_CLIENT_ID = "com.tamnao.applelogin";
    public static final String APPLE_CLIENT_SECRET = "CCGF8N7WQ8";
    public static final String APPLE_REDIRECT_PATH = "/appleLogin.do";


    // 자동취소 시간
	public static final int WAITING_TIME = 20;

	// Tour API 정보
	public static final String TOUR_API_SERVICE_KEY = "JW1hgCUap45Yfuu8QlRAbdEzrsALZwh7V7TBExVuDsbhkrEvHeRPySOagsCt91wTXQSKUPpyJOdbrCDu0Ryqtw%3D%3D";
	public static final String TOUR_API_CONTENT_TYPE_ID = "12";		// 관광타입: 12(관광지)
	public static final String TOUR_API_RADIUS = "5000";			// 거리 반경(m)
	public static final String TOUR_API_ARRANGE = "E"; 				// 정렬: E(거리순), A(제목순), B(조회순)

	/** API 프로토콜*/
	public static final String API_OK = "200";

	// 프로모션 구분 코드
	public static final String PRMT_DIV_CD = "PRMT";
	// 프로모션 라벨 코드
	public static final String PRMT_LABEL_CD = "PLBL";

	// 파일 체크
	public static final String FILE_CHECK_EXT = ".png,.jpg,.jpeg,.gif,.pdf";		//  입점 서류(확장자)
	public static final String FILE_CHECK_SIZE = "5";								//  입점 서류(용량)

	// SK CLOUD CAM
	public static final String SKCC_USER_ID = "tamnao";
	public static final String SKCC_USER_PWD = "1q2w3e4r5t";

	// 수수료 구분 코드
	public static final String PG_CMSS_DIV = "CMDV";

	public static final String TAMNAO_TESTER1 = "010-8976-4976";
	public static final String TAMNAO_TESTER2 = "010-3083-2222";
	public static final String TAMNAO_TESTER3 = "010-8976-4976";
	//public static final String TAMNAO_TESTER3 = "010-8229-0954";

	public static final String TAMNAO_TESTER_NAME1 = "김재성";
	public static final String TAMNAO_TESTER_NAME2 = "정채완";
	public static final String TAMNAO_TESTER_NAME3 = "김재성";
	//public static final String TAMNAO_TESTER_NAME3 = "부민수";

	public static final String API_LSCOMPANY = "Y";
	public static final String API_VPASS = "V";
	public static final String API_YANOLJA = "J";

	public enum INSIDE_IP {
		IP1("211"),
		IP2("218");

		private String value;

		INSIDE_IP(String value) {
			this.value = value;
		}

		public String getValue() {
			return this.value;
		}
	}

	/** 결제구분 */
	public enum TAMNACARD_DIV {
		CORP("C","업체적용"),
		PROD("P","상품적용"),
		NONE("N","사용안함");

		private String code;
		private String name;

		TAMNACARD_DIV(String code, String name) {
			this.code = code;
			this.name = name;
		}

		public String getCode() {
			return this.code;
		}
		public String getName() {
			return this.name; }
	}
}
