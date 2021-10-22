#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include <math.h>
#include <complex.h>

//전처리기 -> ;_CRT_SECURE_NO_WARNINGS



int main(void)
{

	/*
	double theta = acos(-1) / 2;
	FILE* fp = fopen("temp.txt", "w");
	for (int i = 0; i < 1000; ++i) {
		double deg = theta * i / 100;
		fprintf(fp,"%f %f %f\n", deg, sin(deg), cos(deg));
	}
	fclose(fp);
	*/

	/* 
	double pi = acos(-1);
	double ak[100] = { 0, };
	int N = 100;

	double Awr[100] = { 0, }, Awi[100] = { 0, };

	FILE* fp = fopen("dft.txt", "w");
	for (int n = 0; n < N; ++n) {
		for (int k = 0; k < N; ++k) {
			Awr[n] += 1. / N * ak[k] * cos(-2. * pi * n * k / N);
			Awi[n] += 1. / N * ak[k] * sin(-2. * pi * n * k / N);
		}
		fprintf(fp, "%lf %lf %lf\n", Awr[n], Awi[n], sqrt(Awr[n] * Awr[n] + Awi[n] * Awi[n]));
	}
	fclose(fp);

	fp = fopen("dft2.txt", "w");
	double df = 1. / (N * 0.01);
	double f = -df * N / 2.;
	for (int n = 0; n < N / 2; ++n) {	// ?
		fprintf(fp, "%lf %lf %lf %lf\n", f, Awr[n], Awi[n], sqrt(Awr[n] * Awr[n] + Awi[n] * Awi[n]));
		f += df;
	}
	
	for (int n = 0; n < N / 2; ++n) {
		fprinf(fp, "%lf %lf %lf %lf\n", f, Awr[n], Awi[n], sqrt(Awr[n] * Awr[n] + Awi[n] * Awi[n]));
	}
	*/


	// 1021

	/*
	FILE* fp = fopen("h_t.txt", "w");
	int N = 128;
	int K = 1;
	for (int i = -N/2; i < N/2; ++i) {
		fprintf(fp, "%d %d\n", i, K);
	}

	fclose(fp);

	double pi = acos(-1);
	double Aw_r[128] = { 0, }, Aw_i[128] = { 0, };

	for (int n = 0; n < N; ++n) {
		for (int k = 0; k < N; ++k) {
			Aw_r[n] += 1. / N * K * cos(-2 * pi * n * k / N);
			Aw_i[n] += 1. / N * K * sin(-2 * pi * n * k / N);
		}
	}

	double df = 1. / (N * 1.);

	fp = fopen("dft.txt", "w");
	for (int i = 0; i < N / 2; ++i) {
		fprintf(fp, "%lf %lf %lf\n", df * (double)(i - N / 2), Aw_r[i + N / 2], Aw_i[i + N / 2]);
	}
	for (int i = 0; i < N / 2; ++i) {
		fprintf(fp, "%lf %lf %lf\n", df * (double)i, Aw_r[i], Aw_i[i]);
	}
	*/

	/*
	FILE* fp = fopen("h_t.txt", "w");
	int N = 128;
	double A = 1;

	double a[128] = { 0, };
	for (int i = -N / 2; i < N / 2; ++i) {

		if (i == -10 || i == 10) {
			fprintf(fp, "%lf %lf\n", (double)i, A / 2);
			a[i + N / 2] = A / 2;
		}
		else if (i > -10 && i < 10) {
			fprintf(fp, "%lf %lf\n", (double)i, A);
			a[i + N / 2] = A;
		}
		else {
			fprintf(fp, "%lf %lf\n", (double)i, 0.);
			a[i + N / 2] = 0.0;
		}
	}

	fclose(fp);

	// dft
	double pi = acos(-1);
	double Aw_r[128] = { 0, }, Aw_i[128] = { 0, };

	for (int n = 0; n < N; ++n) {
		for (int k = 0; k < N; ++k) {
			Aw_r[n] += 1. / N * a[k] * cos(-2 * pi * n * k / N);
			Aw_i[n] += 1. / N * a[k] * sin(-2 * pi * n * k / N);
		}
	}

	double df = 1. / (N * 1.);

	fp = fopen("dft.txt", "w");
	for (int i = 0; i < N / 2; ++i) {
		fprintf(fp, "%lf %lf %lf\n", df * (double)(i - N / 2), Aw_r[i + N / 2], Aw_i[i + N / 2]);
	}
	for (int i = 0; i < N / 2; ++i) {
		fprintf(fp, "%lf %lf %lf\n", df * (double)i, Aw_r[i], Aw_i[i]);
	}
	*/


}
