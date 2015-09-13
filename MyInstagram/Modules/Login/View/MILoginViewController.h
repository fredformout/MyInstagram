//
//  MILoginViewController.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MILoginViewControllerInterface.h"
#import "MILoginPresenterInterface.h"

@interface MILoginViewController : UIViewController <MILoginViewControllerInterface>

@property (nonatomic, weak) id<MILoginPresenterInterface> presenter;

@end
