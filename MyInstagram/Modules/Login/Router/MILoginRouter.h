//
//  MILoginRouter.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MIBaseRouter.h"

@interface MILoginRouter : MIBaseRouter

- (void)presentLoginInterfaceFromViewController:(UIViewController *)viewController;
- (void)dismissLoginInterface;

@end
