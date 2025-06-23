#import <Foundation/Foundation.h>


// Objective-C with C like characteristics SizeAsIndex implementation
int main (int argc, const char * argv[])
{
    @autoreleasepool {

        int array[5];
        int i;

        size_t wrongSize = sizeof(array) / sizeof(array[0]);

        // Writes out of bounds
        array[wrongSize] = 1; // VULNERABILITY HERE: SizeAsIndex

    }

    return 0;
}