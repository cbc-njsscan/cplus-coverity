#import <Foundation/Foundation.h>
#import <Security/Security.h>

#ifndef XCTAssert
#define XCTAssert(condition) ((void)(condition))
#define XCTAssertNotNil(condition) ((void)(condition))
#endif

@interface HardcodedKeyTests : NSObject @end

// Using Security framework RSA ciphers with secure key sizes
@implementation HardcodedKeyTests

- (void)testSecKeyGeneratePairRSA {
    NSDictionary *params = @{
        (__bridge id)kSecAttrKeyType: (__bridge id)kSecAttrKeyTypeRSA,
        (__bridge id)kSecAttrKeySizeInBits: @3072,
        (__bridge id)kSecPrivateKeyAttrs: @{
            (__bridge id)kSecAttrIsPermanent: @NO
        },
        (__bridge id)kSecPublicKeyAttrs: @{
            (__bridge id)kSecAttrIsPermanent: @NO
        }
    };

    SecKeyRef publicKey = NULL;
    SecKeyRef privateKey = NULL;

    // NO VULNERABILITY HERE: TooSmallKeySize
    OSStatus status = SecKeyGeneratePair((__bridge CFDictionaryRef)params, &publicKey, &privateKey);
    XCTAssert(status == errSecSuccess);
    XCTAssertNotNil(publicKey);
    XCTAssertNotNil(privateKey);

    if (publicKey) CFRelease(publicKey);
    if (privateKey) CFRelease(privateKey);
}

- (void)testSecKeyCreateRandomKeyRSA {
    NSDictionary *params = @{
        (__bridge id)kSecAttrKeyType: (__bridge id)kSecAttrKeyTypeRSA,
        (__bridge id)kSecAttrKeySizeInBits: @4096,
        (__bridge id)kSecAttrIsPermanent: @NO
    };

    CFErrorRef error = NULL;
    
    // NO VULNERABILITY HERE: TooSmallKeySize
    SecKeyRef privateKey = SecKeyCreateRandomKey((__bridge CFDictionaryRef)params, &error);
    XCTAssertNotNil(privateKey);

    SecKeyRef publicKey = SecKeyCopyPublicKey(privateKey);
    XCTAssertNotNil(publicKey);

    if (privateKey) CFRelease(privateKey);
    if (publicKey) CFRelease(publicKey);
    if (error) CFRelease(error);
}


// Using Security framework AES ciphers with secure key sizes
- (void)testSecKeyGeneratePairAES {
    NSDictionary *params = @{
        (__bridge id)kSecAttrKeyType: (__bridge id)kSecAttrKeyTypeAES,
        (__bridge id)kSecAttrKeySizeInBits: @256,
        (__bridge id)kSecPrivateKeyAttrs: @{
            (__bridge id)kSecAttrIsPermanent: @NO
        },
        (__bridge id)kSecPublicKeyAttrs: @{
            (__bridge id)kSecAttrIsPermanent: @NO
        }
    };

    SecKeyRef publicKey = NULL;
    SecKeyRef privateKey = NULL;

    // NO VULNERABILITY HERE: TooSmallKeySize
    OSStatus status = SecKeyGeneratePair((__bridge CFDictionaryRef)params, &publicKey, &privateKey);
    XCTAssert(status == errSecSuccess);
    XCTAssertNotNil(publicKey);
    XCTAssertNotNil(privateKey);

    if (publicKey) CFRelease(publicKey);
    if (privateKey) CFRelease(privateKey);
}

- (void)testSecKeyCreateRandomKeyAES {
    NSDictionary *params = @{
        (__bridge id)kSecAttrKeyType: (__bridge id)kSecAttrKeyTypeAES,
        (__bridge id)kSecAttrKeySizeInBits: @128,
        (__bridge id)kSecAttrIsPermanent: @NO
    };

    CFErrorRef error = NULL;

    // NO VULNERABILITY HERE: TooSmallKeySize
    SecKeyRef privateKey = SecKeyCreateRandomKey((__bridge CFDictionaryRef)params, &error);
    XCTAssertNotNil(privateKey);

    SecKeyRef publicKey = SecKeyCopyPublicKey(privateKey);
    XCTAssertNotNil(publicKey);

    if (privateKey) CFRelease(privateKey);
    if (publicKey) CFRelease(publicKey);
    if (error) CFRelease(error);
}

@end
