//
//  MICommentsInteractorIOInterface.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 11.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MIInstagramPost.h"

@protocol MICommentsInteractorInputInterface <NSObject>

- (void)getCommentsForPost:(MIInstagramPost *)post
         lastViewedComment:(MIInstagramComment *)lastViewedComment;

@end

@protocol MICommentsInteractorOutputInterface <NSObject>

- (void)showComments:(NSArray *)comments
                post:(MIInstagramPost *)post;

@end