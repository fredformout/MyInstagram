//
//  MIAddCommentViewControllerInterface.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 14.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MIAddCommentViewControllerInterface <NSObject>

- (void)undoCommentWithText:(NSString *)text;

@end
