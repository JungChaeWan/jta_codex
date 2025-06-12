package oss.corp.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;
import oss.corp.vo.*;
import oss.etc.vo.FILESVO;

public interface OssCorpPnsReqService {

	void insertCorpPnsReq(CORP_PNSREQVO corpPnsReqVO, MultipartHttpServletRequest multiRequest) throws Exception;

	Map<String, Object> selectCorpPnsReqList(CORP_PNSREQSVO corpPnsReqSVO);

	CORP_PNSREQVO selectCorpPnsReq(CORP_PNSREQVO corpPnsReqVO);

	void updateCorpPnsReq(CORP_PNSREQVO corpPnsReqVO, MultipartHttpServletRequest multiRequest) throws Exception;

	void apprCorpPnsReq(CORP_PNSREQVO corpPnsReqVO);

	String saveCorpAccount(CORPVO corpvo);

	List<VISIT_JEJU> selectVisitJeju(VISIT_JEJU visitVO);

	Integer getCntCorpPnsMain(CORP_PNSREQVO corpPnsReqVO);

	List<CORP_PNSREQFILEVO> selectCorpPnsReqFileList(CORP_PNSREQFILEVO corpPnsReqFileVO);

	Map<String, Object> selectFileList(FILESVO fileSVO);

}
