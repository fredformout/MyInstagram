//
//  MIPhotoDetailsPhotoTableViewCell.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 09.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIPhotoDetailsPhotoTableViewCell.h"
#import "UIImageView+DownloadImage.h"
#import "MIImageUtility.h"

@implementation MIPhotoDetailsPhotoTableViewCell

#pragma mark - Others

- (void)configureWithPost:(MIInstagramPost *)post
{
    self.post = post;
    
    [_photoImageView loadImageFromURL:[NSURL URLWithString:post.standardResolutionPhotoURL]
                           cachingKey:post.identifier];
}

@end
