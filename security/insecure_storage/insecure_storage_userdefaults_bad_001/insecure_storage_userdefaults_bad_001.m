#import <Foundation/Foundation.h>

int exmaple1(int argc, const char * argv[]) {
    @autoreleasepool {
        // Define password key
        NSString *passwordKey = @"password";
        
        // Get password input
        NSString *password = [NSString stringWithUTF8String:argv[1]];
        
        // Set value in NSUserDefaults
        [[NSUserDefaults standardUserDefaults] setObject:password forKey:passwordKey]; // VULNERABILITY HERE: InsecureStorage
    }
    return 0;
}

int example2(int argc, const char * argv[]) {
    @autoreleasepool {      
        // Get password input
        NSString *password = [NSString stringWithUTF8String:argv[1]];
        
        // Set value in NSUserDefaults
        [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"password"]; // VULNERABILITY HERE: InsecureStorage
    }
    return 0;
}

int example3(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // Get account input
        NSString *account = [NSString stringWithUTF8String:argv[1]];
        
        // Set value in NSUserDefaults
        [[NSUserDefaults standardUserDefaults] setURL:account forKey:@"account"]; // VULNERABILITY HERE: InsecureStorage
    }
    return 0;
}

int example4(int argc, const char * argv[]) {
    @autoreleasepool {
        // Define account key
        NSString *accountKey = @"account";
        
        // Get account input
        NSString *account = [NSString stringWithUTF8String:argv[1]];
        
        // Set value in NSUserDefaults
        [[NSUserDefaults standardUserDefaults] setURL:account forKey:accountKey]; // VULNERABILITY HERE: InsecureStorage
    }
    return 0;
}
