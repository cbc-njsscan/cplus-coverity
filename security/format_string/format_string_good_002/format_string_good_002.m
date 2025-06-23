#import <Foundation/Foundation.h>

// Fixes pure Objective-C format string issue in a main function
int main(int argc, const char * argv[]) {

    @autoreleasepool {

        NSString *userInput = [NSString stringWithUTF8String:argv[1]];
        NSLog(@"%@", userInput);

    }

    return 0;
}


