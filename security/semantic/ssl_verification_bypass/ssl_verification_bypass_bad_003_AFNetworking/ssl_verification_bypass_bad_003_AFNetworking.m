#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

// Using AFNetworking as target SSL certificate validator 
@interface YSessionManager : NSObject

+ (instancetype)sharedInstance;
- (AFHTTPSessionManager *)apiManager;

@end

@implementation YSessionManager {
    AFHTTPSessionManager *_manager;
}

+ (instancetype)sharedInstance {
    static YSessionManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[YSessionManager alloc] init];
    });
    return sharedInstance;
}

- (AFHTTPSessionManager *)apiManager {
    if (_manager) {
        return _manager;
    }

    NSString *hostURL = @"https://www.test.com";
    NSLog(@"\n HOST URL: %@", hostURL);

    // Create and initialise AFNetworking session manager
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:hostURL] sessionConfiguration:configuration];

    // Configure security policy for SSL pinning
    _manager.securityPolicy = [self customSecurityPolicyAllowInvalid];

    return _manager;
}

/// Fetching public keys from available Certificates for SSL Pinning
- (AFSecurityPolicy *)customSecurityPolicyAllowInvalid {
    NSString *certPath = [[NSBundle mainBundle] pathForResource:@"certificate" ofType:@"cer"];
    NSData *certData = [NSData dataWithContentsOfFile:certPath];

    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    securityPolicy.allowInvalidCertificates = YES;  // VULNERABILITY HERE: SSLVerificationBypass

    if (certData) {
        securityPolicy.pinnedCertificates = [NSSet setWithObject:certData];
    }

    return securityPolicy;
}

- (AFSecurityPolicy *)customSecurityPolicyNoValidation {
    NSString *certPath = [[NSBundle mainBundle] pathForResource:@"certificate" ofType:@"cer"];
    NSData *certData = [NSData dataWithContentsOfFile:certPath];

    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    securityPolicy.validatesDomainName = NO; // VULNERABILITY HERE: SSLVerificationBypass

    if (certData) {
        securityPolicy.pinnedCertificates = [NSSet setWithObject:certData];
    }

    return securityPolicy;
}

@end
