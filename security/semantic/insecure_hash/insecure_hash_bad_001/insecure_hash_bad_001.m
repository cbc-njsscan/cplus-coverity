#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

int main(int argc, const char * argv[]) {
  @autoreleasepool {
    NSString *plaintext = @"Plaintext to be hashed insecurely!";
    
    const char *plaintextStr = [plaintext UTF8String];
    unsigned long plaintextLength = strlen(plaintextStr);
    
    unsigned char md4Hash[CC_MD4_DIGEST_LENGTH];
    
    // VULNERABILITY HERE: InsecureHash
    CC_MD4(plaintextStr, (CC_LONG)plaintextLength, md4Hash);
    
    NSMutableString *hexString = [NSMutableString stringWithCapacity:CC_MD4_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD4_DIGEST_LENGTH; i++) {
      [hexString appendFormat:@"%02x", md4Hash[i]];
    }
    
    NSLog(@"Original string: %@", plaintext);
    NSLog(@"MD4 hash: %@", hexString);
  }
  return 0;
}