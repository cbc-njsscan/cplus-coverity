#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSURL *url = [NSURL URLWithString:@"https://example.com/data.json"];
        NSURLSession *session = [NSURLSession sharedSession];
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url
                                                completionHandler:^(NSData * _Nullable data,
                                                                    NSURLResponse * _Nullable response,
                                                                    NSError * _Nullable error) {

            // VULNERABILITY HERE: XXE
            NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
            [parser setShouldResolveExternalEntities:YES];
            [parser parse];
            
        }];
        
        [dataTask resume];
        
        // Keep the main runloop running to wait for async callback
        [[NSRunLoop currentRunLoop] run];
    }
    return 0;
}
