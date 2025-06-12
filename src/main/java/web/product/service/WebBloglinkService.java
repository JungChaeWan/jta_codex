package web.product.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import web.product.vo.BLOGLINKSVO;
import web.product.vo.BLOGLINKVO;




public interface WebBloglinkService {

	BLOGLINKVO selectByBlogLink(String blogLinkNum);

	List<BLOGLINKVO> selectLinkList(BLOGLINKVO bolglinkVO);

	List<BLOGLINKVO> selectLinkList(String prdtNum);

	Map<String, Object> selectLinkListPage(BLOGLINKSVO bolglinkVO);

	Integer getBlogLinkCount(BLOGLINKVO bolglinkVO);
	Integer getBlogLinkCount(String prdtNum);

	String getNextBlogLinkNum();

	String insertBlogLink(BLOGLINKVO bolglinkVO, MultipartHttpServletRequest multiRequest);

	void updateBlogLink(BLOGLINKVO bolglinkVO, MultipartHttpServletRequest multiRequest);

	void deleteBlogLink(BLOGLINKVO bolglinkVO);
}
