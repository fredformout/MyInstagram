//
//  MICommentsViewController.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 08.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIWithAddCommentPanelViewController.h"
#import "MICommentsViewControllerInterface.h"
#import "MICommentsTableViewController.h"
#import "MICommentsPresenterInterface.h"
#import "MIAddCommentPresenterInterface.h"
#import "MIAddCommentViewControllerInterface.h"
#import "MIInstagramPost.h"

@interface MICommentsViewController : MIWithAddCommentPanelViewController <MICommentsViewControllerInterface, MIAddCommentViewControllerInterface>

@property (nonatomic, strong) MICommentsTableViewController *tableViewController;

@property (nonatomic, weak) id<MICommentsPresenterInterface, MIAddCommentPresenterInterface> presenter;

@end
