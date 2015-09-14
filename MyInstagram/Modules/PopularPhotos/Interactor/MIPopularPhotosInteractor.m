//
//  MIPhotosInteractor.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 08.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIPopularPhotosInteractor.h"
#import "MIDataProvider+Posts.h"
#import "MIDataProvider+Images.h"
#import "MIInstagramPost.h"
#import "MIInstagramComment.h"

@interface MIPopularPhotosInteractor ()

@end

@implementation MIPopularPhotosInteractor

#pragma mark - MIPhotosInteractorInputInterface

- (void)getLocalPosts
{
    [_presenter addNewPosts:[self.dataProvider localPopularPosts]];
}

- (void)getNewPosts
{
    __weak typeof(self) weakSelf = self;
    
    [self.dataProvider getPopularPostsWithSuccessBlock:^(NSArray *posts)
    {
        __strong typeof(self) strongSelf = weakSelf;
        
        [strongSelf.presenter addNewPosts:posts];
        
        [strongSelf downloadPhotosForPosts:posts];
    }
                                          failureBlock:^(NSString *error)
    {
        __strong typeof(self) strongSelf = weakSelf;
        
        [strongSelf.presenter failAddNewPosts];
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
        
        [strongSelf downloadPhotosForPosts:posts];
    }
                                          failureBlock:^(NSString *error)
    {
        __strong typeof(self) strongSelf = weakSelf;
        
        [strongSelf.presenter failAddPosts];
    }];
}

@end
