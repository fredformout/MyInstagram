//
//  MIAPIBaseRequest.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 09.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIAPIRequest.h"
#import "MIInstagramConstants.h"
#import "MIConstants.h"
#import "FEMMapping.h"
#import "FEMDeserializer.h"
#import "MIMappingManager.h"

@implementation MIAPIRequest

#pragma mark - Others

+ (MIAPIRequest *)requestWithName:(NSString *)name
                          baseUrl:(NSString *)baseUrl
                              url:(NSString *)url
                    isAbsoluteUrl:(BOOL)isAbsoluteUrl
                    requestMethod:(RequestMethod)requestMethod
               responseSerializer:(ResponseSerializer)responseSerializer
                       paramaters:(NSDictionary *)paramaters
                    mappingEntity:(NSString *)mappingEntity
                       mappingKey:(NSString *)mappingKey
                      mappingType:(MappingType)mappingType
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
    request.mappingEntity = mappingEntity;
    request.mappingKey = mappingKey;
    request.mappingType = mappingType;
    request.successBlock = [self blockFromBlock:successBlock
                                  mappingEntity:mappingEntity
                                     mappingKey:mappingKey
                                    mappingType:mappingType];
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
                   mappingEntity:nil
                      mappingKey:nil
                     mappingType:MappingTypeNone
                    successBlock:successBlock
                    failureBlock:failureBlock];
}

+ (MIAPIRequest *)requestWithName:(NSString *)name
                              url:(NSString *)url
                    requestMethod:(RequestMethod)requestMethod
                       paramaters:(NSDictionary *)paramaters
                    mappingEntity:(NSString *)mappingEntity
                       mappingKey:(NSString *)mappingKey
                      mappingType:(MappingType)mappingType
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
                   mappingEntity:mappingEntity
                      mappingKey:mappingKey
                     mappingType:mappingType
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
                   mappingEntity:nil
                      mappingKey:nil
                     mappingType:MappingTypeNone
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
                   mappingEntity:nil
                      mappingKey:nil
                     mappingType:MappingTypeNone
                    successBlock:nil
                    failureBlock:nil];
}

+ (APIRequestSuccessBlock)blockFromBlock:(APIRequestSuccessBlock)block
                           mappingEntity:(NSString *)mappingEntity
                              mappingKey:(NSString *)mappingKey
                             mappingType:(MappingType)mappingType
{
    return ^void(id data, id raw)
    {
        if (block)
        {
            __block id responseData = data;
            id responseRaw = data;
            
            if ((mappingType == MappingTypeObject
                 || mappingType == MappingTypeCollection)
                && mappingEntity
                && mappingKey)
            {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^
                {
                    FEMMapping *mapping = [[MIMappingManager sharedInstance] mappingForKey:[NSString stringWithFormat:@"%@%@", mappingEntity, kObjectMappingPattern]];
                    FEMDeserializer *deserializer = [FEMDeserializer new];
                    
                    if (mappingType == MappingTypeObject)
                    {
                        responseData = [deserializer objectFromRepresentation:data[mappingKey]
                                                                      mapping:mapping];
                    }
                    else
                    {
                        responseData = [deserializer collectionFromRepresentation:data[mappingKey]
                                                                          mapping:mapping];
                    }
                   
                    dispatch_async(dispatch_get_main_queue(), ^
                    {
                        block(responseData, responseRaw);
                    });
                });
            }
            else
            {
                block(responseData, responseRaw);
            }
        }
    };
}

@end
