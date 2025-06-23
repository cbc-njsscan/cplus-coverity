#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

// Tests that check for Configuration without Encryption

int example1(int argc, const char * argv[]) {
    @autoreleasepool {        
        // Generate a 64-byte encryption key
        NSMutableData *key = [NSMutableData dataWithLength:64];
        SecRandomCopyBytes(kSecRandomDefault, 64, key.mutableBytes);

        // Encrypted Realm configuration
        RLMRealmConfiguration *config1 = [[RLMRealmConfiguration alloc] init];
        config1.encryptionKey = key;

        NSError *error = nil;
        RLMRealm *realm1 = [RLMRealm realmWithConfiguration:config1 error:&error];

        // Perform a write transaction
        [realm1 transactionWithBlock:^{
            NSLog(@"Default Realm initialized and ready.");
        }];
    }
    return 0;
}

int example2(int argc, const char * argv[]) {
    @autoreleasepool {        
        // Realm configuration
        RLMRealmConfiguration *config2 = [[RLMRealmConfiguration alloc] init];
        config2.encryptionKey = nil;

        NSError *error = nil;
        RLMRealm *realm2 = [RLMRealm realmWithConfiguration:config2 error:&error]; // VULNERABILITY HERE: InsecureStorage
    }
    return 0;
}

int example3(int argc, const char * argv[]) {
    @autoreleasepool {        
        // Realm configuration
        RLMRealmConfiguration *config3 = [[RLMRealmConfiguration alloc] init];

        NSError *error = nil;
        RLMRealm *realm3 = [RLMRealm realmWithConfiguration:config3 error:&error]; // VULNERABILITY HERE: InsecureStorage
    }
    return 0;
}

// Dont report in-memory unencrypted databases
int example4(int argc, const char * argv[]) {
    @autoreleasepool {        
        // Realm configuration
        RLMRealmConfiguration *config4 = [[RLMRealmConfiguration alloc] init];
        config4.inMemoryIdentifier = @"in-memory";

        NSError *error = nil;
        RLMRealm *realm4 = [RLMRealm realmWithConfiguration:config4 error:&error];
    }
    return 0;
}

int example5(int argc, const char * argv[]) {
    @autoreleasepool {
        RLMRealmConfiguration *config5 = [[RLMRealmConfiguration alloc] init];
        config5.fileURL = [NSURL URLWithString:@"/tmp/myRealm.realm"];
        dispatch_queue_t realmQueue = dispatch_queue_create("com.example.realmQueue", DISPATCH_QUEUE_SERIAL);

        RLMRealm *realm5 = [RLMRealm realmWithConfiguration:config5 queue:realmQueue error:nil]; // VULNERABILITY HERE: InsecureStorage

        dispatch_async(realmQueue, ^{
            [realm5 transactionWithBlock:^{
                NSLog(@"Realm initialized.");
            }];
        });

        sleep(1); // Allow async operation to complete
    }
    return 0;
}

int example6(int argc, const char * argv[]) {
   @autoreleasepool {
        RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
        
        dispatch_queue_t realmQueue = dispatch_queue_create("com.example.realmAsyncQueue", DISPATCH_QUEUE_SERIAL);

        [RLMRealm asyncOpenWithConfiguration:config callbackQueue:realmQueue callback:^(RLMRealm *realm, NSError *error) { // VULNERABILITY HERE: InsecureStorage
            [realm transactionWithBlock:^{
                NSLog(@"Realm asynchronously opened and ready.");
            }];
        }];

        // Keep the main thread alive long enough for the async call
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2.0]];
    }
    return 0;
}


int example7(int argc, const char * argv[]) {
   @autoreleasepool {
        // Generate a 64-byte encryption key
        NSMutableData *key = [NSMutableData dataWithLength:64];
        SecRandomCopyBytes(kSecRandomDefault, 64, key.mutableBytes);

        // Encrypted Realm configuration
        RLMRealmConfiguration *config1 = [[RLMRealmConfiguration alloc] init];
        config1.encryptionKey = key;
        
        dispatch_queue_t realmQueue = dispatch_queue_create("com.example.realmAsyncQueue", DISPATCH_QUEUE_SERIAL);

        [RLMRealm asyncOpenWithConfiguration:config1 callbackQueue:realmQueue callback:^(RLMRealm *realm, NSError *error) {
            if (realm) {
                // Success: Do something with the realm
                [realm transactionWithBlock:^{
                    NSLog(@"Realm asynchronously opened and ready.");
                }];
            } else {
                // Handle error
                NSLog(@"Failed to open Realm: %@", error.localizedDescription);
            }
        }];

        // Keep the main thread alive long enough for the async call
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2.0]];
    }
    return 0;
}

