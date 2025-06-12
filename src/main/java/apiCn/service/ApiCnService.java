package apiCn.service;

import java.util.List;
import java.util.Map;

import apiCn.vo.APICNSVO;
import apiCn.vo.APICNVO;
import apiCn.vo.APIDTLVO;
import apiCn.vo.ILSDTLVO;


public interface ApiCnService {

	/**
	 * 연계 업체 조회
	 * 파일명 : selectApiCnCorpList
	 * 작성일 : 2016. 7. 6. 오후 5:18:11
	 * 작성자 : 최영철
	 * @param apicnSVO
	 * @return
	 */
	Map<String, Object> selectApiCnCorpList(APICNSVO apicnSVO);

	/**
	 * 연계 업체 등록
	 * 파일명 : insertApiCorp
	 * 작성일 : 2016. 7. 11. 오후 5:19:56
	 * 작성자 : 최영철
	 * @param apicnVO
	 */
	void insertApiCorp(APICNVO apicnVO);

	/**
	 * 연계 업체 단건 조회
	 * 파일명 : selectByApiCorp
	 * 작성일 : 2016. 7. 12. 오전 10:52:40
	 * 작성자 : 최영철
	 * @param apicnVO
	 * @return
	 */
	APICNVO selectByApiCorp(APICNVO apicnVO);

	/**
	 * 연계 업체 수정
	 * 파일명 : updateApiCorp
	 * 작성일 : 2016. 7. 12. 오후 1:59:01
	 * 작성자 : 최영철
	 * @param apicnVO
	 */
	void updateApiCorp(APICNVO apicnVO);

	/**
	 * 연계 업체 카운트
	 * 파일명 : getCntCorpList
	 * 작성일 : 2016. 7. 12. 오후 5:56:43
	 * 작성자 : 최영철
	 * @param searchVO
	 * @return
	 */
	Integer getCntCorpList(APICNSVO searchVO);

	/**
	 * API 상세 리스트 조회
	 * 파일명 : selectApiDtlList
	 * 작성일 : 2016. 7. 13. 오후 1:57:50
	 * 작성자 : 최영철
	 * @param apicnVO
	 * @return
	 */
	List<APIDTLVO> selectApiDtlList(APICNVO apicnVO);

	/**
	 * API 등록
	 * 파일명 : insertApi
	 * 작성일 : 2016. 7. 18. 오후 4:24:07
	 * 작성자 : 최영철
	 * @param apiDtlVO
	 */
	void insertApiDtl(APIDTLVO apiDtlVO);

	/**
	 * API 단건 조회
	 * 파일명 : selectByApiDtl
	 * 작성일 : 2016. 7. 18. 오후 5:24:17
	 * 작성자 : 최영철
	 * @param apiDtlVO
	 * @return
	 */
	APIDTLVO selectByApiDtl(APIDTLVO apiDtlVO);

	/**
	 * API 수정
	 * 파일명 : updateApiDtl
	 * 작성일 : 2016. 7. 19. 오전 9:09:36
	 * 작성자 : 최영철
	 * @param apiDtlVO
	 */
	void updateApiDtl(APIDTLVO apiDtlVO);

	/**
	 * ILS 연계용
	 * 파일명 : selectIlsList
	 * 작성일 : 2016. 11. 10. 오후 4:32:40
	 * 작성자 : 최영철
	 * @param apiVO
	 * @return
	 */
	List<ILSDTLVO> selectIlsList(APICNVO apiVO);

}
