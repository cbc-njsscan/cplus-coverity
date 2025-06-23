#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Example sensitive data
        NSDictionary *credentials = @{
            @"username": @"admin",
            @"password": @"supersecret123"
        };

        // Path to plist file
        NSString *plistPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Credentials.plist"];

        // Write plaintext credentials to plist file
        [credentials writeToFile:plistPath atomically:YES]; // VULNERABILITY HERE: InsecureStorage
    }
    return 0;
}

