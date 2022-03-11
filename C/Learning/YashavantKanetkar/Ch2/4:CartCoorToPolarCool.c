#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main(int argc, char const *argv[]) {
	while (1) {
		double x,y;
		printf("Input Cartesian Coordinates (x, y) separated by spaces:");
		scanf("%lf %lf", &x, &y);

		double r = sqrt(pow(x, 2) + pow(y, 2));
		double phi = deg(atan(y / x));

		printf("The Polar Coordinates are:\n\tRadius (r) = %lf; \n\tAngle (phi) = %lf (radians)\n", r, phi);
	}

	return 0;
}