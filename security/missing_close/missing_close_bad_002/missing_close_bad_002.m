#import <Foundation/Foundation.h>

// Missing close file write using Objective-C features
int main(int argc, const char * argv[]) {

    @autoreleasepool {

        const char *bytesArray = "Some data";

        NSMutableData *data = [NSMutableData dataWithBytes:bytesArray length:strlen(bytesArray)-1];
        NSFileHandle *handler = [NSFileHandle fileHandleForWritingAtPath: @"./testfile.txt"]; // VULNERABILITY HERE: CMissingClose

        [handler seekToFileOffset:10];
        [handler writeData:data]; 

    }   

    return 0;

}