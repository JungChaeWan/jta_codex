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

import javax.annotation.Resource;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

import egovframework.cmmn.vo.MMSVO;
import egovframework.cmmn.vo.SMSVO;


/**
 * SMS 관련 DAO
 * 
 * @author 최영철
 * @since  2014. 9. 15.
 * << 개정이력(Modification Information) >>
 *
 *  수정일		수정자		수정내용
 *  -------    	--------    ---------------------------
 */
@SuppressWarnings("deprecation")
@Repository("SmsDAO")
public class SmsDAO extends SqlMapClientDaoSupport{
	@Resource(name="smsSqlMapClient")
	public void setSuperSqlMapClient(SqlMapClient sqlMapClient){
		super.setSqlMapClient(sqlMapClient);
	}

	public void sendSMS(SMSVO smsVO) {
		getSqlMapClientTemplate().insert("SC_TRAN_I_00", smsVO);
		
	}
	
	public void sendSMSDate(SMSVO smsVO) {
		getSqlMapClientTemplate().insert("SC_TRAN_I_01", smsVO);
		
	}

	public void selectRefresh() {
		getSqlMapClientTemplate().queryForObject("selectRefresh", "");
	}

	public void sendMMS(MMSVO mmsVO) {
		getSqlMapClientTemplate().insert("MMS_MSG_I_00", mmsVO);
	}
	
	public void sendMMSDate(MMSVO mmsVO) {
		getSqlMapClientTemplate().insert("MMS_MSG_I_01", mmsVO);
	}
}
