#include <stdio.h>

int main(){
	int iter;
	float len = 1189.0, breadth = 841.0;
	float temp;

	printf("Enter number of iterations: ");
	scanf("%d",&iter);


	printf("Dimensions of A0: %f mm x %f mm.\n",len,breadth);

	for (int i = 1; i <= iter; i++) {
		temp = breadth;
		breadth = len/2;
		len = temp;
		printf("Dimensions of A%d: %f mm x %f mm.\n",i,len,breadth);
	}
	return 0;
}