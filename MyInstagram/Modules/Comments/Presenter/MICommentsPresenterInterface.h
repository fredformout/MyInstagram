//
//  MICommentsPresenterInterface.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 11.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MIInstagramPost.h"

@protocol MICommentsPresenterInterface <NSObject>

- (void)openCommentsForPost:(MIInstagramPost *)post;

- (void)updateView;

@end
