#import <Foundation/Foundation.h>
#import <string.h>

void TestNSMutableDataInheritance(const char *input) {
  NSMutableData *data = // VULNERABILITY HERE: AllocOfStrlen
      [[NSMutableData alloc] initWithBytesNoCopy:(void *)input
                                          length:strlen(input)];
  return;
}

int main(int argc, const char *argv[]) {
  @autoreleasepool {
    const char *str = "ImportantString";
    TestNSMutableDataInheritance(str);
  }
  return 0;
}
