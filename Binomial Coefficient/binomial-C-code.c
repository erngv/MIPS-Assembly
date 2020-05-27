#include <stdio.h>
#include <string.h>

int nchoosek(int n, int k)
{
    if (n == k || k == 0)
        return 1;
    
    return nchoosek(n-1, k-1) + nchoosek(n-1, k); 
}

int main()
{
    int n, k, answer = 1;
    
    do {
        printf("Enter two integers (for n and k) separated by space:\n");
        scanf("%d", &n);
        scanf("%d", &k);

        if (n == 0)
        {
            answer = 0;
            printf("1\n");
            break;
        }
        else
        {
            answer = nchoosek(n, k);
            printf("%d\n", answer);
        }

    } while (answer != 0);
}
