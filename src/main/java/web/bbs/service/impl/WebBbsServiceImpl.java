package web.bbs.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import oss.etc.vo.FILESVO;
import web.bbs.service.WebBbsService;
import web.bbs.vo.NOTICECMTVO;
import web.bbs.vo.NOTICEFILEVO;
import web.bbs.vo.NOTICESVO;
import web.bbs.vo.NOTICEVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("webBbsService")
public class WebBbsServiceImpl extends EgovAbstractServiceImpl implements WebBbsService {

	@SuppressWarnings("unused")
	private static final Logger LOGGER = LoggerFactory.getLogger(WebBbsServiceImpl.class);
	
	@Resource(name = "webBbsDAO")
	private WebBbsDAO webBbsDAO;
	
	@Override
	public NOTICEVO selectNotice(NOTICEVO notiVO) {
		return webBbsDAO.selectNotice(notiVO);
	}


	@Override
	public Map<String, Object> selectList(NOTICESVO notiSVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<NOTICEVO> resultList = webBbsDAO.selectList(notiSVO);
		Integer totalCnt = webBbsDAO.getCntList(notiSVO);
		
		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);
		
		return resultMap;
	}
	
	@Override
	public List<NOTICEVO> selectListMain(NOTICESVO notiSVO) {
		return webBbsDAO.selectListMain(notiSVO);
	}


	@Override
	public List<NOTICEVO> selectNoticeList(NOTICEVO noticeVO) {
		return webBbsDAO.selectNoticeList(noticeVO);
	}


	@Override
	public String insertNotice(NOTICEVO notiVO) {
		String strNoticeNum = "" + webBbsDAO.getNewNoticeNum(notiVO);
		
		notiVO.setNoticeNum(strNoticeNum);
		webBbsDAO.inserNotice(notiVO);
		
		return strNoticeNum;
	}


	@Override
	public String insertNoticeRe(NOTICEVO notiVO) {
		String strNoticeNum = "" + webBbsDAO.getNewNoticeNum(notiVO);
		
		notiVO.setNoticeNum(strNoticeNum);
		webBbsDAO.inserNoticeRe(notiVO);
		
		return strNoticeNum;
	}
	
	@Override
	public void updateNotice(NOTICEVO notiVO) {
		webBbsDAO.updateNotice(notiVO);
		
	}

	
	@Override
	public void deleteNotice(NOTICEVO notiVO) {
		webBbsDAO.deleteNotice(notiVO);
	}

	
	@Override
	public NOTICEFILEVO selectNoticeFile(NOTICEFILEVO notiFileVO) {
		return webBbsDAO.selectNoticeFile(notiFileVO);
	}
	

	@Override
	public List<NOTICEFILEVO> selectNoticeFileList(NOTICEFILEVO notiFileVO) {
		return webBbsDAO.selectNoticeFileList(notiFileVO);
	}

	@Override
	public void updateNoticeDwldCntAdd(NOTICEFILEVO notiFileVO){
		webBbsDAO.updateNoticeDwldCntAdd(notiFileVO);
	}


	@Override
	public Integer getCnthrkNoticeNum(NOTICEVO notiVO) {
		return webBbsDAO.getCnthrkNoticeNum(notiVO);
	}


	@Override
	public List<NOTICECMTVO> selectCmtList(NOTICECMTVO noticeCmtVO) {
		return webBbsDAO.selectCmtList(noticeCmtVO);
	}


	@Override
	public void inserCmt(NOTICECMTVO notiCmtVO) {
		//추가
		webBbsDAO.inserCmt(notiCmtVO);
		
		//댓글 수 다시 계산
		NOTICEVO notiVO = new NOTICEVO();
		notiVO.setBbsNum(notiCmtVO.getBbsNum());
		notiVO.setNoticeNum(notiCmtVO.getNoticeNum());
		notiVO.setAdmCmtYn(notiCmtVO.getAdmCmtYn()); // 관리자일 경우 관리자_댓글_여부 컬럼 update 추가 20.05.18 (김지연)
		
		webBbsDAO.updateNoticeCmtCnt(notiVO);
	}

	@Override
	public void deleteCmt(NOTICECMTVO notiCmtVO) {
		webBbsDAO.deleteCmt(notiCmtVO);
		
		//댓글 수 다시 계산
		NOTICEVO notiVO = new NOTICEVO();
		notiVO.setBbsNum(notiCmtVO.getBbsNum());
		notiVO.setNoticeNum(notiCmtVO.getNoticeNum());
		webBbsDAO.updateNoticeCmtCnt(notiVO);
	}


	@Override
	public void updateCmt(NOTICECMTVO notiCmtVO) {
		webBbsDAO.updateCmt(notiCmtVO);
	}

	@Override
	public Map<String, Object> selectFileList(FILESVO fileSVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<FILESVO> resultList = webBbsDAO.selectFileList(fileSVO);

		Integer totalCnt = webBbsDAO.selectFileListCnt(fileSVO);

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);

		return resultMap;
	}
	
	// 디자인 요청 건 메뉴 현황 추가 20.05.18(김지연)
	@Override
	public Integer getCntAdmCmtYn(NOTICEVO notiVO) {
		return webBbsDAO.getCntAdmCmtYn(notiVO);
	}	

}
