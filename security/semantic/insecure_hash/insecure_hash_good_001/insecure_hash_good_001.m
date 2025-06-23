#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

int main(int argc, const char * argv[]) {
  @autoreleasepool {
    NSString *plaintext = @"Plaintext to be hashed insecurely!";
    
    const char *plaintextStr = [plaintext UTF8String];
    unsigned long plaintextLength = strlen(plaintextStr);
    
    unsigned char sha256Hash[CC_SHA256_DIGEST_LENGTH];
    
    // NO VULNERABILITY HERE: InsecureHash
    CC_SHA256(plaintextStr, (CC_LONG)plaintextLength, sha256Hash);
    
    NSMutableString *hexString = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
      [hexString appendFormat:@"%02x", sha256Hash[i]];
    }
    
    NSLog(@"Original string: %@", plaintext);
    NSLog(@"SHA256 hash: %@", hexString);
  }
  return 0;
}