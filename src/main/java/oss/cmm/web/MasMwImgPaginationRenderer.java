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
package oss.cmm.web;

import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;

import javax.servlet.ServletContext;

import org.springframework.web.context.ServletContextAware;

/** .
 * @Class Name : ImagePaginationRenderer.java
 * @Description : ImagePaginationRenderer Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2009.03.16           최초생성
 *
 * @author 개발프레임웍크 실행환경 개발팀
 * @since 2009. 03.16
 * @version 1.0
 * @see
 *
 *  Copyright (C) by MOPAS All right reserved.
 */
public class MasMwImgPaginationRenderer extends AbstractPaginationRenderer implements ServletContextAware {

	private ServletContext servletContext;

	public MasMwImgPaginationRenderer() {
		// no-op
	}

	/** PaginationRenderer.
	*
	* @see 개발프레임웍크 실행환경 개발팀
	*/
	public void initVariables() {

		String strWebDir = "/images/adm_mw/paging/";

		firstPageLabel = "<li class=\"first\"><a href=\"#\" onclick=\"{0}({1}); return false;\">" +
							"<img src='" + strWebDir + "first.png' alt=\"처음페이지\" /></a></li>";
        previousPageLabel = "<li class=\"prev\"><a href=\"#\" onclick=\"{0}({1}); return false;\">" +
        						"<img src='" + strWebDir + "prev.png' alt=\"이전페이지\" /></a></li>";
        currentPageLabel = "<li class=\"active\">{0}</li>";
        otherPageLabel = "<li><a href=\"#\" onclick=\"{0}({1}); return false;\">{2}</a></li>";
        nextPageLabel = "<li class=\"next\"><a href=\"#\" onclick=\"{0}({1}); return false;\">" +
        					"<img src='" + strWebDir + "next.png' alt=\"다음페이지\" /></a></li>";
        lastPageLabel = "<li class=\"last\">a href=\"#\" onclick=\"{0}({1}); return false;\">" +
        					"<img src='" + strWebDir + "last.png' alt=\"마지막페이지\" /></a></li>";
	}

	@Override
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
		initVariables();
	}
}
