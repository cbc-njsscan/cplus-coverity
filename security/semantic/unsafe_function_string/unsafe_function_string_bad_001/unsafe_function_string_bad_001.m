#import <Foundation/Foundation.h>
#include <string.h>
const char *toCopy[] = {"test", "test2"};
void stringCopy() {
  char *buffer;
  // VULNERABILITY HERE: UnsafeFunctionStringHandling
  strcpy(buffer, toCopy[0]);
  NSLog(@"Copied string: %s", buffer);
}

void appendString() {
  char *dest = "hi ";
  // VULNERABILITY HERE: UnsafeFunctionStringHandling
  strcat(dest, toCopy[1]);
}

int main(int argc, const char *argv[]) {
  @autoreleasepool {

    stringCopy();
    appendString();
  }
  return 0;
}
