//
//  MIDataProvider+Likes.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 13.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIDataProvider+Likes.h"

@implementation MIDataProvider (Likes)

- (void)likePostByPostId:(NSString *)postId
            successBlock:(void (^)(NSObject *))successBlock
            failureBlock:(void (^)(NSString *))failureBlock
{
    if ([self canMakeRequest])
    {
        NSDictionary *parameters = @{
                                     kAccessTokenKey : [UICKeyChainStore sharedInstance][kAccessTokenKey]
                                     };
        
        MIAPIRequest *request = [MIAPIRequest requestWithName:@"LikePost"
                                                          url:[NSString stringWithFormat:@"media/%@/likes", postId]
                                                requestMethod:RequestMethodPOST
                                                   paramaters:parameters
                                                 successBlock:^(id data)
        {
            if (successBlock)
            {
                successBlock(nil);
            }
        }
                         failureBlock:^(id error)
        {
            NSLog(@"Error: %@", [error description]);
            
            if (failureBlock)
            {
                failureBlock(error);
            }
        }];
        
        [[MIAPIDataManager sharedInstance] startOperationWithRequest:request];
    }
    else
    {
        if (failureBlock)
        {
            failureBlock(@"Network is not available.");
        }
    }
}

- (void)unlikePostByPostId:(NSString *)postId
              successBlock:(void (^)(NSObject *))successBlock
              failureBlock:(void (^)(NSString *))failureBlock
{
    if ([self canMakeRequest])
    {
        NSDictionary *parameters = @{
                                     kAccessTokenKey : [UICKeyChainStore sharedInstance][kAccessTokenKey]
                                     };
        
        MIAPIRequest *request = [MIAPIRequest requestWithName:@"UnlikePost"
                                                          url:[NSString stringWithFormat:@"media/%@/likes", postId]
                                                requestMethod:RequestMethodDELETE
                                                   paramaters:parameters
                                                 successBlock:^(id data)
        {
            if (successBlock)
            {
                successBlock(nil);
            }
        }
                                                 failureBlock:^(id error)
        {
            NSLog(@"Error: %@", [error description]);
            
            if (failureBlock)
            {
                failureBlock(error);
            }
        }];
        
        [[MIAPIDataManager sharedInstance] startOperationWithRequest:request];
    }
    else
    {
        if (failureBlock)
        {
            failureBlock(@"Network is not available.");
        }
    }
}

@end
