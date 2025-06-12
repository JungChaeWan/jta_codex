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
package egovframework.cmmn.service;

import java.util.Map;



public interface AllimService {

	/**
	 * 인증번호 템플릿
	 * 파일명 : sendTemplet10001
	 * 작성일 : 2018. 11. 12. 오후 3:52:28
	 * 작성자 : 최영철
	 * @param paramMap
	 */
	void sendTemplet10001(Map<String, Object> paramMap);

	/**
	 * 10003 발송완료(특산품)
	 * 파일명 : sendTemplet10003
	 * 작성일 : 2018. 11. 12. 오후 4:09:37
	 * 작성자 : 최영철
	 * @param paramMap
	 */
	void sendTemplet10003(Map<String, Object> paramMap);

}
