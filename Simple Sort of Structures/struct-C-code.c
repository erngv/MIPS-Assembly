//===================================
//==== Simple Sort of Structures ====
//===================================

#include <stdio.h>

typedef struct
{
    int year;
    int month;
    int day;
    int ID; 
} record;

void main()
{
    int recNum;
    scanf("%d", &recNum);
    record data[recNum], tmp;

    for (int i = 0; i < recNum; i++)
    {
        scanf("%d", &data[i].year);
        scanf("%d", &data[i].month);
        scanf("%d", &data[i].day);
        scanf("%d", &data[i].ID);
    }

    for (int i = 0; i < recNum - 1; i++)
    {
        for (int j = i + 1; j < recNum; j++)
        {
            if (data[i].year > data[j].year)
            {
                tmp = data[j];
                data[j] = data[i];
                data[i] = tmp;
            }
            else if (data[i].year == data[j].year)
            {
                if (data[i].month > data[j].month)
                {
                    tmp = data[j];
                    data[j] = data[i];
                    data[i] = tmp;
                }
                else if (data[i].month == data[j].month)
                {
                    if (data[i].day > data[j].day)
                    {
                        tmp = data[j];
                        data[j] = data[i];
                        data[i] = tmp;
                    } 
                    else if (data[i].day == data[j].day)
                    {
                        if (data[i].ID > data[j].ID)
                        {
                            tmp = data[j];
                            data[j] = data[i];
                            data[i] = tmp;
                        }
                    }
                }
            }
        }
    }

    for (int i = 0; i < recNum; i++)
    {
        printf("%d\t%d\t%d\t%d\n", data[i].year, data[i].month, data[i].day, data[i].ID);
    }
}