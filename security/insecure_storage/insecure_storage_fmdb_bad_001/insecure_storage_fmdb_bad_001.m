#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>

void queue(NSString *sql) {
    // Open database
    FMDatabaseQueue *dbQueue = [FMDatabaseQueue databaseQueueWithPath:@"/path/to/database.sqlite"]; // VULNERABILITY HERE: InsecureStorage
    
    [dbQueue inDatabase:^(FMDatabase *db) {
        // Execute SQL statement
        [db executeUpdate:sql];
        
        // Execute SQL as a query (if needed)
        FMResultSet *result = [db executeQuery:sql];
        while ([result next]) {
            // Process query result if needed
        }
        [result close];
    }];
}
