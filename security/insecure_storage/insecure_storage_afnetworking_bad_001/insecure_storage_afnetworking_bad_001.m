#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Sample login info
        NSDictionary *signInInfo = @{@"username": @"user", @"password": @"pass"};
        NSURL *serverUrl = [NSURL URLWithString:@"http://example.com"];  // Removed the trailing period

        // Cache by default (default behavior)
        AFHTTPSessionManager *manager1 = [AFHTTPSessionManager manager];

        [manager1 POST:serverUrl.absoluteString // VULNERABILITY HERE: InsecureStorage
           parameters:signInInfo
              headers:nil
             progress:nil
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  NSLog(@"Response: %@", responseObject);
              } failure:^(NSURLSessionDataTask *task, NSError *error) {
                  NSLog(@"Error: %@", error.localizedDescription);
              }];
        
        // Cache explicitly (using NSURLCache configuration)
        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024 // 10 MB
                                                          diskCapacity:50 * 1024 * 1024  // 50 MB
                                                              diskPath:nil];
        [NSURLCache setSharedURLCache:cache];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager POST:serverUrl.absoluteString // VULNERABILITY HERE: InsecureStorage
           parameters:signInInfo
              headers:nil
             progress:nil
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  NSLog(@"Cached Response: %@", responseObject);
              } failure:^(NSURLSessionDataTask *task, NSError *error) {
                  NSLog(@"Error: %@", error.localizedDescription);
              }];
        
        // Cache disabled (disable caching by setting cache policy)
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        config.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        AFHTTPSessionManager *managerNoCache = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:config];
        [managerNoCache POST:serverUrl.absoluteString
                   parameters:signInInfo
                      headers:nil
                     progress:nil
                      success:^(NSURLSessionDataTask *task, id responseObject) {
                          NSLog(@"No Cache Response: %@", responseObject);
                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                          NSLog(@"Error: %@", error.localizedDescription);
                      }];
        
        // Keep the main thread alive to receive async responses
        [[NSRunLoop currentRunLoop] run];
    }
    return 0;
}
