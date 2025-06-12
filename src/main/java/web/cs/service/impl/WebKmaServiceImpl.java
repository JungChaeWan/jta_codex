package web.cs.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.cmmn.service.impl.ScheduleDAO;
import egovframework.cmmn.vo.KMAGRIBVO;
import egovframework.cmmn.vo.KMAMLWVO;
import web.cs.service.WebKmaService;

@Service("webKmaService")
public class WebKmaServiceImpl implements WebKmaService{

	@Resource(name="scheduleDAO")
	private ScheduleDAO scheduleDAO;
	
	/**
	 * 기상청 실황
	 * 파일명 : selectKmaGribList
	 * 작성일 : 2016. 11. 21. 오후 3:08:08
	 * 작성자 : 최영철
	 * @return
	 */
	@Override
	public List<KMAGRIBVO> selectKmaGribList(){
		return scheduleDAO.selectKmaGribList();
	}
	
	/**
	 * 중기예보 날씨
	 * 파일명 : selectKmaMlwWfList
	 * 작성일 : 2016. 11. 22. 오전 10:18:23
	 * 작성자 : 최영철
	 * @return
	 */
	@Override
	public List<KMAMLWVO> selectKmaMlwWfList(){
		return scheduleDAO.selectKmaMlwWfList();
	}
	
	/**
	 * 중기예보 온도
	 * 파일명 : selectKmaMlwTaList
	 * 작성일 : 2016. 11. 22. 오전 10:23:11
	 * 작성자 : 최영철
	 * @return
	 */
	@Override
	public List<KMAMLWVO> selectKmaMlwTaList(){
		return scheduleDAO.selectKmaMlwTaList();
	}
}
