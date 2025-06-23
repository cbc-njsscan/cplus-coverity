#import <Foundation/Foundation.h>
#import <string.h>

// No of-type edge because string is initalized via inline message passing
// Utilises NSString length instance function which does not include the null
// terminator
int main(int argc, const char *argv[]) {
  @autoreleasepool {
    NSString *str = @"Hello";
    NSLog(@"%lu", (unsigned long)[str length]);
    // VULNERABILITY HERE: AllocOfStrlen
    NSMutableData *data1 = [[NSMutableData alloc] initWithLength:[str length]];

    NSMutableData *data2 =
        // VULNERABILITY HERE: AllocOfStrlen
        [[NSMutableData alloc] initWithCapacity:[str length]];

    // VULNERABILITY HERE: AllocOfStrlen
    NSMutableData *data3 = [NSMutableData dataWithLength:[str length]];

    // VULNERABILITY HERE: AllocOfStrlen
    NSMutableData *data4 = [NSMutableData dataWithCapacity:[str length]];
  }
  return 0;
}