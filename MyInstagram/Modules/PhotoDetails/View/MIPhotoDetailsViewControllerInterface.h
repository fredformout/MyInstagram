//
//  MIPhotoDetailsViewControllerInterface.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 09.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MIInstagramPost.h"

@protocol MIPhotoDetailsViewControllerInterface <NSObject>

- (void)showPost:(MIInstagramPost *)post;
- (void)reload;
- (void)undoCommentWithText:(NSString *)text;

@end
