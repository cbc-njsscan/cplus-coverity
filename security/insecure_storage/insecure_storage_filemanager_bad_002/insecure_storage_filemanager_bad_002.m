#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *cacheFileLocation = @"oversecured.OVIA/Cache.db";

        NSURL *cacheDir = [[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask].firstObject;
        NSURL *cacheFile = [cacheDir URLByAppendingPathComponent:cacheFileLocation];

        NSURL *targetDir = [NSURL fileURLWithPath:@"/tmp/ExportedCache"];
        [targetDir startAccessingSecurityScopedResource];

        NSURL *destination = [targetDir URLByAppendingPathComponent:cacheFile.lastPathComponent];
        [[NSFileManager defaultManager] copyItemAtURL:cacheFile toURL:destination error:nil]; // VULNERABILITY HERE: InsecureStorage

        [targetDir stopAccessingSecurityScopedResource];

        NSLog(@"Cache file copied to: %@", destination.path);
    }
    return 0;
}
