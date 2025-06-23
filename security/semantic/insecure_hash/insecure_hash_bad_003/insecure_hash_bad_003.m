#import <Foundation/Foundation.h>
#import <openssl/sha.h>

// Note - this is using the CPP OpenSSL support for InsecureHash

int main(int argc, const char * argv[]) {
  @autoreleasepool {
    NSString *plaintext = @"Plaintext to be hashed insecurely!";
    
    const char *plaintextStr = [plaintext UTF8String];
    unsigned long plaintextLength = strlen(plaintextStr);
    
    unsigned char sha1Hash[SHA_DIGEST_LENGTH];
    
    // VULNERABILITY HERE: InsecureHash
    SHA1((unsigned char*)plaintextStr, plaintextLength, sha1Hash);
    
    NSMutableString *hexString = [NSMutableString stringWithCapacity:SHA_DIGEST_LENGTH * 2];
    for (int i = 0; i < SHA_DIGEST_LENGTH; i++) {
      [hexString appendFormat:@"%02x", sha1Hash[i]];
    }
    
    NSLog(@"Original string: %@", plaintext);
    NSLog(@"SHA1 hash: %@", hexString);
  }
  return 0;
}