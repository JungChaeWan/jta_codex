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

import egovframework.cmmn.vo.MMSVO;
import egovframework.cmmn.vo.SMSVO;


public interface SmsService {

	public void sendSMS(SMSVO smsVO);
	public void sendSMSDate(SMSVO smsVO);

	public void sendMMS(MMSVO mmsVO);
	public void sendMMSDate(MMSVO mmsVO);

	/**
	 * 난수 번호 생성
	 * 파일명 : nanSuInt
	 * 작성일 : 2015. 12. 21. 오후 4:03:09
	 * 작성자 : 최영철
	 * @param range
	 * @return
	 */
	public String nanSuInt(Integer range);

}
