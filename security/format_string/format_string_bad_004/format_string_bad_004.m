#import <Foundation/Foundation.h>

// Pure Objective-C format string issue in a main function
int main(int argc, const char * argv[]) {

    @autoreleasepool {

        NSString *userInput = [NSString stringWithUTF8String:argv[1]]; // Passing %xl leaks an address

        // NO VULNERABILITY HERE: FormatString
        NSString *from_nstring = [NSString stringWithFormat:@"%@", userInput];

        // TODO~FormatString~EngineIssue~EdgeBreaksAtStringWithFormat
        NSLog(from_nstring);

    }

    return 0;
}