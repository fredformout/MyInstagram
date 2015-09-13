//
//  MITransitionPhotoDetailsViewControllerInterface.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 11.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MIPhotoDetailsPhotoTableViewCell.h"

@protocol MITransitionPhotoDetailsViewControllerInterface <NSObject>

- (MIPhotoDetailsPhotoTableViewCell *)tableViewCell;

@end
