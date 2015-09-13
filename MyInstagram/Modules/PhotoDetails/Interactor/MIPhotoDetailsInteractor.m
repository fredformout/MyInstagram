//
//  MIPhotoDetailsInteractor.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 09.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIPhotoDetailsInteractor.h"
#import "MICommentsDataProvider.h"
#import "MIMediaDataProvider.h"
#import "MILikesDataProvider.h"

@implementation MIPhotoDetailsInteractor

#pragma mark - MIAddCommentInteractorInputInterface

- (MIInstagramComment *)newCommentWithText:(NSString *)text
                                      post:(MIInstagramPost *)post
{
    MIInstagramComment *comment = [MIInstagramComment new];
    
    comment.text = text;
    
    return comment;
}

- (void)addComment:(MIInstagramComment *)comment
              post:(MIInstagramPost *)post
{
    return;
    
    [MICommentsDataProvider addCommentByPostId:post.identifier
                                          text:comment.text
                                  successBlock:^(NSObject *data)
    {
        [_presenter finishAddComment:comment
                                post:post
                             success:YES];
    }
                                  failureBlock:^(NSString *error)
    {
        [_presenter finishAddComment:comment
                                post:post
                             success:NO];
    }];
}

#pragma mark - MIPhotoDetailsInteractorInputInterface

- (void)getPostByPost:(MIInstagramPost *)post
{
    [MIMediaDataProvider getPostById:post.identifier
                        successBlock:^(NSObject *data)
    {
        [_presenter showPost:(MIInstagramPost *)data];
    }
                        failureBlock:^(NSString *error){}];
}

- (void)likePost:(MIInstagramPost *)post
{
    return;
    
    [MILikesDataProvider likePostByPostId:post.identifier
                             successBlock:^(NSObject *data)
    {
        [_presenter finishLikePostWithSuccess:YES
                                         post:post];
    }
                             failureBlock:^(NSString *error)
    {
        [_presenter finishLikePostWithSuccess:NO
                                         post:post];
    }];
}

- (void)unlikePost:(MIInstagramPost *)post
{
    return;
    
    [MILikesDataProvider unlikePostByPostId:post.identifier
                               successBlock:^(NSObject *data)
    {
        [_presenter finishUnlikePostWithSuccess:YES
                                           post:post];
    }
                               failureBlock:^(NSString *error)
    {
        [_presenter finishUnlikePostWithSuccess:NO
                                           post:post];
    }];
}

@end
