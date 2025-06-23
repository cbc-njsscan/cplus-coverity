#import <Foundation/Foundation.h>
#import <string.h>

int main(int argc, const char *argv[]) {
  @autoreleasepool {
    NSString *str = @"Hello";
    NSLog(@"%lu", (unsigned long)[str length]);
    // NO VULNERABILITY HERE: AllocOfStrlen
    NSMutableData *data1 =
        [[NSMutableData alloc] initWithLength:[str length] + 1];

    // NO VULNERABILITY HERE: AllocOfStrlen
    NSMutableData *data2 =
        [[NSMutableData alloc] initWithCapacity:[str length] + 1];

    // NO VULNERABILITY HERE: AllocOfStrlen
    NSMutableData *data3 = [NSMutableData dataWithLength:[str length] + 1];

    // NO VULNERABILITY HERE: AllocOfStrlen
    NSMutableData *data4 = [NSMutableData dataWithCapacity:[str length] + 1];
  }
  return 0;
}