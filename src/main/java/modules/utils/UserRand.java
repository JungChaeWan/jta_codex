package modules.utils;

import java.security.SecureRandom;

public class UserRand {
	private UserRand(){};
	public static String randString(int size, int radix) {
		StringBuffer buf = new StringBuffer();
		
		for (int i = 0; i < size; i++) {
			buf.append(Integer.toString((int) (Math.random() * radix), radix));
		}
		
		return buf.toString();
	}
	
	public static String generateRandomRange(int len){
		   SecureRandom sr = new SecureRandom();
		   sr.setSeed(System.currentTimeMillis());
		   String result = (sr.nextInt(9)+1) +"";
		   for(int i=0; i<len-2; i++) result += sr.nextInt(10);
		   result += (sr.nextInt(9)+1);
		   return result;
		}

}
