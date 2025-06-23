// BufferOverflowTests.m
#import <Foundation/Foundation.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


void test2(char *input) {
    char *buf = malloc(10); // VULNERABILITY HERE: MemoryLeak
    if (strlen(input) > 7) {
        return;
    }
    sprintf(buf, "XXX%s", input);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray<NSString *> *args = [[NSProcessInfo processInfo] arguments];
        if (args.count <= 2) {
            return 1;
        }

        char *arg1 = [args[1] UTF8String];

        test2(arg1);
        test2( (char *)[args[2] UTF8String] );
    }
    return 0;
}
