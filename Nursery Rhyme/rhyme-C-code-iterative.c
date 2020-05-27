//============================================
//==== Iterative Version of Nursery Rhyme ====
//============================================

#include <stdio.h>
#include <string.h>

char animals[20][15];
char lyrics[20][60];

int main()
{
    int len = 0;

    while (1)
    {
        fgets(animals[len], 15, stdin);
        if (strcmp(animals[len], "END\n") == 0)
            break;
    
        int stringLen = strlen(animals[len]) - 1;
        animals[len][stringLen] = '\0';
        fgets(lyrics[len], 60, stdin);
        len++;
    }

    for (int current = 0; current < len; current++)
    {
        printf("%*s", current, ""); // print "current" number of spaces

        if (current == 0)
            printf("There was an old lady who swallowed a %s;\n", animals[current]);
        else if (current > 0)
            printf("She swallowed the %s to catch the %s;\n", animals[current - 1], animals[current]);
    }

    for (int current = len-1; current >= 0; current--)
    {
        printf("%*s", current, "");
        printf("I don't know why she swallowed a %s - %s", animals[current], lyrics[current]);
    }
}
