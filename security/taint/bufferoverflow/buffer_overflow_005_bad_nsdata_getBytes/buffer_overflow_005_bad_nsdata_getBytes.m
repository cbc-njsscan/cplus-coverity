#import <Foundation/Foundation.h>

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSArray<NSString *> *args = [[NSProcessInfo processInfo] arguments];

        if ([args count] < 2) return 1;

        NSString *arg1 = args[1];
        NSData *taintedData = [arg1 dataUsingEncoding:NSUTF8StringEncoding];

        char smallBuffer[16] = {0};

        // No constraint on how many bytes copied to finite buffer
        // VULNERABILITY HERE: BufferOverflow
        [taintedData getBytes:smallBuffer];

        return 0;
    }
}