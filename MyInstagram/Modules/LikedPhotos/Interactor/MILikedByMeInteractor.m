//
//  MILikedByMeInteractor.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 11.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MILikedByMeInteractor.h"
#import "MIUsersDataProvider.h"
#import "MIInstagramPost.h"

static NSInteger kPostsCount = 24;

@interface MILikedByMeInteractor ()

@property (nonatomic, copy) NSString *maxLikeId;

@end

@implementation MILikedByMeInteractor

#pragma mark - MIPhotosInteractorInputInterface

- (void)getNewPosts
{
    self.maxLikeId = nil;
    
    [MIUsersDataProvider getLikedByMePostsWithMaxLikeId:_maxLikeId
                                                  count:kPostsCount
                                           successBlock:^(NSArray *posts, NSString *maxLikeId)
    {
        if (maxLikeId)
        {
            self.maxLikeId = maxLikeId;
        }
        
        [_presenter replaceAllPostsByPosts:posts
                                  lastPart:!maxLikeId];
    }
                                           failureBlock:^(NSString *error)
    {
        [_presenter failReplaceAllPosts];
    }];
}

- (void)getMorePosts
{
    [MIUsersDataProvider getLikedByMePostsWithMaxLikeId:_maxLikeId
                                                  count:kPostsCount
                                           successBlock:^(NSArray *posts, NSString *maxLikeId)
     {
         if (maxLikeId)
         {
             self.maxLikeId = maxLikeId;
         }
         
         [_presenter addPosts:posts
                     lastPart:!maxLikeId];
     }
                                           failureBlock:^(NSString *error)
     {
         [_presenter failAddPosts];
     }];
}

@end
