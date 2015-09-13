//
//  MIPopularPhotosCollectionViewCell.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIInstagramPost.h"

@interface MIPhotosCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) MIInstagramPost *post;
@property (nonatomic, weak) IBOutlet UIImageView *photoImageView;

- (void)configureCellWithPost:(MIInstagramPost *)post;

@end
