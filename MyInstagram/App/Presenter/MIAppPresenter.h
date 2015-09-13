//
//  MIAppPresenter.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MIBasePresenter.h"

@interface MIAppPresenter : MIBasePresenter

@property (nonatomic, strong) NSArray *innerPresenters;

- (void)showAppViewControllerFromWindow:(UIWindow *)window;
- (void)returnAppInitialState;

@end
