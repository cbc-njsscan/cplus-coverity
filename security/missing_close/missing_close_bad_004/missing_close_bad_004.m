#import <Foundation/Foundation.h>

// Missing close using Objective-C features inside Classes and Functions
@interface SampleClass: NSObject

    - (NSString*) readFile:(NSString*)filePath;

@end


@implementation SampleClass

    - (NSString*) readFile:(NSString*)filePath {

        NSFileHandle *handler = [NSFileHandle fileHandleForReadingAtPath:filePath]; // VULNERABILITY HERE: CMissingClose
        NSData *data = [handler readDataToEndOfFile];

        NSString *strData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding ];
        NSLog(@"%@", strData);

        return strData;

    }

@end


int main(int argc, const char * argv[]) {

    @autoreleasepool {

        NSString * filePath = @"./testfile.txt";
        
        SampleClass *myClass = [[SampleClass alloc] init];

        [myClass readFile:filePath];

    }

    return 0;

}