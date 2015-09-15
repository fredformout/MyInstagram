//
//  MIDataProvider+Authentication.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 13.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIDataProvider+Authentication.h"
#import "MIFileUtility.h"
#import "MIImageCacheUtility.h"

@implementation MIDataProvider (Authentication)

#pragma mark - Others

- (NSString *)accessToken
{
    return [UICKeyChainStore sharedInstance][kAccessTokenKey];
}

- (NSURLRequest *)loginURLRequest
{
    NSDictionary *parameters = @{
                                 kClientIDKey : kInstagramClientID,
                                 kRedirectURIKey : kInstagramRedirectURI,
                                 kResponseTypeKey : kInstagramResponseType,
                                 kScopeKey : kInstagramScope
                                 };
    
    MIAPIRequest *request = [MIAPIRequest requestWithName:@"Authorize"
                                                      url:kInstagramAuthorizationURL
                                            isAbsoluteUrl:YES
                                            requestMethod:RequestMethodGET
                                               paramaters:parameters];
    
    return [[MIAPIDataManager sharedInstance] URLRequestWithRequest:request];
}

- (void)startNetworkMonitoring
{
    [MIAPIDataManager sharedInstance];
}

- (void)logoutWithCompletion:(void (^)(BOOL))completion
{
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    [[storage cookies] enumerateObjectsUsingBlock:^(NSHTTPCookie *cookie, NSUInteger idx, BOOL *stop)
    {
        [storage deleteCookie:cookie];
    }];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [UICKeyChainStore sharedInstance][kAccessTokenKey] = nil;
    
    [[MIAPIDataManager sharedInstance] cancelAllOperations];
    
    [[MIImageCacheUtility sharedInstance] cancelDownloadContentOperations];
    
    [[MILocalDataManager sharedInstance] clearData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
        [MIFileUtility deleteAllFiles];

        [[MIImageCacheUtility sharedInstance] clearCache];
    });

    if (completion)
    {
        completion(YES);
    }
}

- (void)processResponseWithURL:(NSURL *)url
                    completion:(void (^)(BOOL))completion
{
    BOOL success = NO;
    
    NSURL *redirectURL = [NSURL URLWithString:kInstagramRedirectURI];
    
    if ([redirectURL.scheme isEqualToString:url.scheme])
    {
        NSString *decodedString = [url.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSArray *components = [decodedString componentsSeparatedByString:@"#"];
        
        if ([components count] > 0)
        {
            NSString *token = [self queryStringParametersFromString:components[1]][kAccessTokenKey];
            
            if (token)
            {
                [UICKeyChainStore sharedInstance][kAccessTokenKey] = token;
                
                success = YES;
            }
        }
    }
    
    if (completion)
    {
        completion(success);
    }
}

- (NSDictionary *)queryStringParametersFromString:(NSString*)string
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [[string componentsSeparatedByString:@"&"] enumerateObjectsUsingBlock:^(NSString * param, NSUInteger idx, BOOL *stop)
     {
         NSArray *pairs = [param componentsSeparatedByString:@"="];
         
         if ([pairs count] != 2) return;
         
         NSString *key = [pairs[0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
         NSString *value = [pairs[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
         
         dict[key] = value;
     }];
    
    return dict;
}

@end
