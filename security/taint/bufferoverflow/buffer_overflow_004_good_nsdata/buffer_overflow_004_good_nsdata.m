#import <Foundation/Foundation.h>
#include <string.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        if (argc < 2) return 1;

        const char *input = argv[1];
        // +1 to account for the null terminator
        NSUInteger len    = strlen(input) + 1;

        NSData *taintedData = [NSData dataWithBytes:input length:len];

        char smallBuffer[16] = {0};

        // Bound the copy length by the minimum length
        NSUInteger copyLen = (len < sizeof(smallBuffer) ? len : sizeof(smallBuffer));

        // Length check variant is safe
        // NO VULNERABILITY HERE: BufferOverflow
        [taintedData getBytes:smallBuffer length:copyLen];

        return 0;
    }
}
