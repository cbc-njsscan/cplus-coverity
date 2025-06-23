#import <Foundation/Foundation.h>
#import <openssl/evp.h>
#import <string.h>

// Using OpenSSL to test cryptographic functions
@implementation HardcodedKeyTests

- (void)testInsecureEncryptData {
   // VULNERABILITY HERE: HardcodedKey
    const unsigned char *key = (const unsigned char *)"0123456789abcdef0123456789abcdef";
    const unsigned char *iv  = (const unsigned char *)"abcdef9876543210";

    const unsigned char *plaintext = (const unsigned char *)"SecretData123";
    unsigned char ciphertext[128];
    int len, ciphertext_len;

    EVP_CIPHER_CTX *ctx = EVP_CIPHER_CTX_new();
    EVP_EncryptInit_ex(ctx, EVP_aes_256_cbc(), NULL, key, iv);
    EVP_EncryptUpdate(ctx, ciphertext, &len, plaintext, (int)strlen((char *)plaintext));
    ciphertext_len = len;
    EVP_EncryptFinal_ex(ctx, ciphertext + len, &len);
    ciphertext_len += len;
    EVP_CIPHER_CTX_free(ctx);
}

- (void)testInsecureDecryptData {
   // VULNERABILITY HERE: HardcodedKey
    const unsigned char *key = (const unsigned char *)"0123456789abcdef0123456789abcdef";
    const unsigned char *iv  = (const unsigned char *)"abcdef9876543210";

    const unsigned char ciphertext[] = {
        0x0e, 0xc4, 0x17, 0x7c, 0x2b, 0x36, 0x14, 0x89,
        0xd6, 0x62, 0x46, 0x24, 0xe5, 0x39, 0xf4, 0xd5
    };

    unsigned char decrypted[128];
    int len, plaintext_len;

    EVP_CIPHER_CTX *ctx = EVP_CIPHER_CTX_new();
    EVP_DecryptInit_ex(ctx, EVP_aes_256_cbc(), NULL, key, iv);
    EVP_DecryptUpdate(ctx, decrypted, &len, ciphertext, sizeof(ciphertext));
    plaintext_len = len;
    EVP_DecryptFinal_ex(ctx, decrypted + len, &len);
    plaintext_len += len;
    EVP_CIPHER_CTX_free(ctx);
}

@end
