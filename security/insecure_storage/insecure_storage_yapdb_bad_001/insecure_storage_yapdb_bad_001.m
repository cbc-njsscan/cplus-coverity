#import <Foundation/Foundation.h>
#import <YapDatabase/YapDatabase.h>

int example1(int argc, const char * argv[]) {
    @autoreleasepool {
        // Initialise db path
        NSString *dbPath = @"/tmp/testDatabase.sqlite";
        NSURL *dbURL = [NSURL fileURLWithPath:dbPath];
        YapDatabase *database = [[YapDatabase alloc] initWithURL:dbURL];

        // Open a transaction to write to the database
        YapDatabaseConnection *connection = [database newConnection];
        
        // Read input from argv
        NSString *username = [NSString stringWithUTF8String:argv[1]];
        NSString *email = [NSString stringWithUTF8String:argv[2]];

        // Create user info dictionary from input
        NSDictionary *userInfo = @{@"username": username, @"email": email};

        // Write data to the database
        [connection readWriteWithBlock:^(YapDatabaseReadWriteTransaction *transaction) { 
            [transaction setObject:userInfo forKey:@"password" inCollection:nil]; // VULNERABILITY HERE: InsecureStorage
        }];
    }
    return 0;
}

int example2(int argc, const char * argv[]) {
    @autoreleasepool {
        // Initialise db path
        NSString *dbPath = @"/tmp/testDatabase.sqlite";
        NSURL *dbURL = [NSURL fileURLWithPath:dbPath];
        YapDatabase *database = [[YapDatabase alloc] initWithURL:dbURL];

        // Open a transaction to write to the database
        YapDatabaseConnection *connection = [database newConnection];
        
        // Read input from argv
        NSString *key = @"password";
        NSString *username = [NSString stringWithUTF8String:argv[1]];
        NSString *email = [NSString stringWithUTF8String:argv[2]];

        // Create user info dictionary from input
        NSDictionary *userInfo = @{@"username": username, @"email": email};

        // Write data to the database
        [connection readWriteWithBlock:^(YapDatabaseReadWriteTransaction *transaction) { 
            [transaction setObject:userInfo forKey:key inCollection:nil]; // VULNERABILITY HERE: InsecureStorage
        }];
    }
    return 0;
}