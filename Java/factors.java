class factors {
	// Utilities:
	public static void showIntList(int[] list, String attachment){
		String listStr = "[";

		for (int i = 0; i < list.length - 1; i++) {
			int unit = list[i];
			listStr += Integer.toString(unit) + ",\t";
		};

		listStr += Integer.toString(list[list.length - 1]);
		System.out.println(attachment + listStr + "]");
	};

	public int[] appendInt(int[] list, int val){
		int[] newList = new int[list.length + 1];

		for (int i = 0; i <= list.length - 1; i++) {
			newList[i] = list[i];
		};

		newList[newList.length - 1] = val;
		return newList;
	}

	//
	//
	//
	//
	//
	//


	public class getFactors {
		int[] prime;
		int[] factors;
		int largest = 1;
		int steps = 0;

		private int[][] _getFactors(int number, int[] list, int[] primeList) {
			for (int i = 2; i <= number; i++) {
				steps += 1;
				if (number % i == 0) {
					int[] newList = appendInt(list, i);
					if (i > largest) {
						largest = i;
						int[] newPrimeList = appendInt(primeList, i);
						return _getFactors(number/i, newList, newPrimeList);
					} else {
						return _getFactors(number/i, newList, primeList);
					}
				}
			};
			int[][] returns = {list,primeList};
			return returns;
		}

		public getFactors(int number) {
			int[] localList = {};
			int[][] _factors = _getFactors(number, localList, localList);
			this.factors = _factors[0];
			this.prime = _factors[1];
		}

	}

	public void start(String[] args) {
		getFactors Factors = new getFactors(Integer.parseInt(args[0]));
		showIntList(Factors.prime, "Unique Prime Factors:\t");
		showIntList(Factors.factors, "All Prime Factors:\t");
		System.out.println("Total Steps:\t\t" + Integer.toString(Factors.steps));

	};

	public static void main(String[] args) {
		factors _class = new factors();
		_class.start(args);
	}
}