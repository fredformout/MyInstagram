//
//  MIPopularPhotosViewController.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIPhotosViewControllerInterface.h"
#import "MIPhotosInterface.h"

@interface MIPhotosViewController : UIViewController <MIPhotosViewControllerInterface>

@property (nonatomic, strong) id<MIPhotosInterface> actionsHandler;

@end
