#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

// Tests that check for default Realm

// Minimal class to compile - mirrors RLMObject usage
@interface RequestData : RLMObject
@property NSString *key;
@property NSString *data;
@end

@implementation RequestData
@end

int example8 (int argc, const char * argv[]) {
    @autoreleasepool {
        // Get the default Realm instance
        RLMRealm *realm = [RLMRealm defaultRealm];

        // Perform a write transaction
        [realm transactionWithBlock:^{ // VULNERABILITY HERE: InsecureStorage
            NSLog(@"Default Realm initialized and ready.");
        }];
    }
    return 0;
}

int example9(int argc, const char * argv[]) {
    @autoreleasepool {
        // Create a background queue
        dispatch_queue_t realmQueue = dispatch_queue_create("com.example.realmQueue", DISPATCH_QUEUE_SERIAL);

        dispatch_async(realmQueue, ^{
            // Get the default Realm for the queue
            RLMRealm *realm1 = [RLMRealm defaultRealmForQueue:realmQueue];
            
            // Perform a write transaction
            [realm1 transactionWithBlock:^{ // VULNERABILITY HERE: InsecureStorage
                NSLog(@"Default Realm for queue initialized and ready.");
            }];
        });

        // Keep the process alive long enough for the async operation
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2.0]];
    }
    return 0;
}

int example10(int argc, const char * argv[]){
    @autoreleasepool {
        NSString *someData = @"Hello World!";
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction]; // VULNERABILITY HERE: InsecureStorage
        NSString *key = @"primary";
        RequestData *result = [RequestData objectForPrimaryKey:key];
        if (!result) {
            result = [[RequestData alloc] init];
            result.key = key;
        }
        result.data = someData;
        [realm addOrUpdateObject:result];
        [realm commitWriteTransaction];
    }
    return 0;
}