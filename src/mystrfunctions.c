#include "../include/mystrfunctions.h"
#include <string.h>

// Returns length of string
int mystrlen(const char* s) {
    int len = 0;
    while (s[len] != '\0') len++;
    return len;
}

// Copies src into dest
int mystrcpy(char* dest, const char* src) {
    int i = 0;
    while ((dest[i] = src[i]) != '\0') i++;
    return i; // number of chars copied
}

// Copies at most n chars
int mystrncpy(char* dest, const char* src, int n) {
    int i = 0;
    while (i < n && src[i] != '\0') {
        dest[i] = src[i];
        i++;
    }
    dest[i] = '\0';
    return i; // number of chars copied
}

// Concatenates src onto dest
int mystrcat(char* dest, const char* src) {
    int dlen = mystrlen(dest);
    int i = 0;
    while (src[i] != '\0') {
        dest[dlen + i] = src[i];
        i++;
    }
    dest[dlen + i] = '\0';
    return dlen + i;
}

