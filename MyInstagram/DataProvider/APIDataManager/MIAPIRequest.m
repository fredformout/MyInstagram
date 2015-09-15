//
//  MIAPIBaseRequest.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 09.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIAPIRequest.h"
#import "MIInstagramConstants.h"

@implementation MIAPIRequest

#pragma mark - Others

+ (MIAPIRequest *)requestWithName:(NSString *)name
                          baseUrl:(NSString *)baseUrl
                              url:(NSString *)url
                    isAbsoluteUrl:(BOOL)isAbsoluteUrl
                    requestMethod:(RequestMethod)requestMethod
               responseSerializer:(ResponseSerializer)responseSerializer
                       paramaters:(NSDictionary *)paramaters
                     successBlock:(APIRequestSuccessBlock)successBlock
                     failureBlock:(APIRequestFailureBlock)failureBlock
{
    MIAPIRequest *request = [MIAPIRequest new];
    
    request.name = name;
    request.baseUrl = baseUrl;
    request.url = url;
    request.isAbsoluteURL = isAbsoluteUrl;
    request.requestMethod = requestMethod;
    request.responseSerializer = responseSerializer;
    request.parameters = paramaters;
    request.successBlock = successBlock;
    request.failureBlock = failureBlock;
    
    return request;
}

+ (MIAPIRequest *)requestWithName:(NSString *)name
                              url:(NSString *)url
                    isAbsoluteUrl:(BOOL)isAbsoluteUrl
                    requestMethod:(RequestMethod)requestMethod
               responseSerializer:(ResponseSerializer)responseSerializer
                     successBlock:(APIRequestSuccessBlock)successBlock
                     failureBlock:(APIRequestFailureBlock)failureBlock;
{
    return [self requestWithName:name
                         baseUrl:kInstagramBaseURL
                             url:url
                   isAbsoluteUrl:isAbsoluteUrl
                   requestMethod:requestMethod
              responseSerializer:responseSerializer
                      paramaters:[NSDictionary dictionary]
                    successBlock:successBlock
                    failureBlock:failureBlock];
}

+ (MIAPIRequest *)requestWithName:(NSString *)name
                              url:(NSString *)url
                    requestMethod:(RequestMethod)requestMethod
                       paramaters:(NSDictionary *)paramaters
                     successBlock:(APIRequestSuccessBlock)successBlock
                     failureBlock:(APIRequestFailureBlock)failureBlock
{
    return [self requestWithName:name
                         baseUrl:kInstagramBaseURL
                             url:url
                   isAbsoluteUrl:NO
                   requestMethod:requestMethod
              responseSerializer:ResponseSerializerJSON
                      paramaters:paramaters
                    successBlock:successBlock
                    failureBlock:failureBlock];
}

+ (MIAPIRequest *)requestWithName:(NSString *)name
                              url:(NSString *)url
                    isAbsoluteUrl:(BOOL)isAbsoluteUrl
                    requestMethod:(RequestMethod)requestMethod
                       paramaters:(NSDictionary *)paramaters;
{
    return [self requestWithName:name
                         baseUrl:kInstagramBaseURL
                             url:url
                   isAbsoluteUrl:isAbsoluteUrl
                   requestMethod:requestMethod
              responseSerializer:ResponseSerializerJSON
                      paramaters:paramaters
                    successBlock:nil
                    failureBlock:nil];
}

@end
