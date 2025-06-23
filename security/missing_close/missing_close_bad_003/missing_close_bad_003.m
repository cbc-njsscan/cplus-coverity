#import <Foundation/Foundation.h>

// Missing close using C methods in conjunction with Objective-C Classes and Functions
@interface SampleClass: NSObject

    - (void) writeFile:(char*)bytesArray;

@end


@implementation SampleClass

    - (void) writeFile:(char*)bytesArray {
        FILE* fp = fopen("./testfile.txt", "w"); // VULNERABILITY HERE: CMissingClose

        fprintf(fp, bytesArray);

    }

@end


int main(int argc, const char * argv[]) {

    @autoreleasepool {

        char* bytesArray = "this is a string";

        SampleClass *myClass = [[SampleClass alloc] init];
        [myClass writeFile:bytesArray];

    }

    return 0;

}