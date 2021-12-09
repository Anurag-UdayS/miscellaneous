// String array sorting algorithm
// Anurag Tewary (DevTenga)
// 9th December, 2021

import java.lang.Math;

class sort {
	static class Helper {
		
		// Check if character is valid and retrun ascii value. Exit from system for invalid characters.
		int getAsciiEquiv(char ch) {
			int val = (int) ch;
			
			if (val >= 65 && val <= 90){
				val -= 64;
			} else if (val >= 97 && val <= 122) {
				val -= 96;
			} else {
				System.out.println("\u001B[31mError! Entered string contains an invalid character. Please enter characters within range: (A-Z) (a-z)\u001B[0m");
				System.exit(1);
			}
			return val; 
		};


		int[] getAsciiArr(String[] strArr, int base) {
			int[] asciiArr = new int[strArr.length];

			for (int i = 0; i <= strArr.length - 1; i++) {
				String element = strArr[i];
				int val = 0;

				for (int j = 0; j <= element.length() - 1; j++) {
					val += Math.pow(base,j) * getAsciiEquiv(element.charAt(j));
				}
				asciiArr[i] = val;
			}

			return asciiArr ;
		};

	}


	public static void main(String[] args) {
		Helper helper = new Helper();
		for (int i: helper.getAsciiArr(args,100)) {
			System.out.printf("%d\n",i);
		}
	}
}