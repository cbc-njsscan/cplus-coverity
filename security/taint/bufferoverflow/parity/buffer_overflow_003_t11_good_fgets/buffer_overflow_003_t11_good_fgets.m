// BufferOverflowTests.m
#import <Foundation/Foundation.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


void test11(void) {
    char namedst[50];
    char instr[50];
    FILE *fp = fopen("file.txt", "r");
    if (fp == NULL) {
        perror("Error opening file");
        return;
    }
    if (fgets(instr, 60, fp) != NULL) {
        // fgets limits the size of input
        memcpy(namedst, instr, strlen(instr));
    }
    fclose(fp);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        test11();
    }
    return 0;
}
