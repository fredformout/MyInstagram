//
//  MIAPIDataManager.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 09.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIAPIDataManager.h"
#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "MIAPIRequest.h"
#import "MIInstagramConstants.h"

NSString * const kNetworkAvailableNotificationName = @"NetworkAvailableNotification";
NSString * const kNetworkUnavailableNotificationName = @"NetworkUnavailableNotification";

@interface MIAPIDataManager ()

@property (nonatomic, strong) AFHTTPRequestOperationManager *operationManager;

@end

@implementation MIAPIDataManager

#pragma mark - Initialization

+ (instancetype)sharedInstance
{
    static MIAPIDataManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^
    {
        _sharedInstance = [MIAPIDataManager new];
    });
    
    return _sharedInstance;
}

#pragma mark - NSObject

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _operationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kInstagramBaseURL]];
        
        [_operationManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                case AFNetworkReachabilityStatusReachableViaWiFi:
                {
                    NSLog(@"Network is available =)");
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNetworkAvailableNotificationName
                                                                        object:nil];
                }
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                default:
                {
                    NSLog(@"Network is unavailable =(");
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNetworkUnavailableNotificationName
                                                                        object:nil];
                }
                    break;
            }
        }];
        
        [_operationManager.reachabilityManager startMonitoring];
    }
    
    return self;
}

#pragma mark - Others

- (void)startOperationWithRequest:(MIAPIRequest *)request
{
    NSMutableURLRequest *URLRequest = [self URLRequestWithRequest:request];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:URLRequest];
    
    if (request.responseSerializer == ResponseSerializerJSON)
    {
        operation.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [UIApplication sharedApplication ].networkActivityIndicatorVisible = NO;
         
         if (operation.isCancelled)
         {
             if (request.failureBlock)
             {
                 request.failureBlock(@"Operation canceled");
             }
         }
         else
         {
             if (request.successBlock)
             {
                 request.successBlock(responseObject, nil);
             }
         }
     }
                                     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [UIApplication sharedApplication ].networkActivityIndicatorVisible = NO;
         
         if (operation.isCancelled)
         {
             if (request.failureBlock)
             {
                 request.failureBlock(@"Operation canceled");
             }
         }
         else
         {
             if (request.failureBlock)
             {
                 request.failureBlock(error);
             }
         }
     }];
    
    [_operationManager.operationQueue addOperation:operation];
    
    [UIApplication sharedApplication ].networkActivityIndicatorVisible = YES;
}

- (void)cancelAllOperations
{
    [_operationManager.operationQueue cancelAllOperations];
}

- (BOOL)isReachable
{
    return _operationManager.reachabilityManager.reachable;
}

- (NSMutableURLRequest *)URLRequestWithRequest:(MIAPIRequest *)request
{
    NSString *fullURLString = request.isAbsoluteURL ? request.url : [NSString stringWithFormat:@"%@%@", kInstagramBaseURL, request.url];
    
    return  [_operationManager.requestSerializer requestWithMethod:[MIAPIDataManager methodNameForMethodType:request.requestMethod]
                                                         URLString:fullURLString
                                                        parameters:request.parameters
                                                             error:nil];
}

+ (NSString *)urlencodeString:(NSString *)string
{
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[string UTF8String];
    NSInteger sourceLen = strlen((const char *)source);
    
    for (int i = 0; i < sourceLen; ++i)
    {
        const unsigned char thisChar = source[i];
        
        if (thisChar == ' ')
        {
            [output appendString:@"+"];
        }
        else if (thisChar == '.'
                 || thisChar == '-'
                 || thisChar == '_'
                 || thisChar == '~'
                 || (thisChar >= 'a' && thisChar <= 'z')
                 || (thisChar >= 'A' && thisChar <= 'Z')
                 || (thisChar >= '0' && thisChar <= '9'))
        {
            [output appendFormat:@"%c", thisChar];
        }
        else
        {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

+ (NSString *)methodNameForMethodType:(RequestMethod)type
{
    NSString *result = nil;
    
    switch (type)
    {
        case RequestMethodGET:
            result = @"GET";
            break;
        case RequestMethodPOST:
            result = @"POST";
            break;
        case RequestMethodPUT:
            result = @"PUT";
            break;
        case RequestMethodDELETE:
            result = @"DELETE";
            break;
        default:
            break;
    }
    return result;
}

@end
