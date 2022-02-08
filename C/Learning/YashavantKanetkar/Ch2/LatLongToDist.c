#include <stdio.h>
#include <math.h>

int main(int argc, char const *argv[])
{
	double L1,L2,G1,G2;
	printf("Input the values of Latitudes(Format: X Y):");
	scanf("%lf %lf", &L1, &L2);
	
	printf("Input the values of Longitudes(Format: X Y):");
	scanf("%lf %lf", &G1, &G2);

	double v = 3963;
	double s = sin(L1) * sin(L2);
	double c = cos(L1) * cos(L2);
	double g = cos(G2 - G1);

	double D = v * acos(s + c * g);

	printf("The distance in Nautical Miles is %lf miles.\n", D);
	return 0;
}