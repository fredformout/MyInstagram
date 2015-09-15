//
//  MICommentsTableViewController.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 11.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIInstagramPost.h"

@class MICommentsViewController;

@interface MICommentsTableViewController : UITableViewController

@property (nonatomic, weak) MICommentsViewController *viewController;
@property (nonatomic, weak) MIInstagramPost *post;
@property (nonatomic, weak) NSArray *comments;

- (void)scrollToBottom;
- (void)reload;
- (void)insertElementsToTopCount:(NSInteger)count
                  deleteMoreCell:(BOOL)deleteMoreCell;

@end
