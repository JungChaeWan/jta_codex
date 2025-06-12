package web.product.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import web.product.vo.BLOGLINKSVO;
import web.product.vo.BLOGLINKVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;




@Repository("blogLinkDAO")
public class BlogLinkDAO extends EgovAbstractDAO {


	public BLOGLINKVO selectByBlogLink(BLOGLINKVO bolglinkVO) {
		return (BLOGLINKVO) select("BLOGLINK_S_00", bolglinkVO);
	}

	@SuppressWarnings("unchecked")
	public List<BLOGLINKVO> selectLinkList(BLOGLINKVO bolglinkVO) {
		return (List<BLOGLINKVO>) list("BLOGLINK_S_00", bolglinkVO);
	}

	@SuppressWarnings("unchecked")
	public List<BLOGLINKVO> selectLinkListPage(BLOGLINKSVO bolglinkVO) {
		return (List<BLOGLINKVO>) list("BLOGLINK_S_01", bolglinkVO);
	}

	public Integer getCntLinkList(BLOGLINKSVO bolglinkVO) {
		return (Integer) select("BLOGLINK_S_03", bolglinkVO);
	}

	public Integer getBlogLinkCount(BLOGLINKVO bolglinkVO) {
		return (Integer) select("BLOGLINK_S_02", bolglinkVO);
	}

	public String getNextBlogLinkNum() {
		return (String) select("BLOGLINK_S_04", null);
	}

	public String insertBlogLink(BLOGLINKVO bolglinkVO) {
		return (String) insert("BLOGLINK_I_00", bolglinkVO);
	}

	public void updateBlogLink(BLOGLINKVO bolglinkVO) {
		update("BLOGLINK_U_00", bolglinkVO);
	}


	public void deleteBlogLink(BLOGLINKVO bolglinkVO) {
		delete("BLOGLINK_D_00", bolglinkVO);
	}


}
