#import <Foundation/Foundation.h>
#include <string.h>

@interface TestClass : NSObject
- (char *)userCopy:(char *)toCopy;
@end

@implementation TestClass
- (char *)userCopy:(char *)toCopy {
  char buffer[5];
  // NO VULNERABILITY HERE: TODO~GOS-3313~UnsafeFunctionStringHandling
  snprintf(buffer, sizeof(buffer), "XXXXX%s", toCopy);
  return buffer;
}
@end

void FunctionCopy(char *input) {
  char *buf[10];
  sprintf(buf, "XXX%s", input); // VULNERABILITY HERE: BufferOverflow
}

int main(int argc, const char *argv[]) {
  @autoreleasepool {
    if (argc < 2) {
      NSLog(@"Usage: %s <input string>", argv[0]);
      return 1;
    }
    char *userInput = argv[1];
    TestClass *test = [[TestClass alloc] init];
    char *output = [test userCopy:userInput];
    FunctionCopy(userInput);
    printf("%s", output);
  }
  return 0;
}