package web.mypage.web;

import java.util.Comparator;

import web.order.vo.ORDERVO;

public class OrderComparator implements Comparator<ORDERVO>{

	@Override
	public int compare(ORDERVO order1, ORDERVO order2) {
		if(order1.getCorpId().compareTo(order2.getCorpId()) != 0) {
			return order1.getCorpId().compareTo(order2.getCorpId());
		} else {
			if(order1.getDlvAmtDiv() != null && order2.getDlvAmtDiv() != null) {
				return order1.getDlvAmtDiv().compareTo(order2.getDlvAmtDiv());
			} else
				return 0;
		}
	}

}
