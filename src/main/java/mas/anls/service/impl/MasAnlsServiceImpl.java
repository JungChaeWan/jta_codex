package mas.anls.service.impl;

import java.util.List;

import javax.annotation.Resource;

import mas.anls.service.MasAnlsService;
import mas.anls.vo.ANLSOPTVO;
import mas.anls.vo.ANLSSVO;
import mas.anls.vo.ANLSVO;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("masAnlsService")
public class MasAnlsServiceImpl extends EgovAbstractServiceImpl implements MasAnlsService {

//	private static final Logger LOGGER = LoggerFactory.getLogger(MasRcPrdtServiceImpl.class);

	@Resource(name = "masAnlsDAO")
	private MasAnlsDAO masAnlsDAO;
	
	/**
	 * 숙박 날짜 누적 통계
	 * 파일명 : selectAdAnls01
	 * 작성일 : 2015. 12. 14. 오후 8:38:13
	 * 작성자 : 최영철
	 * @param adAnlsSVO
	 * @return
	 */
	@Override
	public List<ANLSVO> selectAdAnls01(ANLSSVO anlsSVO){
		return masAnlsDAO.selectAdAnls01(anlsSVO);
	}
	
	/**
	 * 렌터카 상품별 누적 통계
	 * 파일명 : selectRcAnls01
	 * 작성일 : 2015. 12. 14. 오후 10:08:51
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	@Override
	public List<ANLSVO> selectRcAnls01(ANLSSVO anlsSVO){
		return masAnlsDAO.selectRcAnls01(anlsSVO);
	}

	/**
	 * 소셜상품 상품별 누적 통계
	 * 파일명 : selectSpAnls01
	 * 작성일 : 2015. 12. 14. 오후 10:59:57
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	@Override
	public List<ANLSVO> selectSpAnls01(ANLSSVO anlsSVO){
		return masAnlsDAO.seelctSpAnls01(anlsSVO);
	}
	
	/**
	 * 숙박 연도별 매출 통계
	 * 파일명 : selectAdAnls02
	 * 작성일 : 2015. 12. 16. 오후 1:14:43
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	@Override
	public List<ANLSVO> selectAdAnls02(ANLSSVO anlsSVO){
		return masAnlsDAO.selectAdAnls02(anlsSVO);
	}
	
	/**
	 * 렌터카 연도별 매출 통계
	 * 파일명 : selectRcAnls02
	 * 작성일 : 2015. 12. 16. 오후 1:14:43
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	@Override
	public List<ANLSVO> selectRcAnls02(ANLSSVO anlsSVO){
		return masAnlsDAO.selectRcAnls02(anlsSVO);
	}

	
	/**
	 * 소셜 연도별 매출 통계
	 * 파일명 : selectSpAnls02
	 * 작성일 : 2015. 12. 16. 오후 1:14:43
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	@Override
	public List<ANLSVO> selectSpAnls02(ANLSSVO anlsSVO){
		return masAnlsDAO.selectSpAnls02(anlsSVO);
	}
	
	@Override
	public List<ANLSVO> selectSvAnls02(ANLSSVO anlsSVO){
		return masAnlsDAO.selectSvAnls02(anlsSVO);
	}
	
	/**
	 * 숙박 월별 매출 통계
	 * 파일명 : selectAdAnls02Dtl
	 * 작성일 : 2015. 12. 16. 오후 4:22:49
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	@Override
	public List<ANLSVO> selectAdAnls02Dtl(ANLSSVO anlsSVO){
		return masAnlsDAO.selectAdAnls02Dtl(anlsSVO);
	}
	
	/**
	 * 렌터카 월별 매출 통계
	 * 파일명 : selectRcAnls02Dtl
	 * 작성일 : 2015. 12. 16. 오후 4:22:49
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	@Override
	public List<ANLSVO> selectRcAnls02Dtl(ANLSSVO anlsSVO){
		return masAnlsDAO.selectRcAnls02Dtl(anlsSVO);
	}

	/**
	 * 소셜 월별 매출 통계
	 * 파일명 : selectSpAnls02Dtl
	 * 작성일 : 2015. 12. 16. 오후 4:22:49
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	@Override
	public List<ANLSVO> selectSpAnls02Dtl(ANLSSVO anlsSVO){
		return masAnlsDAO.selectSpAnls02Dtl(anlsSVO);
	}

	/**
	 * 소셜 월별 옵션 매출 통계
	 * 파일명 : selectSpAnls02Opt
	 * 작성일 : 2015. 12. 16. 오후 4:22:49
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	@Override
	public List<ANLSOPTVO> selectSpAnls02Opt(ANLSSVO anlsSVO) {
		return masAnlsDAO.selectSpAnls02Opt(anlsSVO);
	}
}
