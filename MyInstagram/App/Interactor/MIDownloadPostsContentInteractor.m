//
//  MIDownloadPostsContentInteractor.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 15.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIDownloadPostsContentInteractor.h"
#import "MIInstagramPost.h"
#import "MIImageCacheUtility.h"

@implementation MIDownloadPostsContentInteractor

- (void)downloadContentForPosts:(NSArray *)posts
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
        for (MIInstagramPost *post in posts)
        {
            [[MIImageCacheUtility sharedInstance] addDownloadContentOperationWithURLString:post.lowResolutionPhotoURL
                                                                                  priority:DownloadContentOperationPriorityHigh];
            [[MIImageCacheUtility sharedInstance] addDownloadContentOperationWithURLString:post.standardResolutionPhotoURL
                                                                                  priority:DownloadContentOperationPriorityHigh];
           [[MIImageCacheUtility sharedInstance] addDownloadContentOperationWithURLString:post.caption.userPhotoURL
                                                                                 priority:DownloadContentOperationPriorityLow];
           
            [self downloadContentForComments:post.comments];
        }
    });
}

@end
