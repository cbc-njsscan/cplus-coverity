#import <Foundation/Foundation.h>
#import <SAMKeychain/SAMKeychain.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {       
        NSString *password = [NSString stringWithUTF8String:argv[1]];
        NSString *serviceName = @"com.yourapp.identifier";
        NSString *account = @"userAccount";
        
        NSError *error = nil;
        BOOL success = [SAMKeychain setPassword:password forService:serviceName account:account error:&error]; // VULNERABILITY HERE: InsecureStorage
    }
    return 0;
}
