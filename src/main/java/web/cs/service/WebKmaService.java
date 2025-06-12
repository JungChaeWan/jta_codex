package web.cs.service;

import java.util.List;

import egovframework.cmmn.vo.KMAGRIBVO;
import egovframework.cmmn.vo.KMAMLWVO;

public interface WebKmaService {

	/**
	 * 기상청 실황
	 * 파일명 : selectKmaGribList
	 * 작성일 : 2016. 11. 21. 오후 3:08:08
	 * 작성자 : 최영철
	 * @return
	 */
	List<KMAGRIBVO> selectKmaGribList();

	/**
	 * 중기예보 날씨
	 * 파일명 : selectKmaMlwWfList
	 * 작성일 : 2016. 11. 22. 오전 10:18:23
	 * 작성자 : 최영철
	 * @return
	 */
	List<KMAMLWVO> selectKmaMlwWfList();

	/**
	 * 중기예보 온도
	 * 파일명 : selectKmaMlwTaList
	 * 작성일 : 2016. 11. 22. 오전 10:23:11
	 * 작성자 : 최영철
	 * @return
	 */
	List<KMAMLWVO> selectKmaMlwTaList();

}
