// String array sorting algorithm
// Anurag Tewary (DevTenga)
// 9th December, 2021

import java.lang.Math;

class sort {

	// Stores the max, min values and indices.
	static class values {
		long max,min,idx_max,idx_min;

		public values(long max, long min, long idx_max, long idk_min) {
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
		
		// Check if character is valid and return ascii value. Exit from system for invalid characters.
		int getAsciiEquiv(char ch) {
			int val = (int) ch;
			
			if (val >= 65 && val <= 90) {
				val -= 64;
			} else if (val >= 97 && val <= 122) {
				val -= 96;
			} else if (val == 32) {
				val = 0;
			} else {
				System.out.println("\u001B[31mError! Entered string contains an invalid character. Please enter characters within range: (A-Z) (a-z) or (space)\u001B[0m");
				System.exit(1);
			}
			return val; 
		};

		// Get an integer table equivalent to the string table.
		long[][] getAsciiArr(String[] strArr, int base) {
			int largest = getLargestStringLen(strArr);
			long[][] asciiArr = new long[strArr.length][2];

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
				asciiArr[i][0] = i;
				asciiArr[i][1] = val;
			}

			return asciiArr;
		};


		// Get the maximum and minimum values.
		values getMaxAndMin(long[][] asciiArr, int lastIdx) {
			long max = 0;
			long min = Long.MAX_VALUE;
			long idx_max = 0;
			long idx_min = Long.MAX_VALUE;

			for (int i = 0; i <= lastIdx; i++) {
				long[] element = asciiArr[i];

				if (element[1] >= max) {
					max = element[1];
					idx_max = element[0];
				} 

				if (element[1] < min) {
					min = element[1];
					idx_min = element[0];
				}
			};

			return new values(max, min, idx_max, idx_min);
		}


		// Arrange indices in correct order.
		int[] getIndexArr(long[][] asciiArr) {
			int len = asciiArr.length;

			boolean isEven = len % 2 == 0;
			int max_iter = isEven ? len / 2 : (len - 1) / 2;

			int[] idxArr = new int[len];

			int i = 0;

			for ( ; i < max_iter; i++) {
				int sub = i == 0 ? 1 : i*2 + 1; // Value that will be removed from the final index for search.

				values valz = getMaxAndMin(asciiArr, (len - sub));
				int max = (int) valz.idx_max;
				int min = (int) valz.idx_min;

				idxArr[i] = min;
				idxArr[len - 1 - i] = max;

				asciiArr[max] = asciiArr[len - 1];
				asciiArr[min] = asciiArr[len - 2];
			}

			//if (!isEven) idxArr[i] = getMaxAndMin(asciiArr, asciiArr.length - i*2 - 1).idx_min;
			if (!isEven) idxArr[i] = (int) asciiArr[i][0];

			return idxArr;
		}

		// Sort long table in an ascending order.
		String[] getSortedArr(int[] idxArr, String[] original){
			String[] newArr = new String[idxArr.length];

			int n = 0;
			for (int idx: idxArr) {
				newArr[n] =  original[idx];
				n++;
			} 

			return newArr;
		}

	}


	public static void main(String[] args) {
		Helper helper = new Helper();

		long[][] asciiArr = helper.getAsciiArr(args,27);
		int[] idxArr = helper.getIndexArr(asciiArr);

		String[] sortedArr = helper.getSortedArr(idxArr,args);

		for (int i = 0; i < sortedArr.length; i++) {
			System.out.printf("[%d] : %s\n",i,sortedArr[i]);
		}

		/*for (String str: helper.getSortedArr(idxArr,args)) {
			System.out.printf("%s\n",str);
		}*/
	}
}