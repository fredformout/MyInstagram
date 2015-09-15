//
//  MICommentsViewControllerInterface.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 11.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MIInstagramPost.h"

@protocol MICommentsViewControllerInterface <NSObject>

- (void)insertElementsToTopCount:(NSInteger)count
                  deleteMoreCell:(BOOL)deleteMoreCell;
- (void)showComments:(NSArray *)comments
                post:(MIInstagramPost *)post;
- (void)reload;

@end
