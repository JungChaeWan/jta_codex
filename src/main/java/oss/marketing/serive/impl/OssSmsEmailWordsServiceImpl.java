package oss.marketing.serive.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import oss.marketing.serive.OssSmsEmailWordsService;
import oss.marketing.vo.SMSEMAILWORDSVO;

@Service("ossSmsEmailWordsService")
public class OssSmsEmailWordsServiceImpl implements OssSmsEmailWordsService {
	
	@Resource(name = "smsEmailWordsDAO")
	private SmsEmailWordsDAO smsEmailWordsDAO;

	@Override
	public Map<String, Object> selectWordsList(SMSEMAILWORDSVO smsEmailWordsVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("resultList", smsEmailWordsDAO.selectWordsList(smsEmailWordsVO));
		resultMap.put("totalCnt", smsEmailWordsDAO.selectWordsListCnt(smsEmailWordsVO));
		
		return resultMap;
	}

	@Override
	public SMSEMAILWORDSVO selectByWords(SMSEMAILWORDSVO smsEmailWordsVO) {
		return smsEmailWordsDAO.selectByWords(smsEmailWordsVO);
	}

	@Override
	public void insertWords(SMSEMAILWORDSVO smsEmailWordsVO) {		
		smsEmailWordsDAO.insertWords(smsEmailWordsVO);
	}

	@Override
	public void updateWords(SMSEMAILWORDSVO smsEmailWordsVO) {
		smsEmailWordsDAO.updateWords(smsEmailWordsVO);
		
	}

	@Override
	public void deleteWords(SMSEMAILWORDSVO smsEmailWordsVO) {
		smsEmailWordsDAO.deleteWords(smsEmailWordsVO);
		
	}

}
