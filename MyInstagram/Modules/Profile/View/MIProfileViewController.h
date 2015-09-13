//
//  MiProfileViewController.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 08.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIProfilePresenterInterface.h"
#import "MIProfileViewControllerInterface.h"

@interface MIProfileViewController : UIViewController <MIProfileViewControllerInterface>

@property (nonatomic, weak) id<MIProfilePresenterInterface> presenter;

@end
