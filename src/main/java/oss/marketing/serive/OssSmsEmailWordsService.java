package oss.marketing.serive;

import java.util.Map;

import oss.marketing.vo.SMSEMAILWORDSVO;

public interface OssSmsEmailWordsService {
	Map<String, Object> selectWordsList(SMSEMAILWORDSVO smsEmailWordsVO);

	SMSEMAILWORDSVO selectByWords(SMSEMAILWORDSVO smsEmailWordsVO);

	void insertWords(SMSEMAILWORDSVO smsEmailWordsVO);

	void updateWords(SMSEMAILWORDSVO smsEmailWordsVO);

	void deleteWords(SMSEMAILWORDSVO smsEmailWordsVO);
}
