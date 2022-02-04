#include <stdio.h>

int main(int argc, char const *argv[])
{
	while (1) {
		int num;
		int sum = 0;

		printf("Enter your number to get the sum of digits:");
		scanf("%d",&num);

		while (num){
			sum += num % 10;
			num /= 10;
		}

		printf("Sum of digits is %d.\n",sum);
	}

	return 0;
}