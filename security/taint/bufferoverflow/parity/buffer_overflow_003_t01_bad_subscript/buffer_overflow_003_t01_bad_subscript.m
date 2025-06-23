// BufferOverflowTests.m
#import <Foundation/Foundation.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void test1(char *input) {
    char *buf = malloc(10); // VULNERABILITY HERE: MemoryLeak
    sprintf(buf, "XXX%s", input); // VULNERABILITY HERE: BufferOverflow
}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray<NSString *> *args = [[NSProcessInfo processInfo] arguments];
        if (args.count <= 2) {
            return 1;
        }

        test1([args[1] UTF8String]);
    }
    return 0;
}
