//
//  MIPhotoDetailsInteractor.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 09.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIPhotoDetailsInteractor.h"
#import "MIDataProvider+Comments.h"
#import "MIDataProvider+Posts.h"
#import "MIDataProvider+Likes.h"
#import "MIDataProvider+Images.h"
#import "MIDataProvider+User.h"
#import "MIInstagramUser.h"

@implementation MIPhotoDetailsInteractor

#pragma mark - MIAddCommentInteractorInputInterface

- (MIInstagramComment *)newCommentWithText:(NSString *)text
                                      post:(MIInstagramPost *)post
{
    MIInstagramComment *comment = [MIInstagramComment new];
    
    comment.text = text;
    
    MIInstagramUser *user = (MIInstagramUser *)[self.dataProvider localUser];
    
    comment.username = user.username;
    comment.fullname = user.fullname;
    comment.userPhotoURL = user.userPhotoURL;
    
    return comment;
}

- (void)addComment:(MIInstagramComment *)comment
              post:(MIInstagramPost *)post
{
    return;
    
    __weak typeof(self) weakSelf = self;
    
    [self.dataProvider addCommentByPostId:post.identifier
                                     text:comment.text
                             successBlock:^(NSObject *data)
    {
        __strong typeof(self) strongSelf = weakSelf;
        
        [strongSelf.presenter finishAddComment:comment
                                          post:post
                                       success:YES];
    }
                             failureBlock:^(NSString *error)
    {
        __strong typeof(self) strongSelf = weakSelf;
        
        [strongSelf.presenter finishAddComment:comment
                                          post:post
                                       success:NO];
    }];
}

#pragma mark - MIPhotoDetailsInteractorInputInterface

- (void)getPostByPost:(MIInstagramPost *)post
{
    __weak typeof(self) weakSelf = self;
    
    [self.dataProvider getPostById:post.identifier
                      successBlock:^(NSObject *data)
    {
        __strong typeof(self) strongSelf = weakSelf;
        
        [strongSelf.presenter showPost:(MIInstagramPost *)data];
    }
                      failureBlock:^(NSString *error)
    {
        __strong typeof(self) strongSelf = weakSelf;
        
        [strongSelf.presenter failGetPost];
    }];
}

- (void)likePost:(MIInstagramPost *)post
{
    return;
    
    __weak typeof(self) weakSelf = self;
    
    [self.dataProvider likePostByPostId:post.identifier
                           successBlock:^(NSObject *data)
    {
        __strong typeof(self) strongSelf = weakSelf;
        
        [strongSelf.presenter finishLikePostWithSuccess:YES
                                                   post:post];
    }
                           failureBlock:^(NSString *error)
    {
        __strong typeof(self) strongSelf = weakSelf;
        
        [strongSelf.presenter finishLikePostWithSuccess:NO
                                                   post:post];
    }];
}

- (void)unlikePost:(MIInstagramPost *)post
{
    return;
    
    __weak typeof(self) weakSelf = self;
    
    [self.dataProvider unlikePostByPostId:post.identifier
                             successBlock:^(NSObject *data)
    {
        __strong typeof(self) strongSelf = weakSelf;
        
        [strongSelf.presenter finishUnlikePostWithSuccess:YES
                                                     post:post];
    }
                             failureBlock:^(NSString *error)
    {
        __strong typeof(self) strongSelf = weakSelf;
        
        [strongSelf.presenter finishUnlikePostWithSuccess:NO
                                                     post:post];
    }];
}

@end
