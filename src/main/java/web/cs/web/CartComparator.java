package web.cs.web;

import web.product.vo.CARTVO;

import java.util.Comparator;

public class CartComparator implements Comparator<CARTVO>{

	@Override
	public int compare(CARTVO cart1, CARTVO cart2) {
		if(cart1.getCorpId().compareTo(cart2.getCorpId()) != 0) {
			return cart1.getCorpId().compareTo(cart2.getCorpId());
		} else {
			if(cart1.getPrdc() != null) {
				if(cart1.getPrdc().compareTo(cart2.getPrdc()) != 0) {
					return cart1.getPrdc().compareTo(cart2.getPrdc());
				} else {
					if (cart1.getDlvAmtDiv() != null) {
						if (cart1.getDlvAmtDiv().compareTo(cart2.getDlvAmtDiv()) != 0) {
							return cart1.getDlvAmtDiv().compareTo(cart2.getDlvAmtDiv());
						} else {
							if (cart1.getDirectRecvYn() != null) {
								return cart1.getDirectRecvYn().compareTo(cart2.getDirectRecvYn());
							} else {
								return 0;
							}
						}
					} else {
						return 0;
					}
				}
			} else {
				return 0;
			}
		}
	}

}
