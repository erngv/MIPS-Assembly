#include <stdio.h>
#include <string.h>

#define NUM 25
#define LEN 1000

int my_compare_strings(char string1[], char string2[])
{
    int looping_length;
    int length1 = strlen(string1) - 1;
    int length2 = strlen(string2) - 1;

    if (length1 < length2)
    {
        looping_length = length1;
    }
    else
    {
        looping_length = length2;
    }
    
    for (int i = 0; i < looping_length; i++)
    {
        if (string1[i] > string2[i])
        {
            return 1;
        }
        
        if (string1[i] < string2[i])
        {
            return -1;
        }
    }

    if (length1 < length2)
    {
        return -1;
    }
    else if (length1 > length2)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

void my_swap_strings(char string1[], char string2[])
{
    char temp;
    int looping_length;
    int length1 = strlen(string1);
    int length2 = strlen(string2);

    if (length1 < length2)
    {
        looping_length = length2;
    }
    else
    {
        looping_length = length1;
    }

    for (int i = 0; i <= looping_length; i++)
    {
        temp = string2[i];
        string2[i] = string1[i];
        string1[i] = temp;
    }
}

int main()
{
    char Strings[NUM][LEN];
    
    printf("Please enter %d strings, one per line:\n", NUM);

    for (int i = 0; i < NUM; i++)
    {
        fgets(Strings[i], LEN, stdin);
    }

    puts("\nHere are the strings in the order you entered:");
    
    for (int i = 0; i < NUM; i++)
    {
        printf("%s", Strings[i]);
    }

    for (int i = 0; i < NUM - 1; i++)
    {
        for (int j = i + 1; j < NUM; j++)
        {
            if (my_compare_strings(Strings[i], Strings[j]) > 0)
            {
                my_swap_strings(Strings[i], Strings[j]);
            }
        }
    }

    puts("\nIn alphabetical order, the strings are:");

    for (int i = 0; i < NUM; i++)
    {
        printf("%s", Strings[i]);
    }
}
