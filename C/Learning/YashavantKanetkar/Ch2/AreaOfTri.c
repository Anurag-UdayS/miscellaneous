#include <stdio.h>
#include <stdlib.h>
#include <math.h>
 
int main(int argc, char const *argv[])
{
	while (1) {
		float a, b, c;
		printf("Input the three sides of a triangle (separated by spaces):");
		scanf("%f %f %f", &a, &b, &c);
		float s = (a + b + c) / 2.0;
		//printf("DBG: %f, %f %f %f\n", s, s-a, s-b, s-c);
		
		if (s <= 0 || s - a <= 0 || s - b <= 0 || s - c <= 0){
			fprintf(stderr, "Failed. One or more sides are faulty. Please retry.\n");
			continue;
		}

		float ar = sqrt(s * (s - a) * (s - b) * (s - c));

		printf("The area of the triangle is %f\n", ar);
	}
	return 0;
}