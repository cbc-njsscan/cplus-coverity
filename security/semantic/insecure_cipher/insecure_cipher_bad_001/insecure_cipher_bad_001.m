#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

// Example of using 3DES with CCCrypt()

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *plaintext = @"secret message";
        NSData *messageData = [plaintext dataUsingEncoding:NSUTF8StringEncoding];
        
        // Key (24 bytes)
        // VULNERABILITY HERE: HardcodedKey
        char keyData[24] = "123456789012345678901234";
        
        // IV (8 bytes)
        char ivData[8] = "12345678";
        
        size_t bufferSize = messageData.length + kCCBlockSize3DES;
        void *buffer = malloc(bufferSize);
        size_t encryptedSize = 0;
        
        // Encrypt with 3DES
        CCCryptorStatus result = CCCrypt(
            kCCEncrypt,               // Operation: encrypt
            // VULNERABILITY HERE: InsecureCipher
            kCCAlgorithm3DES,         // Algorithm: 3DES
            kCCOptionPKCS7Padding,    // Options: PKCS7 padding
            keyData,                  // Key
            kCCKeySize3DES,           // Key size
            ivData,                   // IV
            messageData.bytes,        // Input data
            messageData.length,       // Input data length
            buffer,                   // Output buffer
            bufferSize,               // Output buffer size
            &encryptedSize            // Output size
        );
        
        if (result == kCCSuccess) {
            NSData *encryptedData = [NSData dataWithBytesNoCopy:buffer 
                                                        length:encryptedSize 
                                                  freeWhenDone:YES];
            
            NSLog(@"Encrypted: %@", encryptedData);
            
            void *decryptBuffer = malloc(encryptedSize + kCCBlockSize3DES);
            size_t decryptedSize = 0;
            
            result = CCCrypt(
                kCCDecrypt,               // Operation: decrypt
                // VULNERABILITY HERE: InsecureCipher
                kCCAlgorithm3DES,         // Algorithm: 3DES
                kCCOptionPKCS7Padding,    // Options: PKCS7 padding
                keyData,                  // Key
                kCCKeySize3DES,           // Key size
                ivData,                   // IV
                encryptedData.bytes,      // Input data
                encryptedData.length,     // Input data length
                decryptBuffer,            // Output buffer
                encryptedSize + kCCBlockSize3DES, // Output buffer size
                &decryptedSize            // Output size
            );
            
            if (result == kCCSuccess) {
                NSData *decryptedData = [NSData dataWithBytesNoCopy:decryptBuffer 
                                                            length:decryptedSize 
                                                      freeWhenDone:YES];
                
                NSString *decryptedMessage = [[NSString alloc] initWithData:decryptedData 
                                                                  encoding:NSUTF8StringEncoding];
                NSLog(@"Decrypted: %@", decryptedMessage);
            } else {
                NSLog(@"Decryption failed with error %d", result);
                free(decryptBuffer);
            }
        } else {
            NSLog(@"Encryption failed with error %d", result);
            free(buffer);
        }
    }
    return 0;
}