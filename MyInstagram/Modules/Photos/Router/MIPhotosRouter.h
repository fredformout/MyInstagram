//
//  MIPopularPhotosRouter.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MISlaveByTabBarControllerRouter.h"
#import "MIPhotoDetailsRouter.h"

@interface MIPhotosRouter : MISlaveByTabBarControllerRouter

@property (nonatomic, strong) MIPhotoDetailsRouter *photoDetailsRouter;

- (void)presentPhotoDetails;

@end
