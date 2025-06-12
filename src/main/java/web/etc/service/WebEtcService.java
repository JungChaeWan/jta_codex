package web.etc.service;

import java.util.Map;

import web.etc.vo.SCCSVO;

public interface WebEtcService {

	/**
	 * 홍보영상 리스트
	 * 파일명 : selectSccList
	 * 작성일 : 2017. 3. 7. 오전 9:46:53
	 * 작성자 : 최영철
	 * @param sccSVO
	 * @return
	 */
	Map<String, Object> selectSccList(SCCSVO sccSVO);

}
