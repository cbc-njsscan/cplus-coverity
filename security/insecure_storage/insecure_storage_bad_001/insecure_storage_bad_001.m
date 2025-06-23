#import <Foundation/Foundation.h>
#import <sqlite3.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        const char *sqlStr = NULL;
        sqlite3 *db;

        sqlite3_open("path/to/db.sqlite3", &db); // VULNERABILITY HERE: InsecureStorage
    }
    return 0;
}
