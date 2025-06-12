/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package egovframework.cmmn.service.impl;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;


/**
 * ALLIM TALK 관련 DAO
 * 
 * @author 최영철
 * @since  2018. 11. 12.
 * << 개정이력(Modification Information) >>
 *
 *  수정일		수정자		수정내용
 *  -------    	--------    ---------------------------
 */
@SuppressWarnings("deprecation")
@Repository("AllimDAO")
public class AllimDAO extends SqlMapClientDaoSupport{
	@Resource(name="allimSqlMapClient")
	public void setSuperSqlMapClient(SqlMapClient sqlMapClient){
		super.setSqlMapClient(sqlMapClient);
	}

	/**
	 * 인증번호 템플릿
	 * 파일명 : sendTemplet10001
	 * 작성일 : 2018. 11. 12. 오후 4:10:28
	 * 작성자 : 최영철
	 * @param paramMap
	 */
	public void sendTemplet10001(Map<String, Object> paramMap) {
		getSqlMapClientTemplate().insert("ALLIM_I_10001", paramMap);
	}

	/**
	 * 10003 발송완료(특산품)
	 * 파일명 : sendTemplet10003
	 * 작성일 : 2018. 11. 12. 오후 4:10:16
	 * 작성자 : 최영철
	 * @param paramMap
	 */
	public void sendTemplet10003(Map<String, Object> paramMap) {
		getSqlMapClientTemplate().insert("ALLIM_I_10003", paramMap);
	}
	
	/**
	 * 10005 구매완료(특산품)
	 * 파일명 : sendTemplet10005
	 * 작성일 : 2018. 11. 12. 오후 4:10:16
	 * 작성자 : 최영철
	 * @param paramMap
	 */
	public void sendTemplet10005(Map<String, Object> paramMap) {
		getSqlMapClientTemplate().insert("ALLIM_I_10005", paramMap);
	}
}
