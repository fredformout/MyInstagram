//
//  MIDataProvider+Posts.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 13.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIDataProvider+Posts.h"
#import "MILocalDataManager+Posts.h"

@implementation MIDataProvider (Posts)

#pragma mark - Others

- (NSArray *)localPopularPosts
{
    return [[MILocalDataManager sharedInstance] postsFromListWithName:@"Popular"];
}

- (void)getPopularPostsWithSuccessBlock:(void (^)(NSArray *data))successBlock
                           failureBlock:(void (^)(NSString *error))failureBlock
{
    if ([self canMakeRequest])
    {
        NSDictionary *parameters = @{
                                     kAccessTokenKey : [UICKeyChainStore sharedInstance][kAccessTokenKey]
                                     };
        
        MIAPIRequest *request = [MIAPIRequest requestWithName:@"GetPopularPosts"
                                                          url:@"media/popular"
                                                requestMethod:RequestMethodGET
                                                   paramaters:parameters
                                                mappingEntity:@"Post"
                                                   mappingKey:kDataKey
                                                  mappingType:MappingTypeCollection
                                                 successBlock:^(id data, id raw)
        {
            if (successBlock)
            {
                successBlock(data);
            }

            [[MILocalDataManager sharedInstance] deleteAllPostsFromListWithName:@"Popular"
                                                                     completion:^
            {
                [[MILocalDataManager sharedInstance] savePostsFromData:raw[kDataKey]
                                                              listName:@"Popular"
                                                                 atTop:YES
                                                            completion:nil];
            }];
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

- (NSArray *)localLikedByMePosts
{
    return [[MILocalDataManager sharedInstance] postsFromListWithName:@"LikedByMe"];
}

- (void)getLikedByMePostsWithMaxLikeId:(NSString *)maxLikeId
                                 count:(NSInteger)count
                          successBlock:(void (^)(NSArray *, NSString *maxLikeId))successBlock
                          failureBlock:(void (^)(NSString *))failureBlock
{
    if ([self canMakeRequest])
    {
        NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                          kAccessTokenKey : [UICKeyChainStore sharedInstance][kAccessTokenKey],
                                                                                          kCountKey : @(count)
                                                                                          }];
        
        if (maxLikeId)
        {
            parameters[kMaxLikeIdKey] = maxLikeId;
        }
        
        MIAPIRequest *request = [MIAPIRequest requestWithName:@"GetLikedByMePosts"
                                                          url:@"users/self/media/liked"
                                                requestMethod:RequestMethodGET
                                                   paramaters:parameters
                                                mappingEntity:@"Post"
                                                   mappingKey:kDataKey
                                                  mappingType:MappingTypeCollection
                                                 successBlock:^(id data, id raw)
         {
            if (successBlock)
            {
                successBlock(data, raw[kPaginationKey][kNextMaxLikeIdKey]);
            }

            [[MILocalDataManager sharedInstance] savePostsFromData:raw[kDataKey]
                                                          listName:@"LikedByMe"
                                                             atTop:!maxLikeId
                                                        completion:^{}];
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

- (void)getPostById:(NSString *)postId
       successBlock:(void (^)(NSObject *))successBlock
       failureBlock:(void (^)(NSString *))failureBlock
{
    if ([self canMakeRequest])
    {
        NSDictionary *parameters = @{
                                     kAccessTokenKey : [UICKeyChainStore sharedInstance][kAccessTokenKey]
                                     };
        
        MIAPIRequest *request = [MIAPIRequest requestWithName:@"GetPost"
                                                          url:[NSString stringWithFormat:@"media/%@", postId]
                                                requestMethod:RequestMethodGET
                                                   paramaters:parameters
                                                mappingEntity:@"Post"
                                                   mappingKey:kDataKey
                                                  mappingType:MappingTypeObject
                                                 successBlock:^(id data, id raw)
        {
            if (successBlock)
            {
                successBlock(data);
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
