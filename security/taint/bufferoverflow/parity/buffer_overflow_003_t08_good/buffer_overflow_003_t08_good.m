// BufferOverflowTests.m
#import <Foundation/Foundation.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void test8(char *input) {
    char namedst[50];
    memcpy(namedst, input, 10);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray<NSString *> *args = [[NSProcessInfo processInfo] arguments];
        if (args.count <= 2) {
            return 1;
        }

        char *arg1 = [args[1] UTF8String];

        test8(arg1);

    }
    return 0;
}
