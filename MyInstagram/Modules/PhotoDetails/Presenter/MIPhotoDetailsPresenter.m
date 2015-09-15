//
//  MIPhotoDetailsPresenter.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 08.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIPhotoDetailsPresenter.h"
#import "MIPhotoDetailsRouter.h"

@interface MIPhotoDetailsPresenter ()

@property (nonatomic, strong) MIInstagramPost *post;

@end

@implementation MIPhotoDetailsPresenter

#pragma mark - MIPhotoDetailsPresenterInterface

- (void)openPost:(MIInstagramPost *)post
       presenter:(id<MIPhotosPresenterInterface>)presenter
{
    self.post = post;
    self.photosPresenter = presenter;
}

- (void)updateView
{
    [_controller showPost:_post];
}

- (void)reloadView
{
    [_interactor getPostByPost:_post];
}

- (void)openComments
{
    [_commentsPresenter openCommentsForPost:_post];
    
    MIPhotoDetailsRouter *router = (MIPhotoDetailsRouter *)self.router;
    [router presentComments];
}

- (void)sendCommentWithText:(NSString *)text
{
    MIInstagramComment *comment = [_interactor newCommentWithText:text
                                                             post:_post];
    
    NSMutableArray *array = [_post.comments mutableCopy];
    [array addObject:comment];
    _post.comments = array;
    _post.commentsCount++;
    
    [_controller reload];
    
    [_interactor addComment:comment
                       post:_post];
}

- (void)toggleLikedByMe
{
    BOOL likedByMe = _post.likedByMe;
    
    if (likedByMe)
    {
        _post.likedByMe = NO;
        _post.likesCount--;
    }
    else
    {
        _post.likedByMe = YES;
        _post.likesCount++;
    }
    
    [_controller reload];
    
    likedByMe ? [_interactor unlikePost:_post] : [_interactor likePost:_post];
}

- (void)setTransitioningDelegate
{
    MIPhotoDetailsRouter *router = (MIPhotoDetailsRouter *)self.router;
    [router setTransitioningDelegate];
}

- (void)unsetTransitioningDelegate
{
    MIPhotoDetailsRouter *router = (MIPhotoDetailsRouter *)self.router;
    [router unsetTransitioningDelegate];
}

#pragma mark - MIAddCommentInteractorOutputInterface

- (void)finishAddComment:(MIInstagramComment *)comment
                    post:(MIInstagramPost *)post
                 success:(BOOL)success
{
    if (success)
    {
        [_interactor getPostByPost:_post];
    }
    else
    {
        if ([_post isEqual:post])
        {
            NSMutableArray *array = [_post.comments mutableCopy];
            [array removeObject:comment];
            _post.comments = array;
            
            [_controller undoCommentWithText:comment.text];
            [_controller reload];
        }
    }
}

#pragma mark - MIPhotoDetailsInteractorOutputInterface

- (void)showPost:(MIInstagramPost *)post
{
    [_photosPresenter refreshPost:_post
                          newPost:post];
    
    self.post = post;
    
    [_controller showPost:_post];
    [_controller reload];
}

- (void)failGetPost
{
    [_controller stopActivityIndicator];
}

- (void)finishLikePostWithSuccess:(BOOL)success
                             post:(MIInstagramPost *)post
{
    if (!success)
    {
        if ([_post isEqual:post])
        {
            post.likedByMe = NO;
            post.likesCount--;
            
            [_controller reload];
        }
    }
}

- (void)finishUnlikePostWithSuccess:(BOOL)success
                               post:(MIInstagramPost *)post
{
    if (!success)
    {
        if ([_post isEqual:post])
        {
            post.likedByMe = YES;
            post.likesCount++;
            
            [_controller reload];
        }
    }
}

@end
