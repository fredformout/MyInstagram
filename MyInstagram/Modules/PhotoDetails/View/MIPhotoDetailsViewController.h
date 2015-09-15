//
//  MIPhotoDetailsViewController.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 12.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIWithAddCommentPanelViewController.h"
#import "MIPhotoDetailsPresenterInterface.h"
#import "MIPhotoDetailsViewControllerInterface.h"
#import "MITransitionPhotoDetailsViewControllerInterface.h"
#import "MIPhotoDetailsTableViewController.h"
#import "MIAddCommentPresenterInterface.h"
#import "MIAddCommentViewControllerInterface.h"
#import "MIInstagramPost.h"

@interface MIPhotoDetailsViewController : MIWithAddCommentPanelViewController <MIPhotoDetailsViewControllerInterface, MITransitionPhotoDetailsViewControllerInterface, MIAddCommentViewControllerInterface>

@property (nonatomic, strong) MIPhotoDetailsTableViewController *tableViewController;

@property (nonatomic, weak) id<MIPhotoDetailsPresenterInterface, MIAddCommentPresenterInterface> presenter;

@end
