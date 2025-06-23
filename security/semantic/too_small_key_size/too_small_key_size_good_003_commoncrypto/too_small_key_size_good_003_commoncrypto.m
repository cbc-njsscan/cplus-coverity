#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonKeyDerivation.h>

@interface InsecureSecretTests : NSObject @end

// Using CommonCrypto symmetric ciphers with secure key sizes
@implementation InsecureSecretTests

- (void)testTooSmallKeySize_CCCrypt {
    // NO VULNERABILITY HERE: TooSmallKeySize
    uint8_t keyIn[16];
    for (int i = 0; i < 16; i++) {
        keyIn[i] = arc4random_uniform(256);
    }
    
    uint8_t input[16] = {0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
        0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff};

    NSMutableData *encryptedData = [NSMutableData dataWithLength:sizeof(input) + kCCBlockSizeAES128];
    size_t outLength;

    CCCrypt(kCCEncrypt, kCCAlgorithmAES,
        kCCOptionECBMode,
        keyIn, sizeof(keyIn), NULL, // VULNERABILITY HERE: InsecureSecret
        input, sizeof(input),
        encryptedData.mutableBytes, encryptedData.length, &outLength);
}

- (void)testTooSmallKeySize_KeyDerivation {
    // NO VULNERABILITY HERE: TooSmallKeySize
    char password[16];
    uint8_t salt[8];
    uint8_t derivedKey[8];

    for (int i = 0; i < sizeof(password) - 1; i++) {
        password[i] = rand() % 256;
    }
    password[sizeof(password) - 1] = '\0';
    SecRandomCopyBytes(kSecRandomDefault, sizeof(salt), salt);

    CCKeyDerivationPBKDF(kCCPBKDF2,
        password, strlen(password), // VULNERABILITY HERE: InsecureSecret
        salt, sizeof(salt),
        kCCPRFHmacAlgSHA256, 1000,
        derivedKey, sizeof(derivedKey));
}

@end
