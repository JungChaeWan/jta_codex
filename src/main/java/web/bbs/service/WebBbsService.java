package web.bbs.service;

import java.util.List;
import java.util.Map;

import oss.etc.vo.FILESVO;
import web.bbs.vo.NOTICECMTVO;
import web.bbs.vo.NOTICEFILEVO;
import web.bbs.vo.NOTICESVO;
import web.bbs.vo.NOTICEVO;




public interface WebBbsService {
	


	NOTICEVO selectNotice(NOTICEVO notiVO);
	Map<String, Object> selectList(NOTICESVO notiSVO);
	List<NOTICEVO> selectListMain(NOTICESVO notiSVO);
	List<NOTICEVO> selectNoticeList(NOTICEVO noticeVO);
	String insertNotice(NOTICEVO notiVO);
	String insertNoticeRe(NOTICEVO notiVO);
	void updateNotice(NOTICEVO notiVO);
	void deleteNotice(NOTICEVO notiVO);
	Integer getCnthrkNoticeNum(NOTICEVO notiVO);
	Integer getCntAdmCmtYn(NOTICEVO notiVO);

	
	NOTICEFILEVO selectNoticeFile(NOTICEFILEVO notiFileVO);
	List<NOTICEFILEVO> selectNoticeFileList(NOTICEFILEVO notiFileVO);
	void updateNoticeDwldCntAdd(NOTICEFILEVO notiFileVO);
	
	List<NOTICECMTVO> selectCmtList(NOTICECMTVO noticeCmtVO);
	void inserCmt(NOTICECMTVO  notiCmtVO);
	void updateCmt(NOTICECMTVO notiCmtVO);
	void deleteCmt(NOTICECMTVO notiCmtVO);

	Map<String, Object> selectFileList(FILESVO fileSVO);
}
