package web.bbs.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import oss.etc.vo.FILESVO;
import web.bbs.vo.NOTICECMTVO;
import web.bbs.vo.NOTICEFILEVO;
import web.bbs.vo.NOTICESVO;
import web.bbs.vo.NOTICEVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("webBbsDAO")
public class WebBbsDAO extends EgovAbstractDAO {


	public NOTICEVO selectNotice(NOTICEVO notiVO) {
		return (NOTICEVO) select("NOTICE_S_00", notiVO);
	}
	
	@SuppressWarnings("unchecked")
	public List<NOTICEVO> selectList(NOTICESVO notiSVO) {
		return (List<NOTICEVO>) list("NOTICE_S_01", notiSVO);
	}
	
	public Integer getCntList(NOTICESVO notiSVO) {
		return (Integer) select("NOTICE_S_02", notiSVO);
	}
	
	
	public Integer getNewNoticeNum(NOTICESVO notiSVO) {
		return (Integer) select("NOTICE_S_03", notiSVO);
	}
	
	public Integer getCnthrkNoticeNum(NOTICESVO notiSVO) {
		return (Integer) select("NOTICE_S_05", notiSVO);
	}
	
	public Integer getCntAdmCmtYn(NOTICESVO notiSVO) {
		return (Integer) select("NOTICE_S_07", notiSVO);
	}	
	
	@SuppressWarnings("unchecked")
	public List<NOTICEVO> selectListMain(NOTICESVO notiSVO) {
		return (List<NOTICEVO>) list("NOTICE_S_04", notiSVO);
	}

	public List<NOTICEVO> selectNoticeList(NOTICEVO noticeVO) {
		return (List<NOTICEVO>) list("NOTICE_S_06", noticeVO);
	}
	
	public void inserNotice(NOTICEVO  notiVO) {
		insert("NOTICE_I_00", notiVO);
	}
	
	public void inserNoticeRe(NOTICEVO  notiVO) {
		insert("NOTICE_I_01", notiVO);
	}
	
	public void updateNotice(NOTICEVO  notiVO) {
		update("NOTICE_U_00", notiVO);
	}
	
	public void updateNoticeCmtCnt(NOTICEVO  notiVO) {
		update("NOTICE_U_01", notiVO);
	}
	
	public void deleteNotice(NOTICEVO notiVO) {
		delete("NOTICE_D_00", notiVO);
	}
	
	public NOTICEFILEVO selectNoticeFile(NOTICEFILEVO notiFileVO) {
		return (NOTICEFILEVO) select("NOTICEFILE_S_00", notiFileVO);
	}
	
	@SuppressWarnings("unchecked")
	public List<NOTICEFILEVO> selectNoticeFileList(NOTICEFILEVO notiFileVO) {
		return (List<NOTICEFILEVO>) list("NOTICEFILE_S_01", notiFileVO);
	}
	
	public void inserNoticeFile(NOTICEFILEVO notiFileVO) {
		insert("NOTICEFILE_I_00", notiFileVO);
	}
	
	public void updateNoticeDwldCntAdd(NOTICEFILEVO notiFileVO) {
		update("NOTICEFILE_U_02", notiFileVO);
	}
	
	public void deleteNoticeFileOne(NOTICEFILEVO notiFileVO) {
		delete("NOTICEFILE_D_00", notiFileVO);
	}
	
	public void deleteNoticeFile(NOTICEFILEVO notiFileVO) {
		delete("NOTICEFILE_D_01", notiFileVO);
	}
	
	
	@SuppressWarnings("unchecked")
	public List<NOTICECMTVO> selectCmtList(NOTICECMTVO noticeCmtVO) {
		return (List<NOTICECMTVO>) list("NOTICECMT_S_01", noticeCmtVO);
	}
	
	public void inserCmt(NOTICECMTVO notiCmtVO) {
		insert("NOTICECMT_I_00", notiCmtVO);
	}
	
	public void updateCmt(NOTICECMTVO notiCmtVO) {
		update("NOTICECMT_U_00", notiCmtVO);
	}
	
	public void deleteCmt(NOTICECMTVO notiCmtVO) {
		delete("NOTICECMT_D_00", notiCmtVO);
	}


	public List<FILESVO> selectFileList(FILESVO fileSVO) {
		return (List<FILESVO>) list("NOTICEFILE_S_02", fileSVO);
	}

	public Integer selectFileListCnt(FILESVO fileSVO) {
		return (Integer) select("NOTICEFILE_S_03", fileSVO);
	}

}
