#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *deviceIdKey = @"accountId";
        NSUbiquitousKeyValueStore *store = [NSUbiquitousKeyValueStore defaultStore];
        
        NSString *uuidString = [store stringForKey:deviceIdKey];
        NSUUID *uuid;
        
        if (uuidString) {
            uuid = [[NSUUID alloc] initWithUUIDString:uuidString];
        }
        
        if (!uuid) {
            uuid = [NSUUID UUID];
            [store setString:[uuid UUIDString] forKey:deviceIdKey]; // VULNERABILITY HERE: InsecureStorage
        }
        
    }
    return 0;
}