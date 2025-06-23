#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

// Example of using RC4 with CCCryptorCreate(), as opposed to the more direct CCCrypt() used in other tests

int main(int argc, const char * argv[]) {
  @autoreleasepool {
    NSString *plaintext = @"secret message";
    NSData *messageData = [plaintext dataUsingEncoding:NSUTF8StringEncoding];
    
    // Key for RC4
    // VULNERABILITY HERE: HardcodedKey
    char keyData[16] = "1234567890123456";
    
    // Create buffer for encrypted data
    size_t bufferSize = messageData.length;
    void *buffer = malloc(bufferSize);
    size_t encryptedSize = 0;
    size_t updateSize = 0;
    
    // Create the RC4 cryptor
    CCCryptorRef cryptor;
    CCCryptorStatus result = CCCryptorCreate(
      kCCEncrypt,           
      // VULNERABILITY HERE: InsecureCipher
      kCCAlgorithmRC4,      
      0,                    // No padding
      keyData,              // Key
      16,                   // Key size
      NULL,                 // No IV
      &cryptor              // Cryptor reference
    );
    
    if (result == kCCSuccess) {
      // Encrypt with RC4
      CCCryptorUpdate(
        cryptor,
        messageData.bytes,
        messageData.length,
        buffer,
        bufferSize,
        &updateSize
      );
      
      // Finalize encryption
      CCCryptorFinal(
        cryptor,
        buffer + updateSize,
        bufferSize - updateSize,
        &encryptedSize
      );
      
      CCCryptorRelease(cryptor);
      
      encryptedSize += updateSize;
      
      NSData *encryptedData = [NSData dataWithBytesNoCopy:buffer 
                            length:encryptedSize 
                          freeWhenDone:YES];
      
      NSLog(@"Encrypted: %@", encryptedData);
      
      // Decrypt
      void *decryptBuffer = malloc(encryptedSize);
      size_t decryptedSize = 0;
      size_t decryptUpdateSize = 0;
      
      result = CCCryptorCreate(
        kCCDecrypt,           
        // VULNERABILITY HERE: InsecureCipher
        kCCAlgorithmRC4,      
        0,                    // No padding
        keyData,              // Key
        16,                   // Key size
        NULL,                 // No IV 
        &cryptor              // Cryptor reference
      );
      
      if (result == kCCSuccess) {
        CCCryptorUpdate(
          cryptor,
          encryptedData.bytes,
          encryptedData.length,
          decryptBuffer,
          encryptedSize,
          &decryptUpdateSize
        );
        
        CCCryptorFinal(
          cryptor,
          decryptBuffer + decryptUpdateSize,
          encryptedSize - decryptUpdateSize,
          &decryptedSize
        );
        
        CCCryptorRelease(cryptor);
        
        decryptedSize += decryptUpdateSize;
        
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