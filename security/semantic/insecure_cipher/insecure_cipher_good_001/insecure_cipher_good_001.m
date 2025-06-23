#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

// Example of using AES with CCCrypt()

int main(int argc, const char * argv[]) {
  @autoreleasepool {
    NSString *plaintext = @"secret message";
    NSData *messageData = [plaintext dataUsingEncoding:NSUTF8StringEncoding];
    
    // VULNERABILITY HERE: HardcodedKey
    char keyData[kCCKeySizeAES256] = "12345678901234567890123456789012";
    
    char ivData[kCCBlockSizeAES128] = "1234567890123456";
    
    size_t bufferSize = messageData.length + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t encryptedSize = 0;
    
    CCCryptorStatus result = CCCrypt(
      kCCEncrypt,           
      // NO VULNERABILITY HERE: InsecureCipher
      kCCAlgorithmAES,      
      kCCOptionPKCS7Padding,
      keyData,              
      kCCKeySizeAES256,     
      ivData,               
      messageData.bytes,    
      messageData.length,   
      buffer,               
      bufferSize,           
      &encryptedSize        
    );
    
    if (result == kCCSuccess) {
      NSData *encryptedData = [NSData dataWithBytesNoCopy:buffer 
                            length:encryptedSize 
                          freeWhenDone:YES];
      
      NSLog(@"Encrypted: %@", encryptedData);
      
      void *decryptBuffer = malloc(encryptedSize + kCCBlockSizeAES128);
      size_t decryptedSize = 0;
      
      result = CCCrypt(
        kCCDecrypt,           
        // NO VULNERABILITY HERE: InsecureCipher
        kCCAlgorithmAES,      
        kCCOptionPKCS7Padding,
        keyData,              
        kCCKeySizeAES256,     
        ivData,               
        encryptedData.bytes,  
        encryptedData.length, 
        decryptBuffer,        
        encryptedSize + kCCBlockSizeAES128,
        &decryptedSize
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