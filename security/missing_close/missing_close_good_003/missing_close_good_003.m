#import <Foundation/Foundation.h>

// Fixes missing close using C methods in conjunction with Objective-C Classes and Functions
@interface SampleClass: NSObject

    - (void) writeFile:(char*)bytesArray;

@end


@implementation SampleClass

    - (void) writeFile:(char*)bytesArray {
        FILE* fp = fopen("./testfile.txt", "w");  // NO VULNERABILITY HERE: CMissingClose
        if(!fp) {
            return;
        }

        fprintf(fp, bytesArray);
        fclose(fp);

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