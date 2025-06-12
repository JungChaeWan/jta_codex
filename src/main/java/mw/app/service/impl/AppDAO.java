package mw.app.service.impl;

import java.util.List;

import mw.app.vo.DEVICEINFVO;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("appDAO")
public class AppDAO extends EgovAbstractDAO{

	/**
	 * 앱 디바이스 정보 등록 / 수정
	 * 파일명 : mergeDeviceInf
	 * 작성일 : 2015. 12. 30. 오후 2:10:52
	 * 작성자 : 최영철
	 * @param deviceinfVO
	 */
	public void mergeDeviceInf(DEVICEINFVO deviceinfVO) {
		update("DEVICEINF_M_00", deviceinfVO);
	}

	/**
	 * 디바이스 정보 조회
	 * 파일명 : selectDeviceInfo
	 * 작성일 : 2016. 1. 25. 오후 3:36:43
	 * 작성자 : 최영철
	 * @param deviceInfo
	 * @return
	 */
	public DEVICEINFVO selectDeviceInfo(DEVICEINFVO deviceInfo) {
		return (DEVICEINFVO) select("DEVICEINF_S_01", deviceInfo);
	}

	/**
	 * 푸쉬 여부 변경
	 * 파일명 : updateDevicePush
	 * 작성일 : 2016. 1. 25. 오후 3:46:34
	 * 작성자 : 최영철
	 * @param deviceInfo
	 */
	public void updateDevicePush(DEVICEINFVO deviceInfo) {
		update("DEVICEINF_U_01", deviceInfo);
	}

	/**
	 * 디바이스 전체 목록 조회
	 * 파일명 : selectDeviceAllList
	 * 작성일 : 2016. 1. 25. 오후 5:55:29
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<DEVICEINFVO> selectDeviceAllList() {
		return (List<DEVICEINFVO>) list("DEVICEINF_S_00", "");
	}

}
