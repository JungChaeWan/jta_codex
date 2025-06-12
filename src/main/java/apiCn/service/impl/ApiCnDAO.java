package apiCn.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import apiCn.vo.APICNSVO;
import apiCn.vo.APICNVO;
import apiCn.vo.APIDTLVO;
import apiCn.vo.ILSDTLVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;


@Repository("apiCnDAO")
public class ApiCnDAO extends EgovAbstractDAO {

	/**
	 * 연계 업체 조회
	 * 파일명 : selectApiCnCorpList
	 * 작성일 : 2016. 7. 6. 오후 5:20:40
	 * 작성자 : 최영철
	 * @param apicnSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<APICNVO> selectApiCnCorpList(APICNSVO apicnSVO) {
		return (List<APICNVO>) list("APICN_S_01", apicnSVO);
	}

	/**
	 * 연계 업체 카운트
	 * 파일명 : getCntCorpList
	 * 작성일 : 2016. 7. 6. 오후 5:22:50
	 * 작성자 : 최영철
	 * @param apicnSVO
	 * @return
	 */
	public Integer getCntCorpList(APICNSVO apicnSVO) {
		return (Integer) select("APICN_S_02", apicnSVO);
	}

	/**
	 * 연계 업체 등록
	 * 파일명 : insertApiCorp
	 * 작성일 : 2016. 7. 11. 오후 5:20:42
	 * 작성자 : 최영철
	 * @param apicnVO
	 */
	public String insertApiCorp(APICNVO apicnVO) {
		return (String) insert("APICN_I_01", apicnVO);
	}

	/**
	 * 연계 업체 단건 조회
	 * 파일명 : selectByApiCorp
	 * 작성일 : 2016. 7. 12. 오전 10:53:18
	 * 작성자 : 최영철
	 * @param apicnVO
	 * @return
	 */
	public APICNVO selectByApiCorp(APICNVO apicnVO) {
		return (APICNVO) select("APICN_S_03", apicnVO);
	}

	/**
	 * 연계 업체 수정
	 * 파일명 : updateApiCorp
	 * 작성일 : 2016. 7. 12. 오후 1:59:43
	 * 작성자 : 최영철
	 * @param apicnVO
	 */
	public void updateApiCorp(APICNVO apicnVO) {
		update("APICN_U_01", apicnVO);
	}

	/**
	 * API 상세 등록
	 * 파일명 : insertApiDtl
	 * 작성일 : 2016. 7. 13. 오전 10:03:37
	 * 작성자 : 최영철
	 * @param apiDtlVO
	 */
	public void insertApiDtl(APIDTLVO apiDtlVO) {
		insert("APIDTL_I_00", apiDtlVO);
	}

	/**
	 * API 상세 리스트 조회
	 * 파일명 : selectApiDtlList
	 * 작성일 : 2016. 7. 13. 오후 1:58:35
	 * 작성자 : 최영철
	 * @param apicnVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<APIDTLVO> selectApiDtlList(APICNVO apicnVO) {
		return (List<APIDTLVO>) list("APIDTL_S_01", apicnVO);
	}

	/**
	 * API 상세 단건 조회
	 * 파일명 : selectByApiDtl
	 * 작성일 : 2016. 7. 18. 오후 5:25:01
	 * 작성자 : 최영철
	 * @param apiDtlVO
	 * @return
	 */
	public APIDTLVO selectByApiDtl(APIDTLVO apiDtlVO) {
		return (APIDTLVO) select("APIDTL_S_00", apiDtlVO);
	}

	/**
	 * API 수정
	 * 파일명 : updateApiDtl
	 * 작성일 : 2016. 7. 19. 오전 9:10:18
	 * 작성자 : 최영철
	 * @param apiDtlVO
	 */
	public void updateApiDtl(APIDTLVO apiDtlVO) {
		update("APIDTL_U_00", apiDtlVO);
	}

	/**
	 * ILS 연계 용
	 * 파일명 : selectIlsList
	 * 작성일 : 2016. 11. 10. 오후 4:35:29
	 * 작성자 : 최영철
	 * @param apiVO
	 * @return 
	 */
	@SuppressWarnings("unchecked")
	public List<ILSDTLVO> selectIlsList(APICNVO apiVO) {
		return (List<ILSDTLVO>) list("API_S_03", apiVO);
	}

}
