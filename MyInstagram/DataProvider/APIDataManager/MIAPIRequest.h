//
//  MIAPIBaseRequest.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 09.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RequestMethod)
{
    RequestMethodGET,
    RequestMethodPOST,
    RequestMethodPUT,
    RequestMethodDELETE
};

typedef NS_ENUM(NSInteger, ResponseSerializer)
{
    ResponseSerializerBasic,
    ResponseSerializerJSON
};

typedef void (^APIRequestSuccessBlock)(id data);
typedef void (^APIRequestFailureBlock)(id error);

@interface MIAPIRequest : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *baseUrl;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) BOOL isAbsoluteURL;
@property (nonatomic, assign) RequestMethod requestMethod;
@property (nonatomic, assign) ResponseSerializer responseSerializer;
@property (nonatomic, strong) NSDictionary *parameters;
@property (nonatomic, copy) APIRequestSuccessBlock successBlock;
@property (nonatomic, copy) APIRequestFailureBlock failureBlock;

+ (MIAPIRequest *)requestWithName:(NSString *)name
                          baseUrl:(NSString *)baseUrl
                              url:(NSString *)url
                    isAbsoluteUrl:(BOOL)isAbsoluteUrl
                    requestMethod:(RequestMethod)requestMethod
               responseSerializer:(ResponseSerializer)responseSerializer
                       paramaters:(NSDictionary *)paramaters
                     successBlock:(APIRequestSuccessBlock)successBlock
                     failureBlock:(APIRequestFailureBlock)failureBlock;
+ (MIAPIRequest *)requestWithName:(NSString *)name
                              url:(NSString *)url
                    isAbsoluteUrl:(BOOL)isAbsoluteUrl
                    requestMethod:(RequestMethod)requestMethod
               responseSerializer:(ResponseSerializer)responseSerializer
                     successBlock:(APIRequestSuccessBlock)successBlock
                     failureBlock:(APIRequestFailureBlock)failureBlock;
+ (MIAPIRequest *)requestWithName:(NSString *)name
                              url:(NSString *)url
                    requestMethod:(RequestMethod)requestMethod
                       paramaters:(NSDictionary *)paramaters
                     successBlock:(APIRequestSuccessBlock)successBlock
                     failureBlock:(APIRequestFailureBlock)failureBlock;
+ (MIAPIRequest *)requestWithName:(NSString *)name
                              url:(NSString *)url
                    isAbsoluteUrl:(BOOL)isAbsoluteUrl
                    requestMethod:(RequestMethod)requestMethod
                       paramaters:(NSDictionary *)paramaters;

@end
