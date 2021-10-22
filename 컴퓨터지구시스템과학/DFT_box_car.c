#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include <math.h>
#include <complex.h>

//전처리기 -> ;_CRT_SECURE_NO_WARNINGS

#define PI acos(-1)

int main()
{
	FILE* fp = fopen("h_t.txt", "w");
	int N = 1 << 7;
	double dt = 1.0;

	double A = 10;
	double a[128] = { 0 };


	// make h(t)
	for (int i = - N / 2; i < N / 2; ++i) {
		if (i == -10 || i == 10) {
			fprintf(fp, "%d %f\n", i, A / 2);
			a[i + N / 2] = A / 2;
		}
		else if (i > -10 && i < 10) {
			fprintf(fp, "%d %f\n", i, A);
			a[i + N / 2] = A;
		}
		else {
			fprintf(fp, "%d %f\n", i, 0.0);
			a[i + N / 2] = 0;
		}
	}
	fclose(fp);


	// DFT
	double Aw_r[128] = { 0 };
	double Aw_i[128] = { 0 };

	for (int n = 0; n < N; ++n) {
		for (int k = 0; k < N; ++k) {
			double factor = -2 * PI * n * k / N;
			Aw_r[n] += a[k] * cos(factor);
			Aw_i[n] += a[k] * sin(factor);
		}
		Aw_r[n] /= N;
		Aw_i[n] /= N;
	}

	double df = 1.0 / (N * dt);

	fp = fopen("dft.txt", "w");
	for (int i = N / 2; i < N; ++i) {
		fprintf(fp, "%f %f %f\n", df * (i - N), Aw_r[i], Aw_i[i]);
	}
	for (int i = 0; i < N / 2; ++i) {
		fprintf(fp, "%f %f %f\n", df * i, Aw_r[i], Aw_i[i]);
	}
	fclose(fp);
}
