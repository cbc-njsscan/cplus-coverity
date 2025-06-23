// BufferOverflowTests.m
#import <Foundation/Foundation.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void test4(int numinput) {
    char *buf = malloc(10); // VULNERABILITY HERE: MemoryLeak
    sprintf(buf, "XXX%d", numinput);
}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray<NSString *> *args = [[NSProcessInfo processInfo] arguments];
        if (args.count <= 2) {
            return 1;
        }

        char *arg1 = [args[1] UTF8String];
        test4(atoi(arg1));
    }
    return 0;
}
