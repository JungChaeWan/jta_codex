package web.product.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import oss.cmm.service.OssFileUtilService;
import web.product.service.WebBloglinkService;
import web.product.vo.BLOGLINKSVO;
import web.product.vo.BLOGLINKVO;
import egovframework.cmmn.service.EgovProperties;


@Service("webBloglinkService")
public class WebBloglinkServiceImpl implements WebBloglinkService {

	@SuppressWarnings("unused")
	private static final Logger LOGGER = LoggerFactory.getLogger(WebBloglinkServiceImpl.class);

	@Resource(name = "blogLinkDAO")
	private BlogLinkDAO blogLinkDAO;

	@Resource(name="ossFileUtilService")
	private OssFileUtilService ossFileUtilService;

	@Override
	public BLOGLINKVO selectByBlogLink(String blogLinkNum) {
		BLOGLINKVO bolglinkVO = new BLOGLINKVO();
		bolglinkVO.setBlogLinkNum(blogLinkNum);
		return blogLinkDAO.selectByBlogLink(bolglinkVO);
	}

	@Override
	public List<BLOGLINKVO> selectLinkList(BLOGLINKVO bolglinkVO) {
		return blogLinkDAO.selectLinkList(bolglinkVO);
	}

	@Override
	public List<BLOGLINKVO> selectLinkList(String prdtNum) {
		BLOGLINKVO bolglinkVO = new BLOGLINKVO();
		bolglinkVO.setPrdtNum(prdtNum);
		return blogLinkDAO.selectLinkList(bolglinkVO);
	}

	@Override
	public Map<String, Object> selectLinkListPage(BLOGLINKSVO bolglinkVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<BLOGLINKVO> resultList = blogLinkDAO.selectLinkListPage(bolglinkVO);
		Integer totalCnt = blogLinkDAO.getCntLinkList(bolglinkVO);

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);

		return resultMap;
	}

	@Override
	public String getNextBlogLinkNum() {
		return blogLinkDAO.getNextBlogLinkNum();
	}

	@Override
	public String insertBlogLink(BLOGLINKVO bolglinkVO, MultipartHttpServletRequest multiRequest) {

		String strNum = getNextBlogLinkNum();
    	bolglinkVO.setBlogLinkNum(strNum);


		String listSavePath = EgovProperties.getProperty("BLOGLINK.SAVEDFILE");

		MultipartFile blogImageFile = multiRequest.getFile("blogImageFile") ;
		if(!blogImageFile.isEmpty()) {
			String newFileName = "blog_" + strNum + "_"+(new java.text.SimpleDateFormat("yyyyMMddhhmmss").format(new java.util.Date())) + "." + FilenameUtils.getExtension(multiRequest.getFile("blogImageFile").getOriginalFilename());
			try {
				ossFileUtilService.uploadFile(blogImageFile, newFileName, listSavePath);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			bolglinkVO.setBlogImage(listSavePath + newFileName);
		}

		return blogLinkDAO.insertBlogLink(bolglinkVO);
	}

	@Override
	public Integer getBlogLinkCount(BLOGLINKVO bolglinkVO) {
		return blogLinkDAO.getBlogLinkCount(bolglinkVO);
	}

	@Override
	public Integer getBlogLinkCount(String prdtNum) {
		BLOGLINKVO bolglinkVO = new BLOGLINKVO();
		bolglinkVO.setPrdtNum(prdtNum);
		return getBlogLinkCount(bolglinkVO);
	}

	@Override
	public void deleteBlogLink(BLOGLINKVO bolglinkVO) {
		blogLinkDAO.deleteBlogLink(bolglinkVO);
	}

	@Override
	public void updateBlogLink(BLOGLINKVO bolglinkVO, MultipartHttpServletRequest multiRequest) {


		String listSavePath = EgovProperties.getProperty("BLOGLINK.SAVEDFILE");

		String strNum = bolglinkVO.getBlogLinkNum();

		MultipartFile blogImageFile = multiRequest.getFile("blogImageFile") ;
		if(!blogImageFile.isEmpty()) {
			String newFileName = "blog_" + strNum + "_"+(new java.text.SimpleDateFormat("yyyyMMddhhmmss").format(new java.util.Date())) + "." + FilenameUtils.getExtension(multiRequest.getFile("blogImageFile").getOriginalFilename());
			try {
				ossFileUtilService.uploadFile(blogImageFile, newFileName, listSavePath);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			bolglinkVO.setBlogImage(listSavePath + newFileName);
		}

		blogLinkDAO.updateBlogLink(bolglinkVO);

	}


}
