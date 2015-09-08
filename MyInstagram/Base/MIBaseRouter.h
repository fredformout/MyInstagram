//
//  MIBaseRouter.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MIBasePresenter;

@interface MIBaseRouter : NSObject

@property (nonatomic, weak) MIBasePresenter *presenter;
@property (nonatomic, copy) NSString *viewControllerIdentifier;

- (instancetype)initWithViewControllerIdentifier:(NSString *)viewControllerIdentifier;
- (UIViewController *)viewController;

@end
