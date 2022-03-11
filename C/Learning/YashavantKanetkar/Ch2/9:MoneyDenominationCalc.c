#include <stdio.h>

int main(int argc, char const *argv[]) {
	int val, total;

	int deno[] = {100, 50, 10, 5, 2, 1};

	printf("Enter amount in Rupees to check for denominations (integer): ₹");
	scanf("%d", &val);

	for (register int i = 0; i < sizeof deno / sizeof deno[0]; i++) {
		int idx = deno[i];
		int div = val/idx;
		printf("The number of ₹%d notes is: %d\n", idx, div);
		val %= idx;
		total += div;
	}

	printf("\nThe Total number of notes required is: %d\n", total);

	return 0;
}