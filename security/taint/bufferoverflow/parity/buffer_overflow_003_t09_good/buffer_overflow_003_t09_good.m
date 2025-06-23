// BufferOverflowTests.m
#import <Foundation/Foundation.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void test9(char *input) {
    char namedst[50];
    if (strlen(input) > 50) {
        return;
    }
    memcpy(namedst, input, strlen(input));
}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray<NSString *> *args = [[NSProcessInfo processInfo] arguments];
        if (args.count <= 2) {
            return 1;
        }

        char *arg1 = [args[1] UTF8String];

        test9(arg1);

    }
    return 0;
}
