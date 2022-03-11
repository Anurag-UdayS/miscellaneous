#include <stdio.h>
#include <math.h>

int main(int argc, char const *argv[]) {
	while (1) {
		float theta;

		/* Trigonometric Ratios:
			* sin
			* cos
			* tan
			* cosec
			* sec
			* cot
		*/

		printf("Input an angle θ in radians: ");
		scanf("%f",&theta);

		printf(
				"\t • sin(θ) = %f\n \t • cos(θ) = %f\n\t • tan(θ) = %f\n\t • cosec(θ) = %f\n\t • sec(θ) = %f\n\t • cot(θ) = %f\n",
				sin(theta),
				cos(theta),
				tan(theta),
				1.0/sin(theta),
				1.0/cos(theta),
				1.0/tan(theta)
			);
	}

	return 0;
}
