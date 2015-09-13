//
//  AppRouter.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MIBaseRouter.h"
#import "MILoginRouter.h"

@interface MIAppRouter : MIBaseRouter

@property (nonatomic, weak) MILoginRouter *loginRouter;
@property (nonatomic, strong) NSArray *innerRouters;

- (void)presentAppViewControllerFromWindow:(UIWindow *)window;
- (void)presentLoginViewController;

@end
