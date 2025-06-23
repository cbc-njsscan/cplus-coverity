#import <Foundation/Foundation.h>

// Fxes Missing close file write using Objective-C features
int main(int argc, const char * argv[]) {

    @autoreleasepool {

        const char *bytesArray = "Some data";
        NSString *pathForFile = @"./testfile.txt";

        NSMutableData *data = [NSMutableData dataWithBytes:bytesArray length:strlen(bytesArray)-1];
        NSFileHandle *handler = [NSFileHandle fileHandleForWritingAtPath: pathForFile]; // NO VULNERABILITY HERE: CMissingClose

        [handler seekToFileOffset:10];
        [handler writeData:data];

        [handler closeFile];

    }

    return 0;

}
