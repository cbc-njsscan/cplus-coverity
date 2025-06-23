#import <Foundation/Foundation.h>

int example1(int argc, const char * argv[]) {
  @autoreleasepool {
    {
      NSString *someText = @"Put some string here";
      NSString *destinationPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"MyFile.txt"];
      NSError *error = nil;
      NSData *stringData = [someText dataUsingEncoding:NSUTF8StringEncoding];
      BOOL write = [stringData writeToFile:destinationPath // VULNERABILITY HERE: InsecureStorage
                                   options:NSDataWritingFileProtectionNone
                                     error:&error];
    }
  }
  return 0;
}

int example2(int argc, const char * argv[]) {
  @autoreleasepool {
    {
      NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"MyFile.txt"];
      NSArray *arrayOfNames = @[@"Steve", @"John", @"Edward"];
      NSData *data = [NSPropertyListSerialization dataWithPropertyList:arrayOfNames format:NSPropertyListBinaryFormat_v1_0 options:0 error:nil];
      NSError *error = nil;

      BOOL write = [data writeToFile:path options:NSDataWritingFileProtectionCompleteUntilFirstUserAuthentication error:&error]; // VULNERABILITY HERE: InsecureStorage
    }
  }
  return 0;
}

int example3(int argc, const char * argv[]) {
  @autoreleasepool {
    {
      NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"MyFile.txt"];
      NSError *error = nil;
      
      NSData *helloData = [@"Hello, World!" dataUsingEncoding:NSUTF8StringEncoding];
      BOOL write = [helloData writeToFile:path // VULNERABILITY HERE: InsecureStorage
                                   options:NSDataWritingFileProtectionNone
                                     error:&error];
    }
  }
  return 0;
}

int example4(int argc, const char * argv[]) {
  @autoreleasepool {
    {
      NSString *someText = @"Put some string here";
      NSURL *destinationURL = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:@"MyFile.txt"]];
      NSError *error = nil;
      
      NSData *textData = [someText dataUsingEncoding:NSUTF8StringEncoding];
      BOOL write = [textData writeToURL:destinationURL // VULNERABILITY HERE: InsecureStorage
                               options:NSDataWritingFileProtectionCompleteUntilFirstUserAuthentication
                                 error:&error];
    }
  }
  return 0;
}

int example5(int argc, const char * argv[]) {
  @autoreleasepool {
    {
      NSString *someText = @"Put some string here";
      NSURL *destinationURL = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:@"MyFile.txt"]];
      NSError *error = nil;
      
      NSData *textData2 = [someText dataUsingEncoding:NSUTF8StringEncoding];
      BOOL write = [textData2 writeToURL:destinationURL // VULNERABILITY HERE: InsecureStorage
                               options:NSDataWritingFileProtectionNone
                                 error:&error];
    }
  }
  return 0;
}