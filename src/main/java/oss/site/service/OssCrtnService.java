package oss.site.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import oss.site.vo.SVCRTNPRDTVO;
import oss.site.vo.SVCRTNVO;

/**
 * 제주특산/기념품 큐레이터 관리
 * 파일명 : OssCrtnService.java
 * 작성일 : 2017. 11. 13. 오후 4:02:55
 * 작성자 : 정동수
 */
public interface OssCrtnService {
	/**
	 * 제주특산/기념품 큐레이션 리스트
	 * Function : selectCrtnList
	 * 작성일 : 2017. 11. 13. 오후 8:55:19
	 * 작성자 : 정동수
	 * @param crtnVO
	 * @return
	 */
	Map<String, Object> selectCrtnList(SVCRTNVO crtnVO);
	
	/**
	 * 제주특산/기념품 큐레이션 메인 리스트
	 * Function : selectCrtnWebList
	 * 작성일 : 2017. 11. 14. 오전 11:57:19
	 * 작성자 : 정동수
	 * @return
	 */
	List<SVCRTNVO> selectCrtnWebList();

	/**
	 * 제주특산/기념품 큐레이션 단건 정보
	 * Function : selectByCrtn
	 * 작성일 : 2017. 11. 13. 오후 8:55:19
	 * 작성자 : 정동수
	 * @param crtnVO
	 * @return
	 */
	SVCRTNVO selectByCrtn(SVCRTNVO crtnVO);
	
	/**
	 * 제주특산/기념품 큐레이션의 포함 상품 리스트
	 * Function : selectCrtnPrdtList
	 * 작성일 : 2017. 11. 13. 오후 8:55:19
	 * 작성자 : 정동수
	 * @param crtnVO
	 * @return
	 */
	List<SVCRTNPRDTVO> selectCrtnPrdtList(SVCRTNVO crtnVO);
	
	/**
	 * 제주특산/기념품 큐레이션 등록
	 * Function : insertCrtn
	 * 작성일 : 2017. 11. 13. 오후 8:55:19
	 * 작성자 : 정동수
	 * @param crtnVO
	 * @param multiRequest
	 * @return
	 * @throws Exception
	 */
	String insertCrtn(SVCRTNVO crtnVO, MultipartHttpServletRequest multiRequest) throws Exception;
	
	/**
	 * 제주특산/기념품 큐레이션 수정
	 * Function : updateCrtn
	 * 작성일 : 2017. 11. 13. 오후 8:55:19
	 * 작성자 : 정동수
	 * @param crtnVO
	 * @param multiRequest
	 * @throws Exception
	 */
	void updateCrtn(SVCRTNVO crtnVO, MultipartHttpServletRequest multiRequest) throws Exception ;
	
	/**
	 * 제주특산/기념품 큐레이션 삭제
	 * Function : deleteCrtn
	 * 작성일 : 2017. 11. 13. 오후 8:55:19
	 * 작성자 : 정동수
	 * @param crtnVO
	 */
	void deleteCrtn(SVCRTNVO crtnVO);
		
	/**
	 * 제주특산/기념품 큐레이션 메인의 큐레이션별 상품 리스트
	 * Function : selectCrtnPrdtWebList
	 * 작성일 : 2017. 11. 14. 오전 11:56:53
	 * 작성자 : 정동수
	 * @return
	 */
	Map<String, List<SVCRTNPRDTVO>> selectCrtnPrdtWebList();
	
	/**
	 * 제주특산/기념품 큐레이션별 상품 등록
	 * Function : insertCrtnPrdtOne
	 * 작성일 : 2017. 11. 14. 오전 11:56:43
	 * 작성자 : 정동수
	 * @param crtnVO
	 */
	void insertCrtnPrdtOne(SVCRTNVO crtnVO);
	
	/**
	 * 제주특산/기념품 큐레이션별 상품 출력 순번 수정
	 * Function : updatePrmtPrdtSort
	 * 작성일 : 2017. 11. 14. 오전 11:56:59
	 * 작성자 : 정동수
	 * @param crtnPrdtVO
	 */
	void updatePrmtPrdtSort(SVCRTNPRDTVO crtnPrdtVO);
	
	/**
	 * 제주특산/기념품 큐레이션별 상품 삭제
	 * Function : deleteCrtnPrdt
	 * 작성일 : 2017. 11. 14. 오전 11:57:02
	 * 작성자 : 정동수
	 * @param prmtNum
	 */
	void deleteCrtnPrdt(String prmtNum);
}
