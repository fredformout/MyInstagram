//
//  MICommentsPresenter.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 08.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MICommentsPresenter.h"

@interface MICommentsPresenter ()

@property (nonatomic, strong) MIInstagramPost *post;
@property (nonatomic, strong) NSMutableArray *comments;

@end

@implementation MICommentsPresenter

#pragma mark - NSObject

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _comments = [NSMutableArray new];
    }
    
    return self;
}

#pragma mark - MICommentsPresenterInterface

- (void)openCommentsForPost:(MIInstagramPost *)post
{
    self.post = post;
}

- (void)updateView
{
    [_interactor getCommentsForPost:_post
                  lastViewedComment:nil];
}

#pragma mark - MICommentsInteractorOutputInterface

- (void)showComments:(NSArray *)comments
                post:(MIInstagramPost *)post
{
    _comments = [comments mutableCopy];
    
    [_controller showComments:_comments
                         post:post];
    [_controller reload];
}

#pragma mark - MIAddCommentInteractorOutputInterface

- (void)finishAddComment:(MIInstagramComment *)comment
                    post:(MIInstagramPost *)post
                 success:(BOOL)success;
{
    if (success)
    {
        //reload
    }
    else
    {
        //delete comment from view
    }
}

#pragma mark - MIAddCommentPresenterInterface

- (void)sendCommentWithText:(NSString *)text
{
    MIInstagramComment *comment = [_interactor newCommentWithText:text
                                                             post:_post];
    
    NSMutableArray *array = [_post.comments mutableCopy];
    [array addObject:comment];
    _post.comments = array;
    _post.commentsCount++;
    [_comments addObject:comment];
    
    [_controller reload];
    
    [_interactor addComment:comment
                       post:_post];
}

@end
