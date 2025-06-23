#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

int main(int argc, const char * argv[]) {
  @autoreleasepool {
    NSString *plaintext = @"Plaintext to be hashed insecurely!";
    
    const char *plaintextStr = [plaintext UTF8String];
    unsigned long plaintextLength = strlen(plaintextStr);
    
    unsigned char sha1Hash[CC_SHA1_DIGEST_LENGTH];
    
    // VULNERABILITY HERE: InsecureHash
    CC_SHA1(plaintextStr, (CC_LONG)plaintextLength, sha1Hash);
    
    NSMutableString *hexString = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
      [hexString appendFormat:@"%02x", sha1Hash[i]];
    }
    
    NSLog(@"Original string: %@", plaintext);
    NSLog(@"SHA1 hash: %@", hexString);
  }
  return 0;
}