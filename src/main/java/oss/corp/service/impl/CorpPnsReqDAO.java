package oss.corp.service.impl;

import java.util.List;

import mas.prmt.vo.PRMTVO;
import org.springframework.stereotype.Repository;

import oss.corp.vo.CORPVO;
import oss.corp.vo.CORP_PNSREQFILEVO;
import oss.corp.vo.CORP_PNSREQSVO;
import oss.corp.vo.CORP_PNSREQVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import oss.etc.vo.FILESVO;
import oss.prmt.vo.PRMTFILEVO;

@Repository("corpPnsReqDAO")
public class CorpPnsReqDAO extends EgovAbstractDAO {

	public void insertCorpPnsReq(CORP_PNSREQVO corpPnsReqVO) {
		insert("CORP_PNSREQ_I_00", corpPnsReqVO);
	}

	@SuppressWarnings("unchecked")
	public List<CORP_PNSREQVO> selectCorpPnsReqList(CORP_PNSREQSVO corpPnsReqSVO) {
		return (List<CORP_PNSREQVO>) list("CORP_PNSREQ_S_00", corpPnsReqSVO);
	}

	public Integer getCntCorpPnsReqList(CORP_PNSREQSVO corpPnsReqSVO) {
		return (Integer) select("CORP_PNSREQ_S_01", corpPnsReqSVO);
	}

	public CORP_PNSREQVO selectCorpPnsReq(CORP_PNSREQVO corpPnsReqVO) {
		return (CORP_PNSREQVO) select("CORP_PNSREQ_S_02", corpPnsReqVO);
	}

	public void updateCorpPnsReq(CORP_PNSREQVO corpPnsReqVO) {
		update("CORP_PNSREQ_U_02", corpPnsReqVO);
	}

	public void apprCorpPnsReq(CORP_PNSREQVO corpPnsReqVO) {
		update("CORP_PNSREQ_U_00", corpPnsReqVO);
	}

	public String insertCorp(CORPVO corpVO) {
		return (String) insert("CORP_I_01", corpVO);
	}

	public void updateConfCorpId(CORP_PNSREQVO corpPnsReqVO) {
		update("CORP_PNSREQ_U_01", corpPnsReqVO);
	}
	
	public Integer getCntCorpPnsMain(CORP_PNSREQVO corpPnsReqVO) {
		return (Integer) select("CORP_PNSREQ_S_03", corpPnsReqVO);
	}

	public String getCorpPnsReqPk() {
		return (String) select("CORP_PNSREQ_S_04");
	}

	// 입점신청 파일 목록 조회
	public List<CORP_PNSREQFILEVO> selectCorpPnsReqFileList(CORP_PNSREQFILEVO corpPnsReqFileVO) {
		return (List<CORP_PNSREQFILEVO>) list("CORP_PNSREQFILE_S_00", corpPnsReqFileVO);
	}

	public CORP_PNSREQFILEVO selectCorpPnsReqFile(CORP_PNSREQFILEVO corpPnsReqFileVO) {
		return (CORP_PNSREQFILEVO) select("CORP_PNSREQFILE_S_00", corpPnsReqFileVO);
	}

	public List<FILESVO> selectFileList(FILESVO fileSVO) {
		return (List<FILESVO>) list("CORP_PNSREQFILE_S_01", fileSVO);
	}

	public Integer selectFileListCnt(FILESVO fileSVO) {
		return (Integer) select("CORP_PNSREQFILE_S_02", fileSVO);
	}

	// 입점신청 파일 추가
	public void insertCorpPnsReqFile(CORP_PNSREQFILEVO corpPnsreqfilevo) {
		insert("CORP_PNSREQFILE_I_00", corpPnsreqfilevo);
	}

	// 입점신청 파일 수정
	public void updateCorpPnsReqFile(CORP_PNSREQFILEVO corpPnsreqfilevo) {
		update("CORP_PNSREQFILE_U_00", corpPnsreqfilevo);
	}

	// 입점신청 파일 삭제
	public void deleteCorpPnsReqFile(CORP_PNSREQFILEVO corpPnsReqFileVO) {
		delete("CORP_PNSREQFILE_D_00", corpPnsReqFileVO);
	}

}
