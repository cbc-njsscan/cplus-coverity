#import <Foundation/Foundation.h>


// Objective-C with C like characteristics SizeAsIndex implementation
int main (int argc, const char * argv[])
{
    @autoreleasepool {

        int array[5];
        int i;

        size_t rightSize = sizeof(array) / sizeof(array[0]) - 1 ;

        array[rightSize] = 1; // NO VULNERABILITY HERE: SizeAsIndex

    }

    return 0;
}