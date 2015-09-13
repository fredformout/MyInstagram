//
//  MIAddCommentInteractorIOInterface.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 12.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MIInstagramPost.h"

@protocol MIAddCommentInteractorInputInterface <NSObject>

- (MIInstagramComment *)newCommentWithText:(NSString *)text
                                      post:(MIInstagramPost *)post;
- (void)addComment:(MIInstagramComment *)comment
              post:(MIInstagramPost *)post;

@end

@protocol MIAddCommentInteractorOutputInterface <NSObject>

- (void)finishAddComment:(MIInstagramComment *)comment
                    post:(MIInstagramPost *)post
                 success:(BOOL)success;

@end
