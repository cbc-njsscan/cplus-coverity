#import <Foundation/Foundation.h>
#import <CouchbaseLite/CouchbaseLite.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        CBLDatabase *database = [[CBLDatabase alloc] initWithName:@"mydb" error:nil];
        
        // Fetch document by ID
        CBLDocument *doc = [database documentWithID:@"doc1"];
        
        if (!doc) {
            return 1;
        }

        NSString *xmlString = [doc stringForKey:@"xmlContent"];
        
        if (!xmlString) {
            return 1;
        }

        NSData *xmlData = [xmlString dataUsingEncoding:NSUTF8StringEncoding];
        
        // VULNERABILITY HERE: XXE
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData];

        [parser setShouldResolveExternalEntities:YES];
        [parser parse];
        
    }
    return 0;
}
