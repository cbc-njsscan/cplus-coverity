#import <Foundation/Foundation.h>

// Normal string format issue with printf in Objective-C with C like characteristics 
int main(int argc, const char * argv[]) {

    @autoreleasepool {
        
        printf(argv[1]); // VULNERABILITY HERE: FormatString

    }

    return 0;
}