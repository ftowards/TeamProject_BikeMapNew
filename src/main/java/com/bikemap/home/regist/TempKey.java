package com.bikemap.home.regist;

import java.util.Random;
import java.util.UUID;

public class TempKey {

	public String getKey(int size) {
		Random ran = new Random();
		StringBuffer sb = new StringBuffer();
		int num = 0;
		
		do {
			num = ran.nextInt(75)+48;
			if((num >=48 && num<=57) || (num>=65 && num <=90) || (num>=97 && num <=122)) {
				sb.append((char)num);
			} else {
				continue;
			}
		}while(sb.length() < size);
		
		return sb.toString();
	}
}
