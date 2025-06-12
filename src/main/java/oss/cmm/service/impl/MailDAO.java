package oss.cmm.service.impl;

import javax.annotation.Resource;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

import oss.cmm.vo.MAILVO;

import com.ibatis.sqlmap.client.SqlMapClient;

@SuppressWarnings("deprecation")
@Repository("mailDAO")
public class MailDAO extends SqlMapClientDaoSupport {
	
	@Resource(name = "mailSqlMapClient")
	public void setSuperSqlMapClient(SqlMapClient sqlMapClient) {
		super.setSqlMapClient(sqlMapClient);
	}
	
	public void insertMail(MAILVO mailVO) {
		getSqlMapClientTemplate().insert("MAIL_I_00", mailVO);
	}
	
	public void selectRefresh() {
		getSqlMapClientTemplate().queryForObject("selectRefresh", "");
	}
}
