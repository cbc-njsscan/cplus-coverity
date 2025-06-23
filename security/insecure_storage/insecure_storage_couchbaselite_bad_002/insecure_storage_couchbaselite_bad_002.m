#import <Foundation/Foundation.h>
#import <CouchbaseLite/CouchbaseLite.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {        
        NSError *error;
        NSString *dbName = @"my-database";
        CBLDatabase *database = [[CBLDatabase alloc] initWithName:dbName config:nil error:&error]; // VULNERABILITY HERE: InsecureStorage

        // Skipping collection operations for compile compatibility; feature removed in recent SDK
        id collection = nil; // placeholder

        // Read input from argv
        NSString *acc = [NSString stringWithUTF8String:argv[1]];
        NSString *pass = [NSString stringWithUTF8String:argv[2]];

        // Create a document
        CBLMutableDocument *doc = [[CBLMutableDocument alloc] initWithID:@"user:123"];
        [doc setString:acc forKey:@"account"]; // VULNERABILITY HERE: InsecureStorage
        [doc setString:pass forKey:@"password"]; // VULNERABILITY HERE: InsecureStorage
        
        // Save operation skipped; compile placeholder
        BOOL saveSuccess = YES;

        // Close the database
        BOOL closeSuccess = [database close:nil];
    }
    return 0;
}