//
//  MIBasePresenter.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MIBaseRouter;

@interface MIBasePresenter : NSObject

@property (nonatomic, strong) MIBaseRouter *router;
@property (nonatomic, weak) UIViewController *viewController;

- (void)returnViewControllerToInitialState;
- (void)performFirstActions;

@end
