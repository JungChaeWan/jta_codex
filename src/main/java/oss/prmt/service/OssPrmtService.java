package oss.prmt.service;

import java.util.Map;

import mas.prmt.vo.PRMTVO;
import oss.prmt.vo.PRMTSVO;

public interface OssPrmtService {

	Map<String, Object> selectOssPrmtList(PRMTSVO prmtSVO);

	void updatePrmtAppr(PRMTVO prmtVO);

}
