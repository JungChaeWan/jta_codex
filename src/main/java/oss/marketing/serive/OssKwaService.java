package oss.marketing.serive;

import java.util.List;
import java.util.Map;

import oss.marketing.vo.KWAPRDTVO;
import oss.marketing.vo.KWASVO;
import oss.marketing.vo.KWAVO;

public interface OssKwaService {

	Map<String, Object> selectKwaList(KWASVO kwaSVO);
	
	Map<String, Object> selectKwaListFind(KWASVO kwaSVO);

	//List<KWAVO> selectKawList(KWAVO kwaVO);
	//int selectKawListCnt(KWAVO kwaVO);

	KWAVO selectKwa(KWAVO kwaVO);

	String insertKwa(KWAVO kwaVO);

	void updateKwa(KWAVO kwaVO);

	void deleteKwa(KWAVO kwaVO);

	//사용자 페이지
	List<KWAVO> selectKwaWebList(KWASVO kwaSVO);
	
	//사용자 각 메인 페이지
	List<KWAVO> selectKwaWebPrdtList(KWASVO kwaSVO);


	List<KWAPRDTVO> selectKawPrdtList(KWAPRDTVO kwaprdtVO);

	void insertKawPrdt(KWAPRDTVO kwaprdtVO);

	void updateKawPrdtSort(KWAPRDTVO kwaprdtVO);

	void deleteKawPrdtAll(String kwaNum);

}
