#import <Foundation/Foundation.h>
#import <string.h>

void TestNSMutableDataInheritance(const char *input) {
  // We malloc here as `freeWhenDone` requires a malloc'd buffer when the
  // argument is true.
  // VULNERABILITY HERE: AllocOfStrlen
  char *buf = malloc(strlen(input));
  memcpy(buf, input, strlen(input));
  // VULNERABILITY HERE: AllocOfStrlen
  NSMutableData *data = [NSMutableData dataWithBytesNoCopy:buf
                                                    length:strlen(input)];
}

int main(int argc, const char *argv[]) {
  @autoreleasepool {
    const char *str = "ImportantString";
    TestNSMutableDataInheritance(str);
  }
  return 0;
}
