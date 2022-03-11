#include <stdio.h>

int main(int argc, char const *argv[]) {
	while (1) {
		int num;
		int sum = 0;

		printf("Enter your number to get the reversed number:");
		scanf("%d",&num);

		while (num){
			sum *= 10;
			sum += num % 10;
			num /= 10;
		}

		printf("Reversed Number is: %d\n",sum);
	}

	return 0;
}