#include <stdio.h>

int main() {
	// Given:	Dearness Allowance 		= 40%
	// 			House Rent Allowance 	= 20%		
	printf("Input the salary of Ramesh: ");
	float baseSalary;
	scanf("%f", &baseSalary);
	float grossSalary = baseSalary * 1.6;
	printf("Ramesh's gross salary is: %f", &grossSalary);
}
