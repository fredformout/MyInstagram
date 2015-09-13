//
//  MIPhotoDetailsViewController.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 08.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIInstagramPost.h"

@class MIPhotoDetailsViewController;

@interface MIPhotoDetailsTableViewController : UITableViewController

@property (nonatomic, weak) MIPhotoDetailsViewController *viewController;
@property (nonatomic, weak) MIInstagramPost *post;

- (void)reload;

@end
