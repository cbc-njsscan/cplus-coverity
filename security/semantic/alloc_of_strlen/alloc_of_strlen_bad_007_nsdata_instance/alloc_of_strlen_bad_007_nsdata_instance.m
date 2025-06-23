#import <Foundation/Foundation.h>
#import <string.h>

// This suite of tests uses NSData init instance methods which take length as an
// initialising parameter.
void test1(const char *input) {
  // VULNERABILITY HERE: AllocOfStrlen
  NSData *data = [[NSData alloc] initWithBytesNoCopy:(void *)input
                                              length:strlen(input)
                                        freeWhenDone:YES];
}

void test2(const char *input) {

  NSData *data = // VULNERABILITY HERE: AllocOfStrlen
      [[NSData alloc] initWithBytesNoCopy:(void *)input
                                   length:strlen(input)
                              deallocator:^(void *bytes, NSUInteger length) {
                                free(bytes);
                              }];
}

void test3(const char *input) {
  // VULNERABILITY HERE: AllocOfStrlen
  NSData *data = [[NSData alloc] initWithBytesNoCopy:(void *)input
                                              length:strlen(input)];
}

void test4(const char *input) {
  // VULNERABILITY HERE: AllocOfStrlen
  NSData *data = [[NSData alloc] initWithBytes:(void *)input
                                        length:strlen(input)];
}

int main(int argc, const char *argv[]) {
  @autoreleasepool {
    const char *str = "ImportantString";
    test1(str);
    test2(str);
    test3(str);
    test4(str);
  }
  return 0;
}