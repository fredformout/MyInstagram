//
//  MIPhotosInteractor.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 08.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIPopularPhotosInteractor.h"
#import "MIMediaDataProvider.h"
#import "MIInstagramPost.h"
#import "MIInstagramComment.h"

@interface MIPopularPhotosInteractor ()

@end

@implementation MIPopularPhotosInteractor

#pragma mark - MIPhotosInteractorInputInterface

- (void)getNewPosts
{
    [MIMediaDataProvider getPopularPostsWithSuccessBlock:^(NSArray *posts)
    {
        [_presenter addNewPosts:posts];
    }
                                            failureBlock:^(NSString *error)
    {
        [_presenter failAddNewPosts];
    }];
}

- (void)getMorePosts
{
    [MIMediaDataProvider getPopularPostsWithSuccessBlock:^(NSArray *posts)
    {
        [_presenter addPosts:posts
                    lastPart:NO];
    }
                                      failureBlock:^(NSString *error)
    {
        [_presenter failAddPosts];
    }];
}

@end
