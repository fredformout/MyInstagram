//
//  MIPopularPhotosViewController.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIPhotosViewControllerInterface.h"
#import "MIPhotosPresenterInterface.h"
#import "MITransitionPhotosViewControllerInterface.h"

@interface MIPhotosCollectionViewController : UICollectionViewController <MIPhotosViewControllerInterface, MITransitionPhotosViewControllerInterface>

@property (nonatomic, weak) id<MIPhotosPresenterInterface> presenter;

@end
