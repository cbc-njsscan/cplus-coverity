// Adapted from
// ~ https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory#2923296
// For now, we should consider the defaults secure for this vuln, as iOS >= 12.2 use TLS 1.3 by default.
// ~ https://support.apple.com/en-au/guide/security/sec100a75d12/web
#import <Foundation/Foundation.h>
#if !__has_include(<UIKit/UIKit.h>)
@interface UIViewController : NSObject @end
#endif

@interface MyViewController : UIViewController
- (void)startLoad;
- (void)handleClientError:(NSError *)error;
- (void)handleServerError:(NSURLResponse *)response;
@end

@implementation MyViewController

- (void)startLoad {
    NSURL *url = [NSURL URLWithString:@"https://www.example.com/"];
    NSURLSessionConfiguration *unsafeConfig = [NSURLSessionConfiguration defaultSessionConfiguration];

    // Set session to TLS 1.2, which is safe
    unsafeConfig.TLSMinimumSupportedProtocolVersion = tls_protocol_version_TLSv12;
    NSURLSession *unsafeSession = [NSURLSession sessionWithConfiguration:unsafeConfig];

    // NO VULNERABILITY HERE: TLS
    NSURLSessionDataTask *task = [unsafeSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            [self handleClientError:error];
            return;
        }

        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (![httpResponse isKindOfClass:[NSHTTPURLResponse class]] || !(httpResponse.statusCode >= 200 && httpResponse.statusCode <= 299)) {
            [self handleServerError:response];
            return;
        }
    }];
    [task resume];
}

@end
