#include <stdio.h>

int AA[100];  		// linearized version of A[10][10]
int BB[100];  		// linearized version of B[10][10]
int CC[100];  		// linearized version of C[10][10]
int m;       		// actual size of the above matrices is mxm, where m is at most 10


int main()
{
    scanf("%d", &m);

    // Scanning values of AA
    for (int i = 0; i < m*m; i++)
    {
        scanf("%d", &AA[i]);
    }

    // Scanning values of BB
    for (int i = 0; i < m; i++)
    {
        for (int j = 0; j < m*m; j+=m)
        {
            scanf("%d", &BB[i+j]);
        }
    }

    // Performing matrix multiplication
    for (int i = 0; i < m*m; i+=m)
    {
        for (int j = 0; j < m*m; j+=m)
        {
            CC[i+j] = 0;
            for (int tmp = 0; tmp < m; tmp++) {
                CC[i+j] += AA[i+tmp] * BB[tmp+j];
            }
            printf("%d ", CC[i+j]);
        }     
        printf("\n");
    }
}
