#ifndef MYFILEFUNCTIONS_H
#define MYFILEFUNCTIONS_H
#include <stdio.h>

// Count lines, words, chars in a file
int wordCount(FILE* file, int* lines, int* words, int* chars);

// Search lines containing search_str
int mygrep(FILE* fp, const char* search_str, char*** matches);

#endif

