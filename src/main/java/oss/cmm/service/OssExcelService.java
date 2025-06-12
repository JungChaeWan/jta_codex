package oss.cmm.service;

import java.util.Map;

import mas.sp.vo.SP_OPTINFVO;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import web.order.vo.AV_RSVVO;

public interface OssExcelService {

	/**
	 * 항공 예약의 Excel 파일 업로드
	 * Function : uploadAvRsvExcel
	 * 작성일 : 2016. 8. 30. 오전 11:22:45
	 * 작성자 : 정동수
	 * @param avRsvVO
	 * @param multiRequest
	 */
	void uploadAvRsvExcel(AV_RSVVO avRsvVO, MultipartHttpServletRequest multiRequest) throws Exception;
}
