//
//  MILikedByMeInteractor.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 11.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MILikedByMeInteractor.h"
#import "MIDataProvider+Posts.h"
#import "MIInstagramPost.h"

static NSInteger kPostsCount = 24;

@interface MILikedByMeInteractor ()

@property (nonatomic, copy) NSString *maxLikeId;

@end

@implementation MILikedByMeInteractor

#pragma mark - MIPhotosInteractorInputInterface

- (void)getLocalPosts
{
    NSArray *posts = [self.dataProvider localLikedByMePosts];
    
    if ([posts count] > 0)
    {
        MIInstagramPost *post = [posts lastObject];
        self.maxLikeId = post.identifier;
    }
    
    [_presenter replaceAllPostsByPosts:posts
                              lastPart:NO];
}

- (void)getNewPosts
{
    self.maxLikeId = nil;
    
    __weak typeof(self) weakSelf = self;
    
    [self.dataProvider getLikedByMePostsWithMaxLikeId:_maxLikeId
                                                count:kPostsCount
                                         successBlock:^(NSArray *posts, NSString *maxLikeId)
    {
        __strong typeof(self) strongSelf = weakSelf;
        
        if (maxLikeId)
        {
            self.maxLikeId = maxLikeId;
        }
        
        [strongSelf.presenter replaceAllPostsByPosts:posts
                                            lastPart:!maxLikeId];
    }
                                           failureBlock:^(NSString *error)
    {
        __strong typeof(self) strongSelf = weakSelf;
        
        [strongSelf.presenter failReplaceAllPosts];
    }];
}

- (void)getMorePosts
{
    __weak typeof(self) weakSelf = self;
    
    [self.dataProvider getLikedByMePostsWithMaxLikeId:_maxLikeId
                                                count:kPostsCount
                                         successBlock:^(NSArray *posts, NSString *maxLikeId)
     {
         __strong typeof(self) strongSelf = weakSelf;
         
         if (maxLikeId)
         {
             self.maxLikeId = maxLikeId;
         }
         
         [strongSelf.presenter addPosts:posts
                               lastPart:!maxLikeId];
     }
                                         failureBlock:^(NSString *error)
     {
         __strong typeof(self) strongSelf = weakSelf;
         
         [strongSelf.presenter failAddPosts];
     }];
}

@end
