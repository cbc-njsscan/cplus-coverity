#import <Foundation/Foundation.h>
#import <string.h>

const char *str = "ImportantString";

void dataWithLengthTest() {
  const int len = strlen(str) + 1;
  // NO VULNERABILITY HERE: AllocOfStrlen
  NSMutableData *data = [NSMutableData dataWithLength:len];
  printf("Data length: %lu\n", (unsigned long)data.length);

  Byte *theBytes = [data mutableBytes];

  memcpy(theBytes, str, len);
  printf("%s\n", (char *)theBytes);
}

void dataWithCapacityTest() {
  const int len = strlen(str) + 1;
  // NO VULNERABILITY HERE: AllocOfStrlen
  NSMutableData *data = [NSMutableData dataWithCapacity:len];
  printf("Data length: %lu\n", (unsigned long)data.length);

  Byte *theBytes = [data mutableBytes];

  memcpy(theBytes, str, len);
  printf("%s\n", (char *)theBytes);
}

void initWithLengthTest() {
  const int len = strlen(str) + 1;
  // NO VULNERABILITY HERE: AllocOfStrlen
  NSMutableData *data = [[NSMutableData alloc] initWithLength:len];
  [data appendBytes:str length:len];
  NSLog(@"After appending, data length: %lu", (unsigned long)[data length]);
}

void initWithCapacityTest() {
  const int len = strlen(str) + 1;
  // NO VULNERABILITY HERE: AllocOfStrlen
  NSMutableData *data = [[NSMutableData alloc] initWithCapacity:len];
  [data appendBytes:str length:len];
  NSLog(@"After appending, data length: %lu", (unsigned long)[data length]);
}

int main(int argc, const char *argv[]) {
  @autoreleasepool {
    dataWithLengthTest();
    dataWithCapacityTest();
    initWithCapacityTest();
    initWithLengthTest();
  }
  return 0;
}