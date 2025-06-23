#import <Foundation/Foundation.h>
#include <string.h>

void stringCopy(NSString *userInput) {
  char buffer[16];
  // NO VULNERABILITY HERE: UnsafeFunctionStringHandling
  strncpy(buffer, [userInput UTF8String], [userInput length] + 1);
  NSLog(@"Copied string: %s", buffer);
}

void appendString(NSString *userInput) {
  char dest[4] = "hi, ";
  // NO VULNERABILITY HERE: UnsafeFunctionStringHandling
  strncat(dest, [userInput UTF8String], [userInput length] + 1);
  NSLog(@"Concatenated %@ to %s", userInput, dest);
}

int main(int argc, const char *argv[]) {
  @autoreleasepool {
    if (argc < 2) {
      NSLog(@"Usage: %s <input string>", argv[0]);
      return 1;
    }
    const char *userInput = argv[1];
    NSString *inputString = [NSString stringWithUTF8String:userInput];

    stringCopy(inputString);
    appendString(inputString);
  }
  return 0;
}
