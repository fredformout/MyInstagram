//
//  MIPhotosInteractor.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 08.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIPopularPhotosInteractor.h"
#import "MIDataProvider+Posts.h"
#import "MIInstagramPost.h"
#import "MIInstagramComment.h"
#import "MIImageCacheUtility.h"

@interface MIPopularPhotosInteractor ()

@end

@implementation MIPopularPhotosInteractor

#pragma mark - MIPhotosInteractorInputInterface

- (void)getLocalPosts
{
    NSArray *posts = [self.dataProvider localPopularPosts];
    
    [_presenter replaceAllPostsByPosts:posts
                              lastPart:NO];
}

- (void)getNewPosts
{
    __weak typeof(self) weakSelf = self;
    
    [self.dataProvider getPopularPostsWithSuccessBlock:^(NSArray *posts)
    {
        __strong typeof(self) strongSelf = weakSelf;
        
        [strongSelf.presenter replaceAllPostsByPosts:posts
                                            lastPart:NO];
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
    
    [self.dataProvider getPopularPostsWithSuccessBlock:^(NSArray *posts)
    {
        __strong typeof(self) strongSelf = weakSelf;
        
        [strongSelf.presenter addPosts:posts
                              lastPart:NO];
    }
                                          failureBlock:^(NSString *error)
    {
        __strong typeof(self) strongSelf = weakSelf;
        
        [strongSelf.presenter failAddPosts];
    }];
}

@end
