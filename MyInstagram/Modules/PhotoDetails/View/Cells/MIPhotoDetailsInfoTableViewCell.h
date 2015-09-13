//
//  MIPhotoDetailsInfoTableViewCell.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 09.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIInstagramPost.h"

@interface MIPhotoDetailsInfoTableViewCell : UITableViewCell

- (void)configureWithPost:(MIInstagramPost *)post
    likeButtonActionBlock:(dispatch_block_t)likeButtonActionBlock;

@end
