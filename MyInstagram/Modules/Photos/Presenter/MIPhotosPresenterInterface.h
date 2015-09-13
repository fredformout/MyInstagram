//
//  MIPhotosPresenterInterface.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 08.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MIInstagramPost.h"

@protocol MIPhotosPresenterInterface <NSObject>

- (void)openPost:(MIInstagramPost *)post;

- (void)initView;
- (void)updateView;
- (void)reloadView;

@end
