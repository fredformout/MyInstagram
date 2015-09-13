//
//  MIPhotoDetailsPhotoTableViewCell.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 09.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIInstagramPost.h"

@interface MIPhotoDetailsPhotoTableViewCell : UITableViewCell

@property (nonatomic, strong) MIInstagramPost *post;

@property (nonatomic, weak) IBOutlet UIImageView *photoImageView;

- (void)configureWithPost:(MIInstagramPost *)post;

@end
