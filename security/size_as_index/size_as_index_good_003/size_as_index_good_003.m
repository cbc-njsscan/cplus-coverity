#import <Foundation/Foundation.h>

// Objective-C Implementation: SizeAsIndex using .count
int main(int argc, const char * argv[]) {
    @autoreleasepool {

        NSArray *myArray = @[@"String1", @"String2"];

        myArray[myArray.count-1]; // Accessing .length-1 which is valid

    }
    return 0;
}