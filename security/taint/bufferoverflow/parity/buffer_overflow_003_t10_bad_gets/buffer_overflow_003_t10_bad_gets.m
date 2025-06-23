// BufferOverflowTests.m
#import <Foundation/Foundation.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


void test10(void) {
    char instr[50];
    // gets does not restrict the input size so is inherently vulnerable
    gets(instr); // VULNERABILITY HERE: BufferOverflow
}


int main(int argc, const char * argv[]) {
    @autoreleasepool {

        test10();
    }
    return 0;
}
