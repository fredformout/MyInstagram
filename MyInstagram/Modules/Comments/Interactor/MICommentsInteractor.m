//
//  MICommentsInteractor.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 11.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MICommentsInteractor.h"
#import "MICommentsDataProvider.h"

@implementation MICommentsInteractor

#pragma mark - MICommentsInteractorInputInterface

- (void)getCommentsForPost:(MIInstagramPost *)post
         lastViewedComment:(MIInstagramComment *)lastViewedComment
{
    [MICommentsDataProvider getCommentsByPostId:post.identifier
                            lastViewedCommentId:lastViewedComment.identifier
                                   successBlock:^(NSArray *data)
    {
        [_presenter showComments:data
                            post:post];
    }
                                   failureBlock:^(NSString *error){}];
}

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

@end
