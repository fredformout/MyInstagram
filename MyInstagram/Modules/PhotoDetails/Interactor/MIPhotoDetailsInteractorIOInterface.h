//
//  MIPhotoDetailsInteractorIOInterface.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 12.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MIInstagramPost.h"

@protocol MIPhotoDetailsInteractorInputInterface <NSObject>

- (void)getPostByPost:(MIInstagramPost *)post;
- (void)likePost:(MIInstagramPost *)post;
- (void)unlikePost:(MIInstagramPost *)post;

@end

@protocol MIPhotoDetailsInteractorOutputInterface <NSObject>

- (void)showPost:(MIInstagramPost *)post;
- (void)failGetPost;
- (void)finishLikePostWithSuccess:(BOOL)success
                             post:(MIInstagramPost *)post;
- (void)finishUnlikePostWithSuccess:(BOOL)success
                               post:(MIInstagramPost *)post;

@end
