// String array sorting algorithm
// Anurag Tewary (DevTenga)
// 9th December, 2021

import java.lang.Math;

class sort {

	// Stores the max, min values and indices.
	static class values {
		long max,min;
		int idx_max,idx_min;

		public values(long max, long min, int idx_max, int idk_min) {
			this.max = max;
			this.min = min;
			this.idx_max = idx_max;
			this.idx_min = idk_min;
		}

	}


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
				System.out.println("\u001B[31mError! Entered string contains an invalid character. Please enter characters within range: (A-Z) (a-z)\u001B[0m");
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
					System.out.println("\u001B[31mError! One of the entered strings is too large. Please reduce the length of the largest string and retry.\u001B[0m");
					System.exit(1);
				}
				asciiArr[i] = val;
			}

			return asciiArr;
		};


		// Get the maximum and minimum values.
		values getMaxAndMin(long[] asciiArr, int lastIdx) {
			long max = 0;
			long min = Long.MAX_VALUE;
			int idx_max = 0;
			int idx_min = Int.MAX_VALUE;

			for (i = 0; i <= lastIdx; i++) {
				long element = asciiArr[i];
				if (element > max) {
					max = element;
					idx_max = i;
				} else if (element < min) {
					min = element;
					idx_min = i;
				}
			};

			return new values(max, min, idx_max, idx_min);
		}


		// Sort long table in an ascending order.


	}


	public static void main(String[] args) {
		Helper helper = new Helper();
		for (long i: helper.getAsciiArr(args,26)) {
			System.out.printf("%d\n",i);
		}
	}
}