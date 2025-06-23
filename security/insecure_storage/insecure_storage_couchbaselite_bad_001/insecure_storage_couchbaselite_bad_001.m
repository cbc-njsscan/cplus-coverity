#import <Foundation/Foundation.h>
#import <CouchbaseLite/CouchbaseLite.h>

int example1(int argc, const char * argv[]) {
    @autoreleasepool {
        NSError *error;
        NSString *dbName = @"my-database";
        CBLDatabase *database = [[CBLDatabase alloc] initWithName:dbName config:nil error:&error]; // VULNERABILITY HERE: InsecureStorage

        if (!database) {
            NSLog(@"Cannot open the database: %@", error);
            return 1;
        }
    }
    return 0;
}

int example2(int argc, const char * argv[]) {
    @autoreleasepool {
        NSError *error;
        NSString *dbName = @"my-database";
        CBLDatabase *database = [[CBLDatabase alloc] initWithName:dbName error:&error]; // VULNERABILITY HERE: InsecureStorage

        if (!database) {
            NSLog(@"Cannot open the database: %@", error);
            return 1;
        }
    }
    return 0;
}