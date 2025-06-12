package oss.etc.service;

import java.util.Map;

import web.etc.vo.SCCSVO;
import web.etc.vo.SCCVO;

public interface OssEtcService {

	/**
	 * 홍보영상 리스트 조회
	 * 파일명 : selectSccList
	 * 작성일 : 2017. 3. 3. 오후 3:46:08
	 * 작성자 : 최영철
	 * @param sccSVO
	 * @return
	 */
	Map<String, Object> selectSccList(SCCSVO sccSVO);

	/**
	 * 홍보영상 등록
	 * 파일명 : insertScc
	 * 작성일 : 2017. 3. 6. 오전 11:30:25
	 * 작성자 : 최영철
	 * @param sccVO
	 */
	void insertScc(SCCVO sccVO);

	/**
	 * 홍보영상 단건 조회
	 * 파일명 : selectByScc
	 * 작성일 : 2017. 3. 6. 오후 3:55:23
	 * 작성자 : 최영철
	 * @param sccVO
	 * @return
	 */
	SCCVO selectByScc(SCCVO sccVO);

	/**
	 * 홍보영상 삭제
	 * 파일명 : deleteScc
	 * 작성일 : 2017. 3. 6. 오후 4:39:05
	 * 작성자 : 최영철
	 * @param sccVO
	 */
	void deleteScc(SCCVO sccVO);

	/**
	 * 홍보영상 수정
	 * 파일명 : updateScc
	 * 작성일 : 2017. 3. 6. 오후 5:39:16
	 * 작성자 : 최영철
	 * @param sccVO
	 */
	void updateScc(SCCVO sccVO);

}
