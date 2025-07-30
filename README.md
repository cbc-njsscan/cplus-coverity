## objective-c-vuln-exampless
This repo contains examples of some common Objective C related security vulnerabilities

Vulnerabilities include
* Insecure Data Storage
* Buffer overflow
* Dereference of a NULL Pointer
* Use of Externally-Controlled Format String 
* Use of Hardcoded Cryptographic Key
* Use of a Broken or Risky Cryptographic Algorithm 
* Size Used as Index
* XML External Entity (XXE) Injection
* Use of Insufficiently Random Values

## Notes 


These programs have been tested 

```
clang \
-fsyntax-only \
-fobjc-arc \
-fmodules \
-Wno-deprecated-declarations \
-isysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX15.5.sdk \
-F /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX15.5.sdk/System/Library/Frameworks \
-I ./temp_headers_for_clang \
-I ./Pods/AFNetworking/AFNetworking \
-I ./Pods/Realm/include \
-I ./Pods/FMDB/src/fmdb \
-I ./Pods/SAMKeychain/Sources \
-I ./Pods/YapDatabase/YapDatabase \
-I ./Pods/RNCryptor-objc/RNCryptor \
-I /opt/homebrew/opt/openssl@3/include \
-F ./Pods/CouchbaseLite/macOS
```
