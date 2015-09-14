//
//  MIPhotoDetailsPresenterInterface.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 09.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MIInstagramPost.h"
#import "MIPhotosPresenterInterface.h"

@protocol MIPhotoDetailsPresenterInterface <NSObject>

- (void)openPost:(MIInstagramPost *)post
       presenter:(id<MIPhotosPresenterInterface>)presenter;

- (void)updateView;
- (void)reloadView;
- (void)openComments;

- (void)toggleLikedByMe;

- (void)setTransitioningDelegate;
- (void)unsetTransitioningDelegate;

@end
