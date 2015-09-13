//
//  MIPhotoDetailsRouter.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 08.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIBaseRouter.h"
#import "MICommentsRouter.h"

@interface MIPhotoDetailsRouter : MIBaseRouter <UINavigationControllerDelegate>

@property (nonatomic, strong) MICommentsRouter *commentsRouter;

- (void)setTransitioningDelegate;
- (void)unsetTransitioningDelegate;

- (void)presentViewControllerFromViewController:(UIViewController *)fromVC;
- (void)presentComments;

@end
