#include <stdio.h>
#include <stdlib.h>
#include "../include/mystrfunctions.h"
#include "../include/myfilefunctions.h"

int main() {
    printf("--- Testing String Functions ---\n");

    char str1[50] = "Hello";
    char str2[50] = "World";
    char buffer[50];

    printf("Length of '%s': %d\n", str1, mystrlen(str1));
    mystrcpy(buffer, str1);
    printf("Copied string: %s\n", buffer);
    mystrcat(str1, str2);
    printf("Concatenated string: %s\n", str1);

    printf("\n--- Testing File Functions ---\n");
    FILE* fp = fopen("test.txt", "w+");
    fprintf(fp, "Hello world\nThis is a test file\nHello again\n");
    rewind(fp);

    int lines, words, chars;
    wordCount(fp, &lines, &words, &chars);
    printf("Lines: %d, Words: %d, Chars: %d\n", lines, words, chars);

    char** matches;
    int count = mygrep(fp, "Hello", &matches);
    printf("Found %d matching lines:\n", count);
    for (int i = 0; i < count; i++) {
        printf("%s", matches[i]);
        free(matches[i]);
    }
    free(matches);
    fclose(fp);

    return 0;
}

