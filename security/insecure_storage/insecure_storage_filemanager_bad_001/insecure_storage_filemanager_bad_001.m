#import <Foundation/Foundation.h>

void crashIntermediateDate(NSString *folder) {
    NSString *url = [folder stringByAppendingPathComponent:@"crashhandler"];
    NSString *dateString = [NSString stringWithContentsOfFile:url encoding:NSUTF8StringEncoding error:nil];
    NSMutableArray *components = [[dateString componentsSeparatedByString:@" "] mutableCopy];

    // Create a new one with the updated contents
    NSData *fileData = [[components componentsJoinedByString:@" "] dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *attributes = @{NSFileProtectionKey: NSFileProtectionNone};
    [[NSFileManager defaultManager] createFileAtPath:url contents:fileData attributes:attributes]; // VULNERABILITY HERE: InsecureStorage
}
