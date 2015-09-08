//
//  MILoginViewController.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MILoginInterface.h"

@interface MILoginViewController : UIViewController

@property (nonatomic, strong) id<MILoginInterface> actionsHandler;

@end
