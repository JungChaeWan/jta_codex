package oss.marketing.serive.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import oss.marketing.vo.SMSEMAILWORDSVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("smsEmailWordsDAO")
public class SmsEmailWordsDAO extends EgovAbstractDAO {
	public SMSEMAILWORDSVO selectByWords(SMSEMAILWORDSVO smsEmailWordsVO) {
		return (SMSEMAILWORDSVO) select("WORDS_S_00", smsEmailWordsVO);
	}
	
	@SuppressWarnings("unchecked")
	public List<SMSEMAILWORDSVO> selectWordsList(SMSEMAILWORDSVO smsEmailWordsVO) {
		return (List<SMSEMAILWORDSVO>) list("WORDS_S_01", smsEmailWordsVO);
	}

	public int selectWordsListCnt(SMSEMAILWORDSVO smsEmailWordsVO) {
		return (Integer) select("WORDS_S_02", smsEmailWordsVO);
	}

	public void insertWords(SMSEMAILWORDSVO smsEmailWordsVO) {
		insert("WORDS_I_00", smsEmailWordsVO);
	}

	public void updateWords(SMSEMAILWORDSVO smsEmailWordsVO) {
		update("WORDS_U_00", smsEmailWordsVO);
	}

	public void deleteWords(SMSEMAILWORDSVO smsEmailWordsVO) {
		delete("WORDS_D_00", smsEmailWordsVO);
	}
}
