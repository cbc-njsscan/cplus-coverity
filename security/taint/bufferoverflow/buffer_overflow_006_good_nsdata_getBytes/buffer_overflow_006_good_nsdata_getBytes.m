#import <Foundation/Foundation.h>

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSArray<NSString *> *args = [[NSProcessInfo processInfo] arguments];

        if ([args count] < 2) return 1;

        NSString *arg1 = args[1];
        NSData *taintedData = [arg1 dataUsingEncoding:NSUTF8StringEncoding];

        char smallBuffer[16] = {0};

        NSUInteger inputLen = [taintedData length];

        // Bound the copy length by the minimum length
        NSUInteger copyLen = (inputLen < sizeof(smallBuffer) ? inputLen : sizeof(smallBuffer));

        // Length check variant is safe
        // NO VULNERABILITY HERE: BufferOverflow
        [taintedData getBytes:smallBuffer length:copyLen];

        return 0;
    }
}