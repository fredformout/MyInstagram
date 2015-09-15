//
//  MICommentsInteractor.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 11.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MICommentsInteractor.h"
#import "MIDataProvider+Comments.h"
#import "MIDataProvider+User.h"
#import "MIInstagramUser.h"

@interface MICommentsInteractor ()

@property (nonatomic, copy) NSString *maxId;

@end

@implementation MICommentsInteractor

#pragma mark - MICommentsInteractorInputInterface

- (void)getCommentsForPost:(MIInstagramPost *)post
{
    __weak typeof(self) weakSelf = self;
    
    [self.dataProvider getCommentsByPostId:post.identifier
                                     maxId:_maxId
                              successBlock:^(NSArray *comments, NSString *maxId)
    {
        __strong typeof(self) strongSelf = weakSelf;
        
        if (maxId)
        {
            strongSelf.maxId = maxId;
        }
        
        [strongSelf.presenter showComments:comments
                                      post:post
                                  lastPart:!maxId];
    }
                              failureBlock:^(NSString *error){}];
}

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

@end
