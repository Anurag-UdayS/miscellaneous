// String array sorting algorithm
// Anurag Tewary (DevTenga)
// 9th December, 2021

import java.lang.Math;

class sort {
	static class Helper {

		// Check for the largest string in a string array.
		int getLargestStringLen(String[] strArr) {
			int largest = 0;
			for (String str: strArr) {
				int len = str.length();
				if (len > largest) largest = len; 
			}
			return largest;
		}
		
		// Check if character is valid and retrun ascii value. Exit from system for invalid characters.
		int getAsciiEquiv(char ch) {
			int val = (int) ch;
			
			if (val >= 65 && val <= 90){
				val -= 64;
			} else if (val >= 97 && val <= 122) {
				val -= 96;
			} else {
				System.out.println("\u001B[31mError! Entered string contains an invalid character. Please enter characters within range: (A-Z) (a-z)\u001B[0m\n");
				System.exit(1);
			}
			return val; 
		};

		// Get an integer table equivalent to the string table.
		long[] getAsciiArr(String[] strArr, int base) {
			int largest = getLargestStringLen(strArr);
			long[] asciiArr = new long[strArr.length];

			for (int i = 0; i <= strArr.length - 1; i++) {
				String element = strArr[i];
				int len = element.length();
				long val = 0;

				for (int j = 0; j <= len - 1; j++) {
					val += Math.pow(base,largest-j-1) * getAsciiEquiv(element.charAt(j));
				}

				if (val >= Long.MAX_VALUE) {
					System.out.println("\u001B[31mError! One of the entered strings is too large. Please reduce the length of the largest string and retry.\u001B[0m\n");
					System.exit(1);
				}
				asciiArr[i] = val;
			}

			return asciiArr;
		};

	}


	public static void main(String[] args) {
		Helper helper = new Helper();
		for (long i: helper.getAsciiArr(args,100)) {
			System.out.printf("%d\n",i);
		}
	}
}