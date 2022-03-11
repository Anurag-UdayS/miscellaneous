#include <stdio.h>
#include <math.h>

int main(int argc, char const *argv[]) {
	while (1) {
		float t,v,wcf;
		
		printf("Enter the temperature in °F: ");
		scanf("%f",&t);
		printf("Enter the wind velocity in Knots: ");
		scanf("%f",&v);

		wcf = 35.74 + 0.6215 * t + (0.4275 * t - 35.75) * pow(v, 0.16);

		printf("The Wind chill factor is: %f\n\n", wcf);

	}
	return 0;
}