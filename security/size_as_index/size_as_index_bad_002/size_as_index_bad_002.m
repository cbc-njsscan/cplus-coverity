#import <Foundation/Foundation.h>


// Objective-C Implementation: SizeAsIndex using Classes
@interface ArbArrVal: NSObject
    
    - (NSInteger) getArbitraryValueFromArray:(NSInteger[])array atLength:(NSInteger)len atIndex:(NSInteger)index;
    
@end


@implementation ArbArrVal 
    
    
    - (NSInteger) getArbitraryValueFromArray:(NSInteger[])array atLength:(NSInteger)len atIndex:(NSInteger)index {
        NSInteger value = 0; 

        // VULNERABILITY HERE: SizeAsIndex
        value = array[index];
        
        NSLog(@"Value: %ld", value); // Prints out an address as %ld which is very clearly out of bounds
        return value;
    }


@end



int main(int argc, const char * argv[]) {


    @autoreleasepool {
    
        ArbArrVal *myClass = [[ArbArrVal alloc ] init ];
        
        NSInteger intArr[6] = {1, 2, 3, 4, 5, 6};

        [myClass getArbitraryValueFromArray:intArr atLength:sizeof(intArr)/sizeof(intArr[0]) atIndex:sizeof(intArr)/sizeof(intArr[0])];
        
    }
    return 0;
}