#import <Foundation/Foundation.h>
#import <string.h>
// This suite of tests uses NSData init functions a string length method.

void truncates(const char *input) {
  // Appears as initWithBytesNoCopy:length:
  // VULNERABILITY HERE: AllocOfStrlen
  NSData *data = [[NSData alloc] initWithBytesNoCopy:(void *)input
                                              length:strlen(input)
                                        freeWhenDone:YES];
}

void no_truncates(const char *input) {
  size_t len = strlen(input);
  // VULNERABILITY HERE: AllocOfStrlen
  NSData *data = [[NSData alloc] initWithBytesNoCopy:(void *)input
                                              length:len
                                        freeWhenDone:YES];
}

int main(int argc, const char *argv[]) {
  @autoreleasepool {
    const char *str = "ImportantString";
    truncates(str);
    no_truncates(str);
  }
  return 0;
}