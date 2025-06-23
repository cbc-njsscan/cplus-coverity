#import <Foundation/Foundation.h>


@interface SampleClass: NSObject

    - (void) logInput:(NSString*)input;

@end


@implementation SampleClass

    - (void) logInput:(NSString*)input {

        NSLog(@"%@", input);

    }

@end

// Fixes pure Objective-C format string issue using classes and interfaces
int main(int argc, const char * argv[]) {

    @autoreleasepool {

        NSString *myString = @"%x"; // Should print literal "%x"

        SampleClass *formatString = [[SampleClass alloc] init];

        [formatString logInput:myString];

    }

    return 0;
}


