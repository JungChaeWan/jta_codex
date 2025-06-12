package oss.marketing.serive;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import oss.marketing.vo.ADMRCMDVO;

public interface OssAdmRcmdService {
	Map<String, Object> selectMdsPickList(ADMRCMDVO admRcmdVO);
	Map<String, Object> selectMdsPickListFind(ADMRCMDVO admRcmdVO);
	Map<String, Object> selectMdsPickWebList(ADMRCMDVO admRcmdVO);
	ADMRCMDVO selectMdsPickInfo(ADMRCMDVO admRcmdVO);
	ADMRCMDVO selectMdsPickWebInfo(ADMRCMDVO admRcmdVO);
	List<ADMRCMDVO> selectMdsPickWebPrdtList(ADMRCMDVO admRcmdVO);
	List<ADMRCMDVO> selectAdmRcmdWebSlideList(ADMRCMDVO admRcmdVO);
	List<ADMRCMDVO> selectAdmRcmdWebRandomList(ADMRCMDVO admRcmdVO);
	void insertMdsPick(ADMRCMDVO admRcmdVO, MultipartHttpServletRequest multiRequest) throws Exception;
	void updateMdsPick(ADMRCMDVO admRcmdVO, MultipartHttpServletRequest multiRequest) throws Exception;
	void deleteMdsPick(ADMRCMDVO admRcmdVO);
	
}
