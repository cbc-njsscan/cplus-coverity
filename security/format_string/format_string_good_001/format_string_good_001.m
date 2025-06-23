#import <Foundation/Foundation.h>

// Fixed string format issue with printf in Objective-C with C like characteristics 
int main(int argc, const char * argv[]) {

    @autoreleasepool {

        printf("%s", argv[1]);

    }

    return 0;
}