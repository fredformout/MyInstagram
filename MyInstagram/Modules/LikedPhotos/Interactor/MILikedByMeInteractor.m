//
//  MILikedByMeInteractor.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 11.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MILikedByMeInteractor.h"
#import "MIDataProvider+Posts.h"
#import "MIDataProvider+Images.h"
#import "MIInstagramPost.h"

static NSInteger kPostsCount = 24;

@interface MILikedByMeInteractor ()

@property (nonatomic, copy) NSString *maxLikeId;

@end

@implementation MILikedByMeInteractor

#pragma mark - MIPhotosInteractorInputInterface

- (void)getLocalPosts
{
    [_presenter addNewPosts:[self.dataProvider localLikedByMePosts]];
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
        
        [strongSelf downloadPhotosForPosts:posts];
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
         
         [strongSelf downloadPhotosForPosts:posts];
     }
                                         failureBlock:^(NSString *error)
     {
         __strong typeof(self) strongSelf = weakSelf;
         
         [strongSelf.presenter failAddPosts];
     }];
}

@end
