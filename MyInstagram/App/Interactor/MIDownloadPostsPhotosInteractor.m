//
//  MIDownloadPostsPhotosInteractor.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 13.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIDownloadPostsPhotosInteractor.h"
#import "MIDataProvider+Images.h"
#import "MIInstagramPost.h"

@implementation MIDownloadPostsPhotosInteractor

- (void)downloadPhotosForPosts:(NSArray *)posts
{
    for (MIInstagramPost *post in posts)
    {
        [self.dataProvider downloadPhotoByURLString:post.lowResolutionPhotoURL
                                           filename:[NSString stringWithFormat:@"%@_%@", kLowResolutionPhotoPattern, post.identifier]];
    }
    
    for (MIInstagramPost *post in posts)
    {
        [self.dataProvider downloadPhotoByURLString:post.standardResolutionPhotoURL
                                           filename:[NSString stringWithFormat:@"%@_%@", kStandardResolutionPhotoPattern, post.identifier]];
    }
        
    for (MIInstagramPost *post in posts)
    {
        [self.dataProvider downloadPhotoByURLString:post.caption.userPhotoURL
                                           filename:[NSString stringWithFormat:@"%@_%@", kUserPhotoPattern, post.caption.identifier]];
        
        [self downloadPhotosForComments:post.comments];
    }
}

@end
