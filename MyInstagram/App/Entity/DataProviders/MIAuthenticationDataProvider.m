//
//  MILoginDataProvider.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 10.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIAuthenticationDataProvider.h"
#import "MIAPIBaseRequest.h"
#import "MIAPIDataManager.h"
#import "UICKeyChainStore+SharedInstance.h"
#import "MIInstagramConstants.h"

@implementation MIAuthenticationDataProvider

#pragma mark - Others

+ (void)startNetworkMonitoring
{
    [MIAPIDataManager sharedInstance];
}

+ (NSString *)accessToken
{
    return [UICKeyChainStore sharedInstance][kAccessTokenKey];
}

+ (NSURLRequest *)loginURLRequest
{
    MIAPIBaseRequest *request = [MIAPIBaseRequest new];
    request.name = @"Authorize";
    request.url = kInstagramAuthorizationURL;
    request.isAbsoluteURL = YES;
    request.parameters = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                         kClientIDKey : kInstagramClientID,
                                                                         kRedirectURIKey : kInstagramRedirectURI,
                                                                         kResponseTypeKey : kInstagramResponseType,
                                                                         kScopeKey : kInstagramScope
                                                                         }];
    request.requestMethod = RequestMethodGET;
    
    return [[MIAPIDataManager sharedInstance] URLRequestWithRequest:request];
}

+ (void)logoutWithCompletion:(void (^)(BOOL))completion
{
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    [[storage cookies] enumerateObjectsUsingBlock:^(NSHTTPCookie *cookie, NSUInteger idx, BOOL *stop)
    {
        [storage deleteCookie:cookie];
    }];
    
    [UICKeyChainStore sharedInstance][kAccessTokenKey] = nil;
    
    //TODO delete all cache
    
    if (completion)
    {
        completion(YES);
    }
}

+ (void)processResponseWithURL:(NSURL *)url
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

+ (NSDictionary *)queryStringParametersFromString:(NSString*)string
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
