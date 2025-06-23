// BufferOverflowTests.m
#import <Foundation/Foundation.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void test5(char *input) {
    char *buf = malloc(10); // VULNERABILITY HERE: MemoryLeak
    strcpy(buf, input); // VULNERABILITY HERE: BufferOverflow
}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray<NSString *> *args = [[NSProcessInfo processInfo] arguments];
        if (args.count <= 2) {
            return 1;
        }

        char *arg1 = [args[1] UTF8String];

        test5(arg1);
    }
    return 0;
}
