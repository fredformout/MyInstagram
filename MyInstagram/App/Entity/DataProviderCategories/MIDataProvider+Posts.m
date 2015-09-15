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
                                                 successBlock:^(id data)
        {
            [[MIMappingManager sharedInstance] backgroundCollectionFromData:data[kDataKey]
                                                    mappingEntity:@"Post"
                                                       completion:^(id data)
            {
                if (successBlock)
                {
                    successBlock(data);
                }
            }];
            
            [[MILocalDataManager sharedInstance] deleteAllPostsFromListWithName:@"Popular"
                                                                     completion:^
            {
                [[MILocalDataManager sharedInstance] savePostsFromData:data[kDataKey]
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
                          successBlock:(void (^)(NSArray *data, NSString *maxLikeId))successBlock
                          failureBlock:(void (^)(NSString *error))failureBlock
{
    if ([self canMakeRequest])
    {
        NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           [UICKeyChainStore sharedInstance][kAccessTokenKey], kAccessTokenKey,
                                           @(count), kCountKey,
                                           nil];
        
        if (maxLikeId)
        {
            parameters[kMaxLikeIdKey] = maxLikeId;
        }
        
        MIAPIRequest *request = [MIAPIRequest requestWithName:@"GetLikedByMePosts"
                                                          url:@"users/self/media/liked"
                                                requestMethod:RequestMethodGET
                                                   paramaters:parameters
                                                 successBlock:^(id data)
        {
            [[MIMappingManager sharedInstance] backgroundCollectionFromData:data[kDataKey]
                                                    mappingEntity:@"Post"
                                                       completion:^(id posts)
            {
                if (successBlock)
                {
                    successBlock(posts, data[kPaginationKey][kNextMaxLikeIdKey]);
                }
            }];

            [[MILocalDataManager sharedInstance] savePostsFromData:data[kDataKey]
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
                                                 successBlock:^(id data)
        {
            [[MIMappingManager sharedInstance] backgroundObjectFromData:data[kDataKey]
                                                mappingEntity:@"Post"
                                                   completion:^(id data)
            {
                if (successBlock)
                {
                    successBlock(data);
                }
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

@end
