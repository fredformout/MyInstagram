//
//  MiProfileViewController.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 08.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIProfileInterface.h"

@interface MIProfileViewController : UIViewController

@property (nonatomic, strong) id<MIProfileInterface> actionsHandler;

@end
