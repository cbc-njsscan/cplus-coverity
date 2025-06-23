#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        if (argc < 2) return 1;

        NSString *tainted = [NSString stringWithUTF8String:argv[1]];

        char smallBuffer[16] = {0};

        // No constraint on how many bytes copied to finite buffer
        // VULNERABILITY HERE: BufferOverflow
        [tainted getCString:smallBuffer];
        return 0;
    }
}
