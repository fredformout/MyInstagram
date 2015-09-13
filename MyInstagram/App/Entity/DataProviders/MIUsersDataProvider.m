//
//  MILikedByMeDataProvider.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 11.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIUsersDataProvider.h"
#import "FEMDeserializer.h"

@implementation MIUsersDataProvider

+ (void)getLikedByMePostsWithMaxLikeId:(NSString *)maxLikeId
                                 count:(NSInteger)count
                          successBlock:(void (^)(NSArray *, NSString *maxLikeId))successBlock
                          failureBlock:(void (^)(NSString *))failureBlock
{
    if ([self canMakeRequest])
    {
        MIAPIBaseRequest *request = [MIAPIBaseRequest new];
        request.name = @"GetLikedByMePosts";
        request.url = @"users/self/media/liked";
        
        [request.parameters addEntriesFromDictionary:@{
                                                       kAccessTokenKey : [UICKeyChainStore sharedInstance][kAccessTokenKey],
                                                       kCountKey : @(count)
                                                       }];
        
        if (maxLikeId)
        {
            request.parameters[kMaxLikeIdKey] = maxLikeId;
        }
        
        request.requestMethod = RequestMethodGET;
        
        request.successBlock = ^(NSDictionary *data)
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^
           {
               FEMDeserializer *deserializer = [[FEMDeserializer alloc] init];
               NSArray *posts =  [deserializer collectionFromRepresentation:data[kDataKey]
                                                                    mapping:[MIMappingManager sharedInstance].postMapping];
               
               dispatch_async(dispatch_get_main_queue(), ^
               {
                   if (successBlock)
                   {
                       successBlock(posts, data[kPaginationKey][kNextMaxLikeIdKey]);
                   }
               });
           });
        };
        
        request.failureBlock = ^(id error)
        {
            NSLog(@"Error: %@", [error description]);
        };
        
        [[MIAPIDataManager sharedInstance] startRequest:request];
    }
    else
    {
        //get data from local cache
        //successBlock();
        if (successBlock)
        {
            successBlock([NSArray array], maxLikeId);
        }
    }
}

+ (void)getUserInfoWithSuccessBlock:(void (^)(NSObject *data))successBlock
                       failureBlock:(void (^)(NSString *error))failureBlock
{
    if ([self canMakeRequest])
    {
        MIAPIBaseRequest *request = [MIAPIBaseRequest new];
        request.name = @"GetUserInfo";
        request.url = @"users/self";
        [request.parameters addEntriesFromDictionary:@{
                                                       kAccessTokenKey : [UICKeyChainStore sharedInstance][kAccessTokenKey]
                                                       }];
        request.requestMethod = RequestMethodGET;
        
        request.successBlock = ^(NSDictionary *data)
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^
            {
                FEMDeserializer *deserializer = [FEMDeserializer new];
                MIInstagramUser *user =  [deserializer objectFromRepresentation:data[kDataKey]
                                                                        mapping:[MIMappingManager sharedInstance].userMapping];

                dispatch_async(dispatch_get_main_queue(), ^
                {
                    if (successBlock)
                    {
                        successBlock(user);
                    }
                });
            });
        };
        
        request.failureBlock = ^(id error)
        {
            NSLog(@"Error: %@", [error description]);
        };
        
        [[MIAPIDataManager sharedInstance] startRequest:request];
    }
}

@end
