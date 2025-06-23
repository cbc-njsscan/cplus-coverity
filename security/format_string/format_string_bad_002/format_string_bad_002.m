#import <Foundation/Foundation.h>

// Pure Objective-C format string issue in a main function
int main(int argc, const char * argv[]) {

    @autoreleasepool {

        NSString *userInput = [NSString stringWithUTF8String:argv[1]]; // Passing %xl leaks an address

        // VULNERABILITY HERE: FormatString
        NSString *formatted = [NSString stringWithFormat:userInput];

        // NO VULNERABILITY HERE: FormatString
        NSString *from_cstring = [NSString stringWithFormat:@"%s", argv[1]];

        NSLog(@"%@", userInput);  // NO VULNERABILITY HERE: FormatString

        // VULNERABILITY HERE: FormatString
        NSLog(userInput);

    }

    return 0;
}