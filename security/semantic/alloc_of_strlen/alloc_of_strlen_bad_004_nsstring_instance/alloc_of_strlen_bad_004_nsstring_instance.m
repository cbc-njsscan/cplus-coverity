#import <Foundation/Foundation.h>

// No of-type edge because string is initalized via inline message passing
// Utilises NSString length class function which does not include the null
// terminator
// Tests NSString instance method call leading to type
int main(int argc, const char *argv[]) {
  @autoreleasepool {
    NSData *data = [[NSData alloc] initWithBytes:"Hello" length:5];

    NSString *string = [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
  
    NSMutableData *data2 =
        // VULNERABILITY HERE: AllocOfStrlen
        [[NSMutableData alloc] initWithLength:[string length]];
  }
  return 0;
}