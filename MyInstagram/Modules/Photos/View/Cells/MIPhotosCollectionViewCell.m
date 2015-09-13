//
//  MIPopularPhotosCollectionViewCell.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIPhotosCollectionViewCell.h"
#import "UIImageView+DownloadImage.h"

@interface MIPhotosCollectionViewCell ()

@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation MIPhotosCollectionViewCell

#pragma mark - Others

- (void)configureCellWithPost:(MIInstagramPost *)post
{
    self.post = post;
    
    [_photoImageView loadImageFromURL:[NSURL URLWithString:post.standardResolutionPhotoURL]
                           cachingKey:post.identifier];
}

@end
