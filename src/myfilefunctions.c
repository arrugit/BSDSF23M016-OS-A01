#include "../include/myfilefunctions.h"
#include <stdlib.h>
#include <string.h>

// Count lines, words, and characters
int wordCount(FILE* file, int* lines, int* words, int* chars) {
    if (!file) return -1;

    *lines = *words = *chars = 0;
    char c;
    int inWord = 0;

    while ((c = fgetc(file)) != EOF) {
        (*chars)++;
        if (c == '\n') (*lines)++;

        if (c == ' ' || c == '\n' || c == '\t')
            inWord = 0;
        else if (!inWord) {
            inWord = 1;
            (*words)++;
        }
    }
    rewind(file);
    return 0;
}

// Search for lines containing search_str
int mygrep(FILE* fp, const char* search_str, char*** matches) {
    if (!fp || !search_str) return -1;

    size_t cap = 10, count = 0;
    char buffer[256];
    *matches = malloc(cap * sizeof(char*));

    while (fgets(buffer, sizeof(buffer), fp)) {
        if (strstr(buffer, search_str)) {
            if (count >= cap) {
                cap *= 2;
                *matches = realloc(*matches, cap * sizeof(char*));
            }
            (*matches)[count] = strdup(buffer);
            count++;
        }
    }
    rewind(fp);
    return count;
}

