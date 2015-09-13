//
//  MILikesDataProvider.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 12.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MILikesDataProvider.h"

@implementation MILikesDataProvider

+ (void)likePostByPostId:(NSString *)postId
            successBlock:(void (^)(NSObject *))successBlock
            failureBlock:(void (^)(NSString *))failureBlock
{
    if ([self canMakeRequest])
    {
        MIAPIBaseRequest *request = [MIAPIBaseRequest new];
        request.name = @"LikePost";
        request.url = [NSString stringWithFormat:@"media/%@/likes", postId];
        [request.parameters addEntriesFromDictionary:@{
                                                       kAccessTokenKey : [UICKeyChainStore sharedInstance][kAccessTokenKey]
                                                       }];
        request.requestMethod = RequestMethodPOST;
        
        request.successBlock = ^(NSDictionary *data)
        {
            if (successBlock)
            {
                successBlock(nil);
            }
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
    }
}

+ (void)unlikePostByPostId:(NSString *)postId
              successBlock:(void (^)(NSObject *))successBlock
              failureBlock:(void (^)(NSString *))failureBlock
{
    if ([self canMakeRequest])
    {
        MIAPIBaseRequest *request = [MIAPIBaseRequest new];
        request.name = @"UnlikePost";
        request.url = [NSString stringWithFormat:@"media/%@/likes", postId];
        [request.parameters addEntriesFromDictionary:@{
                                                       kAccessTokenKey : [UICKeyChainStore sharedInstance][kAccessTokenKey]
                                                       }];
        request.requestMethod = RequestMethodDELETE;
        
        request.successBlock = ^(NSDictionary *data)
        {
            if (successBlock)
            {
                successBlock(nil);
            }
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
    }
}

@end
