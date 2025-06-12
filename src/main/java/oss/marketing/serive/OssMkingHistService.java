package oss.marketing.serive;

import java.util.List;
import java.util.Map;

import mas.prmt.vo.PRMTPRDTVO;
import oss.marketing.vo.KWAPRDTVO;
import oss.marketing.vo.KWASVO;
import oss.marketing.vo.KWAVO;
import oss.marketing.vo.MKINGHISTVO;

public interface OssMkingHistService {

	Map<String, Object> selectMkingHistList(MKINGHISTVO mkinghistVO);

	MKINGHISTVO selectMkingHist(MKINGHISTVO mkinghistVO);

	MKINGHISTVO getMkingHistSale(MKINGHISTVO mkinghistVO);

	void insertMkingHist(MKINGHISTVO mkinghistVO);

	void updateMkingHist(MKINGHISTVO mkinghistVO);

	void deleteMkingHist(MKINGHISTVO mkinghistVO);
}
