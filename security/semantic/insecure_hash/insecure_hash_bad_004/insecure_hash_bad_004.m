#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

// Using the _Init/_Update/_Final APIs vs the simpler CC_SHA1()

int main(int argc, const char * argv[]) {
  @autoreleasepool {
    NSString *plaintext = @"Plaintext to be hashed insecurely!";
    
    const char *plaintextStr = [plaintext UTF8String];
    unsigned long plaintextLength = strlen(plaintextStr);
    
    CC_SHA1_CTX context;

    // VULNERABILITY HERE: InsecureHash
    CC_SHA1_Init(&context);
    
    CC_SHA1_Update(&context, plaintextStr, (CC_LONG)plaintextLength);
    
    unsigned char sha1Hash[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1_Final(sha1Hash, &context);
    
    NSMutableString *hexString = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
      [hexString appendFormat:@"%02x", sha1Hash[i]];
    }
    
    NSLog(@"Original string: %@", plaintext);
    NSLog(@"SHA1 hash: %@", hexString);
  }
  return 0;
}