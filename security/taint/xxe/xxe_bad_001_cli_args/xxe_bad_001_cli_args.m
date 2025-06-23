#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
    if (argc < 2) {
        return 1;
    }

    NSString *cli_tainted = [NSString stringWithUTF8String:argv[1]]; 

    NSURL *xmlURL = [NSURL URLWithString:cli_tainted];

    // VULNERABILITY HERE: XXE
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];

    [parser setShouldResolveExternalEntities:YES];
    [parser parse];

    return 0;
    }
}
