package mas.b2b.service;

import java.util.List;
import java.util.Map;

import mas.b2b.vo.B2B_AD_AMTGRPSVO;
import mas.b2b.vo.B2B_AD_AMTGRPVO;
import mas.b2b.vo.B2B_AD_AMTSVO;
import mas.b2b.vo.B2B_AD_AMTVO;
import mas.b2b.vo.B2B_AD_PRDTSVO;


public interface MasB2bAdService {

	/**
	 * 전체 그룹 리스트 조회
	 * 파일명 : selectAmtGrpList
	 * 작성일 : 2016. 9. 27. 오후 1:39:30
	 * 작성자 : 최영철
	 * @param amtGrpSVO 
	 * @return
	 */
	List<B2B_AD_AMTGRPVO> selectAmtGrpList(B2B_AD_AMTGRPSVO amtGrpSVO);

	/**
	 * 그룹 등록
	 * 파일명 : insertAmtGrp
	 * 작성일 : 2016. 9. 27. 오후 3:24:44
	 * 작성자 : 최영철
	 * @param amtGrpVO
	 */
	void insertAmtGrp(B2B_AD_AMTGRPVO amtGrpVO);

	/**
	 * 그룹별 업체 리스트
	 * 파일명 : selectB2bCorpGrpList
	 * 작성일 : 2016. 9. 27. 오후 3:41:55
	 * 작성자 : 최영철
	 * @param amtGrpSVO
	 * @return
	 */
	Map<String, Object> selectB2bCorpGrpList(B2B_AD_AMTGRPSVO amtGrpSVO);

	/**
	 * 그룹 수정
	 * 파일명 : updateAmtGrp
	 * 작성일 : 2016. 9. 27. 오후 4:47:22
	 * 작성자 : 최영철
	 * @param amtGrpVO
	 */
	void updateAmtGrp(B2B_AD_AMTGRPVO amtGrpVO);

	/**
	 * 업체 그룹 등록
	 * 파일명 : mergeCorpGrp
	 * 작성일 : 2016. 9. 28. 오전 11:18:58
	 * 작성자 : 최영철
	 * @param amtGrpVO
	 */
	void mergeCorpGrp(B2B_AD_AMTGRPVO amtGrpVO);

	/**
	 * 업체 그룹 삭제
	 * 파일명 : deleteCorpGrp
	 * 작성일 : 2016. 9. 28. 오전 11:31:08
	 * 작성자 : 최영철
	 * @param amtGrpVO
	 */
	void deleteCorpGrp(B2B_AD_AMTGRPVO amtGrpVO);

	/**
	 * 숙박 업체요금 그룹 리스트 조회
	 * 파일명 : selectCorpAmtList
	 * 작성일 : 2016. 9. 28. 오후 1:54:26
	 * 작성자 : 최영철
	 * @param amtGrpVO
	 * @return
	 */
	List<B2B_AD_AMTGRPVO> selectCorpAmtList(B2B_AD_AMTGRPVO amtGrpVO);

	/**
	 * 숙박 업체요금 그룹 삭제
	 * 파일명 : deleteAmtGrp
	 * 작성일 : 2016. 9. 28. 오후 1:59:37
	 * 작성자 : 최영철
	 * @param amtGrpVO
	 */
	void deleteAmtGrp(B2B_AD_AMTGRPVO amtGrpVO);

	/**
	 * 숙박 B2B 요금 조회
	 * 파일명 : selectAmtList
	 * 작성일 : 2016. 9. 29. 오전 9:54:46
	 * 작성자 : 최영철
	 * @param amtSVO
	 * @return
	 */
	List<B2B_AD_AMTVO> selectAmtList(B2B_AD_AMTSVO amtSVO);

	/**
	 * 요금 그룹 단건 조회
	 * 파일명 : selectByAmtGrp
	 * 작성일 : 2016. 9. 29. 오전 10:26:28
	 * 작성자 : 최영철
	 * @param amtGrpVO
	 * @return
	 */
	B2B_AD_AMTGRPVO selectByAmtGrp(B2B_AD_AMTGRPVO amtGrpVO);

	/**
	 * 간편입력기를 이용한 요금 적용
	 * 파일명 : mergeAmtCalSmp
	 * 작성일 : 2016. 9. 29. 오전 11:09:00
	 * 작성자 : 최영철
	 * @param amtVO
	 */
	void mergeAmtCalSmp(B2B_AD_AMTVO amtVO);

	/**
	 * 월 단위 요금 적용
	 * 파일명 : mergeAmtInf
	 * 작성일 : 2016. 9. 29. 오후 2:42:07
	 * 작성자 : 최영철
	 * @param amtList
	 */
	void mergeAmtInf(List<B2B_AD_AMTVO> amtList);

	/**
	 * 숙박 실시간 상품 조회
	 * 파일명 : selectAdPrdtList
	 * 작성일 : 2016. 10. 5. 오후 2:32:49
	 * 작성자 : 최영철
	 * @param searchVO
	 * @return
	 */
	Map<String, Object> selectAdPrdtList(B2B_AD_PRDTSVO searchVO);


}
