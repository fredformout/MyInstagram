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
    [_comments removeAllObjects];
    [_controller showComments:_comments
                         post:_post];
    [_interactor getCommentsForPost:_post];
}

#pragma mark - MICommentsInteractorOutputInterface

- (void)showComments:(NSArray *)comments
                post:(MIInstagramPost *)post
            lastPart:(BOOL)lastPart
{
    [_comments insertObjects:comments
                   atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [comments count])]];
    
    [_controller insertElementsToTopCount:[comments count]
                           deleteMoreCell:lastPart];
}

#pragma mark - MIAddCommentInteractorOutputInterface

- (void)finishAddComment:(MIInstagramComment *)comment
                    post:(MIInstagramPost *)post
                 success:(BOOL)success;
{
    if (success)
    {
        [_interactor getCommentsForPost:_post];
    }
    else
    {
        if ([_post isEqual:post])
        {
            [_comments removeObject:comment];
            
            [_controller undoCommentWithText:comment.text];
            [_controller reload];
        }
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
