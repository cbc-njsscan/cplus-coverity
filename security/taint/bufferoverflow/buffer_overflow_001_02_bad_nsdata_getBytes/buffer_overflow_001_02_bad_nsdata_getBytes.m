#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        if (argc < 2) return 1;

        const char *input = argv[1];

        // Adding + 1 to strlen here breaks the dataflow and causes FN
        // VULNERABILITY HERE: AllocOfStrlen
        NSData *taintedData = [NSData dataWithBytes:input length:strlen(input)];

        char smallBuffer[16] = {0};

        // No constraint on how many bytes copied to finite buffer
        // VULNERABILITY HERE: BufferOverflow
        [taintedData getBytes:smallBuffer];

        return 0;
    }
}
