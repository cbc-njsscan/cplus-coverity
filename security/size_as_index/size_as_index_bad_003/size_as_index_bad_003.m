#import <Foundation/Foundation.h>

// Objective-C Implementation: SizeAsIndex using .count
int main(int argc, const char * argv[]) {
    @autoreleasepool {

        NSArray *myArray = @[@"String1", @"String2"];
        // VULNERABILITY HERE: SizeAsIndex
        myArray[myArray.count]; // String array access out of bounds

    }
    return 0;
}